-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_5account_extra_df
-- node_id: n_3769224919154294784
-- task_name: dwa_risk_dz_model_final_5account_extra_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_5account_extra_df.json
-- source_json_sha256: 44668c873a0680a569f109f035813ada36d21c5a9b3917240b218d220f3f83aa
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_5account_extra_tmp1
-- upstream_table: cdmx.cdmx_dim_credit_account_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_5account_extra_tmp2

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_final_5account_extra
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_5account_extra_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_5account_extra_tmp1 as
select model_data.uid
       ,mdl_dte
       ,max(adt_lmt) as adt_lmt
from 
  (select uid,mdl_dte
  from ${dwa_risk}.dwa_risk_f_dz_model_data_base
  ) model_data

left join
  (
--   select uid
--         ,max(risk_admit_limit) adt_lmt
--   from ${ld_loan}.dim_account_info 
--   where ds = '${bizdate}'
--   -- and bsy_typ in 
--    group by uid
  select uid
        ,max(latest_risk_credit_limit) adt_lmt
  from cdmx.cdmx_dim_credit_account_df
  where ds = '${bizdate}'
  group by uid
  ) account_temp on model_data.uid = account_temp.uid 

  group by model_data.uid,mdl_dte;



drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_5account_extra_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_5account_extra_tmp2 as
select uid
        ,mdl_dte
        ,time
        ,bsy_typ_history
        ,ord_no_history
        ,adt_lmt
        ,used_lmt
        ,adt_lmt-used_lmt as avb_lmt
        ,round(used_lmt/adt_lmt,6) as lmt_use_rate
        ,rw
from    (select uid
                ,mdl_dte
                ,time
                ,bsy_typ_history
                ,ord_no_history
                ,adt_lmt
                ,sum(principle) over (partition by uid order by time) as used_lmt
                ,row_number() over(partition by uid order by time desc) as rw
        from 
                (select model_data.uid
                        ,model_data.mdl_dte
                        ,adt_lmt
                        ,(case when time is null or to_date(time) >= model_data.mdl_dte then 0 else order_info_union_stage_plan.principle end)*drt as principle
                        ,time
                        ,bsy_typ_history
                        ,ord_no_history
                        ,to_date(time) as day
                        ,rep_dte
                        ,order_info_union_stage_plan.principle as principle_2

                from (select uid,mdl_dte
                      from ${dwa_risk}.dwa_risk_f_dz_model_data_base
                      ) model_data

                join
                    (select uid
                            ,bsy_typ as bsy_typ_history
                            ,ord_no as ord_no_history
                            ,case when prc_amt is null then 0 else prc_amt end as principle
                            ,1 as drt
                            ,crt_tim as time
                            ,NULL as rep_dte
                    from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic
                    where bsy_typ in ('BALANCE_TRANSFER', 'CASH') and ord_stt_flg = 'success'
                    
                    union all     
                    select uid
                            ,NULL as bsy_typ_history
                            ,NULL as ord_no_history
                            ,case when prc_amt is null then 0 else  prc_amt end as principle
                            ,-1 as drt
                            ,rep_tim as time
                            ,rep_dte
                    from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic
                    where bsy_typ in ('BALANCE_TRANSFER', 'CASH') and stg_stt <> 'R'
                    ) as order_info_union_stage_plan on model_data.uid = order_info_union_stage_plan.uid
                
                left join ${dwa_risk}.dwa_risk_dz_model_final_5account_extra_tmp1 as f_account on model_data.uid = f_account.uid and model_data.mdl_dte = f_account.mdl_dte
                   
                )  as detail
        ) as ordered_detail 
    ;


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_5account_extra_df partition(ds='${bizdate}') 
select uid
        ,mdl_dte
