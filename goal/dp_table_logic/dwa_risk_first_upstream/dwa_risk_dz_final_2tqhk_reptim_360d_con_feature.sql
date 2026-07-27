-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_final_2tqhk_reptim_360d_con_feature
-- node_id: n_3915069295424634880
-- task_name: dwa_risk_dz_final_2tqhk_reptim_360d_con_feature
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_final_2tqhk_reptim_360d_con_feature.json
-- source_json_sha256: 30fc1e19868a7c4b0d4b0a40c1e62e0cc863121970885a8b465c2436779bd3f7
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 郭卫勇
--创建日期: 2022-08-11 15:03:36
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
-- 临时表较多，在前置任务中删除，防止重跑
--********************************************************************--

drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim;
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_feature1;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary;

CREATE TABLE IF NOT EXISTS ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_con_feature( 
    uid STRING COMMENT 'uid'
   ,mdl_dte STRING COMMENT '评分日期'
   ,not_ovd_tqhk_rep_tim_cnt_1m BIGINT COMMENT '近1m内提前还款次数'
   ,max_con_not_ovd_tqhk_rep_tim_cnt_1m BIGINT  COMMENT '近1m连续提前还款次数'
   ,ddf_mdl_max_not_ovd_tqhk_rep_tim_1m INT     COMMENT '近1m内最近提前还款日期距评分日间隔（天）'
   ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_1m INT COMMENT '近1m最大连续提前还款次数结束日期距评分日间隔（天）'
   ,not_ovd_tqhk_rep_tim_cnt_2m BIGINT COMMENT '近2m内提前还款次数'
   ,max_con_not_ovd_tqhk_rep_tim_cnt_2m BIGINT  COMMENT '近2m连续提前还款次数'
   ,ddf_mdl_max_not_ovd_tqhk_rep_tim_2m INT     COMMENT '近2m内最近提前还款日期距评分日间隔（天）'
   ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_2m INT COMMENT '近2m最大连续提前还款次数结束日期距评分日间隔（天）'
   ,not_ovd_tqhk_rep_tim_cnt_3m BIGINT COMMENT '近3m内提前还款次数'
   ,max_con_not_ovd_tqhk_rep_tim_cnt_3m BIGINT  COMMENT '近3m连续提前还款次数'
   ,ddf_mdl_max_not_ovd_tqhk_rep_tim_3m INT     COMMENT '近3m内最近提前还款日期距评分日间隔（天）'
   ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_3m INT COMMENT '近3m最大连续提前还款次数结束日期距评分日间隔（天）'
   ,not_ovd_tqhk_rep_tim_cnt_4m BIGINT COMMENT '近4m内提前还款次数'
   ,max_con_not_ovd_tqhk_rep_tim_cnt_4m BIGINT  COMMENT '近4m连续提前还款次数'
   ,ddf_mdl_max_not_ovd_tqhk_rep_tim_4m INT     COMMENT '近4m内最近提前还款日期距评分日间隔（天）'
   ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_4m INT COMMENT '近4m最大连续提前还款次数结束日期距评分日间隔（天）'
   ,not_ovd_tqhk_rep_tim_cnt_5m BIGINT COMMENT '近5m内提前还款次数'
   ,max_con_not_ovd_tqhk_rep_tim_cnt_5m BIGINT  COMMENT '近5m连续提前还款次数'
   ,ddf_mdl_max_not_ovd_tqhk_rep_tim_5m INT     COMMENT '近5m内最近提前还款日期距评分日间隔（天）'
   ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_5m INT COMMENT '近5m最大连续提前还款次数结束日期距评分日间隔（天）'
   ,not_ovd_tqhk_rep_tim_cnt_6m BIGINT COMMENT ''
   ,max_con_not_ovd_tqhk_rep_tim_cnt_6m BIGINT  COMMENT '近6m连续提前还款次数'
   ,ddf_mdl_max_not_ovd_tqhk_rep_tim_6m INT     COMMENT '近6m内最近提前还款日期距评分日间隔（天）'
   ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_6m INT COMMENT '近6m最大连续提前还款次数结束日期距评分日间隔（天）'
   ,not_ovd_tqhk_rep_tim_cnt_12m BIGINT         COMMENT '近12m提前还款次数'
   ,max_con_not_ovd_tqhk_rep_tim_cnt_12m BIGINT COMMENT '近12m连续提前还款次数'
   ,ddf_mdl_max_not_ovd_tqhk_rep_tim_12m INT  COMMENT '近12m内最近提前还款日期距评分日间隔（天）'
   ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_12m INT  COMMENT '近12m最大连续提前还款次数结束日期距评分日间隔（天）'
 ) partitioned by(ds string);  


------------------【明细数据中间表】--------------------
--1 取近360天内的应还期
-- -- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg as
select model_data.uid,
      model_data.mdl_dte,
      concat_ws('&',model_data.uid,cast(model_data.mdl_dte as string),cast(date(t1.rep_dte) as string)) as kvp_mdl_rep_dte, -- 用于计算提前还款期数
      concat_ws('&',model_data.uid,cast(model_data.mdl_dte as string),cast(date(t1.rep_tim) as string)) as kvp_mdl_rep_tim, -- 用于计算提前还款次数
      case when date(t1.rep_tim)<date(t1.rep_dte) then 1 else 0 end as if_tqhk,
      datediff(date(model_data.mdl_dte),date(t1.rep_tim)) as ddf_mdl_dtl_rep_tim, -- 模型日与实还日之间的间隔
      t1.stg_pln_no as dtl_stg_pln_no,
      cast(date(t1.rep_dte) as string) as dtl_rep_dte,
      cast(date(t1.rep_tim) as string) as dtl_rep_tim,
      datediff(date(t1.rep_tim),date(t1.rep_dte)) as ddf_dtl_rep_tim_dte, -- 实还日与应还日之间的间隔
      -- 历史是否逾期flag
      case when t1.rep_tim is null or date(t1.rep_tim)>date(t1.rep_dte) then 1 else 0 end as ovd_rep_flg
from
      (select uid
        ,date(mdl_dte) as mdl_dte
    from ${dwa_risk}.dwa_risk_f_dz_model_data_base
    ) model_data
inner join ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic t1  -- dbank.loan_f_stage_plan t1 
     on model_data.uid=t1.uid
inner join ${dwa_risk}.dwa_risk_f_heavy_order_info_basic t2-- dbank.loan_f_order_info 
     on t1.ord_no=t2.ord_no
-- inner join 
--       (select uid,ord_no as fst_ord_no,crt_tim as fst_ord_tim,
--               row_number() over(partition by uid order by fst_its_dte,crt_tim asc) rn
--       from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic 
--       where bsy_typ in ('BALANCE_TRANSFER', 'CASH')
--             and ord_stt_flg = 'success'
--       ) t3 on model_data.uid=t3.uid and rn = 1
where  datediff(date(model_data.mdl_dte),date(t1.rep_tim)) between 0 and 360
      and t2.bsy_typ in ('BALANCE_TRANSFER', 'CASH')
      and t2.ord_stt_flg = 'success' -- 成功订单
