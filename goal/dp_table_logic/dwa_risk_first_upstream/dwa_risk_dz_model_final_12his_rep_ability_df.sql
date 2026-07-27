-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_ability_df
-- node_id: n_3784320320450134016
-- task_name: dwa_risk_dz_model_final_12his_rep_ability_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_ability_df.json
-- source_json_sha256: 2ad27bec5b65a0d02202093f3b51232b77a52f33a721ea9d55a9380982181408
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_stage_tmp1
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: cdmx.cdmx_fct_heavy_loancore_repayment_di
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_detail
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的 dmining.dz_model_final_12his_rep_ability
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_stage_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_stage_tmp1 as 
select 
         main2.uid
        ,main2.mdl_dte
        ,main2.dtl_ord_no
        ,main2.dtl_stg_pln_no
        ,main2.dtl_rep_dte
        ,main2.rep_tim
        ,main2.rep_tim_timestamp
        ,main2.rep_prc --还款本金金额
        --实还日和评分日的间隔
        ,main2.ddf_mdl_rep_tim
        --实还日和应还日的间隔
        ,main2.ddf_rep_tim_dte
        ,main2.ded_typ
        --打标签--还款时间类型
        ,main2.rep_tim_type
        --还款方式
        ,main2.rep_mtd_typ --批扣表不可用，暂用模拟
        ,main2.rep_mtd_typ_new
        -- 实还日和评分日的间隔（月）时间切片的flag
        ,case when ddf_mdl_rep_tim between 1 and 31 then 1 else 0 end as his_rep_tim_stg_pln_1m_flg
        ,case when ddf_mdl_rep_tim between 1 and 92 then 1 else 0 end as his_rep_tim_stg_pln_3m_flg
        ,case when ddf_mdl_rep_tim between 1 and 183 then 1 else 0 end as his_rep_tim_stg_pln_6m_flg
        ,case when ddf_mdl_rep_tim between 1 and 366 then 1 else 0 end as his_rep_tim_stg_pln_12m_flg

        ,order_info_tmp.fst_ord_flg --首借订单
        ,order_info_tmp.cur_ord_flg --当前订单

        --实还方式
        ,concat(rep_tim_type,'_',rep_mtd_typ) as rep_typ--迭代
        -- ,case when rep_tim_type='提前还款' then '提前还款'
        --         else concat(rep_tim_type,'_',rep_mtd_typ) end as rep_typ

        ,concat(rep_tim_type,'_',rep_mtd_typ_new) as rep_typ_new

        --实还时间排序-倒序-取最近一次
        ,row_number() over(partition by main2.uid order by rep_tim_timestamp desc) as rep_rn