-- features range start --
       -- ,adt_lmt
       ,round(cur_avb_lmt_v2,6) as b_cur_ord_avb_lmt_v3
       ,round(cur_lmt_use_rat_v2,6) as b_cur_ord_lmt_rat_v3
       ,round(cur_avb_lmt_v2+prc_amt,6) as cur_avb_lmt_v2
       ,round(case when avg_lmt_use_rat_2m_v2 is null then -999 else avg_lmt_use_rat_2m_v2 end,6) as avg_lmt_use_rat_2m_v2
       ,round(case when avg_lmt_use_rat_1m_v2 is null then -999 else avg_lmt_use_rat_1m_v2 end,6) as avg_lmt_use_rat_1m_v2
       ,round(case when avg_avb_lmt_1m_v2 is null then -999 else avg_avb_lmt_1m_v2 end,6) as avg_avb_lmt_1m_v2
       ,round(sum_avb_lmt_1m_v2,6) as sum_avb_lmt_1m_v2
       ,round(cnt_avb_lmt_1m_v2,6) as cnt_avb_lmt_1m_v2
       ,round(sum_avb_lmt_2m_v2,6) as sum_avb_lmt_2m_v2
       ,round(cnt_avb_lmt_2m_v2,6) as cnt_avb_lmt_2m_v2
       ,round(case when avg_avb_lmt_2m_v2 is null then -999 else avg_avb_lmt_2m_v2 end,6) as avg_avb_lmt_2m_v2    

-- features range end --
from 
    (
        select uid
                ,mdl_dte
                -- ,mdl_dte
                ,0 as prc_amt
                ,adt_lmt
                ,max(case when rw=1 then avb_lmt else 0 end) as cur_avb_lmt_v2
                ,max(case when rw=1 then lmt_use_rate else 0 end) as cur_lmt_use_rat_v2
                ,round(sum(case when date(time) >= date_add(add_months(date(mdl_dte),-1),1) and date(time) < date(mdl_dte) then avb_lmt else null end)/count(case when date(time) >= date_add(add_months(date(mdl_dte),-1),1) and date(time) < date(mdl_dte) then avb_lmt else null end),6) as avg_avb_lmt_1m_v2
                ,round(sum(case when date(time) >= date_add(add_months(date(mdl_dte),-2),1) and date(time) < date(mdl_dte) then avb_lmt else null end)/count(case when date(time) >= date_add(add_months(date(mdl_dte),-2),1) and date(time) < date(mdl_dte) then avb_lmt else null end),6) as avg_avb_lmt_2m_v2
                ,sum(case when date(time) >= date_add(add_months(date(mdl_dte),-1),1) and date(time) < date(mdl_dte) then avb_lmt else null end) as sum_avb_lmt_1m_v2
                ,count(case when date(time) >= date_add(add_months(date(mdl_dte),-1),1) and date(time) < date(mdl_dte) then avb_lmt else null end) as cnt_avb_lmt_1m_v2
                ,sum(case when date(time) >= date_add(add_months(date(mdl_dte),-2),1) and date(time) < date(mdl_dte) then avb_lmt else null end) as sum_avb_lmt_2m_v2
                ,count(case when date(time) >= date_add(add_months(date(mdl_dte),-2),1) and date(time) < date(mdl_dte) then avb_lmt else null end) as cnt_avb_lmt_2m_v2
                ,round(sum(case when date(time) >= date_add(add_months(date(mdl_dte),-2),1) and date(time) < date(mdl_dte) then lmt_use_rate else null end)/count(case when date(time) >= date_add(add_months(date(mdl_dte),-2),1) and date(time) < date(mdl_dte) then lmt_use_rate else null end),6) as avg_lmt_use_rat_2m_v2
                ,round(sum(case when date(time) >= date_add(add_months(date(mdl_dte),-1),1) and date(time) < date(mdl_dte) then lmt_use_rate else null end)/count(case when date(time) >= date_add(add_months(date(mdl_dte),-1),1) and date(time) < date(mdl_dte) then lmt_use_rate else null end),6) as avg_lmt_use_rat_1m_v2
        
        from ${dwa_risk}.dwa_risk_dz_model_final_5account_extra_tmp2 as temp
        group by uid,mdl_dte,adt_lmt
    ) as a;
-- feature-copilot:node-end ordinal=0
