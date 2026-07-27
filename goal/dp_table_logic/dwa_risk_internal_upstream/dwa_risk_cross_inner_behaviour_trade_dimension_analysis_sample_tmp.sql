-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp
-- node_id: n_6010041676839124992
-- task_name: dwa_risk_dz_model_final_25_cross_inner_behaviour_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp.json
-- source_json_sha256: de954426241d97ace31af3dee82f89eb770d621cafb09e4a912739736586276e
-- upstream_table: dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline
-- upstream_table: dwa_risk.dwa_risk_trade_cross_debate_behaviour_agregate_by_each_atomtable_oline
-- upstream_table: dwa_risk.dwa_risk_inner_behaviour_all_trade_by_ord_aggregate_tmp_oline
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_cross_inner_behaviour_credit_limit_dimension_analysis_sample_oline
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_due_date_credit_limit_di
-- upstream_table: dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline
-- upstream_table: dwa_risk.dwa_risk_inner_behaviour_all_repay_by_stg_aggregate_tmp_oline
-- upstream_table: dwa_risk.dwa_risk_inner_behaviour_all_trade_by_month_aggregate_tmp_oline
-- upstream_table: dwa_risk.dwa_risk_f_customer_credit_limit_basic_df
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_crt_date_credit_limit_upaid_principal_di
-- upstream_table: dwa_risk.dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_oline
-- upstream_table: dwa_risk.dwa_risk_repay_cross_trade_behaviour_agregate_by_mon_atomtable_oline
-- upstream_table: dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df
-- upstream_table: dwa_risk.dwa_risk_cross_inner_behaviour_debate_dimension_analysis_sample_oline
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_4_repay_cross_credit_limit_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_2_repay_cross_trade_behaviour_by_mon_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_9_trade_cross_credit_limit_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_8_trade_cross_credit_limit_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_1_repay_behaviour_inner_cross_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_5_repay_cross_credit_limit_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_10_trade_cross_credit_limit_behaviour_by_mon_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_11_trade_cross_debate_behaviour_agregate_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_6_repay_cross_credit_limit_behaviour_by_mon_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_3_repay_cross_trade_behaviour_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_12_trade_cross_debate_behaviour_agregate_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_13_credit_limit_cross_debate_behaviour_agregate_by_each_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_25_7_trade_behaviour_inner_cross_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 陈枭2648
--创建日期: 2024-06-12 19:00:04
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- 上线样本表（日更离线批量调度）
-- select  uid
--         ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
-- from    dwa_risk.dwa_risk_f_dz_model_data_base

-- 原子表0:用户评分日T-1日的额度使用情况，BT&CH额度信息，字段：评分日T-1授信额度、评分日T-1可用额度，对uid+mdl_dte做聚合
drop table if exists dwa_risk.dwa_risk_cross_inner_behaviour_credit_limit_dimension_analysis_sample_oline;
create table if not exists dwa_risk.dwa_risk_cross_inner_behaviour_credit_limit_dimension_analysis_sample_oline as
select  uid
       ,mdl_dte
       ,rsk_adt_lmt_cash
       ,rsk_avl_lmt_cash
from  dwa_risk.dwa_risk_f_customer_credit_limit_basic_df where ds = '${bizdate}';

-- 原子表1:用户还款维度，样本表评分日前所有BT&CH分期（包含：正常按时还、逾期未还、逾期已还、未到期未还、未到期提前还），字段：分期的还款状态：提前、逾期、按时、尚未到期，本金，第几期
-- 原子表1 没有对uid+mdl_dte进行聚合，一个分期计划为一条记录
drop table if exists dwa_risk.dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_oline;
create table if not exists dwa_risk.dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_oline as
select  
         main2.uid
        ,main2.mdl_dte
        ,main2.dtl_ord_no -- 还款记录表所在订单号
        ,main2.dtl_stg_pln_no -- 还款记录表的分期号码
        ,main2.dtl_rep_dte -- 应还款日
        ,main2.rep_tim -- 实际还款日
        ,main2.prc_amt -- 应还本金
        ,main2.stg_no -- 期号

        --应还日和实还日之间的间隔（天）：用于判断逾期、提前、按时还款
        ,main2.ddf_rep_tim_dte 
        --实还日和评分日的间隔（天）：用于限定实还行为变量的窗口期
        ,main2.ddf_mdl_rep_tim
        --应还日和评分日的间隔（天）：用于限定应还行为变量的窗口期
        ,main2.ddf_mdl_rep_dte 
        --历史应还款日T日对应的授信额度
        ,main2.rsk_adt_lmt_cash_his_t_day
        --历史应还款日T日对应的可用额度
        ,main2.rsk_avl_lmt_cash_his_t_day

        --还款状态--flag
        --是否提前还款flag
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte<0 then '提前还款' -- 这样写的好处是即使评分日后的应还分期，如果在评分日前提前还了，也能计入
         when ddf_rep_tim_dte>0 then '逾期还款'
         when ddf_mdl_rep_dte>0 and ddf_rep_tim_dte=0 then '按时还款'
         when ddf_mdl_rep_dte<=0 then '未来应还（评分日T日及往后）'
         else '其他分期状态'
         end repay_status_main -- 还款状态主字段

        --逾期天数flag，后面作为限制条件。只用：1～3、4～14、15+、30+、60+、90+
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 1 and 3 then 1 else 0 end as ovd_1d_3d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 4 and 14 then 1 else 0 end as ovd_4d_14d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=15 then 1 else 0 end as ovd_15d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=30 then 1 else 0 end as ovd_1m_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=60 then 1 else 0 end as ovd_2m_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=90 then 1 else 0 end as ovd_3m_pls_flg

        --提前天数flag，后面作为限制条件。只用：<=3、<=15、<=30、<=60、<=90
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -3 and -1 then 1 else 0 end as adv_3d_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -15 and -1 then 1 else 0 end as adv_15d_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -30 and -1 then 1 else 0 end as adv_1m_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -60 and -1 then 1 else 0 end as adv_2m_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -90 and -1 then 1 else 0 end as adv_3m_minus_flg

        --应还本金是否大于还款日T日授信额度，如果是未来应还分期这里是null
        ,case when main2.prc_amt > rsk_adt_lmt_cash_his_t_day then 1 when main2.prc_amt <= rsk_adt_lmt_cash_his_t_day then 0 else null end as if_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day
        --应还本金是否大于还款日T日可用额度，如果是未来应还分期这里是null
        ,case when main2.prc_amt > rsk_avl_lmt_cash_his_t_day then 1 when main2.prc_amt <= rsk_avl_lmt_cash_his_t_day then 0 else null end as if_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day
        --应还本金是否大于评分日T-1日授信额度，一般用于未来应还分期
        ,case when main2.prc_amt > b.rsk_adt_lmt_cash then 1 when main2.prc_amt <= b.rsk_adt_lmt_cash then 0 else null end as if_due_repay_amt_larger_than_mdldte_risk_admit_limit
        --应还本金是否大于评分日T-1日可用额度，一般用于未来应还分期
        ,case when main2.prc_amt > b.rsk_avl_lmt_cash then 1 when main2.prc_amt <= b.rsk_avl_lmt_cash then 0 else null end as if_due_repay_amt_larger_than_mdldte_risk_available_limit
        --评分日T-1日授信额度
        ,b.rsk_adt_lmt_cash
        --评分日T-1日可用额度
        ,b.rsk_avl_lmt_cash
from
        (select 
                main1.uid
                ,main1.mdl_dte
                ,main1.dtl_ord_no
                ,main1.dtl_stg_pln_no
                ,main1.dtl_rep_dte
                ,main1.rep_tim
                ,main1.prc_amt
                ,main1.stg_stt
                ,main1.stg_no
                ,credit_limit.rsk_adt_lmt_cash_his_t_day
                ,credit_limit.rsk_avl_lmt_cash_his_t_day

                --应还日和实还日之间的间隔（天），for判断逾期、提前、按时还款
                ,case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte)
                        else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte
                --实还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim
                --应还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte 
        from
                (select model_data.uid
                        ,model_data.mdl_dte
                        ,plan.dtl_ord_no
                        ,plan.dtl_stg_pln_no
                        ,plan.dtl_rep_dte
                        ,case when date(plan.rep_tim)>=model_data.mdl_dte then null else date(plan.rep_tim) end as rep_tim
                        ,plan.prc_amt
                        ,plan.stg_stt
                        ,plan.stg_no
                from    (
                        select  uid
                               ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                        from    dwa_risk.dwa_risk_f_dz_model_data_base
                        ) model_data

                        left join
                        (select uid
                                ,ord_no as dtl_ord_no -- 分期所在订单编号
                                ,stg_pln_no as dtl_stg_pln_no -- 分期计划编号
                                ,rep_dte as dtl_rep_dte -- 分期应还款日
                                ,rep_tim -- 分期结清时间
                                ,prc_amt -- 分期应还本金
                                ,stg_stt
                                ,stg_no -- 分期所在期数
                        from dwa_risk.dwa_risk_f_heavy_stage_plan_basic
                        where bsy_typ in ('BALANCE_TRANSFER', 'CASH')
                        and stg_stt <> 'R' --分期计划状态，放款成功取<>'R'
                        ) plan on model_data.uid=plan.uid
                ) main1
            left join (
                -- 增量表，每个分区代表应还日是该分区时间的所有分期T日额度信息
                select  uid
                        ,dtl_ord_no
                        ,dtl_stg_pln_no
                        ,rsk_adt_lmt_cash_his_t_day
                        ,rsk_avl_lmt_cash_his_t_day
                from    dwa_risk.dwa_risk_f_heavy_stage_plan_due_date_credit_limit_di
                where   ds between to_char(date_add(to_date('${bizdate}' , 'yyyymmdd') , -1500),'yyyymmdd') and '${bizdate}'
            ) as credit_limit
            on      main1.uid = credit_limit.uid
            and     main1.dtl_stg_pln_no = credit_limit.dtl_stg_pln_no  -- 分期应还日T日额度，这里有一批评分日往后未来还款的分期匹配不到额度信息
        )main2
left join dwa_risk.dwa_risk_cross_inner_behaviour_credit_limit_dimension_analysis_sample_oline b -- 评分日T-1日的额度信息
on main2.uid = b.uid and main2.mdl_dte = b.mdl_dte
;
-- 原子表1.1 用户提前还款、逾期还款、按时还款分月聚合：要求若这个月份没有对应的行为，则聚合结果为空
drop table if exists dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline;
create table if not exists dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline as
select mid.*, 
-- 评分日与月份初之间的日期差
DATEDIFF(mdl_dte,to_date(concat(same_month_flg,'-01'),'yyyy-mm-dd')) as ddf_mdl_dte_rep_mon,
-- 是否提前还款与逾期还款同时发生在该月
case when adv_count_mon > 0 and ovd_count_mon > 0 then 1 when adv_count_mon = 0 or ovd_count_mon = 0 then 0 else null end as if_ovdrepay_advrepay_in_same_month, 
-- 是否该月逾期还款的本金比提前还款要多
case when ovd_amt_sum_mon > adv_amt_sum_mon then 1 when ovd_amt_sum_mon <= adv_amt_sum_mon then 0 else null end as if_ovdrepay_large_than_advrepay_amt_in_this_month,
-- 是否逾期还款与按时还款同时发生在该月
case when ontim_count_mon > 0 and ovd_count_mon > 0 then 1 when ontim_count_mon = 0 or ovd_count_mon = 0 then 0 else null end as if_ovdrepay_ontimrepay_in_same_month,
-- 是否该月逾期还款的本金比按时还款要多
case when ovd_amt_sum_mon > ontim_amt_sum_mon then 1 when ovd_amt_sum_mon <= ontim_amt_sum_mon then 0 else null end as if_ovdrepay_large_than_ontimrepay_amt_in_this_month,
-- 是否提前还款与按时还款同时发生在该月
case when ontim_count_mon > 0 and adv_count_mon > 0 then 1 when ontim_count_mon = 0 or adv_count_mon = 0 then 0 else null end as if_advrepay_ontimrepay_in_same_month,
-- 是否该月提前还款的本金比按时还款要多
case when adv_amt_sum_mon > ontim_amt_sum_mon then 1 when adv_amt_sum_mon <= ontim_amt_sum_mon then 0 else null end as if_advrepay_large_than_ontimrepay_amt_in_this_month,
-- 是否该月按时还款本金比评分日T-1日可用、授信额度还要多
case when ontim_amt_sum_mon > rsk_avl_lmt_cash then 1 when ontim_amt_sum_mon <= rsk_avl_lmt_cash then 0 else null end as if_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash,
case when ontim_amt_sum_mon > rsk_adt_lmt_cash then 1 when ontim_amt_sum_mon <= rsk_adt_lmt_cash then 0 else null end as if_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash,
-- 是否该月逾期还款本金比评分日T-1日可用、授信额度还要多
case when ovd_amt_sum_mon > rsk_avl_lmt_cash then 1 when ovd_amt_sum_mon <= rsk_avl_lmt_cash then 0 else null end as if_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash,
case when ovd_amt_sum_mon > rsk_adt_lmt_cash then 1 when ovd_amt_sum_mon <= rsk_adt_lmt_cash then 0 else null end as if_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash,
-- 是否该月提前还款本金比评分日T-1日可用、授信额度还要多
case when adv_amt_sum_mon > rsk_avl_lmt_cash then 1 when adv_amt_sum_mon <= rsk_avl_lmt_cash then 0 else null end as if_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash,
case when adv_amt_sum_mon > rsk_adt_lmt_cash then 1 when adv_amt_sum_mon <= rsk_adt_lmt_cash then 0 else null end as if_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash
from
(
    select uid,mdl_dte,substr(repay_type_same_month_cross_flag,1,7) as same_month_flg,
        sum(case when repay_status_main = '提前还款' then prc_amt else null end) as adv_amt_sum_mon, -- 该月提前还款的本金
        sum(case when repay_status_main = '提前还款' then 1 else null end) as adv_count_mon, -- 该月提前还款的次数
        sum(case when repay_status_main = '提前还款' and adv_3d_minus_flg = 1 then prc_amt else null end) as adv_3d_minus_amt_sum_mon, -- 该月提前3天内还款的本金
        sum(case when repay_status_main = '提前还款' and adv_15d_minus_flg = 1 then prc_amt else null end) as adv_15d_minus_amt_sum_mon, -- 该月提前15天内还款的本金
        sum(case when repay_status_main = '提前还款' and adv_1m_minus_flg = 1 then prc_amt else null end) as adv_1m_minus_amt_sum_mon, -- 该月提前30天内还款的本金
        sum(case when repay_status_main = '逾期还款' then prc_amt else null end) as ovd_amt_sum_mon, -- 该月逾期还款的本金
        sum(case when repay_status_main = '逾期还款' then 1 else null end) as ovd_count_mon, -- 该月逾期还款的次数
        sum(case when repay_status_main = '逾期还款' and ovd_1d_3d_flg = 1 then prc_amt else null end) as ovd_1_3d_amt_sum_mon, -- 该月逾期1～3天还款的本金总额
        sum(case when repay_status_main = '逾期还款' and ovd_4d_14d_flg = 1 then prc_amt else null end) as ovd_4_14d_amt_sum_mon, -- 该月逾期4～14天还款的本金总额
        sum(case when repay_status_main = '逾期还款' and ovd_15d_pls_flg = 1 then prc_amt else null end) as ovd_15d_plus_amt_sum_mon, -- 该月逾期15天以上还款的本金总额
        sum(case when repay_status_main = '逾期还款' and ovd_1m_pls_flg = 1 then prc_amt else null end) as ovd_1m_plus_amt_sum_mon, -- 该月逾期1个月以上还款的本金总额
        sum(case when repay_status_main = '按时还款' then prc_amt else null end) as ontim_amt_sum_mon, -- 该月按时还款的本金
        sum(case when repay_status_main = '按时还款' then 1 else null end) as ontim_count_mon, -- 该月按时还款的次数
        sum(prc_amt) as due_pay_amt_sum_mon, -- 该月总应还本金
        max(rsk_adt_lmt_cash) as rsk_adt_lmt_cash, -- 评分日T-1日授信额度
        max(rsk_avl_lmt_cash) as rsk_avl_lmt_cash -- 评分日T-1日可用额度
    from (
        select *, case when repay_status_main = '逾期还款' then dtl_rep_dte 
            when repay_status_main = '提前还款' then rep_tim
            when repay_status_main = '按时还款' then rep_tim 
            else null end as repay_type_same_month_cross_flag -- 事件发生时间测算口径：逾期用应还日、提前还款与按时还款用实际还款日
    from dwa_risk.dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_oline where repay_status_main in ('提前还款','逾期还款','按时还款') -- 评分日及以后的未来应还分期，不做计算
    ) basic
    group by uid,mdl_dte,substr(repay_type_same_month_cross_flag,1,7)
) mid
;
-- 原子表1.2 用户提前还款、逾期还款、按时还款按每笔还款聚合
drop table if exists dwa_risk.dwa_risk_inner_behaviour_all_repay_by_stg_aggregate_tmp_oline;
create table if not exists dwa_risk.dwa_risk_inner_behaviour_all_repay_by_stg_aggregate_tmp_oline as
select uid,mdl_dte,
max(case when ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_max_due_prc_amt, -- 历史最大单笔应还本金
max(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_max_due_prc_amt, -- 近90天最大单笔应还本金
max(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 180 then prc_amt else null end) as d180_max_due_prc_amt, -- 近180天最大单笔应还本金
max(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_max_due_prc_amt, -- 近360天最大单笔应还本金
max(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_max_due_prc_amt, -- 近720天最大单笔应还本金
max(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 1080 then prc_amt else null end) as d1080_max_due_prc_amt, -- 近1080天最大单笔应还本金
max(case when ddf_mdl_rep_dte <= 0 then prc_amt else null end) as ftr_max_due_prc_amt, -- 未来最大单笔应还本金

max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 then prc_amt else null end) as his_max_adv_repay_amt, -- 历史最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 90 then prc_amt else null end) as d90_max_adv_repay_amt, -- 近90天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 180 then prc_amt else null end) as d180_max_adv_repay_amt, -- 近180天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 360 then prc_amt else null end) as d360_max_adv_repay_amt, -- 近360天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 720 then prc_amt else null end) as d720_max_adv_repay_amt, -- 近720天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 1080 then prc_amt else null end) as d1080_max_adv_repay_amt, -- 近1080天最大单笔提前还款本金

max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_max_ovd_repay_amt, -- 历史最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_max_ovd_repay_amt, -- 近90天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 180 then prc_amt else null end) as d180_max_ovd_repay_amt, -- 近180天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_max_ovd_repay_amt, -- 近360天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_max_ovd_repay_amt, -- 近720天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 1080 then prc_amt else null end) as d1080_max_ovd_repay_amt, -- 近1080天最大单笔逾期还款本金

max(rsk_adt_lmt_cash) as rsk_adt_lmt_cash, -- 评分日T-1日授信额度
max(rsk_avl_lmt_cash) as rsk_avl_lmt_cash -- 评分日T-1日可用额度

from (
    select * from dwa_risk.dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_oline where repay_status_main in ('提前还款','逾期还款','按时还款')
) basic
group by uid,mdl_dte;

