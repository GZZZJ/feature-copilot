-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_31light_credit_trade_cross_df
-- node_id: n_6903465552388751360
-- task_name: dwa_risk_dz_model_final_31light_credit_trade_cross_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_31light_credit_trade_cross_df.json
-- source_json_sha256: 7960d9af87251d65d406e2553b7ade91f142f26e51c25f53c7ca31a12c649f2e
-- upstream_table: cdmx.cdmx_fct_light_loan_order_df
-- upstream_table: dwa_risk.dwa_risk_f_light_sample_all_base_df
-- upstream_table: dwa_risk.dwa_risk_f_light_credit_data_base_df
-- upstream_table: dwa_risk.dwa_risk_light_feature_part1_df_tmp2
-- upstream_table: dwa_risk.dwa_risk_light_feature_part1_df_tmp1
-- upstream_table: dwa_risk.dwa_risk_light_feature_part1_df_tmp3

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 牛莲泽
--创建日期: 2025-05-12 18:21:05
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_final_31light_credit_trade_cross_df
-- (
--     uid STRING comment 'uid',
--     mdl_dte STRING comment '打分日',
--     credit_cnt_all BIGINT comment '历史轻资产授信次数',
--     credit_cnt_1m BIGINT comment '近1月轻资产授信次数',
--     credit_cnt_3m BIGINT comment '近3月轻资产授信次数',
--     credit_cnt_6m BIGINT comment '近6月轻资产授信次数',
--     credit_cnt_12m BIGINT comment '近12月轻资产授信次数',
--     credit_cnt_24m BIGINT comment '近24月轻资产授信次数',
--     credit_cnt_36m BIGINT comment '近36月轻资产授信次数',
--     credit_reject_cnt_all BIGINT comment '历史轻资产授信拒绝次数',
--     credit_reject_cnt_1m BIGINT comment '近1月轻资产授信拒绝次数',
--     credit_reject_cnt_3m BIGINT comment '近3月轻资产授信拒绝次数',
--     credit_reject_cnt_6m BIGINT comment '近6月轻资产授信拒绝次数',
--     credit_reject_cnt_12m BIGINT comment '近12月轻资产授信拒绝次数',
--     credit_reject_cnt_24m BIGINT comment '近24月轻资产授信拒绝次数',
--     credit_reject_cnt_36m BIGINT comment '近36月轻资产授信拒绝次数',
--     credit_ratio_all DOUBLE comment '历史轻资产授信通过率',
--     credit_ratio_1m DOUBLE comment '近1月轻资产授信通过率',
--     credit_ratio_3m DOUBLE comment '近3月轻资产授信通过率',
--     credit_ratio_6m DOUBLE comment '近6月轻资产授信通过率',
--     credit_ratio_12m DOUBLE comment '近12月轻资产授信通过率',
--     credit_ratio_24m DOUBLE comment '近24月轻资产授信通过率',
--     credit_ratio_36m DOUBLE comment '近36月轻资产授信通过率',
--     credit_limit_cnt_all FLOAT comment '历史轻资产授信总额度',
--     credit_limit_cnt_1m FLOAT comment '近1月轻资产授信总额度',
--     credit_limit_cnt_3m FLOAT comment '近3月轻资产授信总额度',
--     credit_limit_cnt_6m FLOAT comment '近6月轻资产授信总额度',
--     credit_limit_cnt_12m FLOAT comment '近12月轻资产授信总额度',
--     credit_limit_cnt_24m FLOAT comment '近24月轻资产授信总额度',
--     credit_limit_cnt_36m FLOAT comment '近36月轻资产授信总额度',
--     credit_avg_limit_cnt_all FLOAT comment '历史轻资产授信平均额度',
--     credit_avg_limit_cnt_1m FLOAT comment '近1月轻资产授信平均额度',
--     credit_avg_limit_cnt_3m FLOAT comment '近3月轻资产授信平均额度',
--     credit_avg_limit_cnt_6m FLOAT comment '近6月轻资产授信平均额度',
--     credit_avg_limit_cnt_12m FLOAT comment '近12月轻资产授信平均额度',
--     credit_avg_limit_cnt_24m FLOAT comment '近24月轻资产授信平均额度',
--     credit_avg_limit_cnt_36m FLOAT comment '近36月轻资产授信平均额度',
--     credit_max_limit_cnt_all FLOAT comment '历史轻资产授信最大额度',
--     credit_max_limit_cnt_1m FLOAT comment '近1月轻资产授信最大额度',
--     credit_max_limit_cnt_3m FLOAT comment '近3月轻资产授信最大额度',
--     credit_max_limit_cnt_6m FLOAT comment '近6月轻资产授信最大额度',
--     credit_max_limit_cnt_12m FLOAT comment '近12月轻资产授信最大额度',
--     credit_max_limit_cnt_24m FLOAT comment '近24月轻资产授信最大额度',
--     credit_max_limit_cnt_36m FLOAT comment '近36月轻资产授信最大额度',
--     credit_min_limit_cnt_all FLOAT comment '历史轻资产授信最小额度',
--     credit_min_limit_cnt_1m FLOAT comment '近1月轻资产授信最小额度',
--     credit_min_limit_cnt_3m FLOAT comment '近3月轻资产授信最小额度',
--     credit_min_limit_cnt_6m FLOAT comment '近6月轻资产授信最小额度',
--     credit_min_limit_cnt_12m FLOAT comment '近12月轻资产授信最小额度',
--     credit_min_limit_cnt_24m FLOAT comment '近24月轻资产授信最小额度',
--     credit_min_limit_cnt_36m FLOAT comment '近36月轻资产授信最小额度',
--     credit_avg_ir_cnt_all FLOAT comment '历史轻资产授信平均年化利率',
--     credit_avg_ir_cnt_1m FLOAT comment '近1月轻资产授信平均年化利率',
--     credit_avg_ir_cnt_3m FLOAT comment '近3月轻资产授信平均年化利率',
--     credit_avg_ir_cnt_6m FLOAT comment '近6月轻资产授信平均年化利率',
--     credit_avg_ir_cnt_12m FLOAT comment '近12月轻资产授信平均年化利率',
--     credit_avg_ir_cnt_24m FLOAT comment '近24月轻资产授信平均年化利率',
--     credit_avg_ir_cnt_36m FLOAT comment '近36月轻资产授信平均年化利率',
--     credit_max_ir_cnt_all FLOAT comment '历史轻资产授信最大年化利率',
--     credit_max_ir_cnt_1m FLOAT comment '近1月轻资产授信最大年化利率',
--     credit_max_ir_cnt_3m FLOAT comment '近3月轻资产授信最大年化利率',
--     credit_max_ir_cnt_6m FLOAT comment '近6月轻资产授信最大年化利率',
--     credit_max_ir_cnt_12m FLOAT comment '近12月轻资产授信最大年化利率',
--     credit_max_ir_cnt_24m FLOAT comment '近24月轻资产授信最大年化利率',
--     credit_max_ir_cnt_36m FLOAT comment '近36月轻资产授信最大年化利率',
--     credit_min_ir_cnt_all FLOAT comment '历史轻资产授信最小年化利率',
--     credit_min_ir_cnt_1m FLOAT comment '近1月轻资产授信最小年化利率',
--     credit_min_ir_cnt_3m FLOAT comment '近3月轻资产授信最小年化利率',
--     credit_min_ir_cnt_6m FLOAT comment '近6月轻资产授信最小年化利率',
--     credit_min_ir_cnt_12m FLOAT comment '近12月轻资产授信最小年化利率',
--     credit_min_ir_cnt_24m FLOAT comment '近24月轻资产授信最小年化利率',
--     credit_min_ir_cnt_36m FLOAT comment '近36月轻资产授信最小年化利率',
--     credit_fund_level1_cnt_all BIGINT comment '历史轻资产授信第一梯队资方次数',
--     credit_fund_level1_cnt_1m BIGINT comment '近1月轻资产授信第一梯队资方次数',
--     credit_fund_level1_cnt_3m BIGINT comment '近3月轻资产授信第一梯队资方次数',
--     credit_fund_level1_cnt_6m BIGINT comment '近6月轻资产授信第一梯队资方次数',
--     credit_fund_level1_cnt_12m BIGINT comment '近12月轻资产授信第一梯队资方次数',
--     credit_fund_level1_cnt_24m BIGINT comment '近24月轻资产授信第一梯队资方次数',
--     credit_fund_level1_cnt_36m BIGINT comment '近36月轻资产授信第一梯队资方次数',
--     credit_fund_level1_reject_cnt_all BIGINT comment '历史轻资产授信第一梯队资方拒绝次数',
--     credit_fund_level1_reject_cnt_1m BIGINT comment '近1月轻资产授信第一梯队资方拒绝次数',
--     credit_fund_level1_reject_cnt_3m BIGINT comment '近3月轻资产授信第一梯队资方拒绝次数',
--     credit_fund_level1_reject_cnt_6m BIGINT comment '近6月轻资产授信第一梯队资方拒绝次数',
--     credit_fund_level1_reject_cnt_12m BIGINT comment '近12月轻资产授信第一梯队资方拒绝次数',
--     credit_fund_level1_reject_cnt_24m BIGINT comment '近24月轻资产授信第一梯队资方拒绝次数',
--     credit_fund_level1_reject_cnt_36m BIGINT comment '近36月轻资产授信第一梯队资方拒绝次数',
--     credit_fund_level1_ratio_all DOUBLE comment '历史轻资产授信第一梯队资方通过率',
--     credit_fund_level1_ratio_1m DOUBLE comment '近1月轻资产授信第一梯队资方通过率',
--     credit_fund_level1_ratio_3m DOUBLE comment '近3月轻资产授信第一梯队资方通过率',
--     credit_fund_level1_ratio_6m DOUBLE comment '近6月轻资产授信第一梯队资方通过率',
--     credit_fund_level1_ratio_12m DOUBLE comment '近12月轻资产授信第一梯队资方通过率',
--     credit_fund_level1_ratio_24m DOUBLE comment '近24月轻资产授信第一梯队资方通过率',
--     credit_fund_level1_ratio_36m DOUBLE comment '近36月轻资产授信第一梯队资方通过率',
--     credit_fund_level1_limit_cnt_all FLOAT comment '历史轻资产授信第一梯队资方总额度',
--     credit_fund_level1_limit_cnt_1m FLOAT comment '近1月轻资产授信第一梯队资方总额度',
--     credit_fund_level1_limit_cnt_3m FLOAT comment '近3月轻资产授信第一梯队资方总额度',
--     credit_fund_level1_limit_cnt_6m FLOAT comment '近6月轻资产授信第一梯队资方总额度',
--     credit_fund_level1_limit_cnt_12m FLOAT comment '近12月轻资产授信第一梯队资方总额度',
--     credit_fund_level1_limit_cnt_24m FLOAT comment '近24月轻资产授信第一梯队资方总额度',
--     credit_fund_level1_limit_cnt_36m FLOAT comment '近36月轻资产授信第一梯队资方总额度',
--     credit_fund_level1_avg_limit_cnt_all FLOAT comment '历史轻资产授信第一梯队资方平均额度',
--     credit_fund_level1_avg_limit_cnt_1m FLOAT comment '近1月轻资产授信第一梯队资方平均额度',
--     credit_fund_level1_avg_limit_cnt_3m FLOAT comment '近3月轻资产授信第一梯队资方平均额度',
--     credit_fund_level1_avg_limit_cnt_6m FLOAT comment '近6月轻资产授信第一梯队资方平均额度',
--     credit_fund_level1_avg_limit_cnt_12m FLOAT comment '近12月轻资产授信第一梯队资方平均额度',
--     credit_fund_level1_avg_limit_cnt_24m FLOAT comment '近24月轻资产授信第一梯队资方平均额度',
--     credit_fund_level1_avg_limit_cnt_36m FLOAT comment '近36月轻资产授信第一梯队资方平均额度',
--     credit_fund_level1_max_limit_cnt_all FLOAT comment '历史轻资产授信第一梯队资方最大额度',
--     credit_fund_level1_max_limit_cnt_1m FLOAT comment '近1月轻资产授信第一梯队资方最大额度',
--     credit_fund_level1_max_limit_cnt_3m FLOAT comment '近3月轻资产授信第一梯队资方最大额度',
--     credit_fund_level1_max_limit_cnt_6m FLOAT comment '近6月轻资产授信第一梯队资方最大额度',
--     credit_fund_level1_max_limit_cnt_12m FLOAT comment '近12月轻资产授信第一梯队资方最大额度',
--     credit_fund_level1_max_limit_cnt_24m FLOAT comment '近24月轻资产授信第一梯队资方最大额度',
--     credit_fund_level1_max_limit_cnt_36m FLOAT comment '近36月轻资产授信第一梯队资方最大额度',
--     credit_fund_level1_min_limit_cnt_all FLOAT comment '历史轻资产授信第一梯队资方最小额度',
--     credit_fund_level1_min_limit_cnt_1m FLOAT comment '近1月轻资产授信第一梯队资方最小额度',
--     credit_fund_level1_min_limit_cnt_3m FLOAT comment '近3月轻资产授信第一梯队资方最小额度',
--     credit_fund_level1_min_limit_cnt_6m FLOAT comment '近6月轻资产授信第一梯队资方最小额度',
--     credit_fund_level1_min_limit_cnt_12m FLOAT comment '近12月轻资产授信第一梯队资方最小额度',
--     credit_fund_level1_min_limit_cnt_24m FLOAT comment '近24月轻资产授信第一梯队资方最小额度',
--     credit_fund_level1_min_limit_cnt_36m FLOAT comment '近36月轻资产授信第一梯队资方最小额度',
--     credit_fund_level1_avg_ir_cnt_all FLOAT comment '历史轻资产授信第一梯队资方平均年化利率',
--     credit_fund_level1_avg_ir_cnt_1m FLOAT comment '近1月轻资产授信第一梯队资方平均年化利率',
--     credit_fund_level1_avg_ir_cnt_3m FLOAT comment '近3月轻资产授信第一梯队资方平均年化利率',
--     credit_fund_level1_avg_ir_cnt_6m FLOAT comment '近6月轻资产授信第一梯队资方平均年化利率',
--     credit_fund_level1_avg_ir_cnt_12m FLOAT comment '近12月轻资产授信第一梯队资方平均年化利率',
--     credit_fund_level1_avg_ir_cnt_24m FLOAT comment '近24月轻资产授信第一梯队资方平均年化利率',
--     credit_fund_level1_avg_ir_cnt_36m FLOAT comment '近36月轻资产授信第一梯队资方平均年化利率',
--     credit_fund_level1_max_ir_cnt_all FLOAT comment '历史轻资产授信第一梯队资方最大年化利率',
--     credit_fund_level1_max_ir_cnt_1m FLOAT comment '近1月轻资产授信第一梯队资方最大年化利率',
--     credit_fund_level1_max_ir_cnt_3m FLOAT comment '近3月轻资产授信第一梯队资方最大年化利率',
--     credit_fund_level1_max_ir_cnt_6m FLOAT comment '近6月轻资产授信第一梯队资方最大年化利率',
--     credit_fund_level1_max_ir_cnt_12m FLOAT comment '近12月轻资产授信第一梯队资方最大年化利率',
--     credit_fund_level1_max_ir_cnt_24m FLOAT comment '近24月轻资产授信第一梯队资方最大年化利率',
--     credit_fund_level1_max_ir_cnt_36m FLOAT comment '近36月轻资产授信第一梯队资方最大年化利率',
--     credit_fund_level1_min_ir_cnt_all FLOAT comment '历史轻资产授信第一梯队资方最小年化利率',
--     credit_fund_level1_min_ir_cnt_1m FLOAT comment '近1月轻资产授信第一梯队资方最小年化利率',
--     credit_fund_level1_min_ir_cnt_3m FLOAT comment '近3月轻资产授信第一梯队资方最小年化利率',
--     credit_fund_level1_min_ir_cnt_6m FLOAT comment '近6月轻资产授信第一梯队资方最小年化利率',
--     credit_fund_level1_min_ir_cnt_12m FLOAT comment '近12月轻资产授信第一梯队资方最小年化利率',
--     credit_fund_level1_min_ir_cnt_24m FLOAT comment '近24月轻资产授信第一梯队资方最小年化利率',
--     credit_fund_level1_min_ir_cnt_36m FLOAT comment '近36月轻资产授信第一梯队资方最小年化利率',
--     credit_fund_level2_cnt_all BIGINT comment '历史轻资产授信第二梯队资方次数',
--     credit_fund_level2_cnt_1m BIGINT comment '近1月轻资产授信第二梯队资方次数',
--     credit_fund_level2_cnt_3m BIGINT comment '近3月轻资产授信第二梯队资方次数',
--     credit_fund_level2_cnt_6m BIGINT comment '近6月轻资产授信第二梯队资方次数',
--     credit_fund_level2_cnt_12m BIGINT comment '近12月轻资产授信第二梯队资方次数',
--     credit_fund_level2_cnt_24m BIGINT comment '近24月轻资产授信第二梯队资方次数',
--     credit_fund_level2_cnt_36m BIGINT comment '近36月轻资产授信第二梯队资方次数',
--     credit_fund_level2_reject_cnt_all BIGINT comment '历史轻资产授信第二梯队资方拒绝次数',
--     credit_fund_level2_reject_cnt_1m BIGINT comment '近1月轻资产授信第二梯队资方拒绝次数',
--     credit_fund_level2_reject_cnt_3m BIGINT comment '近3月轻资产授信第二梯队资方拒绝次数',
--     credit_fund_level2_reject_cnt_6m BIGINT comment '近6月轻资产授信第二梯队资方拒绝次数',
--     credit_fund_level2_reject_cnt_12m BIGINT comment '近12月轻资产授信第二梯队资方拒绝次数',
--     credit_fund_level2_reject_cnt_24m BIGINT comment '近24月轻资产授信第二梯队资方拒绝次数',
--     credit_fund_level2_reject_cnt_36m BIGINT comment '近36月轻资产授信第二梯队资方拒绝次数',
--     credit_fund_level2_ratio_all DOUBLE comment '历史轻资产授信第二梯队资方通过率',
--     credit_fund_level2_ratio_1m DOUBLE comment '近1月轻资产授信第二梯队资方通过率',
--     credit_fund_level2_ratio_3m DOUBLE comment '近3月轻资产授信第二梯队资方通过率',
--     credit_fund_level2_ratio_6m DOUBLE comment '近6月轻资产授信第二梯队资方通过率',
--     credit_fund_level2_ratio_12m DOUBLE comment '近12月轻资产授信第二梯队资方通过率',
--     credit_fund_level2_ratio_24m DOUBLE comment '近24月轻资产授信第二梯队资方通过率',
--     credit_fund_level2_ratio_36m DOUBLE comment '近36月轻资产授信第二梯队资方通过率',
--     credit_fund_level2_limit_cnt_all FLOAT comment '历史轻资产授信第二梯队资方总额度',
--     credit_fund_level2_limit_cnt_1m FLOAT comment '近1月轻资产授信第二梯队资方总额度',
--     credit_fund_level2_limit_cnt_3m FLOAT comment '近3月轻资产授信第二梯队资方总额度',
--     credit_fund_level2_limit_cnt_6m FLOAT comment '近6月轻资产授信第二梯队资方总额度',
--     credit_fund_level2_limit_cnt_12m FLOAT comment '近12月轻资产授信第二梯队资方总额度',
--     credit_fund_level2_limit_cnt_24m FLOAT comment '近24月轻资产授信第二梯队资方总额度',
--     credit_fund_level2_limit_cnt_36m FLOAT comment '近36月轻资产授信第二梯队资方总额度',
--     credit_fund_level2_avg_limit_cnt_all FLOAT comment '历史轻资产授信第二梯队资方平均额度',
--     credit_fund_level2_avg_limit_cnt_1m FLOAT comment '近1月轻资产授信第二梯队资方平均额度',
--     credit_fund_level2_avg_limit_cnt_3m FLOAT comment '近3月轻资产授信第二梯队资方平均额度',
--     credit_fund_level2_avg_limit_cnt_6m FLOAT comment '近6月轻资产授信第二梯队资方平均额度',
--     credit_fund_level2_avg_limit_cnt_12m FLOAT comment '近12月轻资产授信第二梯队资方平均额度',
--     credit_fund_level2_avg_limit_cnt_24m FLOAT comment '近24月轻资产授信第二梯队资方平均额度',
--     credit_fund_level2_avg_limit_cnt_36m FLOAT comment '近36月轻资产授信第二梯队资方平均额度',
--     credit_fund_level2_max_limit_cnt_all FLOAT comment '历史轻资产授信第二梯队资方最大额度',
--     credit_fund_level2_max_limit_cnt_1m FLOAT comment '近1月轻资产授信第二梯队资方最大额度',
--     credit_fund_level2_max_limit_cnt_3m FLOAT comment '近3月轻资产授信第二梯队资方最大额度',
--     credit_fund_level2_max_limit_cnt_6m FLOAT comment '近6月轻资产授信第二梯队资方最大额度',
--     credit_fund_level2_max_limit_cnt_12m FLOAT comment '近12月轻资产授信第二梯队资方最大额度',
--     credit_fund_level2_max_limit_cnt_24m FLOAT comment '近24月轻资产授信第二梯队资方最大额度',
--     credit_fund_level2_max_limit_cnt_36m FLOAT comment '近36月轻资产授信第二梯队资方最大额度',
--     credit_fund_level2_min_limit_cnt_all FLOAT comment '历史轻资产授信第二梯队资方最小额度',
--     credit_fund_level2_min_limit_cnt_1m FLOAT comment '近1月轻资产授信第二梯队资方最小额度',
--     credit_fund_level2_min_limit_cnt_3m FLOAT comment '近3月轻资产授信第二梯队资方最小额度',
--     credit_fund_level2_min_limit_cnt_6m FLOAT comment '近6月轻资产授信第二梯队资方最小额度',
--     credit_fund_level2_min_limit_cnt_12m FLOAT comment '近12月轻资产授信第二梯队资方最小额度',
--     credit_fund_level2_min_limit_cnt_24m FLOAT comment '近24月轻资产授信第二梯队资方最小额度',
--     credit_fund_level2_min_limit_cnt_36m FLOAT comment '近36月轻资产授信第二梯队资方最小额度',
--     credit_fund_level2_avg_ir_cnt_all FLOAT comment '历史轻资产授信第二梯队资方平均年化利率',
--     credit_fund_level2_avg_ir_cnt_1m FLOAT comment '近1月轻资产授信第二梯队资方平均年化利率',
--     credit_fund_level2_avg_ir_cnt_3m FLOAT comment '近3月轻资产授信第二梯队资方平均年化利率',
--     credit_fund_level2_avg_ir_cnt_6m FLOAT comment '近6月轻资产授信第二梯队资方平均年化利率',
--     credit_fund_level2_avg_ir_cnt_12m FLOAT comment '近12月轻资产授信第二梯队资方平均年化利率',
--     credit_fund_level2_avg_ir_cnt_24m FLOAT comment '近24月轻资产授信第二梯队资方平均年化利率',
--     credit_fund_level2_avg_ir_cnt_36m FLOAT comment '近36月轻资产授信第二梯队资方平均年化利率',
--     credit_fund_level2_max_ir_cnt_all FLOAT comment '历史轻资产授信第二梯队资方最大年化利率',
--     credit_fund_level2_max_ir_cnt_1m FLOAT comment '近1月轻资产授信第二梯队资方最大年化利率',
--     credit_fund_level2_max_ir_cnt_3m FLOAT comment '近3月轻资产授信第二梯队资方最大年化利率',
--     credit_fund_level2_max_ir_cnt_6m FLOAT comment '近6月轻资产授信第二梯队资方最大年化利率',
--     credit_fund_level2_max_ir_cnt_12m FLOAT comment '近12月轻资产授信第二梯队资方最大年化利率',
--     credit_fund_level2_max_ir_cnt_24m FLOAT comment '近24月轻资产授信第二梯队资方最大年化利率',
--     credit_fund_level2_max_ir_cnt_36m FLOAT comment '近36月轻资产授信第二梯队资方最大年化利率',
--     credit_fund_level2_min_ir_cnt_all FLOAT comment '历史轻资产授信第二梯队资方最小年化利率',
--     credit_fund_level2_min_ir_cnt_1m FLOAT comment '近1月轻资产授信第二梯队资方最小年化利率',
--     credit_fund_level2_min_ir_cnt_3m FLOAT comment '近3月轻资产授信第二梯队资方最小年化利率',
--     credit_fund_level2_min_ir_cnt_6m FLOAT comment '近6月轻资产授信第二梯队资方最小年化利率',
--     credit_fund_level2_min_ir_cnt_12m FLOAT comment '近12月轻资产授信第二梯队资方最小年化利率',
--     credit_fund_level2_min_ir_cnt_24m FLOAT comment '近24月轻资产授信第二梯队资方最小年化利率',
--     credit_fund_level2_min_ir_cnt_36m FLOAT comment '近36月轻资产授信第二梯队资方最小年化利率',
--     credit_fund_other_cnt_all BIGINT comment '历史轻资产授信其他资方次数',
--     credit_fund_other_cnt_1m BIGINT comment '近1月轻资产授信其他资方次数',
--     credit_fund_other_cnt_3m BIGINT comment '近3月轻资产授信其他资方次数',
--     credit_fund_other_cnt_6m BIGINT comment '近6月轻资产授信其他资方次数',
--     credit_fund_other_cnt_12m BIGINT comment '近12月轻资产授信其他资方次数',
--     credit_fund_other_cnt_24m BIGINT comment '近24月轻资产授信其他资方次数',
--     credit_fund_other_cnt_36m BIGINT comment '近36月轻资产授信其他资方次数',
--     credit_fund_other_reject_cnt_all BIGINT comment '历史轻资产授信其他资方拒绝次数',
--     credit_fund_other_reject_cnt_1m BIGINT comment '近1月轻资产授信其他资方拒绝次数',
--     credit_fund_other_reject_cnt_3m BIGINT comment '近3月轻资产授信其他资方拒绝次数',
--     credit_fund_other_reject_cnt_6m BIGINT comment '近6月轻资产授信其他资方拒绝次数',
--     credit_fund_other_reject_cnt_12m BIGINT comment '近12月轻资产授信其他资方拒绝次数',
--     credit_fund_other_reject_cnt_24m BIGINT comment '近24月轻资产授信其他资方拒绝次数',
--     credit_fund_other_reject_cnt_36m BIGINT comment '近36月轻资产授信其他资方拒绝次数',
--     credit_fund_other_ratio_all DOUBLE comment '历史轻资产授信其他资方通过率',
--     credit_fund_other_ratio_1m DOUBLE comment '近1月轻资产授信其他资方通过率',
--     credit_fund_other_ratio_3m DOUBLE comment '近3月轻资产授信其他资方通过率',
--     credit_fund_other_ratio_6m DOUBLE comment '近6月轻资产授信其他资方通过率',
--     credit_fund_other_ratio_12m DOUBLE comment '近12月轻资产授信其他资方通过率',
--     credit_fund_other_ratio_24m DOUBLE comment '近24月轻资产授信其他资方通过率',
--     credit_fund_other_ratio_36m DOUBLE comment '近36月轻资产授信其他资方通过率',
--     credit_fund_other_limit_cnt_all FLOAT comment '历史轻资产授信其他资方总额度',
--     credit_fund_other_limit_cnt_1m FLOAT comment '近1月轻资产授信其他资方总额度',
--     credit_fund_other_limit_cnt_3m FLOAT comment '近3月轻资产授信其他资方总额度',
--     credit_fund_other_limit_cnt_6m FLOAT comment '近6月轻资产授信其他资方总额度',
--     credit_fund_other_limit_cnt_12m FLOAT comment '近12月轻资产授信其他资方总额度',
--     credit_fund_other_limit_cnt_24m FLOAT comment '近24月轻资产授信其他资方总额度',
--     credit_fund_other_limit_cnt_36m FLOAT comment '近36月轻资产授信其他资方总额度',
--     credit_fund_other_avg_limit_cnt_all FLOAT comment '历史轻资产授信其他资方平均额度',
--     credit_fund_other_avg_limit_cnt_1m FLOAT comment '近1月轻资产授信其他资方平均额度',
--     credit_fund_other_avg_limit_cnt_3m FLOAT comment '近3月轻资产授信其他资方平均额度',
--     credit_fund_other_avg_limit_cnt_6m FLOAT comment '近6月轻资产授信其他资方平均额度',
--     credit_fund_other_avg_limit_cnt_12m FLOAT comment '近12月轻资产授信其他资方平均额度',
--     credit_fund_other_avg_limit_cnt_24m FLOAT comment '近24月轻资产授信其他资方平均额度',
--     credit_fund_other_avg_limit_cnt_36m FLOAT comment '近36月轻资产授信其他资方平均额度',
--     credit_fund_other_max_limit_cnt_all FLOAT comment '历史轻资产授信其他资方最大额度',
--     credit_fund_other_max_limit_cnt_1m FLOAT comment '近1月轻资产授信其他资方最大额度',
--     credit_fund_other_max_limit_cnt_3m FLOAT comment '近3月轻资产授信其他资方最大额度',
--     credit_fund_other_max_limit_cnt_6m FLOAT comment '近6月轻资产授信其他资方最大额度',
--     credit_fund_other_max_limit_cnt_12m FLOAT comment '近12月轻资产授信其他资方最大额度',
--     credit_fund_other_max_limit_cnt_24m FLOAT comment '近24月轻资产授信其他资方最大额度',
--     credit_fund_other_max_limit_cnt_36m FLOAT comment '近36月轻资产授信其他资方最大额度',
--     credit_fund_other_min_limit_cnt_all FLOAT comment '历史轻资产授信其他资方最小额度',
--     credit_fund_other_min_limit_cnt_1m FLOAT comment '近1月轻资产授信其他资方最小额度',
--     credit_fund_other_min_limit_cnt_3m FLOAT comment '近3月轻资产授信其他资方最小额度',
--     credit_fund_other_min_limit_cnt_6m FLOAT comment '近6月轻资产授信其他资方最小额度',
--     credit_fund_other_min_limit_cnt_12m FLOAT comment '近12月轻资产授信其他资方最小额度',
--     credit_fund_other_min_limit_cnt_24m FLOAT comment '近24月轻资产授信其他资方最小额度',
--     credit_fund_other_min_limit_cnt_36m FLOAT comment '近36月轻资产授信其他资方最小额度',
--     credit_fund_other_avg_ir_cnt_all FLOAT comment '历史轻资产授信其他资方平均年化利率',
--     credit_fund_other_avg_ir_cnt_1m FLOAT comment '近1月轻资产授信其他资方平均年化利率',
--     credit_fund_other_avg_ir_cnt_3m FLOAT comment '近3月轻资产授信其他资方平均年化利率',
--     credit_fund_other_avg_ir_cnt_6m FLOAT comment '近6月轻资产授信其他资方平均年化利率',
--     credit_fund_other_avg_ir_cnt_12m FLOAT comment '近12月轻资产授信其他资方平均年化利率',
--     credit_fund_other_avg_ir_cnt_24m FLOAT comment '近24月轻资产授信其他资方平均年化利率',
--     credit_fund_other_avg_ir_cnt_36m FLOAT comment '近36月轻资产授信其他资方平均年化利率',
--     credit_fund_other_max_ir_cnt_all FLOAT comment '历史轻资产授信其他资方最大年化利率',
--     credit_fund_other_max_ir_cnt_1m FLOAT comment '近1月轻资产授信其他资方最大年化利率',
--     credit_fund_other_max_ir_cnt_3m FLOAT comment '近3月轻资产授信其他资方最大年化利率',
--     credit_fund_other_max_ir_cnt_6m FLOAT comment '近6月轻资产授信其他资方最大年化利率',
--     credit_fund_other_max_ir_cnt_12m FLOAT comment '近12月轻资产授信其他资方最大年化利率',
--     credit_fund_other_max_ir_cnt_24m FLOAT comment '近24月轻资产授信其他资方最大年化利率',
--     credit_fund_other_max_ir_cnt_36m FLOAT comment '近36月轻资产授信其他资方最大年化利率',
--     credit_fund_other_min_ir_cnt_all FLOAT comment '历史轻资产授信其他资方最小年化利率',
--     credit_fund_other_min_ir_cnt_1m FLOAT comment '近1月轻资产授信其他资方最小年化利率',
--     credit_fund_other_min_ir_cnt_3m FLOAT comment '近3月轻资产授信其他资方最小年化利率',
--     credit_fund_other_min_ir_cnt_6m FLOAT comment '近6月轻资产授信其他资方最小年化利率',
--     credit_fund_other_min_ir_cnt_12m FLOAT comment '近12月轻资产授信其他资方最小年化利率',
--     credit_fund_other_min_ir_cnt_24m FLOAT comment '近24月轻资产授信其他资方最小年化利率',
--     credit_fund_other_min_ir_cnt_36m FLOAT comment '近36月轻资产授信其他资方最小年化利率',
--     credit_fund_cnt_all BIGINT comment '历史轻资产授信发起资方个数',
--     credit_unique_fund_cnt_1m BIGINT comment '近1月轻资产授信发起资方个数',
--     credit_unique_fund_cnt_3m BIGINT comment '近3月轻资产授信发起资方个数',
--     credit_unique_fund_cnt_6m BIGINT comment '近6月轻资产授信发起资方个数',
--     credit_unique_fund_cnt_12m BIGINT comment '近12月轻资产授信发起资方个数',
--     credit_unique_fund_cnt_24m BIGINT comment '近24月轻资产授信发起资方个数',
--     credit_unique_fund_cnt_36m BIGINT comment '近36月轻资产授信发起资方个数',
--     credit_pass_fund_cnt_all BIGINT comment '历史轻资产授信通过资方个数',
--     credit_pass_unique_fund_cnt_1m BIGINT comment '近1月轻资产授信通过资方个数',
--     credit_pass_unique_fund_cnt_3m BIGINT comment '近3月轻资产授信通过资方个数',
--     credit_pass_unique_fund_cnt_6m BIGINT comment '近6月轻资产授信通过资方个数',
--     credit_pass_unique_fund_cnt_12m BIGINT comment '近12月轻资产授信通过资方个数',
--     credit_pass_unique_fund_cnt_24m BIGINT comment '近24月轻资产授信通过资方个数',
--     credit_pass_unique_fund_cnt_36m BIGINT comment '近36月轻资产授信通过资方个数',
--     credit_reject_fund_cnt_all BIGINT comment '历史轻资产授信拒绝资方个数',
--     credit_reject_unique_fund_cnt_1m BIGINT comment '近1月轻资产授信拒绝资方个数',
--     credit_reject_unique_fund_cnt_3m BIGINT comment '近3月轻资产授信拒绝资方个数',
--     credit_reject_unique_fund_cnt_6m BIGINT comment '近6月轻资产授信拒绝资方个数',
--     credit_reject_unique_fund_cnt_12m BIGINT comment '近12月轻资产授信拒绝资方个数',
--     credit_reject_unique_fund_cnt_24m BIGINT comment '近24月轻资产授信拒绝资方个数',
--     credit_reject_unique_fund_cnt_36m BIGINT comment '近36月轻资产授信拒绝资方个数',
--     credit_unique_scene_cnt_all BIGINT comment '历史轻资产授信发起重资产导流场景个数',
--     credit_unique_scene_cnt_1m BIGINT comment '近1月轻资产授信发起重资产导流场景个数',
--     credit_unique_scene_cnt_3m BIGINT comment '近3月轻资产授信发起重资产导流场景个数',
--     credit_unique_scene_cnt_6m BIGINT comment '近6月轻资产授信发起重资产导流场景个数',
--     credit_unique_scene_cnt_12m BIGINT comment '近12月轻资产授信发起重资产导流场景个数',
--     credit_unique_scene_cnt_24m BIGINT comment '近24月轻资产授信发起重资产导流场景个数',
--     credit_unique_scene_cnt_36m BIGINT comment '近36月轻资产授信发起重资产导流场景个数',
--     credit_pass_unique_scene_cnt_all BIGINT comment '历史轻资产授信通过重资产导流场景个数',
--     credit_pass_unique_scene_cnt_1m BIGINT comment '近1月轻资产授信通过重资产导流场景个数',
--     credit_pass_unique_scene_cnt_3m BIGINT comment '近3月轻资产授信通过重资产导流场景个数',
--     credit_pass_unique_scene_cnt_6m BIGINT comment '近6月轻资产授信通过重资产导流场景个数',
--     credit_pass_unique_scene_cnt_12m BIGINT comment '近12月轻资产授信通过重资产导流场景个数',
--     credit_pass_unique_scene_cnt_24m BIGINT comment '近24月轻资产授信通过重资产导流场景个数',
--     credit_pass_unique_scene_cnt_36m BIGINT comment '近36月轻资产授信通过重资产导流场景个数',
--     credit_reject_unique_scene_cnt_all BIGINT comment '历史轻资产授信拒绝重资产导流场景个数',
--     credit_reject_unique_scene_cnt_1m BIGINT comment '近1月轻资产授信拒绝重资产导流场景个数',
--     credit_reject_unique_scene_cnt_3m BIGINT comment '近3月轻资产授信拒绝重资产导流场景个数',
--     credit_reject_unique_scene_cnt_6m BIGINT comment '近6月轻资产授信拒绝重资产导流场景个数',
--     credit_reject_unique_scene_cnt_12m BIGINT comment '近12月轻资产授信拒绝重资产导流场景个数',
--     credit_reject_unique_scene_cnt_24m BIGINT comment '近24月轻资产授信拒绝重资产导流场景个数',
--     credit_reject_unique_scene_cnt_36m BIGINT comment '近36月轻资产授信拒绝重资产导流场景个数',
--     loan_cnt_all BIGINT comment '历史轻资产交易次数',
--     loan_cnt_1m BIGINT comment '近1月轻资产交易次数',
--     loan_cnt_3m BIGINT comment '近3月轻资产交易次数',
--     loan_cnt_6m BIGINT comment '近6月轻资产交易次数',
--     loan_cnt_12m BIGINT comment '近12月轻资产交易次数',
--     loan_cnt_24m BIGINT comment '近24月轻资产交易次数',
--     loan_cnt_36m BIGINT comment '近36月轻资产交易次数',
--     loan_reject_cnt_all BIGINT comment '历史轻资产交易拒绝次数',
--     loan_reject_cnt_1m BIGINT comment '近1月轻资产交易拒绝次数',
--     loan_reject_cnt_3m BIGINT comment '近3月轻资产交易拒绝次数',
--     loan_reject_cnt_6m BIGINT comment '近6月轻资产交易拒绝次数',
--     loan_reject_cnt_12m BIGINT comment '近12月轻资产交易拒绝次数',
--     loan_reject_cnt_24m BIGINT comment '近24月轻资产交易拒绝次数',
--     loan_reject_cnt_36m BIGINT comment '近36月轻资产交易拒绝次数',
--     loan_ratio_all DOUBLE comment '历史轻资产交易通过率',
--     loan_ratio_1m DOUBLE comment '近1月轻资产交易通过率',
--     loan_ratio_3m DOUBLE comment '近3月轻资产交易通过率',
--     loan_ratio_6m DOUBLE comment '近6月轻资产交易通过率',
--     loan_ratio_12m DOUBLE comment '近12月轻资产交易通过率',
--     loan_ratio_24m DOUBLE comment '近24月轻资产交易通过率',
--     loan_ratio_36m DOUBLE comment '近36月轻资产交易通过率',
--     loan_avg_terms_all DOUBLE comment '历史轻资产交易平均期数',
--     loan_avg_terms_1m DOUBLE comment '近1月轻资产交易平均期数',
--     loan_avg_terms_3m DOUBLE comment '近3月轻资产交易平均期数',
--     loan_avg_terms_6m DOUBLE comment '近6月轻资产交易平均期数',
--     loan_avg_terms_12m DOUBLE comment '近12月轻资产交易平均期数',
--     loan_avg_terms_24m DOUBLE comment '近24月轻资产交易平均期数',
--     loan_avg_terms_36m DOUBLE comment '近36月轻资产交易平均期数',
--     loan_max_terms_all FLOAT comment '历史轻资产交易最大期数',
--     loan_max_terms_1m FLOAT comment '近1月轻资产交易最大期数',
--     loan_max_terms_3m FLOAT comment '近3月轻资产交易最大期数',
--     loan_max_terms_6m FLOAT comment '近6月轻资产交易最大期数',
--     loan_max_terms_12m FLOAT comment '近12月轻资产交易最大期数',
--     loan_max_terms_24m FLOAT comment '近24月轻资产交易最大期数',
--     loan_max_terms_36m FLOAT comment '近36月轻资产交易最大期数',
--     loan_min_terms_all FLOAT comment '历史轻资产交易最小期数',
--     loan_min_terms_1m FLOAT comment '近1月轻资产交易最小期数',
--     loan_min_terms_3m FLOAT comment '近3月轻资产交易最小期数',
--     loan_min_terms_6m FLOAT comment '近6月轻资产交易最小期数',
--     loan_min_terms_12m FLOAT comment '近12月轻资产交易最小期数',
--     loan_min_terms_24m FLOAT comment '近24月轻资产交易最小期数',
--     loan_min_terms_36m FLOAT comment '近36月轻资产交易最小期数',
--     loan_principal_sum_all FLOAT comment '历史轻资产交易总借款本金',
--     loan_principal_sum_1m FLOAT comment '近1月轻资产交易总借款本金',
--     loan_principal_sum_3m FLOAT comment '近3月轻资产交易总借款本金',
--     loan_principal_sum_6m FLOAT comment '近6月轻资产交易总借款本金',
--     loan_principal_sum_12m FLOAT comment '近12月轻资产交易总借款本金',
--     loan_principal_sum_24m FLOAT comment '近24月轻资产交易总借款本金',
--     loan_principal_sum_36m FLOAT comment '近36月轻资产交易总借款本金',
--     loan_avg_terms_avg_all FLOAT comment '历史轻资产交易平均借款本金',
--     loan_principal_avg_1m FLOAT comment '近1月轻资产交易平均借款本金',
--     loan_principal_avg_3m FLOAT comment '近3月轻资产交易平均借款本金',
--     loan_principal_avg_6m FLOAT comment '近6月轻资产交易平均借款本金',
--     loan_principal_avg_12m FLOAT comment '近12月轻资产交易平均借款本金',
--     loan_principal_avg_24m FLOAT comment '近24月轻资产交易平均借款本金',
--     loan_principal_avg_36m FLOAT comment '近36月轻资产交易平均借款本金',
--     loan_max_terms_max_all FLOAT comment '历史轻资产交易最大借款本金',
--     loan_principal_max_1m FLOAT comment '近1月轻资产交易最大借款本金',
--     loan_principal_max_3m FLOAT comment '近3月轻资产交易最大借款本金',
--     loan_principal_max_6m FLOAT comment '近6月轻资产交易最大借款本金',
--     loan_principal_max_12m FLOAT comment '近12月轻资产交易最大借款本金',
--     loan_principal_max_24m FLOAT comment '近24月轻资产交易最大借款本金',
--     loan_principal_max_36m FLOAT comment '近36月轻资产交易最大借款本金',
--     loan_min_terms_min_all FLOAT comment '历史轻资产交易最小借款本金',
--     loan_principal_min_1m FLOAT comment '近1月轻资产交易最小借款本金',
--     loan_principal_min_3m FLOAT comment '近3月轻资产交易最小借款本金',
--     loan_principal_min_6m FLOAT comment '近6月轻资产交易最小借款本金',
--     loan_principal_min_12m FLOAT comment '近12月轻资产交易最小借款本金',
--     loan_principal_min_24m FLOAT comment '近24月轻资产交易最小借款本金',
--     loan_principal_min_36m FLOAT comment '近36月轻资产交易最小借款本金',
--     loan_avg_ir_all FLOAT comment '历史轻资产交易平均年化利率',
--     loan_avg_ir_1m FLOAT comment '近1月轻资产交易平均年化利率',
--     loan_avg_ir_3m FLOAT comment '近3月轻资产交易平均年化利率',
--     loan_avg_ir_6m FLOAT comment '近6月轻资产交易平均年化利率',
--     loan_avg_ir_12m FLOAT comment '近12月轻资产交易平均年化利率',
--     loan_avg_ir_24m FLOAT comment '近24月轻资产交易平均年化利率',
--     loan_avg_ir_36m FLOAT comment '近36月轻资产交易平均年化利率',
--     loan_max_ir_all FLOAT comment '历史轻资产交易最大年化利率',
--     loan_max_ir_1m FLOAT comment '近1月轻资产交易最大年化利率',
--     loan_max_ir_3m FLOAT comment '近3月轻资产交易最大年化利率',
--     loan_max_ir_6m FLOAT comment '近6月轻资产交易最大年化利率',
--     loan_max_ir_12m FLOAT comment '近12月轻资产交易最大年化利率',
--     loan_max_ir_24m FLOAT comment '近24月轻资产交易最大年化利率',
--     loan_max_ir_36m FLOAT comment '近36月轻资产交易最大年化利率',
--     loan_min_ir_all FLOAT comment '历史轻资产交易最小年化利率',
--     loan_min_ir_1m FLOAT comment '近1月轻资产交易最小年化利率',
--     loan_min_ir_3m FLOAT comment '近3月轻资产交易最小年化利率',
--     loan_min_ir_6m FLOAT comment '近6月轻资产交易最小年化利率',
--     loan_min_ir_12m FLOAT comment '近12月轻资产交易最小年化利率',
--     loan_min_ir_24m FLOAT comment '近24月轻资产交易最小年化利率',
--     loan_min_ir_36m FLOAT comment '近36月轻资产交易最小年化利率',
--     loan_fund_level1_cnt_all BIGINT comment '历史轻资产交易第一梯队资方次数',
--     loan_fund_level1_cnt_1m BIGINT comment '近1月轻资产交易第一梯队资方次数',
--     loan_fund_level1_cnt_3m BIGINT comment '近3月轻资产交易第一梯队资方次数',
--     loan_fund_level1_cnt_6m BIGINT comment '近6月轻资产交易第一梯队资方次数',
--     loan_fund_level1_cnt_12m BIGINT comment '近12月轻资产交易第一梯队资方次数',
--     loan_fund_level1_cnt_24m BIGINT comment '近24月轻资产交易第一梯队资方次数',
--     loan_fund_level1_cnt_36m BIGINT comment '近36月轻资产交易第一梯队资方次数',
--     loan_fund_level1_reject_cnt_all BIGINT comment '历史轻资产交易第一梯队资方拒绝次数',
--     loan_fund_level1_reject_cnt_1m BIGINT comment '近1月轻资产交易第一梯队资方拒绝次数',
--     loan_fund_level1_reject_cnt_3m BIGINT comment '近3月轻资产交易第一梯队资方拒绝次数',
--     loan_fund_level1_reject_cnt_6m BIGINT comment '近6月轻资产交易第一梯队资方拒绝次数',
--     loan_fund_level1_reject_cnt_12m BIGINT comment '近12月轻资产交易第一梯队资方拒绝次数',
--     loan_fund_level1_reject_cnt_24m BIGINT comment '近24月轻资产交易第一梯队资方拒绝次数',
--     loan_fund_level1_reject_cnt_36m BIGINT comment '近36月轻资产交易第一梯队资方拒绝次数',
--     loan_fund_level1_ratio_all DOUBLE comment '历史轻资产交易第一梯队资方通过率',
--     loan_fund_level1_ratio_1m DOUBLE comment '近1月轻资产交易第一梯队资方通过率',
--     loan_fund_level1_ratio_3m DOUBLE comment '近3月轻资产交易第一梯队资方通过率',
--     loan_fund_level1_ratio_6m DOUBLE comment '近6月轻资产交易第一梯队资方通过率',
--     loan_fund_level1_ratio_12m DOUBLE comment '近12月轻资产交易第一梯队资方通过率',
--     loan_fund_level1_ratio_24m DOUBLE comment '近24月轻资产交易第一梯队资方通过率',
--     loan_fund_level1_ratio_36m DOUBLE comment '近36月轻资产交易第一梯队资方通过率',
--     loan_fund_level1_avg_terms_all DOUBLE comment '历史轻资产交易第一梯队资方平均期数',
--     loan_fund_level1_avg_terms_1m DOUBLE comment '近1月轻资产交易第一梯队资方平均期数',
--     loan_fund_level1_avg_terms_3m DOUBLE comment '近3月轻资产交易第一梯队资方平均期数',
--     loan_fund_level1_avg_terms_6m DOUBLE comment '近6月轻资产交易第一梯队资方平均期数',
--     loan_fund_level1_avg_terms_12m DOUBLE comment '近12月轻资产交易第一梯队资方平均期数',
--     loan_fund_level1_avg_terms_24m DOUBLE comment '近24月轻资产交易第一梯队资方平均期数',
--     loan_fund_level1_avg_terms_36m DOUBLE comment '近36月轻资产交易第一梯队资方平均期数',
--     loan_fund_level1_max_terms_all FLOAT comment '历史轻资产交易第一梯队资方最大期数',
--     loan_fund_level1_max_terms_1m FLOAT comment '近1月轻资产交易第一梯队资方最大期数',
--     loan_fund_level1_max_terms_3m FLOAT comment '近3月轻资产交易第一梯队资方最大期数',
--     loan_fund_level1_max_terms_6m FLOAT comment '近6月轻资产交易第一梯队资方最大期数',
--     loan_fund_level1_max_terms_12m FLOAT comment '近12月轻资产交易第一梯队资方最大期数',
--     loan_fund_level1_max_terms_24m FLOAT comment '近24月轻资产交易第一梯队资方最大期数',
--     loan_fund_level1_max_terms_36m FLOAT comment '近36月轻资产交易第一梯队资方最大期数',
--     loan_fund_level1_min_terms_all FLOAT comment '历史轻资产交易第一梯队资方最小期数',
--     loan_fund_level1_min_terms_1m FLOAT comment '近1月轻资产交易第一梯队资方最小期数',
--     loan_fund_level1_min_terms_3m FLOAT comment '近3月轻资产交易第一梯队资方最小期数',
--     loan_fund_level1_min_terms_6m FLOAT comment '近6月轻资产交易第一梯队资方最小期数',
--     loan_fund_level1_min_terms_12m FLOAT comment '近12月轻资产交易第一梯队资方最小期数',
--     loan_fund_level1_min_terms_24m FLOAT comment '近24月轻资产交易第一梯队资方最小期数',
--     loan_fund_level1_min_terms_36m FLOAT comment '近36月轻资产交易第一梯队资方最小期数',
--     loan_fund_level1_principal_sum_all FLOAT comment '历史轻资产交易第一梯队资方总借款本金',
--     loan_fund_level1_principal_sum_1m FLOAT comment '近1月轻资产交易第一梯队资方总借款本金',
--     loan_fund_level1_principal_sum_3m FLOAT comment '近3月轻资产交易第一梯队资方总借款本金',
--     loan_fund_level1_principal_sum_6m FLOAT comment '近6月轻资产交易第一梯队资方总借款本金',
--     loan_fund_level1_principal_sum_12m FLOAT comment '近12月轻资产交易第一梯队资方总借款本金',
--     loan_fund_level1_principal_sum_24m FLOAT comment '近24月轻资产交易第一梯队资方总借款本金',
--     loan_fund_level1_principal_sum_36m FLOAT comment '近36月轻资产交易第一梯队资方总借款本金',
--     loan_fund_level1_avg_terms_avg_all FLOAT comment '历史轻资产交易第一梯队资方平均借款本金',
--     loan_fund_level1_principal_avg_1m FLOAT comment '近1月轻资产交易第一梯队资方平均借款本金',
--     loan_fund_level1_principal_avg_3m FLOAT comment '近3月轻资产交易第一梯队资方平均借款本金',
--     loan_fund_level1_principal_avg_6m FLOAT comment '近6月轻资产交易第一梯队资方平均借款本金',
--     loan_fund_level1_principal_avg_12m FLOAT comment '近12月轻资产交易第一梯队资方平均借款本金',
--     loan_fund_level1_principal_avg_24m FLOAT comment '近24月轻资产交易第一梯队资方平均借款本金',
--     loan_fund_level1_principal_avg_36m FLOAT comment '近36月轻资产交易第一梯队资方平均借款本金',
--     loan_fund_level1_max_terms_max_all FLOAT comment '历史轻资产交易第一梯队资方最大借款本金',
--     loan_fund_level1_principal_max_1m FLOAT comment '近1月轻资产交易第一梯队资方最大借款本金',
--     loan_fund_level1_principal_max_3m FLOAT comment '近3月轻资产交易第一梯队资方最大借款本金',
--     loan_fund_level1_principal_max_6m FLOAT comment '近6月轻资产交易第一梯队资方最大借款本金',
--     loan_fund_level1_principal_max_12m FLOAT comment '近12月轻资产交易第一梯队资方最大借款本金',
--     loan_fund_level1_principal_max_24m FLOAT comment '近24月轻资产交易第一梯队资方最大借款本金',
--     loan_fund_level1_principal_max_36m FLOAT comment '近36月轻资产交易第一梯队资方最大借款本金',
--     loan_fund_level1_min_terms_min_all FLOAT comment '历史轻资产交易第一梯队资方最小借款本金',
--     loan_fund_level1_principal_min_1m FLOAT comment '近1月轻资产交易第一梯队资方最小借款本金',
--     loan_fund_level1_principal_min_3m FLOAT comment '近3月轻资产交易第一梯队资方最小借款本金',
--     loan_fund_level1_principal_min_6m FLOAT comment '近6月轻资产交易第一梯队资方最小借款本金',
--     loan_fund_level1_principal_min_12m FLOAT comment '近12月轻资产交易第一梯队资方最小借款本金',
--     loan_fund_level1_principal_min_24m FLOAT comment '近24月轻资产交易第一梯队资方最小借款本金',
--     loan_fund_level1_principal_min_36m FLOAT comment '近36月轻资产交易第一梯队资方最小借款本金',
--     loan_fund_level1_avg_ir_all FLOAT comment '历史轻资产交易第一梯队资方平均年化利率',
--     loan_fund_level1_avg_ir_1m FLOAT comment '近1月轻资产交易第一梯队资方平均年化利率',
--     loan_fund_level1_avg_ir_3m FLOAT comment '近3月轻资产交易第一梯队资方平均年化利率',
--     loan_fund_level1_avg_ir_6m FLOAT comment '近6月轻资产交易第一梯队资方平均年化利率',
--     loan_fund_level1_avg_ir_12m FLOAT comment '近12月轻资产交易第一梯队资方平均年化利率',
--     loan_fund_level1_avg_ir_24m FLOAT comment '近24月轻资产交易第一梯队资方平均年化利率',
--     loan_fund_level1_avg_ir_36m FLOAT comment '近36月轻资产交易第一梯队资方平均年化利率',
--     loan_fund_level1_max_ir_all FLOAT comment '历史轻资产交易第一梯队资方最大年化利率',
--     loan_fund_level1_max_ir_1m FLOAT comment '近1月轻资产交易第一梯队资方最大年化利率',
--     loan_fund_level1_max_ir_3m FLOAT comment '近3月轻资产交易第一梯队资方最大年化利率',
--     loan_fund_level1_max_ir_6m FLOAT comment '近6月轻资产交易第一梯队资方最大年化利率',
--     loan_fund_level1_max_ir_12m FLOAT comment '近12月轻资产交易第一梯队资方最大年化利率',
--     loan_fund_level1_max_ir_24m FLOAT comment '近24月轻资产交易第一梯队资方最大年化利率',
--     loan_fund_level1_max_ir_36m FLOAT comment '近36月轻资产交易第一梯队资方最大年化利率',
--     loan_fund_level1_min_ir_all FLOAT comment '历史轻资产交易第一梯队资方最小年化利率',
--     loan_fund_level1_min_ir_1m FLOAT comment '近1月轻资产交易第一梯队资方最小年化利率',
--     loan_fund_level1_min_ir_3m FLOAT comment '近3月轻资产交易第一梯队资方最小年化利率',
--     loan_fund_level1_min_ir_6m FLOAT comment '近6月轻资产交易第一梯队资方最小年化利率',
--     loan_fund_level1_min_ir_12m FLOAT comment '近12月轻资产交易第一梯队资方最小年化利率',
--     loan_fund_level1_min_ir_24m FLOAT comment '近24月轻资产交易第一梯队资方最小年化利率',
--     loan_fund_level1_min_ir_36m FLOAT comment '近36月轻资产交易第一梯队资方最小年化利率',
--     loan_fund_level2_cnt_all BIGINT comment '历史轻资产交易第二梯队资方次数',
--     loan_fund_level2_cnt_1m BIGINT comment '近1月轻资产交易第二梯队资方次数',
--     loan_fund_level2_cnt_3m BIGINT comment '近3月轻资产交易第二梯队资方次数',
--     loan_fund_level2_cnt_6m BIGINT comment '近6月轻资产交易第二梯队资方次数',
--     loan_fund_level2_cnt_12m BIGINT comment '近12月轻资产交易第二梯队资方次数',
--     loan_fund_level2_cnt_24m BIGINT comment '近24月轻资产交易第二梯队资方次数',
--     loan_fund_level2_cnt_36m BIGINT comment '近36月轻资产交易第二梯队资方次数',
--     loan_fund_level2_reject_cnt_all BIGINT comment '历史轻资产交易第二梯队资方拒绝次数',
--     loan_fund_level2_reject_cnt_1m BIGINT comment '近1月轻资产交易第二梯队资方拒绝次数',
--     loan_fund_level2_reject_cnt_3m BIGINT comment '近3月轻资产交易第二梯队资方拒绝次数',
--     loan_fund_level2_reject_cnt_6m BIGINT comment '近6月轻资产交易第二梯队资方拒绝次数',
--     loan_fund_level2_reject_cnt_12m BIGINT comment '近12月轻资产交易第二梯队资方拒绝次数',
--     loan_fund_level2_reject_cnt_24m BIGINT comment '近24月轻资产交易第二梯队资方拒绝次数',
--     loan_fund_level2_reject_cnt_36m BIGINT comment '近36月轻资产交易第二梯队资方拒绝次数',
--     loan_fund_level2_ratio_all DOUBLE comment '历史轻资产交易第二梯队资方通过率',
--     loan_fund_level2_ratio_1m DOUBLE comment '近1月轻资产交易第二梯队资方通过率',
--     loan_fund_level2_ratio_3m DOUBLE comment '近3月轻资产交易第二梯队资方通过率',
--     loan_fund_level2_ratio_6m DOUBLE comment '近6月轻资产交易第二梯队资方通过率',
--     loan_fund_level2_ratio_12m DOUBLE comment '近12月轻资产交易第二梯队资方通过率',
--     loan_fund_level2_ratio_24m DOUBLE comment '近24月轻资产交易第二梯队资方通过率',
--     loan_fund_level2_ratio_36m DOUBLE comment '近36月轻资产交易第二梯队资方通过率',
--     loan_fund_level2_avg_terms_all DOUBLE comment '历史轻资产交易第二梯队资方平均期数',
--     loan_fund_level2_avg_terms_1m DOUBLE comment '近1月轻资产交易第二梯队资方平均期数',
--     loan_fund_level2_avg_terms_3m DOUBLE comment '近3月轻资产交易第二梯队资方平均期数',
--     loan_fund_level2_avg_terms_6m DOUBLE comment '近6月轻资产交易第二梯队资方平均期数',
--     loan_fund_level2_avg_terms_12m DOUBLE comment '近12月轻资产交易第二梯队资方平均期数',
--     loan_fund_level2_avg_terms_24m DOUBLE comment '近24月轻资产交易第二梯队资方平均期数',
--     loan_fund_level2_avg_terms_36m DOUBLE comment '近36月轻资产交易第二梯队资方平均期数',
--     loan_fund_level2_max_terms_all FLOAT comment '历史轻资产交易第二梯队资方最大期数',
--     loan_fund_level2_max_terms_1m FLOAT comment '近1月轻资产交易第二梯队资方最大期数',
--     loan_fund_level2_max_terms_3m FLOAT comment '近3月轻资产交易第二梯队资方最大期数',
--     loan_fund_level2_max_terms_6m FLOAT comment '近6月轻资产交易第二梯队资方最大期数',
--     loan_fund_level2_max_terms_12m FLOAT comment '近12月轻资产交易第二梯队资方最大期数',
--     loan_fund_level2_max_terms_24m FLOAT comment '近24月轻资产交易第二梯队资方最大期数',
--     loan_fund_level2_max_terms_36m FLOAT comment '近36月轻资产交易第二梯队资方最大期数',
--     loan_fund_level2_min_terms_all FLOAT comment '历史轻资产交易第二梯队资方最小期数',
--     loan_fund_level2_min_terms_1m FLOAT comment '近1月轻资产交易第二梯队资方最小期数',
--     loan_fund_level2_min_terms_3m FLOAT comment '近3月轻资产交易第二梯队资方最小期数',
--     loan_fund_level2_min_terms_6m FLOAT comment '近6月轻资产交易第二梯队资方最小期数',
--     loan_fund_level2_min_terms_12m FLOAT comment '近12月轻资产交易第二梯队资方最小期数',
--     loan_fund_level2_min_terms_24m FLOAT comment '近24月轻资产交易第二梯队资方最小期数',
--     loan_fund_level2_min_terms_36m FLOAT comment '近36月轻资产交易第二梯队资方最小期数',
--     loan_fund_level2_principal_sum_all FLOAT comment '历史轻资产交易第二梯队资方总借款本金',
--     loan_fund_level2_principal_sum_1m FLOAT comment '近1月轻资产交易第二梯队资方总借款本金',
--     loan_fund_level2_principal_sum_3m FLOAT comment '近3月轻资产交易第二梯队资方总借款本金',
--     loan_fund_level2_principal_sum_6m FLOAT comment '近6月轻资产交易第二梯队资方总借款本金',
--     loan_fund_level2_principal_sum_12m FLOAT comment '近12月轻资产交易第二梯队资方总借款本金',
--     loan_fund_level2_principal_sum_24m FLOAT comment '近24月轻资产交易第二梯队资方总借款本金',
--     loan_fund_level2_principal_sum_36m FLOAT comment '近36月轻资产交易第二梯队资方总借款本金',
--     loan_fund_level2_avg_terms_avg_all FLOAT comment '历史轻资产交易第二梯队资方平均借款本金',
--     loan_fund_level2_principal_avg_1m FLOAT comment '近1月轻资产交易第二梯队资方平均借款本金',
--     loan_fund_level2_principal_avg_3m FLOAT comment '近3月轻资产交易第二梯队资方平均借款本金',
--     loan_fund_level2_principal_avg_6m FLOAT comment '近6月轻资产交易第二梯队资方平均借款本金',
--     loan_fund_level2_principal_avg_12m FLOAT comment '近12月轻资产交易第二梯队资方平均借款本金',
--     loan_fund_level2_principal_avg_24m FLOAT comment '近24月轻资产交易第二梯队资方平均借款本金',
--     loan_fund_level2_principal_avg_36m FLOAT comment '近36月轻资产交易第二梯队资方平均借款本金',
--     loan_fund_level2_max_terms_max_all FLOAT comment '历史轻资产交易第二梯队资方最大借款本金',
--     loan_fund_level2_principal_max_1m FLOAT comment '近1月轻资产交易第二梯队资方最大借款本金',
--     loan_fund_level2_principal_max_3m FLOAT comment '近3月轻资产交易第二梯队资方最大借款本金',
--     loan_fund_level2_principal_max_6m FLOAT comment '近6月轻资产交易第二梯队资方最大借款本金',
--     loan_fund_level2_principal_max_12m FLOAT comment '近12月轻资产交易第二梯队资方最大借款本金',
--     loan_fund_level2_principal_max_24m FLOAT comment '近24月轻资产交易第二梯队资方最大借款本金',
--     loan_fund_level2_principal_max_36m FLOAT comment '近36月轻资产交易第二梯队资方最大借款本金',
--     loan_fund_level2_min_terms_min_all FLOAT comment '历史轻资产交易第二梯队资方最小借款本金',
--     loan_fund_level2_principal_min_1m FLOAT comment '近1月轻资产交易第二梯队资方最小借款本金',
--     loan_fund_level2_principal_min_3m FLOAT comment '近3月轻资产交易第二梯队资方最小借款本金',
--     loan_fund_level2_principal_min_6m FLOAT comment '近6月轻资产交易第二梯队资方最小借款本金',
--     loan_fund_level2_principal_min_12m FLOAT comment '近12月轻资产交易第二梯队资方最小借款本金',
--     loan_fund_level2_principal_min_24m FLOAT comment '近24月轻资产交易第二梯队资方最小借款本金',
--     loan_fund_level2_principal_min_36m FLOAT comment '近36月轻资产交易第二梯队资方最小借款本金',
--     loan_fund_level2_avg_ir_all FLOAT comment '历史轻资产交易第二梯队资方平均年化利率',
--     loan_fund_level2_avg_ir_1m FLOAT comment '近1月轻资产交易第二梯队资方平均年化利率',
--     loan_fund_level2_avg_ir_3m FLOAT comment '近3月轻资产交易第二梯队资方平均年化利率',
--     loan_fund_level2_avg_ir_6m FLOAT comment '近6月轻资产交易第二梯队资方平均年化利率',
--     loan_fund_level2_avg_ir_12m FLOAT comment '近12月轻资产交易第二梯队资方平均年化利率',
--     loan_fund_level2_avg_ir_24m FLOAT comment '近24月轻资产交易第二梯队资方平均年化利率',
--     loan_fund_level2_avg_ir_36m FLOAT comment '近36月轻资产交易第二梯队资方平均年化利率',
--     loan_fund_level2_max_ir_all FLOAT comment '历史轻资产交易第二梯队资方最大年化利率',
--     loan_fund_level2_max_ir_1m FLOAT comment '近1月轻资产交易第二梯队资方最大年化利率',
--     loan_fund_level2_max_ir_3m FLOAT comment '近3月轻资产交易第二梯队资方最大年化利率',
--     loan_fund_level2_max_ir_6m FLOAT comment '近6月轻资产交易第二梯队资方最大年化利率',
--     loan_fund_level2_max_ir_12m FLOAT comment '近12月轻资产交易第二梯队资方最大年化利率',
--     loan_fund_level2_max_ir_24m FLOAT comment '近24月轻资产交易第二梯队资方最大年化利率',
--     loan_fund_level2_max_ir_36m FLOAT comment '近36月轻资产交易第二梯队资方最大年化利率',
--     loan_fund_level2_min_ir_all FLOAT comment '历史轻资产交易第二梯队资方最小年化利率',
--     loan_fund_level2_min_ir_1m FLOAT comment '近1月轻资产交易第二梯队资方最小年化利率',
--     loan_fund_level2_min_ir_3m FLOAT comment '近3月轻资产交易第二梯队资方最小年化利率',
--     loan_fund_level2_min_ir_6m FLOAT comment '近6月轻资产交易第二梯队资方最小年化利率',
--     loan_fund_level2_min_ir_12m FLOAT comment '近12月轻资产交易第二梯队资方最小年化利率',
--     loan_fund_level2_min_ir_24m FLOAT comment '近24月轻资产交易第二梯队资方最小年化利率',
--     loan_fund_level2_min_ir_36m FLOAT comment '近36月轻资产交易第二梯队资方最小年化利率',
--     loan_fund_other_cnt_all BIGINT comment '历史轻资产交易其他资方次数',
--     loan_fund_other_cnt_1m BIGINT comment '近1月轻资产交易其他资方次数',
--     loan_fund_other_cnt_3m BIGINT comment '近3月轻资产交易其他资方次数',
--     loan_fund_other_cnt_6m BIGINT comment '近6月轻资产交易其他资方次数',
--     loan_fund_other_cnt_12m BIGINT comment '近12月轻资产交易其他资方次数',
--     loan_fund_other_cnt_24m BIGINT comment '近24月轻资产交易其他资方次数',
--     loan_fund_other_cnt_36m BIGINT comment '近36月轻资产交易其他资方次数',
--     loan_fund_other_reject_cnt_all BIGINT comment '历史轻资产交易其他资方拒绝次数',
--     loan_fund_other_reject_cnt_1m BIGINT comment '近1月轻资产交易其他资方拒绝次数',
--     loan_fund_other_reject_cnt_3m BIGINT comment '近3月轻资产交易其他资方拒绝次数',
--     loan_fund_other_reject_cnt_6m BIGINT comment '近6月轻资产交易其他资方拒绝次数',
--     loan_fund_other_reject_cnt_12m BIGINT comment '近12月轻资产交易其他资方拒绝次数',
--     loan_fund_other_reject_cnt_24m BIGINT comment '近24月轻资产交易其他资方拒绝次数',
--     loan_fund_other_reject_cnt_36m BIGINT comment '近36月轻资产交易其他资方拒绝次数',
--     loan_fund_other_ratio_all DOUBLE comment '历史轻资产交易其他资方通过率',
--     loan_fund_other_ratio_1m DOUBLE comment '近1月轻资产交易其他资方通过率',
--     loan_fund_other_ratio_3m DOUBLE comment '近3月轻资产交易其他资方通过率',
--     loan_fund_other_ratio_6m DOUBLE comment '近6月轻资产交易其他资方通过率',
--     loan_fund_other_ratio_12m DOUBLE comment '近12月轻资产交易其他资方通过率',
--     loan_fund_other_ratio_24m DOUBLE comment '近24月轻资产交易其他资方通过率',
--     loan_fund_other_ratio_36m DOUBLE comment '近36月轻资产交易其他资方通过率',
--     loan_fund_other_avg_terms_all DOUBLE comment '历史轻资产交易其他资方平均期数',
--     loan_fund_other_avg_terms_1m DOUBLE comment '近1月轻资产交易其他资方平均期数',
--     loan_fund_other_avg_terms_3m DOUBLE comment '近3月轻资产交易其他资方平均期数',
--     loan_fund_other_avg_terms_6m DOUBLE comment '近6月轻资产交易其他资方平均期数',
--     loan_fund_other_avg_terms_12m DOUBLE comment '近12月轻资产交易其他资方平均期数',
--     loan_fund_other_avg_terms_24m DOUBLE comment '近24月轻资产交易其他资方平均期数',
--     loan_fund_other_avg_terms_36m DOUBLE comment '近36月轻资产交易其他资方平均期数',
--     loan_fund_other_max_terms_all FLOAT comment '历史轻资产交易其他资方最大期数',
--     loan_fund_other_max_terms_1m FLOAT comment '近1月轻资产交易其他资方最大期数',
--     loan_fund_other_max_terms_3m FLOAT comment '近3月轻资产交易其他资方最大期数',
--     loan_fund_other_max_terms_6m FLOAT comment '近6月轻资产交易其他资方最大期数',
--     loan_fund_other_max_terms_12m FLOAT comment '近12月轻资产交易其他资方最大期数',
--     loan_fund_other_max_terms_24m FLOAT comment '近24月轻资产交易其他资方最大期数',
--     loan_fund_other_max_terms_36m FLOAT comment '近36月轻资产交易其他资方最大期数',
--     loan_fund_other_min_terms_all FLOAT comment '历史轻资产交易其他资方最小期数',
--     loan_fund_other_min_terms_1m FLOAT comment '近1月轻资产交易其他资方最小期数',
--     loan_fund_other_min_terms_3m FLOAT comment '近3月轻资产交易其他资方最小期数',
--     loan_fund_other_min_terms_6m FLOAT comment '近6月轻资产交易其他资方最小期数',
--     loan_fund_other_min_terms_12m FLOAT comment '近12月轻资产交易其他资方最小期数',
--     loan_fund_other_min_terms_24m FLOAT comment '近24月轻资产交易其他资方最小期数',
--     loan_fund_other_min_terms_36m FLOAT comment '近36月轻资产交易其他资方最小期数',
--     loan_fund_other_principal_sum_all FLOAT comment '历史轻资产交易其他资方总借款本金',
--     loan_fund_other_principal_sum_1m FLOAT comment '近1月轻资产交易其他资方总借款本金',
--     loan_fund_other_principal_sum_3m FLOAT comment '近3月轻资产交易其他资方总借款本金',
--     loan_fund_other_principal_sum_6m FLOAT comment '近6月轻资产交易其他资方总借款本金',
--     loan_fund_other_principal_sum_12m FLOAT comment '近12月轻资产交易其他资方总借款本金',
--     loan_fund_other_principal_sum_24m FLOAT comment '近24月轻资产交易其他资方总借款本金',
--     loan_fund_other_principal_sum_36m FLOAT comment '近36月轻资产交易其他资方总借款本金',
--     loan_fund_other_avg_terms_avg_all FLOAT comment '历史轻资产交易其他资方平均借款本金',
--     loan_fund_other_principal_avg_1m FLOAT comment '近1月轻资产交易其他资方平均借款本金',
--     loan_fund_other_principal_avg_3m FLOAT comment '近3月轻资产交易其他资方平均借款本金',
--     loan_fund_other_principal_avg_6m FLOAT comment '近6月轻资产交易其他资方平均借款本金',
--     loan_fund_other_principal_avg_12m FLOAT comment '近12月轻资产交易其他资方平均借款本金',
--     loan_fund_other_principal_avg_24m FLOAT comment '近24月轻资产交易其他资方平均借款本金',
--     loan_fund_other_principal_avg_36m FLOAT comment '近36月轻资产交易其他资方平均借款本金',
--     loan_fund_other_max_terms_max_all FLOAT comment '历史轻资产交易其他资方最大借款本金',
--     loan_fund_other_principal_max_1m FLOAT comment '近1月轻资产交易其他资方最大借款本金',
--     loan_fund_other_principal_max_3m FLOAT comment '近3月轻资产交易其他资方最大借款本金',
--     loan_fund_other_principal_max_6m FLOAT comment '近6月轻资产交易其他资方最大借款本金',
--     loan_fund_other_principal_max_12m FLOAT comment '近12月轻资产交易其他资方最大借款本金',
--     loan_fund_other_principal_max_24m FLOAT comment '近24月轻资产交易其他资方最大借款本金',
--     loan_fund_other_principal_max_36m FLOAT comment '近36月轻资产交易其他资方最大借款本金',
--     loan_fund_other_min_terms_min_all FLOAT comment '历史轻资产交易其他资方最小借款本金',
--     loan_fund_other_principal_min_1m FLOAT comment '近1月轻资产交易其他资方最小借款本金',
--     loan_fund_other_principal_min_3m FLOAT comment '近3月轻资产交易其他资方最小借款本金',
--     loan_fund_other_principal_min_6m FLOAT comment '近6月轻资产交易其他资方最小借款本金',
--     loan_fund_other_principal_min_12m FLOAT comment '近12月轻资产交易其他资方最小借款本金',
--     loan_fund_other_principal_min_24m FLOAT comment '近24月轻资产交易其他资方最小借款本金',
--     loan_fund_other_principal_min_36m FLOAT comment '近36月轻资产交易其他资方最小借款本金',
--     loan_fund_other_avg_ir_all FLOAT comment '历史轻资产交易其他资方平均年化利率',
--     loan_fund_other_avg_ir_1m FLOAT comment '近1月轻资产交易其他资方平均年化利率',
--     loan_fund_other_avg_ir_3m FLOAT comment '近3月轻资产交易其他资方平均年化利率',
--     loan_fund_other_avg_ir_6m FLOAT comment '近6月轻资产交易其他资方平均年化利率',
--     loan_fund_other_avg_ir_12m FLOAT comment '近12月轻资产交易其他资方平均年化利率',
--     loan_fund_other_avg_ir_24m FLOAT comment '近24月轻资产交易其他资方平均年化利率',
--     loan_fund_other_avg_ir_36m FLOAT comment '近36月轻资产交易其他资方平均年化利率',
--     loan_fund_other_max_ir_all FLOAT comment '历史轻资产交易其他资方最大年化利率',
--     loan_fund_other_max_ir_1m FLOAT comment '近1月轻资产交易其他资方最大年化利率',
--     loan_fund_other_max_ir_3m FLOAT comment '近3月轻资产交易其他资方最大年化利率',
--     loan_fund_other_max_ir_6m FLOAT comment '近6月轻资产交易其他资方最大年化利率',
--     loan_fund_other_max_ir_12m FLOAT comment '近12月轻资产交易其他资方最大年化利率',
--     loan_fund_other_max_ir_24m FLOAT comment '近24月轻资产交易其他资方最大年化利率',
--     loan_fund_other_max_ir_36m FLOAT comment '近36月轻资产交易其他资方最大年化利率',
--     loan_fund_other_min_ir_all FLOAT comment '历史轻资产交易其他资方最小年化利率',
--     loan_fund_other_min_ir_1m FLOAT comment '近1月轻资产交易其他资方最小年化利率',
--     loan_fund_other_min_ir_3m FLOAT comment '近3月轻资产交易其他资方最小年化利率',
--     loan_fund_other_min_ir_6m FLOAT comment '近6月轻资产交易其他资方最小年化利率',
--     loan_fund_other_min_ir_12m FLOAT comment '近12月轻资产交易其他资方最小年化利率',
--     loan_fund_other_min_ir_24m FLOAT comment '近24月轻资产交易其他资方最小年化利率',
--     loan_fund_other_min_ir_36m FLOAT comment '近36月轻资产交易其他资方最小年化利率',
--     loan_fund_cnt_all BIGINT comment '历史轻资产交易发起资方个数',
--     loan_unique_fund_cnt_1m BIGINT comment '近1月轻资产交易发起资方个数',
--     loan_unique_fund_cnt_3m BIGINT comment '近3月轻资产交易发起资方个数',
--     loan_unique_fund_cnt_6m BIGINT comment '近6月轻资产交易发起资方个数',
--     loan_unique_fund_cnt_12m BIGINT comment '近12月轻资产交易发起资方个数',
--     loan_unique_fund_cnt_24m BIGINT comment '近24月轻资产交易发起资方个数',
--     loan_unique_fund_cnt_36m BIGINT comment '近36月轻资产交易发起资方个数',
--     loan_pass_fund_cnt_all BIGINT comment '历史轻资产交易通过资方个数',
--     loan_pass_unique_fund_cnt_1m BIGINT comment '近1月轻资产交易通过资方个数',
--     loan_pass_unique_fund_cnt_3m BIGINT comment '近3月轻资产交易通过资方个数',
--     loan_pass_unique_fund_cnt_6m BIGINT comment '近6月轻资产交易通过资方个数',
--     loan_pass_unique_fund_cnt_12m BIGINT comment '近12月轻资产交易通过资方个数',
--     loan_pass_unique_fund_cnt_24m BIGINT comment '近24月轻资产交易通过资方个数',
--     loan_pass_unique_fund_cnt_36m BIGINT comment '近36月轻资产交易通过资方个数',
--     loan_reject_fund_cnt_all BIGINT comment '历史轻资产交易拒绝资方个数',
--     loan_reject_unique_fund_cnt_1m BIGINT comment '近1月轻资产交易拒绝资方个数',
--     loan_reject_unique_fund_cnt_3m BIGINT comment '近3月轻资产交易拒绝资方个数',
--     loan_reject_unique_fund_cnt_6m BIGINT comment '近6月轻资产交易拒绝资方个数',
--     loan_reject_unique_fund_cnt_12m BIGINT comment '近12月轻资产交易拒绝资方个数',
--     loan_reject_unique_fund_cnt_24m BIGINT comment '近24月轻资产交易拒绝资方个数',
--     loan_reject_unique_fund_cnt_36m BIGINT comment '近36月轻资产交易拒绝资方个数',
--     credit_loan_avg_days_all DOUBLE comment '历史轻资产授信距首次交易平均天数',
--     credit_loan_avg_days_1m DOUBLE comment '近1月轻资产授信距首次交易平均天数',
--     credit_loan_avg_days_3m DOUBLE comment '近3月轻资产授信距首次交易平均天数',
--     credit_loan_avg_days_6m DOUBLE comment '近6月轻资产授信距首次交易平均天数',
--     credit_loan_avg_days_12m DOUBLE comment '近12月轻资产授信距首次交易平均天数',
--     credit_loan_avg_days_24m DOUBLE comment '近24月轻资产授信距首次交易平均天数',
--     credit_loan_avg_days_36m DOUBLE comment '近36月轻资产授信距首次交易平均天数',
--     credit_loan_usage_rate_all FLOAT comment '历史轻资产授信后首次交易额度使用率',
--     credit_loan_usage_rate_1m FLOAT comment '近1月轻资产授信后首次交易额度使用率',
--     credit_loan_usage_rate_3m FLOAT comment '近3月轻资产授信后首次交易额度使用率',
--     credit_loan_usage_rate_6m FLOAT comment '近6月轻资产授信后首次交易额度使用率',
--     credit_loan_usage_rate_12m FLOAT comment '近12月轻资产授信后首次交易额度使用率',
--     credit_loan_usage_rate_24m FLOAT comment '近24月轻资产授信后首次交易额度使用率',
--     credit_loan_usage_rate_36m FLOAT comment '近36月轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level1_avg_days_all DOUBLE comment '历史第一梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level1_avg_days_1m DOUBLE comment '近1月第一梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level1_avg_days_3m DOUBLE comment '近3月第一梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level1_avg_days_6m DOUBLE comment '近6月第一梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level1_avg_days_12m DOUBLE comment '近12月第一梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level1_avg_days_24m DOUBLE comment '近24月第一梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level1_avg_days_36m DOUBLE comment '近36月第一梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level1_usage_rate_all FLOAT comment '历史第一梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level1_usage_rate_1m FLOAT comment '近1月第一梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level1_usage_rate_3m FLOAT comment '近3月第一梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level1_usage_rate_6m FLOAT comment '近6月第一梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level1_usage_rate_12m FLOAT comment '近12月第一梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level1_usage_rate_24m FLOAT comment '近24月第一梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level1_usage_rate_36m FLOAT comment '近36月第一梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level2_avg_days_all DOUBLE comment '历史第二梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level2_avg_days_1m DOUBLE comment '近1月第二梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level2_avg_days_3m DOUBLE comment '近3月第二梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level2_avg_days_6m DOUBLE comment '近6月第二梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level2_avg_days_12m DOUBLE comment '近12月第二梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level2_avg_days_24m DOUBLE comment '近24月第二梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level2_avg_days_36m DOUBLE comment '近36月第二梯队资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_level2_usage_rate_all FLOAT comment '历史第二梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level2_usage_rate_1m FLOAT comment '近1月第二梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level2_usage_rate_3m FLOAT comment '近3月第二梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level2_usage_rate_6m FLOAT comment '近6月第二梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level2_usage_rate_12m FLOAT comment '近12月第二梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level2_usage_rate_24m FLOAT comment '近24月第二梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_level2_usage_rate_36m FLOAT comment '近36月第二梯队资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_other_avg_days_all DOUBLE comment '历史其他资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_other_avg_days_1m DOUBLE comment '近1月其他资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_other_avg_days_3m DOUBLE comment '近3月其他资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_other_avg_days_6m DOUBLE comment '近6月其他资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_other_avg_days_12m DOUBLE comment '近12月其他资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_other_avg_days_24m DOUBLE comment '近24月其他资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_other_avg_days_36m DOUBLE comment '近36月其他资方轻资产授信距首次交易平均天数',
--     credit_loan_fund_other_usage_rate_all FLOAT comment '历史其他资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_other_usage_rate_1m FLOAT comment '近1月其他资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_other_usage_rate_3m FLOAT comment '近3月其他资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_other_usage_rate_6m FLOAT comment '近6月其他资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_other_usage_rate_12m FLOAT comment '近12月其他资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_other_usage_rate_24m FLOAT comment '近24月其他资方轻资产授信后首次交易额度使用率',
--     credit_loan_fund_other_usage_rate_36m FLOAT comment '近36月其他资方轻资产授信后首次交易额度使用率'
-- )
-- PARTITIONED BY (
-- 	ds STRING COMMENT '分区字段格式yyyymmdd'
-- );



