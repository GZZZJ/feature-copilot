-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_36m_bizdate
-- node_id: n_3801961572201529344
-- task_name: dwa_risk_dz_model_account_lmt_feature_sample_all_final_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_36m_bizdate.json
-- source_json_sha256: 013c33af07bf88d36c2928d4770fdc915d563d978f2ad5c5125ce87ce4b60223
-- upstream_table: cdmx.cdmx_dim_credit_account_df
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic
-- upstream_table: dwa_risk.dwa_risk_dz_model_limit_ins_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2
-- upstream_table: dwa_risk.dwa_risk_tmp_order_stage_account_union_ins
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_1m
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_6m
-- upstream_table: dwa_risk.dwa_risk_dz_model_account_lmt_combine_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_3m
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_12m
-- upstream_table: dwa_risk.dwa_risk_tmp_order_stage_account_union_all
-- upstream_table: dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_lmt_list_lft_rep_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_account_lft_rep_tmp
-- upstream_table: dwa_risk.dwa_risk_dz_model_account_lmt_tmp

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应上的pdm_risk_dz_model_account_lmt_feature_sample_all_final
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--


-- drop table if exists dwa_risk.dwa_risk_dz_model_limit_ins_tmp;
-- create table if not exists dwa_risk.dwa_risk_dz_model_limit_ins_tmp as 
--  select uid,
--             account_no as act_no,
--             business_type as bsy_typ,
--             max(risk_admit_limit) as rsk_adt_lmt,
--             max(risk_available_limit) as rsk_avl_lmt,
--             date_add(to_date(ds, 'yyyymmdd'), 1) as day_dff1,
--             ds
--     from ${ld_loan}.dim_account_info
--     where business_type in  ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN')
--     and  date_add(to_date(ds, 'yyyymmdd'), 0) =date_sub(to_date('${bizdate}', 'yyyymmdd'), 1) 
-- group by uid,account_no,business_type,ds
-- ;
drop table if exists dwa_risk.dwa_risk_dz_model_limit_ins_tmp;
create table if not exists dwa_risk.dwa_risk_dz_model_limit_ins_tmp as 
select uid,
            account_no as act_no,
            credit_account_biz_type as bsy_typ,
            max(latest_risk_credit_limit) as rsk_adt_lmt,
            max(latest_risk_available_limit) as rsk_avl_lmt,
            date_add(to_date(ds, 'yyyymmdd'), 1) as day_dff1,
            ds
    from cdmx.cdmx_dim_credit_account_df
    where credit_account_biz_type in  ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN')
    and  date_add(to_date(ds, 'yyyymmdd'), 0) =date_sub(to_date('${bizdate}', 'yyyymmdd'), 1) 
group by uid,account_no,credit_account_biz_type,ds
;


-- 增量数据
-- create table if not exists dwa_risk.dwa_risk_tmp_order_stage_account_union_ins
-- (
-- uid string comment ' uid ',
-- biz_no string comment ' 业务流水号 ',
-- biz_typ string comment '业务类型',
-- bsy_typ string comment ' 产品类型 ',
-- time string comment '日期',
-- ord_stt string comment ' 订单状态 ',
-- stg_stt string comment '还款计划状态',
-- prc_amt decimal(18,6) comment ' 金额 ',
-- rsk_adt_lmt decimal(20,4) comment '授信额度',
-- rsk_avl_lmt decimal(20,4) comment '可用额度'
-- ) comment "大宽表额度表1" 
-- partitioned by (ds string comment '分区字段,格式yyyy-mm-dd')
;

drop table if exists dwa_risk.dwa_risk_tmp_order_stage_account_union_ins;
create table dwa_risk.dwa_risk_tmp_order_stage_account_union_ins as 
select  a.uid
        ,a.biz_no
        ,a.biz_typ
        ,a.bsy_typ
        ,a.time
        ,a.ord_stt
        ,a.stg_stt
        ,a.prc_amt
        ,b.rsk_adt_lmt
        ,b.rsk_avl_lmt
        ,a.ds
from    (
            select  uid
                    ,ord_no as biz_no
                    ,'brw' as biz_typ
                    ,bsy_typ
                    ,crt_tim as time
                    ,date(crt_tim) as ds
                    ,ord_stt
                    ,null as stg_stt
                    ,prc_amt
            from    dwa_risk.dwa_risk_f_heavy_order_info_basic
            where   date(crt_tim) = date_add(to_date('${bizdate}' ,'yyyymmdd') ,0)
        ) as a
left join  dwa_risk.dwa_risk_dz_model_limit_ins_tmp as b
on      a.uid = b.uid
and     a.bsy_typ = b.bsy_typ
and     a.ds = b.day_dff1
union all
select  a.uid
        ,a.biz_no
        ,a.biz_typ
        ,a.bsy_typ
        ,a.time
        ,a.ord_stt
        ,a.stg_stt
        ,a.prc_amt
        ,b.rsk_adt_lmt
        ,b.rsk_avl_lmt
        ,a.ds
from    (
            select  uid
                    ,stg_pln_no as biz_no
                    ,'pln' as biz_typ
                    ,bsy_typ
                    ,rep_tim as time
                    ,date(rep_tim) as ds
                    ,null as ord_stt
                    ,stg_stt
                    ,prc_amt
            from    dwa_risk.dwa_risk_f_heavy_stage_plan_basic
            where   to_date(rep_tim) = date_add(to_date('${bizdate}' ,'yyyymmdd') ,0)
        ) as a
left join  dwa_risk.dwa_risk_dz_model_limit_ins_tmp as b
on      a.uid = b.uid
and     a.bsy_typ = b.bsy_typ
and     a.ds = b.day_dff1;




-- drop table if exists  ${pdm_risk}.pdm_risk_tmp_order_stage_account_union_all ;
-- create table if not exists  ${pdm_risk}.pdm_risk_tmp_order_stage_account_union_all as 
-- select  a.uid
--         ,a.biz_no
--         ,a.biz_typ
--         ,a.bsy_typ
--         ,a.time
--         ,a.ord_stt
--         ,a.stg_stt
--         ,a.prc_amt
--         ,b.rsk_adt_lmt
--         ,b.rsk_avl_lmt
--         ,a.ds
-- from    (
--             select  uid
--                     ,ord_no as biz_no
--                     ,'brw' as biz_typ
--                     ,bsy_typ
--                     ,crt_tim as time
--                     ,date(crt_tim) as ds
--                     ,ord_stt
--                     ,null as stg_stt
--                     ,prc_amt
--             from    dwa_risk.dwa_risk_f_heavy_order_info_basic
--             where   date(crt_tim) between add_months(date_add(to_date('${bizdate}', 'yyyymmdd'), 0) ,-12) and  date_add(to_date('${bizdate}' ,'yyyymmdd') ,0)
--         ) as a
-- left join  ${pdm_risk}.pdm_risk_dz_model_limit_all_tmp as b
-- on      a.uid = b.uid
-- and     a.bsy_typ = b.bsy_typ
-- and     a.ds = b.day_dff1
-- union all
-- select  a.uid
--         ,a.biz_no
--         ,a.biz_typ
--         ,a.bsy_typ
--         ,a.time
--         ,a.ord_stt
--         ,a.stg_stt
--         ,a.prc_amt
--         ,b.rsk_adt_lmt
--         ,b.rsk_avl_lmt
--         ,a.ds
-- from    (
--             select  uid
--                     ,stg_pln_no as biz_no
--                     ,'pln' as biz_typ
--                     ,bsy_typ
--                     ,rep_tim as time
--                     ,date(rep_tim) as ds
--                     ,null as ord_stt
--                     ,stg_stt
--                     ,prc_amt
--             from    dwa_risk.dwa_risk_f_heavy_stage_plan_basic
--             where   to_date(rep_tim)  between add_months(date_add(to_date('${bizdate}', 'yyyymmdd'), 0) ,-12) and  date_add(to_date('${bizdate}' ,'yyyymmdd') ,0)
--         ) as a
-- left join  ${pdm_risk}.pdm_risk_dz_model_limit_all_tmp as b
-- on      a.uid = b.uid
-- and     a.bsy_typ = b.bsy_typ
-- and     a.ds = b.day_dff1;

insert overwrite table dwa_risk.dwa_risk_tmp_order_stage_account_union_all 
select uid, biz_no, biz_typ, bsy_typ, time,  ord_stt, stg_stt, prc_amt, rsk_adt_lmt, rsk_avl_lmt,ds
from 
(
    select uid, biz_no, biz_typ, bsy_typ, time, ds, ord_stt, stg_stt, prc_amt, rsk_adt_lmt, rsk_avl_lmt
    from  dwa_risk.dwa_risk_tmp_order_stage_account_union_all 
    where ds < date_add(to_date('${bizdate}', 'yyyymmdd'), 0)  -- 防止重试造成的多次重复union
    union all
    select uid, biz_no, biz_typ, bsy_typ, time, ds, ord_stt, stg_stt, prc_amt, rsk_adt_lmt, rsk_avl_lmt
    from dwa_risk.dwa_risk_tmp_order_stage_account_union_ins 
    where ds = date_add(to_date('${bizdate}', 'yyyymmdd'), 0) 
) as a
where ds between date_add(add_months(date_add(to_date('${bizdate}', 'yyyymmdd'), 0) ,-12),1) and date_add(to_date('${bizdate}', 'yyyymmdd'), 0) ;


--------------------------------结果表1------------------------------

-- create table if not exists dwa_risk.dwa_risk_dz_model_lmt_list_lft_rep_tmp
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
-- -- partitioned by (ds string comment '分区字段,格式yyyymmdd')
-- ;



insert overwrite table dwa_risk.dwa_risk_dz_model_lmt_list_lft_rep_tmp 
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
from  (select *
    from dwa_risk.dwa_risk_tmp_order_stage_account_union_ins 
    where ds = date_add(to_date('${bizdate}', 'yyyymmdd'), 0)) as a
left join dwa_risk.dwa_risk_f_heavy_stage_plan_basic as b 
on a.uid=b.uid
group by a.uid,biz_no;



-- drop table if exists ${pdm_risk}.dz_model_temp_account_lmt_feature_sample_lmt_list_lft_rep;
-- create table if not exists ${pdm_risk}.dz_model_temp_account_lmt_feature_sample_lmt_list_lft_rep as
-- insert overwrite table dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_tmp
-- select a.uid,biz_no,a.ds,
--       sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,1))  then b.prc_amt else 0 end) as lft_rep_prc_1m_cash,
--       sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,1)) then b.prc_amt else 0 end) as lft_rep_prc_1m_dcp,
--       sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,1)) then b.prc_amt else 0 end) as lft_rep_prc_1m_hug,
--       sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_cash,
--       sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_dcp,
--       sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_hug,
--       sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_cash,
--       sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_dcp,
--       sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_hug,
--       sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_cash,
--       sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_dcp,
--       sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds and (rep_dte<=add_months(a.ds,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_hug,
--       sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds then b.prc_amt else 0 end) as lft_rep_prc_all_cash,
--       sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds then b.prc_amt else 0 end) as lft_rep_prc_all_dcp,
--       sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds) and to_date(b.ctr_tim) <a.ds then b.prc_amt else 0 end) as lft_rep_prc_all_hug
-- from  (select *
--     from dwa_risk.dwa_risk_tmp_order_stage_account_union_all 
--     where ds < date_add(to_date('${bizdate}', 'yyyymmdd'), 0)) as a
-- left join dwa_risk.dwa_risk_f_heavy_stage_plan_basic as b 
-- on a.uid=b.uid
-- group by a.uid,biz_no,a.ds;


--------------------------------结果表2------------------------------
insert overwrite table dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_tmp
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
    from dwa_risk.dwa_risk_dz_model_lmt_list_lft_rep_tmp
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
    from dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_tmp
    where ds < date_add(to_date('${bizdate}', 'yyyymmdd'), 0)-- 防止重试造成的多次重复union
) as a
where ds >= date_add(add_months(date_add(to_date('${bizdate}', 'yyyymmdd'), 0), -12), 1) -- 剔除过期样本, 否则会越来越大
group by uid, biz_no, ds; -- 其实不用再做groupby, 当天新增的mot样本必然不在历史样本中



drop table if exists dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2;
create table if not exists dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2 as
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
from  dwa_risk.dwa_risk_tmp_order_stage_account_union_all  as a
left join dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_tmp as b
on a.biz_no=b.biz_no;





