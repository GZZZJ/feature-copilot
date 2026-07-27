-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_jqh_${bizdate}
-- node_id: n_3771583715193061376
-- task_name: dwa_risk_dz_model_final_16draw_repay_crossed_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_jqh_${bizdate}.json
-- source_json_sha256: 1ece7bdba1fdbba5dcbe0f0aabb2de79e8b0a6e4fde0273c8c8418c3bea5f950
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_detail
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_detail
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_final_16draw_repay_crossed
--创建者: 颜弘彪
--创建日期: 2022-06-22 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1 as 
select 
         main.uid
        ,main.mdl_dte
        ,main.dtl_rep_dte
        ,main.ddf_mdl_rep_dte
        ,main.his_rep_stg_pln_1m_flg
        ,main.his_rep_stg_pln_3m_flg
        ,main.his_rep_stg_pln_6m_flg
        ,main.his_rep_stg_pln_12m_flg
        ,main.rep_prc_amt -- 到期应还金额
        ,main.rep_dte_rn
        ,main.ddf_rep_dte_ord_crt_tim  -- 借款时间和应还日差
        ,main.rct_dtl_ord_no -- 每笔分期计划近期（前后7天内）的order_no
        ,main.crt_tim
        ,main.prc_amt
        ,main.stg_num
        ,main.ord_stt_flg

        -- 到期应还日之前的时间切片（当天、过去1/3/5/7天）
        ,case when ddf_rep_dte_ord_crt_tim = 0 then 1 else 0 end as ddf_0_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 1 then 1 else 0 end as ddf_1_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 3 then 1 else 0 end as ddf_3_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 5 then 1 else 0 end as ddf_5_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 7 then 1 else 0 end as ddf_7_flg
        
        ,case when ddf_rep_dte_ord_crt_tim between -1 and 0 then 1 else 0 end as ddf_neg_1_flg
        ,case when ddf_rep_dte_ord_crt_tim between -3 and 0 then 1 else 0 end as ddf_neg_3_flg
        ,case when ddf_rep_dte_ord_crt_tim between -5 and 0 then 1 else 0 end as ddf_neg_5_flg
        ,case when ddf_rep_dte_ord_crt_tim between -7 and 0 then 1 else 0 end as ddf_neg_7_flg

from 
        (select 
                plan.uid
                ,plan.mdl_dte
                ,plan.dtl_rep_dte
                ,plan.ddf_mdl_rep_dte
                ,plan.his_rep_stg_pln_1m_flg
                ,plan.his_rep_stg_pln_3m_flg
                ,plan.his_rep_stg_pln_6m_flg
                ,plan.his_rep_stg_pln_12m_flg
                ,plan.rep_prc_amt -- 到期应还金额
                ,plan.rep_dte_rn
                ,datediff(date(plan.dtl_rep_dte),date(order_info.crt_tim)) as ddf_rep_dte_ord_crt_tim  -- 借款时间和应还日差
                ,order_info.rct_dtl_ord_no -- 每笔分期计划近期（前后7天内）的order_no
                ,order_info.crt_tim
                ,order_info.prc_amt
                ,order_info.stg_num
                ,order_info.ord_stt_flg
        from    (select uid
                        ,mdl_dte
                        ,dtl_rep_dte
                        ,ddf_mdl_rep_dte
                        ,his_rep_stg_pln_1m_flg
                        ,his_rep_stg_pln_3m_flg
                        ,his_rep_stg_pln_6m_flg
                        ,his_rep_stg_pln_12m_flg
                        ,sum(prc_amt) as rep_prc_amt -- 到期应还金额
                        , dense_rank() over(partition by uid order by dtl_rep_dte desc) rep_dte_rn
                from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail
                where is_his_rep_stg_pln = 1 -- 历史应还分期计划
                and ovd_rep_flg = 0  -- 未逾期 **** 即应还日 == 实还日 -- todo：一般化
                and ddf_mdl_rep_dte >= 1
                group by uid
                        ,mdl_dte
                        ,dtl_rep_dte
                        ,ddf_mdl_rep_dte
                        ,his_rep_stg_pln_1m_flg
                        ,his_rep_stg_pln_3m_flg
                        ,his_rep_stg_pln_6m_flg
                        ,his_rep_stg_pln_12m_flg
                ) plan
                left join 
                (select uid
                        ,mdl_dte
                        ,dtl_ord_no as rct_dtl_ord_no
                        ,crt_tim
                        ,prc_amt
                        ,stg_num
                        ,ord_stt_flg
                from  ${dwa_risk}.dwa_risk_f_heavy_order_info_detail-- 历史交易订单（成功）
                where ord_stt_flg in ('success')
                ) order_info 
                on order_info.uid=plan.uid
        where datediff(date(order_info.crt_tim),date(plan.dtl_rep_dte)) between -7 and 7  -- 每笔分期计划近期（前后7天内）的order_no
        )main;
        
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2 as
select
  uid
  ,mdl_dte
