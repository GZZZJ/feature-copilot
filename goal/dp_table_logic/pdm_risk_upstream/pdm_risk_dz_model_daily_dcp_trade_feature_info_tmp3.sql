-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3
-- node_id: n_4437451324234268672
-- task_name: pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3.json
-- source_json_sha256: 2ac3bc194279f05b1408831a8240a19b96dd6badaf9338fbbb3e9b8078d0d5fe
-- upstream_table: cdmx.cdmx_dim_credit_account_df
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1
-- upstream_table: ods_pdw_loan.ods_pdw_loan_dstradeali_debitaccountengine_trans_journal_df
-- upstream_table: pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 日更dcp客群，基于dcp交易行为挖掘的变量
--创建者: 陈枭2648
--创建日期: 2023-02-01 11:30:43
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- 日更的dcp客群样本表
drop table if EXISTS pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1;
create table pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1 as
select  t1.uid
        ,fst_dcp_tme --dcp初始授信时间
        ,case   when t2.uid is null then 0
                else 1
        end as cash_flg --是否有bt或cash的账户
        ,t3.min_dcp_jy_tim --dcp首次交易时间
        ,t1.ds
        ,to_char(date_add(to_date(t1.ds ,'yyyymmdd') ,1) ,'yyyy-mm-dd') as mdl_dte --模型评分日
from    (
            select  uid
                    ,account_open_time as fst_dcp_tme --dcp初始授信时间
                    ,ds
            from    cdmx.cdmx_dim_credit_account_df
            where   ds = '${bizdate}' 
            and     credit_account_biz_type = 'ENJOY_PAY'
            and     latest_risk_credit_limit > 0 --dcp当前授信额度>0
        
) t1
left join  (
              select  uid
                      ,ds
              from    cdmx.cdmx_dim_credit_account_df
              where   ds = '${bizdate}' 
              and     credit_account_biz_type in ('BALANCE_TRANSFER' ,'CASH')
              group by  uid
                        ,ds
            
) t2
on      t1.uid = t2.uid
and     t1.ds = t2.ds --dcp首次交易时间
left join  (
              select  a.uid, a.ds
                      ,min(apply_record_crt_time) as min_dcp_jy_tim
              from    (
                          select  uid
                                  ,ds
                          from    cdmx.cdmx_dim_credit_account_df
                          where   ds = '${bizdate}' 
                          and     credit_account_biz_type = 'ENJOY_PAY'
                          and     latest_risk_credit_limit > 0 --dcp当前授信额度>0
                          group by  uid
                                    ,ds
                      
) a
              left join  (
                            select  uid
                                    ,apply_record_crt_time --交易时间
                                    ,ds
                            from    dwt.dwt_heavy_order_df -- dbank.loan_f_order_info
                            where   ds = '${bizdate}' 
                            and     business_type in ('ENJOY_PAY')
                            and     loan_success_flag = '1'
                          
) b
              on      a.uid = b.uid
              and     a.ds = b.ds
              group by  a.uid, a.ds
            
) t3
on      t1.uid = t3.uid and t1.ds = t3.ds;

        
-- 与底层dcp事件表拼接，获取日切dcp客群T-1日至前一个月内的dcp流水事件
drop table if EXISTS pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp2;
create table pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp2 as 
select model_data.*
    ,datediff(model_data.mdl_dte,to_date(dcprod.dcp_crt_tim)) as dcp_ddf_mdl_crt_dte
    ,dcprod.dcp_ord_no
    ,dcprod.dcp_crt_tim
    ,to_char(dcprod.dcp_crt_tim, 'yyyy-mm-dd') as dcp_crt_dte
    ,pmod(datediff(to_date(to_char(dcprod.dcp_crt_tim, 'yyyy-mm-dd')), to_date('1920-01-01')) - 3, 7) as dcp_crt_week_num -- 0-6的数，分别表示 日，一，二 ... 六
    ,dcprod.trs_no
    ,dcprod.amt
    ,dcprod.trs_stt
    ,dcprod.stt_des
    ,dcprod.gds_nam
    ,dcprod.mct_nam
    ,dcprod.chl_typ
from pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1 model_data
inner join 
    (select uid, 
        created_at as dcp_crt_tim, 
        trans_no as trs_no, 
        trans_type as trs_typ, 
        trans_status as trs_stt, 
        status_desc as stt_des, 
        order_no as dcp_ord_no, 
        trade_amount as amt, 
        merchant_name as mct_nam, 
        goods_name as gds_nam, 
        channel_type as chl_typ
    from ods_pdw_loan.ods_pdw_loan_dstradeali_debitaccountengine_trans_journal_df
    where ds = '${bizdate}' 
        and date(created_at) between date_add(to_date('${bizdate}','yyyymmdd'),-180) and to_date('${bizdate}','yyyymmdd')
    
) dcprod 
on model_data.uid=dcprod.uid and date(dcp_crt_tim) < to_date(mdl_dte,'yyyy-mm-dd')
;


-- 字段分箱，为后续变量衍生做准备
drop table if EXISTS pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3;
CREATE TABLE pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3
AS
SELECT *, amt AS prc_amt
	, CASE 
		WHEN trs_stt = 'SUCCESS' THEN 'success'
		ELSE 'fail'
	END AS ord_stt_cln
	, CASE 
		WHEN dcp_crt_week_num IN (1, 2, 3, 4, 5) THEN 'workday'
		WHEN dcp_crt_week_num IN (0, 6) THEN 'weekend'
		ELSE 'other'
	END AS week_flg
	, CASE 
		WHEN hour(dcp_crt_tim) BETWEEN 0 AND 6 THEN 'hor_00_06'
		WHEN hour(dcp_crt_tim) BETWEEN 7 AND 12 THEN 'hor_07_12'
		WHEN hour(dcp_crt_tim) BETWEEN 13 AND 18 THEN 'hor_13_18'
		WHEN hour(dcp_crt_tim) BETWEEN 19 AND 23 THEN 'hor_19_23'
		ELSE 'other'
	END AS hor_flg
	, CASE 
		WHEN mct_nam LIKE '%保险%' THEN 'insurance'
		WHEN mct_nam LIKE '%Apple%'
			OR mct_nam LIKE '%云上贵州%'
		THEN 'apple'
		WHEN mct_nam LIKE '%上海拉扎斯%'
			OR mct_nam LIKE '%美团%'
			OR mct_nam LIKE '%饿了么%'
		THEN 'takeout'
		WHEN mct_nam LIKE '%拼多多%'
			OR mct_nam LIKE '%上海寻梦%'
		THEN 'pdd'
		WHEN gds_nam LIKE '%先用后付%' THEN 'pdd_ahead'
		WHEN mct_nam LIKE '%打车%'
			OR mct_nam LIKE '%上海钧正%'
			OR mct_nam LIKE '%出行%'
			OR mct_nam LIKE '%滴滴%'
			OR mct_nam LIKE '%叫车%'
			OR mct_nam LIKE '%公共交通%'
			OR mct_nam LIKE '%上海都畅数字技术%'
			OR mct_nam LIKE '%航空%'
			OR mct_nam LIKE '%E行%'
			OR mct_nam LIKE '%单车%'
			OR mct_nam LIKE '%广州骑安%'
			OR gds_nam LIKE '%单车%'
			OR gds_nam LIKE '%打车%'
			OR mct_nam LIKE '%摩拜%'
			OR mct_nam LIKE '%花小猪%'
			OR gds_nam LIKE '%骑行%'
		THEN 'going'
		WHEN mct_nam LIKE '%电信%'
			OR mct_nam LIKE '%移动%'
			OR mct_nam LIKE '%联通%'
			OR mct_nam LIKE '%手机充值%'
			OR gds_nam LIKE '%话费%'
		THEN 'operator'
		WHEN mct_nam LIKE '%优酷%'
			OR mct_nam LIKE '%爱奇艺%'
			OR mct_nam LIKE '%芒果%'
			OR mct_nam LIKE '%腾讯%'
			OR mct_nam LIKE '%影音%'
			OR mct_nam LIKE '%TV%'
			OR mct_nam LIKE '%播放%'
			OR mct_nam LIKE '%聚力传媒%'
		THEN 'video'
		WHEN mct_nam LIKE '%微信面对面收款%'
			OR mct_nam LIKE '%微信转账%'
			OR mct_nam LIKE '%微信红包%'
			OR mct_nam LIKE '%微信零钱充值账户%'
			OR mct_nam LIKE '%零钱通%'
		THEN 'wechat'
		WHEN mct_nam LIKE '%微信面对面收款%' THEN 'wechat_facetoface'
		WHEN mct_nam LIKE '%微信转账%' THEN 'wechat_transfer'
		WHEN mct_nam LIKE '%微信红包%' THEN 'wechat_redpacket'
		WHEN mct_nam LIKE '%微信零钱充值账户%'
			OR mct_nam LIKE '%零钱通%'
		THEN 'wechat_change'
		WHEN mct_nam LIKE '%上海数禾%'
			OR mct_nam LIKE '%还呗%'
		THEN 'repay_in'
		WHEN (gds_nam LIKE '%还款%'
				AND mct_nam NOT LIKE '%还呗%'
				AND mct_nam NOT LIKE '%上海数禾%')
			OR (mct_nam LIKE '%分期乐%'
				OR mct_nam LIKE '%360借条%')
		THEN 'repay_ex'
		WHEN mct_nam LIKE '%基金%' THEN 'fund'
		WHEN mct_nam LIKE '%充电%'
			OR gds_nam LIKE '%充电%'
			OR mct_nam LIKE '%街电%'
		THEN 'charge'
		WHEN mct_nam LIKE '%医院%'
			OR mct_nam LIKE '%健康%'
			OR mct_nam LIKE '%医保%'
			OR mct_nam LIKE '%药房%'
		THEN 'health'
		WHEN mct_nam LIKE '%淘宝%'
			OR mct_nam LIKE '%京东%'
			OR mct_nam LIKE '%天猫%'
			OR mct_nam LIKE '%JD%'
		THEN 'onlineshopping'
		WHEN mct_nam LIKE '%书%'
			OR mct_nam LIKE '%阅读%'
			OR mct_nam LIKE '%喜马拉雅%'
			OR mct_nam LIKE '%小说%'
			OR mct_nam LIKE '%文学%'
		THEN 'reading'
		WHEN mct_nam LIKE '%游戏%'
			OR mct_nam LIKE '%GAME%'
		THEN 'game'
		WHEN mct_nam LIKE '%特约商户%' THEN 'special_merchant'
		WHEN mct_nam LIKE '%超市%'
			OR mct_nam LIKE '%便利%'
			OR mct_nam LIKE '%LAWSON%'
			OR mct_nam LIKE '%世纪华联%'
			OR mct_nam LIKE '%盒马%'
		THEN 'market'
		ELSE 'other'
	END AS bsy_typ_cln
	, CASE 
		WHEN chl_typ = 'WECHAT' THEN 'wechat'
		WHEN chl_typ = 'ALIPAY' THEN 'alipay'
		ELSE 'other'
	END AS chl_typ_flg
	, CASE 
		WHEN CAST(amt AS INT) = amt THEN 'int'
		ELSE 'float'
	END AS amt_int_flg
	, CASE 
		WHEN amt < 10 THEN 'below10'
		WHEN amt > 500 THEN 'over500'
		ELSE 'other'
	END AS amt_flg
FROM pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp2;
-- feature-copilot:node-end ordinal=0
