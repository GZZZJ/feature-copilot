-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_ability_derived_df
-- node_id: n_3786401455443738624
-- task_name: dwa_risk_dz_model_final_12his_rep_ability_derived_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_ability_derived_df.json
-- source_json_sha256: 2689de32efa5ba74e05cb09a6bef04395c07e3ce1df00cbd23a0cc0a54ea8dc6
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的 dmining.dz_model_final_12his_rep_ability_derived
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_derived_df partition(ds='${bizdate}')
select uid
        ,mdl_dte
-- features range start --

        -- ------------------repment表衍生--------------------
        -- 衍生--实还金额的变化
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_1m_his/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_1m_3m_rto_his
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_3m_his/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_3m_6m_rto_his
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_6m_his/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_6m_12m_rto_his

        ----每种不同的还款方式的实还金额占比
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_adv/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_adv_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_adv/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_adv_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_adv/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_adv_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_adv/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_adv_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_adv/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_adv_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_dwn_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_dwn_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_dwn_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_dwn_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_dwn_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_dwn_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_mrn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_mrn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_mrn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_mrn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_mrn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_mrn_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_mrn_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_mrn_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_mrn_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_mrn_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_mrn_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_non_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_non_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_non_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_non_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_non_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_non_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_non_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_non_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_non_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_non_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_afn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_afn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_afn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_afn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_afn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_afn_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_afn_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_afn_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_afn_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_afn_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_afn_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_afn_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_afn_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_afn_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_afn_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_d0_evn_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_d0_evn_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_d0_evn_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_d0_evn_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_d0_evn_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_d0_evn_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_d0_evn_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_d0_evn_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_d0_evn_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_d0_evn_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_m2_pls_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_m2_pls_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_m2_pls_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_m2_pls_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_m2_pls_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_m2_pls_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_14d_pls_30d_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_14d_pls_30d_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_14d_pls_30d_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_14d_pls_30d_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_14d_pls_30d_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_7d_pls_14d_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_7d_pls_14d_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_7d_pls_14d_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_7d_pls_14d_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_7d_pls_14d_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_3d_pls_7d_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_3d_pls_7d_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_3d_pls_7d_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_3d_pls_7d_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_3d_pls_7d_zd_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_mrn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_afn_pk_rto
        ,case when stg_pln_sum_rep_prc_his=0 then null else stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd/stg_pln_sum_rep_prc_his end as stg_pln_sum_rep_prc_his_ovd_0d_pls_3d_zd_rto
        ,case when stg_pln_sum_rep_prc_1m_his=0 then null else stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd/stg_pln_sum_rep_prc_1m_his end as stg_pln_sum_rep_prc_1m_his_ovd_0d_pls_3d_zd_rto
        ,case when stg_pln_sum_rep_prc_3m_his=0 then null else stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd/stg_pln_sum_rep_prc_3m_his end as stg_pln_sum_rep_prc_3m_his_ovd_0d_pls_3d_zd_rto
        ,case when stg_pln_sum_rep_prc_6m_his=0 then null else stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd/stg_pln_sum_rep_prc_6m_his end as stg_pln_sum_rep_prc_6m_his_ovd_0d_pls_3d_zd_rto
        ,case when stg_pln_sum_rep_prc_12m_his=0 then null else stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd/stg_pln_sum_rep_prc_12m_his end as stg_pln_sum_rep_prc_12m_his_ovd_0d_pls_3d_zd_rto

-- features range end --
from (select * 
        from ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_df 
        where ds='${bizdate}'
        ) a 
;
-- feature-copilot:node-end ordinal=0