-- features range start --
  -- 交易笔数、金额、件均、最大、最低，金额/当前应还比例；
  -- 还款日前及当天的动支
  ,count(case when rep_dte_rn = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as lst_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as lst_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as lst_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as lst_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as lst_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as lst_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as lst_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as lst_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as lst_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as lst_rep_dte_5_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as lst_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as lst_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as lst_rep_dte_7_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as lst_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as lst_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_7_crt_dt_rep_prc_amt


  ,count(case when rep_dte_rn = 2 and ddf_0_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_0_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_0_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_0_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 2 and ddf_1_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_1_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_1_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_1_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 2 and ddf_3_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_3_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_3_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_3_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 2 and ddf_5_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_5_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_5_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_5_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_5_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 2 and ddf_7_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_7_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_7_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_7_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_7_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_7_crt_dt_rep_prc_amt
  
  -- datediff('评分日',dtl_rep_dte) <= 1m
  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_5_crt_dt_sum_prc_amt
  ,avg(case when his_rep_stg_pln_1m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_5_crt_dt_avg_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_7_crt_dt_sum_prc_amt
  ,avg(case when his_rep_stg_pln_1m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_7_crt_dt_avg_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_7_crt_dt_rep_prc_amt
  
  -- datediff('评分日',dtl_rep_dte) <= 3m
  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_5_crt_dt_sum_prc_amt
  ,avg(case when his_rep_stg_pln_3m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_5_crt_dt_avg_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_7_crt_dt_sum_prc_amt
  ,avg(case when his_rep_stg_pln_3m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_7_crt_dt_avg_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_7_crt_dt_rep_prc_amt
  
  
  -- his_rep_stg_pln_6m_flg = 1
  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_1_crt_dt_sum_prc_amt
  ,avg(case when his_rep_stg_pln_6m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_1_crt_dt_avg_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_7_crt_dt_rep_prc_amt
  
  -- his_rep_stg_pln_12m_flg = 1
  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_7_crt_dt_rep_prc_amt

  
  
  -- 还款日后的动支
  
  ,count(case when rep_dte_rn = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as lst_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,avg(case when rep_dte_rn = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_7_crt_dt_avg_prc_amt
  ,max(case when rep_dte_rn = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as lst_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as lst_rep_dte_neg_7_crt_dt_rep_prc_amt


  ,count(case when rep_dte_rn = 2 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 2 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 2 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when rep_dte_rn = 2 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as lst_2_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when rep_dte_rn = 2 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when rep_dte_rn = 2 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as lst_2_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when rep_dte_rn = 2 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as lst_2_rep_dte_neg_7_crt_dt_rep_prc_amt
  
  -- his_rep_stg_pln_1m_flg = 1
  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as ddf_1m_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_1m_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_1m_flg = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as ddf_1m_rep_dte_neg_7_crt_dt_rep_prc_amt

  -- his_rep_stg_pln_3m_flg = 1
  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as ddf_3m_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_3m_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_3m_flg = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as ddf_3m_rep_dte_neg_7_crt_dt_rep_prc_amt
  
  
  -- his_rep_stg_pln_6m_flg = 1
  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as ddf_6m_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_6m_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_6m_flg = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as ddf_6m_rep_dte_neg_7_crt_dt_rep_prc_amt
  
  -- his_rep_stg_pln_12m_flg = 1
  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as ddf_12m_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_12m_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_12m_flg = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as ddf_12m_rep_dte_neg_7_crt_dt_rep_prc_amt


  --借新还旧时间间隔 min max avg
  ,min(case when ddf_1_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_1
  ,max(case when ddf_1_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_1
  ,avg(case when ddf_1_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_1

  ,min(case when ddf_3_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_3
  ,max(case when ddf_3_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_3
  ,avg(case when ddf_3_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_3

  ,min(case when ddf_5_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_5
  ,max(case when ddf_5_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_5
  ,avg(case when ddf_5_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_5

  ,min(case when ddf_7_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_7
  ,max(case when ddf_7_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_7
  ,avg(case when ddf_7_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_7

  ,min(case when ddf_neg_1_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_neg_1
  ,max(case when ddf_neg_1_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_neg_1
  ,avg(case when ddf_neg_1_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_neg_1

  ,min(case when ddf_neg_3_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_neg_3
  ,max(case when ddf_neg_3_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_neg_3
  ,avg(case when ddf_neg_3_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_neg_3

  ,min(case when ddf_neg_5_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_neg_5
  ,max(case when ddf_neg_5_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_neg_5
  ,avg(case when ddf_neg_5_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_neg_5

  ,min(case when ddf_neg_7_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as min_ddf_rep_dte_ord_crt_tim_neg_7
  ,max(case when ddf_neg_7_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as max_ddf_rep_dte_ord_crt_tim_neg_7
  ,avg(case when ddf_neg_7_flg = 1 then datediff(dtl_rep_dte,crt_tim) else null end) as avg_ddf_rep_dte_ord_crt_tim_neg_7


-- features range end --
  
from ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1

group by   
  uid
  ,mdl_dte;


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_df partition(ds='${bizdate}')  
select model_data.uid
        ,model_data.mdl_dte
-- features range start --
    ,coalesce( lst_rep_dte_0_crt_dt_ord_cnt,0) as lst_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_0_crt_dt_sum_prc_amt,0) as lst_rep_dte_0_crt_dt_sum_prc_amt
    ,lst_rep_dte_0_crt_dt_sum_prc_amt / lst_rep_dte_0_crt_dt_ord_cnt as lst_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_0_crt_dt_max_prc_amt,0) as lst_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_0_crt_dt_min_prc_amt,0) as lst_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_0_crt_dt_rep_prc_amt,0) as lst_rep_dte_0_crt_dt_rep_prc_amt
    ,lst_rep_dte_0_crt_dt_sum_prc_amt / lst_rep_dte_0_crt_dt_rep_prc_amt as lst_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_1_crt_dt_ord_cnt,0) as lst_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_1_crt_dt_sum_prc_amt,0) as lst_rep_dte_1_crt_dt_sum_prc_amt
    ,lst_rep_dte_1_crt_dt_sum_prc_amt / lst_rep_dte_1_crt_dt_ord_cnt as lst_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_1_crt_dt_max_prc_amt,0) as lst_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_1_crt_dt_min_prc_amt,0) as lst_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_1_crt_dt_rep_prc_amt,0) as lst_rep_dte_1_crt_dt_rep_prc_amt
    ,lst_rep_dte_1_crt_dt_sum_prc_amt / lst_rep_dte_1_crt_dt_rep_prc_amt as lst_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_3_crt_dt_ord_cnt,0) as lst_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_3_crt_dt_sum_prc_amt,0) as lst_rep_dte_3_crt_dt_sum_prc_amt
    ,lst_rep_dte_3_crt_dt_sum_prc_amt / lst_rep_dte_3_crt_dt_ord_cnt as lst_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_3_crt_dt_max_prc_amt,0) as lst_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_3_crt_dt_min_prc_amt,0) as lst_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_3_crt_dt_rep_prc_amt,0) as lst_rep_dte_3_crt_dt_rep_prc_amt
    ,lst_rep_dte_3_crt_dt_sum_prc_amt / lst_rep_dte_3_crt_dt_rep_prc_amt as lst_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_5_crt_dt_ord_cnt,0) as lst_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_5_crt_dt_sum_prc_amt,0) as lst_rep_dte_5_crt_dt_sum_prc_amt
    ,lst_rep_dte_5_crt_dt_sum_prc_amt / lst_rep_dte_5_crt_dt_ord_cnt as lst_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_5_crt_dt_max_prc_amt,0) as lst_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_5_crt_dt_min_prc_amt,0) as lst_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_5_crt_dt_rep_prc_amt,0) as lst_rep_dte_5_crt_dt_rep_prc_amt
    ,lst_rep_dte_5_crt_dt_sum_prc_amt / lst_rep_dte_5_crt_dt_rep_prc_amt as lst_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_7_crt_dt_ord_cnt,0) as lst_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_7_crt_dt_sum_prc_amt,0) as lst_rep_dte_7_crt_dt_sum_prc_amt
    ,lst_rep_dte_7_crt_dt_sum_prc_amt / lst_rep_dte_7_crt_dt_ord_cnt as lst_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_7_crt_dt_max_prc_amt,0) as lst_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_7_crt_dt_min_prc_amt,0) as lst_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_7_crt_dt_rep_prc_amt,0) as lst_rep_dte_7_crt_dt_rep_prc_amt
    ,lst_rep_dte_7_crt_dt_sum_prc_amt / lst_rep_dte_7_crt_dt_rep_prc_amt as lst_rep_dte_7_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_0_crt_dt_ord_cnt,0) as lst_2_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_0_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_0_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_0_crt_dt_sum_prc_amt / lst_2_rep_dte_0_crt_dt_ord_cnt as lst_2_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_0_crt_dt_max_prc_amt,0) as lst_2_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_0_crt_dt_min_prc_amt,0) as lst_2_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_0_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_0_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_0_crt_dt_sum_prc_amt / lst_2_rep_dte_0_crt_dt_rep_prc_amt as lst_2_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_1_crt_dt_ord_cnt,0) as lst_2_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_1_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_1_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_1_crt_dt_sum_prc_amt / lst_2_rep_dte_1_crt_dt_ord_cnt as lst_2_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_1_crt_dt_max_prc_amt,0) as lst_2_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_1_crt_dt_min_prc_amt,0) as lst_2_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_1_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_1_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_1_crt_dt_sum_prc_amt / lst_2_rep_dte_1_crt_dt_rep_prc_amt as lst_2_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_3_crt_dt_ord_cnt,0) as lst_2_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_3_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_3_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_3_crt_dt_sum_prc_amt / lst_2_rep_dte_3_crt_dt_ord_cnt as lst_2_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_3_crt_dt_max_prc_amt,0) as lst_2_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_3_crt_dt_min_prc_amt,0) as lst_2_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_3_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_3_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_3_crt_dt_sum_prc_amt / lst_2_rep_dte_3_crt_dt_rep_prc_amt as lst_2_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_5_crt_dt_ord_cnt,0) as lst_2_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_5_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_5_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_5_crt_dt_sum_prc_amt / lst_2_rep_dte_5_crt_dt_ord_cnt as lst_2_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_5_crt_dt_max_prc_amt,0) as lst_2_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_5_crt_dt_min_prc_amt,0) as lst_2_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_5_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_5_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_5_crt_dt_sum_prc_amt / lst_2_rep_dte_5_crt_dt_rep_prc_amt as lst_2_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_7_crt_dt_ord_cnt,0) as lst_2_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_7_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_7_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_7_crt_dt_sum_prc_amt / lst_2_rep_dte_7_crt_dt_ord_cnt as lst_2_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_7_crt_dt_max_prc_amt,0) as lst_2_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_7_crt_dt_min_prc_amt,0) as lst_2_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_7_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_7_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_7_crt_dt_sum_prc_amt / lst_2_rep_dte_7_crt_dt_rep_prc_amt as lst_2_rep_dte_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_0_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_0_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_0_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_0_crt_dt_sum_prc_amt / ddf_1m_rep_dte_0_crt_dt_ord_cnt as ddf_1m_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_0_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_0_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_0_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_0_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_0_crt_dt_sum_prc_amt / ddf_1m_rep_dte_0_crt_dt_rep_prc_amt as ddf_1m_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_1_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_1_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_1_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_1_crt_dt_sum_prc_amt / ddf_1m_rep_dte_1_crt_dt_ord_cnt as ddf_1m_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_1_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_1_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_1_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_1_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_1_crt_dt_sum_prc_amt / ddf_1m_rep_dte_1_crt_dt_rep_prc_amt as ddf_1m_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_3_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_3_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_3_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_3_crt_dt_sum_prc_amt / ddf_1m_rep_dte_3_crt_dt_ord_cnt as ddf_1m_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_3_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_3_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_3_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_3_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_3_crt_dt_sum_prc_amt / ddf_1m_rep_dte_3_crt_dt_rep_prc_amt as ddf_1m_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_5_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_5_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_5_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_5_crt_dt_sum_prc_amt / ddf_1m_rep_dte_5_crt_dt_ord_cnt as ddf_1m_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_5_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_5_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_5_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_5_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_5_crt_dt_sum_prc_amt / ddf_1m_rep_dte_5_crt_dt_rep_prc_amt as ddf_1m_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_7_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_7_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_7_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_7_crt_dt_sum_prc_amt / ddf_1m_rep_dte_7_crt_dt_ord_cnt as ddf_1m_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_7_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_7_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_7_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_7_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_7_crt_dt_sum_prc_amt / ddf_1m_rep_dte_7_crt_dt_rep_prc_amt as ddf_1m_rep_dte_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_0_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_0_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_0_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_0_crt_dt_sum_prc_amt / ddf_3m_rep_dte_0_crt_dt_ord_cnt as ddf_3m_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_0_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_0_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_0_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_0_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_0_crt_dt_sum_prc_amt / ddf_3m_rep_dte_0_crt_dt_rep_prc_amt as ddf_3m_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_1_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_1_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_1_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_1_crt_dt_sum_prc_amt / ddf_3m_rep_dte_1_crt_dt_ord_cnt as ddf_3m_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_1_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_1_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_1_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_1_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_1_crt_dt_sum_prc_amt / ddf_3m_rep_dte_1_crt_dt_rep_prc_amt as ddf_3m_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_3_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_3_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_3_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_3_crt_dt_sum_prc_amt / ddf_3m_rep_dte_3_crt_dt_ord_cnt as ddf_3m_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_3_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_3_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_3_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_3_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_3_crt_dt_sum_prc_amt / ddf_3m_rep_dte_3_crt_dt_rep_prc_amt as ddf_3m_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_5_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_5_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_5_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_5_crt_dt_sum_prc_amt / ddf_3m_rep_dte_5_crt_dt_ord_cnt as ddf_3m_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_5_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_5_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_5_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_5_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_5_crt_dt_sum_prc_amt / ddf_3m_rep_dte_5_crt_dt_rep_prc_amt as ddf_3m_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_7_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_7_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_7_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_7_crt_dt_sum_prc_amt / ddf_3m_rep_dte_7_crt_dt_ord_cnt as ddf_3m_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_7_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_7_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_7_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_7_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_7_crt_dt_sum_prc_amt / ddf_3m_rep_dte_7_crt_dt_rep_prc_amt as ddf_3m_rep_dte_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_0_crt_dt_ord_cnt,0) as  ddf_6m_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_0_crt_dt_sum_prc_amt,0) as  ddf_6m_rep_dte_0_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_0_crt_dt_sum_prc_amt / ddf_6m_rep_dte_0_crt_dt_ord_cnt  as ddf_6m_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_0_crt_dt_max_prc_amt,0) as  ddf_6m_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_0_crt_dt_min_prc_amt,0) as  ddf_6m_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_0_crt_dt_rep_prc_amt,0) as  ddf_6m_rep_dte_0_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_0_crt_dt_sum_prc_amt / ddf_6m_rep_dte_0_crt_dt_rep_prc_amt as ddf_6m_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_1_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_1_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_1_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_1_crt_dt_sum_prc_amt / ddf_6m_rep_dte_1_crt_dt_ord_cnt as ddf_6m_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_1_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_1_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_1_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_1_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_1_crt_dt_sum_prc_amt / ddf_6m_rep_dte_1_crt_dt_rep_prc_amt as ddf_6m_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_3_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_3_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_3_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_3_crt_dt_sum_prc_amt / ddf_6m_rep_dte_3_crt_dt_ord_cnt as ddf_6m_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_3_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_3_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_3_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_3_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_3_crt_dt_sum_prc_amt / ddf_6m_rep_dte_3_crt_dt_rep_prc_amt as ddf_6m_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_5_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_5_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_5_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_5_crt_dt_sum_prc_amt / ddf_6m_rep_dte_5_crt_dt_ord_cnt as ddf_6m_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_5_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_5_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_5_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_5_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_5_crt_dt_sum_prc_amt / ddf_6m_rep_dte_5_crt_dt_rep_prc_amt as ddf_6m_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_7_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_7_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_7_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_7_crt_dt_sum_prc_amt / ddf_6m_rep_dte_7_crt_dt_ord_cnt as ddf_6m_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_7_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_7_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_7_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_7_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_7_crt_dt_sum_prc_amt / ddf_6m_rep_dte_7_crt_dt_rep_prc_amt as ddf_6m_rep_dte_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_0_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_0_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_0_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_0_crt_dt_sum_prc_amt / ddf_12m_rep_dte_0_crt_dt_ord_cnt as ddf_12m_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_0_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_0_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_0_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_0_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_0_crt_dt_sum_prc_amt / ddf_12m_rep_dte_0_crt_dt_rep_prc_amt as ddf_12m_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_1_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_1_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_1_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_1_crt_dt_ord_cnt as ddf_12m_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_1_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_1_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_1_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_1_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_1_crt_dt_rep_prc_amt as ddf_12m_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_3_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_3_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_3_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_3_crt_dt_ord_cnt as ddf_12m_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_3_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_3_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_3_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_3_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_3_crt_dt_rep_prc_amt as ddf_12m_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_5_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_5_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_5_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_5_crt_dt_ord_cnt as ddf_12m_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_5_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_5_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_5_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_5_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_5_crt_dt_rep_prc_amt as ddf_12m_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_7_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_7_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_7_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_7_crt_dt_ord_cnt as ddf_12m_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_7_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_7_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_7_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_7_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_7_crt_dt_rep_prc_amt as ddf_12m_rep_dte_7_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_neg_1_crt_dt_ord_cnt,0) as lst_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as lst_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,lst_rep_dte_neg_1_crt_dt_sum_prc_amt / lst_rep_dte_neg_1_crt_dt_ord_cnt as lst_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_neg_1_crt_dt_max_prc_amt,0) as lst_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_neg_1_crt_dt_min_prc_amt,0) as lst_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as lst_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,lst_rep_dte_neg_1_crt_dt_sum_prc_amt / lst_rep_dte_neg_1_crt_dt_rep_prc_amt as lst_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_neg_3_crt_dt_ord_cnt,0) as lst_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as lst_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,lst_rep_dte_neg_3_crt_dt_sum_prc_amt / lst_rep_dte_neg_3_crt_dt_ord_cnt as lst_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_neg_3_crt_dt_max_prc_amt,0) as lst_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_neg_3_crt_dt_min_prc_amt,0) as lst_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as lst_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,lst_rep_dte_neg_3_crt_dt_sum_prc_amt / lst_rep_dte_neg_3_crt_dt_rep_prc_amt as lst_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_neg_5_crt_dt_ord_cnt,0) as lst_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as lst_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,lst_rep_dte_neg_5_crt_dt_sum_prc_amt / lst_rep_dte_neg_5_crt_dt_ord_cnt as lst_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_neg_5_crt_dt_max_prc_amt,0) as lst_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_neg_5_crt_dt_min_prc_amt,0) as lst_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as lst_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,lst_rep_dte_neg_5_crt_dt_sum_prc_amt / lst_rep_dte_neg_5_crt_dt_rep_prc_amt as lst_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_rep_dte_neg_7_crt_dt_ord_cnt,0) as lst_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( lst_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as lst_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,lst_rep_dte_neg_7_crt_dt_sum_prc_amt / lst_rep_dte_neg_7_crt_dt_ord_cnt as lst_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( lst_rep_dte_neg_7_crt_dt_max_prc_amt,0) as lst_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( lst_rep_dte_neg_7_crt_dt_min_prc_amt,0) as lst_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( lst_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as lst_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,lst_rep_dte_neg_7_crt_dt_sum_prc_amt / lst_rep_dte_neg_7_crt_dt_rep_prc_amt as lst_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_neg_1_crt_dt_ord_cnt,0) as lst_2_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_neg_1_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_1_crt_dt_ord_cnt as lst_2_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_neg_1_crt_dt_max_prc_amt,0) as lst_2_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_neg_1_crt_dt_min_prc_amt,0) as lst_2_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_neg_1_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_1_crt_dt_rep_prc_amt as lst_2_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_neg_3_crt_dt_ord_cnt,0) as lst_2_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_neg_3_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_3_crt_dt_ord_cnt as lst_2_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_neg_3_crt_dt_max_prc_amt,0) as lst_2_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_neg_3_crt_dt_min_prc_amt,0) as lst_2_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_neg_3_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_3_crt_dt_rep_prc_amt as lst_2_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_neg_5_crt_dt_ord_cnt,0) as lst_2_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_neg_5_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_5_crt_dt_ord_cnt as lst_2_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_neg_5_crt_dt_max_prc_amt,0) as lst_2_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_neg_5_crt_dt_min_prc_amt,0) as lst_2_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_neg_5_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_5_crt_dt_rep_prc_amt as lst_2_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( lst_2_rep_dte_neg_7_crt_dt_ord_cnt,0) as lst_2_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( lst_2_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as lst_2_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,lst_2_rep_dte_neg_7_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_7_crt_dt_ord_cnt as lst_2_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( lst_2_rep_dte_neg_7_crt_dt_max_prc_amt,0) as lst_2_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( lst_2_rep_dte_neg_7_crt_dt_min_prc_amt,0) as lst_2_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( lst_2_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as lst_2_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,lst_2_rep_dte_neg_7_crt_dt_sum_prc_amt / lst_2_rep_dte_neg_7_crt_dt_rep_prc_amt as lst_2_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_neg_1_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_1_crt_dt_ord_cnt as ddf_1m_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_1_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_1_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_1_crt_dt_rep_prc_amt as ddf_1m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_neg_3_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_3_crt_dt_ord_cnt as ddf_1m_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_3_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_3_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_3_crt_dt_rep_prc_amt as ddf_1m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_neg_5_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_5_crt_dt_ord_cnt as ddf_1m_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_5_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_5_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_5_crt_dt_rep_prc_amt as ddf_1m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_1m_rep_dte_neg_7_crt_dt_ord_cnt,0) as ddf_1m_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( ddf_1m_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as ddf_1m_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,ddf_1m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_7_crt_dt_ord_cnt as ddf_1m_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_7_crt_dt_max_prc_amt,0) as ddf_1m_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_7_crt_dt_min_prc_amt,0) as ddf_1m_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( ddf_1m_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as ddf_1m_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,ddf_1m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_1m_rep_dte_neg_7_crt_dt_rep_prc_amt as ddf_1m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_neg_1_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_1_crt_dt_ord_cnt as ddf_3m_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_1_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_1_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_1_crt_dt_rep_prc_amt as ddf_3m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_neg_3_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_3_crt_dt_ord_cnt as ddf_3m_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_3_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_3_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_3_crt_dt_rep_prc_amt as ddf_3m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_neg_5_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_5_crt_dt_ord_cnt as ddf_3m_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_5_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_5_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_5_crt_dt_rep_prc_amt as ddf_3m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_3m_rep_dte_neg_7_crt_dt_ord_cnt,0) as ddf_3m_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( ddf_3m_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as ddf_3m_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,ddf_3m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_7_crt_dt_ord_cnt as ddf_3m_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_7_crt_dt_max_prc_amt,0) as ddf_3m_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_7_crt_dt_min_prc_amt,0) as ddf_3m_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( ddf_3m_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as ddf_3m_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,ddf_3m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_3m_rep_dte_neg_7_crt_dt_rep_prc_amt as ddf_3m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_neg_1_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_1_crt_dt_ord_cnt as ddf_6m_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_1_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_1_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_1_crt_dt_rep_prc_amt as ddf_6m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_neg_3_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_3_crt_dt_ord_cnt as ddf_6m_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_3_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_3_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_3_crt_dt_rep_prc_amt as ddf_6m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_neg_5_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_5_crt_dt_ord_cnt as ddf_6m_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_5_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_5_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_5_crt_dt_rep_prc_amt as ddf_6m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_6m_rep_dte_neg_7_crt_dt_ord_cnt,0) as ddf_6m_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( ddf_6m_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as ddf_6m_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,ddf_6m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_7_crt_dt_ord_cnt as ddf_6m_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_7_crt_dt_max_prc_amt,0) as ddf_6m_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_7_crt_dt_min_prc_amt,0) as ddf_6m_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( ddf_6m_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as ddf_6m_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,ddf_6m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_6m_rep_dte_neg_7_crt_dt_rep_prc_amt as ddf_6m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_neg_1_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_1_crt_dt_ord_cnt as ddf_12m_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_1_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_1_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_1_crt_dt_rep_prc_amt as ddf_12m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_neg_3_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_3_crt_dt_ord_cnt as ddf_12m_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_3_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_3_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_3_crt_dt_rep_prc_amt as ddf_12m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_neg_5_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_5_crt_dt_ord_cnt as ddf_12m_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_5_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_5_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_5_crt_dt_rep_prc_amt as ddf_12m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_12m_rep_dte_neg_7_crt_dt_ord_cnt,0) as ddf_12m_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_7_crt_dt_ord_cnt as ddf_12m_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_7_crt_dt_max_prc_amt,0) as ddf_12m_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_7_crt_dt_min_prc_amt,0) as ddf_12m_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( ddf_12m_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as ddf_12m_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_7_crt_dt_rep_prc_amt as ddf_12m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

    ,min_ddf_rep_dte_ord_crt_tim_1
    ,max_ddf_rep_dte_ord_crt_tim_1
    ,avg_ddf_rep_dte_ord_crt_tim_1

    ,min_ddf_rep_dte_ord_crt_tim_3
    ,max_ddf_rep_dte_ord_crt_tim_3
    ,avg_ddf_rep_dte_ord_crt_tim_3

    ,min_ddf_rep_dte_ord_crt_tim_5
    ,max_ddf_rep_dte_ord_crt_tim_5
    ,avg_ddf_rep_dte_ord_crt_tim_5

    ,min_ddf_rep_dte_ord_crt_tim_7
    ,max_ddf_rep_dte_ord_crt_tim_7
    ,avg_ddf_rep_dte_ord_crt_tim_7

    ,min_ddf_rep_dte_ord_crt_tim_neg_1
    ,max_ddf_rep_dte_ord_crt_tim_neg_1
    ,avg_ddf_rep_dte_ord_crt_tim_neg_1

    ,min_ddf_rep_dte_ord_crt_tim_neg_3
    ,max_ddf_rep_dte_ord_crt_tim_neg_3
    ,avg_ddf_rep_dte_ord_crt_tim_neg_3

    ,min_ddf_rep_dte_ord_crt_tim_neg_5
    ,max_ddf_rep_dte_ord_crt_tim_neg_5
    ,avg_ddf_rep_dte_ord_crt_tim_neg_5

    ,min_ddf_rep_dte_ord_crt_tim_neg_7
    ,max_ddf_rep_dte_ord_crt_tim_neg_7
    ,avg_ddf_rep_dte_ord_crt_tim_neg_7


-- features range end --
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2 temp_grouped on model_data.uid=temp_grouped.uid;
-- feature-copilot:node-end ordinal=0