-------------------- 最新一天的额度 ----------------------
create table if not exists dwa_risk.dwa_risk_dz_model_account_lmt_tmp(
uid  string  comment '客户号',
mdl_dte  string  comment '模型评分日',
rsk_adt_lmt_cash  double  comment 'CASH.BT授信额度',
rsk_avl_lmt_cash  double  comment 'CASH.BT可用额度',
rsk_adt_lmt_dcp  double  comment 'DCP授信额度',
rsk_avl_lmt_dcp  double  comment 'DCP可用额度',
rsk_adt_lmt_hug  double  comment '大额贷授信额度',
rsk_avl_lmt_hug  double  comment '大额贷可用额度'
) comment "用户账户额度表" 
;


insert overwrite table dwa_risk.dwa_risk_dz_model_account_lmt_tmp
select model_data.uid,
       model_data.mdl_dte,
       max(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') then rsk_adt_lmt else NULL end) as  rsk_adt_lmt_cash,
       max(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') then rsk_avl_lmt else NULL end) as  rsk_avl_lmt_cash,
       max(case when b.bsy_typ = 'ENJOY_PAY' then rsk_adt_lmt else NULL end) as  rsk_adt_lmt_dcp,
       max(case when b.bsy_typ = 'ENJOY_PAY' then rsk_avl_lmt else NULL end) as  rsk_avl_lmt_dcp,
       max(case when b.bsy_typ = 'HUGE_LOAN' then rsk_adt_lmt else NULL end) as  rsk_adt_lmt_hug,
       max(case when b.bsy_typ = 'HUGE_LOAN' then rsk_avl_lmt else NULL end) as  rsk_avl_lmt_hug
from   dwa_risk.dwa_risk_f_dz_model_data_base model_data 
left join 
(
--     select uid,
--             account_no as act_no,
--             business_type as bsy_typ,
--             risk_admit_limit as rsk_adt_lmt,
--             risk_available_limit as rsk_avl_lmt,
--             customer_admit_limit as cus_adt_lmt,
--             customer_available_limit as cus_avl_lmt,
--             date_add(to_date('${bizdate}', 'yyyymmdd'), 0) as ds
--     from ${ld_loan}.dim_account_info
--     where business_type in  ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN')
--     and ds = '${bizdate}' and account_channel is not null
    select uid,
            account_no as act_no,
            credit_account_biz_type as bsy_typ,
            latest_risk_credit_limit as rsk_adt_lmt,
            latest_risk_available_limit as rsk_avl_lmt,
            latest_cust_credit_limit as cus_adt_lmt,
            latest_cust_available_limit as cus_avl_lmt,
            date_add(to_date('${bizdate}', 'yyyymmdd'), 0) as ds
    from cdmx.cdmx_dim_credit_account_df
    where credit_account_biz_type in  ('CASH','BALANCE_TRANSFER','ENJOY_PAY','HUGE_LOAN')
    and ds = '${bizdate}' and account_channel is not null
) as b
on model_data.uid = b.uid and date_sub(model_data.mdl_dte,1) = b.ds
group by model_data.uid, model_data.mdl_dte;        

---------------------临时表2----------------------
drop table if exists dwa_risk.dwa_risk_dz_model_account_lft_rep_tmp ;
create table if not exists dwa_risk.dwa_risk_dz_model_account_lft_rep_tmp as 
select model_data.uid, 
       model_data.mdl_dte,
       sum(case when bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,1))  then prc_amt else 0 end) as lft_rep_prc_1m_cash,
       sum(case when bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,1)) then prc_amt else 0 end) as lft_rep_prc_1m_dcp,
       sum(case when bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,1)) then prc_amt else 0 end) as lft_rep_prc_1m_hug,

       sum(case when bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,2)) then prc_amt else 0 end) as lft_rep_prc_2m_cash,
       sum(case when bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,2)) then prc_amt else 0 end) as lft_rep_prc_2m_dcp,
       sum(case when bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,2)) then prc_amt else 0 end) as lft_rep_prc_2m_hug,

       sum(case when bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,3)) then prc_amt else 0 end) as lft_rep_prc_3m_cash,
       sum(case when bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,3)) then prc_amt else 0 end) as lft_rep_prc_3m_dcp,
       sum(case when bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,3)) then prc_amt else 0 end) as lft_rep_prc_3m_hug,

       sum(case when bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,6)) then prc_amt else 0 end) as lft_rep_prc_6m_cash,
       sum(case when bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,6)) then prc_amt else 0 end) as lft_rep_prc_6m_dcp,
       sum(case when bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte and (rep_dte<=add_months(mdl_dte,6)) then prc_amt else 0 end) as lft_rep_prc_6m_hug,

       sum(case when bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte then prc_amt else 0 end) as lft_rep_prc_all_cash,
       sum(case when bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte  then prc_amt else 0 end) as lft_rep_prc_all_dcp,
       sum(case when bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>mdl_dte) and to_date(ctr_tim) <mdl_dte  then prc_amt else 0 end) as lft_rep_prc_all_hug
from 
dwa_risk.dwa_risk_f_dz_model_data_base model_data 
left join dwa_risk.dwa_risk_f_heavy_stage_plan_basic  as b
on model_data.uid = b.uid
group by model_data.uid, model_data.mdl_dte;         

-------------------------临时表3-----------------------
drop table if exists dwa_risk.dwa_risk_dz_model_account_lmt_combine_tmp ;
create table if not exists dwa_risk.dwa_risk_dz_model_account_lmt_combine_tmp as 
select a.uid,
       a.mdl_dte,
      rsk_avl_lmt_cash,
      rsk_avl_lmt_cash/rsk_adt_lmt_cash as rsk_avl_lmt_cash_rate,
      rsk_avl_lmt_dcp,
      rsk_avl_lmt_dcp/rsk_adt_lmt_dcp as rsk_avl_lmt_dcp_rate,
      rsk_avl_lmt_hug,
      rsk_avl_lmt_hug/rsk_adt_lmt_hug as rsk_adt_lmt_hug_rate,
      rsk_avl_lmt_cash/lft_rep_prc_1m_cash as avb_lft_rep_prc_1m_cash_rate,
      rsk_avl_lmt_cash/lft_rep_prc_1m_dcp as avb_lft_rep_prc_1m_dcp_rate,
      rsk_avl_lmt_cash/lft_rep_prc_1m_hug as avb_lft_rep_prc_1m_hug_rate,
      rsk_avl_lmt_cash/lft_rep_prc_2m_cash as avb_lft_rep_prc_2m_cash_rate,
      rsk_avl_lmt_cash/lft_rep_prc_2m_dcp as avb_lft_rep_prc_2m_dcp_rate,
      rsk_avl_lmt_cash/lft_rep_prc_2m_hug as avb_lft_rep_prc_2m_hug_rate,
      rsk_avl_lmt_cash/lft_rep_prc_3m_cash as avb_lft_rep_prc_3m_cash_rate,
      rsk_avl_lmt_cash/lft_rep_prc_3m_dcp as avb_lft_rep_prc_3m_dcp_rate,
      rsk_avl_lmt_cash/lft_rep_prc_3m_hug as avb_lft_rep_prc_3m_hug_rate,
      rsk_avl_lmt_cash/lft_rep_prc_6m_cash as avb_lft_rep_prc_6m_cash_rate,
      rsk_avl_lmt_cash/lft_rep_prc_6m_dcp as avb_lft_rep_prc_6m_dcp_rate,
      rsk_avl_lmt_cash/lft_rep_prc_6m_hug as avb_lft_rep_prc_6m_hug_rate,
      rsk_avl_lmt_cash/lft_rep_prc_all_cash as avb_lft_rep_prc_all_cash_rate,
      rsk_avl_lmt_cash/lft_rep_prc_all_dcp as avb_lft_rep_prc_all_dcp_rate,
      rsk_avl_lmt_cash/lft_rep_prc_all_hug as avb_lft_rep_prc_all_hug_rate
from(
select a.*,
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
 from dwa_risk.dwa_risk_dz_model_account_lmt_tmp as a
       left join dwa_risk.dwa_risk_dz_model_account_lft_rep_tmp as b
       on a.uid = b.uid
) as a;