-- 原子表2:用户历史交易维度，样本表评分日前BT&CH交易行为，字段：交易状态：交易成功、交易失败，发起本金段，发起时间段，本金、分期数
-- 原子表2没有对uid+mdl_dte进行聚合，一次借款行为为一条记录
drop table if exists dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline;
create table if not exists dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline as
select  main.uid
        ,main.mdl_dte
        ,main.dtl_ord_no
        --订单创建时间（日期格式）
        ,main.crt_dte
        --订单创建时间（时间戳格式）
        ,main.crt_tim
        ,main.prc_amt
        ,main.fst_its_dte
        ,main.stg_num
        ,main.ord_stt_flg
        --间隔天数：用来限制借款行为的时间窗口期
        ,main.ddf_mdl_ord_crt_dte
        --订单创建时间，取两个最不一样的段，作为发起本金小于1000元_发起本金大于1w元_发生在同一个月_的次数_总和计算的基本
        ,case
                when hour(crt_tim) between 1 and 4  then '1到4点借款'
                when hour(crt_tim) between 8 and 11 then '8到11点借款'
                else '其他时间段借款'
        end as crt_hor_flg
        -- 本金区间，取两个最不一样的段，作为1到4点发起_8到11点发起_发生在同一个月_的次数_总和计算的基本
        ,case
                when prc_amt <= 1000  then '发起本金小于等于1000元'
                when prc_amt >= 10000 then '发起本金大于等于10000元'
                else '其他借款本金段'
        end as prc_amt_range_flg
        --借款发起本金是否大于发起日T日授信额度
        ,case when main.prc_amt > rsk_adt_lmt_cash_his_t_day then 1 when main.prc_amt <= rsk_adt_lmt_cash_his_t_day then 0 else null end as if_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day
        --借款发起本金是否大于发起日T日可用额度
        ,case when main.prc_amt > rsk_avl_lmt_cash_his_t_day then 1 when main.prc_amt <= rsk_avl_lmt_cash_his_t_day then 0 else null end as if_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day
        -- 每笔历史发起订单的T日可用额度、授信额度
        ,rsk_adt_lmt_cash_his_t_day
        ,rsk_avl_lmt_cash_his_t_day
        -- 评分日T-1日可用额度、授信额度
        ,b.rsk_adt_lmt_cash
        ,b.rsk_avl_lmt_cash
        --发起T日未结清分期应还本金总额是否大于发起日T日授信额度
        ,case when unpaid_principal_tot_amt_t_day > rsk_adt_lmt_cash_his_t_day then 1 when unpaid_principal_tot_amt_t_day <= rsk_adt_lmt_cash_his_t_day then 0 else null end as if_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day
        --发起T日未结清分期应还本金总额是否大于发起日T日可用额度
        ,case when unpaid_principal_tot_amt_t_day > rsk_avl_lmt_cash_his_t_day then 1 when unpaid_principal_tot_amt_t_day <= rsk_avl_lmt_cash_his_t_day then 0 else null end as if_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day
        -- 每笔历史发起订单的T日未结清分期应还本金
        ,unpaid_principal_tot_amt_t_day

from    (
            select  model_data.uid
                   ,model_data.mdl_dte
                   ,order_info.ord_no                                       as dtl_ord_no
                   --订单创建时间（日期格式）
                   ,order_info.crt_dte
                   --订单创建时间（时间戳格式）
                   ,order_info.crt_tim
                   ,order_info.prc_amt
                   ,order_info.fst_its_dte
                   ,order_info.stg_num
                   ,order_info.ord_stt_flg
                   --间隔天数
                   ,datediff(model_data.mdl_dte , date(order_info.crt_dte)) as ddf_mdl_ord_crt_dte
            from    (
                    select  uid
                            ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                    from    dwa_risk.dwa_risk_f_dz_model_data_base
                    ) model_data
            left join (
                          select  uid
                                 ,ord_no
                                 ,crt_tim
                                 ,date(crt_tim) as crt_dte
                                 ,prc_amt
                                 ,stg_num
                                 ,fst_its_dte
                                 ,ord_stt_flg
                          from    dwa_risk.dwa_risk_f_heavy_order_info_basic
                          where   bsy_typ in ( 'BALANCE_TRANSFER' , 'CASH' )  --('BALANCE_TRANSFER', 'CREDIT_TRANSACTION', 'CASH', 'HUGE_LOAN', 'ENJOY_PAY')
                      ) order_info
            on      model_data.uid = order_info.uid
            where   order_info.crt_tim < date(model_data.mdl_dte)  --在评分日之前的order信息
        ) main

    -- 匹配每个历史交易点T日的授信额度、可用额度
        left join (
            -- 匹配每个历史交易点T日的授信额度、可用额度
            select  uid
                    ,ord_no as dtl_ord_no
                    ,rsk_adt_lmt_cash_his_t_day
                    ,rsk_avl_lmt_cash_his_t_day
                    ,unpaid_principal_tot_amt_t_day
            from    dwa_risk.dwa_risk_f_heavy_order_crt_date_credit_limit_upaid_principal_di
            where   ds between to_char(date_add(to_date('${bizdate}' , 'yyyymmdd') , -1500),'yyyymmdd') and '${bizdate}'
        ) credit_upaid
        on      main.uid = credit_upaid.uid
        and     main.dtl_ord_no = credit_upaid.dtl_ord_no

        left join dwa_risk.dwa_risk_cross_inner_behaviour_credit_limit_dimension_analysis_sample_oline b -- 评分日T-1日的额度信息
        on main.uid = b.uid and main.mdl_dte = b.mdl_dte;

-- 原子表2.1 用户交易行为by月聚合：要求若这个月份没有对应的行为，则聚合结果为空
drop table if exists dwa_risk.dwa_risk_inner_behaviour_all_trade_by_month_aggregate_tmp_oline;
create table if not exists dwa_risk.dwa_risk_inner_behaviour_all_trade_by_month_aggregate_tmp_oline as
select mid.*,
-- 评分日与月份初之间的日期差
DATEDIFF(mdl_dte,to_date(concat(same_month_flg,'-01'),'yyyy-mm-dd')) as ddf_mdl_dte_trade_mon,
-- 是否交易成功和交易失败发生在同一个月：1为是0为否
case when trade_success_count_mon > 0 and trade_fail_count_mon > 0 then 1 when trade_success_count_mon = 0 or trade_fail_count_mon = 0 then 0 else null end as if_suc_fail_trade_in_same_month, 
-- 是否该月失败交易的本金比成功交易的本金要多
case when trade_fail_amt_sum_mon > trade_success_amt_sum_mon then 1 when trade_fail_amt_sum_mon <= trade_success_amt_sum_mon then 0 else null end as if_fail_trade_large_than_suc_trade_amt_in_this_month, 
-- 是否该月失败交易的期限比成功交易的期限要长
case when trade_fail_stgnum_avg_mon > trade_success_stgnum_avg_mon then 1 when trade_fail_stgnum_avg_mon <= trade_success_stgnum_avg_mon then 0 else null end as if_fail_trade_large_than_suc_trade_stgnum_in_this_month, 
-- 是否1到4点发起_8到11点发起_发生在同一个月
case when trade_1_4am_count_mon > 0 and trade_8_11am_count_mon > 0 then 1 when trade_1_4am_count_mon = 0 and trade_8_11am_count_mon = 0 then 0 else null end as if_1_4am_8_11am_trade_in_same_month, 
-- 是否发起本金小于1000元_发起本金大于1w元发生在同一个月
case when trade_1000minus_count_mon > 0 and trade_10000plus_count_mon > 0 then 1 when trade_1000minus_count_mon = 0 and trade_10000plus_count_mon = 0 then 0 else null end as if_1000minus_10000plus_trade_in_same_month,
-- 是否该月累计成功本金比评分日T-1日可用、授信额度还要多
case when trade_success_amt_sum_mon > rsk_avl_lmt_cash then 1 when trade_success_amt_sum_mon <= rsk_avl_lmt_cash then 0 else null end as if_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash,
case when trade_success_amt_sum_mon > rsk_adt_lmt_cash then 1 when trade_success_amt_sum_mon <= rsk_adt_lmt_cash then 0 else null end as if_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash,
-- 是否该月累计发起本金比评分日T-1日可用、授信额度还要多
case when trade_amt_sum_mon > rsk_avl_lmt_cash then 1 when trade_amt_sum_mon <= rsk_avl_lmt_cash then 0 else null end as if_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash,
case when trade_amt_sum_mon > rsk_adt_lmt_cash then 1 when trade_amt_sum_mon <= rsk_adt_lmt_cash then 0 else null end as if_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash
from
(
    select uid,mdl_dte,substr(crt_dte,1,7) as same_month_flg,
        sum(prc_amt) as trade_amt_sum_mon, -- 该月所有发起交易的本金
        avg(prc_amt) as trade_avg_sum_mon, -- 该月所有发起交易的平均本金
        avg(stg_num) as trade_avg_stgnum_mon, -- 该月所有发起交易的平均期数
        count(1) as trade_count_mon, -- 该月所有发起交易的次数
    
        sum(case when ord_stt_flg = 'success' then prc_amt else null end) as trade_success_amt_sum_mon, -- 该月成功交易的本金总和
        avg(case when ord_stt_flg = 'success' then prc_amt else null end) as trade_success_amt_avg_mon, -- 该月成功交易的本金均值
        avg(case when ord_stt_flg = 'success' then stg_num else null end) as trade_success_stgnum_avg_mon, -- 该月成功交易的期数均值
        sum(case when ord_stt_flg = 'success' then 1 else null end) as trade_success_count_mon, -- 该月成功交易的次数
        sum(case when ord_stt_flg = 'fail' then prc_amt else null end) as trade_fail_amt_sum_mon, -- 该月失败交易的本金总和
        avg(case when ord_stt_flg = 'fail' then prc_amt else null end) as trade_fail_amt_avg_mon, -- 该月失败交易的本金均值
        avg(case when ord_stt_flg = 'fail' then stg_num else null end) as trade_fail_stgnum_avg_mon, -- 该月失败交易的期数均值
        sum(case when ord_stt_flg = 'fail' then 1 else null end) as trade_fail_count_mon, -- 该月失败交易的次数
        
        sum(case when crt_hor_flg = '1到4点借款' then prc_amt else null end) as trade_1_4am_amt_sum_mon, -- 该月1到4点发起交易的本金总和
        avg(case when crt_hor_flg = '1到4点借款' then prc_amt else null end) as trade_1_4am_amt_avg_mon, -- 该月1到4点发起交易的本金均值
        avg(case when crt_hor_flg = '1到4点借款' then stg_num else null end) as trade_1_4am_stgnum_avg_mon, -- 该月1到4点发起交易的期数均值
        sum(case when crt_hor_flg = '1到4点借款' then 1 else null end) as trade_1_4am_count_mon, -- 该月1到4点发起交易的次数
    
        sum(case when crt_hor_flg = '8到11点借款' then prc_amt else null end) as trade_8_11am_amt_sum_mon, -- 该月8到11点发起交易的本金总和
        avg(case when crt_hor_flg = '8到11点借款' then prc_amt else null end) as trade_8_11am_amt_avg_mon, -- 该月8到11点发起交易的本金均值
        avg(case when crt_hor_flg = '8到11点借款' then stg_num else null end) as trade_8_11am_stgnum_avg_mon, -- 该月8到11点发起交易的期数均值
        sum(case when crt_hor_flg = '8到11点借款' then 1 else null end) as trade_8_11am_count_mon, -- 该月8到11点发起交易的次数
    
        sum(case when prc_amt_range_flg = '发起本金小于等于1000元' then prc_amt else null end) as trade_1000minus_amt_sum_mon, -- 该月发起交易1000元以下的本金总和
        avg(case when prc_amt_range_flg = '发起本金小于等于1000元' then stg_num else null end) as trade_1000minus_stgnum_avg_mon, -- 该月发起交易1000元以下的期数均值
        sum(case when prc_amt_range_flg = '发起本金小于等于1000元' then 1 else null end) as trade_1000minus_count_mon, -- 该月发起交易1000元以下的次数
        sum(case when prc_amt_range_flg = '发起本金大于等于10000元' then prc_amt else null end) as trade_10000plus_amt_sum_mon, -- 该月发起交易10000元以上的本金总和
        avg(case when prc_amt_range_flg = '发起本金大于等于10000元' then stg_num else null end) as trade_10000plus_stgnum_avg_mon, -- 该月发起交易10000元以上的期数均值
        sum(case when prc_amt_range_flg = '发起本金大于等于10000元' then 1 else null end) as trade_10000plus_count_mon, -- 该月发起交易10000元以上的次数
        max(rsk_adt_lmt_cash) as rsk_adt_lmt_cash, -- 评分日T-1日授信额度
        max(rsk_avl_lmt_cash) as rsk_avl_lmt_cash -- 评分日T-1日可用额度
    
    from dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline basic
    group by uid,mdl_dte,substr(crt_dte,1,7)

) mid;
-- 原子表2.1 用户交易行为by笔聚合
drop table if exists dwa_risk.dwa_risk_inner_behaviour_all_trade_by_ord_aggregate_tmp_oline;
create table if not exists dwa_risk.dwa_risk_inner_behaviour_all_trade_by_ord_aggregate_tmp_oline as
select uid,mdl_dte,
        max(case when ddf_mdl_ord_crt_dte > 0 then prc_amt else null end) as his_max_faqi_prc_amt, -- 历史最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then prc_amt else null end) as d90_max_faqi_prc_amt, -- 近90天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then prc_amt else null end) as d180_max_faqi_prc_amt, -- 近180天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then prc_amt else null end) as d360_max_faqi_prc_amt, -- 近360天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then prc_amt else null end) as d720_max_faqi_prc_amt, -- 近720天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then prc_amt else null end) as d1080_max_faqi_prc_amt, -- 近1080天最大单次发起借款本金

        max(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = 'success' then prc_amt else null end) as his_max_suc_prc_amt, -- 历史最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = 'success' then prc_amt else null end) as d90_max_suc_prc_amt, -- 近90天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 and ord_stt_flg = 'success' then prc_amt else null end) as d180_max_suc_prc_amt, -- 近180天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = 'success' then prc_amt else null end) as d360_max_suc_prc_amt, -- 近360天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = 'success' then prc_amt else null end) as d720_max_suc_prc_amt, -- 近720天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 and ord_stt_flg = 'success' then prc_amt else null end) as d1080_max_suc_prc_amt, -- 近1080天最大单次成功借款本金

        max(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = 'fail' then prc_amt else null end) as his_max_fail_prc_amt, -- 历史最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = 'fail' then prc_amt else null end) as d90_max_fail_prc_amt, -- 近90天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 and ord_stt_flg = 'fail' then prc_amt else null end) as d180_max_fail_prc_amt, -- 近180天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = 'fail' then prc_amt else null end) as d360_max_fail_prc_amt, -- 近360天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = 'fail' then prc_amt else null end) as d720_max_fail_prc_amt, -- 近720天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 and ord_stt_flg = 'fail' then prc_amt else null end) as d1080_max_fail_prc_amt, -- 近1080天最大单次失败借款本金
        max(rsk_adt_lmt_cash) as rsk_adt_lmt_cash, -- 评分日T-1日授信额度
        max(rsk_avl_lmt_cash) as rsk_avl_lmt_cash -- 评分日T-1日可用额度

from dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline basic
group by uid,mdl_dte;

-- 原子表3:用户负债情况，评分日T-1日前所有未结清本金总计
-- 原子表3对uid+mdl_dte做了聚合
drop table if exists dwa_risk.dwa_risk_cross_inner_behaviour_debate_dimension_analysis_sample_oline;
CREATE TABLE if not exists dwa_risk.dwa_risk_cross_inner_behaviour_debate_dimension_analysis_sample_oline as
select a.*,b.max_ovd_amt_sum_mon,b.max_ontim_amt_sum_mon,b.max_due_pay_amt_sum_mon
from (
    select  uid
            ,mdl_dte
            ,unpaid_principal_tot -- 总未还本金
            ,unpaid_principal_his -- 历史到期未还本金
            ,unpaid_principal_future -- 未来到期未还本金
    from dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df where ds = '${bizdate}'
) a
left join
    (
        select uid,mdl_dte,
        -- 历史至今最大月度逾期本金总和
        max(ovd_amt_sum_mon) as max_ovd_amt_sum_mon,
        -- 历史至今最大月度按时还款本金总和
        max(ontim_amt_sum_mon) as max_ontim_amt_sum_mon,
        -- 历史至今最大月度应还款本金总和
        max(due_pay_amt_sum_mon) as max_due_pay_amt_sum_mon
        from
        dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline
        group by uid,mdl_dte
) b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte
;


-- *************************** 原子表相互交叉 *************************** --
-- ************************ 1 还款与其他维度交叉 ************************ --
-- 1.1 还款内部交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_1_repay_behaviour_inner_cross_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_1_repay_behaviour_inner_cross_df as
select uid,mdl_dte,

-- 1.1.1 提前还款与逾期还款的交叉
-- 提前还款与逾期还款发生在同一个月的月份数
sum(case when ddf_mdl_dte_rep_mon >0 then if_ovdrepay_advrepay_in_same_month else null end) as his_ovdrepay_advrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ovdrepay_advrepay_in_same_month else null end) as d90_ovdrepay_advrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ovdrepay_advrepay_in_same_month else null end) as d180_ovdrepay_advrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ovdrepay_advrepay_in_same_month else null end) as d360_ovdrepay_advrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ovdrepay_advrepay_in_same_month else null end) as d720_ovdrepay_advrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ovdrepay_advrepay_in_same_month else null end) as d1080_ovdrepay_advrepay_in_same_month_count_sum,

-- 逾期还款本金大于提前还款本金的月份数
sum(case when ddf_mdl_dte_rep_mon >0 then if_ovdrepay_large_than_advrepay_amt_in_this_month else null end) as his_ovdrepay_large_than_advrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ovdrepay_large_than_advrepay_amt_in_this_month else null end) as d90_ovdrepay_large_than_advrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ovdrepay_large_than_advrepay_amt_in_this_month else null end) as d180_ovdrepay_large_than_advrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ovdrepay_large_than_advrepay_amt_in_this_month else null end) as d360_ovdrepay_large_than_advrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ovdrepay_large_than_advrepay_amt_in_this_month else null end) as d720_ovdrepay_large_than_advrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ovdrepay_large_than_advrepay_amt_in_this_month else null end) as d1080_ovdrepay_large_than_advrepay_amt_months_count_sum,

-- 逾期还款的本金与提前还款本金的比值
sum(case when ddf_mdl_dte_rep_mon >0 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 then adv_amt_sum_mon else null end) as his_ovdrepay_amt_sum_divide_advrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then adv_amt_sum_mon else null end) as d90_ovdrepay_amt_sum_divide_advrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then adv_amt_sum_mon else null end) as d180_ovdrepay_amt_sum_divide_advrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then adv_amt_sum_mon else null end) as d360_ovdrepay_amt_sum_divide_advrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then adv_amt_sum_mon else null end) as d720_ovdrepay_amt_sum_divide_advrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then adv_amt_sum_mon else null end) as d1080_ovdrepay_amt_sum_divide_advrepay_amt_sum,

sum(case when ddf_mdl_dte_rep_mon >0 then ovd_1_3d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 then adv_3d_minus_amt_sum_mon else null end) as his_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then ovd_1_3d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then adv_3d_minus_amt_sum_mon else null end) as d90_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then ovd_1_3d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then adv_3d_minus_amt_sum_mon else null end) as d180_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then ovd_1_3d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then adv_3d_minus_amt_sum_mon else null end) as d360_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then ovd_1_3d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then adv_3d_minus_amt_sum_mon else null end) as d720_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then ovd_1_3d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then adv_3d_minus_amt_sum_mon else null end) as d1080_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum,

sum(case when ddf_mdl_dte_rep_mon >0 then ovd_4_14d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 then adv_15d_minus_amt_sum_mon else null end) as his_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then ovd_4_14d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then adv_15d_minus_amt_sum_mon else null end) as d90_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then ovd_4_14d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then adv_15d_minus_amt_sum_mon else null end) as d180_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then ovd_4_14d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then adv_15d_minus_amt_sum_mon else null end) as d360_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then ovd_4_14d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then adv_15d_minus_amt_sum_mon else null end) as d720_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then ovd_4_14d_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then adv_15d_minus_amt_sum_mon else null end) as d1080_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum,

sum(case when ddf_mdl_dte_rep_mon >0 then ovd_1m_plus_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 then adv_1m_minus_amt_sum_mon else null end) as his_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then ovd_1m_plus_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then adv_1m_minus_amt_sum_mon else null end) as d90_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then ovd_1m_plus_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then adv_1m_minus_amt_sum_mon else null end) as d180_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then ovd_1m_plus_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then adv_1m_minus_amt_sum_mon else null end) as d360_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then ovd_1m_plus_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then adv_1m_minus_amt_sum_mon else null end) as d720_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then ovd_1m_plus_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then adv_1m_minus_amt_sum_mon else null end) as d1080_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum,

-- 1.1.2 逾期还款与按时还款的交叉
-- 按时还款与逾期还款发生在同一个月的月份数
sum(case when ddf_mdl_dte_rep_mon >0 then if_ovdrepay_ontimrepay_in_same_month else null end) as his_ovdrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ovdrepay_ontimrepay_in_same_month else null end) as d90_ovdrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ovdrepay_ontimrepay_in_same_month else null end) as d180_ovdrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ovdrepay_ontimrepay_in_same_month else null end) as d360_ovdrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ovdrepay_ontimrepay_in_same_month else null end) as d720_ovdrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ovdrepay_ontimrepay_in_same_month else null end) as d1080_ovdrepay_ontimrepay_in_same_month_count_sum,