;


-- 2 次数/占比  近30/60/90/120/150/180/360天提前还款期数数/占比
-- -- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt as 
select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt,

  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_rep_dte_cnt
from 
(select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0
group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
) t 
group by uid, mdl_dte
;

-- 3 次数/占比  近30/60/90/120/150/180/360天提前还款次数/占比
-- -- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt as 
select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt,

  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_rep_tim_cnt
from 
(select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0
group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
) t 
group by uid, mdl_dte
;

-- 4 距今间隔 最近一次/两次提前还款距模型日间隔(天)
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim as 
select uid, mdl_dte,
  max(case when if_tqhk=1 and rep_tim_rn = 1 then datediff(date(mdl_dte),date(dtl_rep_tim)) end) as ddf_mdl_df_lst_not_ovd_tqhk_rep_tim,
  max(case when if_tqhk=1 and rep_tim_rn = 2 then datediff(date(mdl_dte),date(dtl_rep_tim)) end) as ddf_mdl_df_lst_2_not_ovd_tqhk_rep_tim,
  max(case when if_tqhk=1 and rep_tim_rn = 3 then datediff(date(mdl_dte),date(dtl_rep_tim)) end) as ddf_mdl_df_lst_3_not_ovd_tqhk_rep_tim
from 
  (select *,
    row_number()over(partition by uid, mdl_dte order by if_tqhk,dtl_rep_tim desc) rep_tim_rn 
  from 
    (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
    from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
    where ovd_rep_flg=0
    group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
    ) t 
  )tt 
group by uid, mdl_dte
;

-- 5 提前多少天还款
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim as 
select uid, mdl_dte,
  -- 近xm提前还款天数的平均值
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then ddf_dtl_rep_dte_tim end) as ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then ddf_dtl_rep_dte_tim end) as ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then ddf_dtl_rep_dte_tim end) as ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then ddf_dtl_rep_dte_tim end) as ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then ddf_dtl_rep_dte_tim end) as ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then ddf_dtl_rep_dte_tim end) as ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then ddf_dtl_rep_dte_tim end) as ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  -- 近xm提前还款天数的最大值
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then ddf_dtl_rep_dte_tim end) as ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then ddf_dtl_rep_dte_tim end) as ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then ddf_dtl_rep_dte_tim end) as ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then ddf_dtl_rep_dte_tim end) as ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then ddf_dtl_rep_dte_tim end) as ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then ddf_dtl_rep_dte_tim end) as ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then ddf_dtl_rep_dte_tim end) as ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  -- 近xm提前还款天数的最小
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then ddf_dtl_rep_dte_tim end) as ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then ddf_dtl_rep_dte_tim end) as ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then ddf_dtl_rep_dte_tim end) as ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then ddf_dtl_rep_dte_tim end) as ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then ddf_dtl_rep_dte_tim end) as ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then ddf_dtl_rep_dte_tim end) as ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then ddf_dtl_rep_dte_tim end) as ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
from 
(select uid,mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte, ddf_dtl_rep_tim_dte*(-1) as ddf_dtl_rep_dte_tim
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where if_tqhk=1
group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte, ddf_dtl_rep_tim_dte
) t 
group by uid,mdl_dte
;