---------------------------授信

drop table if exists ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp1;
create table ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp1 as
select  a.uid
        ,a.mdl_dte

        --************** 授信次数 **************
        --授信成功次数
        ,sum(case when b.is_credit=1 then 1 else null end) credit_cnt_all
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_cnt_1m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_cnt_3m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_cnt_6m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_cnt_12m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_cnt_24m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_cnt_36m

        --授信失败次数
        ,sum(case when b.is_credit=0 then 1 else null end) credit_reject_cnt_all
        ,sum(case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_reject_cnt_1m
        ,sum(case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_reject_cnt_3m
        ,sum(case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_reject_cnt_6m
        ,sum(case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_reject_cnt_12m
        ,sum(case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_reject_cnt_24m
        ,sum(case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_reject_cnt_36m

        --授信通过率
        ,avg(b.is_credit) as credit_ratio_all
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-1)  then b.is_credit else null end) as credit_ratio_1m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-3)  then b.is_credit else null end) as credit_ratio_3m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-6)  then b.is_credit else null end) as credit_ratio_6m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-12) then b.is_credit else null end) as credit_ratio_12m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-24) then b.is_credit else null end) as credit_ratio_24m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-36) then b.is_credit else null end) as credit_ratio_36m

        --************** 授信额度 **************
        --总授信额度
        ,sum(case when b.is_credit=1 then b.light_credit_limit else null end) credit_limit_cnt_all
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_limit_cnt_1m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_limit_cnt_3m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_limit_cnt_6m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_limit_cnt_12m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_limit_cnt_24m
        ,sum(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_limit_cnt_36m

        --平均授信额度
        ,avg(case when b.is_credit=1 then b.light_credit_limit else null end) credit_avg_limit_cnt_all
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_avg_limit_cnt_1m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_avg_limit_cnt_3m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_avg_limit_cnt_6m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_avg_limit_cnt_12m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_avg_limit_cnt_24m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_avg_limit_cnt_36m

        --最大授信额度
        ,max(case when b.is_credit=1 then b.light_credit_limit else null end) credit_max_limit_cnt_all
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_max_limit_cnt_1m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_max_limit_cnt_3m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_max_limit_cnt_6m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_max_limit_cnt_12m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_max_limit_cnt_24m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_max_limit_cnt_36m

        --最小授信额度
        ,min(case when b.is_credit=1 then b.light_credit_limit else null end) credit_min_limit_cnt_all
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_min_limit_cnt_1m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_min_limit_cnt_3m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_min_limit_cnt_6m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_min_limit_cnt_12m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_min_limit_cnt_24m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_min_limit_cnt_36m


        --************** 年化利率 **************
        --平均授信年化利率
        ,avg(case when b.is_credit=1 then b.fund_annual_ir else null end) credit_avg_ir_cnt_all
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_avg_ir_cnt_1m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_avg_ir_cnt_3m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_avg_ir_cnt_6m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_avg_ir_cnt_12m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_avg_ir_cnt_24m
        ,avg(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_avg_ir_cnt_36m

        --最高授信年化利率
        ,max(case when b.is_credit=1 then b.fund_annual_ir else null end) credit_max_ir_cnt_all
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_max_ir_cnt_1m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_max_ir_cnt_3m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_max_ir_cnt_6m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_max_ir_cnt_12m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_max_ir_cnt_24m
        ,max(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_max_ir_cnt_36m

        --最低授信年化利率
        ,min(case when b.is_credit=1 then b.fund_annual_ir else null end) credit_min_ir_cnt_all
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_min_ir_cnt_1m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_min_ir_cnt_3m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_min_ir_cnt_6m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_min_ir_cnt_12m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_min_ir_cnt_24m
        ,min(case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_min_ir_cnt_36m


        --************** 一梯队资方授信次数'PSBCXJ','MSXF','GOMEFUND','DUXIAOMAN','QHJT','HLFUND','TCQZC','WANDA','ZHONGANDAI'
		--************** 中邮消金	马消	国美美易借	度小满金融	360数科	哈啰	同程金服	万达	众安贷 **************
        --授信成功次数
        ,sum(case when b.is_credit=1 and fund_class = 'level1' then 1 else null end) credit_fund_level1_cnt_all
        ,sum(case when b.is_credit=1 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_fund_level1_cnt_1m
        ,sum(case when b.is_credit=1 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_fund_level1_cnt_3m
        ,sum(case when b.is_credit=1 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_fund_level1_cnt_6m
        ,sum(case when b.is_credit=1 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_fund_level1_cnt_12m
        ,sum(case when b.is_credit=1 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_fund_level1_cnt_24m
        ,sum(case when b.is_credit=1 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_fund_level1_cnt_36m
															
        --授信失败次数                                      
        ,sum(case when b.is_credit=0 and fund_class = 'level1' then 1 else null end) credit_fund_level1_reject_cnt_all
        ,sum(case when b.is_credit=0 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_fund_level1_reject_cnt_1m
        ,sum(case when b.is_credit=0 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_fund_level1_reject_cnt_3m
        ,sum(case when b.is_credit=0 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_fund_level1_reject_cnt_6m
        ,sum(case when b.is_credit=0 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_fund_level1_reject_cnt_12m
        ,sum(case when b.is_credit=0 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_fund_level1_reject_cnt_24m
        ,sum(case when b.is_credit=0 and fund_class = 'level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_fund_level1_reject_cnt_36m

        --授信通过率
        ,avg(case when fund_class = 'level1' then b.is_credit else null end) as credit_fund_level1_ratio_all
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-1)  and fund_class = 'level1' then b.is_credit else null end) as credit_fund_level1_ratio_1m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-3)  and fund_class = 'level1' then b.is_credit else null end) as credit_fund_level1_ratio_3m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-6)  and fund_class = 'level1' then b.is_credit else null end) as credit_fund_level1_ratio_6m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-12) and fund_class = 'level1' then b.is_credit else null end) as credit_fund_level1_ratio_12m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-24) and fund_class = 'level1' then b.is_credit else null end) as credit_fund_level1_ratio_24m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-36) and fund_class = 'level1' then b.is_credit else null end) as credit_fund_level1_ratio_36m


        --************** 授信额度 **************
        --总授信额度
        ,sum(case when b.is_credit=1 and fund_class='level1' then b.light_credit_limit else null end) credit_fund_level1_limit_cnt_all
        ,sum(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level1_limit_cnt_1m
        ,sum(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level1_limit_cnt_3m
        ,sum(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level1_limit_cnt_6m
        ,sum(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level1_limit_cnt_12m
        ,sum(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level1_limit_cnt_24m
        ,sum(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level1_limit_cnt_36m
														  
        --平均授信额度                                    
        ,avg(case when b.is_credit=1 and fund_class='level1' then b.light_credit_limit else null end) credit_fund_level1_avg_limit_cnt_all
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level1_avg_limit_cnt_1m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level1_avg_limit_cnt_3m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level1_avg_limit_cnt_6m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level1_avg_limit_cnt_12m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level1_avg_limit_cnt_24m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level1_avg_limit_cnt_36m
														  
        --最大授信额度                                    
        ,max(case when b.is_credit=1 and fund_class='level1' then b.light_credit_limit else null end) credit_fund_level1_max_limit_cnt_all
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level1_max_limit_cnt_1m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level1_max_limit_cnt_3m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level1_max_limit_cnt_6m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level1_max_limit_cnt_12m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level1_max_limit_cnt_24m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level1_max_limit_cnt_36m
														  
        --最小授信额度                                    
        ,min(case when b.is_credit=1 and fund_class='level1' then b.light_credit_limit else null end) credit_fund_level1_min_limit_cnt_all
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level1_min_limit_cnt_1m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level1_min_limit_cnt_3m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level1_min_limit_cnt_6m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level1_min_limit_cnt_12m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level1_min_limit_cnt_24m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level1_min_limit_cnt_36m
														  
														  
        --************** 年化利率 ************            
        --平均授信年化利率                                
        ,avg(case when b.is_credit=1 and fund_class='level1' then b.fund_annual_ir else null end) credit_fund_level1_avg_ir_cnt_all
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_level1_avg_ir_cnt_1m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_level1_avg_ir_cnt_3m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_level1_avg_ir_cnt_6m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_level1_avg_ir_cnt_12m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_level1_avg_ir_cnt_24m
        ,avg(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_level1_avg_ir_cnt_36m
														  
        --最高授信年化利率                                
        ,max(case when b.is_credit=1 and fund_class='level1' then b.fund_annual_ir else null end) credit_fund_level1_max_ir_cnt_all
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_level1_max_ir_cnt_1m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_level1_max_ir_cnt_3m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_level1_max_ir_cnt_6m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_level1_max_ir_cnt_12m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_level1_max_ir_cnt_24m
        ,max(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_level1_max_ir_cnt_36m
														  
        --最低授信年化利率                                
        ,min(case when b.is_credit=1 and fund_class='level1' then b.fund_annual_ir else null end) credit_fund_level1_min_ir_cnt_all
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_level1_min_ir_cnt_1m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_level1_min_ir_cnt_3m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_level1_min_ir_cnt_6m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_level1_min_ir_cnt_12m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_level1_min_ir_cnt_24m
        ,min(case when b.is_credit=1 and fund_class='level1' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_level1_min_ir_cnt_36m


        --************** 二梯队资方授信次数'YXHFUND','XYFUND','JRFUND','WXQZC','FENQILEFUND','HAOFENQI','YQGFUND','SMYFUND','CREDITFLY','ORANGEFUND','ORANGEFUNDJJFF'
		--************** 宜享花	小赢	极融	维信豆豆钱	分期乐	好分期	洋钱罐	省呗	信用飞	桔子分期	桔子分期借据分发 **************
        --授信成功次数
        ,sum(case when b.is_credit=1 and fund_class = 'level2' then 1 else null end) credit_fund_level2_cnt_all
        ,sum(case when b.is_credit=1 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_fund_level2_cnt_1m
        ,sum(case when b.is_credit=1 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_fund_level2_cnt_3m
        ,sum(case when b.is_credit=1 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_fund_level2_cnt_6m
        ,sum(case when b.is_credit=1 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_fund_level2_cnt_12m
        ,sum(case when b.is_credit=1 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_fund_level2_cnt_24m
        ,sum(case when b.is_credit=1 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_fund_level2_cnt_36m
												
        --授信失败次数                         
        ,sum(case when b.is_credit=0 and fund_class = 'level2' then 1 else null end) credit_fund_level2_reject_cnt_all
        ,sum(case when b.is_credit=0 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_fund_level2_reject_cnt_1m
        ,sum(case when b.is_credit=0 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_fund_level2_reject_cnt_3m
        ,sum(case when b.is_credit=0 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_fund_level2_reject_cnt_6m
        ,sum(case when b.is_credit=0 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_fund_level2_reject_cnt_12m
        ,sum(case when b.is_credit=0 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_fund_level2_reject_cnt_24m
        ,sum(case when b.is_credit=0 and fund_class = 'level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_fund_level2_reject_cnt_36m

        --授信通过率
        ,avg(case when fund_class = 'level2' then b.is_credit else null end) as credit_fund_level2_ratio_all
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-1)  and fund_class = 'level2' then b.is_credit else null end) as credit_fund_level2_ratio_1m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-3)  and fund_class = 'level2' then b.is_credit else null end) as credit_fund_level2_ratio_3m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-6)  and fund_class = 'level2' then b.is_credit else null end) as credit_fund_level2_ratio_6m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-12) and fund_class = 'level2' then b.is_credit else null end) as credit_fund_level2_ratio_12m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-24) and fund_class = 'level2' then b.is_credit else null end) as credit_fund_level2_ratio_24m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-36) and fund_class = 'level2' then b.is_credit else null end) as credit_fund_level2_ratio_36m


        --************** 授信额度 **************
        --总授信额度
        ,sum(case when b.is_credit=1 and fund_class='level2' then b.light_credit_limit else null end) credit_fund_level2_limit_cnt_all
        ,sum(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level2_limit_cnt_1m
        ,sum(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level2_limit_cnt_3m
        ,sum(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level2_limit_cnt_6m
        ,sum(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level2_limit_cnt_12m
        ,sum(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level2_limit_cnt_24m
        ,sum(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level2_limit_cnt_36m
											
        --平均授信额度                    
        ,avg(case when b.is_credit=1 and fund_class='level2' then b.light_credit_limit else null end) credit_fund_level2_avg_limit_cnt_all
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level2_avg_limit_cnt_1m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level2_avg_limit_cnt_3m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level2_avg_limit_cnt_6m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level2_avg_limit_cnt_12m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level2_avg_limit_cnt_24m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level2_avg_limit_cnt_36m
											
        --最大授信额度                    
        ,max(case when b.is_credit=1 and fund_class='level2' then b.light_credit_limit else null end) credit_fund_level2_max_limit_cnt_all
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level2_max_limit_cnt_1m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level2_max_limit_cnt_3m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level2_max_limit_cnt_6m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level2_max_limit_cnt_12m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level2_max_limit_cnt_24m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level2_max_limit_cnt_36m
											
        --最小授信额度                
        ,min(case when b.is_credit=1 and fund_class='level2' then b.light_credit_limit else null end) credit_fund_level2_min_limit_cnt_all
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_level2_min_limit_cnt_1m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_level2_min_limit_cnt_3m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_level2_min_limit_cnt_6m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_level2_min_limit_cnt_12m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_level2_min_limit_cnt_24m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_level2_min_limit_cnt_36m
											
										
        --************** 年化利率 ************
        --平均授信年化利率                    
        ,avg(case when b.is_credit=1 and fund_class='level2' then b.fund_annual_ir else null end) credit_fund_level2_avg_ir_cnt_all
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_level2_avg_ir_cnt_1m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_level2_avg_ir_cnt_3m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_level2_avg_ir_cnt_6m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_level2_avg_ir_cnt_12m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_level2_avg_ir_cnt_24m
        ,avg(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_level2_avg_ir_cnt_36m
												
        --最高授信年化利率                
        ,max(case when b.is_credit=1 and fund_class='level2' then b.fund_annual_ir else null end) credit_fund_level2_max_ir_cnt_all
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_level2_max_ir_cnt_1m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_level2_max_ir_cnt_3m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_level2_max_ir_cnt_6m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_level2_max_ir_cnt_12m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_level2_max_ir_cnt_24m
        ,max(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_level2_max_ir_cnt_36m
												
        --最低授信年化利率                  
        ,min(case when b.is_credit=1 and fund_class='level2' then b.fund_annual_ir else null end) credit_fund_level2_min_ir_cnt_all
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_level2_min_ir_cnt_1m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_level2_min_ir_cnt_3m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_level2_min_ir_cnt_6m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_level2_min_ir_cnt_12m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_level2_min_ir_cnt_24m
        ,min(case when b.is_credit=1 and fund_class='level2' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_level2_min_ir_cnt_36m


        --************** 三梯队其他资方 **************
        --授信成功次数
        ,sum(case when b.is_credit=1 and fund_class = 'other' then 1 else null end) credit_fund_other_cnt_all
        ,sum(case when b.is_credit=1 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_fund_other_cnt_1m
        ,sum(case when b.is_credit=1 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_fund_other_cnt_3m
        ,sum(case when b.is_credit=1 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_fund_other_cnt_6m
        ,sum(case when b.is_credit=1 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_fund_other_cnt_12m
        ,sum(case when b.is_credit=1 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_fund_other_cnt_24m
        ,sum(case when b.is_credit=1 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_fund_other_cnt_36m
															
        --授信失败次数                                      
        ,sum(case when b.is_credit=0 and fund_class = 'other' then 1 else null end) credit_fund_other_reject_cnt_all
        ,sum(case when b.is_credit=0 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as credit_fund_other_reject_cnt_1m
        ,sum(case when b.is_credit=0 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as credit_fund_other_reject_cnt_3m
        ,sum(case when b.is_credit=0 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as credit_fund_other_reject_cnt_6m
        ,sum(case when b.is_credit=0 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as credit_fund_other_reject_cnt_12m
        ,sum(case when b.is_credit=0 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as credit_fund_other_reject_cnt_24m
        ,sum(case when b.is_credit=0 and fund_class = 'other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as credit_fund_other_reject_cnt_36m

        --授信通过率
        ,avg(case when fund_class = 'other' then b.is_credit else null end) as credit_fund_other_ratio_all
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-1)  and fund_class = 'other' then b.is_credit else null end) as credit_fund_other_ratio_1m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-3)  and fund_class = 'other' then b.is_credit else null end) as credit_fund_other_ratio_3m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-6)  and fund_class = 'other' then b.is_credit else null end) as credit_fund_other_ratio_6m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-12) and fund_class = 'other' then b.is_credit else null end) as credit_fund_other_ratio_12m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-24) and fund_class = 'other' then b.is_credit else null end) as credit_fund_other_ratio_24m
        ,avg(case when to_date(b.crt_time)>add_months(a.mdl_dte,-36) and fund_class = 'other' then b.is_credit else null end) as credit_fund_other_ratio_36m


        --************** 授信额度 **************
        --总授信额度
        ,sum(case when b.is_credit=1 and fund_class='other' then b.light_credit_limit else null end) credit_fund_other_limit_cnt_all
        ,sum(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_other_limit_cnt_1m
        ,sum(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_other_limit_cnt_3m
        ,sum(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_other_limit_cnt_6m
        ,sum(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_other_limit_cnt_12m
        ,sum(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_other_limit_cnt_24m
        ,sum(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_other_limit_cnt_36m
														  
        --平均授信额度                                    
        ,avg(case when b.is_credit=1 and fund_class='other' then b.light_credit_limit else null end) credit_fund_other_avg_limit_cnt_all
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_other_avg_limit_cnt_1m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_other_avg_limit_cnt_3m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_other_avg_limit_cnt_6m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_other_avg_limit_cnt_12m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_other_avg_limit_cnt_24m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_other_avg_limit_cnt_36m
														  
        --最大授信额度                                    
        ,max(case when b.is_credit=1 and fund_class='other' then b.light_credit_limit else null end) credit_fund_other_max_limit_cnt_all
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_other_max_limit_cnt_1m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_other_max_limit_cnt_3m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_other_max_limit_cnt_6m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_other_max_limit_cnt_12m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_other_max_limit_cnt_24m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_other_max_limit_cnt_36m
														  
        --最小授信额度                                    
        ,min(case when b.is_credit=1 and fund_class='other' then b.light_credit_limit else null end) credit_fund_other_min_limit_cnt_all
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.light_credit_limit else null end ) as credit_fund_other_min_limit_cnt_1m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.light_credit_limit else null end ) as credit_fund_other_min_limit_cnt_3m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.light_credit_limit else null end ) as credit_fund_other_min_limit_cnt_6m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_credit_limit else null end ) as credit_fund_other_min_limit_cnt_12m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_credit_limit else null end ) as credit_fund_other_min_limit_cnt_24m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_credit_limit else null end ) as credit_fund_other_min_limit_cnt_36m
														  
														  
        --************** 年化利率 ************            
        --平均授信年化利率                                
        ,avg(case when b.is_credit=1 and fund_class='other' then b.fund_annual_ir else null end) credit_fund_other_avg_ir_cnt_all
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_other_avg_ir_cnt_1m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_other_avg_ir_cnt_3m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_other_avg_ir_cnt_6m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_other_avg_ir_cnt_12m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_other_avg_ir_cnt_24m
        ,avg(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_other_avg_ir_cnt_36m
														  
        --最高授信年化利率                                
        ,max(case when b.is_credit=1 and fund_class='other' then b.fund_annual_ir else null end) credit_fund_other_max_ir_cnt_all
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_other_max_ir_cnt_1m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_other_max_ir_cnt_3m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_other_max_ir_cnt_6m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_other_max_ir_cnt_12m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_other_max_ir_cnt_24m
        ,max(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_other_max_ir_cnt_36m
														  
        --最低授信年化利率                                
        ,min(case when b.is_credit=1 and fund_class='other' then b.fund_annual_ir else null end) credit_fund_other_min_ir_cnt_all
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_annual_ir else null end ) as credit_fund_other_min_ir_cnt_1m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_annual_ir else null end ) as credit_fund_other_min_ir_cnt_3m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_annual_ir else null end ) as credit_fund_other_min_ir_cnt_6m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_annual_ir else null end ) as credit_fund_other_min_ir_cnt_12m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_annual_ir else null end ) as credit_fund_other_min_ir_cnt_24m
        ,min(case when b.is_credit=1 and fund_class='other' and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_annual_ir else null end ) as credit_fund_other_min_ir_cnt_36m


        --************** 资方名称 **************
        ,count(distinct b.fund_code ) as credit_fund_cnt_all
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_code else null end ) as credit_unique_fund_cnt_1m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_code else null end ) as credit_unique_fund_cnt_3m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_code else null end ) as credit_unique_fund_cnt_6m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_code else null end ) as credit_unique_fund_cnt_12m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_code else null end ) as credit_unique_fund_cnt_24m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_code else null end ) as credit_unique_fund_cnt_36m
        ,count(distinct case when b.is_credit=1 then b.fund_code else null end) as credit_pass_fund_cnt_all
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_code else null end ) as credit_pass_unique_fund_cnt_1m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_code else null end ) as credit_pass_unique_fund_cnt_3m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_code else null end ) as credit_pass_unique_fund_cnt_6m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_code else null end ) as credit_pass_unique_fund_cnt_12m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_code else null end ) as credit_pass_unique_fund_cnt_24m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_code else null end ) as credit_pass_unique_fund_cnt_36m
        ,count(distinct case when b.is_credit=0 then b.fund_code else null end) as credit_reject_fund_cnt_all
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then  b.fund_code else null end ) as credit_reject_unique_fund_cnt_1m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then  b.fund_code else null end ) as credit_reject_unique_fund_cnt_3m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then  b.fund_code else null end ) as credit_reject_unique_fund_cnt_6m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.fund_code else null end ) as credit_reject_unique_fund_cnt_12m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.fund_code else null end ) as credit_reject_unique_fund_cnt_24m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.fund_code else null end ) as credit_reject_unique_fund_cnt_36m


        --************** 重资产导流渠道 **************        
        ,count(distinct b.light_diversion_scene ) as credit_unique_scene_cnt_all
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then b.light_diversion_scene else null end ) as credit_unique_scene_cnt_1m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then b.light_diversion_scene else null end ) as credit_unique_scene_cnt_3m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then b.light_diversion_scene else null end ) as credit_unique_scene_cnt_6m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_diversion_scene else null end ) as credit_unique_scene_cnt_12m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_diversion_scene else null end ) as credit_unique_scene_cnt_24m
        ,count(distinct case when to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_diversion_scene else null end ) as credit_unique_scene_cnt_36m
        ,count(distinct case when b.is_credit=1 then b.light_diversion_scene else null end) as credit_pass_unique_scene_cnt_all
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then b.light_diversion_scene else null end ) as credit_pass_unique_scene_cnt_1m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then b.light_diversion_scene else null end ) as credit_pass_unique_scene_cnt_3m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then b.light_diversion_scene else null end ) as credit_pass_unique_scene_cnt_6m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_diversion_scene else null end ) as credit_pass_unique_scene_cnt_12m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_diversion_scene else null end ) as credit_pass_unique_scene_cnt_24m
        ,count(distinct case when b.is_credit=1 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_diversion_scene else null end ) as credit_pass_unique_scene_cnt_36m
        ,count(distinct case when b.is_credit=0 then b.light_diversion_scene else null end) as credit_reject_unique_scene_cnt_all
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-1) then b.light_diversion_scene else null end ) as credit_reject_unique_scene_cnt_1m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-3) then b.light_diversion_scene else null end ) as credit_reject_unique_scene_cnt_3m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-6) then b.light_diversion_scene else null end ) as credit_reject_unique_scene_cnt_6m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-12) then b.light_diversion_scene else null end ) as credit_reject_unique_scene_cnt_12m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-24) then b.light_diversion_scene else null end ) as credit_reject_unique_scene_cnt_24m
        ,count(distinct case when b.is_credit=0 and to_date(b.crt_time)>add_months(to_date(a.mdl_dte),-36) then b.light_diversion_scene else null end ) as credit_reject_unique_scene_cnt_36m