-- 逾期还款本金大于按时还款本金的月份数
sum(case when ddf_mdl_dte_rep_mon >0 then if_ovdrepay_large_than_ontimrepay_amt_in_this_month else null end) as his_ovdrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ovdrepay_large_than_ontimrepay_amt_in_this_month else null end) as d90_ovdrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ovdrepay_large_than_ontimrepay_amt_in_this_month else null end) as d180_ovdrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ovdrepay_large_than_ontimrepay_amt_in_this_month else null end) as d360_ovdrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ovdrepay_large_than_ontimrepay_amt_in_this_month else null end) as d720_ovdrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ovdrepay_large_than_ontimrepay_amt_in_this_month else null end) as d1080_ovdrepay_large_than_ontimrepay_amt_months_count_sum,

-- 逾期还款的本金与按时还款本金的比值
sum(case when ddf_mdl_dte_rep_mon >0 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 then ontim_amt_sum_mon else null end) as his_ovdrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then ontim_amt_sum_mon else null end) as d90_ovdrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then ontim_amt_sum_mon else null end) as d180_ovdrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then ontim_amt_sum_mon else null end) as d360_ovdrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then ontim_amt_sum_mon else null end) as d720_ovdrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then ovd_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then ontim_amt_sum_mon else null end) as d1080_ovdrepay_amt_sum_divide_ontimrepay_amt_sum,

-- 1.1.3 提前还款与按时还款的交叉
-- 按时还款与提前还款发生在同一个月的月份数
sum(case when ddf_mdl_dte_rep_mon >0 then if_advrepay_ontimrepay_in_same_month else null end) as his_advrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_advrepay_ontimrepay_in_same_month else null end) as d90_advrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_advrepay_ontimrepay_in_same_month else null end) as d180_advrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_advrepay_ontimrepay_in_same_month else null end) as d360_advrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_advrepay_ontimrepay_in_same_month else null end) as d720_advrepay_ontimrepay_in_same_month_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_advrepay_ontimrepay_in_same_month else null end) as d1080_advrepay_ontimrepay_in_same_month_count_sum,

-- 提前还款本金大于按时还款本金的月份数
sum(case when ddf_mdl_dte_rep_mon >0 then if_advrepay_large_than_ontimrepay_amt_in_this_month else null end) as his_advrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_advrepay_large_than_ontimrepay_amt_in_this_month else null end) as d90_advrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_advrepay_large_than_ontimrepay_amt_in_this_month else null end) as d180_advrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_advrepay_large_than_ontimrepay_amt_in_this_month else null end) as d360_advrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_advrepay_large_than_ontimrepay_amt_in_this_month else null end) as d720_advrepay_large_than_ontimrepay_amt_months_count_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_advrepay_large_than_ontimrepay_amt_in_this_month else null end) as d1080_advrepay_large_than_ontimrepay_amt_months_count_sum,

-- 提前还款的本金与按时还款本金的比值
sum(case when ddf_mdl_dte_rep_mon >0 then adv_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 then ontim_amt_sum_mon else null end) as his_advrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then adv_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then ontim_amt_sum_mon else null end) as d90_advrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then adv_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then ontim_amt_sum_mon else null end) as d180_advrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then adv_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then ontim_amt_sum_mon else null end) as d360_advrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then adv_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then ontim_amt_sum_mon else null end) as d720_advrepay_amt_sum_divide_ontimrepay_amt_sum,
sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then adv_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then ontim_amt_sum_mon else null end) as d1080_advrepay_amt_sum_divide_ontimrepay_amt_sum

from dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline aggreate_by_mon
group by uid,mdl_dte;

-- 1.2 还款交叉借款
-- 1.2.1 by月行为的维度交叉
-- 将借款原子表与还款原子表merge在一起_by月行为的merge：
drop table if exists dwa_risk.dwa_risk_repay_cross_trade_behaviour_agregate_by_mon_atomtable_oline;
create table if not exists dwa_risk.dwa_risk_repay_cross_trade_behaviour_agregate_by_mon_atomtable_oline as
select COALESCE(repay.uid, trade.uid) as uid,
COALESCE(repay.mdl_dte, trade.mdl_dte) as mdl_dte,
COALESCE(repay.same_month_flg, trade.same_month_flg) as same_month_flg,
DATEDIFF(COALESCE(repay.mdl_dte, trade.mdl_dte),to_date(concat(COALESCE(repay.same_month_flg, trade.same_month_flg),'-01'),'yyyy-mm-dd')) as ddf_mdl_dte_mon, -- 评分日与事件月份初之间的日期差

-- 是否交易失败与逾期还款同时发生在该月
case when ovd_count_mon > 0 and trade_fail_count_mon > 0 then 1 else 0 end as if_ovdrepay_fail_trade_in_same_month, 
-- 是否交易成功与提前还款同时发生在该月
case when adv_count_mon > 0 and trade_success_count_mon > 0 then 1 else 0 end as if_advrepay_success_trade_in_same_month, 
-- 是否交易成功与逾期还款同时发生在该月
case when ovd_count_mon > 0 and trade_success_count_mon > 0 then 1 else 0 end as if_ovdrepay_success_trade_in_same_month, 
-- 是否1-4点借款与逾期还款同时发生在该月
case when trade_1_4am_count_mon > 0 and ovd_count_mon > 0 then 1 else 0 end as if_ovdrepay_1_4am_trade_in_same_month, 
-- 是否发起本金大于10000元与逾期还款同时发生在该月
case when trade_10000plus_count_mon > 0 and ovd_count_mon > 0 then 1 else 0 end as if_ovdrepay_1wplus_trade_in_same_month, 

adv_amt_sum_mon,adv_count_mon,adv_3d_minus_amt_sum_mon,adv_15d_minus_amt_sum_mon,adv_1m_minus_amt_sum_mon,ovd_amt_sum_mon,ovd_count_mon,ovd_1_3d_amt_sum_mon,ovd_4_14d_amt_sum_mon,ovd_15d_plus_amt_sum_mon,ovd_1m_plus_amt_sum_mon,ontim_amt_sum_mon,ontim_count_mon,due_pay_amt_sum_mon,if_ovdrepay_advrepay_in_same_month,if_ovdrepay_large_than_advrepay_amt_in_this_month,if_ovdrepay_ontimrepay_in_same_month,if_ovdrepay_large_than_ontimrepay_amt_in_this_month,if_advrepay_ontimrepay_in_same_month,if_advrepay_large_than_ontimrepay_amt_in_this_month,

trade_amt_sum_mon, trade_avg_sum_mon, trade_avg_stgnum_mon, trade_count_mon, trade_success_amt_sum_mon, trade_success_amt_avg_mon, trade_success_stgnum_avg_mon, trade_success_count_mon, trade_fail_amt_sum_mon, trade_fail_amt_avg_mon, trade_fail_stgnum_avg_mon, trade_fail_count_mon, trade_1_4am_amt_sum_mon, trade_1_4am_amt_avg_mon, trade_1_4am_stgnum_avg_mon, trade_1_4am_count_mon, trade_8_11am_amt_sum_mon, trade_8_11am_amt_avg_mon, trade_8_11am_stgnum_avg_mon, trade_8_11am_count_mon, trade_1000minus_amt_sum_mon, trade_1000minus_stgnum_avg_mon, trade_1000minus_count_mon, trade_10000plus_amt_sum_mon, trade_10000plus_stgnum_avg_mon, trade_10000plus_count_mon,if_suc_fail_trade_in_same_month,if_fail_trade_large_than_suc_trade_amt_in_this_month,if_fail_trade_large_than_suc_trade_stgnum_in_this_month,if_1_4am_8_11am_trade_in_same_month,if_1000minus_10000plus_trade_in_same_month

 from 
dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline repay
full OUTER JOIN dwa_risk.dwa_risk_inner_behaviour_all_trade_by_month_aggregate_tmp_oline trade
on repay.uid = trade.uid and repay.mdl_dte = trade.mdl_dte and repay.same_month_flg = trade.same_month_flg;

-- 维度之间同月行为的交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_2_repay_cross_trade_behaviour_by_mon_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_2_repay_cross_trade_behaviour_by_mon_df as
select uid,mdl_dte,
-- 交易失败_逾期还款_发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_mon > 0 then if_ovdrepay_fail_trade_in_same_month else null end) as his_ovdrepay_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then if_ovdrepay_fail_trade_in_same_month else null end) as d90_ovdrepay_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then if_ovdrepay_fail_trade_in_same_month else null end) as d180_ovdrepay_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then if_ovdrepay_fail_trade_in_same_month else null end) as d360_ovdrepay_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then if_ovdrepay_fail_trade_in_same_month else null end) as d720_ovdrepay_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then if_ovdrepay_fail_trade_in_same_month else null end) as d1080_ovdrepay_fail_trade_in_same_month_count_sum,
-- 交易成功_提前还款_发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_mon > 0 then if_advrepay_success_trade_in_same_month else null end) as his_advrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then if_advrepay_success_trade_in_same_month else null end) as d90_advrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then if_advrepay_success_trade_in_same_month else null end) as d180_advrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then if_advrepay_success_trade_in_same_month else null end) as d360_advrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then if_advrepay_success_trade_in_same_month else null end) as d720_advrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then if_advrepay_success_trade_in_same_month else null end) as d1080_advrepay_suc_trade_in_same_month_count_sum,
-- 交易成功_逾期还款_发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_mon > 0 then if_ovdrepay_success_trade_in_same_month else null end) as his_ovdrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then if_ovdrepay_success_trade_in_same_month else null end) as d90_ovdrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then if_ovdrepay_success_trade_in_same_month else null end) as d180_ovdrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then if_ovdrepay_success_trade_in_same_month else null end) as d360_ovdrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then if_ovdrepay_success_trade_in_same_month else null end) as d720_ovdrepay_suc_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then if_ovdrepay_success_trade_in_same_month else null end) as d1080_ovdrepay_suc_trade_in_same_month_count_sum,
-- 1-4点借款与逾期还款发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_mon > 0 then if_ovdrepay_1_4am_trade_in_same_month else null end) as his_ovdrepay_1_4am_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then if_ovdrepay_1_4am_trade_in_same_month else null end) as d90_ovdrepay_1_4am_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then if_ovdrepay_1_4am_trade_in_same_month else null end) as d180_ovdrepay_1_4am_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then if_ovdrepay_1_4am_trade_in_same_month else null end) as d360_ovdrepay_1_4am_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then if_ovdrepay_1_4am_trade_in_same_month else null end) as d720_ovdrepay_1_4am_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then if_ovdrepay_1_4am_trade_in_same_month else null end) as d1080_ovdrepay_1_4am_trade_in_same_month_count_sum,
-- 发起本金大于10000元与逾期还款发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_mon > 0 then if_ovdrepay_1wplus_trade_in_same_month else null end) as his_ovdrepay_1wplus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then if_ovdrepay_1wplus_trade_in_same_month else null end) as d90_ovdrepay_1wplus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then if_ovdrepay_1wplus_trade_in_same_month else null end) as d180_ovdrepay_1wplus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then if_ovdrepay_1wplus_trade_in_same_month else null end) as d360_ovdrepay_1wplus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then if_ovdrepay_1wplus_trade_in_same_month else null end) as d720_ovdrepay_1wplus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then if_ovdrepay_1wplus_trade_in_same_month else null end) as d1080_ovdrepay_1wplus_trade_in_same_month_count_sum,
-- 近XX个月_每个月待还本金_总额/近XX个月_每个月发起借款本金_总额
sum(case when ddf_mdl_dte_mon > 0 then due_pay_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_mon > 0 then trade_amt_sum_mon else null end) as his_due_repay_amt_sum_divide_his_faqi_trade_amt_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then due_pay_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then trade_amt_sum_mon else null end) as d90_due_repay_amt_sum_divide_d90_faqi_trade_amt_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then due_pay_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then trade_amt_sum_mon else null end) as d180_due_repay_amt_sum_divide_d180_faqi_trade_amt_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then due_pay_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then trade_amt_sum_mon else null end) as d360_due_repay_amt_sum_divide_d360_faqi_trade_amt_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then due_pay_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then trade_amt_sum_mon else null end) as d720_due_repay_amt_sum_divide_d720_faqi_trade_amt_sum,
sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then due_pay_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then trade_amt_sum_mon else null end) as d1080_due_repay_amt_sum_divide_d1080_faqi_trade_amt_sum,
-- 近XX个月_每个月待还本金总额_均值/近XX个月_每个月发起借款本金总额_均值
avg(case when ddf_mdl_dte_mon > 0 then due_pay_amt_sum_mon else null end)/avg(case when ddf_mdl_dte_mon > 0 then trade_amt_sum_mon else null end) as his_due_repay_amt_avg_divide_his_faqi_trade_amt_avg,
avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then due_pay_amt_sum_mon else null end)/avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 90 then trade_amt_sum_mon else null end) as d90_due_repay_amt_avg_divide_d90_faqi_trade_amt_avg,
avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then due_pay_amt_sum_mon else null end)/avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 180 then trade_amt_sum_mon else null end) as d180_due_repay_amt_avg_divide_d180_faqi_trade_amt_avg,
avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then due_pay_amt_sum_mon else null end)/avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 360 then trade_amt_sum_mon else null end) as d360_due_repay_amt_avg_divide_d360_faqi_trade_amt_avg,
avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then due_pay_amt_sum_mon else null end)/avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 720 then trade_amt_sum_mon else null end) as d720_due_repay_amt_avg_divide_d720_faqi_trade_amt_avg,
avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then due_pay_amt_sum_mon else null end)/avg(case when ddf_mdl_dte_mon > 0 and ddf_mdl_dte_mon <= 1080 then trade_amt_sum_mon else null end) as d1080_due_repay_amt_avg_divide_d1080_faqi_trade_amt_avg

from dwa_risk.dwa_risk_repay_cross_trade_behaviour_agregate_by_mon_atomtable_oline
group by uid,mdl_dte;

-- 1.2.2 by笔行为的维度交叉
-- 借款与还款维度之间行为交叉_by笔聚合
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_3_repay_cross_trade_behaviour_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_3_repay_cross_trade_behaviour_by_each_df as
select COALESCE(repay.uid, trade.uid) as uid,
COALESCE(repay.mdl_dte, trade.mdl_dte) as mdl_dte,
-- 近XX个月_每笔待还本金最大值/近XX个月_发起借款本金最大值
his_max_due_prc_amt/his_max_faqi_prc_amt as his_max_due_prc_amt_divide_his_max_faqi_prc_amt,
d90_max_due_prc_amt/d90_max_faqi_prc_amt as d90_max_due_prc_amt_divide_d90_max_faqi_prc_amt,
d180_max_due_prc_amt/d180_max_faqi_prc_amt as d180_max_due_prc_amt_divide_d180_max_faqi_prc_amt,
d360_max_due_prc_amt/d360_max_faqi_prc_amt as d360_max_due_prc_amt_divide_d360_max_faqi_prc_amt,
d720_max_due_prc_amt/d720_max_faqi_prc_amt as d720_max_due_prc_amt_divide_d720_max_faqi_prc_amt,
d1080_max_due_prc_amt/d1080_max_faqi_prc_amt as d1080_max_due_prc_amt_divide_d1080_max_faqi_prc_amt,

-- 近XX个月_每笔提前还款本金最大值/近XX个月_发起借款本金最大值
his_max_adv_repay_amt/his_max_faqi_prc_amt as his_max_adv_repay_amt_divide_his_max_faqi_prc_amt,
d90_max_adv_repay_amt/d90_max_faqi_prc_amt as d90_max_adv_repay_amt_divide_d90_max_faqi_prc_amt,
d180_max_adv_repay_amt/d180_max_faqi_prc_amt as d180_max_adv_repay_amt_divide_d180_max_faqi_prc_amt,
d360_max_adv_repay_amt/d360_max_faqi_prc_amt as d360_max_adv_repay_amt_divide_d360_max_faqi_prc_amt,
d720_max_adv_repay_amt/d720_max_faqi_prc_amt as d720_max_adv_repay_amt_divide_d720_max_faqi_prc_amt,
d1080_max_adv_repay_amt/d1080_max_faqi_prc_amt as d1080_max_adv_repay_amt_divide_d1080_max_faqi_prc_amt,

-- 近XX个月_每笔逾期还款本金最大值/近XX个月_成功借款本金最大值
his_max_ovd_repay_amt/his_max_suc_prc_amt as his_max_ovd_repay_amt_divide_his_max_suc_prc_amt,
d90_max_ovd_repay_amt/d90_max_suc_prc_amt as d90_max_ovd_repay_amt_divide_d90_max_suc_prc_amt,
d180_max_ovd_repay_amt/d180_max_suc_prc_amt as d180_max_ovd_repay_amt_divide_d180_max_suc_prc_amt,
d360_max_ovd_repay_amt/d360_max_suc_prc_amt as d360_max_ovd_repay_amt_divide_d360_max_suc_prc_amt,
d720_max_ovd_repay_amt/d720_max_suc_prc_amt as d720_max_ovd_repay_amt_divide_d720_max_suc_prc_amt,
d1080_max_ovd_repay_amt/d1080_max_suc_prc_amt as d1080_max_ovd_repay_amt_divide_d1080_max_suc_prc_amt,

-- 近XX个月_每笔逾期还款本金最大值/近XX个月_失败借款本金最大值
his_max_ovd_repay_amt/his_max_fail_prc_amt as his_max_ovd_repay_amt_divide_his_max_fail_prc_amt,
d90_max_ovd_repay_amt/d90_max_fail_prc_amt as d90_max_ovd_repay_amt_divide_d90_max_fail_prc_amt,
d180_max_ovd_repay_amt/d180_max_fail_prc_amt as d180_max_ovd_repay_amt_divide_d180_max_fail_prc_amt,
d360_max_ovd_repay_amt/d360_max_fail_prc_amt as d360_max_ovd_repay_amt_divide_d360_max_fail_prc_amt,
d720_max_ovd_repay_amt/d720_max_fail_prc_amt as d720_max_ovd_repay_amt_divide_d720_max_fail_prc_amt,
d1080_max_ovd_repay_amt/d1080_max_fail_prc_amt as d1080_max_ovd_repay_amt_divide_d1080_max_fail_prc_amt

from 
dwa_risk.dwa_risk_inner_behaviour_all_repay_by_stg_aggregate_tmp_oline repay
full OUTER JOIN dwa_risk.dwa_risk_inner_behaviour_all_trade_by_ord_aggregate_tmp_oline trade
on repay.uid = trade.uid and repay.mdl_dte = trade.mdl_dte;