-- 6 特征汇总
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_feature1;
create table if not exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_feature1 as 
select t.uid, t.mdl_dte
  ,nvl(ddf_1m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_2m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_3m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_4m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_5m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_6m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_12m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_1m_not_ovd_rep_dte_cnt,0) as ddf_1m_not_ovd_rep_dte_cnt
  ,nvl(ddf_2m_not_ovd_rep_dte_cnt,0) as ddf_2m_not_ovd_rep_dte_cnt
  ,nvl(ddf_3m_not_ovd_rep_dte_cnt,0) as ddf_3m_not_ovd_rep_dte_cnt
  ,nvl(ddf_4m_not_ovd_rep_dte_cnt,0) as ddf_4m_not_ovd_rep_dte_cnt
  ,nvl(ddf_5m_not_ovd_rep_dte_cnt,0) as ddf_5m_not_ovd_rep_dte_cnt
  ,nvl(ddf_6m_not_ovd_rep_dte_cnt,0) as ddf_6m_not_ovd_rep_dte_cnt
  ,nvl(ddf_12m_not_ovd_rep_dte_cnt,0) as ddf_12m_not_ovd_rep_dte_cnt
  ,ddf_1m_not_ovd_tqhk_rep_dte_rat
  ,ddf_2m_not_ovd_tqhk_rep_dte_rat
  ,ddf_3m_not_ovd_tqhk_rep_dte_rat
  ,ddf_4m_not_ovd_tqhk_rep_dte_rat
  ,ddf_5m_not_ovd_tqhk_rep_dte_rat
  ,ddf_6m_not_ovd_tqhk_rep_dte_rat
  ,ddf_12m_not_ovd_tqhk_rep_dte_rat

  ,case when nvl(ddf_2m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_2m_not_ovd_tqhk_rep_dte_rat end as ddf_2m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_3m_not_ovd_tqhk_rep_dte_rat end as ddf_3m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_4m_not_ovd_tqhk_rep_dte_rat end as ddf_4m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_1m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_3m_not_ovd_tqhk_rep_dte_rat end as ddf_3m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_4m_not_ovd_tqhk_rep_dte_rat end as ddf_4m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_2m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_4m_not_ovd_tqhk_rep_dte_rat end as ddf_4m_to_3m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_3m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_3m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_3m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_4m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_4m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_4m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_5m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_5m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_6m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_6m_not_ovd_tqhk_rep_dte_rto

  ,nvl(ddf_1m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_2m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_3m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_4m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_5m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_6m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_12m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_1m_not_ovd_rep_tim_cnt,0) as ddf_1m_not_ovd_rep_tim_cnt
  ,nvl(ddf_2m_not_ovd_rep_tim_cnt,0) as ddf_2m_not_ovd_rep_tim_cnt
  ,nvl(ddf_3m_not_ovd_rep_tim_cnt,0) as ddf_3m_not_ovd_rep_tim_cnt
  ,nvl(ddf_4m_not_ovd_rep_tim_cnt,0) as ddf_4m_not_ovd_rep_tim_cnt
  ,nvl(ddf_5m_not_ovd_rep_tim_cnt,0) as ddf_5m_not_ovd_rep_tim_cnt
  ,nvl(ddf_6m_not_ovd_rep_tim_cnt,0) as ddf_6m_not_ovd_rep_tim_cnt
  ,nvl(ddf_12m_not_ovd_rep_tim_cnt,0) as ddf_12m_not_ovd_rep_tim_cnt
  ,ddf_1m_not_ovd_tqhk_rep_tim_rat
  ,ddf_2m_not_ovd_tqhk_rep_tim_rat
  ,ddf_3m_not_ovd_tqhk_rep_tim_rat
  ,ddf_4m_not_ovd_tqhk_rep_tim_rat
  ,ddf_5m_not_ovd_tqhk_rep_tim_rat
  ,ddf_6m_not_ovd_tqhk_rep_tim_rat
  ,ddf_12m_not_ovd_tqhk_rep_tim_rat
    
  ,case when nvl(ddf_2m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_2m_not_ovd_tqhk_rep_tim_rat end as ddf_2m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_3m_not_ovd_tqhk_rep_tim_rat end as ddf_3m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_4m_not_ovd_tqhk_rep_tim_rat end as ddf_4m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_1m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_3m_not_ovd_tqhk_rep_tim_rat end as ddf_3m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_4m_not_ovd_tqhk_rep_tim_rat end as ddf_4m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_2m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_4m_not_ovd_tqhk_rep_tim_rat end as ddf_4m_to_3m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_3m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_3m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_3m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_4m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_4m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_4m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_5m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_5m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_6m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_6m_not_ovd_tqhk_rep_tim_rto
     
  ,ddf_mdl_df_lst_not_ovd_tqhk_rep_tim
  ,ddf_mdl_df_lst_2_not_ovd_tqhk_rep_tim
  ,ddf_mdl_df_lst_3_not_ovd_tqhk_rep_tim

  ,ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg

  ,ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  
  ,ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
from ${dwa_risk}.dwa_risk_f_dz_model_data_base t
left join 
  (select uid,mdl_dte,
    -- 期数
    ddf_1m_not_ovd_tqhk_rep_dte_cnt,
    ddf_2m_not_ovd_tqhk_rep_dte_cnt,
    ddf_3m_not_ovd_tqhk_rep_dte_cnt,
    ddf_4m_not_ovd_tqhk_rep_dte_cnt,
    ddf_5m_not_ovd_tqhk_rep_dte_cnt,
    ddf_6m_not_ovd_tqhk_rep_dte_cnt,
    ddf_12m_not_ovd_tqhk_rep_dte_cnt,
    ddf_1m_not_ovd_rep_dte_cnt,
    ddf_2m_not_ovd_rep_dte_cnt,
    ddf_3m_not_ovd_rep_dte_cnt,
    ddf_4m_not_ovd_rep_dte_cnt,
    ddf_5m_not_ovd_rep_dte_cnt,
    ddf_6m_not_ovd_rep_dte_cnt,
    ddf_12m_not_ovd_rep_dte_cnt,
    ddf_1m_not_ovd_tqhk_rep_dte_cnt/ddf_1m_not_ovd_rep_dte_cnt as ddf_1m_not_ovd_tqhk_rep_dte_rat,
    ddf_2m_not_ovd_tqhk_rep_dte_cnt/ddf_2m_not_ovd_rep_dte_cnt as ddf_2m_not_ovd_tqhk_rep_dte_rat,
    ddf_3m_not_ovd_tqhk_rep_dte_cnt/ddf_3m_not_ovd_rep_dte_cnt as ddf_3m_not_ovd_tqhk_rep_dte_rat,
    ddf_4m_not_ovd_tqhk_rep_dte_cnt/ddf_4m_not_ovd_rep_dte_cnt as ddf_4m_not_ovd_tqhk_rep_dte_rat,
    ddf_5m_not_ovd_tqhk_rep_dte_cnt/ddf_5m_not_ovd_rep_dte_cnt as ddf_5m_not_ovd_tqhk_rep_dte_rat,
    ddf_6m_not_ovd_tqhk_rep_dte_cnt/ddf_6m_not_ovd_rep_dte_cnt as ddf_6m_not_ovd_tqhk_rep_dte_rat,
    ddf_12m_not_ovd_tqhk_rep_dte_cnt/ddf_12m_not_ovd_rep_dte_cnt as ddf_12m_not_ovd_tqhk_rep_dte_rat
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt
  )t1 
on t.uid=t1.uid
left join 
  (select uid, mdl_dte,
    -- 次数
    ddf_1m_not_ovd_tqhk_rep_tim_cnt,
    ddf_2m_not_ovd_tqhk_rep_tim_cnt,
    ddf_3m_not_ovd_tqhk_rep_tim_cnt,
    ddf_4m_not_ovd_tqhk_rep_tim_cnt,
    ddf_5m_not_ovd_tqhk_rep_tim_cnt,
    ddf_6m_not_ovd_tqhk_rep_tim_cnt,
    ddf_12m_not_ovd_tqhk_rep_tim_cnt,
    ddf_1m_not_ovd_rep_tim_cnt,
    ddf_2m_not_ovd_rep_tim_cnt,
    ddf_3m_not_ovd_rep_tim_cnt,
    ddf_4m_not_ovd_rep_tim_cnt,
    ddf_5m_not_ovd_rep_tim_cnt,
    ddf_6m_not_ovd_rep_tim_cnt,
    ddf_12m_not_ovd_rep_tim_cnt,
    ddf_1m_not_ovd_tqhk_rep_tim_cnt/ddf_1m_not_ovd_rep_tim_cnt as ddf_1m_not_ovd_tqhk_rep_tim_rat,
    ddf_2m_not_ovd_tqhk_rep_tim_cnt/ddf_2m_not_ovd_rep_tim_cnt as ddf_2m_not_ovd_tqhk_rep_tim_rat,
    ddf_3m_not_ovd_tqhk_rep_tim_cnt/ddf_3m_not_ovd_rep_tim_cnt as ddf_3m_not_ovd_tqhk_rep_tim_rat,
    ddf_4m_not_ovd_tqhk_rep_tim_cnt/ddf_4m_not_ovd_rep_tim_cnt as ddf_4m_not_ovd_tqhk_rep_tim_rat,
    ddf_5m_not_ovd_tqhk_rep_tim_cnt/ddf_5m_not_ovd_rep_tim_cnt as ddf_5m_not_ovd_tqhk_rep_tim_rat,
    ddf_6m_not_ovd_tqhk_rep_tim_cnt/ddf_6m_not_ovd_rep_tim_cnt as ddf_6m_not_ovd_tqhk_rep_tim_rat,
    ddf_12m_not_ovd_tqhk_rep_tim_cnt/ddf_12m_not_ovd_rep_tim_cnt as ddf_12m_not_ovd_tqhk_rep_tim_rat
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt
  )t2
on t.uid=t2.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim t3 
on t.uid=t3.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim t4
on t.uid=t4.uid;


-- 7 近xm内提前30天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 30 -- 近xm内提前30天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid,mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 8 近xm内提前60天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 60 -- 近xm内提前60天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid,mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid,mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 9 近xm内提前90天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 90 -- 近xm内提前90天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid,mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 10 近xm内提前120天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 120 -- 近xm内提前120天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid,mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 11 近xm内提前150天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 150 -- 近xm内提前150天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid,mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

--12 近xm内提前180天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 180 -- 近xm内提前180天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

--13 近xm内提前360天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 360 -- 近xm内提前360天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid,  mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid,t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 14 
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_tim_cnt as 
select t.uid, t.mdl_dte,
  nvl(ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_rat
from ${dwa_risk}.dwa_risk_f_dz_model_data_base t
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt t_1m
on t.uid=t_1m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt t_2m
on t.uid=t_2m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt t_3m
on t.uid=t_3m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt t_4m
on t.uid=t_4m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt t_5m
on t.uid=t_5m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt t_6m
on t.uid=t_6m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt t_12m
on t.uid=t_12m.uid;


-- 15 近xm内提前30天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 30 -- 近xm内提前30天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 16 近xm内提前60天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 60 -- 近xm内提前60天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 17 近xm内提前90天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 90 -- 近xm内提前90天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 18 近xm内提前120天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 120 -- 近xm内提前120天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 19 近xm内提前150天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 150 -- 近xm内提前150天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 20 近xm内提前180天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 180 -- 近xm内提前180天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 21 近xm内提前360天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 360 -- 近xm内提前360天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;
-- 22
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_dte_cnt as 
select t.uid, t.mdl_dte,
  nvl(ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_rat
from ${dwa_risk}.dwa_risk_f_dz_model_data_base t
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt t_1m
on t.uid=t_1m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt t_2m
on t.uid=t_2m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt t_3m
on t.uid=t_3m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt t_4m
on t.uid=t_4m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt t_5m
on t.uid=t_5m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt t_6m
on t.uid=t_6m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt t_12m
on t.uid=t_12m.uid;

-- 23
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 30
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_1m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_1m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_1m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_1m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_1m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_1m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_1m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_1m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_1m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_1m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_1m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_1m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 24 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 60
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_2m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_2m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_2m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_2m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_2m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_2m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_2m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_2m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_2m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_2m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_2m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_2m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

--25
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 90
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_3m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_3m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_3m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_3m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_3m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_3m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_3m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_3m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_3m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_3m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_3m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_3m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 26 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 120
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_4m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_4m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_4m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_4m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_4m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_4m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_4m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_4m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_4m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_4m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_4m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_4m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 27
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 150
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_5m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_5m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_5m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_5m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_5m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_5m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_5m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_5m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_5m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_5m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_5m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_5m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 28 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 180
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_6m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_6m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_6m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_6m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_6m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_6m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_6m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_6m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_6m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_6m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_6m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_6m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 29 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 360
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_12m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_12m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_12m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_12m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_12m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_12m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_12m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_12m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_12m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_12m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_12m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_12m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 30 特征汇总
insert overwrite table ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_con_feature partition(ds='${bizdate}') 
select t.uid, 
  t.mdl_dte
  ,nvl(not_ovd_tqhk_rep_tim_cnt_1m,0) as not_ovd_tqhk_rep_tim_cnt_1m 
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_1m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_1m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_1m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_1m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_2m,0) as not_ovd_tqhk_rep_tim_cnt_2m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_2m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_2m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_2m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_2m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_3m,0) as not_ovd_tqhk_rep_tim_cnt_3m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_3m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_3m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_3m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_3m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_4m,0) as not_ovd_tqhk_rep_tim_cnt_4m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_4m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_4m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_4m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_4m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_5m,0) as not_ovd_tqhk_rep_tim_cnt_5m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_5m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_5m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_5m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_5m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_6m,0) as not_ovd_tqhk_rep_tim_cnt_6m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_6m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_6m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_6m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_6m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_12m,0) as not_ovd_tqhk_rep_tim_cnt_12m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_12m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_12m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_12m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_12m
from ${dwa_risk}.dwa_risk_f_dz_model_data_base t
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary t_1m
on t.uid=t_1m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary t_2m
on t.uid=t_2m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary t_3m
on t.uid=t_3m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary t_4m
on t.uid=t_4m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary t_5m
on t.uid=t_5m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary t_6m
on t.uid=t_6m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary t_12m
on t.uid=t_12m.uid;
-- feature-copilot:node-end ordinal=0

