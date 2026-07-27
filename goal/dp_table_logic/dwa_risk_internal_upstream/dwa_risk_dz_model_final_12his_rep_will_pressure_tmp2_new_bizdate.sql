-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2_new_bizdate
-- node_id: n_3766288776431009792
-- task_name: dwa_risk_dz_model_final_12his_rep_will_pressure_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2_new_bizdate.json
-- source_json_sha256: 2de52a4d22604bfbb737caba8b41fef1e8312870b4cf74d1bac0990e69ca8546
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_detail

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_temp_12stage_plan
--创建者: 颜弘彪
--创建日期: 2022-06-22 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1 as 
select uid
        ,mdl_dte
-- features range start --
        ----------------------------------------------------------
        --/*12.1.1 历史还款意愿*/
        ----------------------------------------------------------

        ---------/*【还清口径：实还日和评分日间隔】近7/14天/1/3/6/12个月/历史*/---------------
        --/*还清金额*/
        ,sum(case when rep_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt
        ,sum(case when rep_7d_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_7d
        ,sum(case when rep_14d_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_14d
        ,sum(case when rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_1m
        ,sum(case when rep_3m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_3m
        ,sum(case when rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_6m
        ,sum(case when rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_12m
        --/*还清金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 and rep_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_fst_ord
        ,sum(case when cur_ord_flg=1 and rep_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_sum_prc_amt_cur_ord

        --/*还清金额--单笔最大*/
        ,max(case when rep_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_max_prc_amt
        ,max(case when rep_7d_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_max_prc_amt_7d
        ,max(case when rep_14d_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_max_prc_amt_14d
        ,max(case when rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_max_prc_amt_1m
        ,max(case when rep_3m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_max_prc_amt_3m
        ,max(case when rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_max_prc_amt_6m
        ,max(case when rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_max_prc_amt_12m
        --/*还清金额--单笔最小*/
        ,min(case when rep_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_min_prc_amt
        ,min(case when rep_7d_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_min_prc_amt_7d
        ,min(case when rep_14d_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_min_prc_amt_14d
        ,min(case when rep_1m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_min_prc_amt_1m
        ,min(case when rep_3m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_min_prc_amt_3m
        ,min(case when rep_6m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_min_prc_amt_6m
        ,min(case when rep_12m_flg=1 then prc_amt else 0 end) as stg_pln_pay_off_min_prc_amt_12m
        --/*还清分期数*/
        ,count(case when rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt
        ,count(case when rep_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_7d
        ,count(case when rep_14d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_14d
        ,count(case when rep_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_1m
        ,count(case when rep_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_3m
        ,count(case when rep_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_6m
        ,count(case when rep_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_12m
        --/*还清分期数*/*首借订单和当前订单*/
        ,count(case when fst_ord_flg=1 and rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_fst_ord
        ,count(case when cur_ord_flg=1 and rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_pay_off_cnt_cur_ord
        
        --/*最近一次还清日距评分日天数*/
        ,min(case when rep_flg=1 then ddf_mdl_rep_dte else null end) as min_pay_off_ddf_mdl_rep_dte

        --还清金额（单日最大）
        ,max(case when rep_flg=1 then prc_amt_pday else 0 end) as stg_pln_pay_off_max_prc_amt_pday
        ,max(case when rep_7d_flg=1 then prc_amt_pday else 0 end) as stg_pln_pay_off_max_prc_amt_pday_7d
        ,max(case when rep_14d_flg=1 then prc_amt_pday else 0 end) as stg_pln_pay_off_max_prc_amt_pday_14d
        ,max(case when rep_1m_flg=1 then prc_amt_pday else 0 end) as stg_pln_pay_off_max_prc_amt_pday_1m
        ,max(case when rep_3m_flg=1 then prc_amt_pday else 0 end) as stg_pln_pay_off_max_prc_amt_pday_3m
        ,max(case when rep_6m_flg=1 then prc_amt_pday else 0 end) as stg_pln_pay_off_max_prc_amt_pday_6m
        ,max(case when rep_12m_flg=1 then prc_amt_pday else 0 end) as stg_pln_pay_off_max_prc_amt_pday_12m

        --还清金额（近3月单月最大）
        ,max(prc_amt_pmth_3m) as max_prc_amt_pmth_3m
        
        -----------------------/*【应还日和实还日间隔】还款状态：提前还款*/-----------------------
        --提前还款时间切片--历史提前/3/7/14天/1/2/3个月提前还款
        --/*金额--*/
        ,sum(case when adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv
        ,sum(case when adv_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_3d
        ,sum(case when adv_7d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_7d
        ,sum(case when adv_14d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_14d
        ,sum(case when adv_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_1m
        ,sum(case when adv_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_2m
        ,sum(case when adv_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_3m
        -- ,sum(case when adv_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_6m
        -- ,sum(case when adv_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_12m
        --/*金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_fst_ord
        ,sum(case when cur_ord_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_cur_ord
        
        --/*金额--单笔最大*/
        ,max(case when adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv
        ,max(case when adv_3d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_3d
        ,max(case when adv_7d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_7d
        ,max(case when adv_14d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_14d
        ,max(case when adv_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_1m
        ,max(case when adv_2m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_2m
        ,max(case when adv_3m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_3m
        -- ,max(case when adv_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_6m
        -- ,max(case when adv_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_12m
        -- --/*金额--单笔最大/*首借订单和当前订单*/
        -- ,max(case when fst_ord_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_fst_ord
        -- ,max(case when cur_ord_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_cur_ord
        
        --/*金额--单笔最小*/
        ,min(case when adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv
        ,min(case when adv_3d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_3d
        ,min(case when adv_7d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_7d
        ,min(case when adv_14d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_14d
        ,min(case when adv_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_1m
        ,min(case when adv_2m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_2m
        ,min(case when adv_3m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_3m
        -- ,min(case when adv_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_6m
        -- ,min(case when adv_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_12m
        -- --/*金额--单笔最小/*首借订单和当前订单*/
        -- ,min(case when fst_ord_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_fst_ord
        -- ,min(case when cur_ord_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_cur_ord
        
        --/*分期数*/
        ,count(case when adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv
        ,count(case when adv_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_3d
        ,count(case when adv_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_7d
        ,count(case when adv_14d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_14d
        ,count(case when adv_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_1m
        ,count(case when adv_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_2m
        ,count(case when adv_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_3m
        -- ,count(case when adv_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_6m
        -- ,count(case when adv_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_12m
        --/*分期数*/-/*首借订单和当前订单*/
        ,count(case when fst_ord_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_fst_ord
        ,count(case when cur_ord_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_cur_ord
        
        --/*提前还款天数*/--历史最大、最小
        ,max(case when adv_rep_flg=1 then abs(ddf_rep_tim_dte) else null end) as max_ddf_rep_tim_dte_adv
        ,min(case when adv_rep_flg=1 then abs(ddf_rep_tim_dte) else null end) as min_ddf_rep_tim_dte_adv
        --/*提前还款天数*/--历史最大、最小-/*首借订单和当前订单*/
        ,max(case when fst_ord_flg=1 and adv_rep_flg=1 then abs(ddf_rep_tim_dte) else null end) as max_ddf_rep_tim_dte_adv_fst_ord
        ,min(case when fst_ord_flg=1 and adv_rep_flg=1 then abs(ddf_rep_tim_dte) else null end) as min_ddf_rep_tim_dte_adv_fst_ord
        ,max(case when cur_ord_flg=1 and adv_rep_flg=1 then abs(ddf_rep_tim_dte) else null end) as max_ddf_rep_tim_dte_adv_cur_ord
        ,min(case when cur_ord_flg=1 and adv_rep_flg=1 then abs(ddf_rep_tim_dte) else null end) as min_ddf_rep_tim_dte_adv_cur_ord

        --最近一次提前还款时间距评分日间隔
        ,min(case when adv_rep_flg=1 then ddf_mdl_rep_tim else null end) as min_ddf_mdl_rep_tim_adv

        --------------------------/*【还清口径：实还日和评分日间隔】切片（7/14天/1/3/6/12个月）交叉应还日和实还日间隔（提前还款）*/--------------------------
        --最近7天发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,sum(case when rep_7d_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_7d
        ,max(case when rep_7d_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_7d
        ,min(case when rep_7d_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_7d
        ,count(case when rep_7d_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_7d
        
        --最近14天发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,sum(case when rep_14d_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_14d
        ,max(case when rep_14d_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_14d
        ,min(case when rep_14d_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_14d
        ,count(case when rep_14d_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_14d
        
        --最近1个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,sum(case when rep_1m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_1m
        ,max(case when rep_1m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_1m
        ,min(case when rep_1m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_1m
        ,count(case when rep_1m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_1m
        
        --最近3个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,sum(case when rep_3m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_3m
        ,max(case when rep_3m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_3m
        ,min(case when rep_3m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_3m
        ,count(case when rep_3m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_3m
        
        --最近6个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,sum(case when rep_6m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_6m
        ,max(case when rep_6m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_6m
        ,min(case when rep_6m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_6m
        ,count(case when rep_6m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_6m
        
        --最近12个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,sum(case when rep_12m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rct_12m
        ,max(case when rep_12m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rct_12m
        ,min(case when rep_12m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rct_12m
        ,count(case when rep_12m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rct_12m

        --------------------------/*【应还口径：应还日和评分日间隔】切片（1/3/6/12个月）交叉应还日和实还日间隔（提前还款）*/--------------------------
        --历史所有应还的提前还款
        --/*金额*/
        ,sum(case when is_his_rep_stg_pln=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rep_his
        ,max(case when is_his_rep_stg_pln=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rep_his
        ,min(case when is_his_rep_stg_pln=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rep_his
        --/*分期数*/
        ,count(case when is_his_rep_stg_pln=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rep_his
        
        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_1m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rep_1m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_1m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rep_1m
        
        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_3m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rep_3m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_3m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rep_3m
        
        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_6m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rep_6m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_6m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rep_6m
        
        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_12m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and adv_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_rep_12m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_12m_flg=1 and adv_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_rep_12m


        -----------------------/*【应还+还清口径：应还日+实还日和评分日间隔】还款状态：按时还款*/-----------------------
        --/*金额*/
        ,sum(case when d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_his
        ,max(case when d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_his
        ,min(case when d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_his
        --/*金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_his_fst_ord
        ,max(case when fst_ord_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_his_fst_ord
        ,min(case when fst_ord_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_his_fst_ord
        ,sum(case when cur_ord_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_his_cur_ord
        ,max(case when cur_ord_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_his_cur_ord
        ,min(case when cur_ord_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_his_cur_ord

        --/*分期数*/
        ,count(case when d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_his
        --/*分期数*/*首借订单和当前订单*/
        ,count(case when fst_ord_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_his_fst_ord
        ,count(case when cur_ord_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_his_cur_ord

        --最近一次按时还款时间距评分日间隔
        ,min(case when d0_rep_flg=1 then ddf_mdl_rep_tim else null end) as min_ddf_mdl_rep_tim_d0_rep_his
        

        --------------------------/*【应还口径：应还日和评分日间隔】切片（1/3/6/12个月）交叉应还日和实还日间隔（按时还款）*/--------------------------
        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_1m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_1m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_1m_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_1m
        
        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_3m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_3m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_3m_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_3m
        
        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_6m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_6m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_6m_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_6m
        
        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_12m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_d0_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_d0_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and d0_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_d0_rep_12m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_12m_flg=1 and d0_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_d0_rep_12m



        -----------------------/*【应还口径：应还日和评分日间隔】：按时还款+提前还款（只计算历史应还的部分）*/-----------------------
        --/*金额*/
        ,sum(case when is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_d0_rep_his
        ,max(case when is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_d0_rep_his
        ,min(case when is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_d0_rep_his
        --/*金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_d0_rep_his_fst_ord
        ,max(case when fst_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_d0_rep_his_fst_ord
        ,min(case when fst_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_d0_rep_his_fst_ord
        ,sum(case when cur_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_d0_rep_his_cur_ord
        ,max(case when cur_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_d0_rep_his_cur_ord
        ,min(case when cur_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_d0_rep_his_cur_ord

        --/*分期数*/
        ,count(case when is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_d0_rep_his
        --/*分期数*/*首借订单和当前订单*/
        ,count(case when fst_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_d0_rep_his_fst_ord
        ,count(case when cur_ord_flg=1 and is_his_rep_stg_pln=1 and (adv_rep_flg=1 or d0_rep_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_d0_rep_his_cur_ord


        --------------------------/*应还日与评分日时间间隔切片（1/3/6/12个月）交叉应还日和实还日间隔（非逾期还款=提前还款+按时还款）*/--------------------------
        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_1m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_d0_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_d0_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_d0_rep_1m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_1m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_d0_rep_1m

        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_3m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_d0_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_d0_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_d0_rep_3m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_3m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_d0_rep_3m

        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_6m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_d0_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_d0_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_d0_rep_6m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_6m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_d0_rep_6m

        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_12m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_sum_prc_amt_adv_d0_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_max_prc_amt_adv_d0_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then prc_amt else 0 end) as stg_pln_min_prc_amt_adv_d0_rep_12m
        --/*分期数*/
        ,count(case when his_rep_stg_pln_12m_flg=1 and (adv_rep_flg=1 or d0_rep_flg=1) then dtl_stg_pln_no else null end) as stg_pln_cnt_adv_d0_rep_12m

-- features range end --
from 
        (select *
                ,sum(case when per_rep_mth_flg is not null then prc_amt else 0 end) over(partition by uid,per_rep_mth_flg) as prc_amt_pmth_3m
        from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail
        where is_his_rep_rpm_stg_pln=1 --选取应还时间或者实还时间在评分日之前的分期计划
        )main
group by uid
        ,mdl_dte
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2 as 
select uid
        ,mdl_dte
        
-- features range start --
        -----------------------/*还款状态：逾期*/-----------------------
        --逾期时间切片--逾期3/7/15天、1/2/3个月
        --/*金额--*/
        ,sum(case when ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_pls
        ,sum(case when ovd_rep_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_pls
        ,sum(case when ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_1d_3d
        ,sum(case when ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_3d_pls
        ,sum(case when ovd_3d_pls_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_3d_pls
        ,sum(case when ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_7d_pls
        ,sum(case when ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_14d_pls
        ,sum(case when ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m2_pls
        ,sum(case when ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m3_pls
        ,sum(case when ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m4_pls
        --/*金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_pls_fst_ord
        ,sum(case when cur_ord_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_pls_cur_ord

        --/*金额--单笔最大*/
        ,max(case when ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_pls
        ,max(case when ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_1d_3d
        ,max(case when ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_3d_pls
        ,max(case when ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_7d_pls
        ,max(case when ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_14d_pls
        ,max(case when ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m2_pls
        ,max(case when ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m3_pls
        ,max(case when ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m4_pls
        --/*金额--单笔最大/*首借订单和当前订单*/
        ,max(case when fst_ord_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_pls_fst_ord
        ,max(case when cur_ord_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_pls_cur_ord

        --/*金额--单笔最小*/
        ,min(case when ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_pls
        ,min(case when ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_1d_3d
        ,min(case when ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_3d_pls
        ,min(case when ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_7d_pls
        ,min(case when ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_14d_pls
        ,min(case when ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m2_pls
        ,min(case when ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m3_pls
        ,min(case when ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m4_pls
        --/*金额--单笔最小/*首借订单和当前订单*/
        ,min(case when fst_ord_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_pls_fst_ord
        ,min(case when cur_ord_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_pls_cur_ord
        
        --/*分期数*/
        ,count(case when ovd_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_pls
        ,count(case when ovd_rep_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_pls
        ,count(case when ovd_1d_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_1d_3d
        ,count(case when ovd_3d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_3d_pls
        ,count(case when ovd_3d_pls_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_3d_pls
        ,count(case when ovd_7d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_7d_pls
        ,count(case when ovd_14d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_14d_pls
        ,count(case when ovd_m2_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m2_pls
        ,count(case when ovd_m3_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m3_pls
        ,count(case when ovd_m4_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m4_pls
        --/*分期数*/*首借订单和当前订单*/
        ,count(case when fst_ord_flg=1 and ovd_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_pls_fst_ord
        ,count(case when cur_ord_flg=1 and ovd_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_pls_cur_ord

        --最近一次逾期发生时间距评分日间隔（天）
        ,min(case when ovd_rep_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_pls
        ,min(case when ovd_rep_flg=1 and stg_no=1 then ddf_mdl_rep_dte else null end) as min_fst_ddf_mdl_rep_dte_ovd_pls
        ,min(case when ovd_1d_3d_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_1d_3d
        ,min(case when ovd_3d_pls_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_3d_pls
        ,min(case when ovd_3d_pls_flg=1 and stg_no=1 then ddf_mdl_rep_dte else null end) as min_fst_ddf_mdl_rep_dte_ovd_3d_pls
        ,min(case when ovd_7d_pls_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_7d_pls
        ,min(case when ovd_14d_pls_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_14d_pls
        ,min(case when ovd_m2_pls_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_m2_pls
        ,min(case when ovd_m3_pls_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_m3_pls
        ,min(case when ovd_m4_pls_flg=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_ovd_m4_pls
        

        --历史逾期记录最近一次还清时间距建模日间隔（天）
        ,min(case when ovd_rep_flg=1 and rep_tim is not null then ddf_mdl_rep_tim else null end) as min_ddf_mdl_rep_tim_ovd_pls
        
        --/*历史逾期天数*/--历史最大、最小
        ,max(case when ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as max_ddf_rep_tim_dte_ovd_pls
        ,min(case when ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as min_ddf_rep_tim_dte_ovd_pls
        --/*历史逾期天数*/--历史最大、最小/*首借订单和当前订单*/
        ,max(case when fst_ord_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as max_ddf_rep_tim_dte_ovd_pls_fst_ord
        ,min(case when fst_ord_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as min_ddf_rep_tim_dte_ovd_pls_fst_ord
        ,max(case when cur_ord_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as max_ddf_rep_tim_dte_ovd_pls_cur_ord
        ,min(case when cur_ord_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as min_ddf_rep_tim_dte_ovd_pls_cur_ord


        --------------------------/*应还日与评分日时间间隔切片（1/3/6/12个月）交叉应还日和实还日间隔（逾期3/7/15天、1/2/3个月）*/--------------------------
        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_pls_rep_1m
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_1m
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_1m
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_1m
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_1m
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_1m
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_1m
        ,sum(case when his_rep_stg_pln_1m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_1m
        
        --/*金额--单笔最大*/
        ,max(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_pls_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_1d_3d_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_3d_pls_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_7d_pls_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_14d_pls_rep_1m
        ,max(case when his_rep_stg_pln_1m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m2_pls_rep_1m
        
        --/*金额--单笔最小*/
        ,min(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_pls_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_1d_3d_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_3d_pls_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_7d_pls_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_14d_pls_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m2_pls_rep_1m
        
        --/*分期数*/
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_pls_rep_1m
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_pls_rep_1m
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_1d_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_1d_3d_rep_1m
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_3d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_3d_pls_rep_1m
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_3d_pls_rep_1m
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_7d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_7d_pls_rep_1m
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_14d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_14d_pls_rep_1m
        ,count(case when his_rep_stg_pln_1m_flg=1 and ovd_m2_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m2_pls_rep_1m
        
        --/*历史逾期天数*/--历史最大、最小
        ,max(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as max_ddf_rep_tim_dte_ovd_pls_rep_1m
        ,min(case when his_rep_stg_pln_1m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as min_ddf_rep_tim_dte_ovd_pls_rep_1m


        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m3_pls_rep_3m
        ,sum(case when his_rep_stg_pln_3m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m4_pls_rep_3m
        --/*金额--单笔最大*/
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_pls_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_1d_3d_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_3d_pls_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_7d_pls_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_14d_pls_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m2_pls_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m3_pls_rep_3m
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m4_pls_rep_3m
        --/*金额--单笔最小*/
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_pls_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_1d_3d_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_3d_pls_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_7d_pls_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_14d_pls_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m2_pls_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m3_pls_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m4_pls_rep_3m
        
        --/*分期数*/
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_1d_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_1d_3d_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_3d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_3d_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_3d_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_7d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_7d_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_14d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_14d_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_m2_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m2_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_m3_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m3_pls_rep_3m
        ,count(case when his_rep_stg_pln_3m_flg=1 and ovd_m4_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m4_pls_rep_3m
        
        --/*历史逾期天数*/--历史最大、最小
        ,max(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as max_ddf_rep_tim_dte_ovd_pls_rep_3m
        ,min(case when his_rep_stg_pln_3m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as min_ddf_rep_tim_dte_ovd_pls_rep_3m


        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m3_pls_rep_6m
        ,sum(case when his_rep_stg_pln_6m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m4_pls_rep_6m
        --/*金额--单笔最大*/
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_pls_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_1d_3d_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_3d_pls_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_7d_pls_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_14d_pls_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m2_pls_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m3_pls_rep_6m
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m4_pls_rep_6m
        --/*金额--单笔最小*/
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_pls_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_1d_3d_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_3d_pls_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_7d_pls_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_14d_pls_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m2_pls_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m3_pls_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m4_pls_rep_6m
        
        --/*分期数*/
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_1d_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_1d_3d_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_3d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_3d_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_3d_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_7d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_7d_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_14d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_14d_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_m2_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m2_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_m3_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m3_pls_rep_6m
        ,count(case when his_rep_stg_pln_6m_flg=1 and ovd_m4_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m4_pls_rep_6m
        
        --/*历史逾期天数*/--历史最大、最小
        ,max(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as max_ddf_rep_tim_dte_ovd_pls_rep_6m
        ,min(case when his_rep_stg_pln_6m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as min_ddf_rep_tim_dte_ovd_pls_rep_6m


        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then prc_amt else 0 end) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m3_pls_rep_12m
        ,sum(case when his_rep_stg_pln_12m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_m4_pls_rep_12m
        --/*金额--单笔最大*/
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_pls_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_1d_3d_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_3d_pls_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_7d_pls_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_14d_pls_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m2_pls_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m3_pls_rep_12m
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_m4_pls_rep_12m
        --/*金额--单笔最小*/
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_pls_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_1d_3d_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_1d_3d_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_3d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_3d_pls_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_7d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_7d_pls_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_14d_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_14d_pls_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_m2_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m2_pls_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_m3_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m3_pls_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_m4_pls_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_m4_pls_rep_12m
        
        --/*分期数*/
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_1d_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_1d_3d_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_3d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_3d_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_3d_pls_flg=1 and stg_no=1 then dtl_stg_pln_no else null end) as stg_pln_fst_cnt_ovd_3d_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_7d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_7d_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_14d_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_14d_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_m2_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m2_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_m3_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m3_pls_rep_12m
        ,count(case when his_rep_stg_pln_12m_flg=1 and ovd_m4_pls_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_m4_pls_rep_12m
        
        --/*历史逾期天数*/--历史最大、最小
        ,max(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as max_ddf_rep_tim_dte_ovd_pls_rep_12m
        ,min(case when his_rep_stg_pln_12m_flg=1 and ovd_rep_flg=1 then ddf_rep_tim_dte else null end) as min_ddf_rep_tim_dte_ovd_pls_rep_12m


        ----------------------------------------------------------
        --/*12.1.3 历史还款压力*/
        ----------------------------------------------------------
        --/*历史应还金额*/
        ,sum(case when is_his_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his
        ,sum(case when his_rep_stg_pln_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_his
        ,sum(case when his_rep_stg_pln_7d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_his
        ,sum(case when his_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_his
        ,sum(case when his_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_his
        ,sum(case when his_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_his
        ,sum(case when his_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_his
        ,sum(case when his_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_his
        --/*历史应还金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 and is_his_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_fst_ord
        ,sum(case when cur_ord_flg=1 and is_his_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_his_cur_ord

        --/*历史应还金额--单笔最大*/
        ,max(case when is_his_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_his
        ,max(case when his_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_his
        ,max(case when his_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_3m_his
        ,max(case when his_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_his
        ,max(case when his_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_his
        --/*历史应还金额--单笔最小*/
        ,min(case when is_his_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_his
        ,min(case when his_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_his
        ,min(case when his_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_3m_his
        ,min(case when his_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_his
        ,min(case when his_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_his
        --/*历史应还分期数*/
        ,count(case when is_his_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_his
        ,count(case when his_rep_stg_pln_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_his
        ,count(case when his_rep_stg_pln_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_his
        ,count(case when his_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_his
        ,count(case when his_rep_stg_pln_2m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_2m_his
        ,count(case when his_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_his
        ,count(case when his_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_his
        ,count(case when his_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_his
        --/*历史应还分期数*/*首借订单和当前订单*/
        ,count(case when fst_ord_flg=1 and is_his_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_his_fst_ord
        ,count(case when cur_ord_flg=1 and is_his_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_his_cur_ord
        
        --/*应还日距评分日天数*/--历史最大、最小
        ,max(case when is_his_rep_stg_pln=1 then ddf_mdl_rep_dte else null end) as max_ddf_mdl_rep_dte_his
        ,min(case when is_his_rep_stg_pln=1 then ddf_mdl_rep_dte else null end) as min_ddf_mdl_rep_dte_his
-- features range end --
from 
        (select *
                ,sum(case when per_rep_mth_flg is not null then prc_amt else 0 end) over(partition by uid,per_rep_mth_flg) as prc_amt_pmth_3m
        from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail
        where is_his_rep_rpm_stg_pln=1 --选取应还时间或者实还时间在评分日之前的分期计划
        )main
group by uid
        ,mdl_dte
;


------------------【特征计算结果表】--------------------
--------------------------
--/*12.1.1 历史还款意愿*/
--/*12.1.3 历史还款压力*/
--------------------------
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_df partition(ds='${bizdate}') 
select model_data.uid
        ,model_data.mdl_dte
        
-- features range start --
        ----------------------------------------------------------
        --/*12.1.1 历史还款意愿*/
        ----------------------------------------------------------
        -----------------------/*还清口径*/-----------------------
        --还清时间在近7/14天/1/3/6/12个月/历史
        --/*还清金额*/
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt,0) as stg_pln_pay_off_sum_prc_amt
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_7d,0) as stg_pln_pay_off_sum_prc_amt_7d
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_14d,0) as stg_pln_pay_off_sum_prc_amt_14d
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_1m,0) as stg_pln_pay_off_sum_prc_amt_1m
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_3m,0) as stg_pln_pay_off_sum_prc_amt_3m
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_6m,0) as stg_pln_pay_off_sum_prc_amt_6m
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_12m,0) as stg_pln_pay_off_sum_prc_amt_12m
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_fst_ord,0) as stg_pln_pay_off_sum_prc_amt_fst_ord
        ,coalesce(plan1.stg_pln_pay_off_sum_prc_amt_cur_ord,0) as stg_pln_pay_off_sum_prc_amt_cur_ord
        --/*还清金额--单笔最大*/
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt,0) as stg_pln_pay_off_max_prc_amt
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_7d,0) as stg_pln_pay_off_max_prc_amt_7d
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_14d,0) as stg_pln_pay_off_max_prc_amt_14d
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_1m,0) as stg_pln_pay_off_max_prc_amt_1m
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_3m,0) as stg_pln_pay_off_max_prc_amt_3m
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_6m,0) as stg_pln_pay_off_max_prc_amt_6m
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_12m,0) as stg_pln_pay_off_max_prc_amt_12m
        --/*还清金额--单笔最小*/
        ,coalesce(plan1.stg_pln_pay_off_min_prc_amt,0) as stg_pln_pay_off_min_prc_amt
        ,coalesce(plan1.stg_pln_pay_off_min_prc_amt_7d,0) as stg_pln_pay_off_min_prc_amt_7d
        ,coalesce(plan1.stg_pln_pay_off_min_prc_amt_14d,0) as stg_pln_pay_off_min_prc_amt_14d
        ,coalesce(plan1.stg_pln_pay_off_min_prc_amt_1m,0) as stg_pln_pay_off_min_prc_amt_1m
        ,coalesce(plan1.stg_pln_pay_off_min_prc_amt_3m,0) as stg_pln_pay_off_min_prc_amt_3m
        ,coalesce(plan1.stg_pln_pay_off_min_prc_amt_6m,0) as stg_pln_pay_off_min_prc_amt_6m
        ,coalesce(plan1.stg_pln_pay_off_min_prc_amt_12m,0) as stg_pln_pay_off_min_prc_amt_12m
        --/*还清分期数*/
        ,coalesce(plan1.stg_pln_pay_off_cnt,0) as stg_pln_pay_off_cnt
        ,coalesce(plan1.stg_pln_pay_off_cnt_7d,0) as stg_pln_pay_off_cnt_7d
        ,coalesce(plan1.stg_pln_pay_off_cnt_14d,0) as stg_pln_pay_off_cnt_14d
        ,coalesce(plan1.stg_pln_pay_off_cnt_1m,0) as stg_pln_pay_off_cnt_1m
        ,coalesce(plan1.stg_pln_pay_off_cnt_3m,0) as stg_pln_pay_off_cnt_3m
        ,coalesce(plan1.stg_pln_pay_off_cnt_6m,0) as stg_pln_pay_off_cnt_6m
        ,coalesce(plan1.stg_pln_pay_off_cnt_12m,0) as stg_pln_pay_off_cnt_12m
        --/*还清分期数*/*首借订单和当前订单*/
        ,coalesce(plan1.stg_pln_pay_off_cnt_fst_ord,0) as stg_pln_pay_off_cnt_fst_ord
        ,coalesce(plan1.stg_pln_pay_off_cnt_cur_ord,0) as stg_pln_pay_off_cnt_cur_ord
        --/*最近一次还清日距评分日天数*/
        ,plan1.min_pay_off_ddf_mdl_rep_dte

        --还款金额（单日最大）
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_pday,0) as stg_pln_pay_off_max_prc_amt_pday
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_pday_7d,0) as stg_pln_pay_off_max_prc_amt_pday_7d
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_pday_14d,0) as stg_pln_pay_off_max_prc_amt_pday_14d
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_pday_1m,0) as stg_pln_pay_off_max_prc_amt_pday_1m
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_pday_3m,0) as stg_pln_pay_off_max_prc_amt_pday_3m
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_pday_6m,0) as stg_pln_pay_off_max_prc_amt_pday_6m
        ,coalesce(plan1.stg_pln_pay_off_max_prc_amt_pday_12m,0) as stg_pln_pay_off_max_prc_amt_pday_12m

        --还款金额（近3月单月最大）
        ,coalesce(plan1.max_prc_amt_pmth_3m) as max_prc_amt_pmth_3m

        -----------------------/*还款状态：提前还款*/-----------------------
        --提前还款时间切片--1、2、3、6、12个月提前还款
        --/*金额--*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv,0) as stg_pln_sum_prc_amt_adv
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_3d,0) as stg_pln_sum_prc_amt_adv_3d
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_7d,0) as stg_pln_sum_prc_amt_adv_7d
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_14d,0) as stg_pln_sum_prc_amt_adv_14d
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_1m,0) as stg_pln_sum_prc_amt_adv_1m
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_2m,0) as stg_pln_sum_prc_amt_adv_2m
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_3m,0) as stg_pln_sum_prc_amt_adv_3m
        -- ,coalesce(plan1.stg_pln_sum_prc_amt_adv_6m,0) as stg_pln_sum_prc_amt_adv_6m
        -- ,coalesce(plan1.stg_pln_sum_prc_amt_adv_12m,0) as stg_pln_sum_prc_amt_adv_12m
        --/*金额/*首借订单和当前订单*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_fst_ord,0) as stg_pln_sum_prc_amt_adv_fst_ord
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_cur_ord,0) as stg_pln_sum_prc_amt_adv_cur_ord

        --/*金额--单笔最大*/
        ,coalesce(plan1.stg_pln_max_prc_amt_adv,0) as stg_pln_max_prc_amt_adv
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_3d,0) as stg_pln_max_prc_amt_adv_3d
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_7d,0) as stg_pln_max_prc_amt_adv_7d
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_14d,0) as stg_pln_max_prc_amt_adv_14d
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_1m,0) as stg_pln_max_prc_amt_adv_1m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_2m,0) as stg_pln_max_prc_amt_adv_2m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_3m,0) as stg_pln_max_prc_amt_adv_3m
        -- ,coalesce(plan1.stg_pln_max_prc_amt_adv_6m,0) as stg_pln_max_prc_amt_adv_6m
        -- ,coalesce(plan1.stg_pln_max_prc_amt_adv_12m,0) as stg_pln_max_prc_amt_adv_12m
        -- --/*金额--单笔最大/*首借订单和当前订单*/
        -- ,coalesce(plan1.stg_pln_max_prc_amt_adv_fst_ord,0) as stg_pln_max_prc_amt_adv_fst_ord
        -- ,coalesce(plan1.stg_pln_max_prc_amt_adv_cur_ord,0) as stg_pln_max_prc_amt_adv_cur_ord

        --/*金额--单笔最小*/
        ,coalesce(plan1.stg_pln_min_prc_amt_adv,0) as stg_pln_min_prc_amt_adv
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_3d,0) as stg_pln_min_prc_amt_adv_3d
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_7d,0) as stg_pln_min_prc_amt_adv_7d
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_14d,0) as stg_pln_min_prc_amt_adv_14d
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_1m,0) as stg_pln_min_prc_amt_adv_1m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_2m,0) as stg_pln_min_prc_amt_adv_2m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_3m,0) as stg_pln_min_prc_amt_adv_3m
        -- ,coalesce(plan1.stg_pln_min_prc_amt_adv_6m,0) as stg_pln_min_prc_amt_adv_6m
        -- ,coalesce(plan1.stg_pln_min_prc_amt_adv_12m,0) as stg_pln_min_prc_amt_adv_12m
        -- -- --/*金额--单笔最小/*首借订单和当前订单*/
        -- ,coalesce(plan1.stg_pln_min_prc_amt_adv_fst_ord,0) as stg_pln_min_prc_amt_adv_fst_ord
        -- ,coalesce(plan1.stg_pln_min_prc_amt_adv_cur_ord,0) as stg_pln_min_prc_amt_adv_cur_ord

        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv,0) as stg_pln_cnt_adv
        ,coalesce(plan1.stg_pln_cnt_adv_3d,0) as stg_pln_cnt_adv_3d
        ,coalesce(plan1.stg_pln_cnt_adv_7d,0) as stg_pln_cnt_adv_7d
        ,coalesce(plan1.stg_pln_cnt_adv_14d,0) as stg_pln_cnt_adv_14d
        ,coalesce(plan1.stg_pln_cnt_adv_1m,0) as stg_pln_cnt_adv_1m
        ,coalesce(plan1.stg_pln_cnt_adv_2m,0) as stg_pln_cnt_adv_2m
        ,coalesce(plan1.stg_pln_cnt_adv_3m,0) as stg_pln_cnt_adv_3m
        -- ,coalesce(plan1.stg_pln_cnt_adv_6m,0) as stg_pln_cnt_adv_6m
        -- ,coalesce(plan1.stg_pln_cnt_adv_12m,0) as stg_pln_cnt_adv_12m
        --/*分期数*/-/*首借订单和当前订单*/
        ,coalesce(plan1.stg_pln_cnt_adv_fst_ord,0) as stg_pln_cnt_adv_fst_ord
        ,coalesce(plan1.stg_pln_cnt_adv_cur_ord,0) as stg_pln_cnt_adv_cur_ord

        --/*提前还款天数*/--历史最大、最小
        ,plan1.max_ddf_rep_tim_dte_adv
        ,plan1.min_ddf_rep_tim_dte_adv
        --/*提前还款天数*/--历史最大、最小-/*首借订单和当前订单*/
        ,plan1.max_ddf_rep_tim_dte_adv_fst_ord
        ,plan1.min_ddf_rep_tim_dte_adv_fst_ord
        ,plan1.max_ddf_rep_tim_dte_adv_cur_ord
        ,plan1.min_ddf_rep_tim_dte_adv_cur_ord

        --最近一次提前还款时间距评分日间隔
        ,plan1.min_ddf_mdl_rep_tim_adv

        --------------------------/*【还清口径：实还日和评分日间隔】切片（7/14天/1/3/6/12个月）交叉应还日和实还日间隔（提前还款）*/--------------------------
        --最近7天发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,coalesce(stg_pln_sum_prc_amt_adv_rct_7d,0) as stg_pln_sum_prc_amt_adv_rct_7d
        ,coalesce(stg_pln_max_prc_amt_adv_rct_7d,0) as stg_pln_max_prc_amt_adv_rct_7d
        ,coalesce(stg_pln_min_prc_amt_adv_rct_7d,0) as stg_pln_min_prc_amt_adv_rct_7d
        ,coalesce(stg_pln_cnt_adv_rct_7d,0) as stg_pln_cnt_adv_rct_7d

        --最近14天发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,coalesce(stg_pln_sum_prc_amt_adv_rct_14d,0) as stg_pln_sum_prc_amt_adv_rct_14d
        ,coalesce(stg_pln_max_prc_amt_adv_rct_14d,0) as stg_pln_max_prc_amt_adv_rct_14d
        ,coalesce(stg_pln_min_prc_amt_adv_rct_14d,0) as stg_pln_min_prc_amt_adv_rct_14d
        ,coalesce(stg_pln_cnt_adv_rct_14d,0) as stg_pln_cnt_adv_rct_14d

        --最近1个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,coalesce(stg_pln_sum_prc_amt_adv_rct_1m,0) as stg_pln_sum_prc_amt_adv_rct_1m
        ,coalesce(stg_pln_max_prc_amt_adv_rct_1m,0) as stg_pln_max_prc_amt_adv_rct_1m
        ,coalesce(stg_pln_min_prc_amt_adv_rct_1m,0) as stg_pln_min_prc_amt_adv_rct_1m
        ,coalesce(stg_pln_cnt_adv_rct_1m,0) as stg_pln_cnt_adv_rct_1m

        --最近3个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,coalesce(stg_pln_sum_prc_amt_adv_rct_3m,0) as stg_pln_sum_prc_amt_adv_rct_3m
        ,coalesce(stg_pln_max_prc_amt_adv_rct_3m,0) as stg_pln_max_prc_amt_adv_rct_3m
        ,coalesce(stg_pln_min_prc_amt_adv_rct_3m,0) as stg_pln_min_prc_amt_adv_rct_3m
        ,coalesce(stg_pln_cnt_adv_rct_3m,0) as stg_pln_cnt_adv_rct_3m

        --最近6个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,coalesce(stg_pln_sum_prc_amt_adv_rct_6m,0) as stg_pln_sum_prc_amt_adv_rct_6m
        ,coalesce(stg_pln_max_prc_amt_adv_rct_6m,0) as stg_pln_max_prc_amt_adv_rct_6m
        ,coalesce(stg_pln_min_prc_amt_adv_rct_6m,0) as stg_pln_min_prc_amt_adv_rct_6m
        ,coalesce(stg_pln_cnt_adv_rct_6m,0) as stg_pln_cnt_adv_rct_6m

        --最近12个月发生的提前还款
        --/*总/最大/最小金额/分期计划数--*/
        ,coalesce(stg_pln_sum_prc_amt_adv_rct_12m,0) as stg_pln_sum_prc_amt_adv_rct_12m
        ,coalesce(stg_pln_max_prc_amt_adv_rct_12m,0) as stg_pln_max_prc_amt_adv_rct_12m
        ,coalesce(stg_pln_min_prc_amt_adv_rct_12m,0) as stg_pln_min_prc_amt_adv_rct_12m
        ,coalesce(stg_pln_cnt_adv_rct_12m,0) as stg_pln_cnt_adv_rct_12m

        --------------------------/*应还日与评分日时间间隔切片（1/3/6/12个月）交叉应还日和实还日间隔（提前还款）*/--------------------------
        --历史所有应还的提前还款
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_rep_his,0) as stg_pln_sum_prc_amt_adv_rep_his
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_rep_his,0) as stg_pln_max_prc_amt_adv_rep_his
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_rep_his,0) as stg_pln_min_prc_amt_adv_rep_his
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_rep_his,0) as stg_pln_cnt_adv_rep_his

        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_rep_1m,0) as stg_pln_sum_prc_amt_adv_rep_1m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_rep_1m,0) as stg_pln_max_prc_amt_adv_rep_1m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_rep_1m,0) as stg_pln_min_prc_amt_adv_rep_1m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_rep_1m,0) as stg_pln_cnt_adv_rep_1m

        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_rep_3m,0) as stg_pln_sum_prc_amt_adv_rep_3m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_rep_3m,0) as stg_pln_max_prc_amt_adv_rep_3m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_rep_3m,0) as stg_pln_min_prc_amt_adv_rep_3m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_rep_3m,0) as stg_pln_cnt_adv_rep_3m

        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_rep_6m,0) as stg_pln_sum_prc_amt_adv_rep_6m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_rep_6m,0) as stg_pln_max_prc_amt_adv_rep_6m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_rep_6m,0) as stg_pln_min_prc_amt_adv_rep_6m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_rep_6m,0) as stg_pln_cnt_adv_rep_6m

        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_rep_12m,0) as stg_pln_sum_prc_amt_adv_rep_12m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_rep_12m,0) as stg_pln_max_prc_amt_adv_rep_12m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_rep_12m,0) as stg_pln_min_prc_amt_adv_rep_12m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_rep_12m,0) as stg_pln_cnt_adv_rep_12m


        -----------------------/*还款状态：按时还款*/-----------------------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_his,0) as stg_pln_sum_prc_amt_d0_rep_his
        ,coalesce(plan1.stg_pln_max_prc_amt_d0_rep_his,0) as stg_pln_max_prc_amt_d0_rep_his
        ,coalesce(plan1.stg_pln_min_prc_amt_d0_rep_his,0) as stg_pln_min_prc_amt_d0_rep_his
        --/*金额/*首借订单和当前订单*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_his_fst_ord,0) as stg_pln_sum_prc_amt_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_max_prc_amt_d0_rep_his_fst_ord,0) as stg_pln_max_prc_amt_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_min_prc_amt_d0_rep_his_fst_ord,0) as stg_pln_min_prc_amt_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_his_cur_ord,0) as stg_pln_sum_prc_amt_d0_rep_his_cur_ord
        ,coalesce(plan1.stg_pln_max_prc_amt_d0_rep_his_cur_ord,0) as stg_pln_max_prc_amt_d0_rep_his_cur_ord
        ,coalesce(plan1.stg_pln_min_prc_amt_d0_rep_his_cur_ord,0) as stg_pln_min_prc_amt_d0_rep_his_cur_ord

        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_d0_rep_his,0) as stg_pln_cnt_d0_rep_his
        --/*分期数*/*首借订单和当前订单*/
        ,coalesce(plan1.stg_pln_cnt_d0_rep_his_fst_ord,0) as stg_pln_cnt_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_cnt_d0_rep_his_cur_ord,0) as stg_pln_cnt_d0_rep_his_cur_ord

        --最近一次按时还款时间距评分日间隔
        ,plan1.min_ddf_mdl_rep_tim_d0_rep_his


        --------------------------/*应还日与评分日时间间隔切片（1/3/6/12个月）交叉应还日和实还日间隔（按时还款）*/--------------------------
        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_1m,0) as stg_pln_sum_prc_amt_d0_rep_1m
        ,coalesce(plan1.stg_pln_max_prc_amt_d0_rep_1m,0) as stg_pln_max_prc_amt_d0_rep_1m
        ,coalesce(plan1.stg_pln_min_prc_amt_d0_rep_1m,0) as stg_pln_min_prc_amt_d0_rep_1m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_d0_rep_1m,0) as stg_pln_cnt_d0_rep_1m

        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_3m,0) as stg_pln_sum_prc_amt_d0_rep_3m
        ,coalesce(plan1.stg_pln_max_prc_amt_d0_rep_3m,0) as stg_pln_max_prc_amt_d0_rep_3m
        ,coalesce(plan1.stg_pln_min_prc_amt_d0_rep_3m,0) as stg_pln_min_prc_amt_d0_rep_3m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_d0_rep_3m,0) as stg_pln_cnt_d0_rep_3m

        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_6m,0) as stg_pln_sum_prc_amt_d0_rep_6m
        ,coalesce(plan1.stg_pln_max_prc_amt_d0_rep_6m,0) as stg_pln_max_prc_amt_d0_rep_6m
        ,coalesce(plan1.stg_pln_min_prc_amt_d0_rep_6m,0) as stg_pln_min_prc_amt_d0_rep_6m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_d0_rep_6m,0) as stg_pln_cnt_d0_rep_6m

        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_d0_rep_12m,0) as stg_pln_sum_prc_amt_d0_rep_12m
        ,coalesce(plan1.stg_pln_max_prc_amt_d0_rep_12m,0) as stg_pln_max_prc_amt_d0_rep_12m
        ,coalesce(plan1.stg_pln_min_prc_amt_d0_rep_12m,0) as stg_pln_min_prc_amt_d0_rep_12m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_d0_rep_12m,0) as stg_pln_cnt_d0_rep_12m



        -----------------------/*还款状态：按时还款+提前还款（只计算历史应还的部分）*/-----------------------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_d0_rep_his,0) as stg_pln_sum_prc_amt_adv_d0_rep_his
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_d0_rep_his,0) as stg_pln_max_prc_amt_adv_d0_rep_his
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_d0_rep_his,0) as stg_pln_min_prc_amt_adv_d0_rep_his
        --/*金额/*首借订单和当前订单*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_d0_rep_his_fst_ord,0) as stg_pln_sum_prc_amt_adv_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_d0_rep_his_fst_ord,0) as stg_pln_max_prc_amt_adv_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_d0_rep_his_fst_ord,0) as stg_pln_min_prc_amt_adv_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_d0_rep_his_cur_ord,0) as stg_pln_sum_prc_amt_adv_d0_rep_his_cur_ord
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_d0_rep_his_cur_ord,0) as stg_pln_max_prc_amt_adv_d0_rep_his_cur_ord
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_d0_rep_his_cur_ord,0) as stg_pln_min_prc_amt_adv_d0_rep_his_cur_ord

        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_d0_rep_his,0) as stg_pln_cnt_adv_d0_rep_his
        --/*分期数*/*首借订单和当前订单*/
        ,coalesce(plan1.stg_pln_cnt_adv_d0_rep_his_fst_ord,0) as stg_pln_cnt_adv_d0_rep_his_fst_ord
        ,coalesce(plan1.stg_pln_cnt_adv_d0_rep_his_cur_ord,0) as stg_pln_cnt_adv_d0_rep_his_cur_ord


        --------------------------/*应还日与评分日时间间隔切片（1/3/6/12个月）交叉应还日和实还日间隔（非逾期还款=提前还款+按时还款）*/--------------------------
        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_d0_rep_1m,0) as stg_pln_sum_prc_amt_adv_d0_rep_1m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_d0_rep_1m,0) as stg_pln_max_prc_amt_adv_d0_rep_1m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_d0_rep_1m,0) as stg_pln_min_prc_amt_adv_d0_rep_1m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_d0_rep_1m,0) as stg_pln_cnt_adv_d0_rep_1m

        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_d0_rep_3m,0) as stg_pln_sum_prc_amt_adv_d0_rep_3m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_d0_rep_3m,0) as stg_pln_max_prc_amt_adv_d0_rep_3m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_d0_rep_3m,0) as stg_pln_min_prc_amt_adv_d0_rep_3m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_d0_rep_3m,0) as stg_pln_cnt_adv_d0_rep_3m

        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_d0_rep_6m,0) as stg_pln_sum_prc_amt_adv_d0_rep_6m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_d0_rep_6m,0) as stg_pln_max_prc_amt_adv_d0_rep_6m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_d0_rep_6m,0) as stg_pln_min_prc_amt_adv_d0_rep_6m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_d0_rep_6m,0) as stg_pln_cnt_adv_d0_rep_6m

        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,coalesce(plan1.stg_pln_sum_prc_amt_adv_d0_rep_12m,0) as stg_pln_sum_prc_amt_adv_d0_rep_12m
        ,coalesce(plan1.stg_pln_max_prc_amt_adv_d0_rep_12m,0) as stg_pln_max_prc_amt_adv_d0_rep_12m
        ,coalesce(plan1.stg_pln_min_prc_amt_adv_d0_rep_12m,0) as stg_pln_min_prc_amt_adv_d0_rep_12m
        --/*分期数*/
        ,coalesce(plan1.stg_pln_cnt_adv_d0_rep_12m,0) as stg_pln_cnt_adv_d0_rep_12m


        -----------------------/*还款状态：逾期*/-----------------------
        --逾期时间切片--逾期3/7/15天、1/2/3个月
        --/*金额--*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_pls,0) as stg_pln_sum_prc_amt_ovd_pls
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_pls,0) as stg_pln_fst_sum_prc_amt_ovd_pls
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_1d_3d,0) as stg_pln_sum_prc_amt_ovd_1d_3d
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_3d_pls,0) as stg_pln_sum_prc_amt_ovd_3d_pls
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_3d_pls,0) as stg_pln_fst_sum_prc_amt_ovd_3d_pls
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_7d_pls,0) as stg_pln_sum_prc_amt_ovd_7d_pls
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_14d_pls,0) as stg_pln_sum_prc_amt_ovd_14d_pls
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m2_pls,0) as stg_pln_sum_prc_amt_ovd_m2_pls
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m3_pls,0) as stg_pln_sum_prc_amt_ovd_m3_pls
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m4_pls,0) as stg_pln_sum_prc_amt_ovd_m4_pls
        --/*金额/*首借订单和当前订单*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_pls_fst_ord,0) as stg_pln_sum_prc_amt_ovd_pls_fst_ord
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_pls_cur_ord,0) as stg_pln_sum_prc_amt_ovd_pls_cur_ord

        --/*金额--单笔最大*/
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_pls,0) as stg_pln_max_prc_amt_ovd_pls
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_1d_3d,0) as stg_pln_max_prc_amt_ovd_1d_3d
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_3d_pls,0) as stg_pln_max_prc_amt_ovd_3d_pls
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_7d_pls,0) as stg_pln_max_prc_amt_ovd_7d_pls
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_14d_pls,0) as stg_pln_max_prc_amt_ovd_14d_pls
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m2_pls,0) as stg_pln_max_prc_amt_ovd_m2_pls
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m3_pls,0) as stg_pln_max_prc_amt_ovd_m3_pls
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m4_pls,0) as stg_pln_max_prc_amt_ovd_m4_pls
        --/*金额--单笔最大/*首借订单和当前订单*/
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_pls_fst_ord,0) as stg_pln_max_prc_amt_ovd_pls_fst_ord
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_pls_cur_ord,0) as stg_pln_max_prc_amt_ovd_pls_cur_ord

        --/*金额--单笔最小*/
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_pls,0) as stg_pln_min_prc_amt_ovd_pls
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_1d_3d,0) as stg_pln_min_prc_amt_ovd_1d_3d
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_3d_pls,0) as stg_pln_min_prc_amt_ovd_3d_pls
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_7d_pls,0) as stg_pln_min_prc_amt_ovd_7d_pls
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_14d_pls,0) as stg_pln_min_prc_amt_ovd_14d_pls
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m2_pls,0) as stg_pln_min_prc_amt_ovd_m2_pls
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m3_pls,0) as stg_pln_min_prc_amt_ovd_m3_pls
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m4_pls,0) as stg_pln_min_prc_amt_ovd_m4_pls
        --/*金额--单笔最小/*首借订单和当前订单*/
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_pls_fst_ord,0) as stg_pln_min_prc_amt_ovd_pls_fst_ord
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_pls_cur_ord,0) as stg_pln_min_prc_amt_ovd_pls_cur_ord

        --/*分期数*/
        ,coalesce(plan2.stg_pln_cnt_ovd_pls,0) as stg_pln_cnt_ovd_pls
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_pls,0) as stg_pln_fst_cnt_ovd_pls
        ,coalesce(plan2.stg_pln_cnt_ovd_1d_3d,0) as stg_pln_cnt_ovd_1d_3d
        ,coalesce(plan2.stg_pln_cnt_ovd_3d_pls,0) as stg_pln_cnt_ovd_3d_pls
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_3d_pls,0) as stg_pln_fst_cnt_ovd_3d_pls
        ,coalesce(plan2.stg_pln_cnt_ovd_7d_pls,0) as stg_pln_cnt_ovd_7d_pls
        ,coalesce(plan2.stg_pln_cnt_ovd_14d_pls,0) as stg_pln_cnt_ovd_14d_pls
        ,coalesce(plan2.stg_pln_cnt_ovd_m2_pls,0) as stg_pln_cnt_ovd_m2_pls
        ,coalesce(plan2.stg_pln_cnt_ovd_m3_pls,0) as stg_pln_cnt_ovd_m3_pls
        ,coalesce(plan2.stg_pln_cnt_ovd_m4_pls,0) as stg_pln_cnt_ovd_m4_pls
        --/*分期数*/*首借订单和当前订单*/
        ,coalesce(plan2.stg_pln_cnt_ovd_pls_fst_ord,0) as stg_pln_cnt_ovd_pls_fst_ord
        ,coalesce(plan2.stg_pln_cnt_ovd_pls_cur_ord,0) as stg_pln_cnt_ovd_pls_cur_ord

        --最近一次逾期发生时间距评分日间隔
        ,plan2.min_ddf_mdl_rep_dte_ovd_pls
        ,plan2.min_fst_ddf_mdl_rep_dte_ovd_pls
        ,plan2.min_ddf_mdl_rep_dte_ovd_1d_3d
        ,plan2.min_ddf_mdl_rep_dte_ovd_3d_pls
        ,plan2.min_fst_ddf_mdl_rep_dte_ovd_3d_pls
        ,plan2.min_ddf_mdl_rep_dte_ovd_7d_pls
        ,plan2.min_ddf_mdl_rep_dte_ovd_14d_pls
        ,plan2.min_ddf_mdl_rep_dte_ovd_m2_pls
        ,plan2.min_ddf_mdl_rep_dte_ovd_m3_pls
        ,plan2.min_ddf_mdl_rep_dte_ovd_m4_pls

        --/*历史逾期天数*/--历史最大、最小
        ,plan2.max_ddf_rep_tim_dte_ovd_pls
        ,plan2.min_ddf_rep_tim_dte_ovd_pls
        --/*历史逾期天数*/--历史最大、最小/*首借订单和当前订单*/
        ,plan2.max_ddf_rep_tim_dte_ovd_pls_fst_ord
        ,plan2.min_ddf_rep_tim_dte_ovd_pls_fst_ord
        ,plan2.max_ddf_rep_tim_dte_ovd_pls_cur_ord
        ,plan2.min_ddf_rep_tim_dte_ovd_pls_cur_ord


        --------------------------/*应还日与评分日时间间隔切片（1/3/6/12个月）交叉应还日和实还日间隔（逾期3/7/15天、1/2/3个月）*/--------------------------
        -----------/*应还日与评分日时间间隔1个月*/-----------
        --/*金额*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_pls_rep_1m,0) as stg_pln_sum_prc_amt_ovd_pls_rep_1m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_pls_rep_1m,0) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_1m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_1d_3d_rep_1m,0) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_1m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_3d_pls_rep_1m,0) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_1m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_1m,0) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_1m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_7d_pls_rep_1m,0) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_1m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_14d_pls_rep_1m,0) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_1m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m2_pls_rep_1m,0) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_1m

        --/*金额--单笔最大*/
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_pls_rep_1m,0) as stg_pln_max_prc_amt_ovd_pls_rep_1m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_1d_3d_rep_1m,0) as stg_pln_max_prc_amt_ovd_1d_3d_rep_1m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_3d_pls_rep_1m,0) as stg_pln_max_prc_amt_ovd_3d_pls_rep_1m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_7d_pls_rep_1m,0) as stg_pln_max_prc_amt_ovd_7d_pls_rep_1m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_14d_pls_rep_1m,0) as stg_pln_max_prc_amt_ovd_14d_pls_rep_1m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m2_pls_rep_1m,0) as stg_pln_max_prc_amt_ovd_m2_pls_rep_1m

        --/*金额--单笔最小*/
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_pls_rep_1m,0) as stg_pln_min_prc_amt_ovd_pls_rep_1m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_1d_3d_rep_1m,0) as stg_pln_min_prc_amt_ovd_1d_3d_rep_1m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_3d_pls_rep_1m,0) as stg_pln_min_prc_amt_ovd_3d_pls_rep_1m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_7d_pls_rep_1m,0) as stg_pln_min_prc_amt_ovd_7d_pls_rep_1m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_14d_pls_rep_1m,0) as stg_pln_min_prc_amt_ovd_14d_pls_rep_1m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m2_pls_rep_1m,0) as stg_pln_min_prc_amt_ovd_m2_pls_rep_1m

        --/*分期数*/
        ,coalesce(plan2.stg_pln_cnt_ovd_pls_rep_1m,0) as stg_pln_cnt_ovd_pls_rep_1m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_pls_rep_1m,0) as stg_pln_fst_cnt_ovd_pls_rep_1m
        ,coalesce(plan2.stg_pln_cnt_ovd_1d_3d_rep_1m,0) as stg_pln_cnt_ovd_1d_3d_rep_1m
        ,coalesce(plan2.stg_pln_cnt_ovd_3d_pls_rep_1m,0) as stg_pln_cnt_ovd_3d_pls_rep_1m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_3d_pls_rep_1m,0) as stg_pln_fst_cnt_ovd_3d_pls_rep_1m
        ,coalesce(plan2.stg_pln_cnt_ovd_7d_pls_rep_1m,0) as stg_pln_cnt_ovd_7d_pls_rep_1m
        ,coalesce(plan2.stg_pln_cnt_ovd_14d_pls_rep_1m,0) as stg_pln_cnt_ovd_14d_pls_rep_1m
        ,coalesce(plan2.stg_pln_cnt_ovd_m2_pls_rep_1m,0) as stg_pln_cnt_ovd_m2_pls_rep_1m

        --/*历史逾期天数*/--历史最大、最小
        ,plan2.max_ddf_rep_tim_dte_ovd_pls_rep_1m
        ,plan2.min_ddf_rep_tim_dte_ovd_pls_rep_1m


        -----------/*应还日与评分日时间间隔3个月*/-----------
        --/*金额*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_pls_rep_3m,0) as stg_pln_sum_prc_amt_ovd_pls_rep_3m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_pls_rep_3m,0) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_3m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_1d_3d_rep_3m,0) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_3m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_3d_pls_rep_3m,0) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_3m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_3m,0) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_3m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_7d_pls_rep_3m,0) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_3m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_14d_pls_rep_3m,0) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_3m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m2_pls_rep_3m,0) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_3m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m3_pls_rep_3m,0) as stg_pln_sum_prc_amt_ovd_m3_pls_rep_3m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m4_pls_rep_3m,0) as stg_pln_sum_prc_amt_ovd_m4_pls_rep_3m
        --/*金额--单笔最大*/
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_pls_rep_3m,0) as stg_pln_max_prc_amt_ovd_pls_rep_3m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_1d_3d_rep_3m,0) as stg_pln_max_prc_amt_ovd_1d_3d_rep_3m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_3d_pls_rep_3m,0) as stg_pln_max_prc_amt_ovd_3d_pls_rep_3m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_7d_pls_rep_3m,0) as stg_pln_max_prc_amt_ovd_7d_pls_rep_3m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_14d_pls_rep_3m,0) as stg_pln_max_prc_amt_ovd_14d_pls_rep_3m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m2_pls_rep_3m,0) as stg_pln_max_prc_amt_ovd_m2_pls_rep_3m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m3_pls_rep_3m,0) as stg_pln_max_prc_amt_ovd_m3_pls_rep_3m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m4_pls_rep_3m,0) as stg_pln_max_prc_amt_ovd_m4_pls_rep_3m
        --/*金额--单笔最小*/
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_pls_rep_3m,0) as stg_pln_min_prc_amt_ovd_pls_rep_3m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_1d_3d_rep_3m,0) as stg_pln_min_prc_amt_ovd_1d_3d_rep_3m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_3d_pls_rep_3m,0) as stg_pln_min_prc_amt_ovd_3d_pls_rep_3m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_7d_pls_rep_3m,0) as stg_pln_min_prc_amt_ovd_7d_pls_rep_3m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_14d_pls_rep_3m,0) as stg_pln_min_prc_amt_ovd_14d_pls_rep_3m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m2_pls_rep_3m,0) as stg_pln_min_prc_amt_ovd_m2_pls_rep_3m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m3_pls_rep_3m,0) as stg_pln_min_prc_amt_ovd_m3_pls_rep_3m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m4_pls_rep_3m,0) as stg_pln_min_prc_amt_ovd_m4_pls_rep_3m

        --/*分期数*/
        ,coalesce(plan2.stg_pln_cnt_ovd_pls_rep_3m,0) as stg_pln_cnt_ovd_pls_rep_3m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_pls_rep_3m,0) as stg_pln_fst_cnt_ovd_pls_rep_3m
        ,coalesce(plan2.stg_pln_cnt_ovd_1d_3d_rep_3m,0) as stg_pln_cnt_ovd_1d_3d_rep_3m
        ,coalesce(plan2.stg_pln_cnt_ovd_3d_pls_rep_3m,0) as stg_pln_cnt_ovd_3d_pls_rep_3m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_3d_pls_rep_3m,0) as stg_pln_fst_cnt_ovd_3d_pls_rep_3m
        ,coalesce(plan2.stg_pln_cnt_ovd_7d_pls_rep_3m,0) as stg_pln_cnt_ovd_7d_pls_rep_3m
        ,coalesce(plan2.stg_pln_cnt_ovd_14d_pls_rep_3m,0) as stg_pln_cnt_ovd_14d_pls_rep_3m
        ,coalesce(plan2.stg_pln_cnt_ovd_m2_pls_rep_3m,0) as stg_pln_cnt_ovd_m2_pls_rep_3m
        ,coalesce(plan2.stg_pln_cnt_ovd_m3_pls_rep_3m,0) as stg_pln_cnt_ovd_m3_pls_rep_3m
        ,coalesce(plan2.stg_pln_cnt_ovd_m4_pls_rep_3m,0) as stg_pln_cnt_ovd_m4_pls_rep_3m

        --/*历史逾期天数*/--历史最大、最小
        ,plan2.max_ddf_rep_tim_dte_ovd_pls_rep_3m
        ,plan2.min_ddf_rep_tim_dte_ovd_pls_rep_3m


        -----------/*应还日与评分日时间间隔6个月*/-----------
        --/*金额*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_pls_rep_6m,0) as stg_pln_sum_prc_amt_ovd_pls_rep_6m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_pls_rep_6m,0) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_6m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_1d_3d_rep_6m,0) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_6m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_3d_pls_rep_6m,0) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_6m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_6m,0) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_6m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_7d_pls_rep_6m,0) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_6m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_14d_pls_rep_6m,0) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_6m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m2_pls_rep_6m,0) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_6m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m3_pls_rep_6m,0) as stg_pln_sum_prc_amt_ovd_m3_pls_rep_6m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m4_pls_rep_6m,0) as stg_pln_sum_prc_amt_ovd_m4_pls_rep_6m
        --/*金额--单笔最大*/
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_pls_rep_6m,0) as stg_pln_max_prc_amt_ovd_pls_rep_6m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_1d_3d_rep_6m,0) as stg_pln_max_prc_amt_ovd_1d_3d_rep_6m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_3d_pls_rep_6m,0) as stg_pln_max_prc_amt_ovd_3d_pls_rep_6m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_7d_pls_rep_6m,0) as stg_pln_max_prc_amt_ovd_7d_pls_rep_6m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_14d_pls_rep_6m,0) as stg_pln_max_prc_amt_ovd_14d_pls_rep_6m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m2_pls_rep_6m,0) as stg_pln_max_prc_amt_ovd_m2_pls_rep_6m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m3_pls_rep_6m,0) as stg_pln_max_prc_amt_ovd_m3_pls_rep_6m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m4_pls_rep_6m,0) as stg_pln_max_prc_amt_ovd_m4_pls_rep_6m
        --/*金额--单笔最小*/
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_pls_rep_6m,0) as stg_pln_min_prc_amt_ovd_pls_rep_6m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_1d_3d_rep_6m,0) as stg_pln_min_prc_amt_ovd_1d_3d_rep_6m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_3d_pls_rep_6m,0) as stg_pln_min_prc_amt_ovd_3d_pls_rep_6m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_7d_pls_rep_6m,0) as stg_pln_min_prc_amt_ovd_7d_pls_rep_6m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_14d_pls_rep_6m,0) as stg_pln_min_prc_amt_ovd_14d_pls_rep_6m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m2_pls_rep_6m,0) as stg_pln_min_prc_amt_ovd_m2_pls_rep_6m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m3_pls_rep_6m,0) as stg_pln_min_prc_amt_ovd_m3_pls_rep_6m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m4_pls_rep_6m,0) as stg_pln_min_prc_amt_ovd_m4_pls_rep_6m

        --/*分期数*/
        ,coalesce(plan2.stg_pln_cnt_ovd_pls_rep_6m,0) as stg_pln_cnt_ovd_pls_rep_6m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_pls_rep_6m,0) as stg_pln_fst_cnt_ovd_pls_rep_6m
        ,coalesce(plan2.stg_pln_cnt_ovd_1d_3d_rep_6m,0) as stg_pln_cnt_ovd_1d_3d_rep_6m
        ,coalesce(plan2.stg_pln_cnt_ovd_3d_pls_rep_6m,0) as stg_pln_cnt_ovd_3d_pls_rep_6m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_3d_pls_rep_6m,0) as stg_pln_fst_cnt_ovd_3d_pls_rep_6m
        ,coalesce(plan2.stg_pln_cnt_ovd_7d_pls_rep_6m,0) as stg_pln_cnt_ovd_7d_pls_rep_6m
        ,coalesce(plan2.stg_pln_cnt_ovd_14d_pls_rep_6m,0) as stg_pln_cnt_ovd_14d_pls_rep_6m
        ,coalesce(plan2.stg_pln_cnt_ovd_m2_pls_rep_6m,0) as stg_pln_cnt_ovd_m2_pls_rep_6m
        ,coalesce(plan2.stg_pln_cnt_ovd_m3_pls_rep_6m,0) as stg_pln_cnt_ovd_m3_pls_rep_6m
        ,coalesce(plan2.stg_pln_cnt_ovd_m4_pls_rep_6m,0) as stg_pln_cnt_ovd_m4_pls_rep_6m

        --/*历史逾期天数*/--历史最大、最小
        ,plan2.max_ddf_rep_tim_dte_ovd_pls_rep_6m
        ,plan2.min_ddf_rep_tim_dte_ovd_pls_rep_6m


        -----------/*应还日与评分日时间间隔12个月*/-----------
        --/*金额*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_pls_rep_12m,0) as stg_pln_sum_prc_amt_ovd_pls_rep_12m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_pls_rep_12m,0) as stg_pln_fst_sum_prc_amt_ovd_pls_rep_12m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_1d_3d_rep_12m,0) as stg_pln_sum_prc_amt_ovd_1d_3d_rep_12m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_3d_pls_rep_12m,0) as stg_pln_sum_prc_amt_ovd_3d_pls_rep_12m
        ,coalesce(plan2.stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_12m,0) as stg_pln_fst_sum_prc_amt_ovd_3d_pls_rep_12m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_7d_pls_rep_12m,0) as stg_pln_sum_prc_amt_ovd_7d_pls_rep_12m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_14d_pls_rep_12m,0) as stg_pln_sum_prc_amt_ovd_14d_pls_rep_12m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m2_pls_rep_12m,0) as stg_pln_sum_prc_amt_ovd_m2_pls_rep_12m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m3_pls_rep_12m,0) as stg_pln_sum_prc_amt_ovd_m3_pls_rep_12m
        ,coalesce(plan2.stg_pln_sum_prc_amt_ovd_m4_pls_rep_12m,0) as stg_pln_sum_prc_amt_ovd_m4_pls_rep_12m
        --/*金额--单笔最大*/
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_pls_rep_12m,0) as stg_pln_max_prc_amt_ovd_pls_rep_12m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_1d_3d_rep_12m,0) as stg_pln_max_prc_amt_ovd_1d_3d_rep_12m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_3d_pls_rep_12m,0) as stg_pln_max_prc_amt_ovd_3d_pls_rep_12m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_7d_pls_rep_12m,0) as stg_pln_max_prc_amt_ovd_7d_pls_rep_12m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_14d_pls_rep_12m,0) as stg_pln_max_prc_amt_ovd_14d_pls_rep_12m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m2_pls_rep_12m,0) as stg_pln_max_prc_amt_ovd_m2_pls_rep_12m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m3_pls_rep_12m,0) as stg_pln_max_prc_amt_ovd_m3_pls_rep_12m
        ,coalesce(plan2.stg_pln_max_prc_amt_ovd_m4_pls_rep_12m,0) as stg_pln_max_prc_amt_ovd_m4_pls_rep_12m
        --/*金额--单笔最小*/
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_pls_rep_12m,0) as stg_pln_min_prc_amt_ovd_pls_rep_12m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_1d_3d_rep_12m,0) as stg_pln_min_prc_amt_ovd_1d_3d_rep_12m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_3d_pls_rep_12m,0) as stg_pln_min_prc_amt_ovd_3d_pls_rep_12m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_7d_pls_rep_12m,0) as stg_pln_min_prc_amt_ovd_7d_pls_rep_12m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_14d_pls_rep_12m,0) as stg_pln_min_prc_amt_ovd_14d_pls_rep_12m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m2_pls_rep_12m,0) as stg_pln_min_prc_amt_ovd_m2_pls_rep_12m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m3_pls_rep_12m,0) as stg_pln_min_prc_amt_ovd_m3_pls_rep_12m
        ,coalesce(plan2.stg_pln_min_prc_amt_ovd_m4_pls_rep_12m,0) as stg_pln_min_prc_amt_ovd_m4_pls_rep_12m

        --/*分期数*/
        ,coalesce(plan2.stg_pln_cnt_ovd_pls_rep_12m,0) as stg_pln_cnt_ovd_pls_rep_12m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_pls_rep_12m,0) as stg_pln_fst_cnt_ovd_pls_rep_12m
        ,coalesce(plan2.stg_pln_cnt_ovd_1d_3d_rep_12m,0) as stg_pln_cnt_ovd_1d_3d_rep_12m
        ,coalesce(plan2.stg_pln_cnt_ovd_3d_pls_rep_12m,0) as stg_pln_cnt_ovd_3d_pls_rep_12m
        ,coalesce(plan2.stg_pln_fst_cnt_ovd_3d_pls_rep_12m,0) as stg_pln_fst_cnt_ovd_3d_pls_rep_12m
        ,coalesce(plan2.stg_pln_cnt_ovd_7d_pls_rep_12m,0) as stg_pln_cnt_ovd_7d_pls_rep_12m
        ,coalesce(plan2.stg_pln_cnt_ovd_14d_pls_rep_12m,0) as stg_pln_cnt_ovd_14d_pls_rep_12m
        ,coalesce(plan2.stg_pln_cnt_ovd_m2_pls_rep_12m,0) as stg_pln_cnt_ovd_m2_pls_rep_12m
        ,coalesce(plan2.stg_pln_cnt_ovd_m3_pls_rep_12m,0) as stg_pln_cnt_ovd_m3_pls_rep_12m
        ,coalesce(plan2.stg_pln_cnt_ovd_m4_pls_rep_12m,0) as stg_pln_cnt_ovd_m4_pls_rep_12m

        --/*历史逾期天数*/--历史最大、最小
        ,plan2.max_ddf_rep_tim_dte_ovd_pls_rep_12m
        ,plan2.min_ddf_rep_tim_dte_ovd_pls_rep_12m


        ----------------------------------------------------------
        --/*12.1.3 历史还款压力*/
        ----------------------------------------------------------
        --/*历史应还金额*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_his,0) as stg_pln_sum_prc_amt_his
        ,coalesce(plan2.stg_pln_sum_prc_amt_1m_his,0) as stg_pln_sum_prc_amt_1m_his
        ,coalesce(plan2.stg_pln_sum_prc_amt_2m_his,0) as stg_pln_sum_prc_amt_2m_his
        ,coalesce(plan2.stg_pln_sum_prc_amt_3m_his,0) as stg_pln_sum_prc_amt_3m_his
        ,coalesce(plan2.stg_pln_sum_prc_amt_6m_his,0) as stg_pln_sum_prc_amt_6m_his
        ,coalesce(plan2.stg_pln_sum_prc_amt_12m_his,0) as stg_pln_sum_prc_amt_12m_his
        --/*历史应还金额/*首借订单和当前订单*/
        ,coalesce(plan2.stg_pln_sum_prc_amt_his_fst_ord,0) as stg_pln_sum_prc_amt_his_fst_ord
        ,coalesce(plan2.stg_pln_sum_prc_amt_his_cur_ord,0) as stg_pln_sum_prc_amt_his_cur_ord

        --/*历史应还金额--单笔最大*/
        ,coalesce(plan2.stg_pln_max_prc_amt_his,0) as stg_pln_max_prc_amt_his
        ,coalesce(plan2.stg_pln_max_prc_amt_1m_his,0) as stg_pln_max_prc_amt_1m_his
        ,coalesce(plan2.stg_pln_max_prc_amt_3m_his,0) as stg_pln_max_prc_amt_3m_his
        ,coalesce(plan2.stg_pln_max_prc_amt_6m_his,0) as stg_pln_max_prc_amt_6m_his
        ,coalesce(plan2.stg_pln_max_prc_amt_12m_his,0) as stg_pln_max_prc_amt_12m_his
        --/*历史应还金额--单笔最小*/
        ,coalesce(plan2.stg_pln_min_prc_amt_his,0) as stg_pln_min_prc_amt_his
        ,coalesce(plan2.stg_pln_min_prc_amt_1m_his,0) as stg_pln_min_prc_amt_1m_his
        ,coalesce(plan2.stg_pln_min_prc_amt_3m_his,0) as stg_pln_min_prc_amt_3m_his
        ,coalesce(plan2.stg_pln_min_prc_amt_6m_his,0) as stg_pln_min_prc_amt_6m_his
        ,coalesce(plan2.stg_pln_min_prc_amt_12m_his,0) as stg_pln_min_prc_amt_12m_his
        --/*历史应还分期数*/
        ,coalesce(plan2.stg_pln_cnt_his,0) as stg_pln_cnt_his
        ,coalesce(plan2.stg_pln_cnt_1m_his,0) as stg_pln_cnt_1m_his
        ,coalesce(plan2.stg_pln_cnt_2m_his,0) as stg_pln_cnt_2m_his
        ,coalesce(plan2.stg_pln_cnt_3m_his,0) as stg_pln_cnt_3m_his
        ,coalesce(plan2.stg_pln_cnt_6m_his,0) as stg_pln_cnt_6m_his
        ,coalesce(plan2.stg_pln_cnt_12m_his,0) as stg_pln_cnt_12m_his
        --/*历史应还分期数*/*首借订单和当前订单*/
        ,coalesce(plan2.stg_pln_cnt_his_fst_ord,0) as stg_pln_cnt_his_fst_ord
        ,coalesce(plan2.stg_pln_cnt_his_cur_ord,0) as stg_pln_cnt_his_cur_ord

        --/*应还日距评分日天数*/--历史最大、最小
        ,plan2.max_ddf_mdl_rep_dte_his
        ,plan2.min_ddf_mdl_rep_dte_his

-- features range end --
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data  --建模样本
left join ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp1 plan1 on model_data.uid=plan1.uid
left join ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_will_pressure_tmp2 plan2 on model_data.uid=plan2.uid
;
-- feature-copilot:node-end ordinal=0