-- 1.3 还款交叉额度使用
-- 1.3.1 by笔行为的维度交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_4_repay_cross_credit_limit_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_4_repay_cross_credit_limit_by_each_df as
select uid,mdl_dte,
-- 历史每期应还本金大于还款日T日授信额度的次数
sum(case when ddf_mdl_rep_dte > 0 then if_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as his_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then if_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d90_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 180 then if_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d180_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then if_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d360_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then if_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d720_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 1080 then if_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d1080_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
-- 历史每期应还本金大于还款日T日可用额度的次数
sum(case when ddf_mdl_rep_dte > 0 then if_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as his_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then if_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d90_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 180 then if_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d180_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then if_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d360_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then if_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d720_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 1080 then if_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d1080_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
-- 未来每期应还本金大于评分日T-1日授信额度的次数，这样写有未来订单的应还行为穿越
--sum(case when ddf_mdl_rep_dte <= 0 then if_due_repay_amt_larger_than_mdldte_risk_admit_limit else null end) as ftr_due_repay_amt_larger_than_mdldte_risk_admit_limit_count_sum,
-- 未来每期应还本金大于评分日T-1日可用额度的次数，这样写有未来订单的应还行为穿越
--sum(case when ddf_mdl_rep_dte <= 0 then if_due_repay_amt_larger_than_mdldte_risk_available_limit else null end) as ftr_due_repay_amt_larger_than_mdldte_risk_available_limit_count_sum,

from 
dwa_risk.dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_oline main_table
group by uid,mdl_dte;

drop table if exists dwa_risk.dwa_risk_dz_model_final_25_5_repay_cross_credit_limit_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_5_repay_cross_credit_limit_by_each_df as
select uid,mdl_dte,
-- 历史最大应还本金与评分日T-1日授信额度比值
a.his_max_due_prc_amt / rsk_adt_lmt_cash as his_max_due_prc_amt_divide_rsk_adt_lmt_cash,
a.d90_max_due_prc_amt / rsk_adt_lmt_cash as d90_max_due_prc_amt_divide_rsk_adt_lmt_cash,
a.d180_max_due_prc_amt / rsk_adt_lmt_cash as d180_max_due_prc_amt_divide_rsk_adt_lmt_cash,
a.d360_max_due_prc_amt / rsk_adt_lmt_cash as d360_max_due_prc_amt_divide_rsk_adt_lmt_cash,
a.d720_max_due_prc_amt / rsk_adt_lmt_cash as d720_max_due_prc_amt_divide_rsk_adt_lmt_cash,
a.d1080_max_due_prc_amt / rsk_adt_lmt_cash as d1080_max_due_prc_amt_divide_rsk_adt_lmt_cash,
-- 历史最大提前还款本金与评分日T-1日授信额度比值
a.his_max_adv_repay_amt / rsk_adt_lmt_cash as his_max_adv_repay_amt_divide_rsk_adt_lmt_cash,
a.d90_max_adv_repay_amt / rsk_adt_lmt_cash as d90_max_adv_repay_amt_divide_rsk_adt_lmt_cash,
a.d180_max_adv_repay_amt / rsk_adt_lmt_cash as d180_max_adv_repay_amt_divide_rsk_adt_lmt_cash,
a.d360_max_adv_repay_amt / rsk_adt_lmt_cash as d360_max_adv_repay_amt_divide_rsk_adt_lmt_cash,
a.d720_max_adv_repay_amt / rsk_adt_lmt_cash as d720_max_adv_repay_amt_divide_rsk_adt_lmt_cash,
a.d1080_max_adv_repay_amt / rsk_adt_lmt_cash as d1080_max_adv_repay_amt_divide_rsk_adt_lmt_cash,
-- 历史最大逾期还款本金与评分日T-1日授信额度比值
a.his_max_ovd_repay_amt / rsk_adt_lmt_cash as his_max_ovd_repay_amt_divide_rsk_adt_lmt_cash,
a.d90_max_ovd_repay_amt / rsk_adt_lmt_cash as d90_max_ovd_repay_amt_divide_rsk_adt_lmt_cash,
a.d180_max_ovd_repay_amt / rsk_adt_lmt_cash as d180_max_ovd_repay_amt_divide_rsk_adt_lmt_cash,
a.d360_max_ovd_repay_amt / rsk_adt_lmt_cash as d360_max_ovd_repay_amt_divide_rsk_adt_lmt_cash,
a.d720_max_ovd_repay_amt / rsk_adt_lmt_cash as d720_max_ovd_repay_amt_divide_rsk_adt_lmt_cash,
a.d1080_max_ovd_repay_amt / rsk_adt_lmt_cash as d1080_max_ovd_repay_amt_divide_rsk_adt_lmt_cash,

-- 历史最大应还本金与评分日T-1日可用额度比值
a.his_max_due_prc_amt / rsk_avl_lmt_cash as his_max_due_prc_amt_divide_rsk_avl_lmt_cash,
a.d90_max_due_prc_amt / rsk_avl_lmt_cash as d90_max_due_prc_amt_divide_rsk_avl_lmt_cash,
a.d180_max_due_prc_amt / rsk_avl_lmt_cash as d180_max_due_prc_amt_divide_rsk_avl_lmt_cash,
a.d360_max_due_prc_amt / rsk_avl_lmt_cash as d360_max_due_prc_amt_divide_rsk_avl_lmt_cash,
a.d720_max_due_prc_amt / rsk_avl_lmt_cash as d720_max_due_prc_amt_divide_rsk_avl_lmt_cash,
a.d1080_max_due_prc_amt / rsk_avl_lmt_cash as d1080_max_due_prc_amt_divide_rsk_avl_lmt_cash,
-- 历史最大提前还款本金与评分日T-1日可用额度比值
a.his_max_adv_repay_amt / rsk_avl_lmt_cash as his_max_adv_repay_amt_divide_rsk_avl_lmt_cash,
a.d90_max_adv_repay_amt / rsk_avl_lmt_cash as d90_max_adv_repay_amt_divide_rsk_avl_lmt_cash,
a.d180_max_adv_repay_amt / rsk_avl_lmt_cash as d180_max_adv_repay_amt_divide_rsk_avl_lmt_cash,
a.d360_max_adv_repay_amt / rsk_avl_lmt_cash as d360_max_adv_repay_amt_divide_rsk_avl_lmt_cash,
a.d720_max_adv_repay_amt / rsk_avl_lmt_cash as d720_max_adv_repay_amt_divide_rsk_avl_lmt_cash,
a.d1080_max_adv_repay_amt / rsk_avl_lmt_cash as d1080_max_adv_repay_amt_divide_rsk_avl_lmt_cash,
-- 历史最大逾期还款本金与评分日T-1日可用额度比值
a.his_max_ovd_repay_amt / rsk_avl_lmt_cash as his_max_ovd_repay_amt_divide_rsk_avl_lmt_cash,
a.d90_max_ovd_repay_amt / rsk_avl_lmt_cash as d90_max_ovd_repay_amt_divide_rsk_avl_lmt_cash,
a.d180_max_ovd_repay_amt / rsk_avl_lmt_cash as d180_max_ovd_repay_amt_divide_rsk_avl_lmt_cash,
a.d360_max_ovd_repay_amt / rsk_avl_lmt_cash as d360_max_ovd_repay_amt_divide_rsk_avl_lmt_cash,
a.d720_max_ovd_repay_amt / rsk_avl_lmt_cash as d720_max_ovd_repay_amt_divide_rsk_avl_lmt_cash,
a.d1080_max_ovd_repay_amt / rsk_avl_lmt_cash as d1080_max_ovd_repay_amt_divide_rsk_avl_lmt_cash

from 
dwa_risk.dwa_risk_inner_behaviour_all_repay_by_stg_aggregate_tmp_oline a;

-- 1.3.2 by月行为的维度交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_6_repay_cross_credit_limit_behaviour_by_mon_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_6_repay_cross_credit_limit_behaviour_by_mon_df as
select uid,mdl_dte,his_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d90_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d180_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d360_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d720_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d1080_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,his_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d90_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d180_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d360_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d720_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d1080_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,his_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d90_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d180_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d360_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d720_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d1080_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,his_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d90_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d180_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d360_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d720_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d1080_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,his_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d90_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d180_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d360_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d720_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,d1080_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,his_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d90_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d180_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d360_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d720_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,d1080_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,his_avg_due_pay_amt_sum_by_mon,d90_avg_due_pay_amt_sum_by_mon,d180_avg_due_pay_amt_sum_by_mon,d360_avg_due_pay_amt_sum_by_mon,d720_avg_due_pay_amt_sum_by_mon,d1080_avg_due_pay_amt_sum_by_mon, 
-- 历史平均月供除以当前授信额度
his_avg_due_pay_amt_sum_by_mon/rsk_adt_lmt_cash as his_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash,
d90_avg_due_pay_amt_sum_by_mon/rsk_adt_lmt_cash as d90_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash,
d180_avg_due_pay_amt_sum_by_mon/rsk_adt_lmt_cash as d180_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash,
d360_avg_due_pay_amt_sum_by_mon/rsk_adt_lmt_cash as d360_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash,
d720_avg_due_pay_amt_sum_by_mon/rsk_adt_lmt_cash as d720_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash,
d1080_avg_due_pay_amt_sum_by_mon/rsk_adt_lmt_cash as d1080_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash,

-- 历史平均月供除以当前可用额度
his_avg_due_pay_amt_sum_by_mon/rsk_avl_lmt_cash as his_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash,
d90_avg_due_pay_amt_sum_by_mon/rsk_avl_lmt_cash as d90_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash,
d180_avg_due_pay_amt_sum_by_mon/rsk_avl_lmt_cash as d180_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash,
d360_avg_due_pay_amt_sum_by_mon/rsk_avl_lmt_cash as d360_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash,
d720_avg_due_pay_amt_sum_by_mon/rsk_avl_lmt_cash as d720_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash,
d1080_avg_due_pay_amt_sum_by_mon/rsk_avl_lmt_cash as d1080_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash

from
        (
        select uid,mdl_dte,
        -- 月度按时还款总额比评分日T-1日可用额度高的月份数
        sum(case when ddf_mdl_dte_rep_mon >0 then if_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as his_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d90_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d180_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d360_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d720_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d1080_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        -- 月度按时还款总额比评分日T-1日授信额度高的月份数
        sum(case when ddf_mdl_dte_rep_mon >0 then if_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as his_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d90_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d180_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d360_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d720_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d1080_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,

        -- 月度逾期还款总额比评分日T-1日可用额度高的月份数
        sum(case when ddf_mdl_dte_rep_mon >0 then if_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as his_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d90_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d180_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d360_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d720_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d1080_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        -- 月度逾期还款总额比评分日T-1日授信额度高的月份数
        sum(case when ddf_mdl_dte_rep_mon >0 then if_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as his_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d90_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d180_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d360_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d720_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d1080_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,

        -- 月度提前还款总额比评分日T-1日可用额度高的月份数
        sum(case when ddf_mdl_dte_rep_mon >0 then if_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as his_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d90_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d180_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d360_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d720_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d1080_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
        -- 月度提前还款总额比评分日T-1日授信额度高的月份数
        sum(case when ddf_mdl_dte_rep_mon >0 then if_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as his_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then if_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d90_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then if_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d180_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then if_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d360_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then if_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d720_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
        sum(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then if_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d1080_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,

        max(rsk_adt_lmt_cash) as rsk_adt_lmt_cash, -- 评分日T-1日授信额度
        max(rsk_avl_lmt_cash) as rsk_avl_lmt_cash, -- 评分日T-1日可用额度

        -- 月度平均应还款金额
        avg(case when ddf_mdl_dte_rep_mon >0 then due_pay_amt_sum_mon else null end) as his_avg_due_pay_amt_sum_by_mon,
        avg(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 90 then due_pay_amt_sum_mon else null end) as d90_avg_due_pay_amt_sum_by_mon,
        avg(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 180 then due_pay_amt_sum_mon else null end) as d180_avg_due_pay_amt_sum_by_mon,
        avg(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 360 then due_pay_amt_sum_mon else null end) as d360_avg_due_pay_amt_sum_by_mon,
        avg(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 720 then due_pay_amt_sum_mon else null end) as d720_avg_due_pay_amt_sum_by_mon,
        avg(case when ddf_mdl_dte_rep_mon >0 and ddf_mdl_dte_rep_mon <= 1080 then due_pay_amt_sum_mon else null end) as d1080_avg_due_pay_amt_sum_by_mon

        from 
        dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline a
        group by uid,mdl_dte
        ) mid;

-- ************************ 2 借款与其他维度交叉 ************************ --
-- 2.1 借款内部交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_7_trade_behaviour_inner_cross_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_7_trade_behaviour_inner_cross_df as
select uid,mdl_dte,
-- 交易失败_交易成功_发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_trade_mon >0 then if_suc_fail_trade_in_same_month else null end) as his_suc_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_suc_fail_trade_in_same_month else null end) as d90_suc_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_suc_fail_trade_in_same_month else null end) as d180_suc_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_suc_fail_trade_in_same_month else null end) as d360_suc_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_suc_fail_trade_in_same_month else null end) as d720_suc_fail_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_suc_fail_trade_in_same_month else null end) as d1080_suc_fail_trade_in_same_month_count_sum,
-- 失败交易的本金比成功交易的本金要多的月份数
sum(case when ddf_mdl_dte_trade_mon >0 then if_fail_trade_large_than_suc_trade_amt_in_this_month else null end) as his_fail_trade_large_than_suc_trade_amt_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_fail_trade_large_than_suc_trade_amt_in_this_month else null end) as d90_fail_trade_large_than_suc_trade_amt_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_fail_trade_large_than_suc_trade_amt_in_this_month else null end) as d180_fail_trade_large_than_suc_trade_amt_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_fail_trade_large_than_suc_trade_amt_in_this_month else null end) as d360_fail_trade_large_than_suc_trade_amt_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_fail_trade_large_than_suc_trade_amt_in_this_month else null end) as d720_fail_trade_large_than_suc_trade_amt_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_fail_trade_large_than_suc_trade_amt_in_this_month else null end) as d1080_fail_trade_large_than_suc_trade_amt_count_sum,
-- 失败交易的期限比成功交易的期限要长的月份数
sum(case when ddf_mdl_dte_trade_mon >0 then if_fail_trade_large_than_suc_trade_stgnum_in_this_month else null end) as his_fail_trade_large_than_suc_trade_stgnum_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_fail_trade_large_than_suc_trade_stgnum_in_this_month else null end) as d90_fail_trade_large_than_suc_trade_stgnum_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_fail_trade_large_than_suc_trade_stgnum_in_this_month else null end) as d180_fail_trade_large_than_suc_trade_stgnum_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_fail_trade_large_than_suc_trade_stgnum_in_this_month else null end) as d360_fail_trade_large_than_suc_trade_stgnum_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_fail_trade_large_than_suc_trade_stgnum_in_this_month else null end) as d720_fail_trade_large_than_suc_trade_stgnum_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_fail_trade_large_than_suc_trade_stgnum_in_this_month else null end) as d1080_fail_trade_large_than_suc_trade_stgnum_count_sum,

-- 发起金额小于1000元_发起金额大于1w元_发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_trade_mon >0 then if_1000minus_10000plus_trade_in_same_month else null end) as his_1000minus_10000plus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_1000minus_10000plus_trade_in_same_month else null end) as d90_1000minus_10000plus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_1000minus_10000plus_trade_in_same_month else null end) as d180_1000minus_10000plus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_1000minus_10000plus_trade_in_same_month else null end) as d360_1000minus_10000plus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_1000minus_10000plus_trade_in_same_month else null end) as d720_1000minus_10000plus_trade_in_same_month_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_1000minus_10000plus_trade_in_same_month else null end) as d1080_1000minus_10000plus_trade_in_same_month_count_sum,
-- 1到4点发起_8到11点发起_发生在同一个月_的次数_总和
sum(case when ddf_mdl_dte_trade_mon >0 then if_1_4am_8_11am_trade_in_same_month else null end) as his_1_4am_8_11am_trade_in_same_monthh_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_1_4am_8_11am_trade_in_same_month else null end) as d90_1_4am_8_11am_trade_in_same_monthh_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_1_4am_8_11am_trade_in_same_month else null end) as d180_1_4am_8_11am_trade_in_same_monthh_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_1_4am_8_11am_trade_in_same_month else null end) as d360_1_4am_8_11am_trade_in_same_monthh_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_1_4am_8_11am_trade_in_same_month else null end) as d720_1_4am_8_11am_trade_in_same_monthh_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_1_4am_8_11am_trade_in_same_month else null end) as d1080_1_4am_8_11am_trade_in_same_monthh_count_sum,

-- 近XX个月_交易失败次数/近XX个月_交易成功次数
sum(case when ddf_mdl_dte_trade_mon >0 then trade_fail_count_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 then trade_success_count_mon else null end) as his_trade_fail_count_mon_divide_his_trade_success_count_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then trade_fail_count_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then trade_success_count_mon else null end) as d90_trade_fail_count_mon_divide_his_trade_success_count_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then trade_fail_count_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then trade_success_count_mon else null end) as d180_trade_fail_count_mon_divide_his_trade_success_count_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then trade_fail_count_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then trade_success_count_mon else null end) as d360_trade_fail_count_mon_divide_his_trade_success_count_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then trade_fail_count_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then trade_success_count_mon else null end) as d720_trade_fail_count_mon_divide_his_trade_success_count_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then trade_fail_count_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then trade_success_count_mon else null end) as d1080_trade_fail_count_mon_divide_his_trade_success_count_mon,

-- 近XX个月_交易失败期限均值/近XX个月_交易成功期限均值
avg(case when ddf_mdl_dte_trade_mon >0 then trade_fail_stgnum_avg_mon else null end)/avg(case when ddf_mdl_dte_trade_mon >0 then trade_success_stgnum_avg_mon else null end) as his_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon,
avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then trade_fail_stgnum_avg_mon else null end)/avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then trade_success_stgnum_avg_mon else null end) as d90_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon,
avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then trade_fail_stgnum_avg_mon else null end)/avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then trade_success_stgnum_avg_mon else null end) as d180_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon,
avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then trade_fail_stgnum_avg_mon else null end)/avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then trade_success_stgnum_avg_mon else null end) as d360_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon,
avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then trade_fail_stgnum_avg_mon else null end)/avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then trade_success_stgnum_avg_mon else null end) as d720_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon,
avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then trade_fail_stgnum_avg_mon else null end)/avg(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then trade_success_stgnum_avg_mon else null end) as d1080_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon,

-- 近XX个月_交易失败本金总和/近XX个月_交易成功本金总和
sum(case when ddf_mdl_dte_trade_mon >0 then trade_fail_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 then trade_success_amt_sum_mon else null end) as his_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then trade_fail_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then trade_success_amt_sum_mon else null end) as d90_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then trade_fail_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then trade_success_amt_sum_mon else null end) as d180_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then trade_fail_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then trade_success_amt_sum_mon else null end) as d360_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then trade_fail_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then trade_success_amt_sum_mon else null end) as d720_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then trade_fail_amt_sum_mon else null end)/sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then trade_success_amt_sum_mon else null end) as d1080_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon

from
dwa_risk.dwa_risk_inner_behaviour_all_trade_by_month_aggregate_tmp_oline
group by uid,mdl_dte;


