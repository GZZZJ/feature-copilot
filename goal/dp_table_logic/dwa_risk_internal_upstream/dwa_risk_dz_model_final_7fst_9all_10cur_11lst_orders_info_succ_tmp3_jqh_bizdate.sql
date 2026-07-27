-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp3_jqh_bizdate
-- node_id: n_3781196367397781504
-- task_name: dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp3_jqh_bizdate.json
-- source_json_sha256: eddc818b00bb35e2d59dd87c36560c2f9d5dcdab25de2c3dc1b0c2a5813199b6
-- upstream_table: dwa.dwa_f_user_register_apply_info_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp2
-- upstream_table: cdmx.cdmx_dim_credit_account_df
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_7suc_weighted_stg_num_tmp
-- upstream_table: dwa_risk.dwa_risk_7fst_orders_info_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp3
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_apply_tmp1
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_detail

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_final_7fst_9all_10cur_11lst_orders_info 
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_apply_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_apply_tmp1 as 
select uid
        ,mdl_dte
-- features range start --
        
        --/*9、交易信息*/
        --/*----------金额-------------*/
        --支用申请总金额
        ,sum(prc_amt) as ord_apl_sum_prc_amt_his
        ,sum(case when ddf_30_day_flag=1 then prc_amt else 0 end) as ord_apl_sum_prc_amt_30_day
        ,sum(case when ddf_90_day_flag=1 then prc_amt else 0 end) as ord_apl_sum_prc_amt_90_day
        ,sum(case when ddf_180_day_flag=1 then prc_amt else 0 end) as ord_apl_sum_prc_amt_180_day
        ,sum(case when ddf_360_day_flag=1 then prc_amt else 0 end) as ord_apl_sum_prc_amt_360_day
        --单笔支用申请最大申请金额
        ,max(prc_amt) as ord_apl_max_prc_amt_his
        ,max(case when ddf_30_day_flag=1 then prc_amt else 0 end) as ord_apl_max_prc_amt_30_day
        ,max(case when ddf_90_day_flag=1 then prc_amt else 0 end) as ord_apl_max_prc_amt_90_day
        ,max(case when ddf_180_day_flag=1 then prc_amt else 0 end) as ord_apl_max_prc_amt_180_day
        ,max(case when ddf_360_day_flag=1 then prc_amt else 0 end) as ord_apl_max_prc_amt_360_day
        --单笔支用申请最小申请金额
        ,min(prc_amt) as ord_apl_min_prc_amt_his
        ,min(case when ddf_30_day_flag=1 then prc_amt else 0 end) as ord_apl_min_prc_amt_30_day
        ,min(case when ddf_90_day_flag=1 then prc_amt else 0 end) as ord_apl_min_prc_amt_90_day
        ,min(case when ddf_180_day_flag=1 then prc_amt else 0 end) as ord_apl_min_prc_amt_180_day
        ,min(case when ddf_360_day_flag=1 then prc_amt else 0 end) as ord_apl_min_prc_amt_360_day

        --/*----------订单数-------------*/
        --支用申请次数
        ,count(dtl_ord_no) as ord_apl_cnt_his
        ,count(case when ddf_30_day_flag=1 then dtl_ord_no else null end) as ord_apl_cnt_30_day
        ,count(case when ddf_90_day_flag=1 then dtl_ord_no else null end) as ord_apl_cnt_90_day
        ,count(case when ddf_180_day_flag=1 then dtl_ord_no else null end) as ord_apl_cnt_180_day
        ,count(case when ddf_360_day_flag=1 then dtl_ord_no else null end) as ord_apl_cnt_360_day
        
        --/*------------分借款时间（小时）-------------*/
        --小时数0到3点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_30_day_00_03
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_90_day_00_03
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_180_day_00_03
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_360_day_00_03
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_cnt_30_day_00_03
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_cnt_90_day_00_03
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_cnt_180_day_00_03
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_cnt_360_day_00_03

        --小时数4到6点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_30_day_04_06
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_90_day_04_06
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_180_day_04_06
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_360_day_04_06
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_cnt_30_day_04_06
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_cnt_90_day_04_06
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_cnt_180_day_04_06
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_cnt_360_day_04_06

        --小时数7到12点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_30_day_07_12
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_90_day_07_12
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_180_day_07_12
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_360_day_07_12
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_cnt_30_day_07_12
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_cnt_90_day_07_12
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_cnt_180_day_07_12
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_cnt_360_day_07_12

        --小时数13到18点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_30_day_13_18
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_90_day_13_18
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_180_day_13_18
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_360_day_13_18
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_cnt_30_day_13_18
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_cnt_90_day_13_18
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_cnt_180_day_13_18
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_cnt_360_day_13_18

        --小时数19到23点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_30_day_19_23
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_90_day_19_23
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_180_day_19_23
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_sum_prc_amt_360_day_19_23
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_cnt_30_day_19_23
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_cnt_90_day_19_23
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_cnt_180_day_19_23
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_cnt_360_day_19_23

        -- --/*首次失败动支申请*/
        --支用申请次数-交易失败订单
        ,count(case when ord_stt_flg='fail' then dtl_ord_no else null end) as ord_apl_fal_cnt_his
        ,count(case when ord_stt_flg='fail' and ddf_30_day_flag=1 then dtl_ord_no else null end) as ord_apl_fal_cnt_30_day
        ,count(case when ord_stt_flg='fail' and ddf_90_day_flag=1 then dtl_ord_no else null end) as ord_apl_fal_cnt_90_day
        ,count(case when ord_stt_flg='fail' and ddf_180_day_flag=1 then dtl_ord_no else null end) as ord_apl_fal_cnt_180_day
        ,count(case when ord_stt_flg='fail' and ddf_360_day_flag=1 then dtl_ord_no else null end) as ord_apl_fal_cnt_360_day
        
        --时间戳格式的订单创建时间--首次订单失败时间
        ,max(case when fst_ord_flg=1 and ord_stt_flg='fail' then crt_tim else null end) as fst_fal_ord_crt_tim
        ,max(case when fst_ord_flg=1 and ord_stt_flg='fail' then crt_dte else null end) as fst_fal_ord_crt_dte
        ,max(case when fst_ord_flg=1 and ord_stt_flg='fail' then stg_num else null end) as fst_fal_ord_stg_num
        ,max(case when fst_ord_flg=1 and ord_stt_flg='fail' then prc_amt else null end) as fst_fal_ord_prc_amt
        ,max(case when fst_ord_flg=1 and ord_stt_flg='fail' then bsy_typ else null end) as fst_fal_ord_bsy_typ
        --首次订单失败时间--时点
        ,max(case when fst_ord_flg=1 and ord_stt_flg='fail' then crt_hor_flg else null end) as fst_fal_ord_crt_tim_hor
        
        --交易发起时间前后间隔（天）
        ,max(datediff(date(crt_tim),date(lag_crt_tim))) as max_ddf_lag_crt_dte
        ,min(datediff(date(crt_tim),date(lag_crt_tim))) as min_ddf_lag_crt_dte
        --交易发起时间前后间隔（最小/分钟）
        ,round(min(unix_timestamp(crt_tim)-unix_timestamp(lag_crt_tim))/60,2) as min_ddf_lag_crt_tim_mnt

        --/*----------所有订单中 bt / cash 类型比较 -------------*/
        ,count(case when ddf_30_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_30_day_bt_apl_ord_cnt
        ,count(case when ddf_90_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_90_day_bt_apl_ord_cnt
        ,count(case when ddf_180_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_180_day_bt_apl_ord_cnt
        ,count(case when ddf_360_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_360_day_bt_apl_ord_cnt

        ,count(case when ddf_30_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_30_day_csh_apl_ord_cnt
        ,count(case when ddf_90_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_90_day_csh_apl_ord_cnt
        ,count(case when ddf_180_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_180_day_csh_apl_ord_cnt
        ,count(case when ddf_360_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_360_day_csh_apl_ord_cnt

        ,count(dtl_ord_no) as his_apl_ord_cnt

        --/*----------所有订单中 金额区间 -------------*/
        ,count(case when ddf_30_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_1_000_flg_apl_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_1_000_flg_apl_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_1_000_flg_apl_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_1_000_flg_apl_ord_cnt

        ,count(case when ddf_30_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_3_000_flg_apl_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_3_000_flg_apl_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_3_000_flg_apl_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_3_000_flg_apl_ord_cnt

        ,count(case when ddf_30_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_5_000_flg_apl_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_5_000_flg_apl_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_5_000_flg_apl_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_5_000_flg_apl_ord_cnt

        ,count(case when ddf_30_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_10_000_flg_apl_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_10_000_flg_apl_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_10_000_flg_apl_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_10_000_flg_apl_ord_cnt

-- features range end --
                
from   (select *
                ,lag(crt_tim) over(partition by uid order by crt_tim asc) as lag_crt_tim
        from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail
        )main
group by uid
        ,mdl_dte
;



drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp2 as 
select uid
        ,mdl_dte
-- features range start --

        --/*7、首次动支信息*/
        ,max(case when fst_ord_flg=1 then crt_dte else null end) as fst_ord_crt_dte
        --时间戳格式的订单创建时间
        ,max(case when fst_ord_flg=1 then crt_tim else null end) as fst_ord_crt_tim
        ,max(case when fst_ord_flg=1 then stg_num else null end) as fst_ord_stg_num
        ,max(case when fst_ord_flg=1 then prc_amt else null end) as fst_ord_prc_amt
        ,max(case when fst_ord_flg=1 then bsy_typ else null end) as fst_ord_bsy_typ
        --首次订单成功时间--时点
        ,max(case when fst_ord_flg=1 then crt_hor_flg else null end) as fst_suc_ord_crt_tim_hor
        

        --/*10、当前动支信息*/
        ,max(case when cur_ord_flg=1 then crt_dte else null end) as cur_ord_crt_dte
        ,max(case when cur_ord_flg=1 then stg_num else null end) as cur_ord_stg_num
        ,max(case when cur_ord_flg=1 then prc_amt else null end) as cur_ord_prc_amt
        ,max(case when cur_ord_flg=1 then bsy_typ else null end) as cur_ord_bsy_typ
        --截止当前订单的订单总数
        ,max(case when cur_ord_flg=1 then fst_ord_flg else null end) as cur_ord_rn

        --/*11、最近动支信息*/
        ,max(case when lst_ord_flg=1 then crt_dte else null end) as lst_ord_crt_dte
        ,max(case when lst_ord_flg=1 then stg_num else null end) as lst_ord_stg_num
        ,max(case when lst_ord_flg=1 then prc_amt else null end) as lst_ord_prc_amt
        ,max(case when lst_ord_flg=1 then bsy_typ else null end) as lst_ord_bsy_typ

        --/*9、交易信息*/
        
        --/*----------金额-------------*/
        --支用申请成功总金额
        ,sum(prc_amt) as ord_apl_suc_sum_prc_amt_his
        ,sum(case when ddf_30_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_30_day
        ,sum(case when ddf_90_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_90_day
        ,sum(case when ddf_180_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_180_day
        ,sum(case when ddf_360_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_360_day
        --单笔支用申请成功最大申请成功金额
        ,max(prc_amt) as ord_apl_suc_max_prc_amt_his
        ,max(case when ddf_30_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_max_prc_amt_30_day
        ,max(case when ddf_90_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_max_prc_amt_90_day
        ,max(case when ddf_180_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_max_prc_amt_180_day
        ,max(case when ddf_360_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_max_prc_amt_360_day
        --单笔支用申请成功最小申请成功金额
        ,min(prc_amt) as ord_apl_suc_min_prc_amt_his
        ,min(case when ddf_30_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_min_prc_amt_30_day
        ,min(case when ddf_90_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_min_prc_amt_90_day
        ,min(case when ddf_180_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_min_prc_amt_180_day
        ,min(case when ddf_360_day_flag=1 then prc_amt else 0 end) as ord_apl_suc_min_prc_amt_360_day


        --/*----------金额-复借标识-------------*/
        --支用申请成功总金额-复借标识
        ,sum(case when fst_ord_flg>1 then prc_amt else 0 end) as pst_ord_apl_suc_sum_prc_amt_his
        ,sum(case when fst_ord_flg>1 and ddf_30_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_sum_prc_amt_30_day
        ,sum(case when fst_ord_flg>1 and ddf_90_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_sum_prc_amt_90_day
        ,sum(case when fst_ord_flg>1 and ddf_180_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_sum_prc_amt_180_day
        ,sum(case when fst_ord_flg>1 and ddf_360_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_sum_prc_amt_360_day
        --单笔支用申请成功最大申请成功金额-复借标识
        ,max(case when fst_ord_flg>1 then prc_amt else 0 end) as pst_ord_apl_suc_max_prc_amt_his
        ,max(case when fst_ord_flg>1 and ddf_30_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_max_prc_amt_30_day
        ,max(case when fst_ord_flg>1 and ddf_90_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_max_prc_amt_90_day
        ,max(case when fst_ord_flg>1 and ddf_180_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_max_prc_amt_180_day
        ,max(case when fst_ord_flg>1 and ddf_360_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_max_prc_amt_360_day
        --单笔支用申请成功最小申请成功金额-复借标识
        ,min(case when fst_ord_flg>1 then prc_amt else 0 end) as pst_ord_apl_suc_min_prc_amt_his
        ,min(case when fst_ord_flg>1 and ddf_30_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_min_prc_amt_30_day
        ,min(case when fst_ord_flg>1 and ddf_90_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_min_prc_amt_90_day
        ,min(case when fst_ord_flg>1 and ddf_180_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_min_prc_amt_180_day
        ,min(case when fst_ord_flg>1 and ddf_360_day_flag=1 then prc_amt else 0 end) as pst_ord_apl_suc_min_prc_amt_360_day


        --/*----------订单数-------------*/
        --历史结清订单数
        --,count(case when ord_stt='PAY_OFF' then dtl_ord_no else null end) as ord_apl_suc_cnt_his_pay_off
        --分时间切片看历史结清订单数
        --待补充
        
        --支用申请成功次数
        ,count(dtl_ord_no) as ord_apl_suc_cnt_his
        ,count(case when ddf_30_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_cnt_30_day
        ,count(case when ddf_90_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_cnt_90_day
        ,count(case when ddf_180_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_cnt_180_day
        ,count(case when ddf_360_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_cnt_360_day
        --支用申请成功次数_6期订单
        ,count(case when stg_num=6 then dtl_ord_no else null end) as ord_apl_suc_6_cnt_his
        ,count(case when stg_num=6 and ddf_30_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_6_cnt_30_day
        ,count(case when stg_num=6 and ddf_90_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_6_cnt_90_day
        ,count(case when stg_num=6 and ddf_180_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_6_cnt_180_day
        ,count(case when stg_num=6 and ddf_360_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_6_cnt_360_day
        --支用申请成功次数_12期订单
        ,count(case when stg_num=12 then dtl_ord_no else null end) as ord_apl_suc_12_cnt_his
        ,count(case when stg_num=12 and ddf_30_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_12_cnt_30_day
        ,count(case when stg_num=12 and ddf_90_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_12_cnt_90_day
        ,count(case when stg_num=12 and ddf_180_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_12_cnt_180_day
        ,count(case when stg_num=12 and ddf_360_day_flag=1 then dtl_ord_no else null end) as ord_apl_suc_12_cnt_360_day
        --支用申请成功次数-复借标识
        ,count(case when fst_ord_flg>1 then dtl_ord_no else null end) as pst_ord_apl_suc_cnt_his
        ,count(case when fst_ord_flg>1 and ddf_30_day_flag=1 then dtl_ord_no else null end) as pst_ord_apl_suc_cnt_30_day
        ,count(case when fst_ord_flg>1 and ddf_90_day_flag=1 then dtl_ord_no else null end) as pst_ord_apl_suc_cnt_90_day
        ,count(case when fst_ord_flg>1 and ddf_180_day_flag=1 then dtl_ord_no else null end) as pst_ord_apl_suc_cnt_180_day
        ,count(case when fst_ord_flg>1 and ddf_360_day_flag=1 then dtl_ord_no else null end) as pst_ord_apl_suc_cnt_360_day
        
        -- --/*------------借款时间（小时）的表现-------------*/
        --小时数0到3点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_30_day_00_03
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_90_day_00_03
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_180_day_00_03
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='0到3点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_360_day_00_03
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_30_day_00_03
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_90_day_00_03
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_180_day_00_03
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='0到3点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_360_day_00_03

        --小时数4到6点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_30_day_04_06
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_90_day_04_06
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_180_day_04_06
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='4到6点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_360_day_04_06
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_30_day_04_06
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_90_day_04_06
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_180_day_04_06
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='4到6点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_360_day_04_06

        --小时数7到12点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_30_day_07_12
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_90_day_07_12
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_180_day_07_12
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='7到12点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_360_day_07_12
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_30_day_07_12
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_90_day_07_12
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_180_day_07_12
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='7到12点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_360_day_07_12

        -- --/*----------最大最小间隔-------------*/
        -- --交易成功发起时间和评分日间隔
        -- ,max(ddf_mdl_ord_crt_dte) as max_ddf_mdl_suc_ord_crt_dte
        -- ,min(ddf_mdl_ord_crt_dte) as min_ddf_mdl_suc_ord_crt_dte
        --交易成功发起时间前后间隔（天）
        ,max(datediff(date(crt_tim),date(lag_suc_crt_tim))) as max_ddf_suc_lag_crt_dte
        ,min(datediff(date(crt_tim),date(lag_suc_crt_tim))) as min_ddf_suc_lag_crt_dte
        --交易成功发起时间前后间隔（最小/分钟）
        ,round(min(unix_timestamp(crt_tim)-unix_timestamp(lag_suc_crt_tim))/60,2) as min_ddf_suc_lag_crt_tim_mnt

        --最大借款金额订单产生时间距评分日间隔（若有相等取最近一笔）
        ,max(case when prc_amt_rn=1 then ddf_mdl_ord_crt_dte else null end) as ddf_mdl_max_suc_prc_amt_ord_crt_dte
        -- ,max(datediff(date('评分日'),case when prc_amt_rn=1 then crt_dte else null end)) as ddf_mdl_max_suc_prc_amt_ord_crt_dte

        --最大借款分期数订单产生时间距评分日间隔（若有相等取最近一笔）
        ,max(case when stg_num_rn=1 then ddf_mdl_ord_crt_dte else null end) as ddf_mdl_max_suc_stg_num_ord_crt_dte
        -- ,max(datediff(date('评分日'),case when stg_num_rn=1 then crt_dte else null end)) as ddf_mdl_max_suc_stg_num_ord_crt_dte

-- features range end --

from   (select *
-- features range start --
                ,lag(crt_tim) over(partition by uid order by crt_tim asc) as lag_suc_crt_tim --上一笔成功交易时间
                ,row_number() over(partition by uid order by prc_amt desc,crt_tim desc) as prc_amt_rn --最大成功交易金额flag（有相等的取最近的一笔）
                ,row_number() over(partition by uid order by stg_num desc,crt_tim desc) as stg_num_rn --最大交易期数flag（有相等的取最近的一笔）
-- features range end --
        
        from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail
        where ord_stt_flg='success'
        )tmp
group by uid
        ,mdl_dte
;



drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp3;
create table ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp3 as 
select uid
        ,mdl_dte
-- features range start --

        --小时数13到18点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_30_day_13_18
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_90_day_13_18
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_180_day_13_18
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='13到18点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_360_day_13_18
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_30_day_13_18
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_90_day_13_18
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_180_day_13_18
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='13到18点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_360_day_13_18


        --小时数19到23点
        --金额
        ,sum(case when ddf_30_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_30_day_19_23
        ,sum(case when ddf_90_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_90_day_19_23
        ,sum(case when ddf_180_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_180_day_19_23
        ,sum(case when ddf_360_day_flag=1 and crt_hor_flg='19到23点借款' then prc_amt else 0 end) as ord_apl_suc_sum_prc_amt_360_day_19_23
        --次数
        ,count(case when ddf_30_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_30_day_19_23
        ,count(case when ddf_90_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_90_day_19_23
        ,count(case when ddf_180_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_180_day_19_23
        ,count(case when ddf_360_day_flag=1 and crt_hor_flg='19到23点借款' then dtl_ord_no else null end) as ord_apl_suc_cnt_360_day_19_23

        
        --/*----------分期数-------------*/
        --支用申请成功总分期数
        ,sum(stg_num) as ord_apl_suc_sum_stg_num_his
        ,sum(case when ddf_30_day_flag=1 then stg_num else 0 end) as ord_apl_suc_sum_stg_num_30_day
        ,sum(case when ddf_90_day_flag=1 then stg_num else 0 end) as ord_apl_suc_sum_stg_num_90_day
        ,sum(case when ddf_180_day_flag=1 then stg_num else 0 end) as ord_apl_suc_sum_stg_num_180_day
        ,sum(case when ddf_360_day_flag=1 then stg_num else 0 end) as ord_apl_suc_sum_stg_num_360_day
        --单笔支用申请成功最大申请成功分期数
        ,max(stg_num) as ord_apl_suc_max_stg_num_his
        ,max(case when ddf_30_day_flag=1 then stg_num else 0 end) as ord_apl_suc_max_stg_num_30_day
        ,max(case when ddf_90_day_flag=1 then stg_num else 0 end) as ord_apl_suc_max_stg_num_90_day
        ,max(case when ddf_180_day_flag=1 then stg_num else 0 end) as ord_apl_suc_max_stg_num_180_day
        ,max(case when ddf_360_day_flag=1 then stg_num else 0 end) as ord_apl_suc_max_stg_num_360_day
        --单笔支用申请成功最小申请成功分期数
        ,min(stg_num) as ord_apl_suc_min_stg_num_his
        ,min(case when ddf_30_day_flag=1 then stg_num else 0 end) as ord_apl_suc_min_stg_num_30_day
        ,min(case when ddf_90_day_flag=1 then stg_num else 0 end) as ord_apl_suc_min_stg_num_90_day
        ,min(case when ddf_180_day_flag=1 then stg_num else 0 end) as ord_apl_suc_min_stg_num_180_day
        ,min(case when ddf_360_day_flag=1 then stg_num else 0 end) as ord_apl_suc_min_stg_num_360_day
        --复借标识--分期数
        ,sum(case when fst_ord_flg>1 then stg_num else 0 end) as pst_ord_apl_suc_sum_stg_num_his
        ,sum(case when fst_ord_flg>1 and ddf_30_day_flag=1 then stg_num else 0 end) as pst_ord_apl_suc_sum_stg_num_30_day
        ,sum(case when fst_ord_flg>1 and ddf_90_day_flag=1 then stg_num else 0 end) as pst_ord_apl_suc_sum_stg_num_90_day
        ,sum(case when fst_ord_flg>1 and ddf_180_day_flag=1 then stg_num else 0 end) as pst_ord_apl_suc_sum_stg_num_180_day
        ,sum(case when fst_ord_flg>1 and ddf_360_day_flag=1 then stg_num else 0 end) as pst_ord_apl_suc_sum_stg_num_360_day


        --/*----------产品类型数-------------*/
        ,count(distinct bsy_typ) as bsy_typ_suc_cnt_his
        ,count(distinct case when ddf_30_day_flag=1 then bsy_typ else null end) as bsy_typ_suc_cnt_30_day
        ,count(distinct case when ddf_90_day_flag=1 then bsy_typ else null end) as bsy_typ_suc_cnt_90_day
        ,count(distinct case when ddf_180_day_flag=1 then bsy_typ else null end) as bsy_typ_suc_cnt_180_day
        ,count(distinct case when ddf_360_day_flag=1 then bsy_typ else null end) as bsy_typ_suc_cnt_360_day

        --/*----------近期是否借过not_bt_cash-------------*/
        ,max(case when new_bsy_typ='not_bt_cash' then 1 else 0 end) as if_not_bt_csh_suc_his
        ,max(case when ddf_30_day_flag=1 and new_bsy_typ='not_bt_cash' then 1 else 0 end) as if_not_bt_csh_suc_30_day
        ,max(case when ddf_90_day_flag=1 and new_bsy_typ='not_bt_cash' then 1 else 0 end) as if_not_bt_csh_suc_90_day
        ,max(case when ddf_180_day_flag=1 and new_bsy_typ='not_bt_cash' then 1 else 0 end) as if_not_bt_csh_suc_180_day
        ,max(case when ddf_360_day_flag=1 and new_bsy_typ='not_bt_cash' then 1 else 0 end) as if_not_bt_csh_suc_360_day

        --/*----------成功订单中 bt / cash 类型比较 -------------*/
        ,count(case when ddf_30_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_30_day_bt_suc_ord_cnt
        ,count(case when ddf_90_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_90_day_bt_suc_ord_cnt
        ,count(case when ddf_180_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_180_day_bt_suc_ord_cnt
        ,count(case when ddf_360_day_flag=1 and bsy_typ='BALANCE_TRANSFER' then dtl_ord_no else null end) as his_360_day_bt_suc_ord_cnt

        ,count(case when ddf_30_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_30_day_csh_suc_ord_cnt
        ,count(case when ddf_90_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_90_day_csh_suc_ord_cnt
        ,count(case when ddf_180_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_180_day_csh_suc_ord_cnt
        ,count(case when ddf_360_day_flag=1 and bsy_typ='CASH' then dtl_ord_no else null end) as his_360_day_csh_suc_ord_cnt

        ,count(dtl_ord_no) as his_suc_ord_cnt


        --/*----------成功订单中 金额区间 -------------*/
        ,count(case when ddf_30_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_1_000_flg_suc_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_1_000_flg_suc_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_1_000_flg_suc_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_1_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_1_000_flg_suc_ord_cnt

        ,count(case when ddf_30_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_3_000_flg_suc_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_3_000_flg_suc_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_3_000_flg_suc_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_3_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_3_000_flg_suc_ord_cnt

        ,count(case when ddf_30_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_5_000_flg_suc_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_5_000_flg_suc_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_5_000_flg_suc_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_5_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_5_000_flg_suc_ord_cnt

        ,count(case when ddf_30_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_30_day_prc_amt_10_000_flg_suc_ord_cnt
        ,count(case when ddf_90_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_90_day_prc_amt_10_000_flg_suc_ord_cnt
        ,count(case when ddf_180_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_180_day_prc_amt_10_000_flg_suc_ord_cnt
        ,count(case when ddf_360_day_flag=1 and prc_amt_10_000_flg=1 then dtl_ord_no else null end) as his_360_day_prc_amt_10_000_flg_suc_ord_cnt

-- features range end --

from    (select *
        from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail
        where ord_stt_flg='success'
        )tmp
group by uid
        ,mdl_dte
;


drop table if exists ${dwa_risk}.dwa_risk_7suc_weighted_stg_num_tmp;
create table ${dwa_risk}.dwa_risk_7suc_weighted_stg_num_tmp as 
select main.uid
        ,main.mdl_dte
-- features range start --
        --加权分期数
        ,sum(prc_amt*stg_num/sum_suc_prc_amt) as ord_apl_suc_weighted_stg_num_his
        ,sum(case when ddf_30_day_flag=1 then (prc_amt*stg_num/sum_suc_prc_amt_30_day) else 0 end) as ord_apl_suc_weighted_stg_num_30_day
        ,sum(case when ddf_90_day_flag=1 then (prc_amt*stg_num/sum_suc_prc_amt_90_day) else 0 end) as ord_apl_suc_weighted_stg_num_90_day
        ,sum(case when ddf_180_day_flag=1 then (prc_amt*stg_num/sum_suc_prc_amt_180_day) else 0 end) as ord_apl_suc_weighted_stg_num_180_day
        ,sum(case when ddf_360_day_flag=1 then (prc_amt*stg_num/sum_suc_prc_amt_360_day) else 0 end) as ord_apl_suc_weighted_stg_num_360_day
-- features range end --
from    
        (select uid
                ,mdl_dte
                ,dtl_ord_no
                ,ddf_30_day_flag
                ,ddf_90_day_flag
                ,ddf_180_day_flag
                ,ddf_360_day_flag
                ,prc_amt
                ,stg_num
        from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail
        where ord_stt_flg='success'
        )main
        
        left join
        (select uid
                ,mdl_dte
                ,sum(prc_amt) as sum_suc_prc_amt
                ,sum(case when ddf_30_day_flag=1 then prc_amt else 0 end) as sum_suc_prc_amt_30_day
                ,sum(case when ddf_90_day_flag=1 then prc_amt else 0 end) as sum_suc_prc_amt_90_day
                ,sum(case when ddf_180_day_flag=1 then prc_amt else 0 end) sum_suc_prc_amt_180_day
                ,sum(case when ddf_360_day_flag=1 then prc_amt else 0 end) as sum_suc_prc_amt_360_day        
        from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail
        where ord_stt_flg='success'
        group by uid
                ,mdl_dte
        )tmp_grp on main.uid=tmp_grp.uid
group by main.uid
        ,main.mdl_dte
;




drop table if exists ${dwa_risk}.dwa_risk_7fst_orders_info_tmp;
create table ${dwa_risk}.dwa_risk_7fst_orders_info_tmp as 
select order_succ1.uid
        ,order_succ1.mdl_dte
-- features range start --
        --/*7、首次成功动支信息*/
         --申完时间与首次动支日间隔（天）
        ,datediff(order_succ1.fst_ord_crt_dte,register_apply.ato_tim) as ddf_ato_fst_ord_crt_dte
        --首次授信时间与首次动支日间隔（天）
        ,datediff(order_succ1.fst_ord_crt_dte,first_credit.fst_adt_crt_dte) as ddf_fst_adt_fst_ord_crt_dte
         --首次授信时间与首次动支日间隔（分钟）
        ,round((unix_timestamp(order_succ1.fst_ord_crt_tim)-unix_timestamp(first_credit.fst_adt_crt_tim))/60,2) as ddf_fst_adt_fst_ord_crt_dte_mnt
        --首次动支时间和评分日间隔（天）
        ,datediff(order_succ1.mdl_dte,order_succ1.fst_ord_crt_dte) as ddf_mdl_fst_ord_crt_dte
         --首次动支时间和当前订单间隔（天）
        ,datediff(order_succ1.cur_ord_crt_dte,order_succ1.fst_ord_crt_dte) as ddf_fst_cur_ord_crt_dte
         --首次动支时间和最近订单间隔（天）
        ,datediff(order_succ1.lst_ord_crt_dte,order_succ1.fst_ord_crt_dte) as ddf_fst_lst_ord_crt_dte
         --首次动支额度使用率
        ,case when first_credit.fst_adt_lmt=0 then null else order_succ1.fst_ord_prc_amt/first_credit.fst_adt_lmt end as fst_ord_prc_fst_adt_lmt_rto
        --/*10、当前成功动支信息*/
         --当前订单动支时间和评分日间隔（天）
        ,datediff(order_succ1.mdl_dte,order_succ1.cur_ord_crt_dte) as ddf_mdl_cur_ord_crt_dte
        --/*11、最近成功动支信息*/
        --最近订单动支时间和评分日间隔（天）
        ,datediff(order_succ1.mdl_dte,order_succ1.lst_ord_crt_dte) as ddf_mdl_lst_ord_crt_dte

-- features range end --

from (select uid
            ,mdl_dte
            ,fst_ord_crt_dte
            ,fst_ord_crt_tim
            ,cur_ord_crt_dte
            ,lst_ord_crt_dte
            ,fst_ord_prc_amt
    -- features range end --
    from ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp2
    )order_succ1
--/*2、注册环节*/
--/*4、申请环节*/
left join
(select uid
        ,date(register_time) as reg_tim  --注册日
        ,date(first_apply_finish_time_all) as ato_tim  --申完日
        ,date(first_liveness_photo_time) as pho_tim  --人脸识别完成时间
        ,date(first_identification_time) as idt_tim  --身份验证完成时间
        ,date(first_bind_card_time) as crd_tim  --绑卡完成时间
        ,date(first_personal_info_verify_time) as inf_tim  --个人信息验证完成时间
from ${dwa}.dwa_f_user_register_apply_info_df
where ds = '${bizdate}'
)register_apply on order_succ1.uid=register_apply.uid

------------------------------------------------------------------------------
--/*5、授信信息*/
left join
        (
        select uid
                ,adt_lmt as fst_adt_lmt
                --首次授信额度时间
                ,date(amt_crt_tim) as fst_adt_crt_dte
                --首次授信额度时间(时间戳格式)
                ,amt_crt_tim as fst_adt_crt_tim
        from (
        -- select uid
        --         ,crt_time as amt_crt_tim
        --         ,first_risk_credit_limit as adt_lmt
        --         ,row_number() over(partition by uid order by crt_time asc) as rn
        -- from ${ld_loan}.dim_account_info
        -- where ds = '${bizdate}'
        -- -- and  business_type in ('BALANCE_TRANSFER','CASH','ENJOY_PAY','BUSINESS_LOAN'
        -- --                         ,'CREDIT_TRANSACTION','HUGE_LOAN','API_ASSET','HB_IMPREST') 
        -- and account_assets_type = 'HEAVY'
        select uid
                ,account_open_time as amt_crt_tim
                ,first_risk_credit_limit as adt_lmt
                ,row_number() over(partition by uid order by account_open_time asc) as rn
        from cdmx.cdmx_dim_credit_account_df
        where ds = '${bizdate}'
        and credit_account_asset_type = '重资产账户'
                                ) tmp
        where rn = 1 
)first_credit on order_succ1.uid=first_credit.uid;


------------------【特征计算结果表】--------------------

--参数：
--0--项目名
--1--建模样本数据集，例：default.model_data
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_df partition(ds='${bizdate}')
select main.*
-- features range start --

        -------------------------------支用申请------------------------------
        --单笔支用申请平均申请金额
        ,case when ord_apl_cnt_his=0 then null else ord_apl_sum_prc_amt_his/ord_apl_cnt_his end as ord_apl_avg_prc_amt_his
        ,case when ord_apl_cnt_30_day=0 then null else ord_apl_sum_prc_amt_30_day/ord_apl_cnt_30_day end as ord_apl_avg_prc_amt_30_day
        ,case when ord_apl_cnt_90_day=0 then null else ord_apl_sum_prc_amt_90_day/ord_apl_cnt_90_day end as ord_apl_avg_prc_amt_90_day
        ,case when ord_apl_cnt_180_day=0 then null else ord_apl_sum_prc_amt_180_day/ord_apl_cnt_180_day end as ord_apl_avg_prc_amt_180_day
        ,case when ord_apl_cnt_360_day=0 then null else ord_apl_sum_prc_amt_360_day/ord_apl_cnt_360_day end as ord_apl_avg_prc_amt_360_day
        --单月支用申请平均申请金额
        ,ord_apl_sum_prc_amt_90_day/3 as ord_apl_avg_prc_amt_90_day_per_mth
        ,ord_apl_sum_prc_amt_180_day/6 as ord_apl_avg_prc_amt_180_day_per_mth
        ,ord_apl_sum_prc_amt_360_day/12 as ord_apl_avg_prc_amt_360_day_per_mth
        --申请金额占比(时间跨度)
        ,case when ord_apl_sum_prc_amt_90_day=0 then null else ord_apl_sum_prc_amt_30_day/ord_apl_sum_prc_amt_90_day end as ord_apl_sum_prc_amt_30_90_day_rto
        ,case when ord_apl_sum_prc_amt_180_day=0 then null else ord_apl_sum_prc_amt_90_day/ord_apl_sum_prc_amt_180_day end as ord_apl_sum_prc_amt_90_180_day_rto
        ,case when ord_apl_sum_prc_amt_360_day=0 then null else ord_apl_sum_prc_amt_180_day/ord_apl_sum_prc_amt_360_day end as ord_apl_sum_prc_amt_180_360_day_rto
        ,case when ord_apl_sum_prc_amt_his=0 then null else ord_apl_sum_prc_amt_360_day/ord_apl_sum_prc_amt_his end as ord_apl_sum_prc_amt_360_day_his_rto
        
        --/*----------所有订单中 bt / cash 类型比较 -------------*/
        ,case when his_apl_ord_cnt=0 then null else his_30_day_bt_apl_ord_cnt/his_apl_ord_cnt end as his_30_day_bt_apl_ord_cnt_his_rto
        ,case when his_apl_ord_cnt=0 then null else his_90_day_bt_apl_ord_cnt/his_apl_ord_cnt end as his_90_day_bt_apl_ord_cnt_his_rto
        ,case when his_apl_ord_cnt=0 then null else his_180_day_bt_apl_ord_cnt/his_apl_ord_cnt end as his_180_day_bt_apl_ord_cnt_his_rto
        ,case when his_apl_ord_cnt=0 then null else his_360_day_bt_apl_ord_cnt/his_apl_ord_cnt end as his_360_day_bt_apl_ord_cnt_his_rto

        ,case when his_apl_ord_cnt=0 then null else his_30_day_csh_apl_ord_cnt/his_apl_ord_cnt end as his_30_day_csh_apl_ord_cnt_his_rto
        ,case when his_apl_ord_cnt=0 then null else his_90_day_csh_apl_ord_cnt/his_apl_ord_cnt end as his_90_day_csh_apl_ord_cnt_his_rto
        ,case when his_apl_ord_cnt=0 then null else his_180_day_csh_apl_ord_cnt/his_apl_ord_cnt end as his_180_day_csh_apl_ord_cnt_his_rto
        ,case when his_apl_ord_cnt=0 then null else his_360_day_csh_apl_ord_cnt/his_apl_ord_cnt end as his_360_day_csh_apl_ord_cnt_his_rto

        ,case when his_30_day_csh_apl_ord_cnt=0 then null else his_30_day_bt_apl_ord_cnt/his_30_day_csh_apl_ord_cnt end as his_30_day_bt_apl_ord_cnt_csh_rto
        ,case when his_90_day_csh_apl_ord_cnt=0 then null else his_90_day_bt_apl_ord_cnt/his_90_day_csh_apl_ord_cnt end as his_90_day_bt_apl_ord_cnt_csh_rto
        ,case when his_180_day_csh_apl_ord_cnt=0 then null else his_180_day_bt_apl_ord_cnt/his_180_day_csh_apl_ord_cnt end as his_180_day_bt_apl_ord_cnt_csh_rto
        ,case when his_360_day_csh_apl_ord_cnt=0 then null else his_360_day_bt_apl_ord_cnt/his_360_day_csh_apl_ord_cnt end as his_360_day_bt_apl_ord_cnt_csh_rto

        -------------------------------成功支用申请------------------------------
        
        --单笔支用申请平均申请金额
        ,case when ord_apl_suc_cnt_his=0 then null else ord_apl_suc_sum_prc_amt_his/ord_apl_suc_cnt_his end as ord_apl_suc_avg_prc_amt_his
        ,case when ord_apl_suc_cnt_30_day=0 then null else ord_apl_suc_sum_prc_amt_30_day/ord_apl_suc_cnt_30_day end as ord_apl_suc_avg_prc_amt_30_day
        ,case when ord_apl_suc_cnt_90_day=0 then null else ord_apl_suc_sum_prc_amt_90_day/ord_apl_suc_cnt_90_day end as ord_apl_suc_avg_prc_amt_90_day
        ,case when ord_apl_suc_cnt_180_day=0 then null else ord_apl_suc_sum_prc_amt_180_day/ord_apl_suc_cnt_180_day end as ord_apl_suc_avg_prc_amt_180_day
        ,case when ord_apl_suc_cnt_360_day=0 then null else ord_apl_suc_sum_prc_amt_360_day/ord_apl_suc_cnt_360_day end as ord_apl_suc_avg_prc_amt_360_day
        --单月支用申请平均申请金额
        ,ord_apl_suc_sum_prc_amt_90_day/3 as ord_apl_suc_avg_prc_amt_90_day_per_mth
        ,ord_apl_suc_sum_prc_amt_180_day/6 as ord_apl_suc_avg_prc_amt_180_day_per_mth
        ,ord_apl_suc_sum_prc_amt_360_day/12 as ord_apl_suc_avg_prc_amt_360_day_per_mth
        --申请金额占比(时间跨度)
        ,case when ord_apl_suc_sum_prc_amt_90_day=0 then null else ord_apl_suc_sum_prc_amt_30_day/ord_apl_suc_sum_prc_amt_90_day end as ord_apl_suc_sum_prc_amt_30_90_day_rto
        ,case when ord_apl_suc_sum_prc_amt_180_day=0 then null else ord_apl_suc_sum_prc_amt_90_day/ord_apl_suc_sum_prc_amt_180_day end as ord_apl_suc_sum_prc_amt_90_180_day_rto
        ,case when ord_apl_suc_sum_prc_amt_360_day=0 then null else ord_apl_suc_sum_prc_amt_180_day/ord_apl_suc_sum_prc_amt_360_day end as ord_apl_suc_sum_prc_amt_180_360_day_rto
        ,case when ord_apl_suc_sum_prc_amt_his=0 then null else ord_apl_suc_sum_prc_amt_360_day/ord_apl_suc_sum_prc_amt_his end as ord_apl_suc_sum_prc_amt_360_day_his_rto
        --单笔支用申请平均分期数
        ,case when ord_apl_suc_cnt_his=0 then null else ord_apl_suc_sum_stg_num_his/ord_apl_suc_cnt_his end as ord_apl_suc_avg_stg_num_his
        ,case when ord_apl_suc_cnt_30_day=0 then null else ord_apl_suc_sum_stg_num_30_day/ord_apl_suc_cnt_30_day end as ord_apl_suc_avg_stg_num_30_day
        ,case when ord_apl_suc_cnt_90_day=0 then null else ord_apl_suc_sum_stg_num_90_day/ord_apl_suc_cnt_90_day end as ord_apl_suc_avg_stg_num_90_day
        ,case when ord_apl_suc_cnt_180_day=0 then null else ord_apl_suc_sum_stg_num_180_day/ord_apl_suc_cnt_180_day end as ord_apl_suc_avg_stg_num_180_day
        ,case when ord_apl_suc_cnt_360_day=0 then null else ord_apl_suc_sum_stg_num_360_day/ord_apl_suc_cnt_360_day end as ord_apl_suc_avg_stg_num_360_day


        --支用申请成功次数_6期订单占比
        ,case when ord_apl_suc_cnt_his=0 then null else ord_apl_suc_6_cnt_his/ord_apl_suc_cnt_his end as ord_apl_suc_6_cnt_his_rto
        ,case when ord_apl_suc_cnt_30_day=0 then null else ord_apl_suc_6_cnt_30_day/ord_apl_suc_cnt_30_day end as ord_apl_suc_6_cnt_30_day_rto
        ,case when ord_apl_suc_cnt_90_day=0 then null else ord_apl_suc_6_cnt_90_day/ord_apl_suc_cnt_90_day end as ord_apl_suc_6_cnt_90_day_rto
        ,case when ord_apl_suc_cnt_180_day=0 then null else ord_apl_suc_6_cnt_180_day/ord_apl_suc_cnt_180_day end as ord_apl_suc_6_cnt_180_day_rto
        ,case when ord_apl_suc_cnt_360_day=0 then null else ord_apl_suc_6_cnt_360_day/ord_apl_suc_cnt_360_day end as ord_apl_suc_6_cnt_360_day_rto
        --支用申请成功次数_12期订单占比
        ,case when ord_apl_suc_cnt_his=0 then null else ord_apl_suc_12_cnt_his/ord_apl_suc_cnt_his end as ord_apl_suc_12_cnt_his_rto
        ,case when ord_apl_suc_cnt_30_day=0 then null else ord_apl_suc_12_cnt_30_day/ord_apl_suc_cnt_30_day end as ord_apl_suc_12_cnt_30_day_rto
        ,case when ord_apl_suc_cnt_90_day=0 then null else ord_apl_suc_12_cnt_90_day/ord_apl_suc_cnt_90_day end as ord_apl_suc_12_cnt_90_day_rto
        ,case when ord_apl_suc_cnt_180_day=0 then null else ord_apl_suc_12_cnt_180_day/ord_apl_suc_cnt_180_day end as ord_apl_suc_12_cnt_180_day_rto
        ,case when ord_apl_suc_cnt_360_day=0 then null else ord_apl_suc_12_cnt_360_day/ord_apl_suc_cnt_360_day end as ord_apl_suc_12_cnt_360_day_rto
        

        --------------/*复借标识*/--------------
        --单笔支用申请平均申请金额
        ,case when pst_ord_apl_suc_cnt_his=0 then null else pst_ord_apl_suc_sum_prc_amt_his/pst_ord_apl_suc_cnt_his end as pst_ord_apl_suc_avg_prc_amt_his
        ,case when pst_ord_apl_suc_cnt_30_day=0 then null else pst_ord_apl_suc_sum_prc_amt_30_day/pst_ord_apl_suc_cnt_30_day end as pst_ord_apl_suc_avg_prc_amt_30_day
        ,case when pst_ord_apl_suc_cnt_90_day=0 then null else pst_ord_apl_suc_sum_prc_amt_90_day/pst_ord_apl_suc_cnt_90_day end as pst_ord_apl_suc_avg_prc_amt_90_day
        ,case when pst_ord_apl_suc_cnt_180_day=0 then null else pst_ord_apl_suc_sum_prc_amt_180_day/pst_ord_apl_suc_cnt_180_day end as pst_ord_apl_suc_avg_prc_amt_180_day
        ,case when pst_ord_apl_suc_cnt_360_day=0 then null else pst_ord_apl_suc_sum_prc_amt_360_day/pst_ord_apl_suc_cnt_360_day end as pst_ord_apl_suc_avg_prc_amt_360_day
        --单月支用申请平均申请金额
        ,pst_ord_apl_suc_sum_prc_amt_90_day/3 as pst_ord_apl_suc_avg_prc_amt_90_day_per_mth
        ,pst_ord_apl_suc_sum_prc_amt_180_day/6 as pst_ord_apl_suc_avg_prc_amt_180_day_per_mth
        ,pst_ord_apl_suc_sum_prc_amt_360_day/12 as pst_ord_apl_suc_avg_prc_amt_360_day_per_mth
        --申请金额占比(时间跨度)
        ,case when pst_ord_apl_suc_sum_prc_amt_90_day=0 then null else pst_ord_apl_suc_sum_prc_amt_30_day/pst_ord_apl_suc_sum_prc_amt_90_day end as pst_ord_apl_suc_sum_prc_amt_30_90_day_rto
        ,case when pst_ord_apl_suc_sum_prc_amt_180_day=0 then null else pst_ord_apl_suc_sum_prc_amt_90_day/pst_ord_apl_suc_sum_prc_amt_180_day end as pst_ord_apl_suc_sum_prc_amt_90_180_day_rto
        ,case when pst_ord_apl_suc_sum_prc_amt_360_day=0 then null else pst_ord_apl_suc_sum_prc_amt_180_day/pst_ord_apl_suc_sum_prc_amt_360_day end as pst_ord_apl_suc_sum_prc_amt_180_360_day_rto
        ,case when pst_ord_apl_suc_sum_prc_amt_his=0 then null else pst_ord_apl_suc_sum_prc_amt_360_day/pst_ord_apl_suc_sum_prc_amt_his end as pst_ord_apl_suc_sum_prc_amt_360_day_his_rto
        --单笔支用申请平均分期数
        ,case when pst_ord_apl_suc_cnt_his=0 then null else pst_ord_apl_suc_sum_stg_num_his/pst_ord_apl_suc_cnt_his end as pst_ord_apl_suc_avg_stg_num_his
        ,case when pst_ord_apl_suc_cnt_30_day=0 then null else pst_ord_apl_suc_sum_stg_num_30_day/pst_ord_apl_suc_cnt_30_day end as pst_ord_apl_suc_avg_stg_num_30_day
        ,case when pst_ord_apl_suc_cnt_90_day=0 then null else pst_ord_apl_suc_sum_stg_num_90_day/pst_ord_apl_suc_cnt_90_day end as pst_ord_apl_suc_avg_stg_num_90_day
        ,case when pst_ord_apl_suc_cnt_180_day=0 then null else pst_ord_apl_suc_sum_stg_num_180_day/pst_ord_apl_suc_cnt_180_day end as pst_ord_apl_suc_avg_stg_num_180_day
        ,case when pst_ord_apl_suc_cnt_360_day=0 then null else pst_ord_apl_suc_sum_stg_num_360_day/pst_ord_apl_suc_cnt_360_day end as pst_ord_apl_suc_avg_stg_num_360_day

        --交易成功发起时间前后间隔(平均)
        ,case when pst_ord_apl_suc_cnt_his=0 then null else ddf_fst_lst_ord_crt_dte/pst_ord_apl_suc_cnt_his end as avg_ddf_fst_lst_ord_crt_dte

        --/*----------成功订单中 bt / cash 类型比较 -------------*/
        ,case when his_suc_ord_cnt=0 then null else his_30_day_bt_suc_ord_cnt/his_suc_ord_cnt end as his_30_day_bt_suc_ord_cnt_his_rto
        ,case when his_suc_ord_cnt=0 then null else his_90_day_bt_suc_ord_cnt/his_suc_ord_cnt end as his_90_day_bt_suc_ord_cnt_his_rto
        ,case when his_suc_ord_cnt=0 then null else his_180_day_bt_suc_ord_cnt/his_suc_ord_cnt end as his_180_day_bt_suc_ord_cnt_his_rto
        ,case when his_suc_ord_cnt=0 then null else his_360_day_bt_suc_ord_cnt/his_suc_ord_cnt end as his_360_day_bt_suc_ord_cnt_his_rto

        ,case when his_suc_ord_cnt=0 then null else his_30_day_csh_suc_ord_cnt/his_suc_ord_cnt end as his_30_day_csh_suc_ord_cnt_his_rto
        ,case when his_suc_ord_cnt=0 then null else his_90_day_csh_suc_ord_cnt/his_suc_ord_cnt end as his_90_day_csh_suc_ord_cnt_his_rto
        ,case when his_suc_ord_cnt=0 then null else his_180_day_csh_suc_ord_cnt/his_suc_ord_cnt end as his_180_day_csh_suc_ord_cnt_his_rto
        ,case when his_suc_ord_cnt=0 then null else his_360_day_csh_suc_ord_cnt/his_suc_ord_cnt end as his_360_day_csh_suc_ord_cnt_his_rto

        ,case when his_30_day_csh_suc_ord_cnt=0 then null else his_30_day_bt_suc_ord_cnt/his_30_day_csh_suc_ord_cnt end as his_30_day_bt_suc_ord_cnt_csh_rto
        ,case when his_90_day_csh_suc_ord_cnt=0 then null else his_90_day_bt_suc_ord_cnt/his_90_day_csh_suc_ord_cnt end as his_90_day_bt_suc_ord_cnt_csh_rto
        ,case when his_180_day_csh_suc_ord_cnt=0 then null else his_180_day_bt_suc_ord_cnt/his_180_day_csh_suc_ord_cnt end as his_180_day_bt_suc_ord_cnt_csh_rto
        ,case when his_360_day_csh_suc_ord_cnt=0 then null else his_360_day_bt_suc_ord_cnt/his_360_day_csh_suc_ord_cnt end as his_360_day_bt_suc_ord_cnt_csh_rto



        ----------------------------【part3 交易申请和成功交易交叉衍生变量】----------------------------
        --待后续探索有价值的变量进行补充
-- features range end --

from
        (select model_data.uid
                ,model_data.mdl_dte
-- features range start --
                ----------------------------【part1 交易申请】----------------------------
                --/*----------金额-------------*/
                --支用申请总金额
                ,coalesce(order_apply.ord_apl_sum_prc_amt_his,0) as ord_apl_sum_prc_amt_his
                ,coalesce(order_apply.ord_apl_sum_prc_amt_30_day,0) as ord_apl_sum_prc_amt_30_day
                ,coalesce(order_apply.ord_apl_sum_prc_amt_90_day,0) as ord_apl_sum_prc_amt_90_day
                ,coalesce(order_apply.ord_apl_sum_prc_amt_180_day,0) as ord_apl_sum_prc_amt_180_day
                ,coalesce(order_apply.ord_apl_sum_prc_amt_360_day,0) as ord_apl_sum_prc_amt_360_day
                --单笔支用申请最大申请金额
                ,coalesce(order_apply.ord_apl_max_prc_amt_his,0) as ord_apl_max_prc_amt_his
                ,coalesce(order_apply.ord_apl_max_prc_amt_30_day,0) as ord_apl_max_prc_amt_30_day
                ,coalesce(order_apply.ord_apl_max_prc_amt_90_day,0) as ord_apl_max_prc_amt_90_day
                ,coalesce(order_apply.ord_apl_max_prc_amt_180_day,0) as ord_apl_max_prc_amt_180_day
                ,coalesce(order_apply.ord_apl_max_prc_amt_360_day,0) as ord_apl_max_prc_amt_360_day
                --单笔支用申请最小申请金额
                ,coalesce(order_apply.ord_apl_min_prc_amt_his,0) as ord_apl_min_prc_amt_his
                ,coalesce(order_apply.ord_apl_min_prc_amt_30_day,0) as ord_apl_min_prc_amt_30_day
                ,coalesce(order_apply.ord_apl_min_prc_amt_90_day,0) as ord_apl_min_prc_amt_90_day
                ,coalesce(order_apply.ord_apl_min_prc_amt_180_day,0) as ord_apl_min_prc_amt_180_day
                ,coalesce(order_apply.ord_apl_min_prc_amt_360_day,0) as ord_apl_min_prc_amt_360_day

                --/*----------订单数-------------*/
                --支用申请次数
                ,coalesce(order_apply.ord_apl_cnt_his,0) as ord_apl_cnt_his
                ,coalesce(order_apply.ord_apl_cnt_30_day,0) as ord_apl_cnt_30_day
                ,coalesce(order_apply.ord_apl_cnt_90_day,0) as ord_apl_cnt_90_day
                ,coalesce(order_apply.ord_apl_cnt_180_day,0) as ord_apl_cnt_180_day
                ,coalesce(order_apply.ord_apl_cnt_360_day,0) as ord_apl_cnt_360_day
                --支用申请次数-交易失败订单
                ,coalesce(order_apply.ord_apl_fal_cnt_his,0) as ord_apl_fal_cnt_his
                ,coalesce(order_apply.ord_apl_fal_cnt_30_day,0) as ord_apl_fal_cnt_30_day
                ,coalesce(order_apply.ord_apl_fal_cnt_90_day,0) as ord_apl_fal_cnt_90_day
                ,coalesce(order_apply.ord_apl_fal_cnt_180_day,0) as ord_apl_fal_cnt_180_day
                ,coalesce(order_apply.ord_apl_fal_cnt_360_day,0) as ord_apl_fal_cnt_360_day
                --首次交易失败订单信息
                --,order_apply.fst_fal_ord_crt_tim
                --,order_apply.fst_fal_ord_crt_dte
                ,order_apply.fst_fal_ord_stg_num
                ,order_apply.fst_fal_ord_prc_amt
                ,order_apply.fst_fal_ord_bsy_typ
                --首次失败申请是否在周末
                ,case when pmod(datediff(fst_fal_ord_crt_dte,date('2000-01-02')),7) in(0,6) then 1 else 0 end as if_fst_fal_ord_wkd
                --首次失败申请时点
                ,order_apply.fst_fal_ord_crt_tim_hor
                
                --交易发起时间前后间隔（天）
                ,order_apply.max_ddf_lag_crt_dte
                ,order_apply.min_ddf_lag_crt_dte
                --交易发起时间前后间隔（最小/分钟）
                ,order_apply.min_ddf_lag_crt_tim_mnt
                
                --/*------------分借款时间（小时）-------------*/
                --小时数0到3点
                --金额
                ,coalesce(order_apply.ord_apl_sum_prc_amt_30_day_00_03,0) as ord_apl_sum_prc_amt_30_day_00_03
                ,coalesce(order_apply.ord_apl_sum_prc_amt_90_day_00_03,0) as ord_apl_sum_prc_amt_90_day_00_03
                ,coalesce(order_apply.ord_apl_sum_prc_amt_180_day_00_03,0) as ord_apl_sum_prc_amt_180_day_00_03
                ,coalesce(order_apply.ord_apl_sum_prc_amt_360_day_00_03,0) as ord_apl_sum_prc_amt_360_day_00_03
                --次数
                ,coalesce(order_apply.ord_apl_cnt_30_day_00_03,0) as ord_apl_cnt_30_day_00_03
                ,coalesce(order_apply.ord_apl_cnt_90_day_00_03,0) as ord_apl_cnt_90_day_00_03
                ,coalesce(order_apply.ord_apl_cnt_180_day_00_03,0) as ord_apl_cnt_180_day_00_03
                ,coalesce(order_apply.ord_apl_cnt_360_day_00_03,0) as ord_apl_cnt_360_day_00_03
                
                --小时数4到6点
                --金额
                ,coalesce(order_apply.ord_apl_sum_prc_amt_30_day_04_06,0) as ord_apl_sum_prc_amt_30_day_04_06
                ,coalesce(order_apply.ord_apl_sum_prc_amt_90_day_04_06,0) as ord_apl_sum_prc_amt_90_day_04_06
                ,coalesce(order_apply.ord_apl_sum_prc_amt_180_day_04_06,0) as ord_apl_sum_prc_amt_180_day_04_06
                ,coalesce(order_apply.ord_apl_sum_prc_amt_360_day_04_06,0) as ord_apl_sum_prc_amt_360_day_04_06
                --次数
                ,coalesce(order_apply.ord_apl_cnt_30_day_04_06,0) as ord_apl_cnt_30_day_04_06
                ,coalesce(order_apply.ord_apl_cnt_90_day_04_06,0) as ord_apl_cnt_90_day_04_06
                ,coalesce(order_apply.ord_apl_cnt_180_day_04_06,0) as ord_apl_cnt_180_day_04_06
                ,coalesce(order_apply.ord_apl_cnt_360_day_04_06,0) as ord_apl_cnt_360_day_04_06
                
                --小时数7到12点
                --金额
                ,coalesce(order_apply.ord_apl_sum_prc_amt_30_day_07_12,0) as ord_apl_sum_prc_amt_30_day_07_12
                ,coalesce(order_apply.ord_apl_sum_prc_amt_90_day_07_12,0) as ord_apl_sum_prc_amt_90_day_07_12
                ,coalesce(order_apply.ord_apl_sum_prc_amt_180_day_07_12,0) as ord_apl_sum_prc_amt_180_day_07_12
                ,coalesce(order_apply.ord_apl_sum_prc_amt_360_day_07_12,0) as ord_apl_sum_prc_amt_360_day_07_12
                --次数
                ,coalesce(order_apply.ord_apl_cnt_30_day_07_12,0) as ord_apl_cnt_30_day_07_12
                ,coalesce(order_apply.ord_apl_cnt_90_day_07_12,0) as ord_apl_cnt_90_day_07_12
                ,coalesce(order_apply.ord_apl_cnt_180_day_07_12,0) as ord_apl_cnt_180_day_07_12
                ,coalesce(order_apply.ord_apl_cnt_360_day_07_12,0) as ord_apl_cnt_360_day_07_12
                
                --小时数13到18点
                --金额
                ,coalesce(order_apply.ord_apl_sum_prc_amt_30_day_13_18,0) as ord_apl_sum_prc_amt_30_day_13_18
                ,coalesce(order_apply.ord_apl_sum_prc_amt_90_day_13_18,0) as ord_apl_sum_prc_amt_90_day_13_18
                ,coalesce(order_apply.ord_apl_sum_prc_amt_180_day_13_18,0) as ord_apl_sum_prc_amt_180_day_13_18
                ,coalesce(order_apply.ord_apl_sum_prc_amt_360_day_13_18,0) as ord_apl_sum_prc_amt_360_day_13_18
                --次数
                ,coalesce(order_apply.ord_apl_cnt_30_day_13_18,0) as ord_apl_cnt_30_day_13_18
                ,coalesce(order_apply.ord_apl_cnt_90_day_13_18,0) as ord_apl_cnt_90_day_13_18
                ,coalesce(order_apply.ord_apl_cnt_180_day_13_18,0) as ord_apl_cnt_180_day_13_18
                ,coalesce(order_apply.ord_apl_cnt_360_day_13_18,0) as ord_apl_cnt_360_day_13_18
                
                
                --小时数19到23点
                --金额
                ,coalesce(order_apply.ord_apl_sum_prc_amt_30_day_19_23,0) as ord_apl_sum_prc_amt_30_day_19_23
                ,coalesce(order_apply.ord_apl_sum_prc_amt_90_day_19_23,0) as ord_apl_sum_prc_amt_90_day_19_23
                ,coalesce(order_apply.ord_apl_sum_prc_amt_180_day_19_23,0) as ord_apl_sum_prc_amt_180_day_19_23
                ,coalesce(order_apply.ord_apl_sum_prc_amt_360_day_19_23,0) as ord_apl_sum_prc_amt_360_day_19_23
                --次数
                ,coalesce(order_apply.ord_apl_cnt_30_day_19_23,0) as ord_apl_cnt_30_day_19_23
                ,coalesce(order_apply.ord_apl_cnt_90_day_19_23,0) as ord_apl_cnt_90_day_19_23
                ,coalesce(order_apply.ord_apl_cnt_180_day_19_23,0) as ord_apl_cnt_180_day_19_23
                ,coalesce(order_apply.ord_apl_cnt_360_day_19_23,0) as ord_apl_cnt_360_day_19_23


                --/*----------所有订单中 bt / cash 类型比较 -------------*/
                ,coalesce(his_30_day_bt_apl_ord_cnt,0) as his_30_day_bt_apl_ord_cnt
                ,coalesce(his_90_day_bt_apl_ord_cnt,0) as his_90_day_bt_apl_ord_cnt
                ,coalesce(his_180_day_bt_apl_ord_cnt,0) as his_180_day_bt_apl_ord_cnt
                ,coalesce(his_360_day_bt_apl_ord_cnt,0) as his_360_day_bt_apl_ord_cnt

                ,coalesce(his_30_day_csh_apl_ord_cnt,0) as his_30_day_csh_apl_ord_cnt
                ,coalesce(his_90_day_csh_apl_ord_cnt,0) as his_90_day_csh_apl_ord_cnt
                ,coalesce(his_180_day_csh_apl_ord_cnt,0) as his_180_day_csh_apl_ord_cnt
                ,coalesce(his_360_day_csh_apl_ord_cnt,0) as his_360_day_csh_apl_ord_cnt

                ,coalesce(his_apl_ord_cnt,0) as his_apl_ord_cnt

                --/*----------所有订单中金额区间 -------------*/
                ,coalesce(his_30_day_prc_amt_1_000_flg_apl_ord_cnt,0) as his_30_day_prc_amt_1_000_flg_apl_ord_cnt
                ,coalesce(his_90_day_prc_amt_1_000_flg_apl_ord_cnt,0) as his_90_day_prc_amt_1_000_flg_apl_ord_cnt
                ,coalesce(his_180_day_prc_amt_1_000_flg_apl_ord_cnt,0) as his_180_day_prc_amt_1_000_flg_apl_ord_cnt
                ,coalesce(his_360_day_prc_amt_1_000_flg_apl_ord_cnt,0) as his_360_day_prc_amt_1_000_flg_apl_ord_cnt

                ,coalesce(his_30_day_prc_amt_3_000_flg_apl_ord_cnt,0) as his_30_day_prc_amt_3_000_flg_apl_ord_cnt
                ,coalesce(his_90_day_prc_amt_3_000_flg_apl_ord_cnt,0) as his_90_day_prc_amt_3_000_flg_apl_ord_cnt
                ,coalesce(his_180_day_prc_amt_3_000_flg_apl_ord_cnt,0) as his_180_day_prc_amt_3_000_flg_apl_ord_cnt
                ,coalesce(his_360_day_prc_amt_3_000_flg_apl_ord_cnt,0) as his_360_day_prc_amt_3_000_flg_apl_ord_cnt

                ,coalesce(his_30_day_prc_amt_5_000_flg_apl_ord_cnt,0) as his_30_day_prc_amt_5_000_flg_apl_ord_cnt
                ,coalesce(his_90_day_prc_amt_5_000_flg_apl_ord_cnt,0) as his_90_day_prc_amt_5_000_flg_apl_ord_cnt
                ,coalesce(his_180_day_prc_amt_5_000_flg_apl_ord_cnt,0) as his_180_day_prc_amt_5_000_flg_apl_ord_cnt
                ,coalesce(his_360_day_prc_amt_5_000_flg_apl_ord_cnt,0) as his_360_day_prc_amt_5_000_flg_apl_ord_cnt

                ,coalesce(his_30_day_prc_amt_10_000_flg_apl_ord_cnt,0) as his_30_day_prc_amt_10_000_flg_apl_ord_cnt
                ,coalesce(his_90_day_prc_amt_10_000_flg_apl_ord_cnt,0) as his_90_day_prc_amt_10_000_flg_apl_ord_cnt
                ,coalesce(his_180_day_prc_amt_10_000_flg_apl_ord_cnt,0) as his_180_day_prc_amt_10_000_flg_apl_ord_cnt
                ,coalesce(his_360_day_prc_amt_10_000_flg_apl_ord_cnt,0) as his_360_day_prc_amt_10_000_flg_apl_ord_cnt


                ----------------------------【part2 成功交易】----------------------------
                --/*7、首次动支信息*/
                --/*10、当前动支信息*/
                --/*11、最近动支信息*/
                -- ,order_succ.fst_ord_crt_dte
                --,order_succ.fst_ord_crt_tim
                ,order_succ1.fst_ord_stg_num
                ,order_succ1.fst_ord_prc_amt
                ,order_succ1.fst_ord_bsy_typ
                 --首次成功申请是否在周末
                ,case when pmod(datediff(order_succ1.fst_ord_crt_dte,date('2000-01-02')),7) in(0,6) then 1 else 0 end as if_fst_suc_ord_wkd
                --首次成功申请时点
                ,order_succ1.fst_suc_ord_crt_tim_hor

                -- ,order_succ1.cur_ord_crt_dte
                ,order_succ1.cur_ord_stg_num
                ,order_succ1.cur_ord_prc_amt
                ,order_succ1.cur_ord_bsy_typ
                ,coalesce(order_succ1.cur_ord_rn,0) as cur_ord_rn
                
                -- ,order_succ1.lst_ord_crt_dte
                ,order_succ1.lst_ord_stg_num
                ,order_succ1.lst_ord_prc_amt
                ,order_succ1.lst_ord_bsy_typ

                --/*9、交易信息*/

                --/*----------金额-------------*/
                --支用申请成功总金额
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_his,0) as ord_apl_suc_sum_prc_amt_his
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_30_day,0) as ord_apl_suc_sum_prc_amt_30_day
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_90_day,0) as ord_apl_suc_sum_prc_amt_90_day
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_180_day,0) as ord_apl_suc_sum_prc_amt_180_day
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_360_day,0) as ord_apl_suc_sum_prc_amt_360_day
                --单笔支用申请成功最大申请成功金额
                ,coalesce(order_succ1.ord_apl_suc_max_prc_amt_his,0) as ord_apl_suc_max_prc_amt_his
                ,coalesce(order_succ1.ord_apl_suc_max_prc_amt_30_day,0) as ord_apl_suc_max_prc_amt_30_day
                ,coalesce(order_succ1.ord_apl_suc_max_prc_amt_90_day,0) as ord_apl_suc_max_prc_amt_90_day
                ,coalesce(order_succ1.ord_apl_suc_max_prc_amt_180_day,0) as ord_apl_suc_max_prc_amt_180_day
                ,coalesce(order_succ1.ord_apl_suc_max_prc_amt_360_day,0) as ord_apl_suc_max_prc_amt_360_day
                --单笔支用申请成功最小申请成功金额
                ,coalesce(order_succ1.ord_apl_suc_min_prc_amt_his,0) as ord_apl_suc_min_prc_amt_his
                ,coalesce(order_succ1.ord_apl_suc_min_prc_amt_30_day,0) as ord_apl_suc_min_prc_amt_30_day
                ,coalesce(order_succ1.ord_apl_suc_min_prc_amt_90_day,0) as ord_apl_suc_min_prc_amt_90_day
                ,coalesce(order_succ1.ord_apl_suc_min_prc_amt_180_day,0) as ord_apl_suc_min_prc_amt_180_day
                ,coalesce(order_succ1.ord_apl_suc_min_prc_amt_360_day,0) as ord_apl_suc_min_prc_amt_360_day


                --/*----------金额-复借标识-------------*/
                --支用申请成功总金额-复借标识
                ,coalesce(order_succ1.pst_ord_apl_suc_sum_prc_amt_his,0) as pst_ord_apl_suc_sum_prc_amt_his
                ,coalesce(order_succ1.pst_ord_apl_suc_sum_prc_amt_30_day,0) as pst_ord_apl_suc_sum_prc_amt_30_day
                ,coalesce(order_succ1.pst_ord_apl_suc_sum_prc_amt_90_day,0) as pst_ord_apl_suc_sum_prc_amt_90_day
                ,coalesce(order_succ1.pst_ord_apl_suc_sum_prc_amt_180_day,0) as pst_ord_apl_suc_sum_prc_amt_180_day
                ,coalesce(order_succ1.pst_ord_apl_suc_sum_prc_amt_360_day,0) as pst_ord_apl_suc_sum_prc_amt_360_day
                --单笔支用申请成功最大申请成功金额-复借标识
                ,coalesce(order_succ1.pst_ord_apl_suc_max_prc_amt_his,0) as pst_ord_apl_suc_max_prc_amt_his
                ,coalesce(order_succ1.pst_ord_apl_suc_max_prc_amt_30_day,0) as pst_ord_apl_suc_max_prc_amt_30_day
                ,coalesce(order_succ1.pst_ord_apl_suc_max_prc_amt_90_day,0) as pst_ord_apl_suc_max_prc_amt_90_day
                ,coalesce(order_succ1.pst_ord_apl_suc_max_prc_amt_180_day,0) as pst_ord_apl_suc_max_prc_amt_180_day
                ,coalesce(order_succ1.pst_ord_apl_suc_max_prc_amt_360_day,0) as pst_ord_apl_suc_max_prc_amt_360_day
                --单笔支用申请成功最小申请成功金额-复借标识
                ,coalesce(order_succ1.pst_ord_apl_suc_min_prc_amt_his,0) as pst_ord_apl_suc_min_prc_amt_his
                ,coalesce(order_succ1.pst_ord_apl_suc_min_prc_amt_30_day,0) as pst_ord_apl_suc_min_prc_amt_30_day
                ,coalesce(order_succ1.pst_ord_apl_suc_min_prc_amt_90_day,0) as pst_ord_apl_suc_min_prc_amt_90_day
                ,coalesce(order_succ1.pst_ord_apl_suc_min_prc_amt_180_day,0) as pst_ord_apl_suc_min_prc_amt_180_day
                ,coalesce(order_succ1.pst_ord_apl_suc_min_prc_amt_360_day,0) as pst_ord_apl_suc_min_prc_amt_360_day


                --/*----------订单数-------------*/
                --,coalesce(order_succ1.ord_apl_suc_cnt_his_pay_off,0) as ord_apl_suc_cnt_his_pay_off
                --支用申请成功次数
                ,coalesce(order_succ1.ord_apl_suc_cnt_his,0) as ord_apl_suc_cnt_his
                ,coalesce(order_succ1.ord_apl_suc_cnt_30_day,0) as ord_apl_suc_cnt_30_day
                ,coalesce(order_succ1.ord_apl_suc_cnt_90_day,0) as ord_apl_suc_cnt_90_day
                ,coalesce(order_succ1.ord_apl_suc_cnt_180_day,0) as ord_apl_suc_cnt_180_day
                ,coalesce(order_succ1.ord_apl_suc_cnt_360_day,0) as ord_apl_suc_cnt_360_day
                --支用申请成功次数_6期订单
                ,coalesce(order_succ1.ord_apl_suc_6_cnt_his,0) as ord_apl_suc_6_cnt_his
                ,coalesce(order_succ1.ord_apl_suc_6_cnt_30_day,0) as ord_apl_suc_6_cnt_30_day
                ,coalesce(order_succ1.ord_apl_suc_6_cnt_90_day,0) as ord_apl_suc_6_cnt_90_day
                ,coalesce(order_succ1.ord_apl_suc_6_cnt_180_day,0) as ord_apl_suc_6_cnt_180_day
                ,coalesce(order_succ1.ord_apl_suc_6_cnt_360_day,0) as ord_apl_suc_6_cnt_360_day
                --支用申请成功次数_12期订单
                ,coalesce(order_succ1.ord_apl_suc_12_cnt_his,0) as ord_apl_suc_12_cnt_his
                ,coalesce(order_succ1.ord_apl_suc_12_cnt_30_day,0) as ord_apl_suc_12_cnt_30_day
                ,coalesce(order_succ1.ord_apl_suc_12_cnt_90_day,0) as ord_apl_suc_12_cnt_90_day
                ,coalesce(order_succ1.ord_apl_suc_12_cnt_180_day,0) as ord_apl_suc_12_cnt_180_day
                ,coalesce(order_succ1.ord_apl_suc_12_cnt_360_day,0) as ord_apl_suc_12_cnt_360_day
                ----支用申请成功次数_复借标识
                ,coalesce(order_succ1.pst_ord_apl_suc_cnt_his,0) as pst_ord_apl_suc_cnt_his
                ,coalesce(order_succ1.pst_ord_apl_suc_cnt_30_day,0) as pst_ord_apl_suc_cnt_30_day
                ,coalesce(order_succ1.pst_ord_apl_suc_cnt_90_day,0) as pst_ord_apl_suc_cnt_90_day
                ,coalesce(order_succ1.pst_ord_apl_suc_cnt_180_day,0) as pst_ord_apl_suc_cnt_180_day
                ,coalesce(order_succ1.pst_ord_apl_suc_cnt_360_day,0) as pst_ord_apl_suc_cnt_360_day

                --/*------------分借款时间（小时）-------------*/
                --小时数0到3点
                --金额
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_30_day_00_03,0) as ord_apl_suc_sum_prc_amt_30_day_00_03
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_90_day_00_03,0) as ord_apl_suc_sum_prc_amt_90_day_00_03
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_180_day_00_03,0) as ord_apl_suc_sum_prc_amt_180_day_00_03
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_360_day_00_03,0) as ord_apl_suc_sum_prc_amt_360_day_00_03
                --次数
                ,coalesce(order_succ1.ord_apl_suc_cnt_30_day_00_03,0) as ord_apl_suc_cnt_30_day_00_03
                ,coalesce(order_succ1.ord_apl_suc_cnt_90_day_00_03,0) as ord_apl_suc_cnt_90_day_00_03
                ,coalesce(order_succ1.ord_apl_suc_cnt_180_day_00_03,0) as ord_apl_suc_cnt_180_day_00_03
                ,coalesce(order_succ1.ord_apl_suc_cnt_360_day_00_03,0) as ord_apl_suc_cnt_360_day_00_03
                
                --小时数4到6点
                --金额
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_30_day_04_06,0) as ord_apl_suc_sum_prc_amt_30_day_04_06
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_90_day_04_06,0) as ord_apl_suc_sum_prc_amt_90_day_04_06
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_180_day_04_06,0) as ord_apl_suc_sum_prc_amt_180_day_04_06
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_360_day_04_06,0) as ord_apl_suc_sum_prc_amt_360_day_04_06
                --次数
                ,coalesce(order_succ1.ord_apl_suc_cnt_30_day_04_06,0) as ord_apl_suc_cnt_30_day_04_06
                ,coalesce(order_succ1.ord_apl_suc_cnt_90_day_04_06,0) as ord_apl_suc_cnt_90_day_04_06
                ,coalesce(order_succ1.ord_apl_suc_cnt_180_day_04_06,0) as ord_apl_suc_cnt_180_day_04_06
                ,coalesce(order_succ1.ord_apl_suc_cnt_360_day_04_06,0) as ord_apl_suc_cnt_360_day_04_06
                
                --小时数7到12点
                --金额
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_30_day_07_12,0) as ord_apl_suc_sum_prc_amt_30_day_07_12
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_90_day_07_12,0) as ord_apl_suc_sum_prc_amt_90_day_07_12
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_180_day_07_12,0) as ord_apl_suc_sum_prc_amt_180_day_07_12
                ,coalesce(order_succ1.ord_apl_suc_sum_prc_amt_360_day_07_12,0) as ord_apl_suc_sum_prc_amt_360_day_07_12
                --次数
                ,coalesce(order_succ1.ord_apl_suc_cnt_30_day_07_12,0) as ord_apl_suc_cnt_30_day_07_12
                ,coalesce(order_succ1.ord_apl_suc_cnt_90_day_07_12,0) as ord_apl_suc_cnt_90_day_07_12
                ,coalesce(order_succ1.ord_apl_suc_cnt_180_day_07_12,0) as ord_apl_suc_cnt_180_day_07_12
                ,coalesce(order_succ1.ord_apl_suc_cnt_360_day_07_12,0) as ord_apl_suc_cnt_360_day_07_12
                
                --小时数13到18点
                --金额
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_30_day_13_18,0) as ord_apl_suc_sum_prc_amt_30_day_13_18
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_90_day_13_18,0) as ord_apl_suc_sum_prc_amt_90_day_13_18
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_180_day_13_18,0) as ord_apl_suc_sum_prc_amt_180_day_13_18
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_360_day_13_18,0) as ord_apl_suc_sum_prc_amt_360_day_13_18
                --次数
                ,coalesce(order_succ2.ord_apl_suc_cnt_30_day_13_18,0) as ord_apl_suc_cnt_30_day_13_18
                ,coalesce(order_succ2.ord_apl_suc_cnt_90_day_13_18,0) as ord_apl_suc_cnt_90_day_13_18
                ,coalesce(order_succ2.ord_apl_suc_cnt_180_day_13_18,0) as ord_apl_suc_cnt_180_day_13_18
                ,coalesce(order_succ2.ord_apl_suc_cnt_360_day_13_18,0) as ord_apl_suc_cnt_360_day_13_18
                
                --小时数19到23点
                --金额
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_30_day_19_23,0) as ord_apl_suc_sum_prc_amt_30_day_19_23
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_90_day_19_23,0) as ord_apl_suc_sum_prc_amt_90_day_19_23
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_180_day_19_23,0) as ord_apl_suc_sum_prc_amt_180_day_19_23
                ,coalesce(order_succ2.ord_apl_suc_sum_prc_amt_360_day_19_23,0) as ord_apl_suc_sum_prc_amt_360_day_19_23
                --次数
                ,coalesce(order_succ2.ord_apl_suc_cnt_30_day_19_23,0) as ord_apl_suc_cnt_30_day_19_23
                ,coalesce(order_succ2.ord_apl_suc_cnt_90_day_19_23,0) as ord_apl_suc_cnt_90_day_19_23
                ,coalesce(order_succ2.ord_apl_suc_cnt_180_day_19_23,0) as ord_apl_suc_cnt_180_day_19_23
                ,coalesce(order_succ2.ord_apl_suc_cnt_360_day_19_23,0) as ord_apl_suc_cnt_360_day_19_23


                --/*----------分期数-------------*/
                --支用申请成功总分期数
                ,coalesce(order_succ2.ord_apl_suc_sum_stg_num_his,0) as ord_apl_suc_sum_stg_num_his
                ,coalesce(order_succ2.ord_apl_suc_sum_stg_num_30_day,0) as ord_apl_suc_sum_stg_num_30_day
                ,coalesce(order_succ2.ord_apl_suc_sum_stg_num_90_day,0) as ord_apl_suc_sum_stg_num_90_day
                ,coalesce(order_succ2.ord_apl_suc_sum_stg_num_180_day,0) as ord_apl_suc_sum_stg_num_180_day
                ,coalesce(order_succ2.ord_apl_suc_sum_stg_num_360_day,0) as ord_apl_suc_sum_stg_num_360_day
                --单笔支用申请成功最大申请成功分期数
                ,coalesce(order_succ2.ord_apl_suc_max_stg_num_his,0) as ord_apl_suc_max_stg_num_his
                ,coalesce(order_succ2.ord_apl_suc_max_stg_num_30_day,0) as ord_apl_suc_max_stg_num_30_day
                ,coalesce(order_succ2.ord_apl_suc_max_stg_num_90_day,0) as ord_apl_suc_max_stg_num_90_day
                ,coalesce(order_succ2.ord_apl_suc_max_stg_num_180_day,0) as ord_apl_suc_max_stg_num_180_day
                ,coalesce(order_succ2.ord_apl_suc_max_stg_num_360_day,0) as ord_apl_suc_max_stg_num_360_day
                --单笔支用申请成功最小申请成功分期数
                ,coalesce(order_succ2.ord_apl_suc_min_stg_num_his,0) as ord_apl_suc_min_stg_num_his
                ,coalesce(order_succ2.ord_apl_suc_min_stg_num_30_day,0) as ord_apl_suc_min_stg_num_30_day
                ,coalesce(order_succ2.ord_apl_suc_min_stg_num_90_day,0) as ord_apl_suc_min_stg_num_90_day
                ,coalesce(order_succ2.ord_apl_suc_min_stg_num_180_day,0) as ord_apl_suc_min_stg_num_180_day
                ,coalesce(order_succ2.ord_apl_suc_min_stg_num_360_day,0) as ord_apl_suc_min_stg_num_360_day
                --复借标识
                ,coalesce(order_succ2.pst_ord_apl_suc_sum_stg_num_his,0) as pst_ord_apl_suc_sum_stg_num_his
                ,coalesce(order_succ2.pst_ord_apl_suc_sum_stg_num_30_day,0) as pst_ord_apl_suc_sum_stg_num_30_day
                ,coalesce(order_succ2.pst_ord_apl_suc_sum_stg_num_90_day,0) as pst_ord_apl_suc_sum_stg_num_90_day
                ,coalesce(order_succ2.pst_ord_apl_suc_sum_stg_num_180_day,0) as pst_ord_apl_suc_sum_stg_num_180_day
                ,coalesce(order_succ2.pst_ord_apl_suc_sum_stg_num_360_day,0) as pst_ord_apl_suc_sum_stg_num_360_day
                 --加权分期数
                ,coalesce(weighted_stg_num.ord_apl_suc_weighted_stg_num_his,0) as ord_apl_suc_weighted_stg_num_his
                ,coalesce(weighted_stg_num.ord_apl_suc_weighted_stg_num_30_day,0) as ord_apl_suc_weighted_stg_num_30_day
                ,coalesce(weighted_stg_num.ord_apl_suc_weighted_stg_num_90_day,0) as ord_apl_suc_weighted_stg_num_90_day
                ,coalesce(weighted_stg_num.ord_apl_suc_weighted_stg_num_180_day,0) as ord_apl_suc_weighted_stg_num_180_day
                ,coalesce(weighted_stg_num.ord_apl_suc_weighted_stg_num_360_day,0) as ord_apl_suc_weighted_stg_num_360_day

                --/*----------产品类型数-------------*/
                ,coalesce(order_succ2.bsy_typ_suc_cnt_his,0) as bsy_typ_suc_cnt_his
                ,coalesce(order_succ2.bsy_typ_suc_cnt_30_day,0) as bsy_typ_suc_cnt_30_day
                ,coalesce(order_succ2.bsy_typ_suc_cnt_90_day,0) as bsy_typ_suc_cnt_90_day
                ,coalesce(order_succ2.bsy_typ_suc_cnt_180_day,0) as bsy_typ_suc_cnt_180_day
                ,coalesce(order_succ2.bsy_typ_suc_cnt_360_day,0) as bsy_typ_suc_cnt_360_day

                --/*----------近期是否借过not_bt_cash-------------*/
                ,coalesce(order_succ2.if_not_bt_csh_suc_his,0) as if_not_bt_csh_suc_his
                ,coalesce(order_succ2.if_not_bt_csh_suc_30_day,0) as if_not_bt_csh_suc_30_day
                ,coalesce(order_succ2.if_not_bt_csh_suc_90_day,0) as if_not_bt_csh_suc_90_day
                ,coalesce(order_succ2.if_not_bt_csh_suc_180_day,0) as if_not_bt_csh_suc_180_day
                ,coalesce(order_succ2.if_not_bt_csh_suc_360_day,0) as if_not_bt_csh_suc_360_day

                --/*----------成功订单中 bt / cash 类型比较 -------------*/
                ,coalesce(his_30_day_bt_suc_ord_cnt,0) as his_30_day_bt_suc_ord_cnt
                ,coalesce(his_90_day_bt_suc_ord_cnt,0) as his_90_day_bt_suc_ord_cnt
                ,coalesce(his_180_day_bt_suc_ord_cnt,0) as his_180_day_bt_suc_ord_cnt
                ,coalesce(his_360_day_bt_suc_ord_cnt,0) as his_360_day_bt_suc_ord_cnt

                ,coalesce(his_30_day_csh_suc_ord_cnt,0) as his_30_day_csh_suc_ord_cnt
                ,coalesce(his_90_day_csh_suc_ord_cnt,0) as his_90_day_csh_suc_ord_cnt
                ,coalesce(his_180_day_csh_suc_ord_cnt,0) as his_180_day_csh_suc_ord_cnt
                ,coalesce(his_360_day_csh_suc_ord_cnt,0) as his_360_day_csh_suc_ord_cnt

                ,coalesce(his_suc_ord_cnt,0) as his_suc_ord_cnt

                --/*----------成功订单中金额区间 -------------*/
                ,coalesce(his_30_day_prc_amt_1_000_flg_suc_ord_cnt,0) as his_30_day_prc_amt_1_000_flg_suc_ord_cnt
                ,coalesce(his_90_day_prc_amt_1_000_flg_suc_ord_cnt,0) as his_90_day_prc_amt_1_000_flg_suc_ord_cnt
                ,coalesce(his_180_day_prc_amt_1_000_flg_suc_ord_cnt,0) as his_180_day_prc_amt_1_000_flg_suc_ord_cnt
                ,coalesce(his_360_day_prc_amt_1_000_flg_suc_ord_cnt,0) as his_360_day_prc_amt_1_000_flg_suc_ord_cnt

                ,coalesce(his_30_day_prc_amt_3_000_flg_suc_ord_cnt,0) as his_30_day_prc_amt_3_000_flg_suc_ord_cnt
                ,coalesce(his_90_day_prc_amt_3_000_flg_suc_ord_cnt,0) as his_90_day_prc_amt_3_000_flg_suc_ord_cnt
                ,coalesce(his_180_day_prc_amt_3_000_flg_suc_ord_cnt,0) as his_180_day_prc_amt_3_000_flg_suc_ord_cnt
                ,coalesce(his_360_day_prc_amt_3_000_flg_suc_ord_cnt,0) as his_360_day_prc_amt_3_000_flg_suc_ord_cnt

                ,coalesce(his_30_day_prc_amt_5_000_flg_suc_ord_cnt,0) as his_30_day_prc_amt_5_000_flg_suc_ord_cnt
                ,coalesce(his_90_day_prc_amt_5_000_flg_suc_ord_cnt,0) as his_90_day_prc_amt_5_000_flg_suc_ord_cnt
                ,coalesce(his_180_day_prc_amt_5_000_flg_suc_ord_cnt,0) as his_180_day_prc_amt_5_000_flg_suc_ord_cnt
                ,coalesce(his_360_day_prc_amt_5_000_flg_suc_ord_cnt,0) as his_360_day_prc_amt_5_000_flg_suc_ord_cnt

                ,coalesce(his_30_day_prc_amt_10_000_flg_suc_ord_cnt,0) as his_30_day_prc_amt_10_000_flg_suc_ord_cnt
                ,coalesce(his_90_day_prc_amt_10_000_flg_suc_ord_cnt,0) as his_90_day_prc_amt_10_000_flg_suc_ord_cnt
                ,coalesce(his_180_day_prc_amt_10_000_flg_suc_ord_cnt,0) as his_180_day_prc_amt_10_000_flg_suc_ord_cnt
                ,coalesce(his_360_day_prc_amt_10_000_flg_suc_ord_cnt,0) as his_360_day_prc_amt_10_000_flg_suc_ord_cnt


                -- --/*----------最大最小间隔-------------*/
                --交易成功发起时间前后间隔(最大、最小（天）)
                ,order_succ1.max_ddf_suc_lag_crt_dte
                ,order_succ1.min_ddf_suc_lag_crt_dte
                --交易成功发起时间前后间隔(最小（分钟）)
                ,order_succ1.min_ddf_suc_lag_crt_tim_mnt

                --最大借款金额订单产生时间距评分日间隔(若有相等取最近一笔)
                ,order_succ1.ddf_mdl_max_suc_prc_amt_ord_crt_dte

                --最大借款分期数订单产生时间距评分日间隔(若有相等取最近一笔)
                ,order_succ1.ddf_mdl_max_suc_stg_num_ord_crt_dte

                    --/*7、首次成功动支信息*/
                 --申完时间与首次动支日间隔（天）
                ,fst_order.ddf_ato_fst_ord_crt_dte
                --首次授信时间与首次动支日间隔（天）
                ,fst_order.ddf_fst_adt_fst_ord_crt_dte
                 --首次授信时间与首次动支日间隔（分钟）
                ,fst_order.ddf_fst_adt_fst_ord_crt_dte_mnt
                --首次动支时间和评分日间隔（天）
                ,fst_order.ddf_mdl_fst_ord_crt_dte
                 --首次动支时间和当前订单间隔（天）
                ,fst_order.ddf_fst_cur_ord_crt_dte
                 --首次动支时间和最近订单间隔（天）
                ,fst_order.ddf_fst_lst_ord_crt_dte
                 --首次动支额度使用率
                ,fst_order.fst_ord_prc_fst_adt_lmt_rto
                --/*10、当前成功动支信息*/
                 --当前订单动支时间和评分日间隔（天）
                ,fst_order.ddf_mdl_cur_ord_crt_dte
                --/*11、最近成功动支信息*/
                --最近订单动支时间和评分日间隔（天）
                ,fst_order.ddf_mdl_lst_ord_crt_dte

-- features range end --

        from (select uid
                  ,mdl_dte
            from ${dwa_risk}.dwa_risk_f_dz_model_data_base
            )model_data  --建模样本
        left join ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_apply_tmp1 order_apply on model_data.uid=order_apply.uid
        left join ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp2 order_succ1 on model_data.uid=order_succ1.uid
        left join ${dwa_risk}.dwa_risk_dz_model_final_7fst_9all_10cur_11lst_orders_info_succ_tmp3 order_succ2 on model_data.uid=order_succ2.uid
        left join ${dwa_risk}.dwa_risk_7fst_orders_info_tmp fst_order on model_data.uid=fst_order.uid
        left join ${dwa_risk}.dwa_risk_7suc_weighted_stg_num_tmp weighted_stg_num on model_data.uid=weighted_stg_num.uid
        )main;
-- feature-copilot:node-end ordinal=0