from 
        (select 
                 main1.uid
                ,main1.mdl_dte
                ,main1.dtl_ord_no
                ,main1.dtl_stg_pln_no
                ,main1.dtl_rep_dte
                ,main1.rep_tim
                ,main1.rep_tim_timestamp
                ,main1.rep_prc --还款本金金额
                --实还日和评分日的间隔
                ,main1.ddf_mdl_rep_tim
                --实还日和应还日的间隔
                ,main1.ddf_rep_tim_dte
                ,main1.ded_typ

                
                --打标签--还款时间类型
                ,case when ddf_rep_tim_dte<0 then '提前还款'
                        when ddf_rep_tim_dte=0 and hour(rep_tim_timestamp) between 0 and 5 then 'D0早上还款'
                        when ddf_rep_tim_dte=0 and hour(rep_tim_timestamp) between 6 and 11 then 'D0上午还款'
                        when ddf_rep_tim_dte=0 and hour(rep_tim_timestamp) between 12 and 14 then 'D0中午还款'
                        when ddf_rep_tim_dte=0 and hour(rep_tim_timestamp) between 14 and 19 then 'D0下午还款'
                        when ddf_rep_tim_dte=0 and hour(rep_tim_timestamp) between 20 and 23 then 'D0晚上还款'
                        when ddf_rep_tim_dte>30 then '历史逾期30天以上（m2+）'
                        when ddf_rep_tim_dte>14 then '历史逾期15天-30天'
                        when ddf_rep_tim_dte>7 then '历史逾期8-14天'
                        when ddf_rep_tim_dte>3 then '历史逾期4-7天'
                        when ddf_rep_tim_dte>0 then '历史逾期1-3天'
                        else '其他'
                        end as rep_tim_type

                --还款方式
                ,case when hour(rep_tim_timestamp)=7 then '上午批扣'
                        -- when hour(rep_tim_timestamp)=6 then '下午批扣'
                        when hour(rep_tim_timestamp)=18 then '下午批扣'
                        else '主动还款' end as rep_mtd_typ --批扣表不可用，暂用模拟

                ,case when ded_typ='AUTO_DEDUCT' and hour(rep_tim_timestamp) < 12 then '上午批扣'
                        when ded_typ='AUTO_DEDUCT' and hour(rep_tim_timestamp) >= 12 then '下午批扣'
                        when ded_typ='MANUAL_REPAY' then '主动还款'
                        when ded_typ = 'OFFLINE_REPAY' then '缴款补入账'
                        when ded_typ = 'MANUAL_PARTIAL_DEDUCT' then '催收部分扣款'
                        when ded_typ = 'MANUAL_DEDUCT_ALL' then '催收全额补扣'
                        when ded_typ = 'REFUND' then '退货'
                        else '其他' end as rep_mtd_typ_new
        from
                (select model_data.uid
                        ,model_data.mdl_dte

                        ,repayment.dtl_ord_no
                        ,repayment.dtl_stg_pln_no
                        ,repayment.dtl_rep_dte
                        ,repayment.rep_tim
                        ,repayment.rep_tim_timestamp
                        -- ,repayment.prc_amt --分期本金金额
                        ,repayment.rep_prc --还款本金金额
                        -- ,repayment.stg_stt

                        --实还日和评分日的间隔
                        ,datediff(model_data.mdl_dte,rep_tim) as ddf_mdl_rep_tim
                        --实还日和应还日的间隔
                        ,datediff(rep_tim,dtl_rep_dte) as ddf_rep_tim_dte

                        ,repayment_new.ded_typ

                from    (select uid
                                ,mdl_dte
                        from ${dwa_risk}.dwa_risk_f_dz_model_data_base
                        ) model_data

                        left join
                        ( 
                        select uid
                            ,order_no as dtl_ord_no
                            ,stage_plan_no as dtl_stg_pln_no
                            ,due_date as dtl_rep_dte
                            ,date(repay_time) as rep_tim
                            ,repay_time as rep_tim_timestamp
                            --,date(pay_off_tim) as pay_off_tim
                            --,prc_amt
                            ,repay_principal rep_prc
                        from cdmx.cdmx_fct_heavy_loancore_repayment_di x
                        where ds <>''
                        and biz_type_code in ('BALANCE_TRANSFER', 'CASH')
                        and repay_principal >0 --只计算本金金额的还款情况

                        )repayment on model_data.uid=repayment.uid

                        -- 20210617在这里修复, 新增v2代码逻辑, 不覆盖v1版本的该段代码逻辑
                        -- 主被动还款标识为dbank.loan_f_stage_plan的ded_typ字段, 注意ded_typ会有缺失的情况(上面归为其他类)
                        -- 20年以前没有记所以为空是正常的, 20年以后，自扣的资方大地，扣款类型为空是正常的
                        -- loan_f_stage_repayment的ded_typ不准确, 而且需要清洗
                        left join
                        (select uid
                                ,stg_pln_no
                                ,ded_typ
                        from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic
                        where bsy_typ in ('BALANCE_TRANSFER', 'CASH')
                        and stg_stt <> 'R'
                        )repayment_new on repayment.dtl_stg_pln_no=repayment_new.stg_pln_no
                where   date(repayment.rep_tim)<date(model_data.mdl_dte) --去除实还时间穿越的数据
                )main1
        )main2
        left join
        (select uid
                ,mdl_dte
                ,dtl_ord_no
                ,case when fst_ord_flg=1 then 1 else 0 end as fst_ord_flg --首借订单
                ,cur_ord_flg --当前订单
        from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail
        where ord_stt_flg='success'
        )order_info_tmp on main2.uid=order_info_tmp.uid and main2.dtl_ord_no=order_info_tmp.dtl_ord_no
;

------------------【特征计算中间表】--------------------

--------------------------
--/*12.1.2 历史还款能力*/
--------------------------

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_tmp2 as
select uid
        ,mdl_dte