-- 2.2 借款与额度交叉(理论上来说，可以参照还款的衍生方式刷一批变量出来)
-- 2.2.1 by笔行为的维度交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_8_trade_cross_credit_limit_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_8_trade_cross_credit_limit_by_each_df as
select uid,mdl_dte,
-- 历史每笔借款发起本金大于发起日T日授信额度的次数
sum(case when ddf_mdl_ord_crt_dte > 0 then if_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as his_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then if_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d90_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then if_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d180_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then if_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d360_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then if_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d720_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then if_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d1080_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum,
-- 历史每笔借款发起本金大于发起日T日可用额度的次数
sum(case when ddf_mdl_ord_crt_dte > 0 then if_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as his_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then if_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d90_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then if_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d180_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then if_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d360_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then if_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d720_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then if_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d1080_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum

from 
dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline main_table
group by uid,mdl_dte;

drop table if exists dwa_risk.dwa_risk_dz_model_final_25_9_trade_cross_credit_limit_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_9_trade_cross_credit_limit_by_each_df as
select uid,mdl_dte,
-- 历史最大发起本金与评分日T-1日授信额度比值
a.his_max_faqi_prc_amt / rsk_adt_lmt_cash as his_max_faqi_prc_amt_divide_rsk_adt_lmt_cash,
a.d90_max_faqi_prc_amt / rsk_adt_lmt_cash as d90_max_faqi_prc_amt_divide_rsk_adt_lmt_cash,
a.d180_max_faqi_prc_amt / rsk_adt_lmt_cash as d180_max_faqi_prc_amt_divide_rsk_adt_lmt_cash,
a.d360_max_faqi_prc_amt / rsk_adt_lmt_cash as d360_max_faqi_prc_amt_divide_rsk_adt_lmt_cash,
a.d720_max_faqi_prc_amt / rsk_adt_lmt_cash as d720_max_faqi_prc_amt_divide_rsk_adt_lmt_cash,
a.d1080_max_faqi_prc_amt / rsk_adt_lmt_cash as d1080_max_faqi_prc_amt_divide_rsk_adt_lmt_cash,

-- 历史最大发起本金与评分日T-1日可用额度比值
a.his_max_faqi_prc_amt / rsk_avl_lmt_cash as his_max_faqi_prc_amt_divide_rsk_avl_lmt_cash,
a.d90_max_faqi_prc_amt / rsk_avl_lmt_cash as d90_max_faqi_prc_amt_divide_rsk_avl_lmt_cash,
a.d180_max_faqi_prc_amt / rsk_avl_lmt_cash as d180_max_faqi_prc_amt_divide_rsk_avl_lmt_cash,
a.d360_max_faqi_prc_amt / rsk_avl_lmt_cash as d360_max_faqi_prc_amt_divide_rsk_avl_lmt_cash,
a.d720_max_faqi_prc_amt / rsk_avl_lmt_cash as d720_max_faqi_prc_amt_divide_rsk_avl_lmt_cash,
a.d1080_max_faqi_prc_amt / rsk_avl_lmt_cash as d1080_max_faqi_prc_amt_divide_rsk_avl_lmt_cash
from dwa_risk.dwa_risk_inner_behaviour_all_trade_by_ord_aggregate_tmp_oline a;

-- 2.2.2 by月行为的维度交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_10_trade_cross_credit_limit_behaviour_by_mon_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_10_trade_cross_credit_limit_behaviour_by_mon_df as
select uid,mdl_dte,
-- 历史月累计发起交易金额大于评分日T-1日可用额度的月份数
sum(case when ddf_mdl_dte_trade_mon >0 then if_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as his_faqi_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d90_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d180_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d360_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d720_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d1080_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
-- 历史月累计发起交易金额大于评分日T-1日授信额度高的月份数
sum(case when ddf_mdl_dte_trade_mon >0 then if_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as his_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d90_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d180_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d360_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d720_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d1080_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,

-- 历史月累计成功交易金额大于评分日T-1日可用额度的月份数
sum(case when ddf_mdl_dte_trade_mon >0 then if_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as his_success_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d90_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d180_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d360_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d720_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash else null end) as d1080_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum,
-- 历史月累计成功交易金额大于评分日T-1日授信额度高的月份数
sum(case when ddf_mdl_dte_trade_mon >0 then if_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as his_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 90 then if_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d90_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 180 then if_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d180_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 360 then if_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d360_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 720 then if_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d720_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
sum(case when ddf_mdl_dte_trade_mon >0 and ddf_mdl_dte_trade_mon <= 1080 then if_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash else null end) as d1080_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum

from 
dwa_risk.dwa_risk_inner_behaviour_all_trade_by_month_aggregate_tmp_oline a
group by uid,mdl_dte;

-- 2.3 借款与负债交叉
-- 借款维度表（细分到笔）左连接体现出负债信息的还款维度表（聚合到月），历史借款信息与历史切片负债信息对比。用于衍生此类的变量：近XX个月_每笔交易发起金额_大于_当月累计应还金额_的次数_总和
drop table if exists dwa_risk.dwa_risk_trade_cross_debate_behaviour_agregate_by_each_atomtable_oline;
create table if not exists dwa_risk.dwa_risk_trade_cross_debate_behaviour_agregate_by_each_atomtable_oline as
select trade.uid
,trade.mdl_dte
,trade.dtl_ord_no
--订单创建时间（日期格式）
,trade.crt_dte
,trade.same_month_flg
,trade.prc_amt
--间隔天数：用来限制借款行为的时间窗口期
,trade.ddf_mdl_ord_crt_dte
-- 是否该笔发起借款的本金大于所在月份逾期还款的本金总和（说明有借新还旧可能）
,case when prc_amt > ovd_amt_sum_mon then 1 when prc_amt <= ovd_amt_sum_mon then 0 else null end as if_faqi_trade_amt_larger_than_ovd_repay_amt_in_this_month
-- 是否该笔发起借款的本金大于所在月份应还款的本金总和（说明有借新还旧可能）
,case when prc_amt > due_pay_amt_sum_mon then 1 when prc_amt <= due_pay_amt_sum_mon then 0 else null end as if_faqi_trade_amt_larger_than_due_repay_amt_in_this_month
-- 是否该笔发起借款的本金大于历史未结清分期本金总和（说明有跑路、强烈借新还旧可能）
,case when prc_amt > unpaid_principal_tot_amt_t_day then 1 when prc_amt <= unpaid_principal_tot_amt_t_day then 0 else null end as if_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day

from
(
    select *, substr(crt_dte,1,7) as same_month_flg
    from dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline
) trade
left join
(
-- 发起借款时所在月份的月供
    select uid,mdl_dte, same_month_flg, ovd_amt_sum_mon, due_pay_amt_sum_mon
    from dwa_risk.dwa_risk_inner_behaviour_all_repay_by_month_aggregate_tmp_oline
) debate
on trade.uid = debate.uid and trade.mdl_dte = debate.mdl_dte and trade.same_month_flg = debate.same_month_flg;

-- 历史借款信息与历史切片负债信息交叉的变量：
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_11_trade_cross_debate_behaviour_agregate_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_11_trade_cross_debate_behaviour_agregate_by_each_df as
select uid,mdl_dte,
-- 历史发起本金大于所在月份逾期还款本金总和的次数
sum(case when ddf_mdl_ord_crt_dte > 0 then if_faqi_trade_amt_larger_than_ovd_repay_amt_in_this_month else null end) as his_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then if_faqi_trade_amt_larger_than_ovd_repay_amt_in_this_month else null end) as d90_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then if_faqi_trade_amt_larger_than_ovd_repay_amt_in_this_month else null end) as d180_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then if_faqi_trade_amt_larger_than_ovd_repay_amt_in_this_month else null end) as d360_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then if_faqi_trade_amt_larger_than_ovd_repay_amt_in_this_month else null end) as d720_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then if_faqi_trade_amt_larger_than_ovd_repay_amt_in_this_month else null end) as d1080_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum,

-- 历史发起本金大于所在月份应还款本金总和的次数
sum(case when ddf_mdl_ord_crt_dte > 0 then if_faqi_trade_amt_larger_than_due_repay_amt_in_this_month else null end) as his_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then if_faqi_trade_amt_larger_than_due_repay_amt_in_this_month else null end) as d90_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then if_faqi_trade_amt_larger_than_due_repay_amt_in_this_month else null end) as d180_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then if_faqi_trade_amt_larger_than_due_repay_amt_in_this_month else null end) as d360_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then if_faqi_trade_amt_larger_than_due_repay_amt_in_this_month else null end) as d720_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then if_faqi_trade_amt_larger_than_due_repay_amt_in_this_month else null end) as d1080_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum,

-- 历史发起本金大于发起前未结清分期计划本金总和的次数
sum(case when ddf_mdl_ord_crt_dte > 0 then if_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day else null end) as his_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then if_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day else null end) as d90_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then if_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day else null end) as d180_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then if_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day else null end) as d360_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then if_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day else null end) as d720_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum,
sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then if_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day else null end) as d1080_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum

from dwa_risk.dwa_risk_trade_cross_debate_behaviour_agregate_by_each_atomtable_oline basic
group by uid,mdl_dte;

-- 历史借款信息与评分日T-1日负债信息交叉的变量：
-- 聚合后的借款维度表（细分到笔），左连接用户负债情况原子表（评分日时未结清本金，历史至今最大月供）
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_12_trade_cross_debate_behaviour_agregate_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_12_trade_cross_debate_behaviour_agregate_by_each_df as
select a.uid,a.mdl_dte
-- 历史至今_发起借款金额最大值/评分日T-1日前历史至今最大月度逾期本金总计值
,a.his_max_faqi_prc_amt/b.max_ovd_amt_sum_mon as his_max_faqi_prc_amt_divide_max_ovd_amt_sum_mon
-- 历史至今_发起借款金额最大值/评分日T-1日前历史至今最大月度按时还款本金总计值
,a.his_max_faqi_prc_amt/b.max_ontim_amt_sum_mon as his_max_faqi_prc_amt_divide_max_ontim_amt_sum_mon
-- 历史至今_发起借款金额最大值/评分日T-1日前历史至今最大月度应还款本金总计值
,a.his_max_faqi_prc_amt/b.max_due_pay_amt_sum_mon as his_max_faqi_prc_amt_divide_max_due_pay_amt_sum_mon
-- 历史至今_发起借款金额最大值/评分日T-1日前未结清分期金额总和
,a.his_max_faqi_prc_amt/b.unpaid_principal_tot as his_max_faqi_prc_amt_divide_unpaid_principal_tot
from
(select uid, mdl_dte, his_max_faqi_prc_amt from dwa_risk.dwa_risk_inner_behaviour_all_trade_by_ord_aggregate_tmp_oline) a
left join
dwa_risk.dwa_risk_cross_inner_behaviour_debate_dimension_analysis_sample_oline b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte;

-- ************************ 3 额度与其他维度交叉 ************************ --
-- 3.1 额度与负债交叉
drop table if exists dwa_risk.dwa_risk_dz_model_final_25_13_credit_limit_cross_debate_behaviour_agregate_by_each_df;
create table if not exists dwa_risk.dwa_risk_dz_model_final_25_13_credit_limit_cross_debate_behaviour_agregate_by_each_df as
select uid,mdl_dte
        -- 历史T日未结清分期应还本金大于发起日T日授信额度的次数
        ,sum(case when ddf_mdl_ord_crt_dte > 0 then if_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as his_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then if_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d90_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then if_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d180_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then if_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d360_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then if_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d720_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then if_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day else null end) as d1080_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum

        -- 历史T日未结清分期应还本金大于发起日T日可用额度的次数
        ,sum(case when ddf_mdl_ord_crt_dte > 0 then if_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as his_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then if_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d90_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then if_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d180_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then if_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d360_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then if_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d720_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
        ,sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then if_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day else null end) as d1080_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum

        -- 历史T日未结清分期应还本金比上发起日T日授信额度的最大值
        ,max(case when ddf_mdl_ord_crt_dte > 0 then unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day else null end) as his_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day else null end) as d90_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day else null end) as d180_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day else null end) as d360_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day else null end) as d720_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day else null end) as d1080_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max

        -- 历史T日未结清分期应还本金比上发起日T日可用额度的最大值
        ,max(case when ddf_mdl_ord_crt_dte > 0 then unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day else null end) as his_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day else null end) as d90_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 180 then unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day else null end) as d180_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day else null end) as d360_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day else null end) as d720_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max
        ,max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 1080 then unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day else null end) as d1080_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max

from (
    select *
    ,unpaid_principal_tot_amt_t_day/rsk_adt_lmt_cash_his_t_day as unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day
    ,unpaid_principal_tot_amt_t_day/rsk_avl_lmt_cash_his_t_day as unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day
    from
    dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_oline)
group by uid,mdl_dte;