drop table if exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_1m;
create table if not exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_1m as 
select uid,
      max(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_1m_bt_ch,
      max(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_1m_dcp,
      max(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_1m_hug,
      max(rsk_lmt_rate) as max_rsk_lmt_rate_1m_all,

      min(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_1m_bt_ch,
      min(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_1m_dcp,
      min(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_1m_hug,
      min(rsk_lmt_rate) as min_rsk_lmt_rate_1m_all,

      avg(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_1m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_1m_dcp,
      avg(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_1m_hug,
      avg(rsk_lmt_rate) as avg_rsk_lmt_rate_1m_all,

      max(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_1m_bt_ch,
      max(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_1m_dcp,
      max(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_1m_hug,
      max(rsk_avl_lmt) as max_rsk_avl_lmt_1m_all,

      min(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_1m_bt_ch,
      min(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_1m_dcp,
      min(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_1m_hug,
      min(rsk_avl_lmt) as min_rsk_avl_lmt_1m_all,

      avg(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_1m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_1m_dcp,
      avg(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_1m_hug,
      avg(rsk_avl_lmt) as avg_rsk_avl_lmt_1m_all,

      avg(avl_lmt_lft_rep_prc_1m_cash) as avg_avl_lmt_lft_rep_prc_1m_cash_1m,
      avg(avl_lmt_lft_rep_prc_1m_dcp) as avg_avl_lmt_lft_rep_prc_1m_dcp_1m,
      avg(avl_lmt_lft_rep_prc_1m_hug) as avg_avl_lmt_lft_rep_prc_1m_hug_1m,
      max(avl_lmt_lft_rep_prc_1m_cash) as max_avl_lmt_lft_rep_prc_1m_cash_1m,
      max(avl_lmt_lft_rep_prc_1m_dcp) as max_avl_lmt_lft_rep_prc_1m_dcp_1m,
      max(avl_lmt_lft_rep_prc_1m_hug) as max_avl_lmt_lft_rep_prc_1m_hug_1m,
      min(avl_lmt_lft_rep_prc_1m_cash) as min_avl_lmt_lft_rep_prc_1m_cash_1m,
      min(avl_lmt_lft_rep_prc_1m_dcp) as min_avl_lmt_lft_rep_prc_1m_dcp_1m,
      min(avl_lmt_lft_rep_prc_1m_hug) as min_avl_lmt_lft_rep_prc_1m_hug_1m,

      avg(avl_lmt_lft_rep_prc_2m_cash) as avg_avl_lmt_lft_rep_prc_2m_cash_1m,
      avg(avl_lmt_lft_rep_prc_2m_dcp) as avg_avl_lmt_lft_rep_prc_2m_dcp_1m,
      avg(avl_lmt_lft_rep_prc_2m_hug) as avg_avl_lmt_lft_rep_prc_2m_hug_1m,
      max(avl_lmt_lft_rep_prc_2m_cash) as max_avl_lmt_lft_rep_prc_2m_cash_1m,
      max(avl_lmt_lft_rep_prc_2m_dcp) as max_avl_lmt_lft_rep_prc_2m_dcp_1m,
      max(avl_lmt_lft_rep_prc_2m_hug) as max_avl_lmt_lft_rep_prc_2m_hug_1m,
      min(avl_lmt_lft_rep_prc_2m_cash) as min_avl_lmt_lft_rep_prc_2m_cash_1m,
      min(avl_lmt_lft_rep_prc_2m_dcp) as min_avl_lmt_lft_rep_prc_2m_dcp_1m,
      min(avl_lmt_lft_rep_prc_2m_hug) as min_avl_lmt_lft_rep_prc_2m_hug_1m,
       
      avg(avl_lmt_lft_rep_prc_3m_cash) as avg_avl_lmt_lft_rep_prc_3m_cash_1m,
      avg(avl_lmt_lft_rep_prc_3m_dcp) as avg_avl_lmt_lft_rep_prc_3m_dcp_1m,
      avg(avl_lmt_lft_rep_prc_3m_hug) as avg_avl_lmt_lft_rep_prc_3m_hug_1m,
      max(avl_lmt_lft_rep_prc_3m_cash) as max_avl_lmt_lft_rep_prc_3m_cash_1m,
      max(avl_lmt_lft_rep_prc_3m_dcp) as max_avl_lmt_lft_rep_prc_3m_dcp_1m,
      max(avl_lmt_lft_rep_prc_3m_hug) as max_avl_lmt_lft_rep_prc_3m_hug_1m,
      min(avl_lmt_lft_rep_prc_3m_cash) as min_avl_lmt_lft_rep_prc_3m_cash_1m,
      min(avl_lmt_lft_rep_prc_3m_dcp) as min_avl_lmt_lft_rep_prc_3m_dcp_1m,
      min(avl_lmt_lft_rep_prc_3m_hug) as min_avl_lmt_lft_rep_prc_3m_hug_1m,              

      avg(avl_lmt_lft_rep_prc_6m_cash) as avg_avl_lmt_lft_rep_prc_6m_cash_1m,
      avg(avl_lmt_lft_rep_prc_6m_dcp) as avg_avl_lmt_lft_rep_prc_6m_dcp_1m,
      avg(avl_lmt_lft_rep_prc_6m_hug) as avg_avl_lmt_lft_rep_prc_6m_hug_1m,
      max(avl_lmt_lft_rep_prc_6m_cash) as max_avl_lmt_lft_rep_prc_6m_cash_1m,
      max(avl_lmt_lft_rep_prc_6m_dcp) as max_avl_lmt_lft_rep_prc_6m_dcp_1m,
      max(avl_lmt_lft_rep_prc_6m_hug) as max_avl_lmt_lft_rep_prc_6m_hug_1m,
      min(avl_lmt_lft_rep_prc_6m_cash) as min_avl_lmt_lft_rep_prc_6m_cash_1m,
      min(avl_lmt_lft_rep_prc_6m_dcp) as min_avl_lmt_lft_rep_prc_6m_dcp_1m,
      min(avl_lmt_lft_rep_prc_6m_hug) as min_avl_lmt_lft_rep_prc_6m_hug_1m,

      avg(avl_lmt_lft_rep_prc_all_cash) as avg_avl_lmt_lft_rep_prc_all_cash_1m,
      avg(avl_lmt_lft_rep_prc_all_dcp) as avg_avl_lmt_lft_rep_prc_all_dcp_1m,
      avg(avl_lmt_lft_rep_prc_all_hug) as avg_avl_lmt_lft_rep_prc_all_hug_1m,
      max(avl_lmt_lft_rep_prc_all_cash) as max_avl_lmt_lft_rep_prc_all_cash_1m,
      max(avl_lmt_lft_rep_prc_all_dcp) as max_avl_lmt_lft_rep_prc_all_dcp_1m,
      max(avl_lmt_lft_rep_prc_all_hug) as max_avl_lmt_lft_rep_prc_all_hug_1m,
      min(avl_lmt_lft_rep_prc_all_cash) as min_avl_lmt_lft_rep_prc_all_cash_1m,
      min(avl_lmt_lft_rep_prc_all_dcp) as min_avl_lmt_lft_rep_prc_all_dcp_1m,
      min(avl_lmt_lft_rep_prc_all_hug) as min_avl_lmt_lft_rep_prc_all_hug_1m,
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_rate_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_rate_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_rate_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_rate_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_rate_1m, 

      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_rate_1m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_rate_1m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_rate_1m,
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_cnt_1m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_rate_1m
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

from dwa_risk.dwa_risk_f_dz_model_data_base  model_data 
left join dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2 as b
on model_data.uid=b.uid
where date(b.time) >= add_months(model_data.mdl_dte,-1)
and date(b.time)<model_data.mdl_dte
) as a
group by uid;


drop table if exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_3m;
create table if not exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_3m as 

select uid,
      max(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_3m_bt_ch,
      max(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_3m_dcp,
      max(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_3m_hug,
      max(rsk_lmt_rate) as max_rsk_lmt_rate_3m_all,

      min(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_3m_bt_ch,
      min(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_3m_dcp,
      min(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_3m_hug,
      min(rsk_lmt_rate) as min_rsk_lmt_rate_3m_all,

      avg(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_3m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_3m_dcp,
      avg(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_3m_hug,
      avg(rsk_lmt_rate) as avg_rsk_lmt_rate_3m_all,

      max(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_3m_bt_ch,
      max(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_3m_dcp,
      max(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_3m_hug,
      max(rsk_avl_lmt) as max_rsk_avl_lmt_3m_all,

      min(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_3m_bt_ch,
      min(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_3m_dcp,
      min(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_3m_hug,
      min(rsk_avl_lmt) as min_rsk_avl_lmt_3m_all,

      avg(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_3m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_3m_dcp,
      avg(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_3m_hug,
      avg(rsk_avl_lmt) as avg_rsk_avl_lmt_3m_all,

      avg(avl_lmt_lft_rep_prc_1m_cash) as avg_avl_lmt_lft_rep_prc_1m_cash_3m,
      avg(avl_lmt_lft_rep_prc_1m_dcp) as avg_avl_lmt_lft_rep_prc_1m_dcp_3m,
      avg(avl_lmt_lft_rep_prc_1m_hug) as avg_avl_lmt_lft_rep_prc_1m_hug_3m,
      max(avl_lmt_lft_rep_prc_1m_cash) as max_avl_lmt_lft_rep_prc_1m_cash_3m,
      max(avl_lmt_lft_rep_prc_1m_dcp) as max_avl_lmt_lft_rep_prc_1m_dcp_3m,
      max(avl_lmt_lft_rep_prc_1m_hug) as max_avl_lmt_lft_rep_prc_1m_hug_3m,
      min(avl_lmt_lft_rep_prc_1m_cash) as min_avl_lmt_lft_rep_prc_1m_cash_3m,
      min(avl_lmt_lft_rep_prc_1m_dcp) as min_avl_lmt_lft_rep_prc_1m_dcp_3m,
      min(avl_lmt_lft_rep_prc_1m_hug) as min_avl_lmt_lft_rep_prc_1m_hug_3m,

      avg(avl_lmt_lft_rep_prc_2m_cash) as avg_avl_lmt_lft_rep_prc_2m_cash_3m,
      avg(avl_lmt_lft_rep_prc_2m_dcp) as avg_avl_lmt_lft_rep_prc_2m_dcp_3m,
      avg(avl_lmt_lft_rep_prc_2m_hug) as avg_avl_lmt_lft_rep_prc_2m_hug_3m,
      max(avl_lmt_lft_rep_prc_2m_cash) as max_avl_lmt_lft_rep_prc_2m_cash_3m,
      max(avl_lmt_lft_rep_prc_2m_dcp) as max_avl_lmt_lft_rep_prc_2m_dcp_3m,
      max(avl_lmt_lft_rep_prc_2m_hug) as max_avl_lmt_lft_rep_prc_2m_hug_3m,
      min(avl_lmt_lft_rep_prc_2m_cash) as min_avl_lmt_lft_rep_prc_2m_cash_3m,
      min(avl_lmt_lft_rep_prc_2m_dcp) as min_avl_lmt_lft_rep_prc_2m_dcp_3m,
      min(avl_lmt_lft_rep_prc_2m_hug) as min_avl_lmt_lft_rep_prc_2m_hug_3m,
       
      avg(avl_lmt_lft_rep_prc_3m_cash) as avg_avl_lmt_lft_rep_prc_3m_cash_3m,
      avg(avl_lmt_lft_rep_prc_3m_dcp) as avg_avl_lmt_lft_rep_prc_3m_dcp_3m,
      avg(avl_lmt_lft_rep_prc_3m_hug) as avg_avl_lmt_lft_rep_prc_3m_hug_3m,
      max(avl_lmt_lft_rep_prc_3m_cash) as max_avl_lmt_lft_rep_prc_3m_cash_3m,
      max(avl_lmt_lft_rep_prc_3m_dcp) as max_avl_lmt_lft_rep_prc_3m_dcp_3m,
      max(avl_lmt_lft_rep_prc_3m_hug) as max_avl_lmt_lft_rep_prc_3m_hug_3m,
      min(avl_lmt_lft_rep_prc_3m_cash) as min_avl_lmt_lft_rep_prc_3m_cash_3m,
      min(avl_lmt_lft_rep_prc_3m_dcp) as min_avl_lmt_lft_rep_prc_3m_dcp_3m,
      min(avl_lmt_lft_rep_prc_3m_hug) as min_avl_lmt_lft_rep_prc_3m_hug_3m,              

      avg(avl_lmt_lft_rep_prc_6m_cash) as avg_avl_lmt_lft_rep_prc_6m_cash_3m,
      avg(avl_lmt_lft_rep_prc_6m_dcp) as avg_avl_lmt_lft_rep_prc_6m_dcp_3m,
      avg(avl_lmt_lft_rep_prc_6m_hug) as avg_avl_lmt_lft_rep_prc_6m_hug_3m,
      max(avl_lmt_lft_rep_prc_6m_cash) as max_avl_lmt_lft_rep_prc_6m_cash_3m,
      max(avl_lmt_lft_rep_prc_6m_dcp) as max_avl_lmt_lft_rep_prc_6m_dcp_3m,
      max(avl_lmt_lft_rep_prc_6m_hug) as max_avl_lmt_lft_rep_prc_6m_hug_3m,
      min(avl_lmt_lft_rep_prc_6m_cash) as min_avl_lmt_lft_rep_prc_6m_cash_3m,
      min(avl_lmt_lft_rep_prc_6m_dcp) as min_avl_lmt_lft_rep_prc_6m_dcp_3m,
      min(avl_lmt_lft_rep_prc_6m_hug) as min_avl_lmt_lft_rep_prc_6m_hug_3m,

      avg(avl_lmt_lft_rep_prc_all_cash) as avg_avl_lmt_lft_rep_prc_all_cash_3m,
      avg(avl_lmt_lft_rep_prc_all_dcp) as avg_avl_lmt_lft_rep_prc_all_dcp_3m,
      avg(avl_lmt_lft_rep_prc_all_hug) as avg_avl_lmt_lft_rep_prc_all_hug_3m,
      max(avl_lmt_lft_rep_prc_all_cash) as max_avl_lmt_lft_rep_prc_all_cash_3m,
      max(avl_lmt_lft_rep_prc_all_dcp) as max_avl_lmt_lft_rep_prc_all_dcp_3m,
      max(avl_lmt_lft_rep_prc_all_hug) as max_avl_lmt_lft_rep_prc_all_hug_3m,
      min(avl_lmt_lft_rep_prc_all_cash) as min_avl_lmt_lft_rep_prc_all_cash_3m,
      min(avl_lmt_lft_rep_prc_all_dcp) as min_avl_lmt_lft_rep_prc_all_dcp_3m,
      min(avl_lmt_lft_rep_prc_all_hug) as min_avl_lmt_lft_rep_prc_all_hug_3m,
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_rate_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_rate_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_rate_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_rate_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_rate_3m, 

      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_rate_3m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_rate_3m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_rate_3m,
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_cnt_3m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_rate_3m
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

from dwa_risk.dwa_risk_f_dz_model_data_base  model_data 
left join dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2 as b
on model_data.uid=b.uid
where date(b.time)>= add_months(model_data.mdl_dte,-3)
and date(b.time)<model_data.mdl_dte
) as a
group by uid;


drop table if exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_6m;
create table if not exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_6m as 
select uid,
      max(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_6m_bt_ch,
      max(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_6m_dcp,
      max(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_6m_hug,
      max(rsk_lmt_rate) as max_rsk_lmt_rate_6m_all,

      min(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_6m_bt_ch,
      min(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_6m_dcp,
      min(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_6m_hug,
      min(rsk_lmt_rate) as min_rsk_lmt_rate_6m_all,

      avg(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_6m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_6m_dcp,
      avg(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_6m_hug,
      avg(rsk_lmt_rate) as avg_rsk_lmt_rate_6m_all,

      max(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_6m_bt_ch,
      max(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_6m_dcp,
      max(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_6m_hug,
      max(rsk_avl_lmt) as max_rsk_avl_lmt_6m_all,

      min(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_6m_bt_ch,
      min(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_6m_dcp,
      min(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_6m_hug,
      min(rsk_avl_lmt) as min_rsk_avl_lmt_6m_all,

      avg(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_6m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_6m_dcp,
      avg(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_6m_hug,
      avg(rsk_avl_lmt) as avg_rsk_avl_lmt_6m_all,

      avg(avl_lmt_lft_rep_prc_1m_cash) as avg_avl_lmt_lft_rep_prc_1m_cash_6m,
      avg(avl_lmt_lft_rep_prc_1m_dcp) as avg_avl_lmt_lft_rep_prc_1m_dcp_6m,
      avg(avl_lmt_lft_rep_prc_1m_hug) as avg_avl_lmt_lft_rep_prc_1m_hug_6m,
      max(avl_lmt_lft_rep_prc_1m_cash) as max_avl_lmt_lft_rep_prc_1m_cash_6m,
      max(avl_lmt_lft_rep_prc_1m_dcp) as max_avl_lmt_lft_rep_prc_1m_dcp_6m,
      max(avl_lmt_lft_rep_prc_1m_hug) as max_avl_lmt_lft_rep_prc_1m_hug_6m,
      min(avl_lmt_lft_rep_prc_1m_cash) as min_avl_lmt_lft_rep_prc_1m_cash_6m,
      min(avl_lmt_lft_rep_prc_1m_dcp) as min_avl_lmt_lft_rep_prc_1m_dcp_6m,
      min(avl_lmt_lft_rep_prc_1m_hug) as min_avl_lmt_lft_rep_prc_1m_hug_6m,

      avg(avl_lmt_lft_rep_prc_2m_cash) as avg_avl_lmt_lft_rep_prc_2m_cash_6m,
      avg(avl_lmt_lft_rep_prc_2m_dcp) as avg_avl_lmt_lft_rep_prc_2m_dcp_6m,
      avg(avl_lmt_lft_rep_prc_2m_hug) as avg_avl_lmt_lft_rep_prc_2m_hug_6m,
      max(avl_lmt_lft_rep_prc_2m_cash) as max_avl_lmt_lft_rep_prc_2m_cash_6m,
      max(avl_lmt_lft_rep_prc_2m_dcp) as max_avl_lmt_lft_rep_prc_2m_dcp_6m,
      max(avl_lmt_lft_rep_prc_2m_hug) as max_avl_lmt_lft_rep_prc_2m_hug_6m,
      min(avl_lmt_lft_rep_prc_2m_cash) as min_avl_lmt_lft_rep_prc_2m_cash_6m,
      min(avl_lmt_lft_rep_prc_2m_dcp) as min_avl_lmt_lft_rep_prc_2m_dcp_6m,
      min(avl_lmt_lft_rep_prc_2m_hug) as min_avl_lmt_lft_rep_prc_2m_hug_6m,
       
      avg(avl_lmt_lft_rep_prc_3m_cash) as avg_avl_lmt_lft_rep_prc_3m_cash_6m,
      avg(avl_lmt_lft_rep_prc_3m_dcp) as avg_avl_lmt_lft_rep_prc_3m_dcp_6m,
      avg(avl_lmt_lft_rep_prc_3m_hug) as avg_avl_lmt_lft_rep_prc_3m_hug_6m,
      max(avl_lmt_lft_rep_prc_3m_cash) as max_avl_lmt_lft_rep_prc_3m_cash_6m,
      max(avl_lmt_lft_rep_prc_3m_dcp) as max_avl_lmt_lft_rep_prc_3m_dcp_6m,
      max(avl_lmt_lft_rep_prc_3m_hug) as max_avl_lmt_lft_rep_prc_3m_hug_6m,
      min(avl_lmt_lft_rep_prc_3m_cash) as min_avl_lmt_lft_rep_prc_3m_cash_6m,
      min(avl_lmt_lft_rep_prc_3m_dcp) as min_avl_lmt_lft_rep_prc_3m_dcp_6m,
      min(avl_lmt_lft_rep_prc_3m_hug) as min_avl_lmt_lft_rep_prc_3m_hug_6m,              

      avg(avl_lmt_lft_rep_prc_6m_cash) as avg_avl_lmt_lft_rep_prc_6m_cash_6m,
      avg(avl_lmt_lft_rep_prc_6m_dcp) as avg_avl_lmt_lft_rep_prc_6m_dcp_6m,
      avg(avl_lmt_lft_rep_prc_6m_hug) as avg_avl_lmt_lft_rep_prc_6m_hug_6m,
      max(avl_lmt_lft_rep_prc_6m_cash) as max_avl_lmt_lft_rep_prc_6m_cash_6m,
      max(avl_lmt_lft_rep_prc_6m_dcp) as max_avl_lmt_lft_rep_prc_6m_dcp_6m,
      max(avl_lmt_lft_rep_prc_6m_hug) as max_avl_lmt_lft_rep_prc_6m_hug_6m,
      min(avl_lmt_lft_rep_prc_6m_cash) as min_avl_lmt_lft_rep_prc_6m_cash_6m,
      min(avl_lmt_lft_rep_prc_6m_dcp) as min_avl_lmt_lft_rep_prc_6m_dcp_6m,
      min(avl_lmt_lft_rep_prc_6m_hug) as min_avl_lmt_lft_rep_prc_6m_hug_6m,

      avg(avl_lmt_lft_rep_prc_all_cash) as avg_avl_lmt_lft_rep_prc_all_cash_6m,
      avg(avl_lmt_lft_rep_prc_all_dcp) as avg_avl_lmt_lft_rep_prc_all_dcp_6m,
      avg(avl_lmt_lft_rep_prc_all_hug) as avg_avl_lmt_lft_rep_prc_all_hug_6m,
      max(avl_lmt_lft_rep_prc_all_cash) as max_avl_lmt_lft_rep_prc_all_cash_6m,
      max(avl_lmt_lft_rep_prc_all_dcp) as max_avl_lmt_lft_rep_prc_all_dcp_6m,
      max(avl_lmt_lft_rep_prc_all_hug) as max_avl_lmt_lft_rep_prc_all_hug_6m,
      min(avl_lmt_lft_rep_prc_all_cash) as min_avl_lmt_lft_rep_prc_all_cash_6m,
      min(avl_lmt_lft_rep_prc_all_dcp) as min_avl_lmt_lft_rep_prc_all_dcp_6m,
      min(avl_lmt_lft_rep_prc_all_hug) as min_avl_lmt_lft_rep_prc_all_hug_6m,
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_rate_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_rate_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_rate_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_rate_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_rate_6m, 

      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_rate_6m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_rate_6m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_rate_6m,
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_cnt_6m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_rate_6m
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

from dwa_risk.dwa_risk_f_dz_model_data_base  model_data 
left join dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2 as b
on model_data.uid=b.uid
where date(b.time) >= add_months(model_data.mdl_dte,-6)
and date(b.time)<model_data.mdl_dte
) as a
group by uid;


drop table if exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_12m;
create table if not exists  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_12m as 
select uid,
      max(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_12m_bt_ch,
      max(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_12m_dcp,
      max(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as max_rsk_lmt_rate_12m_hug,
      max(rsk_lmt_rate) as max_rsk_lmt_rate_12m_all,

      min(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_12m_bt_ch,
      min(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_12m_dcp,
      min(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as min_rsk_lmt_rate_12m_hug,
      min(rsk_lmt_rate) as min_rsk_lmt_rate_12m_all,

      avg(case when bsy_ch_bt=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_12m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_12m_dcp,
      avg(case when bsy_hug=1 then rsk_lmt_rate else NULL end) as avg_rsk_lmt_rate_12m_hug,
      avg(rsk_lmt_rate) as avg_rsk_lmt_rate_12m_all,

      max(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_12m_bt_ch,
      max(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_12m_dcp,
      max(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as max_rsk_avl_lmt_12m_hug,
      max(rsk_avl_lmt) as max_rsk_avl_lmt_12m_all,

      min(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_12m_bt_ch,
      min(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_12m_dcp,
      min(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as min_rsk_avl_lmt_12m_hug,
      min(rsk_avl_lmt) as min_rsk_avl_lmt_12m_all,

      avg(case when bsy_ch_bt=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_12m_bt_ch,
      avg(case when bsy_dcp=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_12m_dcp,
      avg(case when bsy_hug=1 then rsk_avl_lmt else NULL end) as avg_rsk_avl_lmt_12m_hug,
      avg(rsk_avl_lmt) as avg_rsk_avl_lmt_12m_all,
      avg(avl_lmt_lft_rep_prc_1m_cash) as avg_avl_lmt_lft_rep_prc_1m_cash_12m,
      avg(avl_lmt_lft_rep_prc_1m_dcp) as avg_avl_lmt_lft_rep_prc_1m_dcp_12m,
      avg(avl_lmt_lft_rep_prc_1m_hug) as avg_avl_lmt_lft_rep_prc_1m_hug_12m,
      max(avl_lmt_lft_rep_prc_1m_cash) as max_avl_lmt_lft_rep_prc_1m_cash_12m,
      max(avl_lmt_lft_rep_prc_1m_dcp) as max_avl_lmt_lft_rep_prc_1m_dcp_12m,
      max(avl_lmt_lft_rep_prc_1m_hug) as max_avl_lmt_lft_rep_prc_1m_hug_12m,
      min(avl_lmt_lft_rep_prc_1m_cash) as min_avl_lmt_lft_rep_prc_1m_cash_12m,
      min(avl_lmt_lft_rep_prc_1m_dcp) as min_avl_lmt_lft_rep_prc_1m_dcp_12m,
      min(avl_lmt_lft_rep_prc_1m_hug) as min_avl_lmt_lft_rep_prc_1m_hug_12m,

      avg(avl_lmt_lft_rep_prc_2m_cash) as avg_avl_lmt_lft_rep_prc_2m_cash_12m,
      avg(avl_lmt_lft_rep_prc_2m_dcp) as avg_avl_lmt_lft_rep_prc_2m_dcp_12m,
      avg(avl_lmt_lft_rep_prc_2m_hug) as avg_avl_lmt_lft_rep_prc_2m_hug_12m,
      max(avl_lmt_lft_rep_prc_2m_cash) as max_avl_lmt_lft_rep_prc_2m_cash_12m,
      max(avl_lmt_lft_rep_prc_2m_dcp) as max_avl_lmt_lft_rep_prc_2m_dcp_12m,
      max(avl_lmt_lft_rep_prc_2m_hug) as max_avl_lmt_lft_rep_prc_2m_hug_12m,
      min(avl_lmt_lft_rep_prc_2m_cash) as min_avl_lmt_lft_rep_prc_2m_cash_12m,
      min(avl_lmt_lft_rep_prc_2m_dcp) as min_avl_lmt_lft_rep_prc_2m_dcp_12m,
      min(avl_lmt_lft_rep_prc_2m_hug) as min_avl_lmt_lft_rep_prc_2m_hug_12m,
       
      avg(avl_lmt_lft_rep_prc_3m_cash) as avg_avl_lmt_lft_rep_prc_3m_cash_12m,
      avg(avl_lmt_lft_rep_prc_3m_dcp) as avg_avl_lmt_lft_rep_prc_3m_dcp_12m,
      avg(avl_lmt_lft_rep_prc_3m_hug) as avg_avl_lmt_lft_rep_prc_3m_hug_12m,
      max(avl_lmt_lft_rep_prc_3m_cash) as max_avl_lmt_lft_rep_prc_3m_cash_12m,
      max(avl_lmt_lft_rep_prc_3m_dcp) as max_avl_lmt_lft_rep_prc_3m_dcp_12m,
      max(avl_lmt_lft_rep_prc_3m_hug) as max_avl_lmt_lft_rep_prc_3m_hug_12m,
      min(avl_lmt_lft_rep_prc_3m_cash) as min_avl_lmt_lft_rep_prc_3m_cash_12m,
      min(avl_lmt_lft_rep_prc_3m_dcp) as min_avl_lmt_lft_rep_prc_3m_dcp_12m,
      min(avl_lmt_lft_rep_prc_3m_hug) as min_avl_lmt_lft_rep_prc_3m_hug_12m,              

      avg(avl_lmt_lft_rep_prc_6m_cash) as avg_avl_lmt_lft_rep_prc_6m_cash_12m,
      avg(avl_lmt_lft_rep_prc_6m_dcp) as avg_avl_lmt_lft_rep_prc_6m_dcp_12m,
      avg(avl_lmt_lft_rep_prc_6m_hug) as avg_avl_lmt_lft_rep_prc_6m_hug_12m,
      max(avl_lmt_lft_rep_prc_6m_cash) as max_avl_lmt_lft_rep_prc_6m_cash_12m,
      max(avl_lmt_lft_rep_prc_6m_dcp) as max_avl_lmt_lft_rep_prc_6m_dcp_12m,
      max(avl_lmt_lft_rep_prc_6m_hug) as max_avl_lmt_lft_rep_prc_6m_hug_12m,
      min(avl_lmt_lft_rep_prc_6m_cash) as min_avl_lmt_lft_rep_prc_6m_cash_12m,
      min(avl_lmt_lft_rep_prc_6m_dcp) as min_avl_lmt_lft_rep_prc_6m_dcp_12m,
      min(avl_lmt_lft_rep_prc_6m_hug) as min_avl_lmt_lft_rep_prc_6m_hug_12m,

      avg(avl_lmt_lft_rep_prc_all_cash) as avg_avl_lmt_lft_rep_prc_all_cash_12m,
      avg(avl_lmt_lft_rep_prc_all_dcp) as avg_avl_lmt_lft_rep_prc_all_dcp_12m,
      avg(avl_lmt_lft_rep_prc_all_hug) as avg_avl_lmt_lft_rep_prc_all_hug_12m,
      max(avl_lmt_lft_rep_prc_all_cash) as max_avl_lmt_lft_rep_prc_all_cash_12m,
      max(avl_lmt_lft_rep_prc_all_dcp) as max_avl_lmt_lft_rep_prc_all_dcp_12m,
      max(avl_lmt_lft_rep_prc_all_hug) as max_avl_lmt_lft_rep_prc_all_hug_12m,
      min(avl_lmt_lft_rep_prc_all_cash) as min_avl_lmt_lft_rep_prc_all_cash_12m,
      min(avl_lmt_lft_rep_prc_all_dcp) as min_avl_lmt_lft_rep_prc_all_dcp_12m,
      min(avl_lmt_lft_rep_prc_all_hug) as min_avl_lmt_lft_rep_prc_all_hug_12m,
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.95 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p95_rate_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.9 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p9_rate_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.8 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p8_rate_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate>0.5 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p5_rate_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_lmt_rate<0.2 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_lmt_rate_ch_1m_grt_0p2_rate_12m, 

      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<500 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_500_rate_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<1000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_1000_rate_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<5000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_5000_rate_12m,
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_cnt_12m, 
      count(case when bsy_ch_bt=1 and rsk_avl_lmt<10000 then 1 else NULL end)/count(case when bsy_ch_bt=1 then 1 else NULL end) as rsk_avl_lmt_ch_1m_les_10000_rate_12m

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

from dwa_risk.dwa_risk_f_dz_model_data_base  model_data 
left join dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_lmt_list_v2 as b
on model_data.uid=b.uid
where date(b.time) >= add_months(model_data.mdl_dte,-12)
and date(b.time)<model_data.mdl_dte
) as a
group by uid;

--------------------------最终结果表--------------------
-- create table if not exists dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_all_final_df 
-- (
-- uid string comment 'uid',
-- mdl_dte string comment '模型日期',
-- rsk_avl_lmt_cash decimal(38,16) comment '现金贷可用额度(BT/CASH)',
-- rsk_avl_lmt_cash_rate decimal(38,16) comment '现金贷可用额度(BT/CASH)占比(可用额度/授信额度)',
-- rsk_avl_lmt_dcp decimal(38,16) comment 'DCP可用额度',
-- rsk_avl_lmt_dcp_rate decimal(38,16) comment 'DCP可用额度占比(可用额度/授信额度)',
-- rsk_avl_lmt_hug decimal(38,16) comment '大额贷可用额度',
-- rsk_adt_lmt_hug_rate decimal(38,16) comment '大额贷可用额度占比(可用额度/授信额度)',
-- avb_lft_rep_prc_1m_cash_rate decimal(38,16) comment '现金贷可用额度',
-- avb_lft_rep_prc_1m_dcp_rate decimal(38,16) comment 'DCP可用额度',
-- avb_lft_rep_prc_1m_hug_rate decimal(38,16) comment '大额贷可用额度',
-- avb_lft_rep_prc_2m_cash_rate decimal(38,16) comment '现金贷可用额度',
-- avb_lft_rep_prc_2m_dcp_rate decimal(38,16) comment 'DCP可用额度',
-- avb_lft_rep_prc_2m_hug_rate decimal(38,16) comment '大额贷可用额度',
-- avb_lft_rep_prc_3m_cash_rate decimal(38,16) comment '现金贷可用额度',
-- avb_lft_rep_prc_3m_dcp_rate decimal(38,16) comment 'DCP可用额度',
-- avb_lft_rep_prc_3m_hug_rate decimal(38,16) comment '大额贷可用额度',
-- avb_lft_rep_prc_6m_cash_rate decimal(38,16) comment '现金贷可用额度',
-- avb_lft_rep_prc_6m_dcp_rate decimal(38,16) comment 'DCP可用额度',
-- avb_lft_rep_prc_6m_hug_rate decimal(38,16) comment '大额贷可用额度',
-- avb_lft_rep_prc_all_cash_rate decimal(38,16) comment '现金贷可用额度',
-- avb_lft_rep_prc_all_dcp_rate decimal(38,16) comment 'DCP可用额度',
-- avb_lft_rep_prc_all_hug_rate decimal(38,16) comment '大额贷可用额度',
-- max_rsk_lmt_rate_1m_bt_ch decimal(38,16) comment '近1个月现金贷占比额度使用率',
-- max_rsk_lmt_rate_1m_dcp decimal(38,16) comment '近1个月DCP占比额度使用率',
-- max_rsk_lmt_rate_1m_hug decimal(38,16) comment '近1个月大额贷占比额度使用率',
-- max_rsk_lmt_rate_1m_all decimal(38,16) comment '近1个月占比额度使用率',
-- min_rsk_lmt_rate_1m_bt_ch decimal(38,16) comment '近1个月现金贷最小额度使用率',
-- min_rsk_lmt_rate_1m_dcp decimal(38,16) comment '近1个月DCP最小额度使用率',
-- min_rsk_lmt_rate_1m_hug decimal(38,16) comment '近1个月大额贷最小额度使用率',
-- min_rsk_lmt_rate_1m_all decimal(38,16) comment '近1个月最小额度使用率',
-- avg_rsk_lmt_rate_1m_bt_ch decimal(38,16) comment '近1个月现金贷平均额度使用率',
-- avg_rsk_lmt_rate_1m_dcp decimal(38,16) comment '近1个月DCP平均额度使用率',
-- avg_rsk_lmt_rate_1m_hug decimal(38,16) comment '近1个月大额贷平均额度使用率',
-- avg_rsk_lmt_rate_1m_all decimal(38,16) comment '近1个月平均额度使用率',
-- max_rsk_avl_lmt_1m_bt_ch decimal(38,16) comment '近1个月现金贷最大可用额度',
-- max_rsk_avl_lmt_1m_dcp decimal(38,16) comment '近1个月DCP最大可用额度',
-- max_rsk_avl_lmt_1m_hug decimal(38,16) comment '近1个月大额贷最大可用额度',
-- max_rsk_avl_lmt_1m_all decimal(38,16) comment '近1个月最大可用额度',
-- min_rsk_avl_lmt_1m_bt_ch decimal(38,16) comment '近1个月现金贷最小可用额度',
-- min_rsk_avl_lmt_1m_dcp decimal(38,16) comment '近1个月DCP最小可用额度',
-- min_rsk_avl_lmt_1m_hug decimal(38,16) comment '近1个月大额贷最小可用额度',
-- min_rsk_avl_lmt_1m_all decimal(38,16) comment '近1个月最小可用额度',
-- avg_rsk_avl_lmt_1m_bt_ch decimal(38,16) comment '近1个月现金贷平均可用额度',
-- avg_rsk_avl_lmt_1m_dcp decimal(38,16) comment '近1个月DCP平均可用额度',
-- avg_rsk_avl_lmt_1m_hug decimal(38,16) comment '近1个月大额贷平均可用额度',
-- avg_rsk_avl_lmt_1m_all decimal(38,16) comment '近1个月平均可用额度',
-- avg_avl_lmt_lft_rep_prc_1m_cash_1m decimal(38,16) comment '近1个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_dcp_1m decimal(38,16) comment '近1个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_hug_1m decimal(38,16) comment '近1个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_cash_1m decimal(38,16) comment '近1个月现金贷最大指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_dcp_1m decimal(38,16) comment '近1个月DCP最大指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_hug_1m decimal(38,16) comment '近1个月大额贷最大指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_cash_1m decimal(38,16) comment '近1个月现金贷最小指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_dcp_1m decimal(38,16) comment '近1个月DCP最小指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_hug_1m decimal(38,16) comment '近1个月大额贷最小指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_cash_1m decimal(38,16) comment '近1个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_dcp_1m decimal(38,16) comment '近1个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_hug_1m decimal(38,16) comment '近1个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_cash_1m decimal(38,16) comment '近1个月现金贷最大指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_dcp_1m decimal(38,16) comment '近1个月DCP最大指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_hug_1m decimal(38,16) comment '近1个月大额贷最大指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_cash_1m decimal(38,16) comment '近1个月现金贷最小指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_dcp_1m decimal(38,16) comment '近1个月DCP最小指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_hug_1m decimal(38,16) comment '近1个月大额贷最小指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_cash_1m decimal(38,16) comment '近1个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_dcp_1m decimal(38,16) comment '近1个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_hug_1m decimal(38,16) comment '近1个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_cash_1m decimal(38,16) comment '近1个月现金贷最大指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_dcp_1m decimal(38,16) comment '近1个月DCP最大指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_hug_1m decimal(38,16) comment '近1个月大额贷最大指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_cash_1m decimal(38,16) comment '近1个月现金贷最小指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_dcp_1m decimal(38,16) comment '近1个月DCP最小指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_hug_1m decimal(38,16) comment '近1个月大额贷最小指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_cash_1m decimal(38,16) comment '近1个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_dcp_1m decimal(38,16) comment '近1个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_hug_1m decimal(38,16) comment '近1个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_cash_1m decimal(38,16) comment '近1个月现金贷最大指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_dcp_1m decimal(38,16) comment '近1个月DCP最大指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_hug_1m decimal(38,16) comment '近1个月大额贷最大指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_cash_1m decimal(38,16) comment '近1个月现金贷最小指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_dcp_1m decimal(38,16) comment '近1个月DCP最小指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_hug_1m decimal(38,16) comment '近1个月大额贷最小指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_cash_1m decimal(38,16) comment '近1个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_dcp_1m decimal(38,16) comment '近1个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_hug_1m decimal(38,16) comment '近1个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_cash_1m decimal(38,16) comment '近1个月现金贷最大指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_dcp_1m decimal(38,16) comment '近1个月DCP最大指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_hug_1m decimal(38,16) comment '近1个月大额贷最大指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_cash_1m decimal(38,16) comment '近1个月现金贷最小指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_dcp_1m decimal(38,16) comment '近1个月DCP最小指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_hug_1m decimal(38,16) comment '近1个月大额贷最小指标值(可用额度/未来剩余应还金额)',
-- rsk_lmt_rate_ch_1m_grt_0p95_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.95的次数',
-- rsk_lmt_rate_ch_1m_grt_0p95_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.95的占比',
-- rsk_lmt_rate_ch_1m_grt_0p9_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.9的次数',
-- rsk_lmt_rate_ch_1m_grt_0p9_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.9的占比',
-- rsk_lmt_rate_ch_1m_grt_0p8_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.8的次数',
-- rsk_lmt_rate_ch_1m_grt_0p8_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.8的占比',
-- rsk_lmt_rate_ch_1m_grt_0p5_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.5的次数',
-- rsk_lmt_rate_ch_1m_grt_0p5_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.5的占比',
-- rsk_lmt_rate_ch_1m_grt_0p2_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.2的次数',
-- rsk_lmt_rate_ch_1m_grt_0p2_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率超过0.2的占比',
-- rsk_avl_lmt_ch_1m_les_500_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于500的次数',
-- rsk_avl_lmt_ch_1m_les_500_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于500的占比',
-- rsk_avl_lmt_ch_1m_les_1000_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于1000的次数',
-- rsk_avl_lmt_ch_1m_les_1000_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于1000的占比',
-- rsk_avl_lmt_ch_1m_les_5000_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于5000的次数',
-- rsk_avl_lmt_ch_1m_les_5000_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于5000的占比',
-- rsk_avl_lmt_ch_1m_les_10000_cnt_1m decimal(38,16) comment '近1个月现金贷额度使用率小于10000的次数',
-- rsk_avl_lmt_ch_1m_les_10000_rate_1m decimal(38,16) comment '近1个月现金贷额度使用率小于10000的占比',
-- max_rsk_lmt_rate_3m_bt_ch decimal(38,16) comment '近3个月现金贷最大额度使用率',
-- max_rsk_lmt_rate_3m_dcp decimal(38,16) comment '近3个月DCP最大额度使用率',
-- max_rsk_lmt_rate_3m_hug decimal(38,16) comment '近3个月大额贷最大额度使用率',
-- max_rsk_lmt_rate_3m_all decimal(38,16) comment '近3个月最大额度使用率',
-- min_rsk_lmt_rate_3m_bt_ch decimal(38,16) comment '近3个月现金贷最小额度使用率',
-- min_rsk_lmt_rate_3m_dcp decimal(38,16) comment '近3个月DCP最小额度使用率',
-- min_rsk_lmt_rate_3m_hug decimal(38,16) comment '近3个月大额贷最小额度使用率',
-- min_rsk_lmt_rate_3m_all decimal(38,16) comment '近3个月最小额度使用率',
-- avg_rsk_lmt_rate_3m_bt_ch decimal(38,16) comment '近3个月现金贷平均额度使用率',
-- avg_rsk_lmt_rate_3m_dcp decimal(38,16) comment '近3个月DCP平均额度使用率',
-- avg_rsk_lmt_rate_3m_hug decimal(38,16) comment '近3个月大额贷平均额度使用率',
-- avg_rsk_lmt_rate_3m_all decimal(38,16) comment '近3个月平均额度使用率',
-- max_rsk_avl_lmt_3m_bt_ch decimal(38,16) comment '近3个月现金贷最大可用额度',
-- max_rsk_avl_lmt_3m_dcp decimal(38,16) comment '近3个月DCP最大可用额度',
-- max_rsk_avl_lmt_3m_hug decimal(38,16) comment '近3个月大额贷最大可用额度',
-- max_rsk_avl_lmt_3m_all decimal(38,16) comment '近3个月最大可用额度',
-- min_rsk_avl_lmt_3m_bt_ch decimal(38,16) comment '近3个月现金贷最小可用额度',
-- min_rsk_avl_lmt_3m_dcp decimal(38,16) comment '近3个月DCP最小可用额度',
-- min_rsk_avl_lmt_3m_hug decimal(38,16) comment '近3个月大额贷最小可用额度',
-- min_rsk_avl_lmt_3m_all decimal(38,16) comment '近3个月最小可用额度',
-- avg_rsk_avl_lmt_3m_bt_ch decimal(38,16) comment '近3个月现金贷平均可用额度',
-- avg_rsk_avl_lmt_3m_dcp decimal(38,16) comment '近3个月DCP平均可用额度',
-- avg_rsk_avl_lmt_3m_hug decimal(38,16) comment '近3个月大额贷平均可用额度',
-- avg_rsk_avl_lmt_3m_all decimal(38,16) comment '近3个月平均可用额度',
-- avg_avl_lmt_lft_rep_prc_1m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_cash_3m decimal(38,16) comment '近3个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_dcp_3m decimal(38,16) comment '近3个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_hug_3m decimal(38,16) comment '近3个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- rsk_lmt_rate_ch_1m_grt_0p95_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.95的次数',
-- rsk_lmt_rate_ch_1m_grt_0p95_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.95的占比',
-- rsk_lmt_rate_ch_1m_grt_0p9_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.9的次数',
-- rsk_lmt_rate_ch_1m_grt_0p9_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.9的占比',
-- rsk_lmt_rate_ch_1m_grt_0p8_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.8的次数',
-- rsk_lmt_rate_ch_1m_grt_0p8_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.8的占比',
-- rsk_lmt_rate_ch_1m_grt_0p5_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.5的次数',
-- rsk_lmt_rate_ch_1m_grt_0p5_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.5的占比',
-- rsk_lmt_rate_ch_1m_grt_0p2_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.2的次数',
-- rsk_lmt_rate_ch_1m_grt_0p2_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率超过0.2的占比',
-- rsk_avl_lmt_ch_1m_les_500_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于500的次数',
-- rsk_avl_lmt_ch_1m_les_500_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于500的占比',
-- rsk_avl_lmt_ch_1m_les_1000_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于1000的次数',
-- rsk_avl_lmt_ch_1m_les_1000_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于1000的占比',
-- rsk_avl_lmt_ch_1m_les_5000_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于5000的次数',
-- rsk_avl_lmt_ch_1m_les_5000_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于5000的占比',
-- rsk_avl_lmt_ch_1m_les_10000_cnt_3m decimal(38,16) comment '近3个月现金贷额度使用率小于10000的次数',
-- rsk_avl_lmt_ch_1m_les_10000_rate_3m decimal(38,16) comment '近3个月现金贷额度使用率小于10000的占比',
-- max_rsk_lmt_rate_6m_bt_ch decimal(38,16) comment '近6个月现金贷占比额度使用率',
-- max_rsk_lmt_rate_6m_dcp decimal(38,16) comment '近6个月DCP占比额度使用率',
-- max_rsk_lmt_rate_6m_hug decimal(38,16) comment '近6个月大额贷占比额度使用率',
-- max_rsk_lmt_rate_6m_all decimal(38,16) comment '近6个月现金贷占比额度使用率',
-- min_rsk_lmt_rate_6m_bt_ch decimal(38,16) comment '近6个月现金贷最小额度使用率',
-- min_rsk_lmt_rate_6m_dcp decimal(38,16) comment '近6个月DCP最小额度使用率',
-- min_rsk_lmt_rate_6m_hug decimal(38,16) comment '近6个月大额贷最小额度使用率',
-- min_rsk_lmt_rate_6m_all decimal(38,16) comment '近6个月现金贷最小额度使用率',
-- avg_rsk_lmt_rate_6m_bt_ch decimal(38,16) comment '近6个月现金贷平均额度使用率',
-- avg_rsk_lmt_rate_6m_dcp decimal(38,16) comment '近6个月DCP平均额度使用率',
-- avg_rsk_lmt_rate_6m_hug decimal(38,16) comment '近6个月大额贷平均额度使用率',
-- avg_rsk_lmt_rate_6m_all decimal(38,16) comment '近6个月现金贷平均额度使用率',
-- max_rsk_avl_lmt_6m_bt_ch decimal(38,16) comment '近6个月现金贷最大可用额度',
-- max_rsk_avl_lmt_6m_dcp decimal(38,16) comment '近6个月DCP最大可用额度',
-- max_rsk_avl_lmt_6m_hug decimal(38,16) comment '近6个月大额贷最大可用额度',
-- max_rsk_avl_lmt_6m_all decimal(38,16) comment '近6个月现金贷最大可用额度',
-- min_rsk_avl_lmt_6m_bt_ch decimal(38,16) comment '近6个月现金贷最小可用额度',
-- min_rsk_avl_lmt_6m_dcp decimal(38,16) comment '近6个月DCP最小可用额度',
-- min_rsk_avl_lmt_6m_hug decimal(38,16) comment '近6个月大额贷最小可用额度',
-- min_rsk_avl_lmt_6m_all decimal(38,16) comment '近6个月现金贷最小可用额度',
-- avg_rsk_avl_lmt_6m_bt_ch decimal(38,16) comment '近6个月现金贷平均可用额度',
-- avg_rsk_avl_lmt_6m_dcp decimal(38,16) comment '近6个月DCP平均可用额度',
-- avg_rsk_avl_lmt_6m_hug decimal(38,16) comment '近6个月大额贷平均可用额度',
-- avg_rsk_avl_lmt_6m_all decimal(38,16) comment '近6个月现金贷平均可用额度',
-- avg_avl_lmt_lft_rep_prc_1m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_cash_6m decimal(38,16) comment '近6个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_dcp_6m decimal(38,16) comment '近6个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_hug_6m decimal(38,16) comment '近6个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- rsk_lmt_rate_ch_1m_grt_0p95_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.95的次数',
-- rsk_lmt_rate_ch_1m_grt_0p95_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.95的占比',
-- rsk_lmt_rate_ch_1m_grt_0p9_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.9的次数',
-- rsk_lmt_rate_ch_1m_grt_0p9_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.9的占比',
-- rsk_lmt_rate_ch_1m_grt_0p8_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.8的次数',
-- rsk_lmt_rate_ch_1m_grt_0p8_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.8的占比',
-- rsk_lmt_rate_ch_1m_grt_0p5_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.5的次数',
-- rsk_lmt_rate_ch_1m_grt_0p5_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.5的占比',
-- rsk_lmt_rate_ch_1m_grt_0p2_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.2的次数',
-- rsk_lmt_rate_ch_1m_grt_0p2_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率超过0.2的占比',
-- rsk_avl_lmt_ch_1m_les_500_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于500的次数',
-- rsk_avl_lmt_ch_1m_les_500_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于500的占比',
-- rsk_avl_lmt_ch_1m_les_1000_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于1000的次数',
-- rsk_avl_lmt_ch_1m_les_1000_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于1000的占比',
-- rsk_avl_lmt_ch_1m_les_5000_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于5000的次数',
-- rsk_avl_lmt_ch_1m_les_5000_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于5000的占比',
-- rsk_avl_lmt_ch_1m_les_10000_cnt_6m decimal(38,16) comment '近6个月现金贷额度使用率小于10000的次数',
-- rsk_avl_lmt_ch_1m_les_10000_rate_6m decimal(38,16) comment '近6个月现金贷额度使用率小于10000的占比',
-- max_rsk_lmt_rate_12m_bt_ch decimal(38,16) comment '近12个月现金贷占比额度使用率',
-- max_rsk_lmt_rate_12m_dcp decimal(38,16) comment '近12个月DCP占比额度使用率',
-- max_rsk_lmt_rate_12m_hug decimal(38,16) comment '近12个月大额贷占比额度使用率',
-- max_rsk_lmt_rate_12m_all decimal(38,16) comment '近12个月现金贷占比额度使用率',
-- min_rsk_lmt_rate_12m_bt_ch decimal(38,16) comment '近12个月现金贷最小额度使用率',
-- min_rsk_lmt_rate_12m_dcp decimal(38,16) comment '近12个月DCP最小额度使用率',
-- min_rsk_lmt_rate_12m_hug decimal(38,16) comment '近12个月大额贷最小额度使用率',
-- min_rsk_lmt_rate_12m_all decimal(38,16) comment '近12个月现金贷最小额度使用率',
-- avg_rsk_lmt_rate_12m_bt_ch decimal(38,16) comment '近12个月现金贷平均额度使用率',
-- avg_rsk_lmt_rate_12m_dcp decimal(38,16) comment '近12个月DCP平均额度使用率',
-- avg_rsk_lmt_rate_12m_hug decimal(38,16) comment '近12个月大额贷平均额度使用率',
-- avg_rsk_lmt_rate_12m_all decimal(38,16) comment '近12个月现金贷平均额度使用率',
-- max_rsk_avl_lmt_12m_bt_ch decimal(38,16) comment '近12个月现金贷最大可用额度',
-- max_rsk_avl_lmt_12m_dcp decimal(38,16) comment '近12个月DCP最大可用额度',
-- max_rsk_avl_lmt_12m_hug decimal(38,16) comment '近12个月大额贷最大可用额度',
-- max_rsk_avl_lmt_12m_all decimal(38,16) comment '近12个月现金贷最大可用额度',
-- min_rsk_avl_lmt_12m_bt_ch decimal(38,16) comment '近12个月现金贷最小可用额度',
-- min_rsk_avl_lmt_12m_dcp decimal(38,16) comment '近12个月DCP最小可用额度',
-- min_rsk_avl_lmt_12m_hug decimal(38,16) comment '近12个月大额贷最小可用额度',
-- min_rsk_avl_lmt_12m_all decimal(38,16) comment '近12个月现金贷最小可用额度',
-- avg_rsk_avl_lmt_12m_bt_ch decimal(38,16) comment '近12个月现金贷平均可用额度',
-- avg_rsk_avl_lmt_12m_dcp decimal(38,16) comment '近12个月DCP平均可用额度',
-- avg_rsk_avl_lmt_12m_hug decimal(38,16) comment '近12个月大额贷平均可用额度',
-- avg_rsk_avl_lmt_12m_all decimal(38,16) comment '近12个月现金贷平均可用额度',
-- avg_avl_lmt_lft_rep_prc_1m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_1m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_1m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来1个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_1m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来1个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_2m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_2m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来2个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_2m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_3m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_3m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来3个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_3m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来3个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来2个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_6m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_6m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来6个月剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_6m_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来6个月剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- avg_avl_lmt_lft_rep_prc_all_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- max_avl_lmt_lft_rep_prc_all_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_cash_12m decimal(38,16) comment '近12个月现金贷平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_dcp_12m decimal(38,16) comment '近12个月DCP平均指标值(可用额度/未来剩余应还金额)',
-- min_avl_lmt_lft_rep_prc_all_hug_12m decimal(38,16) comment '近12个月大额贷平均指标值(可用额度/未来剩余应还金额)',
-- rsk_lmt_rate_ch_1m_grt_0p95_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.95的次数',
-- rsk_lmt_rate_ch_1m_grt_0p95_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.95的占比',
-- rsk_lmt_rate_ch_1m_grt_0p9_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.9的次数',
-- rsk_lmt_rate_ch_1m_grt_0p9_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.9的占比',
-- rsk_lmt_rate_ch_1m_grt_0p8_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.8的次数',
-- rsk_lmt_rate_ch_1m_grt_0p8_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.8的占比',
-- rsk_lmt_rate_ch_1m_grt_0p5_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.5的次数',
-- rsk_lmt_rate_ch_1m_grt_0p5_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.5的占比',
-- rsk_lmt_rate_ch_1m_grt_0p2_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.2的次数',
-- rsk_lmt_rate_ch_1m_grt_0p2_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率超过0.2的占比',
-- rsk_avl_lmt_ch_1m_les_500_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率小于500的次数',
-- rsk_avl_lmt_ch_1m_les_500_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率小于500的占比',
-- rsk_avl_lmt_ch_1m_les_1000_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率小于1000的次数',
-- rsk_avl_lmt_ch_1m_les_1000_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率小于1000的占比',
-- rsk_avl_lmt_ch_1m_les_5000_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率小于5000的次数',
-- rsk_avl_lmt_ch_1m_les_5000_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率小于5000的占比',
-- rsk_avl_lmt_ch_1m_les_10000_cnt_12m decimal(38,16) comment '近2个月现金贷额度使用率小于10000的次数',
-- rsk_avl_lmt_ch_1m_les_10000_rate_12m decimal(38,16) comment '近2个月现金贷额度使用率小于10000的占比'
-- ) comment "大宽表额度使用率new" 
-- partitioned by (ds string comment '分区字段,格式yyyymmdd')
-- ;


insert overwrite table dwa_risk.dwa_risk_dz_model_account_lmt_feature_sample_all_final_df partition(ds='${bizdate}')
select 
      a.uid
      ,a.mdl_dte
      ,a.rsk_avl_lmt_cash
      ,a.rsk_avl_lmt_cash_rate
      ,a.rsk_avl_lmt_dcp
      ,a.rsk_avl_lmt_dcp_rate
      ,a.rsk_avl_lmt_hug
      ,a.rsk_adt_lmt_hug_rate
      ,a.avb_lft_rep_prc_1m_cash_rate
      ,a.avb_lft_rep_prc_1m_dcp_rate
      ,a.avb_lft_rep_prc_1m_hug_rate
      ,a.avb_lft_rep_prc_2m_cash_rate
      ,a.avb_lft_rep_prc_2m_dcp_rate
      ,a.avb_lft_rep_prc_2m_hug_rate
      ,a.avb_lft_rep_prc_3m_cash_rate
      ,a.avb_lft_rep_prc_3m_dcp_rate
      ,a.avb_lft_rep_prc_3m_hug_rate
      ,a.avb_lft_rep_prc_6m_cash_rate
      ,a.avb_lft_rep_prc_6m_dcp_rate
      ,a.avb_lft_rep_prc_6m_hug_rate
      ,a.avb_lft_rep_prc_all_cash_rate
      ,a.avb_lft_rep_prc_all_dcp_rate
      ,a.avb_lft_rep_prc_all_hug_rate
      ,max_rsk_lmt_rate_1m_bt_ch
      ,max_rsk_lmt_rate_1m_dcp
      ,max_rsk_lmt_rate_1m_hug
      ,max_rsk_lmt_rate_1m_all
      ,min_rsk_lmt_rate_1m_bt_ch
      ,min_rsk_lmt_rate_1m_dcp
      ,min_rsk_lmt_rate_1m_hug
      ,min_rsk_lmt_rate_1m_all
      ,avg_rsk_lmt_rate_1m_bt_ch
      ,avg_rsk_lmt_rate_1m_dcp
      ,avg_rsk_lmt_rate_1m_hug
      ,avg_rsk_lmt_rate_1m_all
      ,max_rsk_avl_lmt_1m_bt_ch
      ,max_rsk_avl_lmt_1m_dcp
      ,max_rsk_avl_lmt_1m_hug
      ,max_rsk_avl_lmt_1m_all
      ,min_rsk_avl_lmt_1m_bt_ch
      ,min_rsk_avl_lmt_1m_dcp
      ,min_rsk_avl_lmt_1m_hug
      ,min_rsk_avl_lmt_1m_all
      ,avg_rsk_avl_lmt_1m_bt_ch
      ,avg_rsk_avl_lmt_1m_dcp
      ,avg_rsk_avl_lmt_1m_hug
      ,avg_rsk_avl_lmt_1m_all
      ,avg_avl_lmt_lft_rep_prc_1m_cash_1m
      ,avg_avl_lmt_lft_rep_prc_1m_dcp_1m
      ,avg_avl_lmt_lft_rep_prc_1m_hug_1m
      ,max_avl_lmt_lft_rep_prc_1m_cash_1m
      ,max_avl_lmt_lft_rep_prc_1m_dcp_1m
      ,max_avl_lmt_lft_rep_prc_1m_hug_1m
      ,min_avl_lmt_lft_rep_prc_1m_cash_1m
      ,min_avl_lmt_lft_rep_prc_1m_dcp_1m
      ,min_avl_lmt_lft_rep_prc_1m_hug_1m
      ,avg_avl_lmt_lft_rep_prc_2m_cash_1m
      ,avg_avl_lmt_lft_rep_prc_2m_dcp_1m
      ,avg_avl_lmt_lft_rep_prc_2m_hug_1m
      ,max_avl_lmt_lft_rep_prc_2m_cash_1m
      ,max_avl_lmt_lft_rep_prc_2m_dcp_1m
      ,max_avl_lmt_lft_rep_prc_2m_hug_1m
      ,min_avl_lmt_lft_rep_prc_2m_cash_1m
      ,min_avl_lmt_lft_rep_prc_2m_dcp_1m
      ,min_avl_lmt_lft_rep_prc_2m_hug_1m      
      ,avg_avl_lmt_lft_rep_prc_3m_cash_1m
      ,avg_avl_lmt_lft_rep_prc_3m_dcp_1m
      ,avg_avl_lmt_lft_rep_prc_3m_hug_1m
      ,max_avl_lmt_lft_rep_prc_3m_cash_1m
      ,max_avl_lmt_lft_rep_prc_3m_dcp_1m
      ,max_avl_lmt_lft_rep_prc_3m_hug_1m
      ,min_avl_lmt_lft_rep_prc_3m_cash_1m
      ,min_avl_lmt_lft_rep_prc_3m_dcp_1m
      ,min_avl_lmt_lft_rep_prc_3m_hug_1m              
      ,avg_avl_lmt_lft_rep_prc_6m_cash_1m
      ,avg_avl_lmt_lft_rep_prc_6m_dcp_1m
      ,avg_avl_lmt_lft_rep_prc_6m_hug_1m
      ,max_avl_lmt_lft_rep_prc_6m_cash_1m
      ,max_avl_lmt_lft_rep_prc_6m_dcp_1m
      ,max_avl_lmt_lft_rep_prc_6m_hug_1m
      ,min_avl_lmt_lft_rep_prc_6m_cash_1m
      ,min_avl_lmt_lft_rep_prc_6m_dcp_1m
      ,min_avl_lmt_lft_rep_prc_6m_hug_1m
      ,avg_avl_lmt_lft_rep_prc_all_cash_1m
      ,avg_avl_lmt_lft_rep_prc_all_dcp_1m
      ,avg_avl_lmt_lft_rep_prc_all_hug_1m
      ,max_avl_lmt_lft_rep_prc_all_cash_1m
      ,max_avl_lmt_lft_rep_prc_all_dcp_1m
      ,max_avl_lmt_lft_rep_prc_all_hug_1m
      ,min_avl_lmt_lft_rep_prc_all_cash_1m
      ,min_avl_lmt_lft_rep_prc_all_dcp_1m
      ,min_avl_lmt_lft_rep_prc_all_hug_1m
      ,rsk_lmt_rate_ch_1m_grt_0p95_cnt_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p95_rate_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_cnt_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_rate_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_cnt_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_rate_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_cnt_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_rate_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_cnt_1m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_rate_1m 
      ,rsk_avl_lmt_ch_1m_les_500_cnt_1m 
      ,rsk_avl_lmt_ch_1m_les_500_rate_1m 
      ,rsk_avl_lmt_ch_1m_les_1000_cnt_1m 
      ,rsk_avl_lmt_ch_1m_les_1000_rate_1m 
      ,rsk_avl_lmt_ch_1m_les_5000_cnt_1m 
      ,rsk_avl_lmt_ch_1m_les_5000_rate_1m
      ,rsk_avl_lmt_ch_1m_les_10000_cnt_1m 
      ,rsk_avl_lmt_ch_1m_les_10000_rate_1m
      ,max_rsk_lmt_rate_3m_bt_ch
      ,max_rsk_lmt_rate_3m_dcp
      ,max_rsk_lmt_rate_3m_hug
      ,max_rsk_lmt_rate_3m_all
      ,min_rsk_lmt_rate_3m_bt_ch
      ,min_rsk_lmt_rate_3m_dcp
      ,min_rsk_lmt_rate_3m_hug
      ,min_rsk_lmt_rate_3m_all
      ,avg_rsk_lmt_rate_3m_bt_ch
      ,avg_rsk_lmt_rate_3m_dcp
      ,avg_rsk_lmt_rate_3m_hug
      ,avg_rsk_lmt_rate_3m_all
      ,max_rsk_avl_lmt_3m_bt_ch
      ,max_rsk_avl_lmt_3m_dcp
      ,max_rsk_avl_lmt_3m_hug
      ,max_rsk_avl_lmt_3m_all
      ,min_rsk_avl_lmt_3m_bt_ch
      ,min_rsk_avl_lmt_3m_dcp
      ,min_rsk_avl_lmt_3m_hug
      ,min_rsk_avl_lmt_3m_all
      ,avg_rsk_avl_lmt_3m_bt_ch
      ,avg_rsk_avl_lmt_3m_dcp
      ,avg_rsk_avl_lmt_3m_hug
      ,avg_rsk_avl_lmt_3m_all
      ,avg_avl_lmt_lft_rep_prc_1m_cash_3m
      ,avg_avl_lmt_lft_rep_prc_1m_dcp_3m
      ,avg_avl_lmt_lft_rep_prc_1m_hug_3m
      ,max_avl_lmt_lft_rep_prc_1m_cash_3m
      ,max_avl_lmt_lft_rep_prc_1m_dcp_3m
      ,max_avl_lmt_lft_rep_prc_1m_hug_3m
      ,min_avl_lmt_lft_rep_prc_1m_cash_3m
      ,min_avl_lmt_lft_rep_prc_1m_dcp_3m
      ,min_avl_lmt_lft_rep_prc_1m_hug_3m
      ,avg_avl_lmt_lft_rep_prc_2m_cash_3m
      ,avg_avl_lmt_lft_rep_prc_2m_dcp_3m
      ,avg_avl_lmt_lft_rep_prc_2m_hug_3m
      ,max_avl_lmt_lft_rep_prc_2m_cash_3m
      ,max_avl_lmt_lft_rep_prc_2m_dcp_3m
      ,max_avl_lmt_lft_rep_prc_2m_hug_3m
      ,min_avl_lmt_lft_rep_prc_2m_cash_3m
      ,min_avl_lmt_lft_rep_prc_2m_dcp_3m
      ,min_avl_lmt_lft_rep_prc_2m_hug_3m      
      ,avg_avl_lmt_lft_rep_prc_3m_cash_3m
      ,avg_avl_lmt_lft_rep_prc_3m_dcp_3m
      ,avg_avl_lmt_lft_rep_prc_3m_hug_3m
      ,max_avl_lmt_lft_rep_prc_3m_cash_3m
      ,max_avl_lmt_lft_rep_prc_3m_dcp_3m
      ,max_avl_lmt_lft_rep_prc_3m_hug_3m
      ,min_avl_lmt_lft_rep_prc_3m_cash_3m
      ,min_avl_lmt_lft_rep_prc_3m_dcp_3m
      ,min_avl_lmt_lft_rep_prc_3m_hug_3m              
      ,avg_avl_lmt_lft_rep_prc_6m_cash_3m
      ,avg_avl_lmt_lft_rep_prc_6m_dcp_3m
      ,avg_avl_lmt_lft_rep_prc_6m_hug_3m
      ,max_avl_lmt_lft_rep_prc_6m_cash_3m
      ,max_avl_lmt_lft_rep_prc_6m_dcp_3m
      ,max_avl_lmt_lft_rep_prc_6m_hug_3m
      ,min_avl_lmt_lft_rep_prc_6m_cash_3m
      ,min_avl_lmt_lft_rep_prc_6m_dcp_3m
      ,min_avl_lmt_lft_rep_prc_6m_hug_3m
      ,avg_avl_lmt_lft_rep_prc_all_cash_3m
      ,avg_avl_lmt_lft_rep_prc_all_dcp_3m
      ,avg_avl_lmt_lft_rep_prc_all_hug_3m
      ,max_avl_lmt_lft_rep_prc_all_cash_3m
      ,max_avl_lmt_lft_rep_prc_all_dcp_3m
      ,max_avl_lmt_lft_rep_prc_all_hug_3m
      ,min_avl_lmt_lft_rep_prc_all_cash_3m
      ,min_avl_lmt_lft_rep_prc_all_dcp_3m
      ,min_avl_lmt_lft_rep_prc_all_hug_3m
      ,rsk_lmt_rate_ch_1m_grt_0p95_cnt_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p95_rate_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_cnt_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_rate_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_cnt_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_rate_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_cnt_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_rate_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_cnt_3m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_rate_3m 
      ,rsk_avl_lmt_ch_1m_les_500_cnt_3m 
      ,rsk_avl_lmt_ch_1m_les_500_rate_3m 
      ,rsk_avl_lmt_ch_1m_les_1000_cnt_3m 
      ,rsk_avl_lmt_ch_1m_les_1000_rate_3m 
      ,rsk_avl_lmt_ch_1m_les_5000_cnt_3m 
      ,rsk_avl_lmt_ch_1m_les_5000_rate_3m
      ,rsk_avl_lmt_ch_1m_les_10000_cnt_3m 
      ,rsk_avl_lmt_ch_1m_les_10000_rate_3m
      ,max_rsk_lmt_rate_6m_bt_ch
      ,max_rsk_lmt_rate_6m_dcp
      ,max_rsk_lmt_rate_6m_hug
      ,max_rsk_lmt_rate_6m_all
      ,min_rsk_lmt_rate_6m_bt_ch
      ,min_rsk_lmt_rate_6m_dcp
      ,min_rsk_lmt_rate_6m_hug
      ,min_rsk_lmt_rate_6m_all
      ,avg_rsk_lmt_rate_6m_bt_ch
      ,avg_rsk_lmt_rate_6m_dcp
      ,avg_rsk_lmt_rate_6m_hug
      ,avg_rsk_lmt_rate_6m_all
      ,max_rsk_avl_lmt_6m_bt_ch
      ,max_rsk_avl_lmt_6m_dcp
      ,max_rsk_avl_lmt_6m_hug
      ,max_rsk_avl_lmt_6m_all
      ,min_rsk_avl_lmt_6m_bt_ch
      ,min_rsk_avl_lmt_6m_dcp
      ,min_rsk_avl_lmt_6m_hug
      ,min_rsk_avl_lmt_6m_all
      ,avg_rsk_avl_lmt_6m_bt_ch
      ,avg_rsk_avl_lmt_6m_dcp
      ,avg_rsk_avl_lmt_6m_hug
      ,avg_rsk_avl_lmt_6m_all
      ,avg_avl_lmt_lft_rep_prc_1m_cash_6m
      ,avg_avl_lmt_lft_rep_prc_1m_dcp_6m
      ,avg_avl_lmt_lft_rep_prc_1m_hug_6m
      ,max_avl_lmt_lft_rep_prc_1m_cash_6m
      ,max_avl_lmt_lft_rep_prc_1m_dcp_6m
      ,max_avl_lmt_lft_rep_prc_1m_hug_6m
      ,min_avl_lmt_lft_rep_prc_1m_cash_6m
      ,min_avl_lmt_lft_rep_prc_1m_dcp_6m
      ,min_avl_lmt_lft_rep_prc_1m_hug_6m
      ,avg_avl_lmt_lft_rep_prc_2m_cash_6m
      ,avg_avl_lmt_lft_rep_prc_2m_dcp_6m
      ,avg_avl_lmt_lft_rep_prc_2m_hug_6m
      ,max_avl_lmt_lft_rep_prc_2m_cash_6m
      ,max_avl_lmt_lft_rep_prc_2m_dcp_6m
      ,max_avl_lmt_lft_rep_prc_2m_hug_6m
      ,min_avl_lmt_lft_rep_prc_2m_cash_6m
      ,min_avl_lmt_lft_rep_prc_2m_dcp_6m
      ,min_avl_lmt_lft_rep_prc_2m_hug_6m  
      ,avg_avl_lmt_lft_rep_prc_3m_cash_6m
      ,avg_avl_lmt_lft_rep_prc_3m_dcp_6m
      ,avg_avl_lmt_lft_rep_prc_3m_hug_6m
      ,max_avl_lmt_lft_rep_prc_3m_cash_6m
      ,max_avl_lmt_lft_rep_prc_3m_dcp_6m
      ,max_avl_lmt_lft_rep_prc_3m_hug_6m
      ,min_avl_lmt_lft_rep_prc_3m_cash_6m
      ,min_avl_lmt_lft_rep_prc_3m_dcp_6m
      ,min_avl_lmt_lft_rep_prc_3m_hug_6m              
      ,avg_avl_lmt_lft_rep_prc_6m_cash_6m
      ,avg_avl_lmt_lft_rep_prc_6m_dcp_6m
      ,avg_avl_lmt_lft_rep_prc_6m_hug_6m
      ,max_avl_lmt_lft_rep_prc_6m_cash_6m
      ,max_avl_lmt_lft_rep_prc_6m_dcp_6m
      ,max_avl_lmt_lft_rep_prc_6m_hug_6m
      ,min_avl_lmt_lft_rep_prc_6m_cash_6m
      ,min_avl_lmt_lft_rep_prc_6m_dcp_6m
      ,min_avl_lmt_lft_rep_prc_6m_hug_6m
      ,avg_avl_lmt_lft_rep_prc_all_cash_6m
      ,avg_avl_lmt_lft_rep_prc_all_dcp_6m
      ,avg_avl_lmt_lft_rep_prc_all_hug_6m
      ,max_avl_lmt_lft_rep_prc_all_cash_6m
      ,max_avl_lmt_lft_rep_prc_all_dcp_6m
      ,max_avl_lmt_lft_rep_prc_all_hug_6m
      ,min_avl_lmt_lft_rep_prc_all_cash_6m
      ,min_avl_lmt_lft_rep_prc_all_dcp_6m
      ,min_avl_lmt_lft_rep_prc_all_hug_6m
      ,rsk_lmt_rate_ch_1m_grt_0p95_cnt_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p95_rate_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_cnt_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_rate_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_cnt_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_rate_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_cnt_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_rate_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_cnt_6m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_rate_6m 
      ,rsk_avl_lmt_ch_1m_les_500_cnt_6m 
      ,rsk_avl_lmt_ch_1m_les_500_rate_6m 
      ,rsk_avl_lmt_ch_1m_les_1000_cnt_6m 
      ,rsk_avl_lmt_ch_1m_les_1000_rate_6m 
      ,rsk_avl_lmt_ch_1m_les_5000_cnt_6m 
      ,rsk_avl_lmt_ch_1m_les_5000_rate_6m
      ,rsk_avl_lmt_ch_1m_les_10000_cnt_6m 
      ,rsk_avl_lmt_ch_1m_les_10000_rate_6m
      ,max_rsk_lmt_rate_12m_bt_ch
      ,max_rsk_lmt_rate_12m_dcp
      ,max_rsk_lmt_rate_12m_hug
      ,max_rsk_lmt_rate_12m_all
      ,min_rsk_lmt_rate_12m_bt_ch
      ,min_rsk_lmt_rate_12m_dcp
      ,min_rsk_lmt_rate_12m_hug
      ,min_rsk_lmt_rate_12m_all
      ,avg_rsk_lmt_rate_12m_bt_ch
      ,avg_rsk_lmt_rate_12m_dcp
      ,avg_rsk_lmt_rate_12m_hug
      ,avg_rsk_lmt_rate_12m_all
      ,max_rsk_avl_lmt_12m_bt_ch
      ,max_rsk_avl_lmt_12m_dcp
      ,max_rsk_avl_lmt_12m_hug
      ,max_rsk_avl_lmt_12m_all
      ,min_rsk_avl_lmt_12m_bt_ch
      ,min_rsk_avl_lmt_12m_dcp
      ,min_rsk_avl_lmt_12m_hug
      ,min_rsk_avl_lmt_12m_all
      ,avg_rsk_avl_lmt_12m_bt_ch
      ,avg_rsk_avl_lmt_12m_dcp
      ,avg_rsk_avl_lmt_12m_hug
      ,avg_rsk_avl_lmt_12m_all
      ,avg_avl_lmt_lft_rep_prc_1m_cash_12m
      ,avg_avl_lmt_lft_rep_prc_1m_dcp_12m
      ,avg_avl_lmt_lft_rep_prc_1m_hug_12m
      ,max_avl_lmt_lft_rep_prc_1m_cash_12m
      ,max_avl_lmt_lft_rep_prc_1m_dcp_12m
      ,max_avl_lmt_lft_rep_prc_1m_hug_12m
      ,min_avl_lmt_lft_rep_prc_1m_cash_12m
      ,min_avl_lmt_lft_rep_prc_1m_dcp_12m
      ,min_avl_lmt_lft_rep_prc_1m_hug_12m
      ,avg_avl_lmt_lft_rep_prc_2m_cash_12m
      ,avg_avl_lmt_lft_rep_prc_2m_dcp_12m
      ,avg_avl_lmt_lft_rep_prc_2m_hug_12m
      ,max_avl_lmt_lft_rep_prc_2m_cash_12m
      ,max_avl_lmt_lft_rep_prc_2m_dcp_12m
      ,max_avl_lmt_lft_rep_prc_2m_hug_12m
      ,min_avl_lmt_lft_rep_prc_2m_cash_12m
      ,min_avl_lmt_lft_rep_prc_2m_dcp_12m
      ,min_avl_lmt_lft_rep_prc_2m_hug_12m 
      ,avg_avl_lmt_lft_rep_prc_3m_cash_12m
      ,avg_avl_lmt_lft_rep_prc_3m_dcp_12m
      ,avg_avl_lmt_lft_rep_prc_3m_hug_12m
      ,max_avl_lmt_lft_rep_prc_3m_cash_12m
      ,max_avl_lmt_lft_rep_prc_3m_dcp_12m
      ,max_avl_lmt_lft_rep_prc_3m_hug_12m
      ,min_avl_lmt_lft_rep_prc_3m_cash_12m
      ,min_avl_lmt_lft_rep_prc_3m_dcp_12m
      ,min_avl_lmt_lft_rep_prc_3m_hug_12m              
      ,avg_avl_lmt_lft_rep_prc_6m_cash_12m
      ,avg_avl_lmt_lft_rep_prc_6m_dcp_12m
      ,avg_avl_lmt_lft_rep_prc_6m_hug_12m
      ,max_avl_lmt_lft_rep_prc_6m_cash_12m
      ,max_avl_lmt_lft_rep_prc_6m_dcp_12m
      ,max_avl_lmt_lft_rep_prc_6m_hug_12m
      ,min_avl_lmt_lft_rep_prc_6m_cash_12m
      ,min_avl_lmt_lft_rep_prc_6m_dcp_12m
      ,min_avl_lmt_lft_rep_prc_6m_hug_12m
      ,avg_avl_lmt_lft_rep_prc_all_cash_12m
      ,avg_avl_lmt_lft_rep_prc_all_dcp_12m
      ,avg_avl_lmt_lft_rep_prc_all_hug_12m
      ,max_avl_lmt_lft_rep_prc_all_cash_12m
      ,max_avl_lmt_lft_rep_prc_all_dcp_12m
      ,max_avl_lmt_lft_rep_prc_all_hug_12m
      ,min_avl_lmt_lft_rep_prc_all_cash_12m
      ,min_avl_lmt_lft_rep_prc_all_dcp_12m
      ,min_avl_lmt_lft_rep_prc_all_hug_12m
      ,rsk_lmt_rate_ch_1m_grt_0p95_cnt_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p95_rate_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_cnt_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p9_rate_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_cnt_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p8_rate_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_cnt_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p5_rate_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_cnt_12m 
      ,rsk_lmt_rate_ch_1m_grt_0p2_rate_12m 
      ,rsk_avl_lmt_ch_1m_les_500_cnt_12m 
      ,rsk_avl_lmt_ch_1m_les_500_rate_12m 
      ,rsk_avl_lmt_ch_1m_les_1000_cnt_12m 
      ,rsk_avl_lmt_ch_1m_les_1000_rate_12m 
      ,rsk_avl_lmt_ch_1m_les_5000_cnt_12m 
      ,rsk_avl_lmt_ch_1m_les_5000_rate_12m
      ,rsk_avl_lmt_ch_1m_les_10000_cnt_12m 
      ,rsk_avl_lmt_ch_1m_les_10000_rate_12m
from dwa_risk.dwa_risk_dz_model_account_lmt_combine_tmp as a
left join  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_1m as b
on a.uid=b.uid
left join  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_3m as c
on a.uid=c.uid
left join  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_6m as d
on a.uid=d.uid
left join  dwa_risk.dwa_risk_dz_model_temp_account_lmt_feature_sample_daily_12m as e
on a.uid=e.uid;
-- feature-copilot:node-end ordinal=0
