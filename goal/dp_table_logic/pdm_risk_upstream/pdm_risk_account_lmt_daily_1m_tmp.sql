-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_account_lmt_daily_1m_tmp
-- node_id: n_4333429380988665856
-- task_name: pdm_risk_dz_model_account_lmt_feature_sample_final_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_account_lmt_daily_1m_tmp.json
-- source_json_sha256: 03eaacdeb16306dca4cd255841d7f463eb37aaa0f39eed77f2cabe7b565b53c3
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_tmp_order_stage_account_union_all
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: pdm_risk.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp
-- upstream_table: pdm_risk.pdm_risk_dz_model_lmt_list_lft_rep_new_tmp
-- upstream_table: pdm_risk.pdm_risk_account_lmt_daily_6m_tmp
-- upstream_table: pdm_risk.pdm_risk_account_lmt_daily_1m_tmp
-- upstream_table: pdm_risk.pdm_risk_account_lmt_daily_12m_tmp
-- upstream_table: pdm_risk.pdm_risk_account_lmt_daily_3m_tmp
-- upstream_table: pdm_risk.pdm_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_new_tmp
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 沈喜望
--创建日期: 2022-12-12 14:24:35
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--


-- create table if not exists  ${pdm_risk}.pdm_risk_dz_model_lmt_list_lft_rep_new_tmp   
-- (
-- uid string comment ' uid ',
-- biz_no string comment ' 业务流水号 ',
-- lft_rep_prc_1m_cash decimal(28,6) comment '近1个月剩余cash额度',
-- lft_rep_prc_1m_dcp decimal(28,6) comment ' 近1个月剩余dcp额度 ',
-- lft_rep_prc_1m_hug decimal(28,6) comment '近1个月剩余huge额度',
-- lft_rep_prc_2m_cash decimal(28,6) comment ' 近2个月剩余cash额度 ',
-- lft_rep_prc_2m_dcp decimal(28,6) comment '近2个月剩余dcp额度',
-- lft_rep_prc_2m_hug decimal(28,6) comment ' 近2月剩余huge额度 ',
-- lft_rep_prc_3m_cash decimal(28,6) comment '近3个月剩余cash额度',
-- lft_rep_prc_3m_dcp decimal(28,6) comment ' 近3个月剩余dcp额度 ',
-- lft_rep_prc_3m_hug decimal(28,6) comment '近3个月剩余huge额度',
-- lft_rep_prc_6m_cash decimal(28,6) comment ' 近6个月剩余cash额度 ',
-- lft_rep_prc_6m_dcp decimal(28,6) comment '近6个月剩余dcp额度',
-- lft_rep_prc_6m_hug decimal(28,6) comment ' 近6个月剩余huge额度 ',
-- lft_rep_prc_all_cash decimal(28,6) comment '所有剩余cash额度',
-- lft_rep_prc_all_dcp decimal(28,6) comment ' 所有剩余dcp额度 ',
-- lft_rep_prc_all_hug decimal(28,6) comment '所有剩余huge额度',
-- ds string comment '格式yyyymmdd'
-- ) comment "大宽表额度表2" 
-- ;


insert overwrite table ${pdm_risk}.pdm_risk_dz_model_lmt_list_lft_rep_new_tmp  
select a.uid,biz_no,
      sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,1))  then b.prc_amt else 0 end) as lft_rep_prc_1m_cash,
      sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,1)) then b.prc_amt else 0 end) as lft_rep_prc_1m_dcp,
      sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,1)) then b.prc_amt else 0 end) as lft_rep_prc_1m_hug,
      sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_cash,
      sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_dcp,
      sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_hug,
      sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_cash,
      sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_dcp,
      sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_hug,
      sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_cash,
      sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_dcp,
      sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_hug,
      sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds then b.prc_amt else 0 end) as lft_rep_prc_all_cash,
      sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds then b.prc_amt else 0 end) as lft_rep_prc_all_dcp,
      sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds then b.prc_amt else 0 end) as lft_rep_prc_all_hug
      ,'${bizdate}'
from  (select 
       uid, 
       biz_no, 
       biz_typ, 
       bsy_typ, 
       time, 
       ds, 
       ord_stt, 
       stg_stt,
       prc_amt, 
       rsk_adt_lmt, 
       rsk_avl_lmt
    from ${dwa_risk}.dwa_risk_tmp_order_stage_account_union_all
    where ds = date_add(to_date('${bizdate}', 'yyyymmdd'), 0)) as a
left join ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic as b 
on a.uid=b.uid
group by a.uid,biz_no;



insert overwrite table ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_new_tmp
select uid,
    biz_no,
    ds,
    sum(lft_rep_prc_1m_cash) as lft_rep_prc_1m_cash,
    sum(lft_rep_prc_1m_dcp) as lft_rep_prc_1m_dcp,
    sum(lft_rep_prc_1m_hug) as lft_rep_prc_1m_hug,
    sum(lft_rep_prc_2m_cash) as lft_rep_prc_2m_cash,
    sum(lft_rep_prc_2m_dcp) as lft_rep_prc_2m_dcp,
    sum(lft_rep_prc_2m_hug) as lft_rep_prc_2m_hug,
    sum(lft_rep_prc_3m_cash) as lft_rep_prc_3m_cash,
    sum(lft_rep_prc_3m_dcp) as lft_rep_prc_3m_dcp,
    sum(lft_rep_prc_3m_hug) as lft_rep_prc_3m_hug,
    sum(lft_rep_prc_6m_cash) as lft_rep_prc_6m_cash,
    sum(lft_rep_prc_6m_dcp) as lft_rep_prc_6m_dcp,
    sum(lft_rep_prc_6m_hug) as lft_rep_prc_6m_hug,
    sum(lft_rep_prc_all_cash) as lft_rep_prc_all_cash,
    sum(lft_rep_prc_all_dcp) as lft_rep_prc_all_dcp,
    sum(lft_rep_prc_all_hug) as lft_rep_prc_all_hug

from
(
    select uid,
        biz_no,
        date_add(to_date(ds, 'yyyymmdd'), 0) as ds,
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
    from ${pdm_risk}.pdm_risk_dz_model_lmt_list_lft_rep_new_tmp
    where ds = '${bizdate}'

    union all 
    
    select uid,
        biz_no,
        ds,
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
    from ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_new_tmp
    where ds < date_add(to_date('${bizdate}', 'yyyymmdd'), 0)-- 防止重试造成的多次重复union
) as a
where ds >= date_add(add_months(date_add(to_date('${bizdate}', 'yyyymmdd'), 0), -12), 1) -- 剔除过期样本, 否则会越来越大
group by uid, biz_no, ds; -- 其实不用再做groupby, 当天新增的mot样本必然不在历史样本中