-- 将所有生成的变量join在一起
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_final_25_cross_inner_behaviour_df (
uid STRING comment 'uid',
mdl_dte STRING comment '评分日T日，yyyy-mm-dd',
his_ovdrepay_advrepay_in_same_month_count_sum bigint comment '历史至今_逾期还款与提前还款发生在同一个月的月份数_总和',
d90_ovdrepay_advrepay_in_same_month_count_sum bigint comment '近90天_逾期还款与提前还款发生在同一个月的月份数_总和',
d180_ovdrepay_advrepay_in_same_month_count_sum bigint comment '近180天_逾期还款与提前还款发生在同一个月的月份数_总和',
d360_ovdrepay_advrepay_in_same_month_count_sum bigint comment '近360天_逾期还款与提前还款发生在同一个月的月份数_总和',
d720_ovdrepay_advrepay_in_same_month_count_sum bigint comment '近720天_逾期还款与提前还款发生在同一个月的月份数_总和',
d1080_ovdrepay_advrepay_in_same_month_count_sum bigint comment '近1080天_逾期还款与提前还款发生在同一个月的月份数_总和',
his_ovdrepay_large_than_advrepay_amt_months_count_sum bigint comment '历史至今_逾期还款本金大于提前还款本金的月份数_总和',
d90_ovdrepay_large_than_advrepay_amt_months_count_sum bigint comment '近90天_逾期还款本金大于提前还款本金的月份数_总和',
d180_ovdrepay_large_than_advrepay_amt_months_count_sum bigint comment '近180天_逾期还款本金大于提前还款本金的月份数_总和',
d360_ovdrepay_large_than_advrepay_amt_months_count_sum bigint comment '近360天_逾期还款本金大于提前还款本金的月份数_总和',
d720_ovdrepay_large_than_advrepay_amt_months_count_sum bigint comment '近720天_逾期还款本金大于提前还款本金的月份数_总和',
d1080_ovdrepay_large_than_advrepay_amt_months_count_sum bigint comment '近1080天_逾期还款本金大于提前还款本金的月份数_总和',
his_ovdrepay_amt_sum_divide_advrepay_amt_sum decimal(38,18) comment '历史至今_逾期还款本金_总和/历史至今_提前还款本金_总和',
d90_ovdrepay_amt_sum_divide_advrepay_amt_sum decimal(38,18) comment '近90天_逾期还款本金_总和/近90天_提前还款本金_总和',
d180_ovdrepay_amt_sum_divide_advrepay_amt_sum decimal(38,18) comment '近180天_逾期还款本金_总和/近180天_提前还款本金_总和',
d360_ovdrepay_amt_sum_divide_advrepay_amt_sum decimal(38,18) comment '近360天_逾期还款本金_总和/近360天_提前还款本金_总和',
d720_ovdrepay_amt_sum_divide_advrepay_amt_sum decimal(38,18) comment '近720天_逾期还款本金_总和/近720天_提前还款本金_总和',
d1080_ovdrepay_amt_sum_divide_advrepay_amt_sum decimal(38,18) comment '近1080天_逾期还款本金_总和/近1080天_提前还款本金_总和',
his_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum decimal(38,18) comment '历史至今_逾期1到3天还款本金_总和/历史至今_提前3天及以内还款本金_总和',
d90_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum decimal(38,18) comment '近90天_逾期1到3天还款本金_总和/近90天_提前3天及以内还款本金_总和',
d180_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum decimal(38,18) comment '近180天_逾期1到3天还款本金_总和/近180天_提前3天及以内还款本金_总和',
d360_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum decimal(38,18) comment '近360天_逾期1到3天还款本金_总和/近360天_提前3天及以内还款本金_总和',
d720_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum decimal(38,18) comment '近720天_逾期1到3天还款本金_总和/近720天_提前3天及以内还款本金_总和',
d1080_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum decimal(38,18) comment '近1080天_逾期1到3天还款本金_总和/近1080天_提前3天及以内还款本金_总和',
his_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum decimal(38,18) comment '历史至今_逾期4到14天还款本金_总和/历史至今_提前15天及以内还款本金_总和',
d90_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum decimal(38,18) comment '近90天_逾期4到14天还款本金_总和/近90天_提前15天及以内还款本金_总和',
d180_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum decimal(38,18) comment '近180天_逾期4到14天还款本金_总和/近180天_提前15天及以内还款本金_总和',
d360_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum decimal(38,18) comment '近360天_逾期4到14天还款本金_总和/近360天_提前15天及以内还款本金_总和',
d720_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum decimal(38,18) comment '近720天_逾期4到14天还款本金_总和/近720天_提前15天及以内还款本金_总和',
d1080_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum decimal(38,18) comment '近1080天_逾期4到14天还款本金_总和/近1080天_提前15天及以内还款本金_总和',
his_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum decimal(38,18) comment '历史至今_逾期1个月及以上还款本金_总和/历史至今_提前1个月以内还款本金_总和',
d90_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum decimal(38,18) comment '近90天_逾期1个月及以上还款本金_总和/近90天_提前1个月以内还款本金_总和',
d180_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum decimal(38,18) comment '近180天_逾期1个月及以上还款本金_总和/近180天_提前1个月以内还款本金_总和',
d360_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum decimal(38,18) comment '近360天_逾期1个月及以上还款本金_总和/近360天_提前1个月以内还款本金_总和',
d720_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum decimal(38,18) comment '近720天_逾期1个月及以上还款本金_总和/近720天_提前1个月以内还款本金_总和',
d1080_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum decimal(38,18) comment '近1080天_逾期1个月及以上还款本金_总和/近1080天_提前1个月以内还款本金_总和',
his_ovdrepay_ontimrepay_in_same_month_count_sum bigint comment '历史至今_逾期还款与按时还款发生在同一个月的月份数_总和',
d90_ovdrepay_ontimrepay_in_same_month_count_sum bigint comment '近90天_逾期还款与按时还款发生在同一个月的月份数_总和',
d180_ovdrepay_ontimrepay_in_same_month_count_sum bigint comment '近180天_逾期还款与按时还款发生在同一个月的月份数_总和',
d360_ovdrepay_ontimrepay_in_same_month_count_sum bigint comment '近360天_逾期还款与按时还款发生在同一个月的月份数_总和',
d720_ovdrepay_ontimrepay_in_same_month_count_sum bigint comment '近720天_逾期还款与按时还款发生在同一个月的月份数_总和',
d1080_ovdrepay_ontimrepay_in_same_month_count_sum bigint comment '近1080天_逾期还款与按时还款发生在同一个月的月份数_总和',
his_ovdrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '历史至今_逾期还款本金大于按时还款本金的月份数_总和',
d90_ovdrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近90天_逾期还款本金大于按时还款本金的月份数_总和',
d180_ovdrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近180天_逾期还款本金大于按时还款本金的月份数_总和',
d360_ovdrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近360天_逾期还款本金大于按时还款本金的月份数_总和',
d720_ovdrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近720天_逾期还款本金大于按时还款本金的月份数_总和',
d1080_ovdrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近1080天_逾期还款本金大于按时还款本金的月份数_总和',
his_ovdrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '历史至今_逾期还款本金_总和/历史至今_按时还款本金_总和',
d90_ovdrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近90天_逾期还款本金_总和/近90天_按时还款本金_总和',
d180_ovdrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近180天_逾期还款本金_总和/近180天_按时还款本金_总和',
d360_ovdrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近360天_逾期还款本金_总和/近360天_按时还款本金_总和',
d720_ovdrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近720天_逾期还款本金_总和/近720天_按时还款本金_总和',
d1080_ovdrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近1080天_逾期还款本金_总和/近1080天_按时还款本金_总和',
his_advrepay_ontimrepay_in_same_month_count_sum bigint comment '历史至今_按时还款与提前还款发生在同一个月的月份数_总和',
d90_advrepay_ontimrepay_in_same_month_count_sum bigint comment '近90天_按时还款与提前还款发生在同一个月的月份数_总和',
d180_advrepay_ontimrepay_in_same_month_count_sum bigint comment '近180天_按时还款与提前还款发生在同一个月的月份数_总和',
d360_advrepay_ontimrepay_in_same_month_count_sum bigint comment '近360天_按时还款与提前还款发生在同一个月的月份数_总和',
d720_advrepay_ontimrepay_in_same_month_count_sum bigint comment '近720天_按时还款与提前还款发生在同一个月的月份数_总和',
d1080_advrepay_ontimrepay_in_same_month_count_sum bigint comment '近1080天_按时还款与提前还款发生在同一个月的月份数_总和',
his_advrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '历史至今_提前还款本金大于按时还款本金的月份数_总和',
d90_advrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近90天_提前还款本金大于按时还款本金的月份数_总和',
d180_advrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近180天_提前还款本金大于按时还款本金的月份数_总和',
d360_advrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近360天_提前还款本金大于按时还款本金的月份数_总和',
d720_advrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近720天_提前还款本金大于按时还款本金的月份数_总和',
d1080_advrepay_large_than_ontimrepay_amt_months_count_sum bigint comment '近1080天_提前还款本金大于按时还款本金的月份数_总和',
his_advrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '历史至今_提前还款本金_总和/历史至今_按时还款本金_总和',
d90_advrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近90天_提前还款本金_总和/近90天_按时还款本金_总和',
d180_advrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近180天_提前还款本金_总和/近180天_按时还款本金_总和',
d360_advrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近360天_提前还款本金_总和/近360天_按时还款本金_总和',
d720_advrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近720天_提前还款本金_总和/近720天_按时还款本金_总和',
d1080_advrepay_amt_sum_divide_ontimrepay_amt_sum decimal(38,18) comment '近1080天_提前还款本金_总和/近1080天_按时还款本金_总和',
his_ovdrepay_fail_trade_in_same_month_count_sum bigint comment '历史至今_交易失败与逾期还款发生在同一个月的月份数_总和',
d90_ovdrepay_fail_trade_in_same_month_count_sum bigint comment '近90天_交易失败与逾期还款发生在同一个月的月份数_总和',
d180_ovdrepay_fail_trade_in_same_month_count_sum bigint comment '近180天_交易失败与逾期还款发生在同一个月的月份数_总和',
d360_ovdrepay_fail_trade_in_same_month_count_sum bigint comment '近360天_交易失败与逾期还款发生在同一个月的月份数_总和',
d720_ovdrepay_fail_trade_in_same_month_count_sum bigint comment '近720天_交易失败与逾期还款发生在同一个月的月份数_总和',
d1080_ovdrepay_fail_trade_in_same_month_count_sum bigint comment '近1080天_交易失败与逾期还款发生在同一个月的月份数_总和',
his_advrepay_suc_trade_in_same_month_count_sum bigint comment '历史至今_交易成功与提前还款发生在同一个月的月份数_总和',
d90_advrepay_suc_trade_in_same_month_count_sum bigint comment '近90天_交易成功与提前还款发生在同一个月的月份数_总和',
d180_advrepay_suc_trade_in_same_month_count_sum bigint comment '近180天_交易成功与提前还款发生在同一个月的月份数_总和',
d360_advrepay_suc_trade_in_same_month_count_sum bigint comment '近360天_交易成功与提前还款发生在同一个月的月份数_总和',
d720_advrepay_suc_trade_in_same_month_count_sum bigint comment '近720天_交易成功与提前还款发生在同一个月的月份数_总和',
d1080_advrepay_suc_trade_in_same_month_count_sum bigint comment '近1080天_交易成功与提前还款发生在同一个月的月份数_总和',
his_ovdrepay_suc_trade_in_same_month_count_sum bigint comment '历史至今_交易成功与逾期还款发生在同一个月的月份数_总和',
d90_ovdrepay_suc_trade_in_same_month_count_sum bigint comment '近90天_交易成功与逾期还款发生在同一个月的月份数_总和',
d180_ovdrepay_suc_trade_in_same_month_count_sum bigint comment '近180天_交易成功与逾期还款发生在同一个月的月份数_总和',
d360_ovdrepay_suc_trade_in_same_month_count_sum bigint comment '近360天_交易成功与逾期还款发生在同一个月的月份数_总和',
d720_ovdrepay_suc_trade_in_same_month_count_sum bigint comment '近720天_交易成功与逾期还款发生在同一个月的月份数_总和',
d1080_ovdrepay_suc_trade_in_same_month_count_sum bigint comment '近1080天_交易成功与逾期还款发生在同一个月的月份数_总和',
his_ovdrepay_1_4am_trade_in_same_month_count_sum bigint comment '历史至今_1-4点借款与逾期还款发生在同一个月的月份数_总和',
d90_ovdrepay_1_4am_trade_in_same_month_count_sum bigint comment '近90天_1-4点借款与逾期还款发生在同一个月的月份数_总和',
d180_ovdrepay_1_4am_trade_in_same_month_count_sum bigint comment '近180天_1-4点借款与逾期还款发生在同一个月的月份数_总和',
d360_ovdrepay_1_4am_trade_in_same_month_count_sum bigint comment '近360天_1-4点借款与逾期还款发生在同一个月的月份数_总和',
d720_ovdrepay_1_4am_trade_in_same_month_count_sum bigint comment '近720天_1-4点借款与逾期还款发生在同一个月的月份数_总和',
d1080_ovdrepay_1_4am_trade_in_same_month_count_sum bigint comment '近1080天_1-4点借款与逾期还款发生在同一个月的月份数_总和',
his_ovdrepay_1wplus_trade_in_same_month_count_sum bigint comment '历史至今_发起本金大于10000元与逾期还款发生在同一个月的月份数_总和',
d90_ovdrepay_1wplus_trade_in_same_month_count_sum bigint comment '近90天_发起本金大于10000元与逾期还款发生在同一个月的月份数_总和',
d180_ovdrepay_1wplus_trade_in_same_month_count_sum bigint comment '近180天_发起本金大于10000元与逾期还款发生在同一个月的月份数_总和',
d360_ovdrepay_1wplus_trade_in_same_month_count_sum bigint comment '近360天_发起本金大于10000元与逾期还款发生在同一个月的月份数_总和',
d720_ovdrepay_1wplus_trade_in_same_month_count_sum bigint comment '近720天_发起本金大于10000元与逾期还款发生在同一个月的月份数_总和',
d1080_ovdrepay_1wplus_trade_in_same_month_count_sum bigint comment '近1080天_发起本金大于10000元与逾期还款发生在同一个月的月份数_总和',
his_due_repay_amt_sum_divide_his_faqi_trade_amt_sum decimal(38,18) comment '历史至今_每个月待还款本金_总和/历史至今_每个月发起借款本金_总和',
d90_due_repay_amt_sum_divide_d90_faqi_trade_amt_sum decimal(38,18) comment '近90天_每个月待还款本金_总和/近90天_每个月发起借款本金_总和',
d180_due_repay_amt_sum_divide_d180_faqi_trade_amt_sum decimal(38,18) comment '近180天_每个月待还款本金_总和/近180天_每个月发起借款本金_总和',
d360_due_repay_amt_sum_divide_d360_faqi_trade_amt_sum decimal(38,18) comment '近360天_每个月待还款本金_总和/近360天_每个月发起借款本金_总和',
d720_due_repay_amt_sum_divide_d720_faqi_trade_amt_sum decimal(38,18) comment '近720天_每个月待还款本金_总和/近720天_每个月发起借款本金_总和',
d1080_due_repay_amt_sum_divide_d1080_faqi_trade_amt_sum decimal(38,18) comment '近1080天_每个月待还款本金_总和/近1080天_每个月发起借款本金_总和',
his_due_repay_amt_avg_divide_his_faqi_trade_amt_avg decimal(38,18) comment '历史至今_每个月待还款本金_平均值/历史至今_每个月发起借款本金_平均值',
d90_due_repay_amt_avg_divide_d90_faqi_trade_amt_avg decimal(38,18) comment '近90天_每个月待还款本金_平均值/近90天_每个月发起借款本金_平均值',
d180_due_repay_amt_avg_divide_d180_faqi_trade_amt_avg decimal(38,18) comment '近180天_每个月待还款本金_平均值/近180天_每个月发起借款本金_平均值',
d360_due_repay_amt_avg_divide_d360_faqi_trade_amt_avg decimal(38,18) comment '近360天_每个月待还款本金_平均值/近360天_每个月发起借款本金_平均值',
d720_due_repay_amt_avg_divide_d720_faqi_trade_amt_avg decimal(38,18) comment '近720天_每个月待还款本金_平均值/近720天_每个月发起借款本金_平均值',
d1080_due_repay_amt_avg_divide_d1080_faqi_trade_amt_avg decimal(38,18) comment '近1080天_每个月待还款本金_平均值/近1080天_每个月发起借款本金_平均值',
his_max_due_prc_amt_divide_his_max_faqi_prc_amt decimal(38,18) comment '历史至今_单笔待还款本金_最大值/历史至今_单笔发起借款本金_最大值',
d90_max_due_prc_amt_divide_d90_max_faqi_prc_amt decimal(38,18) comment '近90天_单笔待还款本金_最大值/近90天_单笔发起借款本金_最大值',
d180_max_due_prc_amt_divide_d180_max_faqi_prc_amt decimal(38,18) comment '近180天_单笔待还款本金_最大值/近180天_单笔发起借款本金_最大值',
d360_max_due_prc_amt_divide_d360_max_faqi_prc_amt decimal(38,18) comment '近360天_单笔待还款本金_最大值/近360天_单笔发起借款本金_最大值',
d720_max_due_prc_amt_divide_d720_max_faqi_prc_amt decimal(38,18) comment '近720天_单笔待还款本金_最大值/近720天_单笔发起借款本金_最大值',
d1080_max_due_prc_amt_divide_d1080_max_faqi_prc_amt decimal(38,18) comment '近1080天_单笔待还款本金_最大值/近1080天_单笔发起借款本金_最大值',
his_max_adv_repay_amt_divide_his_max_faqi_prc_amt decimal(38,18) comment '历史至今_单笔提前还款本金_最大值/历史至今_单笔发起借款本金_最大值',
d90_max_adv_repay_amt_divide_d90_max_faqi_prc_amt decimal(38,18) comment '近90天_单笔提前还款本金_最大值/近90天_单笔发起借款本金_最大值',
d180_max_adv_repay_amt_divide_d180_max_faqi_prc_amt decimal(38,18) comment '近180天_单笔提前还款本金_最大值/近180天_单笔发起借款本金_最大值',
d360_max_adv_repay_amt_divide_d360_max_faqi_prc_amt decimal(38,18) comment '近360天_单笔提前还款本金_最大值/近360天_单笔发起借款本金_最大值',
d720_max_adv_repay_amt_divide_d720_max_faqi_prc_amt decimal(38,18) comment '近720天_单笔提前还款本金_最大值/近720天_单笔发起借款本金_最大值',
d1080_max_adv_repay_amt_divide_d1080_max_faqi_prc_amt decimal(38,18) comment '近1080天_单笔提前还款本金_最大值/近1080天_单笔发起借款本金_最大值',
his_max_ovd_repay_amt_divide_his_max_suc_prc_amt decimal(38,18) comment '历史至今_单笔逾期还款本金_最大值/历史至今_单笔成功借款本金_最大值',
d90_max_ovd_repay_amt_divide_d90_max_suc_prc_amt decimal(38,18) comment '近90天_单笔逾期还款本金_最大值/近90天_单笔成功借款本金_最大值',
d180_max_ovd_repay_amt_divide_d180_max_suc_prc_amt decimal(38,18) comment '近180天_单笔逾期还款本金_最大值/近180天_单笔成功借款本金_最大值',
d360_max_ovd_repay_amt_divide_d360_max_suc_prc_amt decimal(38,18) comment '近360天_单笔逾期还款本金_最大值/近360天_单笔成功借款本金_最大值',
d720_max_ovd_repay_amt_divide_d720_max_suc_prc_amt decimal(38,18) comment '近720天_单笔逾期还款本金_最大值/近720天_单笔成功借款本金_最大值',
d1080_max_ovd_repay_amt_divide_d1080_max_suc_prc_amt decimal(38,18) comment '近1080天_单笔逾期还款本金_最大值/近1080天_单笔成功借款本金_最大值',
his_max_ovd_repay_amt_divide_his_max_fail_prc_amt decimal(38,18) comment '历史至今_单笔逾期还款本金_最大值/历史至今_单笔失败借款本金_最大值',
d90_max_ovd_repay_amt_divide_d90_max_fail_prc_amt decimal(38,18) comment '近90天_单笔逾期还款本金_最大值/近90天_单笔失败借款本金_最大值',
d180_max_ovd_repay_amt_divide_d180_max_fail_prc_amt decimal(38,18) comment '近180天_单笔逾期还款本金_最大值/近180天_单笔失败借款本金_最大值',
d360_max_ovd_repay_amt_divide_d360_max_fail_prc_amt decimal(38,18) comment '近360天_单笔逾期还款本金_最大值/近360天_单笔失败借款本金_最大值',
d720_max_ovd_repay_amt_divide_d720_max_fail_prc_amt decimal(38,18) comment '近720天_单笔逾期还款本金_最大值/近720天_单笔失败借款本金_最大值',
d1080_max_ovd_repay_amt_divide_d1080_max_fail_prc_amt decimal(38,18) comment '近1080天_单笔逾期还款本金_最大值/近1080天_单笔失败借款本金_最大值',
his_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '历史至今_单笔待还款本金大于待还款日(T日)授信额度的笔数_总和',
d90_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近90天_单笔待还款本金大于待还款日(T日)授信额度的笔数_总和',
d180_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近180天_单笔待还款本金大于待还款日(T日)授信额度的笔数_总和',
d360_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近360天_单笔待还款本金大于待还款日(T日)授信额度的笔数_总和',
d720_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近720天_单笔待还款本金大于待还款日(T日)授信额度的笔数_总和',
d1080_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近1080天_单笔待还款本金大于待还款日(T日)授信额度的笔数_总和',
his_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '历史至今_单笔待还款本金大于待还款日(T日)可用额度的笔数_总和',
d90_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近90天_单笔待还款本金大于待还款日(T日)可用额度的笔数_总和',
d180_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近180天_单笔待还款本金大于待还款日(T日)可用额度的笔数_总和',
d360_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近360天_单笔待还款本金大于待还款日(T日)可用额度的笔数_总和',
d720_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近720天_单笔待还款本金大于待还款日(T日)可用额度的笔数_总和',
d1080_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近1080天_单笔待还款本金大于待还款日(T日)可用额度的笔数_总和',
his_max_due_prc_amt_divide_rsk_adt_lmt_cash double comment '历史至今_单笔待还款本金_最大值/评分日T-1日授信额度',
d90_max_due_prc_amt_divide_rsk_adt_lmt_cash double comment '近90天_单笔待还款本金_最大值/评分日T-1日授信额度',
d180_max_due_prc_amt_divide_rsk_adt_lmt_cash double comment '近180天_单笔待还款本金_最大值/评分日T-1日授信额度',
d360_max_due_prc_amt_divide_rsk_adt_lmt_cash double comment '近360天_单笔待还款本金_最大值/评分日T-1日授信额度',
d720_max_due_prc_amt_divide_rsk_adt_lmt_cash double comment '近720天_单笔待还款本金_最大值/评分日T-1日授信额度',
d1080_max_due_prc_amt_divide_rsk_adt_lmt_cash double comment '近1080天_单笔待还款本金_最大值/评分日T-1日授信额度',
his_max_adv_repay_amt_divide_rsk_adt_lmt_cash double comment '历史至今_单笔提前还款本金_最大值/评分日T-1日授信额度',
d90_max_adv_repay_amt_divide_rsk_adt_lmt_cash double comment '近90天_单笔提前还款本金_最大值/评分日T-1日授信额度',
d180_max_adv_repay_amt_divide_rsk_adt_lmt_cash double comment '近180天_单笔提前还款本金_最大值/评分日T-1日授信额度',
d360_max_adv_repay_amt_divide_rsk_adt_lmt_cash double comment '近360天_单笔提前还款本金_最大值/评分日T-1日授信额度',
d720_max_adv_repay_amt_divide_rsk_adt_lmt_cash double comment '近720天_单笔提前还款本金_最大值/评分日T-1日授信额度',
d1080_max_adv_repay_amt_divide_rsk_adt_lmt_cash double comment '近1080天_单笔提前还款本金_最大值/评分日T-1日授信额度',
his_max_ovd_repay_amt_divide_rsk_adt_lmt_cash double comment '历史至今_单笔逾期还款本金_最大值/评分日T-1日授信额度',
d90_max_ovd_repay_amt_divide_rsk_adt_lmt_cash double comment '近90天_单笔逾期还款本金_最大值/评分日T-1日授信额度',
d180_max_ovd_repay_amt_divide_rsk_adt_lmt_cash double comment '近180天_单笔逾期还款本金_最大值/评分日T-1日授信额度',
d360_max_ovd_repay_amt_divide_rsk_adt_lmt_cash double comment '近360天_单笔逾期还款本金_最大值/评分日T-1日授信额度',
d720_max_ovd_repay_amt_divide_rsk_adt_lmt_cash double comment '近720天_单笔逾期还款本金_最大值/评分日T-1日授信额度',
d1080_max_ovd_repay_amt_divide_rsk_adt_lmt_cash double comment '近1080天_单笔逾期还款本金_最大值/评分日T-1日授信额度',
his_max_due_prc_amt_divide_rsk_avl_lmt_cash double comment '历史至今_单笔待还款本金_最大值/评分日T-1日可用额度',
d90_max_due_prc_amt_divide_rsk_avl_lmt_cash double comment '近90天_单笔待还款本金_最大值/评分日T-1日可用额度',
d180_max_due_prc_amt_divide_rsk_avl_lmt_cash double comment '近180天_单笔待还款本金_最大值/评分日T-1日可用额度',
d360_max_due_prc_amt_divide_rsk_avl_lmt_cash double comment '近360天_单笔待还款本金_最大值/评分日T-1日可用额度',
d720_max_due_prc_amt_divide_rsk_avl_lmt_cash double comment '近720天_单笔待还款本金_最大值/评分日T-1日可用额度',
d1080_max_due_prc_amt_divide_rsk_avl_lmt_cash double comment '近1080天_单笔待还款本金_最大值/评分日T-1日可用额度',
his_max_adv_repay_amt_divide_rsk_avl_lmt_cash double comment '历史至今_单笔提前还款本金_最大值/评分日T-1日可用额度',
d90_max_adv_repay_amt_divide_rsk_avl_lmt_cash double comment '近90天_单笔提前还款本金_最大值/评分日T-1日可用额度',
d180_max_adv_repay_amt_divide_rsk_avl_lmt_cash double comment '近180天_单笔提前还款本金_最大值/评分日T-1日可用额度',
d360_max_adv_repay_amt_divide_rsk_avl_lmt_cash double comment '近360天_单笔提前还款本金_最大值/评分日T-1日可用额度',
d720_max_adv_repay_amt_divide_rsk_avl_lmt_cash double comment '近720天_单笔提前还款本金_最大值/评分日T-1日可用额度',
d1080_max_adv_repay_amt_divide_rsk_avl_lmt_cash double comment '近1080天_单笔提前还款本金_最大值/评分日T-1日可用额度',
his_max_ovd_repay_amt_divide_rsk_avl_lmt_cash double comment '历史至今_单笔逾期还款本金_最大值/评分日T-1日可用额度',
d90_max_ovd_repay_amt_divide_rsk_avl_lmt_cash double comment '近90天_单笔逾期还款本金_最大值/评分日T-1日可用额度',
d180_max_ovd_repay_amt_divide_rsk_avl_lmt_cash double comment '近180天_单笔逾期还款本金_最大值/评分日T-1日可用额度',
d360_max_ovd_repay_amt_divide_rsk_avl_lmt_cash double comment '近360天_单笔逾期还款本金_最大值/评分日T-1日可用额度',
d720_max_ovd_repay_amt_divide_rsk_avl_lmt_cash double comment '近720天_单笔逾期还款本金_最大值/评分日T-1日可用额度',
d1080_max_ovd_repay_amt_divide_rsk_avl_lmt_cash double comment '近1080天_单笔逾期还款本金_最大值/评分日T-1日可用额度',
his_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '历史至今_月度按时还款本金总额比评分日T-1日可用额度高的月份数_总和',
d90_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近90天_月度按时还款本金总额比评分日T-1日可用额度高的月份数_总和',
d180_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近180天_月度按时还款本金总额比评分日T-1日可用额度高的月份数_总和',
d360_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近360天_月度按时还款本金总额比评分日T-1日可用额度高的月份数_总和',
d720_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近720天_月度按时还款本金总额比评分日T-1日可用额度高的月份数_总和',
d1080_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近1080天_月度按时还款本金总额比评分日T-1日可用额度高的月份数_总和',
his_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '历史至今_月度按时还款本金总额比评分日T-1日授信额度高的月份数_总和',
d90_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近90天_月度按时还款本金总额比评分日T-1日授信额度高的月份数_总和',
d180_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近180天_月度按时还款本金总额比评分日T-1日授信额度高的月份数_总和',
d360_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近360天_月度按时还款本金总额比评分日T-1日授信额度高的月份数_总和',
d720_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近720天_月度按时还款本金总额比评分日T-1日授信额度高的月份数_总和',
d1080_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近1080天_月度按时还款本金总额比评分日T-1日授信额度高的月份数_总和',
his_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '历史至今_月度逾期还款本金总额比评分日T-1日可用额度高的月份数_总和',
d90_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近90天_月度逾期还款本金总额比评分日T-1日可用额度高的月份数_总和',
d180_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近180天_月度逾期还款本金总额比评分日T-1日可用额度高的月份数_总和',
d360_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近360天_月度逾期还款本金总额比评分日T-1日可用额度高的月份数_总和',
d720_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近720天_月度逾期还款本金总额比评分日T-1日可用额度高的月份数_总和',
d1080_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近1080天_月度逾期还款本金总额比评分日T-1日可用额度高的月份数_总和',
his_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '历史至今_月度逾期还款本金总额比评分日T-1日授信额度高的月份数_总和',
d90_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近90天_月度逾期还款本金总额比评分日T-1日授信额度高的月份数_总和',
d180_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近180天_月度逾期还款本金总额比评分日T-1日授信额度高的月份数_总和',
d360_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近360天_月度逾期还款本金总额比评分日T-1日授信额度高的月份数_总和',
d720_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近720天_月度逾期还款本金总额比评分日T-1日授信额度高的月份数_总和',
d1080_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近1080天_月度逾期还款本金总额比评分日T-1日授信额度高的月份数_总和',
his_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '历史至今_月度提前还款本金总额比评分日T-1日可用额度高的月份数_总和',
d90_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近90天_月度提前还款本金总额比评分日T-1日可用额度高的月份数_总和',
d180_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近180天_月度提前还款本金总额比评分日T-1日可用额度高的月份数_总和',
d360_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近360天_月度提前还款本金总额比评分日T-1日可用额度高的月份数_总和',
d720_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近720天_月度提前还款本金总额比评分日T-1日可用额度高的月份数_总和',
d1080_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近1080天_月度提前还款本金总额比评分日T-1日可用额度高的月份数_总和',
his_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '历史至今_月度提前还款本金总额比评分日T-1日授信额度高的月份数_总和',
d90_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近90天_月度提前还款本金总额比评分日T-1日授信额度高的月份数_总和',
d180_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近180天_月度提前还款本金总额比评分日T-1日授信额度高的月份数_总和',
d360_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近360天_月度提前还款本金总额比评分日T-1日授信额度高的月份数_总和',
d720_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近720天_月度提前还款本金总额比评分日T-1日授信额度高的月份数_总和',
d1080_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近1080天_月度提前还款本金总额比评分日T-1日授信额度高的月份数_总和',
his_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash double comment '历史至今_月度应还款本金_平均值/评分日T-1日可用额度',
d90_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash double comment '近90天_月度应还款本金_平均值/评分日T-1日可用额度',
d180_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash double comment '近180天_月度应还款本金_平均值/评分日T-1日可用额度',
d360_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash double comment '近360天_月度应还款本金_平均值/评分日T-1日可用额度',
d720_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash double comment '近720天_月度应还款本金_平均值/评分日T-1日可用额度',
d1080_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash double comment '近1080天_月度应还款本金_平均值/评分日T-1日可用额度',
his_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash double comment '历史至今_月度应还款本金_平均值/评分日T-1日授信额度',
d90_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash double comment '近90天_月度应还款本金_平均值/评分日T-1日授信额度',
d180_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash double comment '近180天_月度应还款本金_平均值/评分日T-1日授信额度',
d360_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash double comment '近360天_月度应还款本金_平均值/评分日T-1日授信额度',
d720_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash double comment '近720天_月度应还款本金_平均值/评分日T-1日授信额度',
d1080_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash double comment '近1080天_月度应还款本金_平均值/评分日T-1日授信额度',
his_suc_fail_trade_in_same_month_count_sum bigint comment '历史至今_交易失败与交易成功发生在同一个月的月份数_总和',
d90_suc_fail_trade_in_same_month_count_sum bigint comment '近90天_交易失败与交易成功发生在同一个月的月份数_总和',
d180_suc_fail_trade_in_same_month_count_sum bigint comment '近180天_交易失败与交易成功发生在同一个月的月份数_总和',
d360_suc_fail_trade_in_same_month_count_sum bigint comment '近360天_交易失败与交易成功发生在同一个月的月份数_总和',
d720_suc_fail_trade_in_same_month_count_sum bigint comment '近720天_交易失败与交易成功发生在同一个月的月份数_总和',
d1080_suc_fail_trade_in_same_month_count_sum bigint comment '近1080天_交易失败与交易成功发生在同一个月的月份数_总和',
his_fail_trade_large_than_suc_trade_amt_count_sum bigint comment '历史至今_月度失败交易的本金比成功交易的本金要多的月份数_总和',
d90_fail_trade_large_than_suc_trade_amt_count_sum bigint comment '近90天_月度失败交易的本金比成功交易的本金要多的月份数_总和',
d180_fail_trade_large_than_suc_trade_amt_count_sum bigint comment '近180天_月度失败交易的本金比成功交易的本金要多的月份数_总和',
d360_fail_trade_large_than_suc_trade_amt_count_sum bigint comment '近360天_月度失败交易的本金比成功交易的本金要多的月份数_总和',
d720_fail_trade_large_than_suc_trade_amt_count_sum bigint comment '近720天_月度失败交易的本金比成功交易的本金要多的月份数_总和',
d1080_fail_trade_large_than_suc_trade_amt_count_sum bigint comment '近1080天_月度失败交易的本金比成功交易的本金要多的月份数_总和',
his_fail_trade_large_than_suc_trade_stgnum_count_sum bigint comment '历史至今_月度失败交易的平均期限比成功交易的平均期限要长的月份数_总和',
d90_fail_trade_large_than_suc_trade_stgnum_count_sum bigint comment '近90天_月度失败交易的平均期限比成功交易的平均期限要长的月份数_总和',
d180_fail_trade_large_than_suc_trade_stgnum_count_sum bigint comment '近180天_月度失败交易的平均期限比成功交易的平均期限要长的月份数_总和',
d360_fail_trade_large_than_suc_trade_stgnum_count_sum bigint comment '近360天_月度失败交易的平均期限比成功交易的平均期限要长的月份数_总和',
d720_fail_trade_large_than_suc_trade_stgnum_count_sum bigint comment '近720天_月度失败交易的平均期限比成功交易的平均期限要长的月份数_总和',
d1080_fail_trade_large_than_suc_trade_stgnum_count_sum bigint comment '近1080天_月度失败交易的平均期限比成功交易的平均期限要长的月份数_总和',
his_1000minus_10000plus_trade_in_same_month_count_sum bigint comment '历史至今_发起金额小于1000元与发起金额大于1w元_发生在同一个月的月份数_总和',
d90_1000minus_10000plus_trade_in_same_month_count_sum bigint comment '近90天_发起金额小于1000元与发起金额大于1w元_发生在同一个月的月份数_总和',
d180_1000minus_10000plus_trade_in_same_month_count_sum bigint comment '近180天_发起金额小于1000元与发起金额大于1w元_发生在同一个月的月份数_总和',
d360_1000minus_10000plus_trade_in_same_month_count_sum bigint comment '近360天_发起金额小于1000元与发起金额大于1w元_发生在同一个月的月份数_总和',
d720_1000minus_10000plus_trade_in_same_month_count_sum bigint comment '近720天_发起金额小于1000元与发起金额大于1w元_发生在同一个月的月份数_总和',
d1080_1000minus_10000plus_trade_in_same_month_count_sum bigint comment '近1080天_发起金额小于1000元与发起金额大于1w元_发生在同一个月的月份数_总和',
his_1_4am_8_11am_trade_in_same_monthh_count_sum bigint comment '历史至今_发起金额小于1000元与发起金额大于1w元_发生在同一个月的月份数_总和',
d90_1_4am_8_11am_trade_in_same_monthh_count_sum bigint comment '近90天_1到4点发起与8到11点发起_发生在同一个月的月份数_总和',
d180_1_4am_8_11am_trade_in_same_monthh_count_sum bigint comment '近180天_1到4点发起与8到11点发起_发生在同一个月的月份数_总和',
d360_1_4am_8_11am_trade_in_same_monthh_count_sum bigint comment '近360天_1到4点发起与8到11点发起_发生在同一个月的月份数_总和',
d720_1_4am_8_11am_trade_in_same_monthh_count_sum bigint comment '近720天_1到4点发起与8到11点发起_发生在同一个月的月份数_总和',
d1080_1_4am_8_11am_trade_in_same_monthh_count_sum bigint comment '近1080天_1到4点发起与8到11点发起_发生在同一个月的月份数_总和',
his_trade_fail_count_mon_divide_his_trade_success_count_mon double comment '历史至今_交易失败次数_总和/历史至今_交易成功次数_总和',
d90_trade_fail_count_mon_divide_his_trade_success_count_mon double comment '近90天_交易失败次数_总和/近90天_交易成功次数_总和',
d180_trade_fail_count_mon_divide_his_trade_success_count_mon double comment '近180天_交易失败次数_总和/近180天_交易成功次数_总和',
d360_trade_fail_count_mon_divide_his_trade_success_count_mon double comment '近360天_交易失败次数_总和/近360天_交易成功次数_总和',
d720_trade_fail_count_mon_divide_his_trade_success_count_mon double comment '近720天_交易失败次数_总和/近720天_交易成功次数_总和',
d1080_trade_fail_count_mon_divide_his_trade_success_count_mon double comment '近1080天_交易失败次数_总和/近1080天_交易成功次数_总和',
his_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon double comment '历史至今_月度交易失败订单平均期限_总和/历史至今_月度交易成功订单平均期限_总和',
d90_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon double comment '近90天_月度交易失败订单平均期限_总和/近90天_月度交易成功订单平均期限_总和',
d180_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon double comment '近180天_月度交易失败订单平均期限_总和/近180天_月度交易成功订单平均期限_总和',
d360_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon double comment '近360天_月度交易失败订单平均期限_总和/近360天_月度交易成功订单平均期限_总和',
d720_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon double comment '近720天_月度交易失败订单平均期限_总和/近720天_月度交易成功订单平均期限_总和',
d1080_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon double comment '近1080天_月度交易失败订单平均期限_总和/近1080天_月度交易成功订单平均期限_总和',
his_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon decimal(38,18) comment '历史至今_月度交易失败本金_总和/历史至今_月度交易成功本金_总和',
d90_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon decimal(38,18) comment '近90天_月度交易失败本金_总和/近90天_月度交易成功本金_总和',
d180_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon decimal(38,18) comment '近180天_月度交易失败本金_总和/近180天_月度交易成功本金_总和',
d360_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon decimal(38,18) comment '近360天_月度交易失败本金_总和/近360天_月度交易成功本金_总和',
d720_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon decimal(38,18) comment '近720天_月度交易失败本金_总和/近720天_月度交易成功本金_总和',
d1080_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon decimal(38,18) comment '近1080天_月度交易失败本金_总和/近1080天_月度交易成功本金_总和',
his_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '历史至今_单笔最大发起本金大于发起日(T日)授信额度的次数_总和',
d90_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近90天_单笔最大发起本金大于发起日(T日)授信额度的次数_总和',
d180_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近180天_单笔最大发起本金大于发起日(T日)授信额度的次数_总和',
d360_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近360天_单笔最大发起本金大于发起日(T日)授信额度的次数_总和',
d720_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近720天_单笔最大发起本金大于发起日(T日)授信额度的次数_总和',
d1080_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近1080天_单笔最大发起本金大于发起日(T日)授信额度的次数_总和',
his_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '历史至今_单笔最大发起本金大于发起日(T日)可用额度的次数_总和',
d90_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近90天_单笔最大发起本金大于发起日(T日)可用额度的次数_总和',
d180_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近180天_单笔最大发起本金大于发起日(T日)可用额度的次数_总和',
d360_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近360天_单笔最大发起本金大于发起日(T日)可用额度的次数_总和',
d720_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近720天_单笔最大发起本金大于发起日(T日)可用额度的次数_总和',
d1080_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近1080天_单笔最大发起本金大于发起日(T日)可用额度的次数_总和',
his_max_faqi_prc_amt_divide_rsk_adt_lmt_cash double comment '历史至今_单笔最大发起本金/评分日T-1日授信额度',
d90_max_faqi_prc_amt_divide_rsk_adt_lmt_cash double comment '近90天_单笔最大发起本金/评分日T-1日授信额度',
d180_max_faqi_prc_amt_divide_rsk_adt_lmt_cash double comment '近180天_单笔最大发起本金/评分日T-1日授信额度',
d360_max_faqi_prc_amt_divide_rsk_adt_lmt_cash double comment '近360天_单笔最大发起本金/评分日T-1日授信额度',
d720_max_faqi_prc_amt_divide_rsk_adt_lmt_cash double comment '近720天_单笔最大发起本金/评分日T-1日授信额度',
d1080_max_faqi_prc_amt_divide_rsk_adt_lmt_cash double comment '近1080天_单笔最大发起本金/评分日T-1日授信额度',
his_max_faqi_prc_amt_divide_rsk_avl_lmt_cash double comment '历史至今_单笔最大发起本金/评分日T-1日可用额度',
d90_max_faqi_prc_amt_divide_rsk_avl_lmt_cash double comment '近90天_单笔最大发起本金/评分日T-1日可用额度',
d180_max_faqi_prc_amt_divide_rsk_avl_lmt_cash double comment '近180天_单笔最大发起本金/评分日T-1日可用额度',
d360_max_faqi_prc_amt_divide_rsk_avl_lmt_cash double comment '近360天_单笔最大发起本金/评分日T-1日可用额度',
d720_max_faqi_prc_amt_divide_rsk_avl_lmt_cash double comment '近720天_单笔最大发起本金/评分日T-1日可用额度',
d1080_max_faqi_prc_amt_divide_rsk_avl_lmt_cash double comment '近1080天_单笔最大发起本金/评分日T-1日可用额度',
his_faqi_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '历史至今_月度发起交易本金总额大于评分日T-1日可用额度的月份数_总和',
d90_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近90天_月度发起交易本金总额大于评分日T-1日可用额度的月份数_总和',
d180_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近180天_月度发起交易本金总额大于评分日T-1日可用额度的月份数_总和',
d360_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近360天_月度发起交易本金总额大于评分日T-1日可用额度的月份数_总和',
d720_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近720天_月度发起交易本金总额大于评分日T-1日可用额度的月份数_总和',
d1080_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近1080天_月度发起交易本金总额大于评分日T-1日可用额度的月份数_总和',
his_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '历史至今_月度发起交易本金总额大于评分日T-1日授信额度的月份数_总和',
d90_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近90天_月度发起交易本金总额大于评分日T-1日授信额度的月份数_总和',
d180_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近180天_月度发起交易本金总额大于评分日T-1日授信额度的月份数_总和',
d360_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近360天_月度发起交易本金总额大于评分日T-1日授信额度的月份数_总和',
d720_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近720天_月度发起交易本金总额大于评分日T-1日授信额度的月份数_总和',
d1080_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近1080天_月度发起交易本金总额大于评分日T-1日授信额度的月份数_总和',
his_success_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '历史至今_月度成功交易本金总额大于评分日T-1日可用额度的月份数_总和',
d90_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近90天_月度成功交易本金总额大于评分日T-1日可用额度的月份数_总和',
d180_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近180天_月度成功交易本金总额大于评分日T-1日可用额度的月份数_总和',
d360_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近360天_月度成功交易本金总额大于评分日T-1日可用额度的月份数_总和',
d720_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近720天_月度成功交易本金总额大于评分日T-1日可用额度的月份数_总和',
d1080_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum bigint comment '近1080天_月度成功交易本金总额大于评分日T-1日可用额度的月份数_总和',
his_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '历史至今_月度成功交易本金总额大于评分日T-1日授信额度的月份数_总和',
d90_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近90天_月度成功交易本金总额大于评分日T-1日授信额度的月份数_总和',
d180_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近180天_月度成功交易本金总额大于评分日T-1日授信额度的月份数_总和',
d360_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近360天_月度成功交易本金总额大于评分日T-1日授信额度的月份数_总和',
d720_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近720天_月度成功交易本金总额大于评分日T-1日授信额度的月份数_总和',
d1080_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum bigint comment '近1080天_月度成功交易本金总额大于评分日T-1日授信额度的月份数_总和',
his_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum bigint comment '历史至今_单笔发起本金金额大于所在月份月度逾期还款本金总额的笔数_总和',
d90_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum bigint comment '近90天_单笔发起本金金额大于所在月份月度逾期还款本金总额的笔数_总和',
d180_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum bigint comment '近180天_单笔发起本金金额大于所在月份月度逾期还款本金总额的笔数_总和',
d360_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum bigint comment '近360天_单笔发起本金金额大于所在月份月度逾期还款本金总额的笔数_总和',
d720_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum bigint comment '近720天_单笔发起本金金额大于所在月份月度逾期还款本金总额的笔数_总和',
d1080_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum bigint comment '近1080天_单笔发起本金金额大于所在月份月度逾期还款本金总额的笔数_总和',
his_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum bigint comment '历史至今_单笔发起本金金额大于所在月份月度应还款本金总额的笔数_总和',
d90_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum bigint comment '近90天_单笔发起本金金额大于所在月份月度应还款本金总额的笔数_总和',
d180_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum bigint comment '近180天_单笔发起本金金额大于所在月份月度应还款本金总额的笔数_总和',
d360_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum bigint comment '近360天_单笔发起本金金额大于所在月份月度应还款本金总额的笔数_总和',
d720_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum bigint comment '近720天_单笔发起本金金额大于所在月份月度应还款本金总额的笔数_总和',
d1080_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum bigint comment '近1080天_单笔发起本金金额大于所在月份月度应还款本金总额的笔数_总和',
his_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum bigint comment '历史至今_单笔发起本金金额大于发起前未结清分期计划（含未来应还）本金总和的笔数_总和',
d90_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum bigint comment '近90天_单笔发起本金金额大于发起前所有未结清分期计划（含未来应还）本金总和的笔数_总和',
d180_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum bigint comment '近180天_单笔发起本金金额大于发起前所有未结清分期计划（含未来应还）本金总和的笔数_总和',
d360_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum bigint comment '近360天_单笔发起本金金额大于发起前所有未结清分期计划（含未来应还）本金总和的笔数_总和',
d720_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum bigint comment '近720天_单笔发起本金金额大于发起前所有未结清分期计划（含未来应还）本金总和的笔数_总和',
d1080_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum bigint comment '近1080天_单笔发起本金金额大于发起前所有未结清分期计划（含未来应还）本金总和的笔数_总和',
his_max_faqi_prc_amt_divide_max_ovd_amt_sum_mon decimal(38,18) comment '历史至今_发起借款本金最大值/评分日T-1日前历史至今最大月度逾期还款本金总额',
his_max_faqi_prc_amt_divide_max_ontim_amt_sum_mon decimal(38,18) comment '历史至今_发起借款本金最大值/评分日T-1日前历史至今最大月度按时还款本金总额',
his_max_faqi_prc_amt_divide_max_due_pay_amt_sum_mon decimal(38,18) comment '历史至今_发起借款本金最大值/评分日T-1日前历史至今最大月度应还款本金总额',
his_max_faqi_prc_amt_divide_unpaid_principal_tot decimal(38,18) comment '历史至今_发起借款本金最大值/评分日T-1日前所有未结清分期计划（含未来应还）本金总和',
his_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '历史至今_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于授信额度(T日)_总和',
d90_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近90天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于授信额度(T日)_总和',
d180_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近180天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于授信额度(T日)_总和',
d360_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近360天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于授信额度(T日)_总和',
d720_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近720天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于授信额度(T日)_总和',
d1080_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum bigint comment '近1080天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于授信额度(T日)_总和',
his_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '历史至今_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于可用额度(T日)_总和',
d90_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近90天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于可用额度(T日)_总和',
d180_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近180天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于可用额度(T日)_总和',
d360_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近360天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于可用额度(T日)_总和',
d720_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近720天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于可用额度(T日)_总和',
d1080_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum bigint comment '近1080天_交易发起日(T日)未结清分期计划（含未来）应还本金总额大于可用额度(T日)_总和',
his_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max double comment '历史至今_交易发起日(T日)未结清分期计划（含未来）应还本金总额与授信额度(T日)比值_最大值',
d90_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max double comment '近90天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与授信额度(T日)比值_最大值',
d180_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max double comment '近180天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与授信额度(T日)比值_最大值',
d360_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max double comment '近360天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与授信额度(T日)比值_最大值',
d720_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max double comment '近720天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与授信额度(T日)比值_最大值',
d1080_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max double comment '近1080天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与授信额度(T日)比值_最大值',
his_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max double comment '历史至今_交易发起日(T日)未结清分期计划（含未来）应还本金总额与可用额度(T日)比值_最大值',
d90_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max double comment '近90天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与可用额度(T日)比值_最大值',
d180_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max double comment '近180天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与可用额度(T日)比值_最大值',
d360_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max double comment '近360天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与可用额度(T日)比值_最大值',
d720_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max double comment '近720天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与可用额度(T日)比值_最大值',
d1080_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max double comment '近1080天_交易发起日(T日)未结清分期计划（含未来）应还本金总额与可用额度(T日)比值_最大值'
) PARTITIONED BY (ds STRING comment '分区字段，yyyymmdd');