-- features range start --
        ----------------------------------------------------------
        --/*12.1.2 历史还款能力*/--实还口径
        ----------------------------------------------------------
        --/*历史实还本金金额*/
        ,sum(rep_prc) as stg_pln_sum_rep_prc_his
        ,sum(case when his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his
        ,sum(case when his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his
        ,sum(case when his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his
        ,sum(case when his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his
        --/*历史实还本金金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_fst_ord
        ,sum(case when cur_ord_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_cur_ord

        --/*历史实还本金金额--单笔最大*/
        ,max(rep_prc) as stg_pln_max_rep_prc_his
        ,max(case when his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_1m_his
        ,max(case when his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_3m_his
        ,max(case when his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_6m_his
        ,max(case when his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_max_rep_prc_12m_his
        --/*历史实还本金金额--单笔最小*/
        ,min(rep_prc) as stg_pln_min_rep_prc_his
        ,min(case when his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_1m_his
        ,min(case when his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_3m_his
        ,min(case when his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_6m_his
        ,min(case when his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_min_rep_prc_12m_his
        
        --/*实还日距评分日天数*/--历史最大、最小
        ,max(ddf_mdl_rep_tim) as max_ddf_mdl_rep_tim_his
        ,min(ddf_mdl_rep_tim) as min_ddf_mdl_rep_tim_his


        --最近一次还款方式
        ,max(case when rep_rn=1 then rep_typ else null end) as lst_rep_typ
        --最近一次还款金额
        ,max(case when rep_rn=1 then rep_prc else null end) as lst_rep_prc

        ----按照不同的还款方式计算实还本金金额
        -- rep_tim_type='提前还款'
        ,sum(case when rep_tim_type='提前还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_adv
        ,sum(case when rep_tim_type='提前还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_adv
        ,sum(case when rep_tim_type='提前还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_adv
        ,sum(case when rep_tim_type='提前还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_adv
        ,sum(case when rep_tim_type='提前还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_adv
 

        -- rep_typ='D0早上还款_主动还款'(dawn：0点到5点)
        ,sum(case when rep_typ='D0早上还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_dwn_zd
        ,sum(case when rep_typ='D0早上还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_dwn_zd
        ,sum(case when rep_typ='D0早上还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_dwn_zd
        ,sum(case when rep_typ='D0早上还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_dwn_zd
        ,sum(case when rep_typ='D0早上还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_dwn_zd
 

        -- rep_typ='D0上午还款_上午批扣'(morning：6点到11点)
        ,sum(case when rep_typ='D0上午还款_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_mrn_pk
        ,sum(case when rep_typ='D0上午还款_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_mrn_pk
        ,sum(case when rep_typ='D0上午还款_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_mrn_pk
        ,sum(case when rep_typ='D0上午还款_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_mrn_pk
        ,sum(case when rep_typ='D0上午还款_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_mrn_pk
 

        -- rep_typ='D0上午还款_主动还款'(morning：6点到11点)
        ,sum(case when rep_typ='D0上午还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_mrn_zd
        ,sum(case when rep_typ='D0上午还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_mrn_zd
        ,sum(case when rep_typ='D0上午还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_mrn_zd
        ,sum(case when rep_typ='D0上午还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_mrn_zd
        ,sum(case when rep_typ='D0上午还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_mrn_zd
 

        -- rep_typ='D0中午还款_主动还款'(noon：12点到14点)
        ,sum(case when rep_typ='D0中午还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_non_zd
        ,sum(case when rep_typ='D0中午还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_non_zd
        ,sum(case when rep_typ='D0中午还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_non_zd
        ,sum(case when rep_typ='D0中午还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_non_zd
        ,sum(case when rep_typ='D0中午还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_non_zd
 

        -- rep_typ='D0下午还款_下午批扣'(aft：15点到19点)
        ,sum(case when rep_typ='D0下午还款_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_afn_pk
        ,sum(case when rep_typ='D0下午还款_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_afn_pk
        ,sum(case when rep_typ='D0下午还款_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_afn_pk
        ,sum(case when rep_typ='D0下午还款_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_afn_pk
        ,sum(case when rep_typ='D0下午还款_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_afn_pk
 

        -- rep_typ='D0下午还款_主动还款'
        ,sum(case when rep_typ='D0下午还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_afn_zd
        ,sum(case when rep_typ='D0下午还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_afn_zd
        ,sum(case when rep_typ='D0下午还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_afn_zd
        ,sum(case when rep_typ='D0下午还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_afn_zd
        ,sum(case when rep_typ='D0下午还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_afn_zd
 

        -- rep_typ='D0晚上还款_主动还款'
        ,sum(case when rep_typ='D0晚上还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_evn_zd
        ,sum(case when rep_typ='D0晚上还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_evn_zd
        ,sum(case when rep_typ='D0晚上还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_evn_zd
        ,sum(case when rep_typ='D0晚上还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_evn_zd
        ,sum(case when rep_typ='D0晚上还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_evn_zd
 
        -- rep_typ='历史逾期30天以上（m2+）_上午批扣'
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk
 

        -- rep_typ='历史逾期30天以上（m2+）_下午批扣'
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk
 

        -- rep_typ='历史逾期30天以上（m2+）_主动还款'
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_m2_pls_zd
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd
        ,sum(case when rep_typ='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd
 

        -- rep_typ='历史逾期15天-30天_上午批扣'
        ,sum(case when rep_typ='历史逾期15天-30天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk
 

        -- rep_typ='历史逾期15天-30天_下午批扣'

        ,sum(case when rep_typ='历史逾期15天-30天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk
        ,sum(case when rep_typ='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk
 

        -- rep_typ='历史逾期15天-30天_主动还款'
        ,sum(case when rep_typ='历史逾期15天-30天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd
        ,sum(case when rep_typ='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd
        ,sum(case when rep_typ='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd
        ,sum(case when rep_typ='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd
        ,sum(case when rep_typ='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd
 

        -- rep_typ='历史逾期8-14天_上午批扣'
        ,sum(case when rep_typ='历史逾期8-14天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk
        ,sum(case when rep_typ='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk
        ,sum(case when rep_typ='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk
        ,sum(case when rep_typ='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk
        ,sum(case when rep_typ='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk
 

        -- rep_typ='历史逾期8-14天_下午批扣'
        ,sum(case when rep_typ='历史逾期8-14天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk
        ,sum(case when rep_typ='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk
        ,sum(case when rep_typ='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk
        ,sum(case when rep_typ='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk
        ,sum(case when rep_typ='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk
 

        -- rep_typ='历史逾期8-14天_主动还款'
        ,sum(case when rep_typ='历史逾期8-14天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd
        ,sum(case when rep_typ='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd
        ,sum(case when rep_typ='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd
        ,sum(case when rep_typ='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd
        ,sum(case when rep_typ='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd
 

        -- rep_typ='历史逾期4-7天_上午批扣'
        ,sum(case when rep_typ='历史逾期4-7天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk
        ,sum(case when rep_typ='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk
        ,sum(case when rep_typ='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk
        ,sum(case when rep_typ='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk
        ,sum(case when rep_typ='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk
 

        -- rep_typ='历史逾期4-7天_下午批扣'
        ,sum(case when rep_typ='历史逾期4-7天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk
        ,sum(case when rep_typ='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk
        ,sum(case when rep_typ='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk
        ,sum(case when rep_typ='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk
        ,sum(case when rep_typ='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk
 

        -- rep_typ='历史逾期4-7天_主动还款'
        ,sum(case when rep_typ='历史逾期4-7天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd
        ,sum(case when rep_typ='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd
        ,sum(case when rep_typ='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd
        ,sum(case when rep_typ='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd
        ,sum(case when rep_typ='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd
 

        -- rep_typ='历史逾期1-3天_上午批扣'
        ,sum(case when rep_typ='历史逾期1-3天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk
        ,sum(case when rep_typ='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk
        ,sum(case when rep_typ='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk
        ,sum(case when rep_typ='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk
        ,sum(case when rep_typ='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk
 

        -- rep_typ='历史逾期1-3天_下午批扣'
        ,sum(case when rep_typ='历史逾期1-3天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk
        ,sum(case when rep_typ='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk
        ,sum(case when rep_typ='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk
        ,sum(case when rep_typ='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk
        ,sum(case when rep_typ='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk
 

        -- rep_typ='历史逾期1-3天_主动还款'
        ,sum(case when rep_typ='历史逾期1-3天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd
        ,sum(case when rep_typ='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd
        ,sum(case when rep_typ='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd
        ,sum(case when rep_typ='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd
        ,sum(case when rep_typ='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd
 
-- features range end --
from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_stage_tmp1
group by uid
        ,mdl_dte
;


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_v2_tmp3;
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_v2_tmp3 as
select uid
        ,mdl_dte

-- features range start --
        ----------------------------------------------------------
        --/*12.1.2 历史还款能力*/--实还口径
        ----------------------------------------------------------
        --/*历史实还本金金额*/
        --最近一次还款方式v2
        ,max(case when rep_rn=1 then rep_typ_new else null end) as lst_rep_typ_v2

                -- rep_typ_new='D0早上还款_主动还款'(dawn：0点到5点)
        ,sum(case when rep_typ_new='D0早上还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_dwn_zd_v2
        ,sum(case when rep_typ_new='D0早上还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_v2
        ,sum(case when rep_typ_new='D0早上还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_v2
        ,sum(case when rep_typ_new='D0早上还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_v2
        ,sum(case when rep_typ_new='D0早上还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_v2
 

        -- rep_typ_new='D0上午还款_上午批扣'(v2)
        ,sum(case when rep_typ_new='D0上午还款_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_mrn_pk_v2
        ,sum(case when rep_typ_new='D0上午还款_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_v2
        ,sum(case when rep_typ_new='D0上午还款_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_v2
        ,sum(case when rep_typ_new='D0上午还款_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_v2
        ,sum(case when rep_typ_new='D0上午还款_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_v2
 

        -- rep_typ_new='D0上午还款_主动还款'(v2)
        ,sum(case when rep_typ_new='D0上午还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_mrn_zd_v2
        ,sum(case when rep_typ_new='D0上午还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_v2
        ,sum(case when rep_typ_new='D0上午还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_v2
        ,sum(case when rep_typ_new='D0上午还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_v2
        ,sum(case when rep_typ_new='D0上午还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_v2
 

        -- rep_typ_new='D0中午还款_主动还款'(v2)
        ,sum(case when rep_typ_new='D0中午还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_non_zd_v2
        ,sum(case when rep_typ_new='D0中午还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_non_zd_v2
        ,sum(case when rep_typ_new='D0中午还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_non_zd_v2
        ,sum(case when rep_typ_new='D0中午还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_non_zd_v2
        ,sum(case when rep_typ_new='D0中午还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_non_zd_v2
 

        -- rep_typ_new='D0下午还款_下午批扣'(v2)
        ,sum(case when rep_typ_new='D0下午还款_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_afn_pk_v2
        ,sum(case when rep_typ_new='D0下午还款_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_afn_pk_v2
        ,sum(case when rep_typ_new='D0下午还款_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_afn_pk_v2
        ,sum(case when rep_typ_new='D0下午还款_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_afn_pk_v2
        ,sum(case when rep_typ_new='D0下午还款_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_afn_pk_v2
 

        -- rep_typ_new='D0下午还款_主动还款'(v2)
        ,sum(case when rep_typ_new='D0下午还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_afn_zd_v2
        ,sum(case when rep_typ_new='D0下午还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_afn_zd_v2
        ,sum(case when rep_typ_new='D0下午还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_afn_zd_v2
        ,sum(case when rep_typ_new='D0下午还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_afn_zd_v2
        ,sum(case when rep_typ_new='D0下午还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_afn_zd_v2
 

        -- rep_typ_new='D0晚上还款_主动还款'(v2)
        ,sum(case when rep_typ_new='D0晚上还款_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_d0_evn_zd_v2
        ,sum(case when rep_typ_new='D0晚上还款_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_d0_evn_zd_v2
        ,sum(case when rep_typ_new='D0晚上还款_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_d0_evn_zd_v2
        ,sum(case when rep_typ_new='D0晚上还款_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_d0_evn_zd_v2
        ,sum(case when rep_typ_new='D0晚上还款_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_d0_evn_zd_v2
 
        -- rep_typ_new='历史逾期30天以上（m2+）_上午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk_v2
 

        -- rep_typ_new='历史逾期30天以上（m2+）_下午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk_v2
 

        -- rep_typ_new='历史逾期30天以上（m2+）_主动还款'(v2)
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_m2_pls_zd_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd_v2
        ,sum(case when rep_typ_new='历史逾期30天以上（m2+）_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd_v2
 

        -- rep_typ_new='历史逾期15天-30天_上午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期15天-30天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk_v2
 

        -- rep_typ_new='历史逾期15天-30天_下午批扣'(v2)

        ,sum(case when rep_typ_new='历史逾期15天-30天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk_v2
 

        -- rep_typ_new='历史逾期15天-30天_主动还款'(v2)
        ,sum(case when rep_typ_new='历史逾期15天-30天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd_v2
        ,sum(case when rep_typ_new='历史逾期15天-30天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd_v2
 

        -- rep_typ_new='历史逾期8-14天_上午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期8-14天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk_v2
 

        -- rep_typ_new='历史逾期8-14天_下午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期8-14天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk_v2
 

        -- rep_typ_new='历史逾期8-14天_主动还款'(v2)
        ,sum(case when rep_typ_new='历史逾期8-14天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd_v2
        ,sum(case when rep_typ_new='历史逾期8-14天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd_v2
 

        -- rep_typ_new='历史逾期4-7天_上午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期4-7天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk_v2
 

        -- rep_typ_new='历史逾期4-7天_下午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期4-7天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk_v2
 

        -- rep_typ_new='历史逾期4-7天_主动还款'(v2)
        ,sum(case when rep_typ_new='历史逾期4-7天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd_v2
        ,sum(case when rep_typ_new='历史逾期4-7天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd_v2
 

        -- rep_typ_new='历史逾期1-3天_上午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期1-3天_上午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_上午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk_v2
 

        -- rep_typ_new='历史逾期1-3天_下午批扣'(v2)
        ,sum(case when rep_typ_new='历史逾期1-3天_下午批扣' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_下午批扣' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk_v2
 

        -- rep_typ_new='历史逾期1-3天_主动还款'(v2)
        ,sum(case when rep_typ_new='历史逾期1-3天_主动还款' then rep_prc else 0 end) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_1m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_3m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_6m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd_v2
        ,sum(case when rep_typ_new='历史逾期1-3天_主动还款' and his_rep_tim_stg_pln_12m_flg=1 then rep_prc else 0 end) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd_v2
 
-- features range end --
from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_stage_tmp1
group by uid
        ,mdl_dte
;

------------------【特征计算结果表】--------------------
--------------------------
--/*12.1.2 历史还款能力*/
--------------------------

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_df partition(ds='${bizdate}')
select model_data.uid
        ,model_data.mdl_dte
        
-- features range start --
        ----------------------------------------------------------
        --/*12.1.2 历史还款能力*/
        ----------------------------------------------------------
        ,coalesce(repayment.stg_pln_sum_rep_prc_his,0) as stg_pln_sum_rep_prc_his
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his,0) as stg_pln_sum_rep_prc_1m_his
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his,0) as stg_pln_sum_rep_prc_3m_his
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his,0) as stg_pln_sum_rep_prc_6m_his
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his,0) as stg_pln_sum_rep_prc_12m_his
        --/*历史实还本金金额/*首借订单和当前订单*/
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_fst_ord,0) as stg_pln_sum_rep_prc_his_fst_ord
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_cur_ord,0) as stg_pln_sum_rep_prc_his_cur_ord

        --/*历史实还本金金额--单笔最大*/
        ,coalesce(repayment.stg_pln_max_rep_prc_his,0) as stg_pln_max_rep_prc_his
        ,coalesce(repayment.stg_pln_max_rep_prc_1m_his,0) as stg_pln_max_rep_prc_1m_his
        ,coalesce(repayment.stg_pln_max_rep_prc_3m_his,0) as stg_pln_max_rep_prc_3m_his
        ,coalesce(repayment.stg_pln_max_rep_prc_6m_his,0) as stg_pln_max_rep_prc_6m_his
        ,coalesce(repayment.stg_pln_max_rep_prc_12m_his,0) as stg_pln_max_rep_prc_12m_his
        --/*历史实还本金金额--单笔最小*/
        ,coalesce(repayment.stg_pln_min_rep_prc_his,0) as stg_pln_min_rep_prc_his
        ,coalesce(repayment.stg_pln_min_rep_prc_1m_his,0) as stg_pln_min_rep_prc_1m_his
        ,coalesce(repayment.stg_pln_min_rep_prc_3m_his,0) as stg_pln_min_rep_prc_3m_his
        ,coalesce(repayment.stg_pln_min_rep_prc_6m_his,0) as stg_pln_min_rep_prc_6m_his
        ,coalesce(repayment.stg_pln_min_rep_prc_12m_his,0) as stg_pln_min_rep_prc_12m_his
        --/*实还日距评分日天数*/--历史最大、最小
        ,repayment.max_ddf_mdl_rep_tim_his
        ,repayment.min_ddf_mdl_rep_tim_his


        ---------按照还款方式计算还款金额---------
        ,repayment.lst_rep_typ
        ,repayment.lst_rep_prc
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_adv,0) as stg_pln_sum_rep_prc_his_adv
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_adv,0) as stg_pln_sum_rep_prc_1m_his_adv
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_adv,0) as stg_pln_sum_rep_prc_3m_his_adv
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_adv,0) as stg_pln_sum_rep_prc_6m_his_adv
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_adv,0) as stg_pln_sum_rep_prc_12m_his_adv
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_dwn_zd,0) as stg_pln_sum_rep_prc_his_d0_dwn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_dwn_zd,0) as stg_pln_sum_rep_prc_1m_his_d0_dwn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_dwn_zd,0) as stg_pln_sum_rep_prc_3m_his_d0_dwn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_dwn_zd,0) as stg_pln_sum_rep_prc_6m_his_d0_dwn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_dwn_zd,0) as stg_pln_sum_rep_prc_12m_his_d0_dwn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_mrn_pk,0) as stg_pln_sum_rep_prc_his_d0_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_mrn_pk,0) as stg_pln_sum_rep_prc_1m_his_d0_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_mrn_pk,0) as stg_pln_sum_rep_prc_3m_his_d0_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_mrn_pk,0) as stg_pln_sum_rep_prc_6m_his_d0_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_mrn_pk,0) as stg_pln_sum_rep_prc_12m_his_d0_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_mrn_zd,0) as stg_pln_sum_rep_prc_his_d0_mrn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_mrn_zd,0) as stg_pln_sum_rep_prc_1m_his_d0_mrn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_mrn_zd,0) as stg_pln_sum_rep_prc_3m_his_d0_mrn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_mrn_zd,0) as stg_pln_sum_rep_prc_6m_his_d0_mrn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_mrn_zd,0) as stg_pln_sum_rep_prc_12m_his_d0_mrn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_non_zd,0) as stg_pln_sum_rep_prc_his_d0_non_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_non_zd,0) as stg_pln_sum_rep_prc_1m_his_d0_non_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_non_zd,0) as stg_pln_sum_rep_prc_3m_his_d0_non_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_non_zd,0) as stg_pln_sum_rep_prc_6m_his_d0_non_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_non_zd,0) as stg_pln_sum_rep_prc_12m_his_d0_non_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_afn_pk,0) as stg_pln_sum_rep_prc_his_d0_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_afn_pk,0) as stg_pln_sum_rep_prc_1m_his_d0_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_afn_pk,0) as stg_pln_sum_rep_prc_3m_his_d0_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_afn_pk,0) as stg_pln_sum_rep_prc_6m_his_d0_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_afn_pk,0) as stg_pln_sum_rep_prc_12m_his_d0_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_afn_zd,0) as stg_pln_sum_rep_prc_his_d0_afn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_afn_zd,0) as stg_pln_sum_rep_prc_1m_his_d0_afn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_afn_zd,0) as stg_pln_sum_rep_prc_3m_his_d0_afn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_afn_zd,0) as stg_pln_sum_rep_prc_6m_his_d0_afn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_afn_zd,0) as stg_pln_sum_rep_prc_12m_his_d0_afn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_evn_zd,0) as stg_pln_sum_rep_prc_his_d0_evn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_evn_zd,0) as stg_pln_sum_rep_prc_1m_his_d0_evn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_evn_zd,0) as stg_pln_sum_rep_prc_3m_his_d0_evn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_evn_zd,0) as stg_pln_sum_rep_prc_6m_his_d0_evn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_evn_zd,0) as stg_pln_sum_rep_prc_12m_his_d0_evn_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk,0) as stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk,0) as stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_m2_pls_zd,0) as stg_pln_sum_rep_prc_his_ovd_m2_pls_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd,0) as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd,0) as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd,0) as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd,0) as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk,0) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk,0) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd,0) as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd,0) as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd,0) as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd,0) as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd,0) as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk,0) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk,0) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd,0) as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd,0) as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd,0) as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd,0) as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd,0) as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk,0) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk,0) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd,0) as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd,0) as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd,0) as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd,0) as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd,0) as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk,0) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk,0) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk,0) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk,0) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk,0) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk,0) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd,0) as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd,0) as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd,0) as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd,0) as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd,0) as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd

-- features range end --
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data  --建模样本
left join ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_tmp2 repayment on model_data.uid=repayment.uid
;
-- feature-copilot:node-end ordinal=0