drop table if exists ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp;
create table if not exists ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp as
select a.uid,
       a.biz_no,
       a.biz_typ,
       a.bsy_typ,
       a.time,
       a.ds,
       a.rsk_adt_lmt,
       a.rsk_avl_lmt,
       a.prc_amt,
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
       lft_rep_prc_all_hug,
       c.ord_stt_flg
from (select uid,
             biz_no,
             biz_typ,
             bsy_typ,
             time,
             ds,
             rsk_adt_lmt,
             rsk_avl_lmt,
             prc_amt
      from  ${dwa_risk}.dwa_risk_tmp_order_stage_account_union_all 
      where biz_typ= 'brw') as a
left join ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_new_tmp as b
on a.biz_no=b.biz_no
left join ${dwa_risk}.dwa_risk_f_heavy_order_info_basic c 
on a.biz_no=c.ord_no;


drop table if exists ${pdm_risk}.pdm_risk_account_lmt_daily_1m_tmp;
create table if not exists ${pdm_risk}.pdm_risk_account_lmt_daily_1m_tmp as 
select uid,
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_1m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_1m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_1m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_1m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_1m, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_1m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_1m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_1m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_1m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_1m_suc, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_1m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_1m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_1m,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_1m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_1m,  

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_1m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_1m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_1m_suc,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_1m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_1m_suc, 

      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_cnt_1m, 
      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_rate_1m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_cnt_1m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_rate_1m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_cnt_1m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_rate_1m,
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_cnt_1m, 
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_rate_1m,


      max(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as max_rsk_lmt_rate_bt_ch_1m,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as max_rsk_lmt_rate_dcp_1m,
      max(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as max_rsk_lmt_rate_hug_1m,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as min_rsk_lmt_rate_bt_ch_1m,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as min_rsk_lmt_rate_dcp_1m,
      min(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as min_rsk_lmt_rate_hug_1m,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as avg_rsk_lmt_rate_bt_ch_1m,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as avg_rsk_lmt_rate_dcp_1m,
      avg(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as avg_rsk_lmt_rate_hug_1m,

      max(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as max_rsk_lmt_rate_bt_ch_1m_suc,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as max_rsk_lmt_rate_dcp_1m_suc,
      max(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as max_rsk_lmt_rate_hug_1m_suc,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as min_rsk_lmt_rate_bt_ch_1m_suc,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as min_rsk_lmt_rate_dcp_1m_suc,
      min(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as min_rsk_lmt_rate_hug_1m_suc,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as avg_rsk_lmt_rate_bt_ch_1m_suc,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as avg_rsk_lmt_rate_dcp_1m_suc,
      avg(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as avg_rsk_lmt_rate_hug_1m_suc

from(
select model_data.uid,
      biz_typ,
      bsy_typ,
      model_data.mdl_dte,
      b.time,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then 1 else 0 end as bsy_ch_bt,
      case when bsy_typ in ('ENJOY_PAY') then 1 else 0 end as bsy_dcp,
      case when bsy_typ in ('HUGE_LOAN') then 1 else 0 end as bsy_hug,
      rsk_avl_lmt,
      rsk_adt_lmt,
      case when ord_stt_flg='success' then rsk_avl_lmt-prc_amt else rsk_avl_lmt end as avl_lmt,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash,
      case when bsy_typ in ('ENJOY_PAY') then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp,
      case when bsy_typ in ('HUGE_LOAN') then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash_suc,
      case when bsy_typ in ('ENJOY_PAY') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp_suc,
      case when bsy_typ in ('HUGE_LOAN') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug_suc

      from ${dwa_risk}.dwa_risk_f_dz_model_data_base  model_data 
      left join ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp as b
      on model_data.uid=b.uid
      where date(b.time) >= add_months(model_data.mdl_dte,-1)
      and date(b.time)<model_data.mdl_dte
) as a 
group by uid;


drop table if exists ${pdm_risk}.pdm_risk_account_lmt_daily_3m_tmp;
create table if not exists ${pdm_risk}.pdm_risk_account_lmt_daily_3m_tmp as 
select uid,
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_3m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_3m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_3m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_3m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_3m, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_3m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_3m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_3m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_3m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_3m_suc, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_3m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_3m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_3m,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_3m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_3m,  

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_3m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_3m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_3m_suc,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_3m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_3m_suc, 


      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_cnt_3m, 
      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_rate_3m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_cnt_3m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_rate_3m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_cnt_3m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_rate_3m,
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_cnt_3m, 
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_rate_3m,


      max(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as max_rsk_lmt_rate_bt_ch_3m,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as max_rsk_lmt_rate_dcp_3m,
      max(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as max_rsk_lmt_rate_hug_3m,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as min_rsk_lmt_rate_bt_ch_3m,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as min_rsk_lmt_rate_dcp_3m,
      min(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as min_rsk_lmt_rate_hug_3m,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as avg_rsk_lmt_rate_bt_ch_3m,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as avg_rsk_lmt_rate_dcp_3m,
      avg(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as avg_rsk_lmt_rate_hug_3m,

      max(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as max_rsk_lmt_rate_bt_ch_3m_suc,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as max_rsk_lmt_rate_dcp_3m_suc,
      max(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as max_rsk_lmt_rate_hug_3m_suc,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as min_rsk_lmt_rate_bt_ch_3m_suc,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as min_rsk_lmt_rate_dcp_3m_suc,
      min(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as min_rsk_lmt_rate_hug_3m_suc,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as avg_rsk_lmt_rate_bt_ch_3m_suc,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as avg_rsk_lmt_rate_dcp_3m_suc,
      avg(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as avg_rsk_lmt_rate_hug_3m_suc

from(
select model_data.uid,
      biz_typ,
      bsy_typ,
      model_data.mdl_dte,
      b.time,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then 1 else 0 end as bsy_ch_bt,
      case when bsy_typ in ('ENJOY_PAY') then 1 else 0 end as bsy_dcp,
      case when bsy_typ in ('HUGE_LOAN') then 1 else 0 end as bsy_hug,
      rsk_avl_lmt,
      rsk_adt_lmt,
      case when ord_stt_flg='success' then rsk_avl_lmt-prc_amt else rsk_avl_lmt end as avl_lmt,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash,
      case when bsy_typ in ('ENJOY_PAY') then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp,
      case when bsy_typ in ('HUGE_LOAN') then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash_suc,
      case when bsy_typ in ('ENJOY_PAY') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp_suc,
      case when bsy_typ in ('HUGE_LOAN') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug_suc

      from ${dwa_risk}.dwa_risk_f_dz_model_data_base  model_data 
      left join ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp as b
      on model_data.uid=b.uid
      where date(b.time) >= add_months(model_data.mdl_dte,-3)
      and date(b.time)<model_data.mdl_dte
) as a 
group by uid;


drop table if exists ${pdm_risk}.pdm_risk_account_lmt_daily_6m_tmp;
create table if not exists ${pdm_risk}.pdm_risk_account_lmt_daily_6m_tmp as 
select uid,
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_6m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_6m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_6m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_6m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_6m, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_6m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_6m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_6m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_6m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_6m_suc, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_6m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_6m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_6m,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_6m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_6m,  

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_6m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_6m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_6m_suc,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_6m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_6m_suc,  

      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_cnt_6m, 
      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_rate_6m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_cnt_6m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_rate_6m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_cnt_6m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_rate_6m,
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_cnt_6m, 
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_rate_6m,


      max(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as max_rsk_lmt_rate_bt_ch_6m,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as max_rsk_lmt_rate_dcp_6m,
      max(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as max_rsk_lmt_rate_hug_6m,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as min_rsk_lmt_rate_bt_ch_6m,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as min_rsk_lmt_rate_dcp_6m,
      min(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as min_rsk_lmt_rate_hug_6m,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as avg_rsk_lmt_rate_bt_ch_6m,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as avg_rsk_lmt_rate_dcp_6m,
      avg(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as avg_rsk_lmt_rate_hug_6m,

      max(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as max_rsk_lmt_rate_bt_ch_6m_suc,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as max_rsk_lmt_rate_dcp_6m_suc,
      max(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as max_rsk_lmt_rate_hug_6m_suc,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as min_rsk_lmt_rate_bt_ch_6m_suc,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as min_rsk_lmt_rate_dcp_6m_suc,
      min(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as min_rsk_lmt_rate_hug_6m_suc,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as avg_rsk_lmt_rate_bt_ch_6m_suc,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as avg_rsk_lmt_rate_dcp_6m_suc,
      avg(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as avg_rsk_lmt_rate_hug_6m_suc

from(
select model_data.uid,
      biz_typ,
      bsy_typ,
      model_data.mdl_dte,
      b.time,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then 1 else 0 end as bsy_ch_bt,
      case when bsy_typ in ('ENJOY_PAY') then 1 else 0 end as bsy_dcp,
      case when bsy_typ in ('HUGE_LOAN') then 1 else 0 end as bsy_hug,
      rsk_avl_lmt,
      rsk_adt_lmt,
      case when ord_stt_flg='success' then rsk_avl_lmt-prc_amt else rsk_avl_lmt end as avl_lmt,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash,
      case when bsy_typ in ('ENJOY_PAY') then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp,
      case when bsy_typ in ('HUGE_LOAN') then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash_suc,
      case when bsy_typ in ('ENJOY_PAY') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp_suc,
      case when bsy_typ in ('HUGE_LOAN') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug_suc

      from ${dwa_risk}.dwa_risk_f_dz_model_data_base  model_data 
      left join ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp as b
      on model_data.uid=b.uid
      where date(b.time) >= add_months(model_data.mdl_dte,-6)
      and date(b.time)<model_data.mdl_dte
) as a 
group by uid;



drop table if exists ${pdm_risk}.pdm_risk_account_lmt_daily_12m_tmp;
create table if not exists ${pdm_risk}.pdm_risk_account_lmt_daily_12m_tmp as 
select uid,
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_12m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_12m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_12m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_12m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_12m, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end) as used_rate_ch_grt_0p95_cnt_12m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end) as used_rate_ch_grt_0p9_cnt_12m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end) as used_rate_ch_grt_0p8_cnt_12m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end) as used_rate_ch_grt_0p5_cnt_12m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end) as used_rate_ch_grt_0p2_cnt_12m_suc, 

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_12m, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_12m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_12m,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_12m,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_12m,  

      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p95_rate_12m_suc, 
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p9_rate_12m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p8_rate_12m_suc,      
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p5_rate_12m_suc,  
      count(case when bsy_ch_bt=1 and lmt_rate_all_cash_suc<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as used_rate_ch_grt_0p2_rate_12m_suc, 

      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_cnt_12m, 
      count(case when bsy_ch_bt=1 and avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_500_rate_12m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_cnt_12m, 
      count(case when bsy_ch_bt=1 and avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_1000_rate_12m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_cnt_12m, 
      count(case when bsy_ch_bt=1 and avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_5000_rate_12m,
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_cnt_12m, 
      count(case when bsy_ch_bt=1 and avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_les_10000_rate_12m,


      max(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as max_rsk_lmt_rate_bt_ch_12m,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as max_rsk_lmt_rate_dcp_12m,
      max(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as max_rsk_lmt_rate_hug_12m,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as min_rsk_lmt_rate_bt_ch_12m,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as min_rsk_lmt_rate_dcp_12m,
      min(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as min_rsk_lmt_rate_hug_12m,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash else NULL end) as avg_rsk_lmt_rate_bt_ch_12m,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp else NULL end) as avg_rsk_lmt_rate_dcp_12m,
      avg(case when bsy_hug=1 then lmt_rate_all_hug else NULL end) as avg_rsk_lmt_rate_hug_12m,

      max(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as max_rsk_lmt_rate_bt_ch_12m_suc,
      max(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as max_rsk_lmt_rate_dcp_12m_suc,
      max(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as max_rsk_lmt_rate_hug_12m_suc,

      min(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as min_rsk_lmt_rate_bt_ch_12m_suc,
      min(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as min_rsk_lmt_rate_dcp_12m_suc,
      min(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as min_rsk_lmt_rate_hug_12m_suc,

      avg(case when bsy_ch_bt=1 then lmt_rate_all_cash_suc else NULL end) as avg_rsk_lmt_rate_bt_ch_12m_suc,
      avg(case when bsy_dcp=1 then lmt_rate_all_dcp_suc else NULL end) as avg_rsk_lmt_rate_dcp_12m_suc,
      avg(case when bsy_hug=1 then lmt_rate_all_hug_suc else NULL end) as avg_rsk_lmt_rate_hug_12m_suc
      

from(
select model_data.uid,
      biz_typ,
      bsy_typ,
      model_data.mdl_dte,
      b.time,
      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then 1 else 0 end as bsy_ch_bt,
      case when bsy_typ in ('ENJOY_PAY') then 1 else 0 end as bsy_dcp,
      case when bsy_typ in ('HUGE_LOAN') then 1 else 0 end as bsy_hug,
      rsk_avl_lmt,
      rsk_adt_lmt,
      case when ord_stt_flg='success' then rsk_avl_lmt-prc_amt else rsk_avl_lmt end as avl_lmt,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash,
      case when bsy_typ in ('ENJOY_PAY') then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp,
      case when bsy_typ in ('HUGE_LOAN') then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug,

      case when bsy_typ in ('BALANCE_TRANSFER','CASH') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_cash)/rsk_adt_lmt else null end as lmt_rate_all_cash_suc,
      case when bsy_typ in ('ENJOY_PAY') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_dcp)/rsk_adt_lmt else null end as lmt_rate_all_dcp_suc,
      case when bsy_typ in ('HUGE_LOAN') and ord_stt_flg='success' then (prc_amt+lft_rep_prc_all_hug)/rsk_adt_lmt else null end as lmt_rate_all_hug_suc

      from ${dwa_risk}.dwa_risk_f_dz_model_data_base  model_data 
      left join ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp as b
      on model_data.uid=b.uid
      where date(b.time) >= add_months(model_data.mdl_dte,-12)
      and date(b.time)<model_data.mdl_dte
) as a 
group by uid;



create table if not exists ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_final_df 
(
uid string comment 'uid',
mdl_dte string comment '模型日期',
used_rate_ch_grt_0p95_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.95的次数',
used_rate_ch_grt_0p9_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.9的次数',
used_rate_ch_grt_0p8_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.8的次数',
used_rate_ch_grt_0p5_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.5的次数',
used_rate_ch_grt_0p2_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于0.2的次数',
used_rate_ch_grt_0p95_cnt_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率超过0.95的次数(成功订单)',
used_rate_ch_grt_0p9_cnt_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率超过0.9的次数(成功订单)',
used_rate_ch_grt_0p8_cnt_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率超过0.8的次数(成功订单)',
used_rate_ch_grt_0p5_cnt_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率超过0.5的次数(成功订单)',
used_rate_ch_grt_0p2_cnt_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率小于0.2的次数(成功订单)',
used_rate_ch_grt_0p95_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.95的占比',
used_rate_ch_grt_0p9_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.9的占比',
used_rate_ch_grt_0p8_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.8的占比',
used_rate_ch_grt_0p5_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.5的占比',
used_rate_ch_grt_0p2_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于0.2的占比',
used_rate_ch_grt_0p95_rate_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率超过0.95的占比(成功订单)', 
used_rate_ch_grt_0p9_rate_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率超过0.9的占比(成功订单)', 
used_rate_ch_grt_0p8_rate_1m_suc  decimal(38,16) comment '近1个月现金贷额度使用率超过0.8的占比(成功订单)', 
used_rate_ch_grt_0p5_rate_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率超过0.5的占比(成功订单)', 
used_rate_ch_grt_0p2_rate_1m_suc decimal(38,16) comment '近1个月现金贷额度使用率小于0.2的占比(成功订单)', 
rsk_avl_lmt_ch_les_500_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于500的次数',
rsk_avl_lmt_ch_les_500_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于500的占比',
rsk_avl_lmt_ch_les_1000_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于1000的次数',
rsk_avl_lmt_ch_les_1000_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于1000的占比',
rsk_avl_lmt_ch_les_5000_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于5000的次数',
rsk_avl_lmt_ch_les_5000_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于5000的占比',
rsk_avl_lmt_ch_les_10000_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于10000的次数',
rsk_avl_lmt_ch_les_10000_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于10000的占比',
max_rsk_lmt_rate_bt_ch_1m decimal(38,16) comment '近1个月现金贷最大额度使用率',
max_rsk_lmt_rate_dcp_1m decimal(38,16) comment '近1个月DCP最大额度使用率',
max_rsk_lmt_rate_hug_1m decimal(38,16) comment '近1个月大额贷最大额度使用率',
min_rsk_lmt_rate_bt_ch_1m decimal(38,16) comment '近1个月现金贷最小额度使用率',
min_rsk_lmt_rate_dcp_1m decimal(38,16) comment '近1个月DCP最小额度使用率',
min_rsk_lmt_rate_hug_1m decimal(38,16) comment '近1个月大额贷最小额度使用率',
avg_rsk_lmt_rate_bt_ch_1m decimal(38,16) comment '近1个月现金贷平均额度使用率',
avg_rsk_lmt_rate_dcp_1m decimal(38,16) comment '近1个月DCP平均额度使用率',
avg_rsk_lmt_rate_hug_1m decimal(38,16) comment '近1个月大额贷平均额度使用率',
max_rsk_lmt_rate_bt_ch_1m_suc decimal(38,16) comment '近1个月现金贷最大额度使用率(成功订单)',
max_rsk_lmt_rate_dcp_1m_suc decimal(38,16) comment '近1个月DCP最大额度使用率(成功订单)',
max_rsk_lmt_rate_hug_1m_suc decimal(38,16) comment '近1个月大额贷最大额度使用率(成功订单)',
min_rsk_lmt_rate_bt_ch_1m_suc decimal(38,16) comment '近1个月现金贷最小额度使用率(成功订单)',
min_rsk_lmt_rate_dcp_1m_suc decimal(38,16) comment '近1个月DCP最小额度使用率(成功订单)',
min_rsk_lmt_rate_hug_1m_suc decimal(38,16) comment '近1个月大额贷最小额度使用率(成功订单)',
avg_rsk_lmt_rate_bt_ch_1m_suc decimal(38,16) comment '近1个月现金贷平均额度使用率(成功订单)',
avg_rsk_lmt_rate_dcp_1m_suc decimal(38,16) comment '近1个月DCP平均额度使用率(成功订单)',
avg_rsk_lmt_rate_hug_1m_suc decimal(38,16) comment '近1个月大额贷平均额度使用率(成功订单)',
used_rate_ch_grt_0p95_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.95的次数',
used_rate_ch_grt_0p9_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.9的次数',
used_rate_ch_grt_0p8_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.8的次数',
used_rate_ch_grt_0p5_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.5的次数',
used_rate_ch_grt_0p2_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于0.2的次数',
used_rate_ch_grt_0p95_cnt_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率超过0.95的次数(成功订单)',
used_rate_ch_grt_0p9_cnt_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率超过0.9的次数(成功订单)',
used_rate_ch_grt_0p8_cnt_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率超过0.8的次数(成功订单)',
used_rate_ch_grt_0p5_cnt_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率超过0.5的次数(成功订单)',
used_rate_ch_grt_0p2_cnt_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率小于0.2的次数(成功订单)',
used_rate_ch_grt_0p95_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.95的占比',
used_rate_ch_grt_0p9_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.9的占比',
used_rate_ch_grt_0p8_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.8的占比',
used_rate_ch_grt_0p5_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.5的占比',
used_rate_ch_grt_0p2_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于0.2的占比',
used_rate_ch_grt_0p95_rate_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率超过0.95的占比(成功订单)', 
used_rate_ch_grt_0p9_rate_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率超过0.9的占比(成功订单)', 
used_rate_ch_grt_0p8_rate_3m_suc  decimal(38,16) comment '近3个月现金贷额度使用率超过0.8的占比(成功订单)', 
used_rate_ch_grt_0p5_rate_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率超过0.5的占比(成功订单)', 
used_rate_ch_grt_0p2_rate_3m_suc decimal(38,16) comment '近3个月现金贷额度使用率小于0.2的占比(成功订单)', 
rsk_avl_lmt_ch_les_500_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于500的次数',
rsk_avl_lmt_ch_les_500_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于500的占比',
rsk_avl_lmt_ch_les_1000_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于1000的次数',
rsk_avl_lmt_ch_les_1000_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于1000的占比',
rsk_avl_lmt_ch_les_5000_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于5000的次数',
rsk_avl_lmt_ch_les_5000_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于5000的占比',
rsk_avl_lmt_ch_les_10000_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于10000的次数',
rsk_avl_lmt_ch_les_10000_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于10000的占比',
max_rsk_lmt_rate_bt_ch_3m decimal(38,16) comment '近3个月现金贷最大额度使用率',
max_rsk_lmt_rate_dcp_3m decimal(38,16) comment '近3个月DCP最大额度使用率',
max_rsk_lmt_rate_hug_3m decimal(38,16) comment '近3个月大额贷最大额度使用率',
min_rsk_lmt_rate_bt_ch_3m decimal(38,16) comment '近3个月现金贷最小额度使用率',
min_rsk_lmt_rate_dcp_3m decimal(38,16) comment '近3个月DCP最小额度使用率',
min_rsk_lmt_rate_hug_3m decimal(38,16) comment '近3个月大额贷最小额度使用率',
avg_rsk_lmt_rate_bt_ch_3m decimal(38,16) comment '近3个月现金贷平均额度使用率',
avg_rsk_lmt_rate_dcp_3m decimal(38,16) comment '近3个月DCP平均额度使用率',
avg_rsk_lmt_rate_hug_3m decimal(38,16) comment '近3个月大额贷平均额度使用率',
max_rsk_lmt_rate_bt_ch_3m_suc decimal(38,16) comment '近3个月现金贷最大额度使用率(成功订单)',
max_rsk_lmt_rate_dcp_3m_suc decimal(38,16) comment '近3个月DCP最大额度使用率(成功订单)',
max_rsk_lmt_rate_hug_3m_suc decimal(38,16) comment '近3个月大额贷最大额度使用率(成功订单)',
min_rsk_lmt_rate_bt_ch_3m_suc decimal(38,16) comment '近3个月现金贷最小额度使用率(成功订单)',
min_rsk_lmt_rate_dcp_3m_suc decimal(38,16) comment '近3个月DCP最小额度使用率(成功订单)',
min_rsk_lmt_rate_hug_3m_suc decimal(38,16) comment '近3个月大额贷最小额度使用率(成功订单)',
avg_rsk_lmt_rate_bt_ch_3m_suc decimal(38,16) comment '近3个月现金贷平均额度使用率(成功订单)',
avg_rsk_lmt_rate_dcp_3m_suc decimal(38,16) comment '近3个月DCP平均额度使用率(成功订单)',
avg_rsk_lmt_rate_hug_3m_suc decimal(38,16) comment '近3个月大额贷平均额度使用率(成功订单)',
used_rate_ch_grt_0p95_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.95的次数',
used_rate_ch_grt_0p9_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.9的次数',
used_rate_ch_grt_0p8_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.8的次数',
used_rate_ch_grt_0p5_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.5的次数',
used_rate_ch_grt_0p2_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于0.2的次数',
used_rate_ch_grt_0p95_cnt_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率超过0.95的次数(成功订单)',
used_rate_ch_grt_0p9_cnt_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率超过0.9的次数(成功订单)',
used_rate_ch_grt_0p8_cnt_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率超过0.8的次数(成功订单)',
used_rate_ch_grt_0p5_cnt_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率超过0.5的次数(成功订单)',
used_rate_ch_grt_0p2_cnt_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率小于0.2的次数(成功订单)',
used_rate_ch_grt_0p95_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.95的占比',
used_rate_ch_grt_0p9_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.9的占比',
used_rate_ch_grt_0p8_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.8的占比',
used_rate_ch_grt_0p5_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.5的占比',
used_rate_ch_grt_0p2_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于0.2的占比',
used_rate_ch_grt_0p95_rate_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率超过0.95的占比(成功订单)', 
used_rate_ch_grt_0p9_rate_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率超过0.9的占比(成功订单)', 
used_rate_ch_grt_0p8_rate_6m_suc  decimal(38,16) comment '近6个月现金贷额度使用率超过0.8的占比(成功订单)', 
used_rate_ch_grt_0p5_rate_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率超过0.5的占比(成功订单)', 
used_rate_ch_grt_0p2_rate_6m_suc decimal(38,16) comment '近6个月现金贷额度使用率小于0.2的占比(成功订单)', 
rsk_avl_lmt_ch_les_500_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于500的次数',
rsk_avl_lmt_ch_les_500_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于500的占比',
rsk_avl_lmt_ch_les_1000_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于1000的次数',
rsk_avl_lmt_ch_les_1000_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于1000的占比',
rsk_avl_lmt_ch_les_5000_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于5000的次数',
rsk_avl_lmt_ch_les_5000_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于5000的占比',
rsk_avl_lmt_ch_les_10000_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于10000的次数',
rsk_avl_lmt_ch_les_10000_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于10000的占比',
max_rsk_lmt_rate_bt_ch_6m decimal(38,16) comment '近6个月现金贷最大额度使用率',
max_rsk_lmt_rate_dcp_6m decimal(38,16) comment '近6个月DCP最大额度使用率',
max_rsk_lmt_rate_hug_6m decimal(38,16) comment '近6个月大额贷最大额度使用率',
min_rsk_lmt_rate_bt_ch_6m decimal(38,16) comment '近6个月现金贷最小额度使用率',
min_rsk_lmt_rate_dcp_6m decimal(38,16) comment '近6个月DCP最小额度使用率',
min_rsk_lmt_rate_hug_6m decimal(38,16) comment '近6个月大额贷最小额度使用率',
avg_rsk_lmt_rate_bt_ch_6m decimal(38,16) comment '近6个月现金贷平均额度使用率',
avg_rsk_lmt_rate_dcp_6m decimal(38,16) comment '近6个月DCP平均额度使用率',
avg_rsk_lmt_rate_hug_6m decimal(38,16) comment '近6个月大额贷平均额度使用率',
max_rsk_lmt_rate_bt_ch_6m_suc decimal(38,16) comment '近6个月现金贷最大额度使用率(成功订单)',
max_rsk_lmt_rate_dcp_6m_suc decimal(38,16) comment '近6个月DCP最大额度使用率(成功订单)',
max_rsk_lmt_rate_hug_6m_suc decimal(38,16) comment '近6个月大额贷最大额度使用率(成功订单)',
min_rsk_lmt_rate_bt_ch_6m_suc decimal(38,16) comment '近6个月现金贷最小额度使用率(成功订单)',
min_rsk_lmt_rate_dcp_6m_suc decimal(38,16) comment '近6个月DCP最小额度使用率(成功订单)',
min_rsk_lmt_rate_hug_6m_suc decimal(38,16) comment '近6个月大额贷最小额度使用率(成功订单)',
avg_rsk_lmt_rate_bt_ch_6m_suc decimal(38,16) comment '近6个月现金贷平均额度使用率(成功订单)',
avg_rsk_lmt_rate_dcp_6m_suc decimal(38,16) comment '近6个月DCP平均额度使用率(成功订单)',
avg_rsk_lmt_rate_hug_6m_suc decimal(38,16) comment '近6个月大额贷平均额度使用率(成功订单)',
used_rate_ch_grt_0p95_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.95的次数',
used_rate_ch_grt_0p9_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.9的次数',
used_rate_ch_grt_0p8_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.8的次数',
used_rate_ch_grt_0p5_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.5的次数',
used_rate_ch_grt_0p2_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率小于0.2的次数',
used_rate_ch_grt_0p95_cnt_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率超过0.95的次数(成功订单)',
used_rate_ch_grt_0p9_cnt_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率超过0.9的次数(成功订单)',
used_rate_ch_grt_0p8_cnt_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率超过0.8的次数(成功订单)',
used_rate_ch_grt_0p5_cnt_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率超过0.5的次数(成功订单)',
used_rate_ch_grt_0p2_cnt_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率小于0.2的次数(成功订单)',
used_rate_ch_grt_0p95_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.95的占比',
used_rate_ch_grt_0p9_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.9的占比',
used_rate_ch_grt_0p8_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.8的占比',
used_rate_ch_grt_0p5_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率超过0.5的占比',
used_rate_ch_grt_0p2_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率小于0.2的占比',
used_rate_ch_grt_0p95_rate_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率超过0.95的占比(成功订单)', 
used_rate_ch_grt_0p9_rate_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率超过0.9的占比(成功订单)', 
used_rate_ch_grt_0p8_rate_12m_suc  decimal(38,16) comment '近12个月现金贷额度使用率超过0.8的占比(成功订单)', 
used_rate_ch_grt_0p5_rate_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率超过0.5的占比(成功订单)', 
used_rate_ch_grt_0p2_rate_12m_suc decimal(38,16) comment '近12个月现金贷额度使用率小于0.2的占比(成功订单)', 
rsk_avl_lmt_ch_les_500_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率小于500的次数',
rsk_avl_lmt_ch_les_500_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率小于500的占比',
rsk_avl_lmt_ch_les_1000_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率小于1000的次数',
rsk_avl_lmt_ch_les_1000_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率小于1000的占比',
rsk_avl_lmt_ch_les_5000_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率小于5000的次数',
rsk_avl_lmt_ch_les_5000_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率小于5000的占比',
rsk_avl_lmt_ch_les_10000_cnt_12m decimal(38,16) comment '近12个月现金贷额度使用率小于10000的次数',
rsk_avl_lmt_ch_les_10000_rate_12m decimal(38,16) comment '近12个月现金贷额度使用率小于10000的占比',
max_rsk_lmt_rate_bt_ch_12m decimal(38,16) comment '近12个月现金贷最大额度使用率',
max_rsk_lmt_rate_dcp_12m decimal(38,16) comment '近12个月DCP最大额度使用率',
max_rsk_lmt_rate_hug_12m decimal(38,16) comment '近12个月大额贷最大额度使用率',
min_rsk_lmt_rate_bt_ch_12m decimal(38,16) comment '近12个月现金贷最小额度使用率',
min_rsk_lmt_rate_dcp_12m decimal(38,16) comment '近12个月DCP最小额度使用率',
min_rsk_lmt_rate_hug_12m decimal(38,16) comment '近12个月大额贷最小额度使用率',
avg_rsk_lmt_rate_bt_ch_12m decimal(38,16) comment '近12个月现金贷平均额度使用率',
avg_rsk_lmt_rate_dcp_12m decimal(38,16) comment '近12个月DCP平均额度使用率',
avg_rsk_lmt_rate_hug_12m decimal(38,16) comment '近12个月大额贷平均额度使用率',
max_rsk_lmt_rate_bt_ch_12m_suc decimal(38,16) comment '近12个月现金贷最大额度使用率(成功订单)',
max_rsk_lmt_rate_dcp_12m_suc decimal(38,16) comment '近12个月DCP最大额度使用率(成功订单)',
max_rsk_lmt_rate_hug_12m_suc decimal(38,16) comment '近12个月大额贷最大额度使用率(成功订单)',
min_rsk_lmt_rate_bt_ch_12m_suc decimal(38,16) comment '近12个月现金贷最小额度使用率(成功订单)',
min_rsk_lmt_rate_dcp_12m_suc decimal(38,16) comment '近12个月DCP最小额度使用率(成功订单)',
min_rsk_lmt_rate_hug_12m_suc decimal(38,16) comment '近12个月大额贷最小额度使用率(成功订单)',
avg_rsk_lmt_rate_bt_ch_12m_suc decimal(38,16) comment '近12个月现金贷平均额度使用率(成功订单)',
avg_rsk_lmt_rate_dcp_12m_suc decimal(38,16) comment '近12个月DCP平均额度使用率(成功订单)',
avg_rsk_lmt_rate_hug_12m_suc decimal(38,16) comment '近12个月大额贷平均额度使用率(成功订单)'

) comment "额度使用率(新口径)" 
partitioned by (ds string comment '分区字段,格式yyyymmdd')
;


insert overwrite table ${pdm_risk}.pdm_risk_dz_model_account_lmt_feature_sample_final_df partition(ds='${bizdate}')
select a.uid,
       a.mdl_dte,
      used_rate_ch_grt_0p95_cnt_1m,
      used_rate_ch_grt_0p9_cnt_1m,
      used_rate_ch_grt_0p8_cnt_1m,
      used_rate_ch_grt_0p5_cnt_1m,
      used_rate_ch_grt_0p2_cnt_1m,
      used_rate_ch_grt_0p95_cnt_1m_suc,
      used_rate_ch_grt_0p9_cnt_1m_suc,
      used_rate_ch_grt_0p8_cnt_1m_suc,
      used_rate_ch_grt_0p5_cnt_1m_suc,
      used_rate_ch_grt_0p2_cnt_1m_suc,
      used_rate_ch_grt_0p95_rate_1m,
      used_rate_ch_grt_0p9_rate_1m,
      used_rate_ch_grt_0p8_rate_1m,
      used_rate_ch_grt_0p5_rate_1m,
      used_rate_ch_grt_0p2_rate_1m,
      used_rate_ch_grt_0p95_rate_1m_suc, 
      used_rate_ch_grt_0p9_rate_1m_suc, 
      used_rate_ch_grt_0p8_rate_1m_suc, 
      used_rate_ch_grt_0p5_rate_1m_suc, 
      used_rate_ch_grt_0p2_rate_1m_suc, 
      rsk_avl_lmt_ch_les_500_cnt_1m,
      rsk_avl_lmt_ch_les_500_rate_1m,
      rsk_avl_lmt_ch_les_1000_cnt_1m,
      rsk_avl_lmt_ch_les_1000_rate_1m,
      rsk_avl_lmt_ch_les_5000_cnt_1m,
      rsk_avl_lmt_ch_les_5000_rate_1m,
      rsk_avl_lmt_ch_les_10000_cnt_1m,
      rsk_avl_lmt_ch_les_10000_rate_1m,
      max_rsk_lmt_rate_bt_ch_1m,
      max_rsk_lmt_rate_dcp_1m,
      max_rsk_lmt_rate_hug_1m,
      min_rsk_lmt_rate_bt_ch_1m,
      min_rsk_lmt_rate_dcp_1m,
      min_rsk_lmt_rate_hug_1m,
      avg_rsk_lmt_rate_bt_ch_1m,
      avg_rsk_lmt_rate_dcp_1m,
      avg_rsk_lmt_rate_hug_1m,
      max_rsk_lmt_rate_bt_ch_1m_suc,
      max_rsk_lmt_rate_dcp_1m_suc,
      max_rsk_lmt_rate_hug_1m_suc,
      min_rsk_lmt_rate_bt_ch_1m_suc,
      min_rsk_lmt_rate_dcp_1m_suc,
      min_rsk_lmt_rate_hug_1m_suc,
      avg_rsk_lmt_rate_bt_ch_1m_suc,
      avg_rsk_lmt_rate_dcp_1m_suc,
      avg_rsk_lmt_rate_hug_1m_suc,
      used_rate_ch_grt_0p95_cnt_3m,
      used_rate_ch_grt_0p9_cnt_3m,
      used_rate_ch_grt_0p8_cnt_3m,
      used_rate_ch_grt_0p5_cnt_3m,
      used_rate_ch_grt_0p2_cnt_3m,
      used_rate_ch_grt_0p95_cnt_3m_suc,
      used_rate_ch_grt_0p9_cnt_3m_suc,
      used_rate_ch_grt_0p8_cnt_3m_suc,
      used_rate_ch_grt_0p5_cnt_3m_suc,
      used_rate_ch_grt_0p2_cnt_3m_suc,
      used_rate_ch_grt_0p95_rate_3m,
      used_rate_ch_grt_0p9_rate_3m,
      used_rate_ch_grt_0p8_rate_3m,
      used_rate_ch_grt_0p5_rate_3m,
      used_rate_ch_grt_0p2_rate_3m,
      used_rate_ch_grt_0p95_rate_3m_suc,
      used_rate_ch_grt_0p9_rate_3m_suc,
      used_rate_ch_grt_0p8_rate_3m_suc,
      used_rate_ch_grt_0p5_rate_3m_suc,
      used_rate_ch_grt_0p2_rate_3m_suc,
      rsk_avl_lmt_ch_les_500_cnt_3m,
      rsk_avl_lmt_ch_les_500_rate_3m,
      rsk_avl_lmt_ch_les_1000_cnt_3m,
      rsk_avl_lmt_ch_les_1000_rate_3m,
      rsk_avl_lmt_ch_les_5000_cnt_3m,
      rsk_avl_lmt_ch_les_5000_rate_3m,
      rsk_avl_lmt_ch_les_10000_cnt_3m,
      rsk_avl_lmt_ch_les_10000_rate_3m,
      max_rsk_lmt_rate_bt_ch_3m,
      max_rsk_lmt_rate_dcp_3m,
      max_rsk_lmt_rate_hug_3m,
      min_rsk_lmt_rate_bt_ch_3m,
      min_rsk_lmt_rate_dcp_3m,
      min_rsk_lmt_rate_hug_3m,
      avg_rsk_lmt_rate_bt_ch_3m,
      avg_rsk_lmt_rate_dcp_3m,
      avg_rsk_lmt_rate_hug_3m,
      max_rsk_lmt_rate_bt_ch_3m_suc,
      max_rsk_lmt_rate_dcp_3m_suc,
      max_rsk_lmt_rate_hug_3m_suc,
      min_rsk_lmt_rate_bt_ch_3m_suc,
      min_rsk_lmt_rate_dcp_3m_suc,
      min_rsk_lmt_rate_hug_3m_suc,
      avg_rsk_lmt_rate_bt_ch_3m_suc,
      avg_rsk_lmt_rate_dcp_3m_suc,
      avg_rsk_lmt_rate_hug_3m_suc,
      used_rate_ch_grt_0p95_cnt_6m,
      used_rate_ch_grt_0p9_cnt_6m,
      used_rate_ch_grt_0p8_cnt_6m,
      used_rate_ch_grt_0p5_cnt_6m,
      used_rate_ch_grt_0p2_cnt_6m,
      used_rate_ch_grt_0p95_cnt_6m_suc,
      used_rate_ch_grt_0p9_cnt_6m_suc,
      used_rate_ch_grt_0p8_cnt_6m_suc,
      used_rate_ch_grt_0p5_cnt_6m_suc,
      used_rate_ch_grt_0p2_cnt_6m_suc,
      used_rate_ch_grt_0p95_rate_6m,
      used_rate_ch_grt_0p9_rate_6m,
      used_rate_ch_grt_0p8_rate_6m,
      used_rate_ch_grt_0p5_rate_6m,
      used_rate_ch_grt_0p2_rate_6m,
      used_rate_ch_grt_0p95_rate_6m_suc,
      used_rate_ch_grt_0p9_rate_6m_suc,
      used_rate_ch_grt_0p8_rate_6m_suc, 
      used_rate_ch_grt_0p5_rate_6m_suc,
      used_rate_ch_grt_0p2_rate_6m_suc, 
      rsk_avl_lmt_ch_les_500_cnt_6m,
      rsk_avl_lmt_ch_les_500_rate_6m,
      rsk_avl_lmt_ch_les_1000_cnt_6m,
      rsk_avl_lmt_ch_les_1000_rate_6m,
      rsk_avl_lmt_ch_les_5000_cnt_6m,
      rsk_avl_lmt_ch_les_5000_rate_6m,
      rsk_avl_lmt_ch_les_10000_cnt_6m,
      rsk_avl_lmt_ch_les_10000_rate_6m,
      max_rsk_lmt_rate_bt_ch_6m,
      max_rsk_lmt_rate_dcp_6m,
      max_rsk_lmt_rate_hug_6m,
      min_rsk_lmt_rate_bt_ch_6m,
      min_rsk_lmt_rate_dcp_6m,
      min_rsk_lmt_rate_hug_6m,
      avg_rsk_lmt_rate_bt_ch_6m,
      avg_rsk_lmt_rate_dcp_6m,
      avg_rsk_lmt_rate_hug_6m,
      max_rsk_lmt_rate_bt_ch_6m_suc,
      max_rsk_lmt_rate_dcp_6m_suc,
      max_rsk_lmt_rate_hug_6m_suc,
      min_rsk_lmt_rate_bt_ch_6m_suc,
      min_rsk_lmt_rate_dcp_6m_suc,
      min_rsk_lmt_rate_hug_6m_suc,
      avg_rsk_lmt_rate_bt_ch_6m_suc,
      avg_rsk_lmt_rate_dcp_6m_suc,
      avg_rsk_lmt_rate_hug_6m_suc,
      used_rate_ch_grt_0p95_cnt_12m,
      used_rate_ch_grt_0p9_cnt_12m,
      used_rate_ch_grt_0p8_cnt_12m,
      used_rate_ch_grt_0p5_cnt_12m,
      used_rate_ch_grt_0p2_cnt_12m,
      used_rate_ch_grt_0p95_cnt_12m_suc,
      used_rate_ch_grt_0p9_cnt_12m_suc,
      used_rate_ch_grt_0p8_cnt_12m_suc,
      used_rate_ch_grt_0p5_cnt_12m_suc,
      used_rate_ch_grt_0p2_cnt_12m_suc,
      used_rate_ch_grt_0p95_rate_12m,
      used_rate_ch_grt_0p9_rate_12m,
      used_rate_ch_grt_0p8_rate_12m,
      used_rate_ch_grt_0p5_rate_12m,
      used_rate_ch_grt_0p2_rate_12m,
      used_rate_ch_grt_0p95_rate_12m_suc, 
      used_rate_ch_grt_0p9_rate_12m_suc, 
      used_rate_ch_grt_0p8_rate_12m_suc, 
      used_rate_ch_grt_0p5_rate_12m_suc, 
      used_rate_ch_grt_0p2_rate_12m_suc, 
      rsk_avl_lmt_ch_les_500_cnt_12m,
      rsk_avl_lmt_ch_les_500_rate_12m,
      rsk_avl_lmt_ch_les_1000_cnt_12m,
      rsk_avl_lmt_ch_les_1000_rate_12m,
      rsk_avl_lmt_ch_les_5000_cnt_12m,
      rsk_avl_lmt_ch_les_5000_rate_12m,
      rsk_avl_lmt_ch_les_10000_cnt_12m,
      rsk_avl_lmt_ch_les_10000_rate_12m,
      max_rsk_lmt_rate_bt_ch_12m,
      max_rsk_lmt_rate_dcp_12m,
      max_rsk_lmt_rate_hug_12m,
      min_rsk_lmt_rate_bt_ch_12m,
      min_rsk_lmt_rate_dcp_12m,
      min_rsk_lmt_rate_hug_12m,
      avg_rsk_lmt_rate_bt_ch_12m,
      avg_rsk_lmt_rate_dcp_12m,
      avg_rsk_lmt_rate_hug_12m,
      max_rsk_lmt_rate_bt_ch_12m_suc,
      max_rsk_lmt_rate_dcp_12m_suc,
      max_rsk_lmt_rate_hug_12m_suc,
      min_rsk_lmt_rate_bt_ch_12m_suc,
      min_rsk_lmt_rate_dcp_12m_suc,
      min_rsk_lmt_rate_hug_12m_suc,
      avg_rsk_lmt_rate_bt_ch_12m_suc,
      avg_rsk_lmt_rate_dcp_12m_suc,
      avg_rsk_lmt_rate_hug_12m_suc

from  ${dwa_risk}.dwa_risk_f_dz_model_data_base  as a
left join  ${pdm_risk}.pdm_risk_account_lmt_daily_1m_tmp as b
on a.uid=b.uid
left join  ${pdm_risk}.pdm_risk_account_lmt_daily_3m_tmp as c
on a.uid=c.uid
left join  ${pdm_risk}.pdm_risk_account_lmt_daily_6m_tmp as d
on a.uid=d.uid
left join  ${pdm_risk}.pdm_risk_account_lmt_daily_12m_tmp as e
on a.uid=e.uid;
-- feature-copilot:node-end ordinal=0