-- feature-copilot:node-begin ordinal=1
-- table_name: dwa_risk_dz_final_2tqhk_reptim_360d_con_feature
-- node_id: n_3952998082896068608
-- task_name: dwa_risk_dz_final_2tqhk_reptim_360d_con_feature_history
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_final_2tqhk_reptim_360d_con_feature.json
-- source_json_sha256: 30fc1e19868a7c4b0d4b0a40c1e62e0cc863121970885a8b465c2436779bd3f7
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base_temp
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: cdmx.cdmx_fct_heavy_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary
-- upstream_table: dwa_risk.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 郭卫勇
--创建日期: 2022-08-11 15:03:36
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
-- 临时表较多，在前置任务中删除，防止重跑
--********************************************************************--

drop table if exists ${dwa_risk}.dwa_risk_f_dz_model_data_base_temp;
create table ${dwa_risk}.dwa_risk_f_dz_model_data_base_temp as 
select uid
          ,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
        from ${dwt}.dwt_heavy_order_df 
       where ds = '${bizdate}' and loan_success_flag = 1 
       group by uid;


drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim;
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_feature1;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_tim_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_dte_cnt;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary;
drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary;


------------------【明细数据中间表】--------------------
--1 取近360天内的应还期
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg as
select model_data.uid,
      model_data.mdl_dte,
      concat_ws('&',model_data.uid,cast(model_data.mdl_dte as string),cast(date(t1.rep_dte) as string)) as kvp_mdl_rep_dte, -- 用于计算提前还款期数
      concat_ws('&',model_data.uid,cast(model_data.mdl_dte as string),cast(date(t1.rep_tim) as string)) as kvp_mdl_rep_tim, -- 用于计算提前还款次数
      case when date(t1.rep_tim)<date(t1.rep_dte) then 1 else 0 end as if_tqhk,
      datediff(date(model_data.mdl_dte),date(t1.rep_tim)) as ddf_mdl_dtl_rep_tim, -- 模型日与实还日之间的间隔
      t1.stg_pln_no as dtl_stg_pln_no,
      cast(date(t1.rep_dte) as string) as dtl_rep_dte,
      cast(date(t1.rep_tim) as string) as dtl_rep_tim,
      datediff(date(t1.rep_tim),date(t1.rep_dte)) as ddf_dtl_rep_tim_dte, -- 实还日与应还日之间的间隔
      -- 历史是否逾期flag
      case when t1.rep_tim is null or date(t1.rep_tim)>date(t1.rep_dte) then 1 else 0 end as ovd_rep_flg
from
      (select uid
        ,date(mdl_dte) as mdl_dte
    from ${dwa_risk}.dwa_risk_f_dz_model_data_base_temp
    ) model_data
inner join 
    (-- ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic t1  -- dbank.loan_f_stage_plan t1 )
       select  uid
        ,order_no as ord_no
        ,stage_plan_no as stg_pln_no
        -- ,business_type bsy_typ
        -- ,stage_plan_status stg_stt --放款成功取<>'R'
        -- ,a.dim_order_heavy.total_stage
        -- ,stage_no
        -- ,schedule_pay_principal prc_amt
        ,due_date as rep_dte
        ,settlement_time as rep_tim 
        -- ,current_overdue_status ovd_stt
        -- ,repay_type ded_typ
        -- ,crt_time
        -- ,loan_original_principal as raw_prc_amt
from cdmx.cdmx_fct_heavy_stage_plan_df a
where ds = '${bizdate}'
    ) t1
     on model_data.uid=t1.uid
