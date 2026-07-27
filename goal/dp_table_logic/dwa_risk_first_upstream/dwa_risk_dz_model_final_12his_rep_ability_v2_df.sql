-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12his_rep_ability_v2_df
-- node_id: n_3786377472346554368
-- task_name: dwa_risk_dz_model_final_12his_rep_ability_v2_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12his_rep_ability_v2_df.json
-- source_json_sha256: 9f5eda039231a7f220d054a75819799574c4c32a646a34118598b98d3ef6359f
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_12his_rep_ability_v2_tmp3

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的 dmining.dz_model_final_12his_rep_ability_v2
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--



insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_v2_df partition(ds='${bizdate}')
select model_data.uid
        ,model_data.mdl_dte
-- features range start --
        ----------------------------------------------------------
        --/*12.1.2 历史还款能力*/
        ----------------------------------------------------------
        ---------按照还款方式计算还款金额---------
        ,repayment.lst_rep_typ_v2

        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_dwn_zd_v2,0) as stg_pln_sum_rep_prc_his_d0_dwn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_v2,0) as stg_pln_sum_rep_prc_1m_his_d0_dwn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_v2,0) as stg_pln_sum_rep_prc_3m_his_d0_dwn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_v2,0) as stg_pln_sum_rep_prc_6m_his_d0_dwn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_v2,0) as stg_pln_sum_rep_prc_12m_his_d0_dwn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_mrn_pk_v2,0) as stg_pln_sum_rep_prc_his_d0_mrn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_v2,0) as stg_pln_sum_rep_prc_1m_his_d0_mrn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_v2,0) as stg_pln_sum_rep_prc_3m_his_d0_mrn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_v2,0) as stg_pln_sum_rep_prc_6m_his_d0_mrn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_v2,0) as stg_pln_sum_rep_prc_12m_his_d0_mrn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_mrn_zd_v2,0) as stg_pln_sum_rep_prc_his_d0_mrn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_v2,0) as stg_pln_sum_rep_prc_1m_his_d0_mrn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_v2,0) as stg_pln_sum_rep_prc_3m_his_d0_mrn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_v2,0) as stg_pln_sum_rep_prc_6m_his_d0_mrn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_v2,0) as stg_pln_sum_rep_prc_12m_his_d0_mrn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_non_zd_v2,0) as stg_pln_sum_rep_prc_his_d0_non_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_non_zd_v2,0) as stg_pln_sum_rep_prc_1m_his_d0_non_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_non_zd_v2,0) as stg_pln_sum_rep_prc_3m_his_d0_non_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_non_zd_v2,0) as stg_pln_sum_rep_prc_6m_his_d0_non_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_non_zd_v2,0) as stg_pln_sum_rep_prc_12m_his_d0_non_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_afn_pk_v2,0) as stg_pln_sum_rep_prc_his_d0_afn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_afn_pk_v2,0) as stg_pln_sum_rep_prc_1m_his_d0_afn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_afn_pk_v2,0) as stg_pln_sum_rep_prc_3m_his_d0_afn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_afn_pk_v2,0) as stg_pln_sum_rep_prc_6m_his_d0_afn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_afn_pk_v2,0) as stg_pln_sum_rep_prc_12m_his_d0_afn_pk_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_afn_zd_v2,0) as stg_pln_sum_rep_prc_his_d0_afn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_afn_zd_v2,0) as stg_pln_sum_rep_prc_1m_his_d0_afn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_afn_zd_v2,0) as stg_pln_sum_rep_prc_3m_his_d0_afn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_afn_zd_v2,0) as stg_pln_sum_rep_prc_6m_his_d0_afn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_afn_zd_v2,0) as stg_pln_sum_rep_prc_12m_his_d0_afn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_his_d0_evn_zd_v2,0) as stg_pln_sum_rep_prc_his_d0_evn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_1m_his_d0_evn_zd_v2,0) as stg_pln_sum_rep_prc_1m_his_d0_evn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_3m_his_d0_evn_zd_v2,0) as stg_pln_sum_rep_prc_3m_his_d0_evn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_6m_his_d0_evn_zd_v2,0) as stg_pln_sum_rep_prc_6m_his_d0_evn_zd_v2
        ,coalesce(repayment.stg_pln_sum_rep_prc_12m_his_d0_evn_zd_v2,0) as stg_pln_sum_rep_prc_12m_his_d0_evn_zd_v2

-- features range end --
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_12his_rep_ability_v2_tmp3 repayment on model_data.uid=repayment.uid
;
-- feature-copilot:node-end ordinal=0