insert overwrite table dwa_risk.dwa_risk_dz_model_final_25_cross_inner_behaviour_df partition(ds='${bizdate}')
select model_data.*,his_ovdrepay_advrepay_in_same_month_count_sum, d90_ovdrepay_advrepay_in_same_month_count_sum
, d180_ovdrepay_advrepay_in_same_month_count_sum, d360_ovdrepay_advrepay_in_same_month_count_sum, d720_ovdrepay_advrepay_in_same_month_count_sum, d1080_ovdrepay_advrepay_in_same_month_count_sum, his_ovdrepay_large_than_advrepay_amt_months_count_sum
, d90_ovdrepay_large_than_advrepay_amt_months_count_sum, d180_ovdrepay_large_than_advrepay_amt_months_count_sum, d360_ovdrepay_large_than_advrepay_amt_months_count_sum, d720_ovdrepay_large_than_advrepay_amt_months_count_sum, d1080_ovdrepay_large_than_advrepay_amt_months_count_sum
, his_ovdrepay_amt_sum_divide_advrepay_amt_sum, d90_ovdrepay_amt_sum_divide_advrepay_amt_sum, d180_ovdrepay_amt_sum_divide_advrepay_amt_sum, d360_ovdrepay_amt_sum_divide_advrepay_amt_sum, d720_ovdrepay_amt_sum_divide_advrepay_amt_sum
, d1080_ovdrepay_amt_sum_divide_advrepay_amt_sum, his_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum, d90_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum, d180_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum, d360_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum
, d720_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum, d1080_ovd_1d3d_repay_amt_sum_divide_adv_3dminus_repay_amt_sum, his_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum, d90_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum, d180_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum
, d360_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum, d720_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum, d1080_ovd_4d14d_repay_amt_sum_divide_adv_15dminus_repay_amt_sum, his_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum, d90_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum
, d180_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum, d360_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum, d720_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum, d1080_ovd_1mplus_repay_amt_sum_divide_adv_1m_minus_repay_amt_sum, his_ovdrepay_ontimrepay_in_same_month_count_sum
, d90_ovdrepay_ontimrepay_in_same_month_count_sum, d180_ovdrepay_ontimrepay_in_same_month_count_sum, d360_ovdrepay_ontimrepay_in_same_month_count_sum, d720_ovdrepay_ontimrepay_in_same_month_count_sum, d1080_ovdrepay_ontimrepay_in_same_month_count_sum
, his_ovdrepay_large_than_ontimrepay_amt_months_count_sum, d90_ovdrepay_large_than_ontimrepay_amt_months_count_sum, d180_ovdrepay_large_than_ontimrepay_amt_months_count_sum, d360_ovdrepay_large_than_ontimrepay_amt_months_count_sum, d720_ovdrepay_large_than_ontimrepay_amt_months_count_sum
, d1080_ovdrepay_large_than_ontimrepay_amt_months_count_sum, his_ovdrepay_amt_sum_divide_ontimrepay_amt_sum, d90_ovdrepay_amt_sum_divide_ontimrepay_amt_sum, d180_ovdrepay_amt_sum_divide_ontimrepay_amt_sum, d360_ovdrepay_amt_sum_divide_ontimrepay_amt_sum
, d720_ovdrepay_amt_sum_divide_ontimrepay_amt_sum, d1080_ovdrepay_amt_sum_divide_ontimrepay_amt_sum, his_advrepay_ontimrepay_in_same_month_count_sum, d90_advrepay_ontimrepay_in_same_month_count_sum, d180_advrepay_ontimrepay_in_same_month_count_sum
, d360_advrepay_ontimrepay_in_same_month_count_sum, d720_advrepay_ontimrepay_in_same_month_count_sum, d1080_advrepay_ontimrepay_in_same_month_count_sum, his_advrepay_large_than_ontimrepay_amt_months_count_sum, d90_advrepay_large_than_ontimrepay_amt_months_count_sum
, d180_advrepay_large_than_ontimrepay_amt_months_count_sum, d360_advrepay_large_than_ontimrepay_amt_months_count_sum, d720_advrepay_large_than_ontimrepay_amt_months_count_sum, d1080_advrepay_large_than_ontimrepay_amt_months_count_sum, his_advrepay_amt_sum_divide_ontimrepay_amt_sum
, d90_advrepay_amt_sum_divide_ontimrepay_amt_sum, d180_advrepay_amt_sum_divide_ontimrepay_amt_sum, d360_advrepay_amt_sum_divide_ontimrepay_amt_sum, d720_advrepay_amt_sum_divide_ontimrepay_amt_sum, d1080_advrepay_amt_sum_divide_ontimrepay_amt_sum,
his_ovdrepay_fail_trade_in_same_month_count_sum, d90_ovdrepay_fail_trade_in_same_month_count_sum
, d180_ovdrepay_fail_trade_in_same_month_count_sum, d360_ovdrepay_fail_trade_in_same_month_count_sum, d720_ovdrepay_fail_trade_in_same_month_count_sum, d1080_ovdrepay_fail_trade_in_same_month_count_sum, his_advrepay_suc_trade_in_same_month_count_sum
, d90_advrepay_suc_trade_in_same_month_count_sum, d180_advrepay_suc_trade_in_same_month_count_sum, d360_advrepay_suc_trade_in_same_month_count_sum, d720_advrepay_suc_trade_in_same_month_count_sum, d1080_advrepay_suc_trade_in_same_month_count_sum
, his_ovdrepay_suc_trade_in_same_month_count_sum, d90_ovdrepay_suc_trade_in_same_month_count_sum, d180_ovdrepay_suc_trade_in_same_month_count_sum, d360_ovdrepay_suc_trade_in_same_month_count_sum, d720_ovdrepay_suc_trade_in_same_month_count_sum
, d1080_ovdrepay_suc_trade_in_same_month_count_sum, his_ovdrepay_1_4am_trade_in_same_month_count_sum, d90_ovdrepay_1_4am_trade_in_same_month_count_sum, d180_ovdrepay_1_4am_trade_in_same_month_count_sum, d360_ovdrepay_1_4am_trade_in_same_month_count_sum
, d720_ovdrepay_1_4am_trade_in_same_month_count_sum, d1080_ovdrepay_1_4am_trade_in_same_month_count_sum, his_ovdrepay_1wplus_trade_in_same_month_count_sum, d90_ovdrepay_1wplus_trade_in_same_month_count_sum, d180_ovdrepay_1wplus_trade_in_same_month_count_sum
, d360_ovdrepay_1wplus_trade_in_same_month_count_sum, d720_ovdrepay_1wplus_trade_in_same_month_count_sum, d1080_ovdrepay_1wplus_trade_in_same_month_count_sum, his_due_repay_amt_sum_divide_his_faqi_trade_amt_sum, d90_due_repay_amt_sum_divide_d90_faqi_trade_amt_sum
, d180_due_repay_amt_sum_divide_d180_faqi_trade_amt_sum, d360_due_repay_amt_sum_divide_d360_faqi_trade_amt_sum, d720_due_repay_amt_sum_divide_d720_faqi_trade_amt_sum, d1080_due_repay_amt_sum_divide_d1080_faqi_trade_amt_sum, his_due_repay_amt_avg_divide_his_faqi_trade_amt_avg
, d90_due_repay_amt_avg_divide_d90_faqi_trade_amt_avg, d180_due_repay_amt_avg_divide_d180_faqi_trade_amt_avg, d360_due_repay_amt_avg_divide_d360_faqi_trade_amt_avg, d720_due_repay_amt_avg_divide_d720_faqi_trade_amt_avg, d1080_due_repay_amt_avg_divide_d1080_faqi_trade_amt_avg,
his_max_due_prc_amt_divide_his_max_faqi_prc_amt, d90_max_due_prc_amt_divide_d90_max_faqi_prc_amt
, d180_max_due_prc_amt_divide_d180_max_faqi_prc_amt, d360_max_due_prc_amt_divide_d360_max_faqi_prc_amt, d720_max_due_prc_amt_divide_d720_max_faqi_prc_amt, d1080_max_due_prc_amt_divide_d1080_max_faqi_prc_amt, his_max_adv_repay_amt_divide_his_max_faqi_prc_amt
, d90_max_adv_repay_amt_divide_d90_max_faqi_prc_amt, d180_max_adv_repay_amt_divide_d180_max_faqi_prc_amt, d360_max_adv_repay_amt_divide_d360_max_faqi_prc_amt, d720_max_adv_repay_amt_divide_d720_max_faqi_prc_amt, d1080_max_adv_repay_amt_divide_d1080_max_faqi_prc_amt
, his_max_ovd_repay_amt_divide_his_max_suc_prc_amt, d90_max_ovd_repay_amt_divide_d90_max_suc_prc_amt, d180_max_ovd_repay_amt_divide_d180_max_suc_prc_amt, d360_max_ovd_repay_amt_divide_d360_max_suc_prc_amt, d720_max_ovd_repay_amt_divide_d720_max_suc_prc_amt
, d1080_max_ovd_repay_amt_divide_d1080_max_suc_prc_amt, his_max_ovd_repay_amt_divide_his_max_fail_prc_amt, d90_max_ovd_repay_amt_divide_d90_max_fail_prc_amt, d180_max_ovd_repay_amt_divide_d180_max_fail_prc_amt, d360_max_ovd_repay_amt_divide_d360_max_fail_prc_amt
, d720_max_ovd_repay_amt_divide_d720_max_fail_prc_amt, d1080_max_ovd_repay_amt_divide_d1080_max_fail_prc_amt,
his_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d90_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
, d180_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d360_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d720_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d1080_due_repay_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, his_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
, d90_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d180_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d360_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d720_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d1080_due_repay_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
his_max_due_prc_amt_divide_rsk_adt_lmt_cash, d90_max_due_prc_amt_divide_rsk_adt_lmt_cash
, d180_max_due_prc_amt_divide_rsk_adt_lmt_cash, d360_max_due_prc_amt_divide_rsk_adt_lmt_cash, d720_max_due_prc_amt_divide_rsk_adt_lmt_cash, d1080_max_due_prc_amt_divide_rsk_adt_lmt_cash, his_max_adv_repay_amt_divide_rsk_adt_lmt_cash
, d90_max_adv_repay_amt_divide_rsk_adt_lmt_cash, d180_max_adv_repay_amt_divide_rsk_adt_lmt_cash, d360_max_adv_repay_amt_divide_rsk_adt_lmt_cash, d720_max_adv_repay_amt_divide_rsk_adt_lmt_cash, d1080_max_adv_repay_amt_divide_rsk_adt_lmt_cash
, his_max_ovd_repay_amt_divide_rsk_adt_lmt_cash, d90_max_ovd_repay_amt_divide_rsk_adt_lmt_cash, d180_max_ovd_repay_amt_divide_rsk_adt_lmt_cash, d360_max_ovd_repay_amt_divide_rsk_adt_lmt_cash, d720_max_ovd_repay_amt_divide_rsk_adt_lmt_cash
, d1080_max_ovd_repay_amt_divide_rsk_adt_lmt_cash, his_max_due_prc_amt_divide_rsk_avl_lmt_cash, d90_max_due_prc_amt_divide_rsk_avl_lmt_cash, d180_max_due_prc_amt_divide_rsk_avl_lmt_cash, d360_max_due_prc_amt_divide_rsk_avl_lmt_cash
, d720_max_due_prc_amt_divide_rsk_avl_lmt_cash, d1080_max_due_prc_amt_divide_rsk_avl_lmt_cash, his_max_adv_repay_amt_divide_rsk_avl_lmt_cash, d90_max_adv_repay_amt_divide_rsk_avl_lmt_cash, d180_max_adv_repay_amt_divide_rsk_avl_lmt_cash
, d360_max_adv_repay_amt_divide_rsk_avl_lmt_cash, d720_max_adv_repay_amt_divide_rsk_avl_lmt_cash, d1080_max_adv_repay_amt_divide_rsk_avl_lmt_cash, his_max_ovd_repay_amt_divide_rsk_avl_lmt_cash, d90_max_ovd_repay_amt_divide_rsk_avl_lmt_cash
, d180_max_ovd_repay_amt_divide_rsk_avl_lmt_cash, d360_max_ovd_repay_amt_divide_rsk_avl_lmt_cash, d720_max_ovd_repay_amt_divide_rsk_avl_lmt_cash, d1080_max_ovd_repay_amt_divide_rsk_avl_lmt_cash,
his_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d90_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum
, d180_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d360_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d720_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d1080_ontimrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, his_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum
, d90_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d180_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d360_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d720_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d1080_ontimrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum
, his_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d90_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d180_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d360_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d720_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum
, d1080_ovdrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, his_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d90_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d180_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d360_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum
, d720_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d1080_ovdrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, his_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d90_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d180_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum
, d360_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d720_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d1080_advrepay_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, his_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d90_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum
, d180_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d360_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d720_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d1080_advrepay_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
his_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash, d90_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash, d180_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash, d360_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash, d720_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash
, d1080_avg_due_pay_amt_sum_by_mon_divide_rsk_adt_lmt_cash, his_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash, d90_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash, d180_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash, d360_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash
, d720_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash, d1080_avg_due_pay_amt_sum_by_mon_divide_rsk_avl_lmt_cash,
his_suc_fail_trade_in_same_month_count_sum, d90_suc_fail_trade_in_same_month_count_sum
, d180_suc_fail_trade_in_same_month_count_sum, d360_suc_fail_trade_in_same_month_count_sum, d720_suc_fail_trade_in_same_month_count_sum, d1080_suc_fail_trade_in_same_month_count_sum, his_fail_trade_large_than_suc_trade_amt_count_sum
, d90_fail_trade_large_than_suc_trade_amt_count_sum, d180_fail_trade_large_than_suc_trade_amt_count_sum, d360_fail_trade_large_than_suc_trade_amt_count_sum, d720_fail_trade_large_than_suc_trade_amt_count_sum, d1080_fail_trade_large_than_suc_trade_amt_count_sum
, his_fail_trade_large_than_suc_trade_stgnum_count_sum, d90_fail_trade_large_than_suc_trade_stgnum_count_sum, d180_fail_trade_large_than_suc_trade_stgnum_count_sum, d360_fail_trade_large_than_suc_trade_stgnum_count_sum, d720_fail_trade_large_than_suc_trade_stgnum_count_sum
, d1080_fail_trade_large_than_suc_trade_stgnum_count_sum, his_1000minus_10000plus_trade_in_same_month_count_sum, d90_1000minus_10000plus_trade_in_same_month_count_sum, d180_1000minus_10000plus_trade_in_same_month_count_sum, d360_1000minus_10000plus_trade_in_same_month_count_sum
, d720_1000minus_10000plus_trade_in_same_month_count_sum, d1080_1000minus_10000plus_trade_in_same_month_count_sum, his_1_4am_8_11am_trade_in_same_monthh_count_sum, d90_1_4am_8_11am_trade_in_same_monthh_count_sum, d180_1_4am_8_11am_trade_in_same_monthh_count_sum
, d360_1_4am_8_11am_trade_in_same_monthh_count_sum, d720_1_4am_8_11am_trade_in_same_monthh_count_sum, d1080_1_4am_8_11am_trade_in_same_monthh_count_sum, his_trade_fail_count_mon_divide_his_trade_success_count_mon, d90_trade_fail_count_mon_divide_his_trade_success_count_mon
, d180_trade_fail_count_mon_divide_his_trade_success_count_mon, d360_trade_fail_count_mon_divide_his_trade_success_count_mon, d720_trade_fail_count_mon_divide_his_trade_success_count_mon, d1080_trade_fail_count_mon_divide_his_trade_success_count_mon, his_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon
, d90_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon, d180_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon, d360_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon, d720_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon, d1080_trade_fail_stgnum_avg_mon_divide_his_trade_success_stgnum_avg_mon
, his_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon, d90_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon, d180_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon, d360_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon, d720_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon
, d1080_trade_fail_amt_sum_mon_divide_his_trade_success_amt_sum_mon,
his_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d90_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
, d180_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d360_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d720_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d1080_faqi_trade_amt_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, his_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
, d90_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d180_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d360_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d720_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d1080_faqi_trade_amt_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum,
his_max_faqi_prc_amt_divide_rsk_adt_lmt_cash, d90_max_faqi_prc_amt_divide_rsk_adt_lmt_cash
, d180_max_faqi_prc_amt_divide_rsk_adt_lmt_cash, d360_max_faqi_prc_amt_divide_rsk_adt_lmt_cash, d720_max_faqi_prc_amt_divide_rsk_adt_lmt_cash, d1080_max_faqi_prc_amt_divide_rsk_adt_lmt_cash, his_max_faqi_prc_amt_divide_rsk_avl_lmt_cash
, d90_max_faqi_prc_amt_divide_rsk_avl_lmt_cash, d180_max_faqi_prc_amt_divide_rsk_avl_lmt_cash, d360_max_faqi_prc_amt_divide_rsk_avl_lmt_cash, d720_max_faqi_prc_amt_divide_rsk_avl_lmt_cash, d1080_max_faqi_prc_amt_divide_rsk_avl_lmt_cash,
his_faqi_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d90_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum
, d180_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d360_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d720_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d1080_faqiamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, his_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum
, d90_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d180_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d360_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d720_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d1080_faqiamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum
, his_success_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d90_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d180_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d360_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, d720_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum
, d1080_successamt_thismon_sum_larger_than_rsk_avl_lmt_cash_count_sum, his_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d90_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d180_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d360_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum
, d720_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum, d1080_successamt_thismon_sum_larger_than_rsk_adt_lmt_cash_count_sum,
his_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum, d90_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum
, d180_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum, d360_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum, d720_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum, d1080_faqi_trade_amt_larger_than_ovd_repay_amt_by_mon_count_sum, his_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum
, d90_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum, d180_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum, d360_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum, d720_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum, d1080_faqi_trade_amt_larger_than_due_repay_amt_by_mon_count_sum
, his_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum, d90_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum, d180_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum, d360_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum, d720_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum
, d1080_faqi_trade_amt_larger_than_unpaid_principal_tot_amt_t_day_count_sum,
his_max_faqi_prc_amt_divide_max_ovd_amt_sum_mon, his_max_faqi_prc_amt_divide_max_ontim_amt_sum_mon
, his_max_faqi_prc_amt_divide_max_due_pay_amt_sum_mon, his_max_faqi_prc_amt_divide_unpaid_principal_tot,
his_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d90_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum
, d180_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d360_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d720_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, d1080_faqi_unpaid_principal_tot_larger_than_rsk_adt_lmt_cash_his_t_day_count_sum, his_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
, d90_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d180_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d360_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d720_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum, d1080_faqi_unpaid_principal_tot_larger_than_rsk_avl_lmt_cash_his_t_day_count_sum
, his_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max, d90_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max, d180_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max, d360_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max, d720_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max
, d1080_unpaid_principal_tot_amt_t_day_divide_rsk_adt_lmt_cash_his_t_day_max, his_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max, d90_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max, d180_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max, d360_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max
, d720_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max, d1080_unpaid_principal_tot_amt_t_day_divide_rsk_avl_lmt_cash_his_t_day_max
from 
(
    select  uid
            ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from    dwa_risk.dwa_risk_f_dz_model_data_base
    ) model_data
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_1_repay_behaviour_inner_cross_df) t1
on model_data.uid = t1.uid and model_data.mdl_dte = t1.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_2_repay_cross_trade_behaviour_by_mon_df) t2
on model_data.uid = t2.uid and model_data.mdl_dte = t2.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_3_repay_cross_trade_behaviour_by_each_df) t3
on model_data.uid = t3.uid and model_data.mdl_dte = t3.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_4_repay_cross_credit_limit_by_each_df) t4
on model_data.uid = t4.uid and model_data.mdl_dte = t4.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_5_repay_cross_credit_limit_by_each_df) t5
on model_data.uid = t5.uid and model_data.mdl_dte = t5.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_6_repay_cross_credit_limit_behaviour_by_mon_df) t6
on model_data.uid = t6.uid and model_data.mdl_dte = t6.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_7_trade_behaviour_inner_cross_df) t7
on model_data.uid = t7.uid and model_data.mdl_dte = t7.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_8_trade_cross_credit_limit_by_each_df) t8
on model_data.uid = t8.uid and model_data.mdl_dte = t8.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_9_trade_cross_credit_limit_by_each_df) t9
on model_data.uid = t9.uid and model_data.mdl_dte = t9.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_10_trade_cross_credit_limit_behaviour_by_mon_df) t10
on model_data.uid = t10.uid and model_data.mdl_dte = t10.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_11_trade_cross_debate_behaviour_agregate_by_each_df) t11
on model_data.uid = t11.uid and model_data.mdl_dte = t11.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_12_trade_cross_debate_behaviour_agregate_by_each_df) t12
on model_data.uid = t12.uid and model_data.mdl_dte = t12.mdl_dte
left join
(select * from dwa_risk.dwa_risk_dz_model_final_25_13_credit_limit_cross_debate_behaviour_agregate_by_each_df) t13
on model_data.uid = t13.uid and model_data.mdl_dte = t13.mdl_dte;
-- feature-copilot:node-end ordinal=0