from    (   
            select uid,mdl_dte from ${dwa_risk}.dwa_risk_f_light_sample_all_base_df where ds = '${bizdate}'
        ) a 
left join   (   
            select x1.*
            from
                    ( 
                    select  uid
                            ,light_diversion_sn
                            ,create_time crt_time
                            ,substr(create_time,1,10) as credit_apply_date
                            ,fund_credit_time
                            ,fund_code
            				,case when fund_code in ('PSBCXJ','MSXF','GOMEFUND','DUXIAOMAN','QHJT','HLFUND','TCQZC','WANDA','ZHONGANDAI') then 'level1'
            				when fund_code in ('YXHFUND','XYFUND','JRFUND','WXQZC','FENQILEFUND','HAOFENQI','YQGFUND','SMYFUND','CREDITFLY','ORANGEFUND','ORANGEFUNDJJFF') then 'level2'
            				else 'other' end as fund_class
                            ,case when light_credit_status = '成功' 
                            and fund_credit_time is not null 
                            and substr(create_time,1,10) <= substr(fund_credit_time,1,10) 
                            and light_credit_limit <>0 then '1' else '0' 
                            end as is_credit
                            ,light_credit_limit
                            ,fund_annual_ir
                            ,light_diversion_scene
                            ,light_credit_status
                            ,row_number()over(partition by uid,fund_code,substr(create_time,1,10) order by create_time asc) as rnk
                    from    ${dwa_risk}.dwa_risk_f_light_credit_data_base_df
                            --申请授信流水表----最小分区20220506,但有效数据目测20220801之后---
                    where   ds = '${bizdate}' 
                    )x1
            where   x1.rnk = 1 
                    -- 排除历史错误数据逻辑 轻资产业务方提供
                    and ((x1.light_credit_status = '成功' 
                    and x1.fund_credit_time is not null 
                    and substr(x1.crt_time,1,10) <= substr(x1.fund_credit_time,1,10) 
                    and x1.light_credit_limit <>0) 
                    or (x1.light_credit_status = '失败' 
                    and substr(x1.crt_time,1,10) <= substr(x1.fund_credit_time,1,10)))
            ) b 
