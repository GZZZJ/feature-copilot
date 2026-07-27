-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_account_lmt_feature_sample_all_final_jqh_df
-- node_id: n_6398919835569094656
-- task_name: dwa_risk_dz_model_account_lmt_feature_sample_all_final_jqh_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_account_lmt_feature_sample_all_final_jqh_df.json
-- source_json_sha256: be008ecf8a80dd9e5044ec137b8b38df0b8a73812cacd92d554be25bd07b35fb
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base_jqh_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2024-11-25 11:21:26
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
create table if not exists ${dwa_risk}.dwa_risk_dz_model_account_lmt_feature_sample_all_final_jqh_df
(
uid string comment 'uid',
mdl_dte string comment '模型日期',
max_rsk_lmt_rate_bjq_12m_bt_ch decimal(38,16) comment '所有订单结清前12个月现金贷最大额度使用率',
max_rsk_lmt_rate_bjq_12m_dcp decimal(38,16) comment '所有订单结清前12个月DCP最大额度使用率',
max_rsk_lmt_rate_bjq_12m_hug decimal(38,16) comment '所有订单结清前12个月大额贷最大额度使用率',
max_rsk_lmt_rate_bjq_12m_all decimal(38,16) comment '所有订单结清前12个月最大额度使用率',
min_rsk_lmt_rate_bjq_12m_bt_ch decimal(38,16) comment '所有订单结清前12个月现金贷最小额度使用率',
min_rsk_lmt_rate_bjq_12m_dcp decimal(38,16) comment '所有订单结清前12个月DCP最小额度使用率',
min_rsk_lmt_rate_bjq_12m_hug decimal(38,16) comment '所有订单结清前12个月大额贷最小额度使用率',
min_rsk_lmt_rate_bjq_12m_all decimal(38,16) comment '所有订单结清前12个月最小额度使用率',
avg_rsk_lmt_rate_bjq_12m_bt_ch decimal(38,16) comment '所有订单结清前12个月现金贷平均额度使用率',
avg_rsk_lmt_rate_bjq_12m_dcp decimal(38,16) comment '所有订单结清前12个月DCP平均额度使用率',
avg_rsk_lmt_rate_bjq_12m_hug decimal(38,16) comment '所有订单结清前12个月大额贷平均额度使用率',
avg_rsk_lmt_rate_bjq_12m_all decimal(38,16) comment '所有订单结清前12个月平均额度使用率',
max_rsk_avl_lmt_bjq_12m_bt_ch decimal(38,16) comment '所有订单结清前12个月现金贷最大可用额度',
max_rsk_avl_lmt_bjq_12m_dcp decimal(38,16) comment '所有订单结清前12个月DCP最大可用额度',
max_rsk_avl_lmt_bjq_12m_hug decimal(38,16) comment '所有订单结清前12个月大额贷最大可用额度',
max_rsk_avl_lmt_bjq_12m_all decimal(38,16) comment '所有订单结清前12个月最大可用额度',
min_rsk_avl_lmt_bjq_12m_bt_ch decimal(38,16) comment '所有订单结清前12个月现金贷最小可用额度',
min_rsk_avl_lmt_bjq_12m_dcp decimal(38,16) comment '所有订单结清前12个月DCP最小可用额度',
min_rsk_avl_lmt_bjq_12m_hug decimal(38,16) comment '所有订单结清前12个月大额贷最小可用额度',
min_rsk_avl_lmt_bjq_12m_all decimal(38,16) comment '所有订单结清前12个月最小可用额度',
avg_rsk_avl_lmt_bjq_12m_bt_ch decimal(38,16) comment '所有订单结清前12个月现金贷平均可用额度',
avg_rsk_avl_lmt_bjq_12m_dcp decimal(38,16) comment '所有订单结清前12个月DCP平均可用额度',
avg_rsk_avl_lmt_bjq_12m_hug decimal(38,16) comment '所有订单结清前12个月大额贷平均可用额度',
avg_rsk_avl_lmt_bjq_12m_all decimal(38,16) comment '所有订单结清前12个月平均可用额度',
avg_avl_lmt_lft_rep_prc_1m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_1m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_1m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最大指标值(可用额度/未来1个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最大指标值(可用额度/未来1个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_1m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最大指标值(可用额度/未来1个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_1m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最小指标值(可用额度/未来1个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最小指标值(可用额度/未来1个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_1m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最小指标值(可用额度/未来1个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_2m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_2m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_2m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最大指标值(可用额度/未来2个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最大指标值(可用额度/未来2个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_2m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最大指标值(可用额度/未来2个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_2m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最小指标值(可用额度/未来2个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最小指标值(可用额度/未来2个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_2m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最小指标值(可用额度/未来2个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_3m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_3m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_3m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最大指标值(可用额度/未来3个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最大指标值(可用额度/未来3个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_3m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最大指标值(可用额度/未来3个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_3m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最小指标值(可用额度/未来3个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最小指标值(可用额度/未来3个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_3m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最小指标值(可用额度/未来3个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_6m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_6m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_6m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最大指标值(可用额度/未来6个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最大指标值(可用额度/未来6个月剩余应还金额)',
max_avl_lmt_lft_rep_prc_6m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最大指标值(可用额度/未来6个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_6m_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最小指标值(可用额度/未来6个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最小指标值(可用额度/未来6个月剩余应还金额)',
min_avl_lmt_lft_rep_prc_6m_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最小指标值(可用额度/未来6个月剩余应还金额)',
avg_avl_lmt_lft_rep_prc_all_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷平均指标值(可用额度/未来剩余应还金额)',
avg_avl_lmt_lft_rep_prc_all_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP平均指标值(可用额度/未来剩余应还金额)',
avg_avl_lmt_lft_rep_prc_all_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷平均指标值(可用额度/未来剩余应还金额)',
max_avl_lmt_lft_rep_prc_all_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最大指标值(可用额度/未来剩余应还金额)',
max_avl_lmt_lft_rep_prc_all_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最大指标值(可用额度/未来剩余应还金额)',
max_avl_lmt_lft_rep_prc_all_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最大指标值(可用额度/未来剩余应还金额)',
min_avl_lmt_lft_rep_prc_all_cash_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷最小指标值(可用额度/未来剩余应还金额)',
min_avl_lmt_lft_rep_prc_all_dcp_bjq_12m decimal(38,16) comment '所有订单结清前12个月DCP最小指标值(可用额度/未来剩余应还金额)',
min_avl_lmt_lft_rep_prc_all_hug_bjq_12m decimal(38,16) comment '所有订单结清前12个月大额贷最小指标值(可用额度/未来剩余应还金额)',
rsk_lmt_rate_ch_1m_grt_0p95_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.95的次数',
rsk_lmt_rate_ch_1m_grt_0p95_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.95的占比',
rsk_lmt_rate_ch_1m_grt_0p9_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.9的次数',
rsk_lmt_rate_ch_1m_grt_0p9_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.9的占比',
rsk_lmt_rate_ch_1m_grt_0p8_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.8的次数',
rsk_lmt_rate_ch_1m_grt_0p8_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.8的占比',
rsk_lmt_rate_ch_1m_grt_0p5_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.5的次数',
rsk_lmt_rate_ch_1m_grt_0p5_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.5的占比',
rsk_lmt_rate_ch_1m_grt_0p2_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.2的次数',
rsk_lmt_rate_ch_1m_grt_0p2_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷额度使用率超过0.2的占比',
rsk_avl_lmt_ch_1m_les_500_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于500的次数',
rsk_avl_lmt_ch_1m_les_500_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于500的占比',
rsk_avl_lmt_ch_1m_les_1000_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于1000的次数',
rsk_avl_lmt_ch_1m_les_1000_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于1000的占比',
rsk_avl_lmt_ch_1m_les_5000_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于5000的次数',
rsk_avl_lmt_ch_1m_les_5000_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于5000的占比',
rsk_avl_lmt_ch_1m_les_10000_cnt_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于10000的次数',
rsk_avl_lmt_ch_1m_les_10000_rate_bjq_12m decimal(38,16) comment '所有订单结清前12个月现金贷可用额度小于10000的占比'
) comment "结清前12个月额度使用率宽表" 
partitioned by (ds string comment '分区字段,格式yyyymmdd')
;



drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2_jqh_${bizdate};
create table if not exists ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2_jqh_${bizdate} as
select a.uid,
       a.biz_no,
       a.biz_typ,
       a.bsy_typ,
       a.time,
       a.ds,
       a.rsk_adt_lmt,
       a.rsk_avl_lmt,
      lft_rep_prc_1m_cash,
      lft_rep_prc_1m_dcp,
      lft_rep_prc_1m_hug,
      lft_rep_prc_2m_cash,
      lft_rep_prc_2m_dcp,
      lft_rep_prc_2m_hug,
      lft_rep_prc_3m_cash,
      lft_rep_prc_3m_dcp,
      lft_rep_prc_3m_hug,
      lft_rep_prc_6m_cash,
      lft_rep_prc_6m_dcp,
      lft_rep_prc_6m_hug,
      lft_rep_prc_all_cash,
      lft_rep_prc_all_dcp,
      lft_rep_prc_all_hug
from  
(select * from ${dwa_risk}.dwa_risk_tmp_order_stage_account_union_ins_3y where ds <= '${bizdate}'  ) as a
left join (select * from ${dwa_risk}.dwa_risk_dz_model_lmt_list_lft_rep_tmp_new_di where ds <= '${bizdate}' )  as b
on a.biz_no=b.biz_no;





drop table if exists  ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_jqh_12m_${bizdate};
create table if not exists  ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_jqh_12m_${bizdate} as 
select uid,
      max(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_bjq_12m_bt_ch,
      max(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_bjq_12m_dcp,
      max(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_bjq_12m_hug,
      max(rsk_lmt_rate) as max_rsk_lmt_rate_bjq_12m_all,
      min(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_bjq_12m_bt_ch,
      min(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_bjq_12m_dcp,
      min(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_bjq_12m_hug,
      min(rsk_lmt_rate) as min_rsk_lmt_rate_bjq_12m_all,
      avg(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_bjq_12m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_bjq_12m_dcp,
      avg(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_bjq_12m_hug,
      avg(rsk_lmt_rate) as avg_rsk_lmt_rate_bjq_12m_all,
      max(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_bjq_12m_bt_ch,
      max(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_bjq_12m_dcp,
      max(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_bjq_12m_hug,
      max(rsk_avl_lmt) as max_rsk_avl_lmt_bjq_12m_all,
      min(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_bjq_12m_bt_ch,
      min(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_bjq_12m_dcp,
      min(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_bjq_12m_hug,
      min(rsk_avl_lmt) as min_rsk_avl_lmt_bjq_12m_all,
      avg(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_bjq_12m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_bjq_12m_dcp,
      avg(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_bjq_12m_hug,
      avg(rsk_avl_lmt) as avg_rsk_avl_lmt_bjq_12m_all,
      avg(avl_lmt_lft_rep_prc_1m_cash) as avg_avl_lmt_lft_rep_prc_1m_cash_bjq_12m,
      avg(avl_lmt_lft_rep_prc_1m_dcp) as avg_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m,
      avg(avl_lmt_lft_rep_prc_1m_hug) as avg_avl_lmt_lft_rep_prc_1m_hug_bjq_12m,
      max(avl_lmt_lft_rep_prc_1m_cash) as max_avl_lmt_lft_rep_prc_1m_cash_bjq_12m,
      max(avl_lmt_lft_rep_prc_1m_dcp) as max_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m,
      max(avl_lmt_lft_rep_prc_1m_hug) as max_avl_lmt_lft_rep_prc_1m_hug_bjq_12m,
      min(avl_lmt_lft_rep_prc_1m_cash) as min_avl_lmt_lft_rep_prc_1m_cash_bjq_12m,
      min(avl_lmt_lft_rep_prc_1m_dcp) as min_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m,
      min(avl_lmt_lft_rep_prc_1m_hug) as min_avl_lmt_lft_rep_prc_1m_hug_bjq_12m,
      avg(avl_lmt_lft_rep_prc_2m_cash) as avg_avl_lmt_lft_rep_prc_2m_cash_bjq_12m,
      avg(avl_lmt_lft_rep_prc_2m_dcp) as avg_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m,
      avg(avl_lmt_lft_rep_prc_2m_hug) as avg_avl_lmt_lft_rep_prc_2m_hug_bjq_12m,
      max(avl_lmt_lft_rep_prc_2m_cash) as max_avl_lmt_lft_rep_prc_2m_cash_bjq_12m,
      max(avl_lmt_lft_rep_prc_2m_dcp) as max_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m,
      max(avl_lmt_lft_rep_prc_2m_hug) as max_avl_lmt_lft_rep_prc_2m_hug_bjq_12m,
      min(avl_lmt_lft_rep_prc_2m_cash) as min_avl_lmt_lft_rep_prc_2m_cash_bjq_12m,
      min(avl_lmt_lft_rep_prc_2m_dcp) as min_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m,
      min(avl_lmt_lft_rep_prc_2m_hug) as min_avl_lmt_lft_rep_prc_2m_hug_bjq_12m,
      avg(avl_lmt_lft_rep_prc_3m_cash) as avg_avl_lmt_lft_rep_prc_3m_cash_bjq_12m,
      avg(avl_lmt_lft_rep_prc_3m_dcp) as avg_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m,
      avg(avl_lmt_lft_rep_prc_3m_hug) as avg_avl_lmt_lft_rep_prc_3m_hug_bjq_12m,
      max(avl_lmt_lft_rep_prc_3m_cash) as max_avl_lmt_lft_rep_prc_3m_cash_bjq_12m,
      max(avl_lmt_lft_rep_prc_3m_dcp) as max_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m,
      max(avl_lmt_lft_rep_prc_3m_hug) as max_avl_lmt_lft_rep_prc_3m_hug_bjq_12m,
      min(avl_lmt_lft_rep_prc_3m_cash) as min_avl_lmt_lft_rep_prc_3m_cash_bjq_12m,
      min(avl_lmt_lft_rep_prc_3m_dcp) as min_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m,
      min(avl_lmt_lft_rep_prc_3m_hug) as min_avl_lmt_lft_rep_prc_3m_hug_bjq_12m,
      avg(avl_lmt_lft_rep_prc_6m_cash) as avg_avl_lmt_lft_rep_prc_6m_cash_bjq_12m,
      avg(avl_lmt_lft_rep_prc_6m_dcp) as avg_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m,
      avg(avl_lmt_lft_rep_prc_6m_hug) as avg_avl_lmt_lft_rep_prc_6m_hug_bjq_12m,
      max(avl_lmt_lft_rep_prc_6m_cash) as max_avl_lmt_lft_rep_prc_6m_cash_bjq_12m,
      max(avl_lmt_lft_rep_prc_6m_dcp) as max_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m,
      max(avl_lmt_lft_rep_prc_6m_hug) as max_avl_lmt_lft_rep_prc_6m_hug_bjq_12m,
      min(avl_lmt_lft_rep_prc_6m_cash) as min_avl_lmt_lft_rep_prc_6m_cash_bjq_12m,
      min(avl_lmt_lft_rep_prc_6m_dcp) as min_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m,
      min(avl_lmt_lft_rep_prc_6m_hug) as min_avl_lmt_lft_rep_prc_6m_hug_bjq_12m,
      avg(avl_lmt_lft_rep_prc_all_cash) as avg_avl_lmt_lft_rep_prc_all_cash_bjq_12m,
      avg(avl_lmt_lft_rep_prc_all_dcp) as avg_avl_lmt_lft_rep_prc_all_dcp_bjq_12m,
      avg(avl_lmt_lft_rep_prc_all_hug) as avg_avl_lmt_lft_rep_prc_all_hug_bjq_12m,
      max(avl_lmt_lft_rep_prc_all_cash) as max_avl_lmt_lft_rep_prc_all_cash_bjq_12m,
      max(avl_lmt_lft_rep_prc_all_dcp) as max_avl_lmt_lft_rep_prc_all_dcp_bjq_12m,
      max(avl_lmt_lft_rep_prc_all_hug) as max_avl_lmt_lft_rep_prc_all_hug_bjq_12m,
      min(avl_lmt_lft_rep_prc_all_cash) as min_avl_lmt_lft_rep_prc_all_cash_bjq_12m,
      min(avl_lmt_lft_rep_prc_all_dcp) as min_avl_lmt_lft_rep_prc_all_dcp_bjq_12m,
      min(avl_lmt_lft_rep_prc_all_hug) as min_avl_lmt_lft_rep_prc_all_hug_bjq_12m,
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_rate_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_rate_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_rate_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_rate_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_rate_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_rate_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_rate_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_rate_bjq_12m,
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_cnt_bjq_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_rate_bjq_12m
from
    (
select model_data.uid,
      biz_typ,
      bsy_typ,
      model_data.lst_settle_up_date,
      b.time,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then 1 else 0 end as bsy_ch_bt,
      case when bsy_typ in ('ENJOY_PAY') then 1 else 0 end as bsy_dcp,
      case when bsy_typ in ('HUGE_LOAN') then 1 else 0 end as bsy_hug,
      rsk_avl_lmt,
      rsk_adt_lmt,
      round(1-rsk_avl_lmt/rsk_adt_lmt,6) as rsk_lmt_rate,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then rsk_avl_lmt/lft_rep_prc_1m_cash else NULL end as avl_lmt_lft_rep_prc_1m_cash,
      case when bsy_typ in ('ENJOY_PAY') then rsk_avl_lmt/lft_rep_prc_1m_dcp else NULL end as avl_lmt_lft_rep_prc_1m_dcp,
      case when bsy_typ in ('HUGE_LOAN') then rsk_avl_lmt/lft_rep_prc_1m_hug else NULL end as avl_lmt_lft_rep_prc_1m_hug,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then rsk_avl_lmt/lft_rep_prc_2m_cash else NULL end as avl_lmt_lft_rep_prc_2m_cash,
      case when bsy_typ in ('ENJOY_PAY') then rsk_avl_lmt/lft_rep_prc_2m_dcp else NULL end as avl_lmt_lft_rep_prc_2m_dcp,
      case when bsy_typ in ('HUGE_LOAN') then rsk_avl_lmt/lft_rep_prc_2m_hug else NULL end as avl_lmt_lft_rep_prc_2m_hug,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then rsk_avl_lmt/lft_rep_prc_3m_cash else NULL end as avl_lmt_lft_rep_prc_3m_cash,
      case when bsy_typ in ('ENJOY_PAY') then rsk_avl_lmt/lft_rep_prc_3m_dcp else NULL end as avl_lmt_lft_rep_prc_3m_dcp,
      case when bsy_typ in ('HUGE_LOAN') then rsk_avl_lmt/lft_rep_prc_3m_hug else NULL end as avl_lmt_lft_rep_prc_3m_hug,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then rsk_avl_lmt/lft_rep_prc_6m_cash else NULL end as avl_lmt_lft_rep_prc_6m_cash,
      case when bsy_typ in ('ENJOY_PAY') then rsk_avl_lmt/lft_rep_prc_6m_dcp else NULL end as avl_lmt_lft_rep_prc_6m_dcp,
      case when bsy_typ in ('HUGE_LOAN') then rsk_avl_lmt/lft_rep_prc_6m_hug else NULL end as avl_lmt_lft_rep_prc_6m_hug,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then rsk_avl_lmt/lft_rep_prc_all_cash else NULL end as avl_lmt_lft_rep_prc_all_cash,
      case when bsy_typ in ('ENJOY_PAY') then rsk_avl_lmt/lft_rep_prc_all_dcp else NULL end as avl_lmt_lft_rep_prc_all_dcp,
      case when bsy_typ in ('HUGE_LOAN') then rsk_avl_lmt/lft_rep_prc_all_hug else NULL end as avl_lmt_lft_rep_prc_all_hug
from (select * from ${dwa_risk}.dwa_risk_f_dz_model_data_base_jqh_df where ds='${bizdate}')  model_data 
left join ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2_jqh_${bizdate} as b
on model_data.uid=b.uid
where to_date(b.time) >= add_months(model_data.lst_settle_up_date,-12)
and to_date(b.time) <= model_data.lst_settle_up_date
    ) as a
group by uid;










insert overwrite table ${dwa_risk}.dwa_risk_dz_model_account_lmt_feature_sample_all_final_jqh_df partition(ds='${bizdate}')
select 
      a.uid
      ,a.mdl_dte
      ,max_rsk_lmt_rate_bjq_12m_bt_ch
      ,max_rsk_lmt_rate_bjq_12m_dcp
      ,max_rsk_lmt_rate_bjq_12m_hug
      ,max_rsk_lmt_rate_bjq_12m_all
      ,min_rsk_lmt_rate_bjq_12m_bt_ch
      ,min_rsk_lmt_rate_bjq_12m_dcp
      ,min_rsk_lmt_rate_bjq_12m_hug
      ,min_rsk_lmt_rate_bjq_12m_all
      ,avg_rsk_lmt_rate_bjq_12m_bt_ch
      ,avg_rsk_lmt_rate_bjq_12m_dcp
      ,avg_rsk_lmt_rate_bjq_12m_hug
      ,avg_rsk_lmt_rate_bjq_12m_all
      ,max_rsk_avl_lmt_bjq_12m_bt_ch
      ,max_rsk_avl_lmt_bjq_12m_dcp
      ,max_rsk_avl_lmt_bjq_12m_hug
      ,max_rsk_avl_lmt_bjq_12m_all
      ,min_rsk_avl_lmt_bjq_12m_bt_ch
      ,min_rsk_avl_lmt_bjq_12m_dcp
      ,min_rsk_avl_lmt_bjq_12m_hug
      ,min_rsk_avl_lmt_bjq_12m_all
      ,avg_rsk_avl_lmt_bjq_12m_bt_ch
      ,avg_rsk_avl_lmt_bjq_12m_dcp
      ,avg_rsk_avl_lmt_bjq_12m_hug
      ,avg_rsk_avl_lmt_bjq_12m_all
      ,avg_avl_lmt_lft_rep_prc_1m_cash_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_1m_hug_bjq_12m
      ,max_avl_lmt_lft_rep_prc_1m_cash_bjq_12m
      ,max_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m
      ,max_avl_lmt_lft_rep_prc_1m_hug_bjq_12m
      ,min_avl_lmt_lft_rep_prc_1m_cash_bjq_12m
      ,min_avl_lmt_lft_rep_prc_1m_dcp_bjq_12m
      ,min_avl_lmt_lft_rep_prc_1m_hug_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_2m_cash_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_2m_hug_bjq_12m
      ,max_avl_lmt_lft_rep_prc_2m_cash_bjq_12m
      ,max_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m
      ,max_avl_lmt_lft_rep_prc_2m_hug_bjq_12m
      ,min_avl_lmt_lft_rep_prc_2m_cash_bjq_12m
      ,min_avl_lmt_lft_rep_prc_2m_dcp_bjq_12m
      ,min_avl_lmt_lft_rep_prc_2m_hug_bjq_12m 
      ,avg_avl_lmt_lft_rep_prc_3m_cash_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_3m_hug_bjq_12m
      ,max_avl_lmt_lft_rep_prc_3m_cash_bjq_12m
      ,max_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m
      ,max_avl_lmt_lft_rep_prc_3m_hug_bjq_12m
      ,min_avl_lmt_lft_rep_prc_3m_cash_bjq_12m
      ,min_avl_lmt_lft_rep_prc_3m_dcp_bjq_12m
      ,min_avl_lmt_lft_rep_prc_3m_hug_bjq_12m              
      ,avg_avl_lmt_lft_rep_prc_6m_cash_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_6m_hug_bjq_12m
      ,max_avl_lmt_lft_rep_prc_6m_cash_bjq_12m
      ,max_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m
      ,max_avl_lmt_lft_rep_prc_6m_hug_bjq_12m
      ,min_avl_lmt_lft_rep_prc_6m_cash_bjq_12m
      ,min_avl_lmt_lft_rep_prc_6m_dcp_bjq_12m
      ,min_avl_lmt_lft_rep_prc_6m_hug_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_all_cash_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_all_dcp_bjq_12m
      ,avg_avl_lmt_lft_rep_prc_all_hug_bjq_12m
      ,max_avl_lmt_lft_rep_prc_all_cash_bjq_12m
      ,max_avl_lmt_lft_rep_prc_all_dcp_bjq_12m
      ,max_avl_lmt_lft_rep_prc_all_hug_bjq_12m
      ,min_avl_lmt_lft_rep_prc_all_cash_bjq_12m
      ,min_avl_lmt_lft_rep_prc_all_dcp_bjq_12m
      ,min_avl_lmt_lft_rep_prc_all_hug_bjq_12m
      ,rsk_lmt_rate_ch_1m_grt_0p95_cnt_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p95_rate_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_cnt_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_rate_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_cnt_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_rate_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_cnt_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_rate_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_cnt_bjq_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_rate_bjq_12m 
      ,rsk_avl_lmt_ch_1m_les_500_cnt_bjq_12m 
      ,rsk_avl_lmt_ch_1m_les_500_rate_bjq_12m 
      ,rsk_avl_lmt_ch_1m_les_1000_cnt_bjq_12m 
      ,rsk_avl_lmt_ch_1m_les_1000_rate_bjq_12m 
      ,rsk_avl_lmt_ch_1m_les_5000_cnt_bjq_12m 
      ,rsk_avl_lmt_ch_1m_les_5000_rate_bjq_12m
      ,rsk_avl_lmt_ch_1m_les_10000_cnt_bjq_12m 
      ,rsk_avl_lmt_ch_1m_les_10000_rate_bjq_12m
from (select * from ${dwa_risk}.dwa_risk_f_dz_model_data_base_jqh_df where ds='${bizdate}') as a
left join  ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_jqh_12m_${bizdate} as b
on a.uid=b.uid




drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2_jqh_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_jqh_12m_${bizdate};
-- feature-copilot:node-end ordinal=0