inner join ( -- ${dwa_risk}.dwa_risk_f_heavy_order_info_basic t2-- dbank.loan_f_order_info 
select  uid
        ,order_no as ord_no
        ,business_type bsy_typ
from ${dwt}.dwt_heavy_order_df 
where ds = '${bizdate}'
and loan_success_flag = 1 
and business_type in ('BALANCE_TRANSFER', 'CASH')
) t2
     on t1.ord_no=t2.ord_no
-- inner join 
--       (select uid,ord_no as fst_ord_no,crt_tim as fst_ord_tim,
--               row_number() over(partition by uid order by fst_its_dte,crt_tim asc) rn
--       from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic 
--       where bsy_typ in ('BALANCE_TRANSFER', 'CASH')
--             and ord_stt_flg = 'success'
--       ) t3 on model_data.uid=t3.uid and rn = 1
where  datediff(date(model_data.mdl_dte),date(t1.rep_tim)) between 0 and 360
    --   and t2.bsy_typ in ('BALANCE_TRANSFER', 'CASH')
    --   and t2.ord_stt_flg = 'success' -- 成功订单
;


-- 2 次数/占比  近30/60/90/120/150/180/360天提前还款期数数/占比
-- -- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt as 
select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 and if_tqhk=1 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt,

  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_rep_dte_cnt
from 
(select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0
group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
) t 
group by uid, mdl_dte
;

-- 3 次数/占比  近30/60/90/120/150/180/360天提前还款次数/占比
-- -- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt as 
select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 and if_tqhk=1 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt,

  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_rep_tim_cnt
from 
(select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0
group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
) t 
group by uid, mdl_dte
;

-- 4 距今间隔 最近一次/两次提前还款距模型日间隔(天)
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim as 
select uid, mdl_dte,
  max(case when if_tqhk=1 and rep_tim_rn = 1 then datediff(date(mdl_dte),date(dtl_rep_tim)) end) as ddf_mdl_df_lst_not_ovd_tqhk_rep_tim,
  max(case when if_tqhk=1 and rep_tim_rn = 2 then datediff(date(mdl_dte),date(dtl_rep_tim)) end) as ddf_mdl_df_lst_2_not_ovd_tqhk_rep_tim,
  max(case when if_tqhk=1 and rep_tim_rn = 3 then datediff(date(mdl_dte),date(dtl_rep_tim)) end) as ddf_mdl_df_lst_3_not_ovd_tqhk_rep_tim
from 
  (select *,
    row_number()over(partition by uid, mdl_dte order by if_tqhk,dtl_rep_tim desc) rep_tim_rn 
  from 
    (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
    from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
    where ovd_rep_flg=0
    group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
    ) t 
  )tt 
group by uid, mdl_dte
;

-- 5 提前多少天还款
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim as 
select uid, mdl_dte,
  -- 近xm提前还款天数的平均值
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then ddf_dtl_rep_dte_tim end) as ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then ddf_dtl_rep_dte_tim end) as ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then ddf_dtl_rep_dte_tim end) as ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then ddf_dtl_rep_dte_tim end) as ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then ddf_dtl_rep_dte_tim end) as ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then ddf_dtl_rep_dte_tim end) as ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  avg(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then ddf_dtl_rep_dte_tim end) as ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg,
  -- 近xm提前还款天数的最大值
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then ddf_dtl_rep_dte_tim end) as ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then ddf_dtl_rep_dte_tim end) as ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then ddf_dtl_rep_dte_tim end) as ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then ddf_dtl_rep_dte_tim end) as ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then ddf_dtl_rep_dte_tim end) as ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then ddf_dtl_rep_dte_tim end) as ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  max(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then ddf_dtl_rep_dte_tim end) as ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max,
  -- 近xm提前还款天数的最小
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then ddf_dtl_rep_dte_tim end) as ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then ddf_dtl_rep_dte_tim end) as ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then ddf_dtl_rep_dte_tim end) as ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then ddf_dtl_rep_dte_tim end) as ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then ddf_dtl_rep_dte_tim end) as ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then ddf_dtl_rep_dte_tim end) as ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min,
  min(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then ddf_dtl_rep_dte_tim end) as ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
from 
(select uid,mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte, ddf_dtl_rep_tim_dte*(-1) as ddf_dtl_rep_dte_tim
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where if_tqhk=1
group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte, ddf_dtl_rep_tim_dte
) t 
group by uid,mdl_dte
;

