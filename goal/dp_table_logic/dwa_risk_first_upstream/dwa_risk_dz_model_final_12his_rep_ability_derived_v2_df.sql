-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_ability_derived_v2_df
-- node_id: n_5758640645250416640
-- task_name: 12his_rep_ability_derived_v2
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_ability_derived_v2_df.json
-- source_json_sha256: 9fc05827af67c900a4756fd044fde842b75dc6adf472e419209d333c42ecba46
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_v2_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 牛莲泽
--创建日期: 2024-04-23 19:07:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_derived_v2_df partition(ds='${bizdate}')
select repay_v2.uid
      ,repay_v2.mdl_dte
-- features range start --

        -- ------------------repment表衍生--------------------
        ----每种不同的还款方式的实还金额占比
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_non_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd_rto_v2

-- features range end --
from (select * from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_v2_df where ds='${bizdate}') repay_v2
left join
(
    select uid,
        stg_pln_sum_rep_prc_his,
        stg_pln_sum_rep_prc_1m_his,
        stg_pln_sum_rep_prc_3m_his,
        stg_pln_sum_rep_prc_6m_his,
        stg_pln_sum_rep_prc_12m_his
    from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_df
    where ds='${bizdate}'
) repay
on repay_v2.uid=repay.uid;
-- feature-copilot:node-end ordinal=0

-- feature-copilot:node-begin ordinal=1
-- table_name: dwa_risk_dz_model_final_12his_rep_ability_derived_v2_df
-- node_id: n_3786822396598484992
-- task_name: dwa_risk_dz_model_final_12his_rep_ability_derived_v2_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_ability_derived_v2_df.json
-- source_json_sha256: 9fc05827af67c900a4756fd044fde842b75dc6adf472e419209d333c42ecba46
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_v2_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的 dmining.dz_model_final_12his_rep_ability_derived_v2
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_derived_v2_df partition(ds='${bizdate}')
select repay_v2.uid
      ,repay_v2.mdl_dte
-- features range start --

        -- ------------------repment表衍生--------------------
        ----每种不同的还款方式的实还金额占比
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_non_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_non_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_non_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_afn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_afn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_evn_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_evn_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk_rto_v2
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd_rto_v2
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd_v2/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd_rto_v2

-- features range end --
from (select * from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_v2_df where ds='${bizdate}') repay_v2
left join
(
    select uid,
        stg_pln_sum_rep_prc_his,
        stg_pln_sum_rep_prc_1m_his,
        stg_pln_sum_rep_prc_3m_his,
        stg_pln_sum_rep_prc_6m_his,
        stg_pln_sum_rep_prc_12m_his
    from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_df
    where ds='${bizdate}'
) repay
on repay_v2.uid=repay.uid;
-- feature-copilot:node-end ordinal=1