on a.uid = b.uid 
and to_date(mdl_dte) > credit_apply_date
group by a.uid,a.mdl_dte
;


---------------------------轻资产交易

drop table if exists ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp2;
create table ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp2 as
select  a.uid
        ,a.mdl_dte

        -- 重资产订单前n个月通过的轻资产订单数
        --交易成功次数
        ,sum(case when b.is_loan=1 then 1 else null end) loan_cnt_all
        ,sum(case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_cnt_1m
        ,sum(case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_cnt_3m
        ,sum(case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_cnt_6m
        ,sum(case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_cnt_12m
        ,sum(case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_cnt_24m
        ,sum(case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_cnt_36m

        --交易失败次数
        ,sum(case when b.is_loan=0 then 1 else null end) loan_reject_cnt_all
        ,sum(case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_reject_cnt_1m
        ,sum(case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_reject_cnt_3m
        ,sum(case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_reject_cnt_6m
        ,sum(case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_reject_cnt_12m
        ,sum(case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_reject_cnt_24m
        ,sum(case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_reject_cnt_36m

        --交易通过率
        -- 重资产订单前n个月发起的轻资产订单的通过率
        ,avg(is_loan) loan_ratio_all
        ,avg(case when loan_create_date>add_months(a.mdl_dte,-1)  then is_loan else null end) as loan_ratio_1m
        ,avg(case when loan_create_date>add_months(a.mdl_dte,-3)  then is_loan else null end) as loan_ratio_3m
        ,avg(case when loan_create_date>add_months(a.mdl_dte,-6)  then is_loan else null end) as loan_ratio_6m
        ,avg(case when loan_create_date>add_months(a.mdl_dte,-12) then is_loan else null end) as loan_ratio_12m
        ,avg(case when loan_create_date>add_months(a.mdl_dte,-24) then is_loan else null end) as loan_ratio_24m
        ,avg(case when loan_create_date>add_months(a.mdl_dte,-36) then is_loan else null end) as loan_ratio_36m

        --********************* 交易期数 ******************

        -- 重资产订单前n个月通过的轻资产订单的平均期数
        ,avg(case when is_loan=1 and b.uid is not null then total_stage else null end) loan_avg_terms_all
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_avg_terms_1m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_avg_terms_3m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_avg_terms_6m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_avg_terms_12m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_avg_terms_24m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_avg_terms_36m

        -- 重资产订单前n个月通过的轻资产订单的最大期数
        ,max(case when is_loan=1 and b.uid is not null then total_stage else null end) loan_max_terms_all
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_max_terms_1m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_max_terms_3m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_max_terms_6m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_max_terms_12m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_max_terms_24m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_max_terms_36m

        -- 重资产订单前n个月通过的轻资产订单的最小期数
        ,min(case when is_loan=1 and b.uid is not null then total_stage else null end) loan_min_terms_all
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_min_terms_1m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_min_terms_3m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_min_terms_6m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_min_terms_12m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_min_terms_24m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_min_terms_36m


        --********************* 借款本金 ******************

        -- 重资产订单前n个月通过的轻资产订单借款本金总和
        ,sum(case when is_loan=1 and b.uid is not null then loan_principal else null end) loan_principal_sum_all
        ,sum(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_principal_sum_1m
        ,sum(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_principal_sum_3m
        ,sum(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_principal_sum_6m
        ,sum(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_principal_sum_12m
        ,sum(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_principal_sum_24m
        ,sum(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_principal_sum_36m

        -- 重资产订单前n个月通过的轻资产订单平均借款本金
        ,avg(case when is_loan=1 and b.uid is not null then loan_principal else null end) loan_avg_terms_avg_all
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_principal_avg_1m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_principal_avg_3m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_principal_avg_6m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_principal_avg_12m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_principal_avg_24m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_principal_avg_36m

        -- 重资产订单前n个月通过的轻资产订单最大借款本金
        ,max(case when is_loan=1 and b.uid is not null then loan_principal else null end) loan_max_terms_max_all
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_principal_max_1m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_principal_max_3m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_principal_max_6m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_principal_max_12m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_principal_max_24m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_principal_max_36m

        -- 重资产订单前n个月通过的轻资产订单最小借款本金
        ,min(case when is_loan=1 and b.uid is not null then loan_principal else null end) loan_min_terms_min_all
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_principal_min_1m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_principal_min_3m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_principal_min_6m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_principal_min_12m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_principal_min_24m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_principal_min_36m


        --********************* 借款利率 ******************

        -- 重资产订单前n个月通过的轻资产订单的平均利率
        ,avg(case when is_loan=1 and b.uid is not null then annual_ir_rate else null end) loan_avg_ir_all
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_avg_ir_1m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_avg_ir_3m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_avg_ir_6m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_avg_ir_12m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_avg_ir_24m
        ,avg(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_avg_ir_36m

        -- 重资产订单前n个月通过的轻资产订单的最大利率
        ,max(case when is_loan=1 and b.uid is not null then annual_ir_rate else null end) loan_max_ir_all
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_max_ir_1m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_max_ir_3m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_max_ir_6m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_max_ir_12m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_max_ir_24m
        ,max(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_max_ir_36m

        -- 重资产订单前n个月通过的轻资产订单的最小利率
        ,min(case when is_loan=1 and b.uid is not null then annual_ir_rate else null end) loan_min_ir_all
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_min_ir_1m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_min_ir_3m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_min_ir_6m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_min_ir_12m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_min_ir_24m
        ,min(case when is_loan=1 and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_min_ir_36m



        --************** 一梯队资方授信次数'PSBCXJ','MSXF','GOMEFUND','DUXIAOMAN','QHJT','HLFUND','TCQZC','WANDA','ZHONGANDAI'
		--************** 中邮消金	马消	国美美易借	度小满金融	360数科	哈啰	同程金服	万达	众安贷 **************

        -- 重资产订单前n个月通过的轻资产订单数
        --交易成功次数
        ,sum(case when b.is_loan=1 and fund_class = 'level1' then 1 else null end) loan_fund_level1_cnt_all
        ,sum(case when b.is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_fund_level1_cnt_1m
        ,sum(case when b.is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_fund_level1_cnt_3m
        ,sum(case when b.is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_fund_level1_cnt_6m
        ,sum(case when b.is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_fund_level1_cnt_12m
        ,sum(case when b.is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_fund_level1_cnt_24m
        ,sum(case when b.is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_fund_level1_cnt_36m
											 
        --交易失败次数                       
        ,sum(case when b.is_loan=0 and fund_class = 'level1' then 1 else null end) loan_fund_level1_reject_cnt_all
        ,sum(case when b.is_loan=0 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_fund_level1_reject_cnt_1m
        ,sum(case when b.is_loan=0 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_fund_level1_reject_cnt_3m
        ,sum(case when b.is_loan=0 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_fund_level1_reject_cnt_6m
        ,sum(case when b.is_loan=0 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_fund_level1_reject_cnt_12m
        ,sum(case when b.is_loan=0 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_fund_level1_reject_cnt_24m
        ,sum(case when b.is_loan=0 and fund_class = 'level1' and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_fund_level1_reject_cnt_36m

        --交易通过率
        -- 重资产订单前n个月发起的轻资产订单的通过率
        ,avg(case when fund_class = 'level1' then is_loan else null end) loan_fund_level1_ratio_all
        ,avg(case when fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then is_loan else null end) as loan_fund_level1_ratio_1m
        ,avg(case when fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then is_loan else null end) as loan_fund_level1_ratio_3m
        ,avg(case when fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then is_loan else null end) as loan_fund_level1_ratio_6m
        ,avg(case when fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then is_loan else null end) as loan_fund_level1_ratio_12m
        ,avg(case when fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then is_loan else null end) as loan_fund_level1_ratio_24m
        ,avg(case when fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then is_loan else null end) as loan_fund_level1_ratio_36m


        --********************* 交易期数 ******************

		-- 重订单前n月通过轻订单平均期数
        ,avg(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then total_stage else null end) loan_fund_level1_avg_terms_all
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_level1_avg_terms_1m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_level1_avg_terms_3m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_level1_avg_terms_6m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_level1_avg_terms_12m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_level1_avg_terms_24m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_level1_avg_terms_36m
										
		-- 重订单前n月通过轻订单最大期数         
        ,max(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then total_stage else null end) loan_fund_level1_max_terms_all
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_level1_max_terms_1m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_level1_max_terms_3m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_level1_max_terms_6m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_level1_max_terms_12m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_level1_max_terms_24m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_level1_max_terms_36m
										 
		-- 重订单前n月通过轻订单最小期数        
        ,min(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then total_stage else null end) loan_fund_level1_min_terms_all
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_level1_min_terms_1m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_level1_min_terms_3m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_level1_min_terms_6m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_level1_min_terms_12m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_level1_min_terms_24m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_level1_min_terms_36m
										   
										   
        --*********** 借款本金 ************
										  
		-- 重订单前n月通过轻订单借款本金总和    
        ,sum(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then loan_principal else null end) loan_fund_level1_principal_sum_all
        ,sum(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level1_principal_sum_1m
        ,sum(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level1_principal_sum_3m
        ,sum(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level1_principal_sum_6m
        ,sum(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level1_principal_sum_12m
        ,sum(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level1_principal_sum_24m
        ,sum(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level1_principal_sum_36m
										  
		-- 重订单前n月通过轻订单平均借款本金    
        ,avg(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then loan_principal else null end) loan_fund_level1_avg_terms_avg_all
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level1_principal_avg_1m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level1_principal_avg_3m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level1_principal_avg_6m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level1_principal_avg_12m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level1_principal_avg_24m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level1_principal_avg_36m
										 
		-- 重订单前n月通过轻订单最大借款本金    
        ,max(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then loan_principal else null end) loan_fund_level1_max_terms_max_all
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level1_principal_max_1m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level1_principal_max_3m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level1_principal_max_6m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level1_principal_max_12m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level1_principal_max_24m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level1_principal_max_36m
										 
		-- 重订单前n月通过轻订单最小借款本金   
        ,min(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then loan_principal else null end) loan_fund_level1_min_terms_min_all
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level1_principal_min_1m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level1_principal_min_3m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level1_principal_min_6m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level1_principal_min_12m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level1_principal_min_24m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level1_principal_min_36m
										   
										   
        --************ 借款利率 ***********
										  
		-- 重订单前n月通过轻订单的平均利率       
        ,avg(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then annual_ir_rate else null end) loan_fund_level1_avg_ir_all
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_level1_avg_ir_1m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_level1_avg_ir_3m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_level1_avg_ir_6m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_level1_avg_ir_12m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_level1_avg_ir_24m
        ,avg(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_level1_avg_ir_36m
										 
		-- 重订单前n月通过轻订单的最大利率        
        ,max(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then annual_ir_rate else null end) loan_fund_level1_max_ir_all
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_level1_max_ir_1m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_level1_max_ir_3m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_level1_max_ir_6m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_level1_max_ir_12m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_level1_max_ir_24m
        ,max(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_level1_max_ir_36m
										  
		-- 重订单前n月通过轻订单的最小利率       
        ,min(case when is_loan=1 and fund_class = 'level1' and b.uid is not null then annual_ir_rate else null end) loan_fund_level1_min_ir_all
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_level1_min_ir_1m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_level1_min_ir_3m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_level1_min_ir_6m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_level1_min_ir_12m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_level1_min_ir_24m
        ,min(case when is_loan=1 and fund_class = 'level1' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_level1_min_ir_36m


        --************** 二梯队资方授信次数'YXHFUND','XYFUND','JRFUND','WXQZC','FENQILEFUND','HAOFENQI','YQGFUND','SMYFUND','CREDITFLY','ORANGEFUND','ORANGEFUNDJJFF'
		--************** 宜享花	小赢	极融	维信豆豆钱	分期乐	好分期	洋钱罐	省呗	信用飞	桔子分期	桔子分期 **************

        -- 重资产订单前n个月通过的轻资产订单数
        --交易成功次数
        ,sum(case when b.is_loan=1 and fund_class = 'level2' then 1 else null end) loan_fund_level2_cnt_all
        ,sum(case when b.is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_fund_level2_cnt_1m
        ,sum(case when b.is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_fund_level2_cnt_3m
        ,sum(case when b.is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_fund_level2_cnt_6m
        ,sum(case when b.is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_fund_level2_cnt_12m
        ,sum(case when b.is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_fund_level2_cnt_24m
        ,sum(case when b.is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_fund_level2_cnt_36m
											 
        --交易失败次数                       
        ,sum(case when b.is_loan=0 and fund_class = 'level2' then 1 else null end) loan_fund_level2_reject_cnt_all
        ,sum(case when b.is_loan=0 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_fund_level2_reject_cnt_1m
        ,sum(case when b.is_loan=0 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_fund_level2_reject_cnt_3m
        ,sum(case when b.is_loan=0 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_fund_level2_reject_cnt_6m
        ,sum(case when b.is_loan=0 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_fund_level2_reject_cnt_12m
        ,sum(case when b.is_loan=0 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_fund_level2_reject_cnt_24m
        ,sum(case when b.is_loan=0 and fund_class = 'level2' and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_fund_level2_reject_cnt_36m

        --交易通过率
        -- 重资产订单前n个月发起的轻资产订单的通过率
        ,avg(case when fund_class = 'level2' then is_loan else null end) loan_fund_level2_ratio_all
        ,avg(case when fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then is_loan else null end) as loan_fund_level2_ratio_1m
        ,avg(case when fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then is_loan else null end) as loan_fund_level2_ratio_3m
        ,avg(case when fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then is_loan else null end) as loan_fund_level2_ratio_6m
        ,avg(case when fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then is_loan else null end) as loan_fund_level2_ratio_12m
        ,avg(case when fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then is_loan else null end) as loan_fund_level2_ratio_24m
        ,avg(case when fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then is_loan else null end) as loan_fund_level2_ratio_36m


        --********************* 交易期数 ******************

		-- 重订单前n月通过轻订单平均期数
        ,avg(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then total_stage else null end) loan_fund_level2_avg_terms_all
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_level2_avg_terms_1m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_level2_avg_terms_3m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_level2_avg_terms_6m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_level2_avg_terms_12m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_level2_avg_terms_24m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_level2_avg_terms_36m
														
		-- 重订单前n月通过轻订单最大期数                       
        ,max(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then total_stage else null end) loan_fund_level2_max_terms_all
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_level2_max_terms_1m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_level2_max_terms_3m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_level2_max_terms_6m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_level2_max_terms_12m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_level2_max_terms_24m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_level2_max_terms_36m
														
		-- 重订单前n月通过轻订单最小期数                       
        ,min(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then total_stage else null end) loan_fund_level2_min_terms_all
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_level2_min_terms_1m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_level2_min_terms_3m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_level2_min_terms_6m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_level2_min_terms_12m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_level2_min_terms_24m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_level2_min_terms_36m
										   
										   
        --*********** 借款本金 ************
										  
		-- 重订单前n月通过轻订单借款本金总和    
        ,sum(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then loan_principal else null end) loan_fund_level2_principal_sum_all
        ,sum(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level2_principal_sum_1m
        ,sum(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level2_principal_sum_3m
        ,sum(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level2_principal_sum_6m
        ,sum(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level2_principal_sum_12m
        ,sum(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level2_principal_sum_24m
        ,sum(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level2_principal_sum_36m
														
		-- 重订单前n月通过轻订单平均借款本金                   
        ,avg(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then loan_principal else null end) loan_fund_level2_avg_terms_avg_all
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level2_principal_avg_1m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level2_principal_avg_3m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level2_principal_avg_6m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level2_principal_avg_12m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level2_principal_avg_24m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level2_principal_avg_36m
														
		-- 重订单前n月通过轻订单最大借款本金                   
        ,max(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then loan_principal else null end) loan_fund_level2_max_terms_max_all
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level2_principal_max_1m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level2_principal_max_3m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level2_principal_max_6m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level2_principal_max_12m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level2_principal_max_24m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level2_principal_max_36m
														
		-- 重订单前n月通过轻订单最小借款本金                   
        ,min(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then loan_principal else null end) loan_fund_level2_min_terms_min_all
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_level2_principal_min_1m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_level2_principal_min_3m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_level2_principal_min_6m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_level2_principal_min_12m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_level2_principal_min_24m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_level2_principal_min_36m
										   
										   
        --************ 借款利率 ***********
										  
		-- 重订单前n月通过轻订单的平均利率       
        ,avg(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then annual_ir_rate else null end) loan_fund_level2_avg_ir_all
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_level2_avg_ir_1m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_level2_avg_ir_3m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_level2_avg_ir_6m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_level2_avg_ir_12m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_level2_avg_ir_24m
        ,avg(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_level2_avg_ir_36m
														
		-- 重订单前n月通过轻订单的最大利率                     
        ,max(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then annual_ir_rate else null end) loan_fund_level2_max_ir_all
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_level2_max_ir_1m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_level2_max_ir_3m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_level2_max_ir_6m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_level2_max_ir_12m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_level2_max_ir_24m
        ,max(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_level2_max_ir_36m
														
		-- 重订单前n月通过轻订单的最小利率                     
        ,min(case when is_loan=1 and fund_class = 'level2' and b.uid is not null then annual_ir_rate else null end) loan_fund_level2_min_ir_all
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_level2_min_ir_1m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_level2_min_ir_3m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_level2_min_ir_6m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_level2_min_ir_12m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_level2_min_ir_24m
        ,min(case when is_loan=1 and fund_class = 'level2' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_level2_min_ir_36m

        --************** 三梯队其他资方 ********************

        -- 重资产订单前n个月通过的轻资产订单数
        --交易成功次数
        ,sum(case when b.is_loan=1 and fund_class = 'other' then 1 else null end) loan_fund_other_cnt_all
        ,sum(case when b.is_loan=1 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_fund_other_cnt_1m
        ,sum(case when b.is_loan=1 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_fund_other_cnt_3m
        ,sum(case when b.is_loan=1 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_fund_other_cnt_6m
        ,sum(case when b.is_loan=1 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_fund_other_cnt_12m
        ,sum(case when b.is_loan=1 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_fund_other_cnt_24m
        ,sum(case when b.is_loan=1 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_fund_other_cnt_36m
											 
        --交易失败次数                       
        ,sum(case when b.is_loan=0 and fund_class = 'other' then 1 else null end) loan_fund_other_reject_cnt_all
        ,sum(case when b.is_loan=0 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  1 else null end ) as loan_fund_other_reject_cnt_1m
        ,sum(case when b.is_loan=0 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  1 else null end ) as loan_fund_other_reject_cnt_3m
        ,sum(case when b.is_loan=0 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  1 else null end ) as loan_fund_other_reject_cnt_6m
        ,sum(case when b.is_loan=0 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-12) then 1 else null end ) as loan_fund_other_reject_cnt_12m
        ,sum(case when b.is_loan=0 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-24) then 1 else null end ) as loan_fund_other_reject_cnt_24m
        ,sum(case when b.is_loan=0 and fund_class = 'other' and loan_create_date>add_months(to_date(a.mdl_dte),-36) then 1 else null end ) as loan_fund_other_reject_cnt_36m

        --交易通过率
        -- 重资产订单前n个月发起的轻资产订单的通过率
        ,avg(case when fund_class = 'other' then is_loan else null end) loan_fund_other_ratio_all
        ,avg(case when fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then is_loan else null end) as loan_fund_other_ratio_1m
        ,avg(case when fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then is_loan else null end) as loan_fund_other_ratio_3m
        ,avg(case when fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then is_loan else null end) as loan_fund_other_ratio_6m
        ,avg(case when fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then is_loan else null end) as loan_fund_other_ratio_12m
        ,avg(case when fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then is_loan else null end) as loan_fund_other_ratio_24m
        ,avg(case when fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then is_loan else null end) as loan_fund_other_ratio_36m


        --********************* 交易期数 ******************

		-- 重订单前n月通过轻订单平均期数
        ,avg(case when is_loan=1 and fund_class = 'other' and b.uid is not null then total_stage else null end) loan_fund_other_avg_terms_all
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_other_avg_terms_1m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_other_avg_terms_3m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_other_avg_terms_6m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_other_avg_terms_12m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_other_avg_terms_24m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_other_avg_terms_36m
														
		-- 重订单前n月通过轻订单最大期数                       
        ,max(case when is_loan=1 and fund_class = 'other' and b.uid is not null then total_stage else null end) loan_fund_other_max_terms_all
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_other_max_terms_1m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_other_max_terms_3m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_other_max_terms_6m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_other_max_terms_12m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_other_max_terms_24m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_other_max_terms_36m
														
		-- 重订单前n月通过轻订单最小期数                       
        ,min(case when is_loan=1 and fund_class = 'other' and b.uid is not null then total_stage else null end) loan_fund_other_min_terms_all
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then total_stage else null end) as loan_fund_other_min_terms_1m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then total_stage else null end) as loan_fund_other_min_terms_3m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then total_stage else null end) as loan_fund_other_min_terms_6m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then total_stage else null end) as loan_fund_other_min_terms_12m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then total_stage else null end) as loan_fund_other_min_terms_24m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then total_stage else null end) as loan_fund_other_min_terms_36m
										   
										   
        --*********** 借款本金 ************
										  
		-- 重订单前n月通过轻订单借款本金总和    
        ,sum(case when is_loan=1 and fund_class = 'other' and b.uid is not null then loan_principal else null end) loan_fund_other_principal_sum_all
        ,sum(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_other_principal_sum_1m
        ,sum(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_other_principal_sum_3m
        ,sum(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_other_principal_sum_6m
        ,sum(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_other_principal_sum_12m
        ,sum(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_other_principal_sum_24m
        ,sum(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_other_principal_sum_36m
														
		-- 重订单前n月通过轻订单平均借款本金                   
        ,avg(case when is_loan=1 and fund_class = 'other' and b.uid is not null then loan_principal else null end) loan_fund_other_avg_terms_avg_all
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_other_principal_avg_1m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_other_principal_avg_3m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_other_principal_avg_6m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_other_principal_avg_12m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_other_principal_avg_24m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_other_principal_avg_36m
														
		-- 重订单前n月通过轻订单最大借款本金                   
        ,max(case when is_loan=1 and fund_class = 'other' and b.uid is not null then loan_principal else null end) loan_fund_other_max_terms_max_all
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_other_principal_max_1m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_other_principal_max_3m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_other_principal_max_6m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_other_principal_max_12m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_other_principal_max_24m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_other_principal_max_36m
														
		-- 重订单前n月通过轻订单最小借款本金                   
        ,min(case when is_loan=1 and fund_class = 'other' and b.uid is not null then loan_principal else null end) loan_fund_other_min_terms_min_all
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then loan_principal else null end) as loan_fund_other_principal_min_1m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then loan_principal else null end) as loan_fund_other_principal_min_3m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then loan_principal else null end) as loan_fund_other_principal_min_6m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then loan_principal else null end) as loan_fund_other_principal_min_12m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then loan_principal else null end) as loan_fund_other_principal_min_24m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then loan_principal else null end) as loan_fund_other_principal_min_36m
										   
										   
        --************ 借款利率 ***********
										  
		-- 重订单前n月通过轻订单的平均利率       
        ,avg(case when is_loan=1 and fund_class = 'other' and b.uid is not null then annual_ir_rate else null end) loan_fund_other_avg_ir_all
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_other_avg_ir_1m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_other_avg_ir_3m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_other_avg_ir_6m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_other_avg_ir_12m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_other_avg_ir_24m
        ,avg(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_other_avg_ir_36m
														
		-- 重订单前n月通过轻订单的最大利率                     
        ,max(case when is_loan=1 and fund_class = 'other' and b.uid is not null then annual_ir_rate else null end) loan_fund_other_max_ir_all
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_other_max_ir_1m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_other_max_ir_3m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_other_max_ir_6m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_other_max_ir_12m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_other_max_ir_24m
        ,max(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_other_max_ir_36m
														
		-- 重订单前n月通过轻订单的最小利率                     
        ,min(case when is_loan=1 and fund_class = 'other' and b.uid is not null then annual_ir_rate else null end) loan_fund_other_min_ir_all
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-1)  then annual_ir_rate else null end) as loan_fund_other_min_ir_1m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-3)  then annual_ir_rate else null end) as loan_fund_other_min_ir_3m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-6)  then annual_ir_rate else null end) as loan_fund_other_min_ir_6m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-12) then annual_ir_rate else null end) as loan_fund_other_min_ir_12m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-24) then annual_ir_rate else null end) as loan_fund_other_min_ir_24m
        ,min(case when is_loan=1 and fund_class = 'other' and loan_create_date>add_months(a.mdl_dte,-36) then annual_ir_rate else null end) as loan_fund_other_min_ir_36m



        --************** 资方名称 **************
        ,count(distinct b.fund_code ) as loan_fund_cnt_all
        ,count(distinct case when loan_create_date>add_months(to_date(a.mdl_dte),-1) then  b.fund_code else null end ) as loan_unique_fund_cnt_1m
        ,count(distinct case when loan_create_date>add_months(to_date(a.mdl_dte),-3) then  b.fund_code else null end ) as loan_unique_fund_cnt_3m
        ,count(distinct case when loan_create_date>add_months(to_date(a.mdl_dte),-6) then  b.fund_code else null end ) as loan_unique_fund_cnt_6m
        ,count(distinct case when loan_create_date>add_months(to_date(a.mdl_dte),-12) then b.fund_code else null end ) as loan_unique_fund_cnt_12m
        ,count(distinct case when loan_create_date>add_months(to_date(a.mdl_dte),-24) then b.fund_code else null end ) as loan_unique_fund_cnt_24m
        ,count(distinct case when loan_create_date>add_months(to_date(a.mdl_dte),-36) then b.fund_code else null end ) as loan_unique_fund_cnt_36m
        ,count(distinct case when b.is_loan=1 then b.fund_code else null end) as loan_pass_fund_cnt_all
        ,count(distinct case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  b.fund_code else null end ) as loan_pass_unique_fund_cnt_1m
        ,count(distinct case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  b.fund_code else null end ) as loan_pass_unique_fund_cnt_3m
        ,count(distinct case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  b.fund_code else null end ) as loan_pass_unique_fund_cnt_6m
        ,count(distinct case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-12) then b.fund_code else null end ) as loan_pass_unique_fund_cnt_12m
        ,count(distinct case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-24) then b.fund_code else null end ) as loan_pass_unique_fund_cnt_24m
        ,count(distinct case when b.is_loan=1 and loan_create_date>add_months(to_date(a.mdl_dte),-36) then b.fund_code else null end ) as loan_pass_unique_fund_cnt_36m
        ,count(distinct case when b.is_loan=0 then b.fund_code else null end) as loan_reject_fund_cnt_all
        ,count(distinct case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-1) then  b.fund_code else null end ) as loan_reject_unique_fund_cnt_1m
        ,count(distinct case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-3) then  b.fund_code else null end ) as loan_reject_unique_fund_cnt_3m
        ,count(distinct case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-6) then  b.fund_code else null end ) as loan_reject_unique_fund_cnt_6m
        ,count(distinct case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-12) then b.fund_code else null end ) as loan_reject_unique_fund_cnt_12m
        ,count(distinct case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-24) then b.fund_code else null end ) as loan_reject_unique_fund_cnt_24m
        ,count(distinct case when b.is_loan=0 and loan_create_date>add_months(to_date(a.mdl_dte),-36) then b.fund_code else null end ) as loan_reject_unique_fund_cnt_36m


from (
            select uid,mdl_dte from ${dwa_risk}.dwa_risk_f_light_sample_all_base_df where ds = '${bizdate}'
            
) a   --重资产记录
left join (select uid
                  ,to_date(create_time) as loan_create_date
                  ,loan_principal
                  ,annual_ir_rate
                  ,order_no as ord_no
                  ,fund_code
				,case when fund_code in ('PSBCXJ','MSXF','GOMEFUND','DUXIAOMAN','QHJT','HLFUND','TCQZC','WANDA','ZHONGANDAI') then 'level1'
					  when fund_code in ('YXHFUND','XYFUND','JRFUND','WXQZC','FENQILEFUND','HAOFENQI','YQGFUND','SMYFUND','CREDITFLY','ORANGEFUND','ORANGEFUNDJJFF') then 'level2'
					  else 'other' end as fund_class
                  ,cast(light_loan_stage as float) as total_stage
                  ,case when order_no is not null then loan_success_flag else 0 end is_loan
            from ${cdmx}.cdmx_fct_light_loan_order_df
            where ds='${bizdate}'
            and to_date(create_time)<=to_date(to_date('${bizdate}','yyyymmdd'))
           ) b on a.uid=b.uid 
               and b.loan_create_date<a.mdl_dte--轻资产发标记录，可能有多条
group by a.uid,a.mdl_dte
;


---------------------------首次轻资产交易

drop table if exists ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp3;
create table ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp3 as
select  a.uid
        ,a.mdl_dte

        --授信到首次发起交易平均天数（因为可能会授信好几家机构）
        ,avg(case when loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_avg_days_all
        ,avg(case when credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_avg_days_1m
        ,avg(case when credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_avg_days_3m
        ,avg(case when credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_avg_days_6m
        ,avg(case when credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_avg_days_12m
        ,avg(case when credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_avg_days_24m
        ,avg(case when credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_avg_days_36m

        --授信到首次发起交易额度使用率
        ,sum(case when loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_usage_rate_all
        ,sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_usage_rate_1m
        ,sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_usage_rate_3m
        ,sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_usage_rate_6m
        ,sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_usage_rate_12m
        ,sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_usage_rate_24m
        ,sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_usage_rate_36m


        --************** 一梯队资方授信次数'PSBCXJ','MSXF','GOMEFUND','DUXIAOMAN','QHJT','HLFUND','TCQZC','WANDA','ZHONGANDAI'
		--************** 中邮消金	马消	国美美易借	度小满金融	360数科	哈啰	同程金服	万达	众安贷 **************

        --授信到首次发起交易平均天数（因为可能会授信好几家机构）
        ,avg(case when fund_class = 'level1' and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level1_avg_days_all
        ,avg(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level1_avg_days_1m
        ,avg(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level1_avg_days_3m
        ,avg(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level1_avg_days_6m
        ,avg(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level1_avg_days_12m
        ,avg(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level1_avg_days_24m
        ,avg(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level1_avg_days_36m

        --授信到首次发起交易额度使用率
        ,sum(case when fund_class = 'level1' and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level1' and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level1_usage_rate_all
        ,sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level1_usage_rate_1m
        ,sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level1_usage_rate_3m
        ,sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level1_usage_rate_6m
        ,sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level1_usage_rate_12m
        ,sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level1_usage_rate_24m
        ,sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level1' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level1_usage_rate_36m


        --************** 二梯队资方授信次数'YXHFUND','XYFUND','JRFUND','WXQZC','FENQILEFUND','HAOFENQI','YQGFUND','SMYFUND','CREDITFLY','ORANGEFUND','ORANGEFUNDJJFF'
		--************** 宜享花	小赢	极融	维信豆豆钱	分期乐	好分期	洋钱罐	省呗	信用飞	桔子分期	桔子分期 **************

        --授信到首次发起交易平均天数（因为可能会授信好几家机构）
        ,avg(case when fund_class = 'level2' and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level2_avg_days_all
        ,avg(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level2_avg_days_1m
        ,avg(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level2_avg_days_3m
        ,avg(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level2_avg_days_6m
        ,avg(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level2_avg_days_12m
        ,avg(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level2_avg_days_24m
        ,avg(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_level2_avg_days_36m

        --授信到首次发起交易额度使用率
        ,sum(case when fund_class = 'level2' and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level2' and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level2_usage_rate_all
        ,sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level2_usage_rate_1m
        ,sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level2_usage_rate_3m
        ,sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level2_usage_rate_6m
        ,sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level2_usage_rate_12m
        ,sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level2_usage_rate_24m
        ,sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'level2' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_level2_usage_rate_36m

        --************** 三梯队其他资方 **************

        --授信到首次发起交易平均天数（因为可能会授信好几家机构）
        ,avg(case when fund_class = 'other' and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_other_avg_days_all
        ,avg(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_other_avg_days_1m
        ,avg(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_other_avg_days_3m
        ,avg(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_other_avg_days_6m
        ,avg(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_other_avg_days_12m
        ,avg(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_other_avg_days_24m
        ,avg(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then datediff(loan_apply_time,credit_apply_time) else null end) credit_loan_fund_other_avg_days_36m

        --授信到首次发起交易额度使用率
        ,sum(case when fund_class = 'other' and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'other' and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_other_usage_rate_all
        ,sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-1)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_other_usage_rate_1m
        ,sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-3)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_other_usage_rate_3m
        ,sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-6)  and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_other_usage_rate_6m
        ,sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-12) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_other_usage_rate_12m
        ,sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-24) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_other_usage_rate_24m
        ,sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then loan_principal else null end)/sum(case when fund_class = 'other' and credit_apply_date>add_months(to_date(a.mdl_dte),-36) and loan_create_date<to_date(a.mdl_dte) then light_credit_limit else null end) credit_loan_fund_other_usage_rate_36m



from (
            select uid,mdl_dte from ${dwa_risk}.dwa_risk_f_light_sample_all_base_df where ds = '${bizdate}'
    ) a      
left join
    (
    select x2.uid
           ,x2.credit_apply_date
           ,x2.credit_apply_time
           ,x2.light_credit_limit
           ,x2.is_credit
           ,x2.fund_code
		   ,case when x2.fund_code in ('PSBCXJ','MSXF','GOMEFUND','DUXIAOMAN','QHJT','HLFUND','TCQZC','WANDA','ZHONGANDAI') then 'level1'
				 when x2.fund_code in ('YXHFUND','XYFUND','JRFUND','WXQZC','FENQILEFUND','HAOFENQI','YQGFUND','SMYFUND','CREDITFLY','ORANGEFUND','ORANGEFUNDJJFF') then 'level2'
				 else 'other' end as fund_class
           ,x4.order_no
           ,x4.loan_create_date
           ,x4.loan_apply_time
           ,x4.loan_success_flag
           ,x4.loan_principal

           ,row_number()over(partition by x2.uid,x2.credit_apply_date,x2.fund_code order by x4.loan_apply_time asc) as rnk
    from (  
        -- 同uid同天同资方一条授信流水
        select x1.*
        from
            (
                select 
                uid
                ,light_diversion_sn
                ,create_time credit_apply_time
                ,substr(create_time,1,10) as credit_apply_date
                ,fund_credit_time
                ,substr(fund_credit_time,1,10) as fund_credit_date
                ,fund_code
                ,case when light_credit_status = '成功' and fund_credit_time is not null and substr(create_time,1,10) <= substr(fund_credit_time,1,10) and light_credit_limit <>0 then '1' else '0' end as is_credit
                ,light_credit_limit
                ,fund_annual_ir
                ,light_diversion_scene
                ,light_credit_status
                ,row_number()over(partition by uid,fund_code,substr(create_time,1,10) order by create_time asc) as rnk
                from ${dwa_risk}.dwa_risk_f_light_credit_data_base_df  ----轻资产导流记录表 --申请授信流水表----最小分区20220506,但有效数据目测20220801之后---
                where ds = '${bizdate}'
            )x1
        where x1.rnk = 1 
        and ((x1.light_credit_status = '成功' and x1.fund_credit_time is not null and substr(x1.credit_apply_time,1,10) <= substr(x1.fund_credit_time,1,10) and x1.light_credit_limit <>0) 
        or (x1.light_credit_status = '失败' and substr(x1.credit_apply_time,1,10) <= substr(x1.fund_credit_time,1,10)))
	)x2
	left join
	(
		select
		uid
		,create_time loan_apply_time
		,substr(create_time,1,10) as loan_create_date
		,fund_code
		,fund_name
		,order_no
		,loan_principal
        ,loan_success_flag
		,cost_per_sales as cps
		,first_reloan_flag_by_uid
		,first_reloan_flag_by_fund
		from cdmx.cdmx_fct_light_loan_order_df
		where ds = '${bizdate}'
	)x4
	on x2.uid = x4.uid
	and x2.fund_code = x4.fund_code
	and x2.credit_apply_time <= x4.loan_apply_time
    -- and x4.create_time <= dateadd(x2.create_time,31,'dd')
) b 
on a.uid=b.uid 
and b.loan_create_date<a.mdl_dte
where rnk=1
group by a.uid,a.mdl_dte
;


---------------------------最终宽表整合-----------------------------

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_31light_credit_trade_cross_df partition(ds='${bizdate}')
SELECT a.uid,a.mdl_dte,`(uid|mdl_dte)?+.+`
from (
        select uid,mdl_dte from ${dwa_risk}.dwa_risk_f_light_sample_all_base_df where ds = '${bizdate}'
    ) a
left join ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp1 b 
on a.uid = b.uid and a.mdl_dte=b.mdl_dte
left join ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp2 c 
on a.uid = c.uid and a.mdl_dte=c.mdl_dte
left join ${dwa_risk}.dwa_risk_light_feature_part1_df_tmp3 d 
on a.uid = d.uid and a.mdl_dte=d.mdl_dte
;


-- select * from dwa_risk}.dwa_risk_dz_model_final_31light_credit_trade_cross_df where ds
-- feature-copilot:node-end ordinal=0