-- 6 特征汇总
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_feature1;
create table if not exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_feature1 as 
select t.uid, t.mdl_dte
  ,nvl(ddf_1m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_2m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_3m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_4m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_5m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_6m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_12m_not_ovd_tqhk_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
  ,nvl(ddf_1m_not_ovd_rep_dte_cnt,0) as ddf_1m_not_ovd_rep_dte_cnt
  ,nvl(ddf_2m_not_ovd_rep_dte_cnt,0) as ddf_2m_not_ovd_rep_dte_cnt
  ,nvl(ddf_3m_not_ovd_rep_dte_cnt,0) as ddf_3m_not_ovd_rep_dte_cnt
  ,nvl(ddf_4m_not_ovd_rep_dte_cnt,0) as ddf_4m_not_ovd_rep_dte_cnt
  ,nvl(ddf_5m_not_ovd_rep_dte_cnt,0) as ddf_5m_not_ovd_rep_dte_cnt
  ,nvl(ddf_6m_not_ovd_rep_dte_cnt,0) as ddf_6m_not_ovd_rep_dte_cnt
  ,nvl(ddf_12m_not_ovd_rep_dte_cnt,0) as ddf_12m_not_ovd_rep_dte_cnt
  ,ddf_1m_not_ovd_tqhk_rep_dte_rat
  ,ddf_2m_not_ovd_tqhk_rep_dte_rat
  ,ddf_3m_not_ovd_tqhk_rep_dte_rat
  ,ddf_4m_not_ovd_tqhk_rep_dte_rat
  ,ddf_5m_not_ovd_tqhk_rep_dte_rat
  ,ddf_6m_not_ovd_tqhk_rep_dte_rat
  ,ddf_12m_not_ovd_tqhk_rep_dte_rat

  ,case when nvl(ddf_2m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_2m_not_ovd_tqhk_rep_dte_rat end as ddf_2m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_3m_not_ovd_tqhk_rep_dte_rat end as ddf_3m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_4m_not_ovd_tqhk_rep_dte_rat end as ddf_4m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_1m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_1m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_3m_not_ovd_tqhk_rep_dte_rat end as ddf_3m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_4m_not_ovd_tqhk_rep_dte_rat end as ddf_4m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_2m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_2m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_4m_not_ovd_tqhk_rep_dte_rat end as ddf_4m_to_3m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_3m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_3m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_3m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_dte_rat/ddf_5m_not_ovd_tqhk_rep_dte_rat end as ddf_5m_to_4m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_4m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_4m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_dte_rat/ddf_6m_not_ovd_tqhk_rep_dte_rat end as ddf_6m_to_5m_not_ovd_tqhk_rep_dte_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_5m_not_ovd_tqhk_rep_dte_rto

  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_dte_rat,0)=0 then null else ddf_6m_not_ovd_tqhk_rep_dte_rat/ddf_12m_not_ovd_tqhk_rep_dte_rat end as ddf_12m_to_6m_not_ovd_tqhk_rep_dte_rto

  ,nvl(ddf_1m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_2m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_3m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_4m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_5m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_6m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_12m_not_ovd_tqhk_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
  ,nvl(ddf_1m_not_ovd_rep_tim_cnt,0) as ddf_1m_not_ovd_rep_tim_cnt
  ,nvl(ddf_2m_not_ovd_rep_tim_cnt,0) as ddf_2m_not_ovd_rep_tim_cnt
  ,nvl(ddf_3m_not_ovd_rep_tim_cnt,0) as ddf_3m_not_ovd_rep_tim_cnt
  ,nvl(ddf_4m_not_ovd_rep_tim_cnt,0) as ddf_4m_not_ovd_rep_tim_cnt
  ,nvl(ddf_5m_not_ovd_rep_tim_cnt,0) as ddf_5m_not_ovd_rep_tim_cnt
  ,nvl(ddf_6m_not_ovd_rep_tim_cnt,0) as ddf_6m_not_ovd_rep_tim_cnt
  ,nvl(ddf_12m_not_ovd_rep_tim_cnt,0) as ddf_12m_not_ovd_rep_tim_cnt
  ,ddf_1m_not_ovd_tqhk_rep_tim_rat
  ,ddf_2m_not_ovd_tqhk_rep_tim_rat
  ,ddf_3m_not_ovd_tqhk_rep_tim_rat
  ,ddf_4m_not_ovd_tqhk_rep_tim_rat
  ,ddf_5m_not_ovd_tqhk_rep_tim_rat
  ,ddf_6m_not_ovd_tqhk_rep_tim_rat
  ,ddf_12m_not_ovd_tqhk_rep_tim_rat
    
  ,case when nvl(ddf_2m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_2m_not_ovd_tqhk_rep_tim_rat end as ddf_2m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_3m_not_ovd_tqhk_rep_tim_rat end as ddf_3m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_4m_not_ovd_tqhk_rep_tim_rat end as ddf_4m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_1m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_1m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_1m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_3m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_3m_not_ovd_tqhk_rep_tim_rat end as ddf_3m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_4m_not_ovd_tqhk_rep_tim_rat end as ddf_4m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_2m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_2m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_2m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_4m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_4m_not_ovd_tqhk_rep_tim_rat end as ddf_4m_to_3m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_3m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_3m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_3m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_3m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_5m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_tim_rat/ddf_5m_not_ovd_tqhk_rep_tim_rat end as ddf_5m_to_4m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_4m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_4m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_4m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_6m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_tim_rat/ddf_6m_not_ovd_tqhk_rep_tim_rat end as ddf_6m_to_5m_not_ovd_tqhk_rep_tim_rto
  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_5m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_5m_not_ovd_tqhk_rep_tim_rto

  ,case when nvl(ddf_12m_not_ovd_tqhk_rep_tim_rat,0)=0 then null else ddf_6m_not_ovd_tqhk_rep_tim_rat/ddf_12m_not_ovd_tqhk_rep_tim_rat end as ddf_12m_to_6m_not_ovd_tqhk_rep_tim_rto
     
  ,ddf_mdl_df_lst_not_ovd_tqhk_rep_tim
  ,ddf_mdl_df_lst_2_not_ovd_tqhk_rep_tim
  ,ddf_mdl_df_lst_3_not_ovd_tqhk_rep_tim

  ,ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg
  ,ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_avg

  ,ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  ,ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_max
  
  ,ddf_1m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_2m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_3m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_4m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_5m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_6m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
  ,ddf_12m_not_ovd_tqhk_ddf_dtl_rep_dte_tim_min
from ${dwa_risk}.dwa_risk_f_dz_model_data_base_temp t
left join 
  (select uid,mdl_dte,
    -- 期数
    ddf_1m_not_ovd_tqhk_rep_dte_cnt,
    ddf_2m_not_ovd_tqhk_rep_dte_cnt,
    ddf_3m_not_ovd_tqhk_rep_dte_cnt,
    ddf_4m_not_ovd_tqhk_rep_dte_cnt,
    ddf_5m_not_ovd_tqhk_rep_dte_cnt,
    ddf_6m_not_ovd_tqhk_rep_dte_cnt,
    ddf_12m_not_ovd_tqhk_rep_dte_cnt,
    ddf_1m_not_ovd_rep_dte_cnt,
    ddf_2m_not_ovd_rep_dte_cnt,
    ddf_3m_not_ovd_rep_dte_cnt,
    ddf_4m_not_ovd_rep_dte_cnt,
    ddf_5m_not_ovd_rep_dte_cnt,
    ddf_6m_not_ovd_rep_dte_cnt,
    ddf_12m_not_ovd_rep_dte_cnt,
    ddf_1m_not_ovd_tqhk_rep_dte_cnt/ddf_1m_not_ovd_rep_dte_cnt as ddf_1m_not_ovd_tqhk_rep_dte_rat,
    ddf_2m_not_ovd_tqhk_rep_dte_cnt/ddf_2m_not_ovd_rep_dte_cnt as ddf_2m_not_ovd_tqhk_rep_dte_rat,
    ddf_3m_not_ovd_tqhk_rep_dte_cnt/ddf_3m_not_ovd_rep_dte_cnt as ddf_3m_not_ovd_tqhk_rep_dte_rat,
    ddf_4m_not_ovd_tqhk_rep_dte_cnt/ddf_4m_not_ovd_rep_dte_cnt as ddf_4m_not_ovd_tqhk_rep_dte_rat,
    ddf_5m_not_ovd_tqhk_rep_dte_cnt/ddf_5m_not_ovd_rep_dte_cnt as ddf_5m_not_ovd_tqhk_rep_dte_rat,
    ddf_6m_not_ovd_tqhk_rep_dte_cnt/ddf_6m_not_ovd_rep_dte_cnt as ddf_6m_not_ovd_tqhk_rep_dte_rat,
    ddf_12m_not_ovd_tqhk_rep_dte_cnt/ddf_12m_not_ovd_rep_dte_cnt as ddf_12m_not_ovd_tqhk_rep_dte_rat
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_dte_cnt
  )t1 
on t.uid=t1.uid
left join 
  (select uid, mdl_dte,
    -- 次数
    ddf_1m_not_ovd_tqhk_rep_tim_cnt,
    ddf_2m_not_ovd_tqhk_rep_tim_cnt,
    ddf_3m_not_ovd_tqhk_rep_tim_cnt,
    ddf_4m_not_ovd_tqhk_rep_tim_cnt,
    ddf_5m_not_ovd_tqhk_rep_tim_cnt,
    ddf_6m_not_ovd_tqhk_rep_tim_cnt,
    ddf_12m_not_ovd_tqhk_rep_tim_cnt,
    ddf_1m_not_ovd_rep_tim_cnt,
    ddf_2m_not_ovd_rep_tim_cnt,
    ddf_3m_not_ovd_rep_tim_cnt,
    ddf_4m_not_ovd_rep_tim_cnt,
    ddf_5m_not_ovd_rep_tim_cnt,
    ddf_6m_not_ovd_rep_tim_cnt,
    ddf_12m_not_ovd_rep_tim_cnt,
    ddf_1m_not_ovd_tqhk_rep_tim_cnt/ddf_1m_not_ovd_rep_tim_cnt as ddf_1m_not_ovd_tqhk_rep_tim_rat,
    ddf_2m_not_ovd_tqhk_rep_tim_cnt/ddf_2m_not_ovd_rep_tim_cnt as ddf_2m_not_ovd_tqhk_rep_tim_rat,
    ddf_3m_not_ovd_tqhk_rep_tim_cnt/ddf_3m_not_ovd_rep_tim_cnt as ddf_3m_not_ovd_tqhk_rep_tim_rat,
    ddf_4m_not_ovd_tqhk_rep_tim_cnt/ddf_4m_not_ovd_rep_tim_cnt as ddf_4m_not_ovd_tqhk_rep_tim_rat,
    ddf_5m_not_ovd_tqhk_rep_tim_cnt/ddf_5m_not_ovd_rep_tim_cnt as ddf_5m_not_ovd_tqhk_rep_tim_rat,
    ddf_6m_not_ovd_tqhk_rep_tim_cnt/ddf_6m_not_ovd_rep_tim_cnt as ddf_6m_not_ovd_tqhk_rep_tim_rat,
    ddf_12m_not_ovd_tqhk_rep_tim_cnt/ddf_12m_not_ovd_rep_tim_cnt as ddf_12m_not_ovd_tqhk_rep_tim_rat
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_rep_tim_cnt
  )t2
on t.uid=t2.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_rep_tim t3 
on t.uid=t3.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf_dtl_rep_dte_tim t4
on t.uid=t4.uid;


-- 7 近xm内提前30天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 30 -- 近xm内提前30天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid,mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 8 近xm内提前60天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 60 -- 近xm内提前60天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid,mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid,mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 9 近xm内提前90天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 90 -- 近xm内提前90天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid,mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 10 近xm内提前120天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 120 -- 近xm内提前120天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid,mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 11 近xm内提前150天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 150 -- 近xm内提前150天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid,mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

--12 近xm内提前180天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 180 -- 近xm内提前180天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

--13 近xm内提前360天还款的次数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt
from 
  (select uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 360 -- 近xm内提前360天以上还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_tim end) as ddf_1m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_tim end) as ddf_2m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_tim end) as ddf_3m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_tim end) as ddf_4m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_tim end) as ddf_5m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_tim end) as ddf_6m_not_ovd_tqhk_rep_tim_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_tim end) as ddf_12m_not_ovd_tqhk_rep_tim_cnt
from 
  (select uid,  mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款次数
  group by uid, mdl_dte, dtl_rep_tim, if_tqhk, kvp_mdl_rep_tim
  )tt
group by uid, mdl_dte
)
select t1.uid,t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_1m_not_ovd_tqhk_rep_tim_cnt as ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_2m_not_ovd_tqhk_rep_tim_cnt as ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_3m_not_ovd_tqhk_rep_tim_cnt as ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_4m_not_ovd_tqhk_rep_tim_cnt as ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_5m_not_ovd_tqhk_rep_tim_cnt as ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_6m_not_ovd_tqhk_rep_tim_cnt as ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt/ddf_12m_not_ovd_tqhk_rep_tim_cnt as ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 14 
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_tim_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_tim_cnt as 
select t.uid, t.mdl_dte,
  nvl(ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_tim_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt,0) as ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_tim_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_tim_rat
from ${dwa_risk}.dwa_risk_f_dz_model_data_base_temp t
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_tim_cnt t_1m
on t.uid=t_1m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_tim_cnt t_2m
on t.uid=t_2m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_tim_cnt t_3m
on t.uid=t_3m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_tim_cnt t_4m
on t.uid=t_4m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_tim_cnt t_5m
on t.uid=t_5m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_tim_cnt t_6m
on t.uid=t_6m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_tim_cnt t_12m
on t.uid=t_12m.uid;


-- 15 近xm内提前30天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 30 -- 近xm内提前30天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_rat
from tablea t1 
left join tableb t2 
on t1.uid=t2.uid
;

-- 16 近xm内提前60天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 60 -- 近xm内提前60天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 17 近xm内提前90天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 90 -- 近xm内提前90天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 18 近xm内提前120天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 120 -- 近xm内提前120天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 19 近xm内提前150天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 150 -- 近xm内提前150天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 20 近xm内提前180天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 180 -- 近xm内提前180天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;

-- 21 近xm内提前360天还款的期数
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt as 
with tablea as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 and ddf_dtl_rep_tim_dte*(-1) > 360 -- 近xm内提前360天以上还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )t
group by uid, mdl_dte
),
tableb as
(select uid, mdl_dte,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 30 then kvp_mdl_rep_dte end) as ddf_1m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 60 then kvp_mdl_rep_dte end) as ddf_2m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 90 then kvp_mdl_rep_dte end) as ddf_3m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 120 then kvp_mdl_rep_dte end) as ddf_4m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 150 then kvp_mdl_rep_dte end) as ddf_5m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 180 then kvp_mdl_rep_dte end) as ddf_6m_not_ovd_tqhk_rep_dte_cnt,
  count(case when datediff(date(mdl_dte),date(dtl_rep_tim)) between 0 and 360 then kvp_mdl_rep_dte end) as ddf_12m_not_ovd_tqhk_rep_dte_cnt
from 
  (select uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
  where if_tqhk=1 -- 近xm内提前3还款期数
  group by uid, mdl_dte, dtl_stg_pln_no, dtl_rep_tim, if_tqhk, kvp_mdl_rep_dte
  )tt
group by uid, mdl_dte
)
select t1.uid, t1.mdl_dte,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_1m_not_ovd_tqhk_rep_dte_cnt as ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_2m_not_ovd_tqhk_rep_dte_cnt as ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_3m_not_ovd_tqhk_rep_dte_cnt as ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_4m_not_ovd_tqhk_rep_dte_cnt as ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_5m_not_ovd_tqhk_rep_dte_cnt as ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_6m_not_ovd_tqhk_rep_dte_cnt as ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt/ddf_12m_not_ovd_tqhk_rep_dte_cnt as ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_rat
from tablea t1 
left join tableb t2 
on  t1.uid=t2.uid
;
-- 22
drop table if exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_dte_cnt;
create table if not exists ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_ddfup_rep_dte_cnt as 
select t.uid, t.mdl_dte,
  nvl(ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf30up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf30up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf60up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf60up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf90up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf90up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf120up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf120up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf150up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf150up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf180up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf180up_rep_dte_rat,

  nvl(ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  nvl(ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt,0) as ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_cnt,
  ddf_1m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_2m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_3m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_4m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_5m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_6m_not_ovd_tqhk_ddf360up_rep_dte_rat,
  ddf_12m_not_ovd_tqhk_ddf360up_rep_dte_rat
from ${dwa_risk}.dwa_risk_f_dz_model_data_base_temp t
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf30up_rep_dte_cnt t_1m
on t.uid=t_1m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf60up_rep_dte_cnt t_2m
on t.uid=t_2m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf90up_rep_dte_cnt t_3m
on t.uid=t_3m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf120up_rep_dte_cnt t_4m
on t.uid=t_4m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf150up_rep_dte_cnt t_5m
on t.uid=t_5m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf180up_rep_dte_cnt t_6m
on t.uid=t_6m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_ddf360up_rep_dte_cnt t_12m
on t.uid=t_12m.uid;

-- 23
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 30
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_1m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_1m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_1m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_1m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_1m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_1m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_1m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_1m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_1m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_1m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_1m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_1m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 24 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 60
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_2m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_2m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_2m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_2m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_2m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_2m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_2m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_2m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_2m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_2m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_2m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_2m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

--25
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 90
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_3m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_3m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_3m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_3m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_3m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_3m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_3m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_3m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_3m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_3m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_3m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_3m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 26 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 120
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_4m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_4m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_4m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_4m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_4m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_4m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_4m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_4m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_4m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_4m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_4m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_4m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 27
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 150
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_5m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_5m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_5m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_5m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_5m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_5m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_5m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_5m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_5m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_5m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_5m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_5m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 28 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 180
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_6m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_6m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_6m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_6m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_6m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_6m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_6m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_6m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_6m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_6m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_6m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_6m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 29 
-- drop table if exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary;
create table if not exists ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary as 
with tablea as 
(select uid, mdl_dte,
  dtl_rep_tim, if_tqhk
from ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_360d_byplan_flg
where ovd_rep_flg=0 
  and ddf_mdl_dtl_rep_tim between 1 and 360
group by uid, mdl_dte,
  dtl_rep_tim, if_tqhk
)
select uid, mdl_dte
  ,not_ovd_tqhk_rep_tim_cnt_12m -- 近1m内提前还款次数
  -- ,max_not_ovd_tqhk_rep_tim_12m -- 近1m内最近提前还款日期
  ,max_con_not_ovd_tqhk_rep_tim_cnt_12m -- 近1m最大连续提前还款次数
  -- ,max_con_not_ovd_tqhk_rep_tim_12m -- 近1m最大连续提前还款次数结束日期
  ,datediff(date(mdl_dte),date(max_not_ovd_tqhk_rep_tim_12m)) as ddf_mdl_max_not_ovd_tqhk_rep_tim_12m
  ,datediff(date(mdl_dte),date(max_con_not_ovd_tqhk_rep_tim_12m)) as ddf_mdl_max_con_not_ovd_tqhk_rep_tim_12m
from 
(select uid, mdl_dte
  ,sum(con_not_ovd_tqhk_rep_tim_dts) as not_ovd_tqhk_rep_tim_cnt_12m 
  ,max(max_not_ovd_tqhk_rep_tim) as max_not_ovd_tqhk_rep_tim_12m
  ,max(con_not_ovd_tqhk_rep_tim_dts) as max_con_not_ovd_tqhk_rep_tim_cnt_12m
  ,max(case when con_not_ovd_tqhk_rep_tim_dts >=2 and con_not_ovd_tqhk_rep_tim_rn = 1 then max_not_ovd_tqhk_rep_tim end) as max_con_not_ovd_tqhk_rep_tim_12m

from 
  (select uid, mdl_dte
    ,grp
    ,con_not_ovd_tqhk_rep_tim_dts
    ,min_not_ovd_tqhk_rep_tim
    ,max_not_ovd_tqhk_rep_tim
    ,row_number() over(partition by uid order by con_not_ovd_tqhk_rep_tim_dts desc,max_not_ovd_tqhk_rep_tim desc) con_not_ovd_tqhk_rep_tim_rn
  from
    (select uid, mdl_dte
      ,grp
      ,count(not_ovd_tqhk_rep_tim_rn) AS con_not_ovd_tqhk_rep_tim_dts
      ,min(dtl_rep_tim) AS min_not_ovd_tqhk_rep_tim
      ,max(dtl_rep_tim) AS max_not_ovd_tqhk_rep_tim

    from 
      (select uid, mdl_dte,
        dtl_rep_tim, 
        not_ovd_rep_tim_rn, 
        row_number() over (partition by uid order by not_ovd_rep_tim_rn) as not_ovd_tqhk_rep_tim_rn, 
        not_ovd_rep_tim_rn - row_number() over (partition by uid order by dtl_rep_tim) AS grp
      from
        (select *,
          row_number() over (partition by uid order by dtl_rep_tim) as not_ovd_rep_tim_rn
        from tablea
        )t1 
      where if_tqhk=1
      )t2 
    group by uid, mdl_dte
      ,grp
    )t3 
  )t4 
group by uid, mdl_dte
)t5;

-- 30 特征汇总
insert overwrite table ${dwa_risk}.dwa_risk_dz_final_2tqhk_reptim_360d_con_feature partition(ds='${bizdate}') 
select t.uid, 
  t.mdl_dte
  ,nvl(not_ovd_tqhk_rep_tim_cnt_1m,0) as not_ovd_tqhk_rep_tim_cnt_1m 
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_1m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_1m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_1m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_1m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_2m,0) as not_ovd_tqhk_rep_tim_cnt_2m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_2m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_2m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_2m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_2m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_3m,0) as not_ovd_tqhk_rep_tim_cnt_3m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_3m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_3m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_3m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_3m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_4m,0) as not_ovd_tqhk_rep_tim_cnt_4m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_4m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_4m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_4m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_4m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_5m,0) as not_ovd_tqhk_rep_tim_cnt_5m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_5m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_5m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_5m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_5m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_6m,0) as not_ovd_tqhk_rep_tim_cnt_6m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_6m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_6m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_6m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_6m
  ,nvl(not_ovd_tqhk_rep_tim_cnt_12m,0) as not_ovd_tqhk_rep_tim_cnt_12m
  ,nvl(max_con_not_ovd_tqhk_rep_tim_cnt_12m,0) as max_con_not_ovd_tqhk_rep_tim_cnt_12m
  ,ddf_mdl_max_not_ovd_tqhk_rep_tim_12m
  ,ddf_mdl_max_con_not_ovd_tqhk_rep_tim_12m
from ${dwa_risk}.dwa_risk_f_dz_model_data_base_temp t
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_1m_con_summary t_1m
on t.uid=t_1m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_2m_con_summary t_2m
on t.uid=t_2m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_3m_con_summary t_3m
on t.uid=t_3m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_4m_con_summary t_4m
on t.uid=t_4m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_5m_con_summary t_5m
on t.uid=t_5m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_6m_con_summary t_6m
on t.uid=t_6m.uid
left join ${dwa_risk}.dwa_risk_dz_temp_2tqhk_reptim_12m_con_summary t_12m
on t.uid=t_12m.uid;
-- feature-copilot:node-end ordinal=1
