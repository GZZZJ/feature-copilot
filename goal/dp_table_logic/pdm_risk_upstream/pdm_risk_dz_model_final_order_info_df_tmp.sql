-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_model_final_order_info_df_tmp
-- node_id: n_4517318199608410112
-- task_name: pdm_risk_dz_model_final_order_info_df
-- owner_name: 刘诗涵
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dz_model_final_order_info_df_tmp.json
-- source_json_sha256: aedf9e54918764b7c999be68bf1832bff7807779c61d2e41229e1d840f614747
-- upstream_table: pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp4
-- upstream_table: pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp3
-- upstream_table: pdm_risk.pdm_risk_f_heavy_order_info_detail_tmp
-- upstream_table: pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp1
-- upstream_table: pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp5
-- upstream_table: pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp
-- upstream_table: dwt.dwt_heavy_order_df
-- upstream_table: pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp2
-- upstream_table: pdm_risk.pdm_risk_f_heavy_order_info_basic_tmp

--MaxCompute_SQL
--********************************************************************--
--所属主题: 贷中宽表_借款明细数据
--功能描述: 包含重资产和全产品的订单基本信息变量及趋势类变量,针对近360天有过发起订单的客群分析
--创建者: 刘诗涵
--创建日期: 2023-03-01 15:40:14
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- create table if not exists ${pdm_risk}.pdm_risk_dz_model_final_order_info_df(
-- uid  string  comment '客户号',
-- mdl_dte  string  comment '模型评分日',
-- d7_apl_ord_cnt bigint comment '近7天_发起订单数',
-- d7_apl_ord_prc_amt_sum decimal(38,18) comment '近7天_发起订单的借款本金_总和',
-- d7_apl_ord_prc_amt_max decimal(38,18) comment '近7天_发起订单的借款本金_最大',
-- d7_apl_ord_prc_amt_min decimal(38,18) comment '近7天_发起订单的借款本金_最小',
-- d7_apl_ord_prc_amt_avg decimal(38,18) comment '近7天_发起订单的借款本金_平均',
-- d7_apl_ord_prc_amt_per_stg_sum decimal(38,18) comment '近7天_发起订单的单期平均借款本金_总和',
-- d7_apl_ord_prc_amt_per_stg_max decimal(38,18) comment '近7天_发起订单的单期平均借款本金_最大',
-- d7_apl_ord_prc_amt_per_stg_min decimal(38,18) comment '近7天_发起订单的单期平均借款本金_最小',
-- d7_apl_ord_prc_amt_per_stg_avg decimal(38,18) comment '近7天_发起订单的单期平均借款本金_平均',
-- d7_apl_ord_days_cnt bigint comment '近7天_订单发起天数(去重)',
-- d7_apl_ord_ddf_mdl_ord_crt_dte_max int comment '近7天_发起订单距评分日的时间间隔_最大',
-- d7_apl_ord_ddf_mdl_ord_crt_dte_min int comment '近7天_发起订单距评分日的时间间隔_最小',
-- d7_apl_ord_stg_num_sum bigint comment '近7天_发起订单的分期计划数_总和',
-- d7_apl_ord_stg_num_max bigint comment '近7天_发起订单的分期计划数_最大',
-- d7_apl_ord_stg_num_min bigint comment '近7天_发起订单的分期计划数_最小',
-- d7_apl_ord_stg_num_avg double comment '近7天_发起订单的分期计划数_平均',
-- d7_prc_amt_mor_3_000_apl_ord_cnt bigint comment '近7_借款本金大于等于3k的发起订单数',
-- d7_prc_amt_mor_5_000_apl_ord_cnt bigint comment '近7_借款本金大于等于5k的发起订单数',
-- d7_prc_amt_mor_10_000_apl_ord_cnt bigint comment '近7_借款本金大于等于1w的发起订单数',
-- d7_prc_amt_mor_20_000_apl_ord_cnt bigint comment '近7_借款本金大于等于2w的发起订单数',
-- d7_prc_amt_mor_50_000_apl_ord_cnt bigint comment '近7_借款本金大于等于5w的发起订单数',
-- d15_apl_ord_cnt bigint comment '近15天_发起订单数',
-- d15_apl_ord_prc_amt_sum decimal(38,18) comment '近15天_发起订单的借款本金_总和',
-- d15_apl_ord_prc_amt_max decimal(38,18) comment '近15天_发起订单的借款本金_最大',
-- d15_apl_ord_prc_amt_min decimal(38,18) comment '近15天_发起订单的借款本金_最小',
-- d15_apl_ord_prc_amt_avg decimal(38,18) comment '近15天_发起订单的借款本金_平均',
-- d15_apl_ord_prc_amt_per_stg_sum decimal(38,18) comment '近15天_发起订单的单期平均借款本金_总和',
-- d15_apl_ord_prc_amt_per_stg_max decimal(38,18) comment '近15天_发起订单的单期平均借款本金_最大',
-- d15_apl_ord_prc_amt_per_stg_min decimal(38,18) comment '近15天_发起订单的单期平均借款本金_最小',
-- d15_apl_ord_prc_amt_per_stg_avg decimal(38,18) comment '近15天_发起订单的单期平均借款本金_平均',
-- d15_apl_ord_days_cnt bigint comment '近15天_订单发起天数(去重)',
-- d15_apl_ord_ddf_mdl_ord_crt_dte_max int comment '近15天_发起订单距评分日的时间间隔_最大',
-- d15_apl_ord_ddf_mdl_ord_crt_dte_min int comment '近15天_发起订单距评分日的时间间隔_最小',
-- d15_apl_ord_stg_num_sum bigint comment '近15天_发起订单的分期计划数_总和',
-- d15_apl_ord_stg_num_max bigint comment '近15天_发起订单的分期计划数_最大',
-- d15_apl_ord_stg_num_min bigint comment '近15天_发起订单的分期计划数_最小',
-- d15_apl_ord_stg_num_avg double comment '近15天_发起订单的分期计划数_平均',
-- d15_prc_amt_mor_3_000_apl_ord_cnt bigint comment '近15_借款本金大于等于3k的发起订单数',
-- d15_prc_amt_mor_5_000_apl_ord_cnt bigint comment '近15_借款本金大于等于5k的发起订单数',
-- d15_prc_amt_mor_10_000_apl_ord_cnt bigint comment '近15_借款本金大于等于1w的发起订单数',
-- d15_prc_amt_mor_20_000_apl_ord_cnt bigint comment '近15_借款本金大于等于2w的发起订单数',
-- d15_prc_amt_mor_50_000_apl_ord_cnt bigint comment '近15_借款本金大于等于5w的发起订单数',
-- d30_apl_ord_cnt bigint comment '近30天_发起订单数',
-- d30_apl_ord_prc_amt_sum decimal(38,18) comment '近30天_发起订单的借款本金_总和',
-- d30_apl_ord_prc_amt_max decimal(38,18) comment '近30天_发起订单的借款本金_最大',
-- d30_apl_ord_prc_amt_min decimal(38,18) comment '近30天_发起订单的借款本金_最小',
-- d30_apl_ord_prc_amt_avg decimal(38,18) comment '近30天_发起订单的借款本金_平均',
-- d30_apl_ord_prc_amt_per_stg_sum decimal(38,18) comment '近30天_发起订单的单期平均借款本金_总和',
-- d30_apl_ord_prc_amt_per_stg_max decimal(38,18) comment '近30天_发起订单的单期平均借款本金_最大',
-- d30_apl_ord_prc_amt_per_stg_min decimal(38,18) comment '近30天_发起订单的单期平均借款本金_最小',
-- d30_apl_ord_prc_amt_per_stg_avg decimal(38,18) comment '近30天_发起订单的单期平均借款本金_平均',
-- d30_apl_ord_days_cnt bigint comment '近30天_订单发起天数(去重)',
-- d30_apl_ord_ddf_mdl_ord_crt_dte_max int comment '近30天_发起订单距评分日的时间间隔_最大',
-- d30_apl_ord_ddf_mdl_ord_crt_dte_min int comment '近30天_发起订单距评分日的时间间隔_最小',
-- d30_apl_ord_stg_num_sum bigint comment '近30天_发起订单的分期计划数_总和',
-- d30_apl_ord_stg_num_max bigint comment '近30天_发起订单的分期计划数_最大',
-- d30_apl_ord_stg_num_min bigint comment '近30天_发起订单的分期计划数_最小',
-- d30_apl_ord_stg_num_avg double comment '近30天_发起订单的分期计划数_平均',
-- d30_prc_amt_mor_3_000_apl_ord_cnt bigint comment '近30_借款本金大于等于3k的发起订单数',
-- d30_prc_amt_mor_5_000_apl_ord_cnt bigint comment '近30_借款本金大于等于5k的发起订单数',
-- d30_prc_amt_mor_10_000_apl_ord_cnt bigint comment '近30_借款本金大于等于1w的发起订单数',
-- d30_prc_amt_mor_20_000_apl_ord_cnt bigint comment '近30_借款本金大于等于2w的发起订单数',
-- d30_prc_amt_mor_50_000_apl_ord_cnt bigint comment '近30_借款本金大于等于5w的发起订单数',
-- d60_apl_ord_cnt bigint comment '近60天_发起订单数',
-- d60_apl_ord_prc_amt_sum decimal(38,18) comment '近60天_发起订单的借款本金_总和',
-- d60_apl_ord_prc_amt_max decimal(38,18) comment '近60天_发起订单的借款本金_最大',
-- d60_apl_ord_prc_amt_min decimal(38,18) comment '近60天_发起订单的借款本金_最小',
-- d60_apl_ord_prc_amt_avg decimal(38,18) comment '近60天_发起订单的借款本金_平均',
-- d60_apl_ord_prc_amt_per_stg_sum decimal(38,18) comment '近60天_发起订单的单期平均借款本金_总和',
-- d60_apl_ord_prc_amt_per_stg_max decimal(38,18) comment '近60天_发起订单的单期平均借款本金_最大',
-- d60_apl_ord_prc_amt_per_stg_min decimal(38,18) comment '近60天_发起订单的单期平均借款本金_最小',
-- d60_apl_ord_prc_amt_per_stg_avg decimal(38,18) comment '近60天_发起订单的单期平均借款本金_平均',
-- d60_apl_ord_days_cnt bigint comment '近60天_订单发起天数(去重)',
-- d60_apl_ord_ddf_mdl_ord_crt_dte_max int comment '近60天_发起订单距评分日的时间间隔_最大',
-- d60_apl_ord_ddf_mdl_ord_crt_dte_min int comment '近60天_发起订单距评分日的时间间隔_最小',
-- d60_apl_ord_stg_num_sum bigint comment '近60天_发起订单的分期计划数_总和',
-- d60_apl_ord_stg_num_max bigint comment '近60天_发起订单的分期计划数_最大',
-- d60_apl_ord_stg_num_min bigint comment '近60天_发起订单的分期计划数_最小',
-- d60_apl_ord_stg_num_avg double comment '近60天_发起订单的分期计划数_平均',
-- d60_prc_amt_mor_3_000_apl_ord_cnt bigint comment '近60_借款本金大于等于3k的发起订单数',
-- d60_prc_amt_mor_5_000_apl_ord_cnt bigint comment '近60_借款本金大于等于5k的发起订单数',
-- d60_prc_amt_mor_10_000_apl_ord_cnt bigint comment '近60_借款本金大于等于1w的发起订单数',
-- d60_prc_amt_mor_20_000_apl_ord_cnt bigint comment '近60_借款本金大于等于2w的发起订单数',
-- d60_prc_amt_mor_50_000_apl_ord_cnt bigint comment '近60_借款本金大于等于5w的发起订单数',
-- d90_apl_ord_cnt bigint comment '近90天_发起订单数',
-- d90_apl_ord_prc_amt_sum decimal(38,18) comment '近90天_发起订单的借款本金_总和',
-- d90_apl_ord_prc_amt_max decimal(38,18) comment '近90天_发起订单的借款本金_最大',
-- d90_apl_ord_prc_amt_min decimal(38,18) comment '近90天_发起订单的借款本金_最小',
-- d90_apl_ord_prc_amt_avg decimal(38,18) comment '近90天_发起订单的借款本金_平均',
-- d90_apl_ord_prc_amt_per_stg_sum decimal(38,18) comment '近90天_发起订单的单期平均借款本金_总和',
-- d90_apl_ord_prc_amt_per_stg_max decimal(38,18) comment '近90天_发起订单的单期平均借款本金_最大',
-- d90_apl_ord_prc_amt_per_stg_min decimal(38,18) comment '近90天_发起订单的单期平均借款本金_最小',
-- d90_apl_ord_prc_amt_per_stg_avg decimal(38,18) comment '近90天_发起订单的单期平均借款本金_平均',
-- d90_apl_ord_days_cnt bigint comment '近90天_订单发起天数(去重)',
-- d90_apl_ord_ddf_mdl_ord_crt_dte_max int comment '近90天_发起订单距评分日的时间间隔_最大',
-- d90_apl_ord_ddf_mdl_ord_crt_dte_min int comment '近90天_发起订单距评分日的时间间隔_最小',
-- d90_apl_ord_stg_num_sum bigint comment '近90天_发起订单的分期计划数_总和',
-- d90_apl_ord_stg_num_max bigint comment '近90天_发起订单的分期计划数_最大',
-- d90_apl_ord_stg_num_min bigint comment '近90天_发起订单的分期计划数_最小',
-- d90_apl_ord_stg_num_avg double comment '近90天_发起订单的分期计划数_平均',
-- d90_prc_amt_mor_3_000_apl_ord_cnt bigint comment '近90_借款本金大于等于3k的发起订单数',
-- d90_prc_amt_mor_5_000_apl_ord_cnt bigint comment '近90_借款本金大于等于5k的发起订单数',
-- d90_prc_amt_mor_10_000_apl_ord_cnt bigint comment '近90_借款本金大于等于1w的发起订单数',
-- d90_prc_amt_mor_20_000_apl_ord_cnt bigint comment '近90_借款本金大于等于2w的发起订单数',
-- d90_prc_amt_mor_50_000_apl_ord_cnt bigint comment '近90_借款本金大于等于5w的发起订单数',
-- d180_apl_ord_cnt bigint comment '近180天_发起订单数',
-- d180_apl_ord_prc_amt_sum decimal(38,18) comment '近180天_发起订单的借款本金_总和',
-- d180_apl_ord_prc_amt_max decimal(38,18) comment '近180天_发起订单的借款本金_最大',
-- d180_apl_ord_prc_amt_min decimal(38,18) comment '近180天_发起订单的借款本金_最小',
-- d180_apl_ord_prc_amt_avg decimal(38,18) comment '近180天_发起订单的借款本金_平均',
-- d180_apl_ord_prc_amt_per_stg_sum decimal(38,18) comment '近180天_发起订单的单期平均借款本金_总和',
-- d180_apl_ord_prc_amt_per_stg_max decimal(38,18) comment '近180天_发起订单的单期平均借款本金_最大',
-- d180_apl_ord_prc_amt_per_stg_min decimal(38,18) comment '近180天_发起订单的单期平均借款本金_最小',
-- d180_apl_ord_prc_amt_per_stg_avg decimal(38,18) comment '近180天_发起订单的单期平均借款本金_平均',
-- d180_apl_ord_days_cnt bigint comment '近180天_订单发起天数(去重)',
-- d180_apl_ord_ddf_mdl_ord_crt_dte_max int comment '近180天_发起订单距评分日的时间间隔_最大',
-- d180_apl_ord_ddf_mdl_ord_crt_dte_min int comment '近180天_发起订单距评分日的时间间隔_最小',
-- d180_apl_ord_stg_num_sum bigint comment '近180天_发起订单的分期计划数_总和',
-- d180_apl_ord_stg_num_max bigint comment '近180天_发起订单的分期计划数_最大',
-- d180_apl_ord_stg_num_min bigint comment '近180天_发起订单的分期计划数_最小',
-- d180_apl_ord_stg_num_avg double comment '近180天_发起订单的分期计划数_平均',
-- d180_prc_amt_mor_3_000_apl_ord_cnt bigint comment '近180_借款本金大于等于3k的发起订单数',
-- d180_prc_amt_mor_5_000_apl_ord_cnt bigint comment '近180_借款本金大于等于5k的发起订单数',
-- d180_prc_amt_mor_10_000_apl_ord_cnt bigint comment '近180_借款本金大于等于1w的发起订单数',
-- d180_prc_amt_mor_20_000_apl_ord_cnt bigint comment '近180_借款本金大于等于2w的发起订单数',
-- d180_prc_amt_mor_50_000_apl_ord_cnt bigint comment '近180_借款本金大于等于5w的发起订单数',
-- d360_apl_ord_cnt bigint comment '近360天_发起订单数',
-- d360_apl_ord_prc_amt_sum decimal(38,18) comment '近360天_发起订单的借款本金_总和',
-- d360_apl_ord_prc_amt_max decimal(38,18) comment '近360天_发起订单的借款本金_最大',
-- d360_apl_ord_prc_amt_min decimal(38,18) comment '近360天_发起订单的借款本金_最小',
-- d360_apl_ord_prc_amt_avg decimal(38,18) comment '近360天_发起订单的借款本金_平均',
-- d360_apl_ord_prc_amt_per_stg_sum decimal(38,18) comment '近360天_发起订单的单期平均借款本金_总和',
-- d360_apl_ord_prc_amt_per_stg_max decimal(38,18) comment '近360天_发起订单的单期平均借款本金_最大',
-- d360_apl_ord_prc_amt_per_stg_min decimal(38,18) comment '近360天_发起订单的单期平均借款本金_最小',
-- d360_apl_ord_prc_amt_per_stg_avg decimal(38,18) comment '近360天_发起订单的单期平均借款本金_平均',
-- d360_apl_ord_days_cnt bigint comment '近360天_订单发起天数(去重)',
-- d360_apl_ord_ddf_mdl_ord_crt_dte_max int comment '近360天_发起订单距评分日的时间间隔_最大',
-- d360_apl_ord_ddf_mdl_ord_crt_dte_min int comment '近360天_发起订单距评分日的时间间隔_最小',
-- d360_apl_ord_stg_num_sum bigint comment '近360天_发起订单的分期计划数_总和',
-- d360_apl_ord_stg_num_max bigint comment '近360天_发起订单的分期计划数_最大',
-- d360_apl_ord_stg_num_min bigint comment '近360天_发起订单的分期计划数_最小',
-- d360_apl_ord_stg_num_avg double comment '近360天_发起订单的分期计划数_平均',
-- d360_prc_amt_mor_3_000_apl_ord_cnt bigint comment '近360_借款本金大于等于3k的发起订单数',
-- d360_prc_amt_mor_5_000_apl_ord_cnt bigint comment '近360_借款本金大于等于5k的发起订单数',
-- d360_prc_amt_mor_10_000_apl_ord_cnt bigint comment '近360_借款本金大于等于1w的发起订单数',
-- d360_prc_amt_mor_20_000_apl_ord_cnt bigint comment '近360_借款本金大于等于2w的发起订单数',
-- d360_prc_amt_mor_50_000_apl_ord_cnt bigint comment '近360_借款本金大于等于5w的发起订单数',
-- d7_suc_ord_cnt bigint comment '近7天_成功订单数',
-- d7_suc_ord_prc_amt_sum decimal(38,18) comment '近7天_成功订单的借款本金_总和',
-- d7_suc_ord_prc_amt_max decimal(38,18) comment '近7天_成功订单的借款本金_最大',
-- d7_suc_ord_prc_amt_min decimal(38,18) comment '近7天_成功订单的借款本金_最小',
-- d7_suc_ord_prc_amt_avg decimal(38,18) comment '近7天_成功订单的借款本金_平均',
-- d7_suc_ord_prc_amt_per_stg_sum decimal(38,18) comment '近7天_成功订单的单期平均借款本金_总和',
-- d7_suc_ord_prc_amt_per_stg_max decimal(38,18) comment '近7天_成功订单的单期平均借款本金_最大',
-- d7_suc_ord_prc_amt_per_stg_min decimal(38,18) comment '近7天_成功订单的单期平均借款本金_最小',
-- d7_suc_ord_prc_amt_per_stg_avg decimal(38,18) comment '近7天_成功订单的单期平均借款本金_平均',
-- d7_suc_ord_days_cnt bigint comment '近7天_成功交易天数(去重)',
-- d7_suc_ord_ddf_mdl_ord_crt_dte_max int comment '近7天_成功订单距评分日的时间间隔_最大',
-- d7_suc_ord_ddf_mdl_ord_crt_dte_min int comment '近7天_成功订单距评分日的时间间隔_最小',
-- d7_suc_ord_stg_num_sum bigint comment '近7天_成功订单的分期计划数_总和',
-- d7_suc_ord_stg_num_max bigint comment '近7天_成功订单的分期计划数_最大',
-- d7_suc_ord_stg_num_min bigint comment '近7天_成功订单的分期计划数_最小',
-- d7_suc_ord_stg_num_avg double comment '近7天_成功订单的分期计划数_平均',
-- d7_prc_amt_mor_3_000_suc_ord_cnt bigint comment '近7_借款本金大于等于3k的成功订单数',
-- d7_prc_amt_mor_5_000_suc_ord_cnt bigint comment '近7_借款本金大于等于5k的成功订单数',
-- d7_prc_amt_mor_10_000_suc_ord_cnt bigint comment '近7_借款本金大于等于1w的成功订单数',
-- d7_prc_amt_mor_20_000_suc_ord_cnt bigint comment '近7_借款本金大于等于2w的成功订单数',
-- d7_prc_amt_mor_50_000_suc_ord_cnt bigint comment '近7_借款本金大于等于5w的成功订单数',
-- d15_suc_ord_cnt bigint comment '近15天_成功订单数',
-- d15_suc_ord_prc_amt_sum decimal(38,18) comment '近15天_成功订单的借款本金_总和',
-- d15_suc_ord_prc_amt_max decimal(38,18) comment '近15天_成功订单的借款本金_最大',
-- d15_suc_ord_prc_amt_min decimal(38,18) comment '近15天_成功订单的借款本金_最小',
-- d15_suc_ord_prc_amt_avg decimal(38,18) comment '近15天_成功订单的借款本金_平均',
-- d15_suc_ord_prc_amt_per_stg_sum decimal(38,18) comment '近15天_成功订单的单期平均借款本金_总和',
-- d15_suc_ord_prc_amt_per_stg_max decimal(38,18) comment '近15天_成功订单的单期平均借款本金_最大',
-- d15_suc_ord_prc_amt_per_stg_min decimal(38,18) comment '近15天_成功订单的单期平均借款本金_最小',
-- d15_suc_ord_prc_amt_per_stg_avg decimal(38,18) comment '近15天_成功订单的单期平均借款本金_平均',
-- d15_suc_ord_days_cnt bigint comment '近15天_成功交易天数(去重)',
-- d15_suc_ord_ddf_mdl_ord_crt_dte_max int comment '近15天_成功订单距评分日的时间间隔_最大',
-- d15_suc_ord_ddf_mdl_ord_crt_dte_min int comment '近15天_成功订单距评分日的时间间隔_最小',
-- d15_suc_ord_stg_num_sum bigint comment '近15天_成功订单的分期计划数_总和',
-- d15_suc_ord_stg_num_max bigint comment '近15天_成功订单的分期计划数_最大',
-- d15_suc_ord_stg_num_min bigint comment '近15天_成功订单的分期计划数_最小',
-- d15_suc_ord_stg_num_avg double comment '近15天_成功订单的分期计划数_平均',
-- d15_prc_amt_mor_3_000_suc_ord_cnt bigint comment '近15_借款本金大于等于3k的成功订单数',
-- d15_prc_amt_mor_5_000_suc_ord_cnt bigint comment '近15_借款本金大于等于5k的成功订单数',
-- d15_prc_amt_mor_10_000_suc_ord_cnt bigint comment '近15_借款本金大于等于1w的成功订单数',
-- d15_prc_amt_mor_20_000_suc_ord_cnt bigint comment '近15_借款本金大于等于2w的成功订单数',
-- d15_prc_amt_mor_50_000_suc_ord_cnt bigint comment '近15_借款本金大于等于5w的成功订单数',
-- d30_suc_ord_cnt bigint comment '近30天_成功订单数',
-- d30_suc_ord_prc_amt_sum decimal(38,18) comment '近30天_成功订单的借款本金_总和',
-- d30_suc_ord_prc_amt_max decimal(38,18) comment '近30天_成功订单的借款本金_最大',
-- d30_suc_ord_prc_amt_min decimal(38,18) comment '近30天_成功订单的借款本金_最小',
-- d30_suc_ord_prc_amt_avg decimal(38,18) comment '近30天_成功订单的借款本金_平均',
-- d30_suc_ord_prc_amt_per_stg_sum decimal(38,18) comment '近30天_成功订单的单期平均借款本金_总和',
-- d30_suc_ord_prc_amt_per_stg_max decimal(38,18) comment '近30天_成功订单的单期平均借款本金_最大',
-- d30_suc_ord_prc_amt_per_stg_min decimal(38,18) comment '近30天_成功订单的单期平均借款本金_最小',
-- d30_suc_ord_prc_amt_per_stg_avg decimal(38,18) comment '近30天_成功订单的单期平均借款本金_平均',
-- d30_suc_ord_days_cnt bigint comment '近30天_成功交易天数(去重)',
-- d30_suc_ord_ddf_mdl_ord_crt_dte_max int comment '近30天_成功订单距评分日的时间间隔_最大',
-- d30_suc_ord_ddf_mdl_ord_crt_dte_min int comment '近30天_成功订单距评分日的时间间隔_最小',
-- d30_suc_ord_stg_num_sum bigint comment '近30天_成功订单的分期计划数_总和',
-- d30_suc_ord_stg_num_max bigint comment '近30天_成功订单的分期计划数_最大',
-- d30_suc_ord_stg_num_min bigint comment '近30天_成功订单的分期计划数_最小',
-- d30_suc_ord_stg_num_avg double comment '近30天_成功订单的分期计划数_平均',
-- d30_prc_amt_mor_3_000_suc_ord_cnt bigint comment '近30_借款本金大于等于3k的成功订单数',
-- d30_prc_amt_mor_5_000_suc_ord_cnt bigint comment '近30_借款本金大于等于5k的成功订单数',
-- d30_prc_amt_mor_10_000_suc_ord_cnt bigint comment '近30_借款本金大于等于1w的成功订单数',
-- d30_prc_amt_mor_20_000_suc_ord_cnt bigint comment '近30_借款本金大于等于2w的成功订单数',
-- d30_prc_amt_mor_50_000_suc_ord_cnt bigint comment '近30_借款本金大于等于5w的成功订单数',
-- d60_suc_ord_cnt bigint comment '近60天_成功订单数',
-- d60_suc_ord_prc_amt_sum decimal(38,18) comment '近60天_成功订单的借款本金_总和',
-- d60_suc_ord_prc_amt_max decimal(38,18) comment '近60天_成功订单的借款本金_最大',
-- d60_suc_ord_prc_amt_min decimal(38,18) comment '近60天_成功订单的借款本金_最小',
-- d60_suc_ord_prc_amt_avg decimal(38,18) comment '近60天_成功订单的借款本金_平均',
-- d60_suc_ord_prc_amt_per_stg_sum decimal(38,18) comment '近60天_成功订单的单期平均借款本金_总和',
-- d60_suc_ord_prc_amt_per_stg_max decimal(38,18) comment '近60天_成功订单的单期平均借款本金_最大',
-- d60_suc_ord_prc_amt_per_stg_min decimal(38,18) comment '近60天_成功订单的单期平均借款本金_最小',
-- d60_suc_ord_prc_amt_per_stg_avg decimal(38,18) comment '近60天_成功订单的单期平均借款本金_平均',
-- d60_suc_ord_days_cnt bigint comment '近60天_成功交易天数(去重)',
-- d60_suc_ord_ddf_mdl_ord_crt_dte_max int comment '近60天_成功订单距评分日的时间间隔_最大',
-- d60_suc_ord_ddf_mdl_ord_crt_dte_min int comment '近60天_成功订单距评分日的时间间隔_最小',
-- d60_suc_ord_stg_num_sum bigint comment '近60天_成功订单的分期计划数_总和',
-- d60_suc_ord_stg_num_max bigint comment '近60天_成功订单的分期计划数_最大',
-- d60_suc_ord_stg_num_min bigint comment '近60天_成功订单的分期计划数_最小',
-- d60_suc_ord_stg_num_avg double comment '近60天_成功订单的分期计划数_平均',
-- d60_prc_amt_mor_3_000_suc_ord_cnt bigint comment '近60_借款本金大于等于3k的成功订单数',
-- d60_prc_amt_mor_5_000_suc_ord_cnt bigint comment '近60_借款本金大于等于5k的成功订单数',
-- d60_prc_amt_mor_10_000_suc_ord_cnt bigint comment '近60_借款本金大于等于1w的成功订单数',
-- d60_prc_amt_mor_20_000_suc_ord_cnt bigint comment '近60_借款本金大于等于2w的成功订单数',
-- d60_prc_amt_mor_50_000_suc_ord_cnt bigint comment '近60_借款本金大于等于5w的成功订单数',
-- d90_suc_ord_cnt bigint comment '近90天_成功订单数',
-- d90_suc_ord_prc_amt_sum decimal(38,18) comment '近90天_成功订单的借款本金_总和',
-- d90_suc_ord_prc_amt_max decimal(38,18) comment '近90天_成功订单的借款本金_最大',
-- d90_suc_ord_prc_amt_min decimal(38,18) comment '近90天_成功订单的借款本金_最小',
-- d90_suc_ord_prc_amt_avg decimal(38,18) comment '近90天_成功订单的借款本金_平均',
-- d90_suc_ord_prc_amt_per_stg_sum decimal(38,18) comment '近90天_成功订单的单期平均借款本金_总和',
-- d90_suc_ord_prc_amt_per_stg_max decimal(38,18) comment '近90天_成功订单的单期平均借款本金_最大',
-- d90_suc_ord_prc_amt_per_stg_min decimal(38,18) comment '近90天_成功订单的单期平均借款本金_最小',
-- d90_suc_ord_prc_amt_per_stg_avg decimal(38,18) comment '近90天_成功订单的单期平均借款本金_平均',
-- d90_suc_ord_days_cnt bigint comment '近90天_成功交易天数(去重)',
-- d90_suc_ord_ddf_mdl_ord_crt_dte_max int comment '近90天_成功订单距评分日的时间间隔_最大',
-- d90_suc_ord_ddf_mdl_ord_crt_dte_min int comment '近90天_成功订单距评分日的时间间隔_最小',
-- d90_suc_ord_stg_num_sum bigint comment '近90天_成功订单的分期计划数_总和',
-- d90_suc_ord_stg_num_max bigint comment '近90天_成功订单的分期计划数_最大',
-- d90_suc_ord_stg_num_min bigint comment '近90天_成功订单的分期计划数_最小',
-- d90_suc_ord_stg_num_avg double comment '近90天_成功订单的分期计划数_平均',
-- d90_prc_amt_mor_3_000_suc_ord_cnt bigint comment '近90_借款本金大于等于3k的成功订单数',
-- d90_prc_amt_mor_5_000_suc_ord_cnt bigint comment '近90_借款本金大于等于5k的成功订单数',
-- d90_prc_amt_mor_10_000_suc_ord_cnt bigint comment '近90_借款本金大于等于1w的成功订单数',
-- d90_prc_amt_mor_20_000_suc_ord_cnt bigint comment '近90_借款本金大于等于2w的成功订单数',
-- d90_prc_amt_mor_50_000_suc_ord_cnt bigint comment '近90_借款本金大于等于5w的成功订单数',
-- d180_suc_ord_cnt bigint comment '近180天_成功订单数',
-- d180_suc_ord_prc_amt_sum decimal(38,18) comment '近180天_成功订单的借款本金_总和',
-- d180_suc_ord_prc_amt_max decimal(38,18) comment '近180天_成功订单的借款本金_最大',
-- d180_suc_ord_prc_amt_min decimal(38,18) comment '近180天_成功订单的借款本金_最小',
-- d180_suc_ord_prc_amt_avg decimal(38,18) comment '近180天_成功订单的借款本金_平均',
-- d180_suc_ord_prc_amt_per_stg_sum decimal(38,18) comment '近180天_成功订单的单期平均借款本金_总和',
-- d180_suc_ord_prc_amt_per_stg_max decimal(38,18) comment '近180天_成功订单的单期平均借款本金_最大',
-- d180_suc_ord_prc_amt_per_stg_min decimal(38,18) comment '近180天_成功订单的单期平均借款本金_最小',
-- d180_suc_ord_prc_amt_per_stg_avg decimal(38,18) comment '近180天_成功订单的单期平均借款本金_平均',
-- d180_suc_ord_days_cnt bigint comment '近180天_成功交易天数(去重)',
-- d180_suc_ord_ddf_mdl_ord_crt_dte_max int comment '近180天_成功订单距评分日的时间间隔_最大',
-- d180_suc_ord_ddf_mdl_ord_crt_dte_min int comment '近180天_成功订单距评分日的时间间隔_最小',
-- d180_suc_ord_stg_num_sum bigint comment '近180天_成功订单的分期计划数_总和',
-- d180_suc_ord_stg_num_max bigint comment '近180天_成功订单的分期计划数_最大',
-- d180_suc_ord_stg_num_min bigint comment '近180天_成功订单的分期计划数_最小',
-- d180_suc_ord_stg_num_avg double comment '近180天_成功订单的分期计划数_平均',
-- d180_prc_amt_mor_3_000_suc_ord_cnt bigint comment '近180_借款本金大于等于3k的成功订单数',
-- d180_prc_amt_mor_5_000_suc_ord_cnt bigint comment '近180_借款本金大于等于5k的成功订单数',
-- d180_prc_amt_mor_10_000_suc_ord_cnt bigint comment '近180_借款本金大于等于1w的成功订单数',
-- d180_prc_amt_mor_20_000_suc_ord_cnt bigint comment '近180_借款本金大于等于2w的成功订单数',
-- d180_prc_amt_mor_50_000_suc_ord_cnt bigint comment '近180_借款本金大于等于5w的成功订单数',
-- d360_suc_ord_cnt bigint comment '近360天_成功订单数',
-- d360_suc_ord_prc_amt_sum decimal(38,18) comment '近360天_成功订单的借款本金_总和',
-- d360_suc_ord_prc_amt_max decimal(38,18) comment '近360天_成功订单的借款本金_最大',
-- d360_suc_ord_prc_amt_min decimal(38,18) comment '近360天_成功订单的借款本金_最小',
-- d360_suc_ord_prc_amt_avg decimal(38,18) comment '近360天_成功订单的借款本金_平均',
-- d360_suc_ord_prc_amt_per_stg_sum decimal(38,18) comment '近360天_成功订单的单期平均借款本金_总和',
-- d360_suc_ord_prc_amt_per_stg_max decimal(38,18) comment '近360天_成功订单的单期平均借款本金_最大',
-- d360_suc_ord_prc_amt_per_stg_min decimal(38,18) comment '近360天_成功订单的单期平均借款本金_最小',
-- d360_suc_ord_prc_amt_per_stg_avg decimal(38,18) comment '近360天_成功订单的单期平均借款本金_平均',
-- d360_suc_ord_days_cnt bigint comment '近360天_成功交易天数(去重)',
-- d360_suc_ord_ddf_mdl_ord_crt_dte_max int comment '近360天_成功订单距评分日的时间间隔_最大',
-- d360_suc_ord_ddf_mdl_ord_crt_dte_min int comment '近360天_成功订单距评分日的时间间隔_最小',
-- d360_suc_ord_stg_num_sum bigint comment '近360天_成功订单的分期计划数_总和',
-- d360_suc_ord_stg_num_max bigint comment '近360天_成功订单的分期计划数_最大',
-- d360_suc_ord_stg_num_min bigint comment '近360天_成功订单的分期计划数_最小',
-- d360_suc_ord_stg_num_avg double comment '近360天_成功订单的分期计划数_平均',
-- d360_prc_amt_mor_3_000_suc_ord_cnt bigint comment '近360_借款本金大于等于3k的成功订单数',
-- d360_prc_amt_mor_5_000_suc_ord_cnt bigint comment '近360_借款本金大于等于5k的成功订单数',
-- d360_prc_amt_mor_10_000_suc_ord_cnt bigint comment '近360_借款本金大于等于1w的成功订单数',
-- d360_prc_amt_mor_20_000_suc_ord_cnt bigint comment '近360_借款本金大于等于2w的成功订单数',
-- d360_prc_amt_mor_50_000_suc_ord_cnt bigint comment '近360_借款本金大于等于5w的成功订单数',
-- d7_d15_apl_ord_cnt_rat double comment '近7天/近15天_发起订单数_的比例',
-- d7_d30_apl_ord_cnt_rat double comment '近7天/近30天_发起订单数_的比例',
-- d7_d60_apl_ord_cnt_rat double comment '近7天/近60天_发起订单数_的比例',
-- d7_d90_apl_ord_cnt_rat double comment '近7天/近90天_发起订单数_的比例',
-- d7_d180_apl_ord_cnt_rat double comment '近7天/近180天_发起订单数_的比例',
-- d7_d360_apl_ord_cnt_rat double comment '近7天/近360天_发起订单数_的比例',
-- d15_d30_apl_ord_cnt_rat double comment '近15天/近30天_发起订单数_的比例',
-- d15_d60_apl_ord_cnt_rat double comment '近15天/近60天_发起订单数_的比例',
-- d15_d90_apl_ord_cnt_rat double comment '近15天/近90天_发起订单数_的比例',
-- d15_d180_apl_ord_cnt_rat double comment '近15天/近180天_发起订单数_的比例',
-- d15_d360_apl_ord_cnt_rat double comment '近15天/近360天_发起订单数_的比例',
-- d30_d60_apl_ord_cnt_rat double comment '近30天/近60天_发起订单数_的比例',
-- d30_d90_apl_ord_cnt_rat double comment '近30天/近90天_发起订单数_的比例',
-- d30_d180_apl_ord_cnt_rat double comment '近30天/近180天_发起订单数_的比例',
-- d30_d360_apl_ord_cnt_rat double comment '近30天/近360天_发起订单数_的比例',
-- d60_d90_apl_ord_cnt_rat double comment '近60天/近90天_发起订单数_的比例',
-- d60_d180_apl_ord_cnt_rat double comment '近60天/近180天_发起订单数_的比例',
-- d60_d360_apl_ord_cnt_rat double comment '近60天/近360天_发起订单数_的比例',
-- d90_d180_apl_ord_cnt_rat double comment '近90天/近180天_发起订单数_的比例',
-- d90_d360_apl_ord_cnt_rat double comment '近90天/近360天_发起订单数_的比例',
-- d180_d360_apl_ord_cnt_rat double comment '近180天/近360天_发起订单数_的比例',
-- d7_d15_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近15天_发起订单的借款本金_平均_的比例',
-- d7_d30_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近30天_发起订单的借款本金_平均_的比例',
-- d7_d60_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近60天_发起订单的借款本金_平均_的比例',
-- d7_d90_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近90天_发起订单的借款本金_平均_的比例',
-- d7_d180_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近180天_发起订单的借款本金_平均_的比例',
-- d7_d360_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近360天_发起订单的借款本金_平均_的比例',
-- d15_d30_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近30天_发起订单的借款本金_平均_的比例',
-- d15_d60_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近60天_发起订单的借款本金_平均_的比例',
-- d15_d90_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近90天_发起订单的借款本金_平均_的比例',
-- d15_d180_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近180天_发起订单的借款本金_平均_的比例',
-- d15_d360_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近360天_发起订单的借款本金_平均_的比例',
-- d30_d60_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近60天_发起订单的借款本金_平均_的比例',
-- d30_d90_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近90天_发起订单的借款本金_平均_的比例',
-- d30_d180_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近180天_发起订单的借款本金_平均_的比例',
-- d30_d360_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近360天_发起订单的借款本金_平均_的比例',
-- d60_d90_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近60天/近90天_发起订单的借款本金_平均_的比例',
-- d60_d180_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近60天/近180天_发起订单的借款本金_平均_的比例',
-- d60_d360_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近60天/近360天_发起订单的借款本金_平均_的比例',
-- d90_d180_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近90天/近180天_发起订单的借款本金_平均_的比例',
-- d90_d360_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近90天/近360天_发起订单的借款本金_平均_的比例',
-- d180_d360_apl_ord_prc_amt_avg_rat decimal(38,18) comment '近180天/近360天_发起订单的借款本金_平均_的比例',
-- d7_d15_suc_ord_cnt_rat double comment '近7天/近15天_成功订单数_的比例',
-- d7_d30_suc_ord_cnt_rat double comment '近7天/近30天_成功订单数_的比例',
-- d7_d60_suc_ord_cnt_rat double comment '近7天/近60天_成功订单数_的比例',
-- d7_d90_suc_ord_cnt_rat double comment '近7天/近90天_成功订单数_的比例',
-- d7_d180_suc_ord_cnt_rat double comment '近7天/近180天_成功订单数_的比例',
-- d7_d360_suc_ord_cnt_rat double comment '近7天/近360天_成功订单数_的比例',
-- d15_d30_suc_ord_cnt_rat double comment '近15天/近30天_成功订单数_的比例',
-- d15_d60_suc_ord_cnt_rat double comment '近15天/近60天_成功订单数_的比例',
-- d15_d90_suc_ord_cnt_rat double comment '近15天/近90天_成功订单数_的比例',
-- d15_d180_suc_ord_cnt_rat double comment '近15天/近180天_成功订单数_的比例',
-- d15_d360_suc_ord_cnt_rat double comment '近15天/近360天_成功订单数_的比例',
-- d30_d60_suc_ord_cnt_rat double comment '近30天/近60天_成功订单数_的比例',
-- d30_d90_suc_ord_cnt_rat double comment '近30天/近90天_成功订单数_的比例',
-- d30_d180_suc_ord_cnt_rat double comment '近30天/近180天_成功订单数_的比例',
-- d30_d360_suc_ord_cnt_rat double comment '近30天/近360天_成功订单数_的比例',
-- d60_d90_suc_ord_cnt_rat double comment '近60天/近90天_成功订单数_的比例',
-- d60_d180_suc_ord_cnt_rat double comment '近60天/近180天_成功订单数_的比例',
-- d60_d360_suc_ord_cnt_rat double comment '近60天/近360天_成功订单数_的比例',
-- d90_d180_suc_ord_cnt_rat double comment '近90天/近180天_成功订单数_的比例',
-- d90_d360_suc_ord_cnt_rat double comment '近90天/近360天_成功订单数_的比例',
-- d180_d360_suc_ord_cnt_rat double comment '近180天/近360天_成功订单数_的比例',
-- d7_d15_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近15天_成功订单的借款本金_平均_的比例',
-- d7_d30_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近30天_成功订单的借款本金_平均_的比例',
-- d7_d60_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近60天_成功订单的借款本金_平均_的比例',
-- d7_d90_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近90天_成功订单的借款本金_平均_的比例',
-- d7_d180_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近180天_成功订单的借款本金_平均_的比例',
-- d7_d360_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近7天/近360天_成功订单的借款本金_平均_的比例',
-- d15_d30_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近30天_成功订单的借款本金_平均_的比例',
-- d15_d60_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近60天_成功订单的借款本金_平均_的比例',
-- d15_d90_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近90天_成功订单的借款本金_平均_的比例',
-- d15_d180_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近180天_成功订单的借款本金_平均_的比例',
-- d15_d360_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近15天/近360天_成功订单的借款本金_平均_的比例',
-- d30_d60_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近60天_成功订单的借款本金_平均_的比例',
-- d30_d90_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近90天_成功订单的借款本金_平均_的比例',
-- d30_d180_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近180天_成功订单的借款本金_平均_的比例',
-- d30_d360_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近30天/近360天_成功订单的借款本金_平均_的比例',
-- d60_d90_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近60天/近90天_成功订单的借款本金_平均_的比例',
-- d60_d180_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近60天/近180天_成功订单的借款本金_平均_的比例',
-- d60_d360_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近60天/近360天_成功订单的借款本金_平均_的比例',
-- d90_d180_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近90天/近180天_成功订单的借款本金_平均_的比例',
-- d90_d360_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近90天/近360天_成功订单的借款本金_平均_的比例',
-- d180_d360_suc_ord_prc_amt_avg_rat decimal(38,18) comment '近180天/近360天_成功订单的借款本金_平均_的比例',
-- d7_apl_ord_dis_bsy_typ_cnt_all bigint comment '近7天_发起订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d7_apl_ord_bsy_typ_cnt_all bigint comment '近7天_发起订单的业务类型数（所有业务类型口径统计）',
-- d7_apl_ord_cnt_all bigint comment '近7天_发起订单数（所有业务类型口径统计）',
-- d7_bsy_typ_bt_cash_apl_ord_cnt_all bigint comment '近7天_业务类型为重资产的发起订单数（所有业务类型口径统计）',
-- d7_bsy_typ_api_apl_ord_cnt_all bigint comment '近7天_业务类型为api的发起订单数（所有业务类型口径统计）',
-- d7_bsy_typ_bl_apl_ord_cnt_all bigint comment '近7天_业务类型为小微贷的发起订单数（所有业务类型口径统计）',
-- d7_bsy_typ_ep_apl_ord_cnt_all bigint comment '近7天_业务类型为还享花的发起订单数（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_sum_all decimal(38,18) comment '近7天_发起订单的借款本金_总和（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_max_all decimal(38,18) comment '近7天_发起订单的借款本金_最大（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_min_all decimal(38,18) comment '近7天_发起订单的借款本金_最小（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_avg_all decimal(38,18) comment '近7天_发起订单的借款本金_平均（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近7天_发起订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近7天_发起订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近7天_发起订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d7_apl_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近7天_发起订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d7_apl_ord_stg_num_sum_all bigint comment '近7天_发起订单的分期计划数_总和（所有业务类型口径统计）',
-- d7_apl_ord_stg_num_max_all bigint comment '近7天_发起订单的分期计划数_最大（所有业务类型口径统计）',
-- d7_apl_ord_stg_num_min_all bigint comment '近7天_发起订单的分期计划数_最小（所有业务类型口径统计）',
-- d7_apl_ord_stg_num_avg_all double comment '近7天_发起订单的分期计划数_平均（所有业务类型口径统计）',
-- d7_apl_ord_days_cnt_all bigint comment '近7天_订单发起天数(去重)（所有业务类型口径统计）',
-- d15_apl_ord_dis_bsy_typ_cnt_all bigint comment '近15天_发起订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d15_apl_ord_bsy_typ_cnt_all bigint comment '近15天_发起订单的业务类型数（所有业务类型口径统计）',
-- d15_apl_ord_cnt_all bigint comment '近15天_发起订单数（所有业务类型口径统计）',
-- d15_bsy_typ_bt_cash_apl_ord_cnt_all bigint comment '近15天_业务类型为重资产的发起订单数（所有业务类型口径统计）',
-- d15_bsy_typ_api_apl_ord_cnt_all bigint comment '近15天_业务类型为api的发起订单数（所有业务类型口径统计）',
-- d15_bsy_typ_bl_apl_ord_cnt_all bigint comment '近15天_业务类型为小微贷的发起订单数（所有业务类型口径统计）',
-- d15_bsy_typ_ep_apl_ord_cnt_all bigint comment '近15天_业务类型为还享花的发起订单数（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_sum_all decimal(38,18) comment '近15天_发起订单的借款本金_总和（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_max_all decimal(38,18) comment '近15天_发起订单的借款本金_最大（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_min_all decimal(38,18) comment '近15天_发起订单的借款本金_最小（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_avg_all decimal(38,18) comment '近15天_发起订单的借款本金_平均（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近15天_发起订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近15天_发起订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近15天_发起订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d15_apl_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近15天_发起订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d15_apl_ord_stg_num_sum_all bigint comment '近15天_发起订单的分期计划数_总和（所有业务类型口径统计）',
-- d15_apl_ord_stg_num_max_all bigint comment '近15天_发起订单的分期计划数_最大（所有业务类型口径统计）',
-- d15_apl_ord_stg_num_min_all bigint comment '近15天_发起订单的分期计划数_最小（所有业务类型口径统计）',
-- d15_apl_ord_stg_num_avg_all double comment '近15天_发起订单的分期计划数_平均（所有业务类型口径统计）',
-- d15_apl_ord_days_cnt_all bigint comment '近15天_订单发起天数(去重)（所有业务类型口径统计）',
-- d30_apl_ord_dis_bsy_typ_cnt_all bigint comment '近30天_发起订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d30_apl_ord_bsy_typ_cnt_all bigint comment '近30天_发起订单的业务类型数（所有业务类型口径统计）',
-- d30_apl_ord_cnt_all bigint comment '近30天_发起订单数（所有业务类型口径统计）',
-- d30_bsy_typ_bt_cash_apl_ord_cnt_all bigint comment '近30天_业务类型为重资产的发起订单数（所有业务类型口径统计）',
-- d30_bsy_typ_api_apl_ord_cnt_all bigint comment '近30天_业务类型为api的发起订单数（所有业务类型口径统计）',
-- d30_bsy_typ_bl_apl_ord_cnt_all bigint comment '近30天_业务类型为小微贷的发起订单数（所有业务类型口径统计）',
-- d30_bsy_typ_ep_apl_ord_cnt_all bigint comment '近30天_业务类型为还享花的发起订单数（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_sum_all decimal(38,18) comment '近30天_发起订单的借款本金_总和（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_max_all decimal(38,18) comment '近30天_发起订单的借款本金_最大（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_min_all decimal(38,18) comment '近30天_发起订单的借款本金_最小（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_avg_all decimal(38,18) comment '近30天_发起订单的借款本金_平均（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近30天_发起订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近30天_发起订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近30天_发起订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d30_apl_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近30天_发起订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d30_apl_ord_stg_num_sum_all bigint comment '近30天_发起订单的分期计划数_总和（所有业务类型口径统计）',
-- d30_apl_ord_stg_num_max_all bigint comment '近30天_发起订单的分期计划数_最大（所有业务类型口径统计）',
-- d30_apl_ord_stg_num_min_all bigint comment '近30天_发起订单的分期计划数_最小（所有业务类型口径统计）',
-- d30_apl_ord_stg_num_avg_all double comment '近30天_发起订单的分期计划数_平均（所有业务类型口径统计）',
-- d30_apl_ord_days_cnt_all bigint comment '近30天_订单发起天数(去重)（所有业务类型口径统计）',
-- d60_apl_ord_dis_bsy_typ_cnt_all bigint comment '近60天_发起订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d60_apl_ord_bsy_typ_cnt_all bigint comment '近60天_发起订单的业务类型数（所有业务类型口径统计）',
-- d60_apl_ord_cnt_all bigint comment '近60天_发起订单数（所有业务类型口径统计）',
-- d60_bsy_typ_bt_cash_apl_ord_cnt_all bigint comment '近60天_业务类型为重资产的发起订单数（所有业务类型口径统计）',
-- d60_bsy_typ_api_apl_ord_cnt_all bigint comment '近60天_业务类型为api的发起订单数（所有业务类型口径统计）',
-- d60_bsy_typ_bl_apl_ord_cnt_all bigint comment '近60天_业务类型为小微贷的发起订单数（所有业务类型口径统计）',
-- d60_bsy_typ_ep_apl_ord_cnt_all bigint comment '近60天_业务类型为还享花的发起订单数（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_sum_all decimal(38,18) comment '近60天_发起订单的借款本金_总和（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_max_all decimal(38,18) comment '近60天_发起订单的借款本金_最大（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_min_all decimal(38,18) comment '近60天_发起订单的借款本金_最小（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_avg_all decimal(38,18) comment '近60天_发起订单的借款本金_平均（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近60天_发起订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近60天_发起订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近60天_发起订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d60_apl_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近60天_发起订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d60_apl_ord_stg_num_sum_all bigint comment '近60天_发起订单的分期计划数_总和（所有业务类型口径统计）',
-- d60_apl_ord_stg_num_max_all bigint comment '近60天_发起订单的分期计划数_最大（所有业务类型口径统计）',
-- d60_apl_ord_stg_num_min_all bigint comment '近60天_发起订单的分期计划数_最小（所有业务类型口径统计）',
-- d60_apl_ord_stg_num_avg_all double comment '近60天_发起订单的分期计划数_平均（所有业务类型口径统计）',
-- d60_apl_ord_days_cnt_all bigint comment '近60天_订单发起天数(去重)（所有业务类型口径统计）',
-- d90_apl_ord_dis_bsy_typ_cnt_all bigint comment '近90天_发起订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d90_apl_ord_bsy_typ_cnt_all bigint comment '近90天_发起订单的业务类型数（所有业务类型口径统计）',
-- d90_apl_ord_cnt_all bigint comment '近90天_发起订单数（所有业务类型口径统计）',
-- d90_bsy_typ_bt_cash_apl_ord_cnt_all bigint comment '近90天_业务类型为重资产的发起订单数（所有业务类型口径统计）',
-- d90_bsy_typ_api_apl_ord_cnt_all bigint comment '近90天_业务类型为api的发起订单数（所有业务类型口径统计）',
-- d90_bsy_typ_bl_apl_ord_cnt_all bigint comment '近90天_业务类型为小微贷的发起订单数（所有业务类型口径统计）',
-- d90_bsy_typ_ep_apl_ord_cnt_all bigint comment '近90天_业务类型为还享花的发起订单数（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_sum_all decimal(38,18) comment '近90天_发起订单的借款本金_总和（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_max_all decimal(38,18) comment '近90天_发起订单的借款本金_最大（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_min_all decimal(38,18) comment '近90天_发起订单的借款本金_最小（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_avg_all decimal(38,18) comment '近90天_发起订单的借款本金_平均（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近90天_发起订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近90天_发起订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近90天_发起订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d90_apl_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近90天_发起订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d90_apl_ord_stg_num_sum_all bigint comment '近90天_发起订单的分期计划数_总和（所有业务类型口径统计）',
-- d90_apl_ord_stg_num_max_all bigint comment '近90天_发起订单的分期计划数_最大（所有业务类型口径统计）',
-- d90_apl_ord_stg_num_min_all bigint comment '近90天_发起订单的分期计划数_最小（所有业务类型口径统计）',
-- d90_apl_ord_stg_num_avg_all double comment '近90天_发起订单的分期计划数_平均（所有业务类型口径统计）',
-- d90_apl_ord_days_cnt_all bigint comment '近90天_订单发起天数(去重)（所有业务类型口径统计）',
-- d180_apl_ord_dis_bsy_typ_cnt_all bigint comment '近180天_发起订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d180_apl_ord_bsy_typ_cnt_all bigint comment '近180天_发起订单的业务类型数（所有业务类型口径统计）',
-- d180_apl_ord_cnt_all bigint comment '近180天_发起订单数（所有业务类型口径统计）',
-- d180_bsy_typ_bt_cash_apl_ord_cnt_all bigint comment '近180天_业务类型为重资产的发起订单数（所有业务类型口径统计）',
-- d180_bsy_typ_api_apl_ord_cnt_all bigint comment '近180天_业务类型为api的发起订单数（所有业务类型口径统计）',
-- d180_bsy_typ_bl_apl_ord_cnt_all bigint comment '近180天_业务类型为小微贷的发起订单数（所有业务类型口径统计）',
-- d180_bsy_typ_ep_apl_ord_cnt_all bigint comment '近180天_业务类型为还享花的发起订单数（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_sum_all decimal(38,18) comment '近180天_发起订单的借款本金_总和（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_max_all decimal(38,18) comment '近180天_发起订单的借款本金_最大（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_min_all decimal(38,18) comment '近180天_发起订单的借款本金_最小（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_avg_all decimal(38,18) comment '近180天_发起订单的借款本金_平均（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近180天_发起订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近180天_发起订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近180天_发起订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d180_apl_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近180天_发起订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d180_apl_ord_stg_num_sum_all bigint comment '近180天_发起订单的分期计划数_总和（所有业务类型口径统计）',
-- d180_apl_ord_stg_num_max_all bigint comment '近180天_发起订单的分期计划数_最大（所有业务类型口径统计）',
-- d180_apl_ord_stg_num_min_all bigint comment '近180天_发起订单的分期计划数_最小（所有业务类型口径统计）',
-- d180_apl_ord_stg_num_avg_all double comment '近180天_发起订单的分期计划数_平均（所有业务类型口径统计）',
-- d180_apl_ord_days_cnt_all bigint comment '近180天_订单发起天数(去重)（所有业务类型口径统计）',
-- d360_apl_ord_dis_bsy_typ_cnt_all bigint comment '近360天_发起订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d360_apl_ord_bsy_typ_cnt_all bigint comment '近360天_发起订单的业务类型数（所有业务类型口径统计）',
-- d360_apl_ord_cnt_all bigint comment '近360天_发起订单数（所有业务类型口径统计）',
-- d360_bsy_typ_bt_cash_apl_ord_cnt_all bigint comment '近360天_业务类型为重资产的发起订单数（所有业务类型口径统计）',
-- d360_bsy_typ_api_apl_ord_cnt_all bigint comment '近360天_业务类型为api的发起订单数（所有业务类型口径统计）',
-- d360_bsy_typ_bl_apl_ord_cnt_all bigint comment '近360天_业务类型为小微贷的发起订单数（所有业务类型口径统计）',
-- d360_bsy_typ_ep_apl_ord_cnt_all bigint comment '近360天_业务类型为还享花的发起订单数（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_sum_all decimal(38,18) comment '近360天_发起订单的借款本金_总和（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_max_all decimal(38,18) comment '近360天_发起订单的借款本金_最大（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_min_all decimal(38,18) comment '近360天_发起订单的借款本金_最小（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_avg_all decimal(38,18) comment '近360天_发起订单的借款本金_平均（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近360天_发起订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近360天_发起订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近360天_发起订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d360_apl_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近360天_发起订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d360_apl_ord_stg_num_sum_all bigint comment '近360天_发起订单的分期计划数_总和（所有业务类型口径统计）',
-- d360_apl_ord_stg_num_max_all bigint comment '近360天_发起订单的分期计划数_最大（所有业务类型口径统计）',
-- d360_apl_ord_stg_num_min_all bigint comment '近360天_发起订单的分期计划数_最小（所有业务类型口径统计）',
-- d360_apl_ord_stg_num_avg_all double comment '近360天_发起订单的分期计划数_平均（所有业务类型口径统计）',
-- d360_apl_ord_days_cnt_all bigint comment '近360天_订单发起天数(去重)（所有业务类型口径统计）',
-- d7_suc_ord_dis_bsy_typ_cnt_all bigint comment '近7天_成功订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d7_suc_ord_bsy_typ_cnt_all bigint comment '近7天_成功订单的业务类型数（所有业务类型口径统计）',
-- d7_suc_ord_cnt_all bigint comment '近7天_成功订单数（所有业务类型口径统计）',
-- d7_bsy_typ_bt_cash_suc_ord_cnt_all bigint comment '近7天_业务类型为重资产的成功订单数（所有业务类型口径统计）',
-- d7_bsy_typ_api_suc_ord_cnt_all bigint comment '近7天_业务类型为api的成功订单数（所有业务类型口径统计）',
-- d7_bsy_typ_bl_suc_ord_cnt_all bigint comment '近7天_业务类型为小微贷的成功订单数（所有业务类型口径统计）',
-- d7_bsy_typ_ep_suc_ord_cnt_all bigint comment '近7天_业务类型为还享花的成功订单数（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_sum_all decimal(38,18) comment '近7天_成功订单的借款本金_总和（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_max_all decimal(38,18) comment '近7天_成功订单的借款本金_最大（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_min_all decimal(38,18) comment '近7天_成功订单的借款本金_最小（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_avg_all decimal(38,18) comment '近7天_成功订单的借款本金_平均（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近7天_成功订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近7天_成功订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近7天_成功订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d7_suc_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近7天_成功订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d7_suc_ord_stg_num_sum_all bigint comment '近7天_成功订单的分期计划数_总和（所有业务类型口径统计）',
-- d7_suc_ord_stg_num_max_all bigint comment '近7天_成功订单的分期计划数_最大（所有业务类型口径统计）',
-- d7_suc_ord_stg_num_min_all bigint comment '近7天_成功订单的分期计划数_最小（所有业务类型口径统计）',
-- d7_suc_ord_stg_num_avg_all double comment '近7天_成功订单的分期计划数_平均（所有业务类型口径统计）',
-- d7_suc_ord_days_cnt_all bigint comment '近7天_成功交易天数(去重)（所有业务类型口径统计）',
-- d15_suc_ord_dis_bsy_typ_cnt_all bigint comment '近15天_成功订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d15_suc_ord_bsy_typ_cnt_all bigint comment '近15天_成功订单的业务类型数（所有业务类型口径统计）',
-- d15_suc_ord_cnt_all bigint comment '近15天_成功订单数（所有业务类型口径统计）',
-- d15_bsy_typ_bt_cash_suc_ord_cnt_all bigint comment '近15天_业务类型为重资产的成功订单数（所有业务类型口径统计）',
-- d15_bsy_typ_api_suc_ord_cnt_all bigint comment '近15天_业务类型为api的成功订单数（所有业务类型口径统计）',
-- d15_bsy_typ_bl_suc_ord_cnt_all bigint comment '近15天_业务类型为小微贷的成功订单数（所有业务类型口径统计）',
-- d15_bsy_typ_ep_suc_ord_cnt_all bigint comment '近15天_业务类型为还享花的成功订单数（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_sum_all decimal(38,18) comment '近15天_成功订单的借款本金_总和（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_max_all decimal(38,18) comment '近15天_成功订单的借款本金_最大（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_min_all decimal(38,18) comment '近15天_成功订单的借款本金_最小（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_avg_all decimal(38,18) comment '近15天_成功订单的借款本金_平均（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近15天_成功订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近15天_成功订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近15天_成功订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d15_suc_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近15天_成功订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d15_suc_ord_stg_num_sum_all bigint comment '近15天_成功订单的分期计划数_总和（所有业务类型口径统计）',
-- d15_suc_ord_stg_num_max_all bigint comment '近15天_成功订单的分期计划数_最大（所有业务类型口径统计）',
-- d15_suc_ord_stg_num_min_all bigint comment '近15天_成功订单的分期计划数_最小（所有业务类型口径统计）',
-- d15_suc_ord_stg_num_avg_all double comment '近15天_成功订单的分期计划数_平均（所有业务类型口径统计）',
-- d15_suc_ord_days_cnt_all bigint comment '近15天_成功交易天数(去重)（所有业务类型口径统计）',
-- d30_suc_ord_dis_bsy_typ_cnt_all bigint comment '近30天_成功订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d30_suc_ord_bsy_typ_cnt_all bigint comment '近30天_成功订单的业务类型数（所有业务类型口径统计）',
-- d30_suc_ord_cnt_all bigint comment '近30天_成功订单数（所有业务类型口径统计）',
-- d30_bsy_typ_bt_cash_suc_ord_cnt_all bigint comment '近30天_业务类型为重资产的成功订单数（所有业务类型口径统计）',
-- d30_bsy_typ_api_suc_ord_cnt_all bigint comment '近30天_业务类型为api的成功订单数（所有业务类型口径统计）',
-- d30_bsy_typ_bl_suc_ord_cnt_all bigint comment '近30天_业务类型为小微贷的成功订单数（所有业务类型口径统计）',
-- d30_bsy_typ_ep_suc_ord_cnt_all bigint comment '近30天_业务类型为还享花的成功订单数（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_sum_all decimal(38,18) comment '近30天_成功订单的借款本金_总和（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_max_all decimal(38,18) comment '近30天_成功订单的借款本金_最大（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_min_all decimal(38,18) comment '近30天_成功订单的借款本金_最小（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_avg_all decimal(38,18) comment '近30天_成功订单的借款本金_平均（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近30天_成功订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近30天_成功订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近30天_成功订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d30_suc_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近30天_成功订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d30_suc_ord_stg_num_sum_all bigint comment '近30天_成功订单的分期计划数_总和（所有业务类型口径统计）',
-- d30_suc_ord_stg_num_max_all bigint comment '近30天_成功订单的分期计划数_最大（所有业务类型口径统计）',
-- d30_suc_ord_stg_num_min_all bigint comment '近30天_成功订单的分期计划数_最小（所有业务类型口径统计）',
-- d30_suc_ord_stg_num_avg_all double comment '近30天_成功订单的分期计划数_平均（所有业务类型口径统计）',
-- d30_suc_ord_days_cnt_all bigint comment '近30天_成功交易天数(去重)（所有业务类型口径统计）',
-- d60_suc_ord_dis_bsy_typ_cnt_all bigint comment '近60天_成功订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d60_suc_ord_bsy_typ_cnt_all bigint comment '近60天_成功订单的业务类型数（所有业务类型口径统计）',
-- d60_suc_ord_cnt_all bigint comment '近60天_成功订单数（所有业务类型口径统计）',
-- d60_bsy_typ_bt_cash_suc_ord_cnt_all bigint comment '近60天_业务类型为重资产的成功订单数（所有业务类型口径统计）',
-- d60_bsy_typ_api_suc_ord_cnt_all bigint comment '近60天_业务类型为api的成功订单数（所有业务类型口径统计）',
-- d60_bsy_typ_bl_suc_ord_cnt_all bigint comment '近60天_业务类型为小微贷的成功订单数（所有业务类型口径统计）',
-- d60_bsy_typ_ep_suc_ord_cnt_all bigint comment '近60天_业务类型为还享花的成功订单数（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_sum_all decimal(38,18) comment '近60天_成功订单的借款本金_总和（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_max_all decimal(38,18) comment '近60天_成功订单的借款本金_最大（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_min_all decimal(38,18) comment '近60天_成功订单的借款本金_最小（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_avg_all decimal(38,18) comment '近60天_成功订单的借款本金_平均（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近60天_成功订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近60天_成功订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近60天_成功订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d60_suc_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近60天_成功订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d60_suc_ord_stg_num_sum_all bigint comment '近60天_成功订单的分期计划数_总和（所有业务类型口径统计）',
-- d60_suc_ord_stg_num_max_all bigint comment '近60天_成功订单的分期计划数_最大（所有业务类型口径统计）',
-- d60_suc_ord_stg_num_min_all bigint comment '近60天_成功订单的分期计划数_最小（所有业务类型口径统计）',
-- d60_suc_ord_stg_num_avg_all double comment '近60天_成功订单的分期计划数_平均（所有业务类型口径统计）',
-- d60_suc_ord_days_cnt_all bigint comment '近60天_成功交易天数(去重)（所有业务类型口径统计）',
-- d90_suc_ord_dis_bsy_typ_cnt_all bigint comment '近90天_成功订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d90_suc_ord_bsy_typ_cnt_all bigint comment '近90天_成功订单的业务类型数（所有业务类型口径统计）',
-- d90_suc_ord_cnt_all bigint comment '近90天_成功订单数（所有业务类型口径统计）',
-- d90_bsy_typ_bt_cash_suc_ord_cnt_all bigint comment '近90天_业务类型为重资产的成功订单数（所有业务类型口径统计）',
-- d90_bsy_typ_api_suc_ord_cnt_all bigint comment '近90天_业务类型为api的成功订单数（所有业务类型口径统计）',
-- d90_bsy_typ_bl_suc_ord_cnt_all bigint comment '近90天_业务类型为小微贷的成功订单数（所有业务类型口径统计）',
-- d90_bsy_typ_ep_suc_ord_cnt_all bigint comment '近90天_业务类型为还享花的成功订单数（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_sum_all decimal(38,18) comment '近90天_成功订单的借款本金_总和（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_max_all decimal(38,18) comment '近90天_成功订单的借款本金_最大（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_min_all decimal(38,18) comment '近90天_成功订单的借款本金_最小（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_avg_all decimal(38,18) comment '近90天_成功订单的借款本金_平均（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近90天_成功订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近90天_成功订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近90天_成功订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d90_suc_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近90天_成功订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d90_suc_ord_stg_num_sum_all bigint comment '近90天_成功订单的分期计划数_总和（所有业务类型口径统计）',
-- d90_suc_ord_stg_num_max_all bigint comment '近90天_成功订单的分期计划数_最大（所有业务类型口径统计）',
-- d90_suc_ord_stg_num_min_all bigint comment '近90天_成功订单的分期计划数_最小（所有业务类型口径统计）',
-- d90_suc_ord_stg_num_avg_all double comment '近90天_成功订单的分期计划数_平均（所有业务类型口径统计）',
-- d90_suc_ord_days_cnt_all bigint comment '近90天_成功交易天数(去重)（所有业务类型口径统计）',
-- d180_suc_ord_dis_bsy_typ_cnt_all bigint comment '近180天_成功订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d180_suc_ord_bsy_typ_cnt_all bigint comment '近180天_成功订单的业务类型数（所有业务类型口径统计）',
-- d180_suc_ord_cnt_all bigint comment '近180天_成功订单数（所有业务类型口径统计）',
-- d180_bsy_typ_bt_cash_suc_ord_cnt_all bigint comment '近180天_业务类型为重资产的成功订单数（所有业务类型口径统计）',
-- d180_bsy_typ_api_suc_ord_cnt_all bigint comment '近180天_业务类型为api的成功订单数（所有业务类型口径统计）',
-- d180_bsy_typ_bl_suc_ord_cnt_all bigint comment '近180天_业务类型为小微贷的成功订单数（所有业务类型口径统计）',
-- d180_bsy_typ_ep_suc_ord_cnt_all bigint comment '近180天_业务类型为还享花的成功订单数（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_sum_all decimal(38,18) comment '近180天_成功订单的借款本金_总和（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_max_all decimal(38,18) comment '近180天_成功订单的借款本金_最大（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_min_all decimal(38,18) comment '近180天_成功订单的借款本金_最小（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_avg_all decimal(38,18) comment '近180天_成功订单的借款本金_平均（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近180天_成功订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近180天_成功订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近180天_成功订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d180_suc_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近180天_成功订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d180_suc_ord_stg_num_sum_all bigint comment '近180天_成功订单的分期计划数_总和（所有业务类型口径统计）',
-- d180_suc_ord_stg_num_max_all bigint comment '近180天_成功订单的分期计划数_最大（所有业务类型口径统计）',
-- d180_suc_ord_stg_num_min_all bigint comment '近180天_成功订单的分期计划数_最小（所有业务类型口径统计）',
-- d180_suc_ord_stg_num_avg_all double comment '近180天_成功订单的分期计划数_平均（所有业务类型口径统计）',
-- d180_suc_ord_days_cnt_all bigint comment '近180天_成功交易天数(去重)（所有业务类型口径统计）',
-- d360_suc_ord_dis_bsy_typ_cnt_all bigint comment '近360天_成功订单的业务类型数(重资产/还享花/api/小微贷/其他)（所有业务类型口径统计）',
-- d360_suc_ord_bsy_typ_cnt_all bigint comment '近360天_成功订单的业务类型数（所有业务类型口径统计）',
-- d360_suc_ord_cnt_all bigint comment '近360天_成功订单数（所有业务类型口径统计）',
-- d360_bsy_typ_bt_cash_suc_ord_cnt_all bigint comment '近360天_业务类型为重资产的成功订单数（所有业务类型口径统计）',
-- d360_bsy_typ_api_suc_ord_cnt_all bigint comment '近360天_业务类型为api的成功订单数（所有业务类型口径统计）',
-- d360_bsy_typ_bl_suc_ord_cnt_all bigint comment '近360天_业务类型为小微贷的成功订单数（所有业务类型口径统计）',
-- d360_bsy_typ_ep_suc_ord_cnt_all bigint comment '近360天_业务类型为还享花的成功订单数（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_sum_all decimal(38,18) comment '近360天_成功订单的借款本金_总和（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_max_all decimal(38,18) comment '近360天_成功订单的借款本金_最大（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_min_all decimal(38,18) comment '近360天_成功订单的借款本金_最小（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_avg_all decimal(38,18) comment '近360天_成功订单的借款本金_平均（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_per_stg_sum_all decimal(38,18) comment '近360天_成功订单的单期平均借款本金_总和（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_per_stg_max_all decimal(38,18) comment '近360天_成功订单的单期平均借款本金_最大（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_per_stg_min_all decimal(38,18) comment '近360天_成功订单的单期平均借款本金_最小（所有业务类型口径统计）',
-- d360_suc_ord_prc_amt_per_stg_avg_all decimal(38,18) comment '近360天_成功订单的单期平均借款本金_平均（所有业务类型口径统计）',
-- d360_suc_ord_stg_num_sum_all bigint comment '近360天_成功订单的分期计划数_总和（所有业务类型口径统计）',
-- d360_suc_ord_stg_num_max_all bigint comment '近360天_成功订单的分期计划数_最大（所有业务类型口径统计）',
-- d360_suc_ord_stg_num_min_all bigint comment '近360天_成功订单的分期计划数_最小（所有业务类型口径统计）',
-- d360_suc_ord_stg_num_avg_all double comment '近360天_成功订单的分期计划数_平均（所有业务类型口径统计）',
-- d360_suc_ord_days_cnt_all bigint comment '近360天_成功交易天数(去重)（所有业务类型口径统计）',
-- d7_d15_apl_ord_cnt_rat_all double comment '近7天/近15天_发起订单数_的比例（所有业务类型口径统计）',
-- d7_d30_apl_ord_cnt_rat_all double comment '近7天/近30天_发起订单数_的比例（所有业务类型口径统计）',
-- d7_d60_apl_ord_cnt_rat_all double comment '近7天/近60天_发起订单数_的比例（所有业务类型口径统计）',
-- d7_d90_apl_ord_cnt_rat_all double comment '近7天/近90天_发起订单数_的比例（所有业务类型口径统计）',
-- d7_d180_apl_ord_cnt_rat_all double comment '近7天/近180天_发起订单数_的比例（所有业务类型口径统计）',
-- d7_d360_apl_ord_cnt_rat_all double comment '近7天/近360天_发起订单数_的比例（所有业务类型口径统计）',
-- d15_d30_apl_ord_cnt_rat_all double comment '近15天/近30天_发起订单数_的比例（所有业务类型口径统计）',
-- d15_d60_apl_ord_cnt_rat_all double comment '近15天/近60天_发起订单数_的比例（所有业务类型口径统计）',
-- d15_d90_apl_ord_cnt_rat_all double comment '近15天/近90天_发起订单数_的比例（所有业务类型口径统计）',
-- d15_d180_apl_ord_cnt_rat_all double comment '近15天/近180天_发起订单数_的比例（所有业务类型口径统计）',
-- d15_d360_apl_ord_cnt_rat_all double comment '近15天/近360天_发起订单数_的比例（所有业务类型口径统计）',
-- d30_d60_apl_ord_cnt_rat_all double comment '近30天/近60天_发起订单数_的比例（所有业务类型口径统计）',
-- d30_d90_apl_ord_cnt_rat_all double comment '近30天/近90天_发起订单数_的比例（所有业务类型口径统计）',
-- d30_d180_apl_ord_cnt_rat_all double comment '近30天/近180天_发起订单数_的比例（所有业务类型口径统计）',
-- d30_d360_apl_ord_cnt_rat_all double comment '近30天/近360天_发起订单数_的比例（所有业务类型口径统计）',
-- d60_d90_apl_ord_cnt_rat_all double comment '近60天/近90天_发起订单数_的比例（所有业务类型口径统计）',
-- d60_d180_apl_ord_cnt_rat_all double comment '近60天/近180天_发起订单数_的比例（所有业务类型口径统计）',
-- d60_d360_apl_ord_cnt_rat_all double comment '近60天/近360天_发起订单数_的比例（所有业务类型口径统计）',
-- d90_d180_apl_ord_cnt_rat_all double comment '近90天/近180天_发起订单数_的比例（所有业务类型口径统计）',
-- d90_d360_apl_ord_cnt_rat_all double comment '近90天/近360天_发起订单数_的比例（所有业务类型口径统计）',
-- d180_d360_apl_ord_cnt_rat_all double comment '近180天/近360天_发起订单数_的比例（所有业务类型口径统计）',
-- d7_d15_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近15天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d30_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近30天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d60_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近60天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d90_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近90天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d180_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近180天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d360_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近360天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d30_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近30天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d60_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近60天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d90_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近90天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d180_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近180天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d360_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近360天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d60_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近60天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d90_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近90天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d180_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近180天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d360_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近360天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d60_d90_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近60天/近90天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d60_d180_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近60天/近180天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d60_d360_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近60天/近360天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d90_d180_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近90天/近180天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d90_d360_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近90天/近360天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d180_d360_apl_ord_prc_amt_avg_rat_all decimal(38,18) comment '近180天/近360天_发起订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d15_suc_ord_cnt_rat_all double comment '近7天/近15天_成功订单数_的比例（所有业务类型口径统计）',
-- d7_d30_suc_ord_cnt_rat_all double comment '近7天/近30天_成功订单数_的比例（所有业务类型口径统计）',
-- d7_d60_suc_ord_cnt_rat_all double comment '近7天/近60天_成功订单数_的比例（所有业务类型口径统计）',
-- d7_d90_suc_ord_cnt_rat_all double comment '近7天/近90天_成功订单数_的比例（所有业务类型口径统计）',
-- d7_d180_suc_ord_cnt_rat_all double comment '近7天/近180天_成功订单数_的比例（所有业务类型口径统计）',
-- d7_d360_suc_ord_cnt_rat_all double comment '近7天/近360天_成功订单数_的比例（所有业务类型口径统计）',
-- d15_d30_suc_ord_cnt_rat_all double comment '近15天/近30天_成功订单数_的比例（所有业务类型口径统计）',
-- d15_d60_suc_ord_cnt_rat_all double comment '近15天/近60天_成功订单数_的比例（所有业务类型口径统计）',
-- d15_d90_suc_ord_cnt_rat_all double comment '近15天/近90天_成功订单数_的比例（所有业务类型口径统计）',
-- d15_d180_suc_ord_cnt_rat_all double comment '近15天/近180天_成功订单数_的比例（所有业务类型口径统计）',
-- d15_d360_suc_ord_cnt_rat_all double comment '近15天/近360天_成功订单数_的比例（所有业务类型口径统计）',
-- d30_d60_suc_ord_cnt_rat_all double comment '近30天/近60天_成功订单数_的比例（所有业务类型口径统计）',
-- d30_d90_suc_ord_cnt_rat_all double comment '近30天/近90天_成功订单数_的比例（所有业务类型口径统计）',
-- d30_d180_suc_ord_cnt_rat_all double comment '近30天/近180天_成功订单数_的比例（所有业务类型口径统计）',
-- d30_d360_suc_ord_cnt_rat_all double comment '近30天/近360天_成功订单数_的比例（所有业务类型口径统计）',
-- d60_d90_suc_ord_cnt_rat_all double comment '近60天/近90天_成功订单数_的比例（所有业务类型口径统计）',
-- d60_d180_suc_ord_cnt_rat_all double comment '近60天/近180天_成功订单数_的比例（所有业务类型口径统计）',
-- d60_d360_suc_ord_cnt_rat_all double comment '近60天/近360天_成功订单数_的比例（所有业务类型口径统计）',
-- d90_d180_suc_ord_cnt_rat_all double comment '近90天/近180天_成功订单数_的比例（所有业务类型口径统计）',
-- d90_d360_suc_ord_cnt_rat_all double comment '近90天/近360天_成功订单数_的比例（所有业务类型口径统计）',
-- d180_d360_suc_ord_cnt_rat_all double comment '近180天/近360天_成功订单数_的比例（所有业务类型口径统计）',
-- d7_d15_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近15天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d30_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近30天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d60_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近60天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d90_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近90天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d180_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近180天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d7_d360_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近7天/近360天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d30_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近30天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d60_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近60天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d90_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近90天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d180_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近180天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d15_d360_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近15天/近360天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d60_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近60天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d90_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近90天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d180_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近180天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d30_d360_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近30天/近360天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d60_d90_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近60天/近90天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d60_d180_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近60天/近180天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d60_d360_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近60天/近360天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d90_d180_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近90天/近180天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d90_d360_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近90天/近360天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）',
-- d180_d360_suc_ord_prc_amt_avg_rat_all decimal(38,18) comment '近180天/近360天_成功订单的借款本金_平均_的比例（所有业务类型口径统计）'
-- )comment '贷中宽表_借款明细数据,对全量复借户打分'
-- partitioned by (ds string)
-- ;


set odps.stage.mapper.split.size=20; 
-- 基础层
drop table if exists ${pdm_risk}.pdm_risk_f_heavy_order_info_basic_tmp;
create table ${pdm_risk}.pdm_risk_f_heavy_order_info_basic_tmp as
select  uid
        ,order_no
        ,business_type as bsy_typ 
        ,coalesce(order_status,apply_status) ord_stt
        ,case when loan_success_flag = 1 then 'success'
              when apply_status in ('LEND_FAIL', 'LOAN_DENIED')  then 'fail'
              when order_status ='R'  then 'fail'
         else 'else' 
         end ord_stt_flg
        ,coalesce(loan_principal_amount,apply_amount) as prc_amt 
        ,coalesce(init_total_stage,apply_total_stage) stg_num
        ,apply_record_crt_time crt_tim
        ,coalesce(loan_date,date(apply_record_crt_time)) as loan_date 
        ,to_date(apply_record_crt_time) as crt_dte
from dwt.dwt_heavy_order_df
where ds = '${bizdate}'
and to_date(apply_record_crt_time) between add_months(date_add(to_date('${bizdate}' ,'yyyymmdd') ,0),-12) and date_add(to_date('${bizdate}' ,'yyyymmdd') ,0)
;


set odps.stage.mapper.split.size=20; 
-- 明细层
drop table if exists ${pdm_risk}.pdm_risk_f_heavy_order_info_detail_tmp;
create table ${pdm_risk}.pdm_risk_f_heavy_order_info_detail_tmp as
select  *
        ,case when ddf_mdl_ord_crt_dte between 1 and 7 then 1 else 0 end as d7_flg
        ,case when ddf_mdl_ord_crt_dte between 1 and 15 then 1 else 0 end as d15_flg
        ,case when ddf_mdl_ord_crt_dte between 1 and 30 then 1 else 0 end as d30_flg
        ,case when ddf_mdl_ord_crt_dte between 1 and 60 then 1 else 0 end as d60_flg
        ,case when ddf_mdl_ord_crt_dte between 1 and 90 then 1 else 0 end as d90_flg
        ,case when ddf_mdl_ord_crt_dte between 1 and 180 then 1 else 0 end as d180_flg   
        ,case when ddf_mdl_ord_crt_dte between 1 and 360 then 1 else 0 end as d360_flg  
from 
(
        select model_data.uid
                ,model_data.mdl_dte
              

                --订单创建时间（时间戳格式）
                ,order_info.crt_tim
                ,order_info.ord_stt
                
                -- 订单标识
                ,order_info.ord_stt_flg

                --订单flag
                ,row_number() over(partition by model_data.uid,order_info.ord_stt_flg order by order_info.crt_tim asc) as fst_ord_flg  --首次动支订单flag
                ,row_number() over(partition by model_data.uid,order_info.ord_stt_flg order by order_info.crt_tim desc) as lst_ord_flg  --最近动支订单flag
                ,0 as cur_ord_flg  --当前动支订单flag（这里假设如有多笔，model_data已经取了最近的一笔ord_no）
                --bt_cash_flag
                ,case when order_info.bsy_typ in('BALANCE_TRANSFER','CASH') then 'bt_cash' 
                      when bsy_typ in 'API_ASSET' then 'api'
                      when bsy_typ in 'BUSINESS_LOAN' then 'bl'
                      when bsy_typ in 'ENJOY_PAY' then 'ep'
                else 'other' end as new_bsy_typ
                -- 金额区间 flag
                ,case when prc_amt >= 3000 then 1 else 0 end as prc_amt_3_000_flg
                ,case when prc_amt >= 5000 then 1 else 0 end as prc_amt_5_000_flg
                ,case when prc_amt >= 10000 then 1 else 0 end as prc_amt_10_000_flg
                ,case when prc_amt >= 20000 then 1 else 0 end as prc_amt_20_000_flg
                ,case when prc_amt >= 30000 then 1 else 0 end as prc_amt_30_000_flg
                ,case when prc_amt >= 50000 then 1 else 0 end as prc_amt_50_000_flg
                
                -- 指标
                ,order_info.prc_amt
                ,order_info.ord_no
                ,order_info.crt_dte --订单创建时间（日期格式）
                ,order_info.bsy_typ
                ,datediff(model_data.mdl_dte,date(order_info.crt_dte)) as ddf_mdl_ord_crt_dte --间隔天数
                ,order_info.stg_num -- 分期计划数
                ,prc_amt/stg_num as prc_amt_per_stg
        from    
        (
                select uid
                        ,date_add(date(to_date('${bizdate}','yyyymmdd')),1) as mdl_dte
                from dwt.dwt_heavy_order_df
                where ds = '${bizdate}'
                and loan_success_flag = 1
                group by uid
        ) model_data     
        left join
        (   
                select uid
                        ,order_no as ord_no
                        ,crt_tim
                        ,crt_dte
                        ,prc_amt
                        ,stg_num
                        ,ord_stt
                        ,bsy_typ
                        ,ord_stt_flg
                from ${pdm_risk}.pdm_risk_f_heavy_order_info_basic_tmp
                -- where bsy_typ in ('BALANCE_TRANSFER', 'CASH')--('BALANCE_TRANSFER', 'CREDIT_TRANSACTION', 'CASH', 'HUGE_LOAN', 'ENJOY_PAY')
        )order_info 
        on model_data.uid=order_info.uid
        where order_info.crt_dte < date(model_data.mdl_dte)  --在评分日之前的order信息
          and order_info.crt_dte >= date_add(model_data.mdl_dte,-360)
) main
;


set odps.stage.mapper.split.size=20; 
-----------------------------------------------------------
--------/*统计重资产（'CASH','BALANCE_TRANSFER'）*/
-----------------------------------------------------------

drop table if exists ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp;
create table ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp as
select uid
       ,mdl_dte
       --/*--------------发起订单---------------*/
       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d7_flg = 1 then ord_no else null end) as d7_apl_ord_cnt
       ,sum(case when d7_flg = 1 then prc_amt else null end) as d7_apl_ord_prc_amt_sum
       ,max(case when d7_flg = 1 then prc_amt else null end) as d7_apl_ord_prc_amt_max
       ,min(case when d7_flg = 1 then prc_amt else null end) as d7_apl_ord_prc_amt_min
       ,avg(case when d7_flg = 1 then prc_amt else null end) as d7_apl_ord_prc_amt_avg
       ,sum(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_apl_ord_prc_amt_per_stg_sum
       ,max(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_apl_ord_prc_amt_per_stg_max
       ,min(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_apl_ord_prc_amt_per_stg_min
       ,avg(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_apl_ord_prc_amt_per_stg_avg
       ,count(distinct case when d7_flg = 1 then crt_dte else null end) as d7_apl_ord_days_cnt
       ,max(case when d7_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d7_apl_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d7_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d7_apl_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_sum
       ,max(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_max
       ,min(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_min
       ,avg(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d7_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_3_000_apl_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_5_000_apl_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_10_000_apl_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_20_000_apl_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_50_000_apl_ord_cnt
       
       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d15_flg = 1 then ord_no else null end) as d15_apl_ord_cnt
       ,sum(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_sum
       ,max(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_max
       ,min(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_min
       ,avg(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_avg
       ,sum(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_sum
       ,max(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_max
       ,min(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_min
       ,avg(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_avg
       ,count(distinct case when d15_flg = 1 then crt_dte else null end) as d15_apl_ord_days_cnt
       ,max(case when d15_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d15_apl_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d15_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d15_apl_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_sum
       ,max(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_max
       ,min(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_min
       ,avg(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d15_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_3_000_apl_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_5_000_apl_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_10_000_apl_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_20_000_apl_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_50_000_apl_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d30_flg = 1 then ord_no else null end) as d30_apl_ord_cnt
       ,sum(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_sum
       ,max(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_max
       ,min(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_min
       ,avg(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_avg
       ,sum(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_sum
       ,max(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_max
       ,min(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_min
       ,avg(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_avg
       ,count(distinct case when d30_flg = 1 then crt_dte else null end) as d30_apl_ord_days_cnt
       ,max(case when d30_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d30_apl_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d30_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d30_apl_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_sum
       ,max(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_max
       ,min(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_min
       ,avg(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d30_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_3_000_apl_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_5_000_apl_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_10_000_apl_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_20_000_apl_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_50_000_apl_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d60_flg = 1 then ord_no else null end) as d60_apl_ord_cnt
       ,sum(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_sum
       ,max(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_max
       ,min(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_min
       ,avg(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_avg
       ,sum(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_sum
       ,max(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_max
       ,min(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_min
       ,avg(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_avg
       ,count(distinct case when d60_flg = 1 then crt_dte else null end) as d60_apl_ord_days_cnt
       ,max(case when d60_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d60_apl_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d60_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d60_apl_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_sum
       ,max(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_max
       ,min(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_min
       ,avg(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d60_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_3_000_apl_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_5_000_apl_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_10_000_apl_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_20_000_apl_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_50_000_apl_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d90_flg = 1 then ord_no else null end) as d90_apl_ord_cnt
       ,sum(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_sum
       ,max(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_max
       ,min(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_min
       ,avg(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_avg
       ,sum(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_sum
       ,max(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_max
       ,min(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_min
       ,avg(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_avg
       ,count(distinct case when d90_flg = 1 then crt_dte else null end) as d90_apl_ord_days_cnt
       ,max(case when d90_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d90_apl_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d90_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d90_apl_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_sum
       ,max(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_max
       ,min(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_min
       ,avg(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d90_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_3_000_apl_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_5_000_apl_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_10_000_apl_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_20_000_apl_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_50_000_apl_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d180_flg = 1 then ord_no else null end) as d180_apl_ord_cnt
       ,sum(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_sum
       ,max(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_max
       ,min(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_min
       ,avg(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_avg
       ,sum(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_sum
       ,max(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_max
       ,min(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_min
       ,avg(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_avg
       ,count(distinct case when d180_flg = 1 then crt_dte else null end) as d180_apl_ord_days_cnt
       ,max(case when d180_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d180_apl_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d180_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d180_apl_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_sum
       ,max(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_max
       ,min(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_min
       ,avg(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d180_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_3_000_apl_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_5_000_apl_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_10_000_apl_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_20_000_apl_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_50_000_apl_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d360_flg = 1 then ord_no else null end) as d360_apl_ord_cnt
       ,sum(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_sum
       ,max(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_max
       ,min(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_min
       ,avg(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_avg
       ,sum(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_sum
       ,max(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_max
       ,min(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_min
       ,avg(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_avg
       ,count(distinct case when d360_flg = 1 then crt_dte else null end) as d360_apl_ord_days_cnt
       ,max(case when d360_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d360_apl_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d360_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d360_apl_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_sum
       ,max(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_max
       ,min(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_min
       ,avg(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d360_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_3_000_apl_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_5_000_apl_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_10_000_apl_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_20_000_apl_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_50_000_apl_ord_cnt
       
from ${pdm_risk}.pdm_risk_f_heavy_order_info_detail_tmp
where bsy_typ in ('CASH','BALANCE_TRANSFER')
group by uid
        ,mdl_dte
;


-- 成功订单 
drop table if exists ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp1;
create table ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp1 as
select uid
       ,mdl_dte
       
       --/*--------------成功订单---------------*/
       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d7_flg = 1 then ord_no else null end) as d7_suc_ord_cnt
       ,sum(case when d7_flg = 1 then prc_amt else null end) as d7_suc_ord_prc_amt_sum
       ,max(case when d7_flg = 1 then prc_amt else null end) as d7_suc_ord_prc_amt_max
       ,min(case when d7_flg = 1 then prc_amt else null end) as d7_suc_ord_prc_amt_min
       ,avg(case when d7_flg = 1 then prc_amt else null end) as d7_suc_ord_prc_amt_avg
       ,sum(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_suc_ord_prc_amt_per_stg_sum
       ,max(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_suc_ord_prc_amt_per_stg_max
       ,min(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_suc_ord_prc_amt_per_stg_min
       ,avg(case when d7_flg = 1 then prc_amt_per_stg else null end) as d7_suc_ord_prc_amt_per_stg_avg
       ,count(distinct case when d7_flg = 1 then crt_dte else null end) as d7_suc_ord_days_cnt
       ,max(case when d7_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d7_suc_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d7_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d7_suc_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_sum
       ,max(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_max
       ,min(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_min
       ,avg(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d7_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_3_000_suc_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_5_000_suc_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_10_000_suc_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_20_000_suc_ord_cnt
       ,count(case when d7_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d7_prc_amt_mor_50_000_suc_ord_cnt
       
       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d15_flg = 1 then ord_no else null end) as d15_suc_ord_cnt
       ,sum(case when d15_flg = 1 then prc_amt else null end) as d15_suc_ord_prc_amt_sum
       ,max(case when d15_flg = 1 then prc_amt else null end) as d15_suc_ord_prc_amt_max
       ,min(case when d15_flg = 1 then prc_amt else null end) as d15_suc_ord_prc_amt_min
       ,avg(case when d15_flg = 1 then prc_amt else null end) as d15_suc_ord_prc_amt_avg
       ,sum(case when d15_flg = 1 then prc_amt_per_stg else null end) as d15_suc_ord_prc_amt_per_stg_sum
       ,max(case when d15_flg = 1 then prc_amt_per_stg else null end) as d15_suc_ord_prc_amt_per_stg_max
       ,min(case when d15_flg = 1 then prc_amt_per_stg else null end) as d15_suc_ord_prc_amt_per_stg_min
       ,avg(case when d15_flg = 1 then prc_amt_per_stg else null end) as d15_suc_ord_prc_amt_per_stg_avg
       ,count(distinct case when d15_flg = 1 then crt_dte else null end) as d15_suc_ord_days_cnt
       ,max(case when d15_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d15_suc_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d15_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d15_suc_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_sum
       ,max(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_max
       ,min(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_min
       ,avg(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d15_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_3_000_suc_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_5_000_suc_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_10_000_suc_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_20_000_suc_ord_cnt
       ,count(case when d15_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d15_prc_amt_mor_50_000_suc_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d30_flg = 1 then ord_no else null end) as d30_suc_ord_cnt
       ,sum(case when d30_flg = 1 then prc_amt else null end) as d30_suc_ord_prc_amt_sum
       ,max(case when d30_flg = 1 then prc_amt else null end) as d30_suc_ord_prc_amt_max
       ,min(case when d30_flg = 1 then prc_amt else null end) as d30_suc_ord_prc_amt_min
       ,avg(case when d30_flg = 1 then prc_amt else null end) as d30_suc_ord_prc_amt_avg
       ,sum(case when d30_flg = 1 then prc_amt_per_stg else null end) as d30_suc_ord_prc_amt_per_stg_sum
       ,max(case when d30_flg = 1 then prc_amt_per_stg else null end) as d30_suc_ord_prc_amt_per_stg_max
       ,min(case when d30_flg = 1 then prc_amt_per_stg else null end) as d30_suc_ord_prc_amt_per_stg_min
       ,avg(case when d30_flg = 1 then prc_amt_per_stg else null end) as d30_suc_ord_prc_amt_per_stg_avg
       ,count(distinct case when d30_flg = 1 then crt_dte else null end) as d30_suc_ord_days_cnt
       ,max(case when d30_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d30_suc_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d30_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d30_suc_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_sum
       ,max(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_max
       ,min(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_min
       ,avg(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d30_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_3_000_suc_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_5_000_suc_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_10_000_suc_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_20_000_suc_ord_cnt
       ,count(case when d30_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d30_prc_amt_mor_50_000_suc_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d60_flg = 1 then ord_no else null end) as d60_suc_ord_cnt
       ,sum(case when d60_flg = 1 then prc_amt else null end) as d60_suc_ord_prc_amt_sum
       ,max(case when d60_flg = 1 then prc_amt else null end) as d60_suc_ord_prc_amt_max
       ,min(case when d60_flg = 1 then prc_amt else null end) as d60_suc_ord_prc_amt_min
       ,avg(case when d60_flg = 1 then prc_amt else null end) as d60_suc_ord_prc_amt_avg
       ,sum(case when d60_flg = 1 then prc_amt_per_stg else null end) as d60_suc_ord_prc_amt_per_stg_sum
       ,max(case when d60_flg = 1 then prc_amt_per_stg else null end) as d60_suc_ord_prc_amt_per_stg_max
       ,min(case when d60_flg = 1 then prc_amt_per_stg else null end) as d60_suc_ord_prc_amt_per_stg_min
       ,avg(case when d60_flg = 1 then prc_amt_per_stg else null end) as d60_suc_ord_prc_amt_per_stg_avg
       ,count(distinct case when d60_flg = 1 then crt_dte else null end) as d60_suc_ord_days_cnt
       ,max(case when d60_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d60_suc_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d60_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d60_suc_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_sum
       ,max(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_max
       ,min(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_min
       ,avg(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d60_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_3_000_suc_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_5_000_suc_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_10_000_suc_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_20_000_suc_ord_cnt
       ,count(case when d60_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d60_prc_amt_mor_50_000_suc_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d90_flg = 1 then ord_no else null end) as d90_suc_ord_cnt
       ,sum(case when d90_flg = 1 then prc_amt else null end) as d90_suc_ord_prc_amt_sum
       ,max(case when d90_flg = 1 then prc_amt else null end) as d90_suc_ord_prc_amt_max
       ,min(case when d90_flg = 1 then prc_amt else null end) as d90_suc_ord_prc_amt_min
       ,avg(case when d90_flg = 1 then prc_amt else null end) as d90_suc_ord_prc_amt_avg
       ,sum(case when d90_flg = 1 then prc_amt_per_stg else null end) as d90_suc_ord_prc_amt_per_stg_sum
       ,max(case when d90_flg = 1 then prc_amt_per_stg else null end) as d90_suc_ord_prc_amt_per_stg_max
       ,min(case when d90_flg = 1 then prc_amt_per_stg else null end) as d90_suc_ord_prc_amt_per_stg_min
       ,avg(case when d90_flg = 1 then prc_amt_per_stg else null end) as d90_suc_ord_prc_amt_per_stg_avg
       ,count(distinct case when d90_flg = 1 then crt_dte else null end) as d90_suc_ord_days_cnt
       ,max(case when d90_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d90_suc_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d90_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d90_suc_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_sum
       ,max(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_max
       ,min(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_min
       ,avg(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d90_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_3_000_suc_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_5_000_suc_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_10_000_suc_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_20_000_suc_ord_cnt
       ,count(case when d90_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d90_prc_amt_mor_50_000_suc_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d180_flg = 1 then ord_no else null end) as d180_suc_ord_cnt
       ,sum(case when d180_flg = 1 then prc_amt else null end) as d180_suc_ord_prc_amt_sum
       ,max(case when d180_flg = 1 then prc_amt else null end) as d180_suc_ord_prc_amt_max
       ,min(case when d180_flg = 1 then prc_amt else null end) as d180_suc_ord_prc_amt_min
       ,avg(case when d180_flg = 1 then prc_amt else null end) as d180_suc_ord_prc_amt_avg
       ,sum(case when d180_flg = 1 then prc_amt_per_stg else null end) as d180_suc_ord_prc_amt_per_stg_sum
       ,max(case when d180_flg = 1 then prc_amt_per_stg else null end) as d180_suc_ord_prc_amt_per_stg_max
       ,min(case when d180_flg = 1 then prc_amt_per_stg else null end) as d180_suc_ord_prc_amt_per_stg_min
       ,avg(case when d180_flg = 1 then prc_amt_per_stg else null end) as d180_suc_ord_prc_amt_per_stg_avg
       ,count(distinct case when d180_flg = 1 then crt_dte else null end) as d180_suc_ord_days_cnt
       ,max(case when d180_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d180_suc_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d180_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d180_suc_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_sum
       ,max(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_max
       ,min(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_min
       ,avg(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d180_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_3_000_suc_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_5_000_suc_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_10_000_suc_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_20_000_suc_ord_cnt
       ,count(case when d180_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d180_prc_amt_mor_50_000_suc_ord_cnt

       -- /*订单数/金额/分期数/申请天数/时间间隔*/ 
       ,count(case when d360_flg = 1 then ord_no else null end) as d360_suc_ord_cnt
       ,sum(case when d360_flg = 1 then prc_amt else null end) as d360_suc_ord_prc_amt_sum
       ,max(case when d360_flg = 1 then prc_amt else null end) as d360_suc_ord_prc_amt_max
       ,min(case when d360_flg = 1 then prc_amt else null end) as d360_suc_ord_prc_amt_min
       ,avg(case when d360_flg = 1 then prc_amt else null end) as d360_suc_ord_prc_amt_avg
       ,sum(case when d360_flg = 1 then prc_amt_per_stg else null end) as d360_suc_ord_prc_amt_per_stg_sum
       ,max(case when d360_flg = 1 then prc_amt_per_stg else null end) as d360_suc_ord_prc_amt_per_stg_max
       ,min(case when d360_flg = 1 then prc_amt_per_stg else null end) as d360_suc_ord_prc_amt_per_stg_min
       ,avg(case when d360_flg = 1 then prc_amt_per_stg else null end) as d360_suc_ord_prc_amt_per_stg_avg
       ,count(distinct case when d360_flg = 1 then crt_dte else null end) as d360_suc_ord_days_cnt
       ,max(case when d360_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d360_suc_ord_ddf_mdl_ord_crt_dte_max
       ,min(case when d360_flg = 1 then ddf_mdl_ord_crt_dte else null end) as d360_suc_ord_ddf_mdl_ord_crt_dte_min
       ,sum(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_sum
       ,max(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_max
       ,min(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_min
       ,avg(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_avg
       -- /*借款金额区间*/
       ,count(case when d360_flg = 1 and prc_amt_3_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_3_000_suc_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_5_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_5_000_suc_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_10_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_10_000_suc_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_20_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_20_000_suc_ord_cnt
       ,count(case when d360_flg = 1 and prc_amt_50_000_flg = 1 then ord_no else null end) as d360_prc_amt_mor_50_000_suc_ord_cnt
from ${pdm_risk}.pdm_risk_f_heavy_order_info_detail_tmp
where bsy_typ in ('CASH','BALANCE_TRANSFER')
and ord_stt_flg = 'success'
group by uid
        ,mdl_dte
;



-- 趋势变化
drop table if exists ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp2;
create table ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp2 as 
select a.uid
       ,a.mdl_dte
       --/*--------------发起订单---------------*/
       -- /*订单数*/ 
       ,case when d15_apl_ord_cnt = 0 then -1 else d7_apl_ord_cnt/d15_apl_ord_cnt end as d7_d15_apl_ord_cnt_rat
       ,case when d30_apl_ord_cnt = 0 then -1 else d7_apl_ord_cnt/d30_apl_ord_cnt end as d7_d30_apl_ord_cnt_rat
       ,case when d60_apl_ord_cnt = 0 then -1 else d7_apl_ord_cnt/d60_apl_ord_cnt end as d7_d60_apl_ord_cnt_rat
       ,case when d90_apl_ord_cnt = 0 then -1 else d7_apl_ord_cnt/d90_apl_ord_cnt end as d7_d90_apl_ord_cnt_rat
       ,case when d180_apl_ord_cnt = 0 then -1 else d7_apl_ord_cnt/d180_apl_ord_cnt end as d7_d180_apl_ord_cnt_rat
       ,case when d360_apl_ord_cnt = 0 then -1 else d7_apl_ord_cnt/d360_apl_ord_cnt end as d7_d360_apl_ord_cnt_rat
       
       ,case when d30_apl_ord_cnt = 0 then -1 else d15_apl_ord_cnt/d30_apl_ord_cnt end as d15_d30_apl_ord_cnt_rat
       ,case when d60_apl_ord_cnt = 0 then -1 else d15_apl_ord_cnt/d60_apl_ord_cnt end as d15_d60_apl_ord_cnt_rat
       ,case when d90_apl_ord_cnt = 0 then -1 else d15_apl_ord_cnt/d90_apl_ord_cnt end as d15_d90_apl_ord_cnt_rat
       ,case when d180_apl_ord_cnt = 0 then -1 else d15_apl_ord_cnt/d180_apl_ord_cnt end as d15_d180_apl_ord_cnt_rat
       ,case when d360_apl_ord_cnt = 0 then -1 else d15_apl_ord_cnt/d360_apl_ord_cnt end as d15_d360_apl_ord_cnt_rat
       ,case when d60_apl_ord_cnt = 0 then -1 else d30_apl_ord_cnt/d60_apl_ord_cnt end as d30_d60_apl_ord_cnt_rat
       ,case when d90_apl_ord_cnt = 0 then -1 else d30_apl_ord_cnt/d90_apl_ord_cnt end as d30_d90_apl_ord_cnt_rat
       ,case when d180_apl_ord_cnt = 0 then -1 else d30_apl_ord_cnt/d180_apl_ord_cnt end as d30_d180_apl_ord_cnt_rat
       ,case when d360_apl_ord_cnt = 0 then -1 else d30_apl_ord_cnt/d360_apl_ord_cnt end as d30_d360_apl_ord_cnt_rat
       ,case when d90_apl_ord_cnt = 0 then -1 else d60_apl_ord_cnt/d90_apl_ord_cnt end as d60_d90_apl_ord_cnt_rat
       ,case when d180_apl_ord_cnt = 0 then -1 else d60_apl_ord_cnt/d180_apl_ord_cnt end as d60_d180_apl_ord_cnt_rat
       ,case when d360_apl_ord_cnt = 0 then -1 else d60_apl_ord_cnt/d360_apl_ord_cnt end as d60_d360_apl_ord_cnt_rat
       ,case when d180_apl_ord_cnt = 0 then -1 else d90_apl_ord_cnt/d180_apl_ord_cnt end as d90_d180_apl_ord_cnt_rat
       ,case when d360_apl_ord_cnt = 0 then -1 else d90_apl_ord_cnt/d360_apl_ord_cnt end as d90_d360_apl_ord_cnt_rat
       ,case when d360_apl_ord_cnt = 0 then -1 else d180_apl_ord_cnt/d360_apl_ord_cnt end as d180_d360_apl_ord_cnt_rat
       -- /*订单金额*/
       ,case when d15_apl_ord_prc_amt_avg = 0 then -1 else d7_apl_ord_prc_amt_avg/d15_apl_ord_prc_amt_avg end as d7_d15_apl_ord_prc_amt_avg_rat
       ,case when d30_apl_ord_prc_amt_avg = 0 then -1 else d7_apl_ord_prc_amt_avg/d30_apl_ord_prc_amt_avg end as d7_d30_apl_ord_prc_amt_avg_rat
       ,case when d60_apl_ord_prc_amt_avg = 0 then -1 else d7_apl_ord_prc_amt_avg/d60_apl_ord_prc_amt_avg end as d7_d60_apl_ord_prc_amt_avg_rat
       ,case when d90_apl_ord_prc_amt_avg = 0 then -1 else d7_apl_ord_prc_amt_avg/d90_apl_ord_prc_amt_avg end as d7_d90_apl_ord_prc_amt_avg_rat
       ,case when d180_apl_ord_prc_amt_avg = 0 then -1 else d7_apl_ord_prc_amt_avg/d180_apl_ord_prc_amt_avg end as d7_d180_apl_ord_prc_amt_avg_rat
       ,case when d360_apl_ord_prc_amt_avg = 0 then -1 else d7_apl_ord_prc_amt_avg/d360_apl_ord_prc_amt_avg end as d7_d360_apl_ord_prc_amt_avg_rat
       
       ,case when d30_apl_ord_prc_amt_avg = 0 then -1 else d15_apl_ord_prc_amt_avg/d30_apl_ord_prc_amt_avg end as d15_d30_apl_ord_prc_amt_avg_rat
       ,case when d60_apl_ord_prc_amt_avg = 0 then -1 else d15_apl_ord_prc_amt_avg/d60_apl_ord_prc_amt_avg end as d15_d60_apl_ord_prc_amt_avg_rat
       ,case when d90_apl_ord_prc_amt_avg = 0 then -1 else d15_apl_ord_prc_amt_avg/d90_apl_ord_prc_amt_avg end as d15_d90_apl_ord_prc_amt_avg_rat
       ,case when d180_apl_ord_prc_amt_avg = 0 then -1 else d15_apl_ord_prc_amt_avg/d180_apl_ord_prc_amt_avg end as d15_d180_apl_ord_prc_amt_avg_rat
       ,case when d360_apl_ord_prc_amt_avg = 0 then -1 else d15_apl_ord_prc_amt_avg/d360_apl_ord_prc_amt_avg end as d15_d360_apl_ord_prc_amt_avg_rat
       ,case when d60_apl_ord_prc_amt_avg = 0 then -1 else d30_apl_ord_prc_amt_avg/d60_apl_ord_prc_amt_avg end as d30_d60_apl_ord_prc_amt_avg_rat
       ,case when d90_apl_ord_prc_amt_avg = 0 then -1 else d30_apl_ord_prc_amt_avg/d90_apl_ord_prc_amt_avg end as d30_d90_apl_ord_prc_amt_avg_rat
       ,case when d180_apl_ord_prc_amt_avg = 0 then -1 else d30_apl_ord_prc_amt_avg/d180_apl_ord_prc_amt_avg end as d30_d180_apl_ord_prc_amt_avg_rat
       ,case when d360_apl_ord_prc_amt_avg = 0 then -1 else d30_apl_ord_prc_amt_avg/d360_apl_ord_prc_amt_avg end as d30_d360_apl_ord_prc_amt_avg_rat
       ,case when d90_apl_ord_prc_amt_avg = 0 then -1 else d60_apl_ord_prc_amt_avg/d90_apl_ord_prc_amt_avg end as d60_d90_apl_ord_prc_amt_avg_rat
       ,case when d180_apl_ord_prc_amt_avg = 0 then -1 else d60_apl_ord_prc_amt_avg/d180_apl_ord_prc_amt_avg end as d60_d180_apl_ord_prc_amt_avg_rat
       ,case when d360_apl_ord_prc_amt_avg = 0 then -1 else d60_apl_ord_prc_amt_avg/d360_apl_ord_prc_amt_avg end as d60_d360_apl_ord_prc_amt_avg_rat
       ,case when d180_apl_ord_prc_amt_avg = 0 then -1 else d90_apl_ord_prc_amt_avg/d180_apl_ord_prc_amt_avg end as d90_d180_apl_ord_prc_amt_avg_rat
       ,case when d360_apl_ord_prc_amt_avg = 0 then -1 else d90_apl_ord_prc_amt_avg/d360_apl_ord_prc_amt_avg end as d90_d360_apl_ord_prc_amt_avg_rat
       ,case when d360_apl_ord_prc_amt_avg = 0 then -1 else d180_apl_ord_prc_amt_avg/d360_apl_ord_prc_amt_avg end as d180_d360_apl_ord_prc_amt_avg_rat
       --/*--------------成功订单---------------*/
       -- /*订单数*/ 
       ,case when d15_suc_ord_cnt = 0 then -1 else d7_suc_ord_cnt/d15_suc_ord_cnt end as d7_d15_suc_ord_cnt_rat
       ,case when d30_suc_ord_cnt = 0 then -1 else d7_suc_ord_cnt/d30_suc_ord_cnt end as d7_d30_suc_ord_cnt_rat
       ,case when d60_suc_ord_cnt = 0 then -1 else d7_suc_ord_cnt/d60_suc_ord_cnt end as d7_d60_suc_ord_cnt_rat
       ,case when d90_suc_ord_cnt = 0 then -1 else d7_suc_ord_cnt/d90_suc_ord_cnt end as d7_d90_suc_ord_cnt_rat
       ,case when d180_suc_ord_cnt = 0 then -1 else d7_suc_ord_cnt/d180_suc_ord_cnt end as d7_d180_suc_ord_cnt_rat
       ,case when d360_suc_ord_cnt = 0 then -1 else d7_suc_ord_cnt/d360_suc_ord_cnt end as d7_d360_suc_ord_cnt_rat
       
       ,case when d30_suc_ord_cnt = 0 then -1 else d15_suc_ord_cnt/d30_suc_ord_cnt end as d15_d30_suc_ord_cnt_rat
       ,case when d60_suc_ord_cnt = 0 then -1 else d15_suc_ord_cnt/d60_suc_ord_cnt end as d15_d60_suc_ord_cnt_rat
       ,case when d90_suc_ord_cnt = 0 then -1 else d15_suc_ord_cnt/d90_suc_ord_cnt end as d15_d90_suc_ord_cnt_rat
       ,case when d180_suc_ord_cnt = 0 then -1 else d15_suc_ord_cnt/d180_suc_ord_cnt end as d15_d180_suc_ord_cnt_rat
       ,case when d360_suc_ord_cnt = 0 then -1 else d15_suc_ord_cnt/d360_suc_ord_cnt end as d15_d360_suc_ord_cnt_rat
       ,case when d60_suc_ord_cnt = 0 then -1 else d30_suc_ord_cnt/d60_suc_ord_cnt end as d30_d60_suc_ord_cnt_rat
       ,case when d90_suc_ord_cnt = 0 then -1 else d30_suc_ord_cnt/d90_suc_ord_cnt end as d30_d90_suc_ord_cnt_rat
       ,case when d180_suc_ord_cnt = 0 then -1 else d30_suc_ord_cnt/d180_suc_ord_cnt end as d30_d180_suc_ord_cnt_rat
       ,case when d360_suc_ord_cnt = 0 then -1 else d30_suc_ord_cnt/d360_suc_ord_cnt end as d30_d360_suc_ord_cnt_rat
       ,case when d90_suc_ord_cnt = 0 then -1 else d60_suc_ord_cnt/d90_suc_ord_cnt end as d60_d90_suc_ord_cnt_rat
       ,case when d180_suc_ord_cnt = 0 then -1 else d60_suc_ord_cnt/d180_suc_ord_cnt end as d60_d180_suc_ord_cnt_rat
       ,case when d360_suc_ord_cnt = 0 then -1 else d60_suc_ord_cnt/d360_suc_ord_cnt end as d60_d360_suc_ord_cnt_rat
       ,case when d180_suc_ord_cnt = 0 then -1 else d90_suc_ord_cnt/d180_suc_ord_cnt end as d90_d180_suc_ord_cnt_rat
       ,case when d360_suc_ord_cnt = 0 then -1 else d90_suc_ord_cnt/d360_suc_ord_cnt end as d90_d360_suc_ord_cnt_rat
       ,case when d360_suc_ord_cnt = 0 then -1 else d180_suc_ord_cnt/d360_suc_ord_cnt end as d180_d360_suc_ord_cnt_rat
       -- /*订单金额*/
       ,case when d15_suc_ord_prc_amt_avg = 0 then -1 else d7_suc_ord_prc_amt_avg/d15_suc_ord_prc_amt_avg end as d7_d15_suc_ord_prc_amt_avg_rat
       ,case when d30_suc_ord_prc_amt_avg = 0 then -1 else d7_suc_ord_prc_amt_avg/d30_suc_ord_prc_amt_avg end as d7_d30_suc_ord_prc_amt_avg_rat
       ,case when d60_suc_ord_prc_amt_avg = 0 then -1 else d7_suc_ord_prc_amt_avg/d60_suc_ord_prc_amt_avg end as d7_d60_suc_ord_prc_amt_avg_rat
       ,case when d90_suc_ord_prc_amt_avg = 0 then -1 else d7_suc_ord_prc_amt_avg/d90_suc_ord_prc_amt_avg end as d7_d90_suc_ord_prc_amt_avg_rat
       ,case when d180_suc_ord_prc_amt_avg = 0 then -1 else d7_suc_ord_prc_amt_avg/d180_suc_ord_prc_amt_avg end as d7_d180_suc_ord_prc_amt_avg_rat
       ,case when d360_suc_ord_prc_amt_avg = 0 then -1 else d7_suc_ord_prc_amt_avg/d360_suc_ord_prc_amt_avg end as d7_d360_suc_ord_prc_amt_avg_rat
       
       ,case when d30_suc_ord_prc_amt_avg = 0 then -1 else d15_suc_ord_prc_amt_avg/d30_suc_ord_prc_amt_avg end as d15_d30_suc_ord_prc_amt_avg_rat
       ,case when d60_suc_ord_prc_amt_avg = 0 then -1 else d15_suc_ord_prc_amt_avg/d60_suc_ord_prc_amt_avg end as d15_d60_suc_ord_prc_amt_avg_rat
       ,case when d90_suc_ord_prc_amt_avg = 0 then -1 else d15_suc_ord_prc_amt_avg/d90_suc_ord_prc_amt_avg end as d15_d90_suc_ord_prc_amt_avg_rat
       ,case when d180_suc_ord_prc_amt_avg = 0 then -1 else d15_suc_ord_prc_amt_avg/d180_suc_ord_prc_amt_avg end as d15_d180_suc_ord_prc_amt_avg_rat
       ,case when d360_suc_ord_prc_amt_avg = 0 then -1 else d15_suc_ord_prc_amt_avg/d360_suc_ord_prc_amt_avg end as d15_d360_suc_ord_prc_amt_avg_rat
       ,case when d60_suc_ord_prc_amt_avg = 0 then -1 else d30_suc_ord_prc_amt_avg/d60_suc_ord_prc_amt_avg end as d30_d60_suc_ord_prc_amt_avg_rat
       ,case when d90_suc_ord_prc_amt_avg = 0 then -1 else d30_suc_ord_prc_amt_avg/d90_suc_ord_prc_amt_avg end as d30_d90_suc_ord_prc_amt_avg_rat
       ,case when d180_suc_ord_prc_amt_avg = 0 then -1 else d30_suc_ord_prc_amt_avg/d180_suc_ord_prc_amt_avg end as d30_d180_suc_ord_prc_amt_avg_rat
       ,case when d360_suc_ord_prc_amt_avg = 0 then -1 else d30_suc_ord_prc_amt_avg/d360_suc_ord_prc_amt_avg end as d30_d360_suc_ord_prc_amt_avg_rat
       ,case when d90_suc_ord_prc_amt_avg = 0 then -1 else d60_suc_ord_prc_amt_avg/d90_suc_ord_prc_amt_avg end as d60_d90_suc_ord_prc_amt_avg_rat
       ,case when d180_suc_ord_prc_amt_avg = 0 then -1 else d60_suc_ord_prc_amt_avg/d180_suc_ord_prc_amt_avg end as d60_d180_suc_ord_prc_amt_avg_rat
       ,case when d360_suc_ord_prc_amt_avg = 0 then -1 else d60_suc_ord_prc_amt_avg/d360_suc_ord_prc_amt_avg end as d60_d360_suc_ord_prc_amt_avg_rat
       ,case when d180_suc_ord_prc_amt_avg = 0 then -1 else d90_suc_ord_prc_amt_avg/d180_suc_ord_prc_amt_avg end as d90_d180_suc_ord_prc_amt_avg_rat
       ,case when d360_suc_ord_prc_amt_avg = 0 then -1 else d90_suc_ord_prc_amt_avg/d360_suc_ord_prc_amt_avg end as d90_d360_suc_ord_prc_amt_avg_rat
       ,case when d360_suc_ord_prc_amt_avg = 0 then -1 else d180_suc_ord_prc_amt_avg/d360_suc_ord_prc_amt_avg end as d180_d360_suc_ord_prc_amt_avg_rat
from ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp as a
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp1 as b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte
;

-----------------------------------------------------------
--------/*统计全部产品*/
----------------------------------------------------------- 
-- 发起订单
drop table if exists ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp3;
create table ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp3 as
select uid
    ,mdl_dte
    --/*--------------d7---------------*/
    -- /*产品类型*/
    ,count(distinct case when d7_flg = 1 then new_bsy_typ else null end) as d7_apl_ord_dis_bsy_typ_cnt_all
    ,count(distinct case when d7_flg = 1 then bsy_typ else null end) as d7_apl_ord_bsy_typ_cnt_all
    ,count(case when d7_flg = 1 then ord_no else null end) as d7_apl_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d7_bsy_typ_bt_cash_apl_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d7_bsy_typ_api_apl_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d7_bsy_typ_bl_apl_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d7_bsy_typ_ep_apl_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d7_flg = 1 then prc_amt else 0 end) as d7_apl_ord_prc_amt_sum_all
    ,max(case when d7_flg = 1 then prc_amt else 0 end) as d7_apl_ord_prc_amt_max_all
    ,min(case when d7_flg = 1 then prc_amt else 0 end) as d7_apl_ord_prc_amt_min_all
    ,avg(case when d7_flg = 1 then prc_amt else 0 end) as d7_apl_ord_prc_amt_avg_all
    ,sum(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_apl_ord_prc_amt_per_stg_sum_all
    ,max(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_apl_ord_prc_amt_per_stg_max_all
    ,min(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_apl_ord_prc_amt_per_stg_min_all
    ,avg(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_apl_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_sum_all
    ,max(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_max_all
    ,min(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_min_all
    ,avg(case when d7_flg = 1 then stg_num else null end) as d7_apl_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d7_flg = 1 then crt_dte else null end) as d7_apl_ord_days_cnt_all

    --/*--------------d15---------------*/
    -- /*产品类型*/
    ,count(distinct case when d15_flg = 1 then new_bsy_typ else null end) as d15_apl_ord_dis_bsy_typ_cnt_all
    ,count(distinct case when d15_flg = 1 then bsy_typ else null end) as d15_apl_ord_bsy_typ_cnt_all
    ,count(case when d15_flg = 1 then ord_no else null end) as d15_apl_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d15_bsy_typ_bt_cash_apl_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d15_bsy_typ_api_apl_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d15_bsy_typ_bl_apl_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d15_bsy_typ_ep_apl_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_sum_all
    ,max(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_max_all
    ,min(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_min_all
    ,avg(case when d15_flg = 1 then prc_amt else 0 end) as d15_apl_ord_prc_amt_avg_all
    ,sum(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_sum_all
    ,max(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_max_all
    ,min(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_min_all
    ,avg(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_apl_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_sum_all
    ,max(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_max_all
    ,min(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_min_all
    ,avg(case when d15_flg = 1 then stg_num else null end) as d15_apl_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d15_flg = 1 then crt_dte else null end) as d15_apl_ord_days_cnt_all

    --/*--------------d30---------------*/
    -- /*产品类型*/
    ,count(distinct case when d30_flg = 1 then new_bsy_typ else null end) as d30_apl_ord_dis_bsy_typ_cnt_all
    ,count(distinct case when d30_flg = 1 then bsy_typ else null end) as d30_apl_ord_bsy_typ_cnt_all
    ,count(case when d30_flg = 1 then ord_no else null end) as d30_apl_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d30_bsy_typ_bt_cash_apl_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d30_bsy_typ_api_apl_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d30_bsy_typ_bl_apl_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d30_bsy_typ_ep_apl_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_sum_all
    ,max(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_max_all
    ,min(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_min_all
    ,avg(case when d30_flg = 1 then prc_amt else 0 end) as d30_apl_ord_prc_amt_avg_all
    ,sum(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_sum_all
    ,max(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_max_all
    ,min(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_min_all
    ,avg(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_apl_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_sum_all
    ,max(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_max_all
    ,min(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_min_all
    ,avg(case when d30_flg = 1 then stg_num else null end) as d30_apl_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d30_flg = 1 then crt_dte else null end) as d30_apl_ord_days_cnt_all
    
    --/*--------------d60---------------*/
    -- /*产品类型*/
    ,count(distinct case when d60_flg = 1 then new_bsy_typ else null end) as d60_apl_ord_dis_bsy_typ_cnt_all
    ,count(distinct case when d60_flg = 1 then bsy_typ else null end) as d60_apl_ord_bsy_typ_cnt_all
    ,count(case when d60_flg = 1 then ord_no else null end) as d60_apl_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d60_bsy_typ_bt_cash_apl_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d60_bsy_typ_api_apl_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d60_bsy_typ_bl_apl_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d60_bsy_typ_ep_apl_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_sum_all
    ,max(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_max_all
    ,min(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_min_all
    ,avg(case when d60_flg = 1 then prc_amt else 0 end) as d60_apl_ord_prc_amt_avg_all
    ,sum(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_sum_all
    ,max(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_max_all
    ,min(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_min_all
    ,avg(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_apl_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_sum_all
    ,max(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_max_all
    ,min(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_min_all
    ,avg(case when d60_flg = 1 then stg_num else null end) as d60_apl_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d60_flg = 1 then crt_dte else null end) as d60_apl_ord_days_cnt_all

    --/*--------------d90---------------*/
    -- /*产品类型*/
    ,count(distinct case when d90_flg = 1 then new_bsy_typ else null end) as d90_apl_ord_dis_bsy_typ_cnt_all
    ,count(distinct case when d90_flg = 1 then bsy_typ else null end) as d90_apl_ord_bsy_typ_cnt_all
    ,count(case when d90_flg = 1 then ord_no else null end) as d90_apl_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d90_bsy_typ_bt_cash_apl_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d90_bsy_typ_api_apl_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d90_bsy_typ_bl_apl_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d90_bsy_typ_ep_apl_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_sum_all
    ,max(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_max_all
    ,min(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_min_all
    ,avg(case when d90_flg = 1 then prc_amt else 0 end) as d90_apl_ord_prc_amt_avg_all
    ,sum(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_sum_all
    ,max(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_max_all
    ,min(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_min_all
    ,avg(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_apl_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_sum_all
    ,max(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_max_all
    ,min(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_min_all
    ,avg(case when d90_flg = 1 then stg_num else null end) as d90_apl_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d90_flg = 1 then crt_dte else null end) as d90_apl_ord_days_cnt_all

    --/*--------------d180---------------*/
    -- /*产品类型*/
    ,count(distinct case when d180_flg = 1 then new_bsy_typ else null end) as d180_apl_ord_dis_bsy_typ_cnt_all
    ,count(distinct case when d180_flg = 1 then bsy_typ else null end) as d180_apl_ord_bsy_typ_cnt_all
    ,count(case when d180_flg = 1 then ord_no else null end) as d180_apl_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d180_bsy_typ_bt_cash_apl_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d180_bsy_typ_api_apl_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d180_bsy_typ_bl_apl_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d180_bsy_typ_ep_apl_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_sum_all
    ,max(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_max_all
    ,min(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_min_all
    ,avg(case when d180_flg = 1 then prc_amt else 0 end) as d180_apl_ord_prc_amt_avg_all
    ,sum(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_sum_all
    ,max(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_max_all
    ,min(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_min_all
    ,avg(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_apl_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_sum_all
    ,max(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_max_all
    ,min(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_min_all
    ,avg(case when d180_flg = 1 then stg_num else null end) as d180_apl_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d180_flg = 1 then crt_dte else null end) as d180_apl_ord_days_cnt_all

    --/*--------------d360---------------*/
    -- /*产品类型*/
    ,count(distinct case when d360_flg = 1 then new_bsy_typ else null end) as d360_apl_ord_dis_bsy_typ_cnt_all
    ,count(distinct case when d360_flg = 1 then bsy_typ else null end) as d360_apl_ord_bsy_typ_cnt_all
    ,count(case when d360_flg = 1 then ord_no else null end) as d360_apl_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d360_bsy_typ_bt_cash_apl_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d360_bsy_typ_api_apl_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d360_bsy_typ_bl_apl_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d360_bsy_typ_ep_apl_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_sum_all
    ,max(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_max_all
    ,min(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_min_all
    ,avg(case when d360_flg = 1 then prc_amt else 0 end) as d360_apl_ord_prc_amt_avg_all
    ,sum(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_sum_all
    ,max(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_max_all
    ,min(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_min_all
    ,avg(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_apl_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_sum_all
    ,max(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_max_all
    ,min(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_min_all
    ,avg(case when d360_flg = 1 then stg_num else null end) as d360_apl_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d360_flg = 1 then crt_dte else null end) as d360_apl_ord_days_cnt_all
from ${pdm_risk}.pdm_risk_f_heavy_order_info_detail_tmp
group by uid
    ,mdl_dte   
;


-- 成功订单
drop table if exists ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp4;
create table ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp4 as
select uid
    ,mdl_dte
    --/*--------------d7---------------*/
    -- /*产品类型*/
    ,count(distinct case when d7_flg = 1 then new_bsy_typ else null end) as d7_suc_ord_dis_bsy_typ_cnt_all
    ,count(case when d7_flg = 1 then new_bsy_typ else null end) as d7_suc_ord_bsy_typ_cnt_all
    ,count(case when d7_flg = 1 then ord_no else null end) as d7_suc_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d7_bsy_typ_bt_cash_suc_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d7_bsy_typ_api_suc_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d7_bsy_typ_bl_suc_ord_cnt_all
    ,sum(case when d7_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d7_bsy_typ_ep_suc_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d7_flg = 1 then prc_amt else 0 end) as d7_suc_ord_prc_amt_sum_all
    ,max(case when d7_flg = 1 then prc_amt else 0 end) as d7_suc_ord_prc_amt_max_all
    ,min(case when d7_flg = 1 then prc_amt else 0 end) as d7_suc_ord_prc_amt_min_all
    ,avg(case when d7_flg = 1 then prc_amt else 0 end) as d7_suc_ord_prc_amt_avg_all
    ,sum(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_suc_ord_prc_amt_per_stg_sum_all
    ,max(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_suc_ord_prc_amt_per_stg_max_all
    ,min(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_suc_ord_prc_amt_per_stg_min_all
    ,avg(case when d7_flg = 1 then prc_amt_per_stg else 0 end) as d7_suc_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_sum_all
    ,max(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_max_all
    ,min(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_min_all
    ,avg(case when d7_flg = 1 then stg_num else null end) as d7_suc_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d7_flg = 1 then crt_dte else null end) as d7_suc_ord_days_cnt_all

    --/*--------------d15---------------*/
    -- /*产品类型*/
    ,count(distinct case when d15_flg = 1 then new_bsy_typ else null end) as d15_suc_ord_dis_bsy_typ_cnt_all
    ,count(case when d15_flg = 1 then new_bsy_typ else null end) as d15_suc_ord_bsy_typ_cnt_all
    ,count(case when d15_flg = 1 then ord_no else null end) as d15_suc_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d15_bsy_typ_bt_cash_suc_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d15_bsy_typ_api_suc_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d15_bsy_typ_bl_suc_ord_cnt_all
    ,sum(case when d15_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d15_bsy_typ_ep_suc_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d15_flg = 1 then prc_amt else 0 end) as d15_suc_ord_prc_amt_sum_all
    ,max(case when d15_flg = 1 then prc_amt else 0 end) as d15_suc_ord_prc_amt_max_all
    ,min(case when d15_flg = 1 then prc_amt else 0 end) as d15_suc_ord_prc_amt_min_all
    ,avg(case when d15_flg = 1 then prc_amt else 0 end) as d15_suc_ord_prc_amt_avg_all
    ,sum(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_suc_ord_prc_amt_per_stg_sum_all
    ,max(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_suc_ord_prc_amt_per_stg_max_all
    ,min(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_suc_ord_prc_amt_per_stg_min_all
    ,avg(case when d15_flg = 1 then prc_amt_per_stg else 0 end) as d15_suc_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_sum_all
    ,max(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_max_all
    ,min(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_min_all
    ,avg(case when d15_flg = 1 then stg_num else null end) as d15_suc_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d15_flg = 1 then crt_dte else null end) as d15_suc_ord_days_cnt_all

    --/*--------------d30---------------*/
    -- /*产品类型*/
    ,count(distinct case when d30_flg = 1 then new_bsy_typ else null end) as d30_suc_ord_dis_bsy_typ_cnt_all
    ,count(case when d30_flg = 1 then new_bsy_typ else null end) as d30_suc_ord_bsy_typ_cnt_all
    ,count(case when d30_flg = 1 then ord_no else null end) as d30_suc_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d30_bsy_typ_bt_cash_suc_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d30_bsy_typ_api_suc_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d30_bsy_typ_bl_suc_ord_cnt_all
    ,sum(case when d30_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d30_bsy_typ_ep_suc_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d30_flg = 1 then prc_amt else 0 end) as d30_suc_ord_prc_amt_sum_all
    ,max(case when d30_flg = 1 then prc_amt else 0 end) as d30_suc_ord_prc_amt_max_all
    ,min(case when d30_flg = 1 then prc_amt else 0 end) as d30_suc_ord_prc_amt_min_all
    ,avg(case when d30_flg = 1 then prc_amt else 0 end) as d30_suc_ord_prc_amt_avg_all
    ,sum(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_suc_ord_prc_amt_per_stg_sum_all
    ,max(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_suc_ord_prc_amt_per_stg_max_all
    ,min(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_suc_ord_prc_amt_per_stg_min_all
    ,avg(case when d30_flg = 1 then prc_amt_per_stg else 0 end) as d30_suc_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_sum_all
    ,max(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_max_all
    ,min(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_min_all
    ,avg(case when d30_flg = 1 then stg_num else null end) as d30_suc_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d30_flg = 1 then crt_dte else null end) as d30_suc_ord_days_cnt_all
    
    --/*--------------d60---------------*/
    -- /*产品类型*/
    ,count(distinct case when d60_flg = 1 then new_bsy_typ else null end) as d60_suc_ord_dis_bsy_typ_cnt_all
    ,count(case when d60_flg = 1 then new_bsy_typ else null end) as d60_suc_ord_bsy_typ_cnt_all
    ,count(case when d60_flg = 1 then ord_no else null end) as d60_suc_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d60_bsy_typ_bt_cash_suc_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d60_bsy_typ_api_suc_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d60_bsy_typ_bl_suc_ord_cnt_all
    ,sum(case when d60_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d60_bsy_typ_ep_suc_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d60_flg = 1 then prc_amt else 0 end) as d60_suc_ord_prc_amt_sum_all
    ,max(case when d60_flg = 1 then prc_amt else 0 end) as d60_suc_ord_prc_amt_max_all
    ,min(case when d60_flg = 1 then prc_amt else 0 end) as d60_suc_ord_prc_amt_min_all
    ,avg(case when d60_flg = 1 then prc_amt else 0 end) as d60_suc_ord_prc_amt_avg_all
    ,sum(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_suc_ord_prc_amt_per_stg_sum_all
    ,max(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_suc_ord_prc_amt_per_stg_max_all
    ,min(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_suc_ord_prc_amt_per_stg_min_all
    ,avg(case when d60_flg = 1 then prc_amt_per_stg else 0 end) as d60_suc_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_sum_all
    ,max(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_max_all
    ,min(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_min_all
    ,avg(case when d60_flg = 1 then stg_num else null end) as d60_suc_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d60_flg = 1 then crt_dte else null end) as d60_suc_ord_days_cnt_all

    --/*--------------d90---------------*/
    -- /*产品类型*/
    ,count(distinct case when d90_flg = 1 then new_bsy_typ else null end) as d90_suc_ord_dis_bsy_typ_cnt_all
    ,count(case when d90_flg = 1 then new_bsy_typ else null end) as d90_suc_ord_bsy_typ_cnt_all
    ,count(case when d90_flg = 1 then ord_no else null end) as d90_suc_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d90_bsy_typ_bt_cash_suc_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d90_bsy_typ_api_suc_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d90_bsy_typ_bl_suc_ord_cnt_all
    ,sum(case when d90_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d90_bsy_typ_ep_suc_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d90_flg = 1 then prc_amt else 0 end) as d90_suc_ord_prc_amt_sum_all
    ,max(case when d90_flg = 1 then prc_amt else 0 end) as d90_suc_ord_prc_amt_max_all
    ,min(case when d90_flg = 1 then prc_amt else 0 end) as d90_suc_ord_prc_amt_min_all
    ,avg(case when d90_flg = 1 then prc_amt else 0 end) as d90_suc_ord_prc_amt_avg_all
    ,sum(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_suc_ord_prc_amt_per_stg_sum_all
    ,max(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_suc_ord_prc_amt_per_stg_max_all
    ,min(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_suc_ord_prc_amt_per_stg_min_all
    ,avg(case when d90_flg = 1 then prc_amt_per_stg else 0 end) as d90_suc_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_sum_all
    ,max(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_max_all
    ,min(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_min_all
    ,avg(case when d90_flg = 1 then stg_num else null end) as d90_suc_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d90_flg = 1 then crt_dte else null end) as d90_suc_ord_days_cnt_all

    --/*--------------d180---------------*/
    -- /*产品类型*/
    ,count(distinct case when d180_flg = 1 then new_bsy_typ else null end) as d180_suc_ord_dis_bsy_typ_cnt_all
    ,count(case when d180_flg = 1 then new_bsy_typ else null end) as d180_suc_ord_bsy_typ_cnt_all
    ,count(case when d180_flg = 1 then ord_no else null end) as d180_suc_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d180_bsy_typ_bt_cash_suc_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d180_bsy_typ_api_suc_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d180_bsy_typ_bl_suc_ord_cnt_all
    ,sum(case when d180_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d180_bsy_typ_ep_suc_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d180_flg = 1 then prc_amt else 0 end) as d180_suc_ord_prc_amt_sum_all
    ,max(case when d180_flg = 1 then prc_amt else 0 end) as d180_suc_ord_prc_amt_max_all
    ,min(case when d180_flg = 1 then prc_amt else 0 end) as d180_suc_ord_prc_amt_min_all
    ,avg(case when d180_flg = 1 then prc_amt else 0 end) as d180_suc_ord_prc_amt_avg_all
    ,sum(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_suc_ord_prc_amt_per_stg_sum_all
    ,max(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_suc_ord_prc_amt_per_stg_max_all
    ,min(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_suc_ord_prc_amt_per_stg_min_all
    ,avg(case when d180_flg = 1 then prc_amt_per_stg else 0 end) as d180_suc_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_sum_all
    ,max(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_max_all
    ,min(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_min_all
    ,avg(case when d180_flg = 1 then stg_num else null end) as d180_suc_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d180_flg = 1 then crt_dte else null end) as d180_suc_ord_days_cnt_all

    --/*--------------d360---------------*/
    -- /*产品类型*/
    ,count(distinct case when d360_flg = 1 then new_bsy_typ else null end) as d360_suc_ord_dis_bsy_typ_cnt_all
    ,count(case when d360_flg = 1 then new_bsy_typ else null end) as d360_suc_ord_bsy_typ_cnt_all
    ,count(case when d360_flg = 1 then ord_no else null end) as d360_suc_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'bt_cash' then 1 else 0 end) as d360_bsy_typ_bt_cash_suc_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'api' then 1 else 0 end) as d360_bsy_typ_api_suc_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'bl' then 1 else 0 end) as d360_bsy_typ_bl_suc_ord_cnt_all
    ,sum(case when d360_flg = 1 and new_bsy_typ = 'ep' then 1 else 0 end) as d360_bsy_typ_ep_suc_ord_cnt_all
    -- /*借款金额*/
    ,sum(case when d360_flg = 1 then prc_amt else 0 end) as d360_suc_ord_prc_amt_sum_all
    ,max(case when d360_flg = 1 then prc_amt else 0 end) as d360_suc_ord_prc_amt_max_all
    ,min(case when d360_flg = 1 then prc_amt else 0 end) as d360_suc_ord_prc_amt_min_all
    ,avg(case when d360_flg = 1 then prc_amt else 0 end) as d360_suc_ord_prc_amt_avg_all
    ,sum(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_suc_ord_prc_amt_per_stg_sum_all
    ,max(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_suc_ord_prc_amt_per_stg_max_all
    ,min(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_suc_ord_prc_amt_per_stg_min_all
    ,avg(case when d360_flg = 1 then prc_amt_per_stg else 0 end) as d360_suc_ord_prc_amt_per_stg_avg_all
    -- /*分期计划数*/
    ,sum(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_sum_all
    ,max(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_max_all
    ,min(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_min_all
    ,avg(case when d360_flg = 1 then stg_num else null end) as d360_suc_ord_stg_num_avg_all
    -- /*天数*/
    ,count(distinct case when d360_flg = 1 then crt_dte else null end) as d360_suc_ord_days_cnt_all
from ${pdm_risk}.pdm_risk_f_heavy_order_info_detail_tmp
where ord_stt_flg = 'success'
group by uid
    ,mdl_dte   
;



-- 趋势变化
drop table if exists ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp5;
create table ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp5 as 
select a.uid
       ,a.mdl_dte
       --/*--------------发起订单---------------*/
       -- /*订单数*/ 
       ,case when d15_apl_ord_cnt_all = 0 then -1 else d7_apl_ord_cnt_all/d15_apl_ord_cnt_all end as d7_d15_apl_ord_cnt_rat_all
       ,case when d30_apl_ord_cnt_all = 0 then -1 else d7_apl_ord_cnt_all/d30_apl_ord_cnt_all end as d7_d30_apl_ord_cnt_rat_all
       ,case when d60_apl_ord_cnt_all = 0 then -1 else d7_apl_ord_cnt_all/d60_apl_ord_cnt_all end as d7_d60_apl_ord_cnt_rat_all
       ,case when d90_apl_ord_cnt_all = 0 then -1 else d7_apl_ord_cnt_all/d90_apl_ord_cnt_all end as d7_d90_apl_ord_cnt_rat_all
       ,case when d180_apl_ord_cnt_all = 0 then -1 else d7_apl_ord_cnt_all/d180_apl_ord_cnt_all end as d7_d180_apl_ord_cnt_rat_all
       ,case when d360_apl_ord_cnt_all = 0 then -1 else d7_apl_ord_cnt_all/d360_apl_ord_cnt_all end as d7_d360_apl_ord_cnt_rat_all
       
       ,case when d30_apl_ord_cnt_all = 0 then -1 else d15_apl_ord_cnt_all/d30_apl_ord_cnt_all end as d15_d30_apl_ord_cnt_rat_all
       ,case when d60_apl_ord_cnt_all = 0 then -1 else d15_apl_ord_cnt_all/d60_apl_ord_cnt_all end as d15_d60_apl_ord_cnt_rat_all
       ,case when d90_apl_ord_cnt_all = 0 then -1 else d15_apl_ord_cnt_all/d90_apl_ord_cnt_all end as d15_d90_apl_ord_cnt_rat_all
       ,case when d180_apl_ord_cnt_all = 0 then -1 else d15_apl_ord_cnt_all/d180_apl_ord_cnt_all end as d15_d180_apl_ord_cnt_rat_all
       ,case when d360_apl_ord_cnt_all = 0 then -1 else d15_apl_ord_cnt_all/d360_apl_ord_cnt_all end as d15_d360_apl_ord_cnt_rat_all
       ,case when d60_apl_ord_cnt_all = 0 then -1 else d30_apl_ord_cnt_all/d60_apl_ord_cnt_all end as d30_d60_apl_ord_cnt_rat_all
       ,case when d90_apl_ord_cnt_all = 0 then -1 else d30_apl_ord_cnt_all/d90_apl_ord_cnt_all end as d30_d90_apl_ord_cnt_rat_all
       ,case when d180_apl_ord_cnt_all = 0 then -1 else d30_apl_ord_cnt_all/d180_apl_ord_cnt_all end as d30_d180_apl_ord_cnt_rat_all
       ,case when d360_apl_ord_cnt_all = 0 then -1 else d30_apl_ord_cnt_all/d360_apl_ord_cnt_all end as d30_d360_apl_ord_cnt_rat_all
       ,case when d90_apl_ord_cnt_all = 0 then -1 else d60_apl_ord_cnt_all/d90_apl_ord_cnt_all end as d60_d90_apl_ord_cnt_rat_all
       ,case when d180_apl_ord_cnt_all = 0 then -1 else d60_apl_ord_cnt_all/d180_apl_ord_cnt_all end as d60_d180_apl_ord_cnt_rat_all
       ,case when d360_apl_ord_cnt_all = 0 then -1 else d60_apl_ord_cnt_all/d360_apl_ord_cnt_all end as d60_d360_apl_ord_cnt_rat_all
       ,case when d180_apl_ord_cnt_all = 0 then -1 else d90_apl_ord_cnt_all/d180_apl_ord_cnt_all end as d90_d180_apl_ord_cnt_rat_all
       ,case when d360_apl_ord_cnt_all = 0 then -1 else d90_apl_ord_cnt_all/d360_apl_ord_cnt_all end as d90_d360_apl_ord_cnt_rat_all
       ,case when d360_apl_ord_cnt_all = 0 then -1 else d180_apl_ord_cnt_all/d360_apl_ord_cnt_all end as d180_d360_apl_ord_cnt_rat_all
       -- /*订单金额*/
       ,case when d15_apl_ord_prc_amt_avg_all = 0 then -1 else d7_apl_ord_prc_amt_avg_all/d15_apl_ord_prc_amt_avg_all end as d7_d15_apl_ord_prc_amt_avg_rat_all
       ,case when d30_apl_ord_prc_amt_avg_all = 0 then -1 else d7_apl_ord_prc_amt_avg_all/d30_apl_ord_prc_amt_avg_all end as d7_d30_apl_ord_prc_amt_avg_rat_all
       ,case when d60_apl_ord_prc_amt_avg_all = 0 then -1 else d7_apl_ord_prc_amt_avg_all/d60_apl_ord_prc_amt_avg_all end as d7_d60_apl_ord_prc_amt_avg_rat_all
       ,case when d90_apl_ord_prc_amt_avg_all = 0 then -1 else d7_apl_ord_prc_amt_avg_all/d90_apl_ord_prc_amt_avg_all end as d7_d90_apl_ord_prc_amt_avg_rat_all
       ,case when d180_apl_ord_prc_amt_avg_all = 0 then -1 else d7_apl_ord_prc_amt_avg_all/d180_apl_ord_prc_amt_avg_all end as d7_d180_apl_ord_prc_amt_avg_rat_all
       ,case when d360_apl_ord_prc_amt_avg_all = 0 then -1 else d7_apl_ord_prc_amt_avg_all/d360_apl_ord_prc_amt_avg_all end as d7_d360_apl_ord_prc_amt_avg_rat_all
       
       ,case when d30_apl_ord_prc_amt_avg_all = 0 then -1 else d15_apl_ord_prc_amt_avg_all/d30_apl_ord_prc_amt_avg_all end as d15_d30_apl_ord_prc_amt_avg_rat_all
       ,case when d60_apl_ord_prc_amt_avg_all = 0 then -1 else d15_apl_ord_prc_amt_avg_all/d60_apl_ord_prc_amt_avg_all end as d15_d60_apl_ord_prc_amt_avg_rat_all
       ,case when d90_apl_ord_prc_amt_avg_all = 0 then -1 else d15_apl_ord_prc_amt_avg_all/d90_apl_ord_prc_amt_avg_all end as d15_d90_apl_ord_prc_amt_avg_rat_all
       ,case when d180_apl_ord_prc_amt_avg_all = 0 then -1 else d15_apl_ord_prc_amt_avg_all/d180_apl_ord_prc_amt_avg_all end as d15_d180_apl_ord_prc_amt_avg_rat_all
       ,case when d360_apl_ord_prc_amt_avg_all = 0 then -1 else d15_apl_ord_prc_amt_avg_all/d360_apl_ord_prc_amt_avg_all end as d15_d360_apl_ord_prc_amt_avg_rat_all
       ,case when d60_apl_ord_prc_amt_avg_all = 0 then -1 else d30_apl_ord_prc_amt_avg_all/d60_apl_ord_prc_amt_avg_all end as d30_d60_apl_ord_prc_amt_avg_rat_all
       ,case when d90_apl_ord_prc_amt_avg_all = 0 then -1 else d30_apl_ord_prc_amt_avg_all/d90_apl_ord_prc_amt_avg_all end as d30_d90_apl_ord_prc_amt_avg_rat_all
       ,case when d180_apl_ord_prc_amt_avg_all = 0 then -1 else d30_apl_ord_prc_amt_avg_all/d180_apl_ord_prc_amt_avg_all end as d30_d180_apl_ord_prc_amt_avg_rat_all
       ,case when d360_apl_ord_prc_amt_avg_all = 0 then -1 else d30_apl_ord_prc_amt_avg_all/d360_apl_ord_prc_amt_avg_all end as d30_d360_apl_ord_prc_amt_avg_rat_all
       ,case when d90_apl_ord_prc_amt_avg_all = 0 then -1 else d60_apl_ord_prc_amt_avg_all/d90_apl_ord_prc_amt_avg_all end as d60_d90_apl_ord_prc_amt_avg_rat_all
       ,case when d180_apl_ord_prc_amt_avg_all = 0 then -1 else d60_apl_ord_prc_amt_avg_all/d180_apl_ord_prc_amt_avg_all end as d60_d180_apl_ord_prc_amt_avg_rat_all
       ,case when d360_apl_ord_prc_amt_avg_all = 0 then -1 else d60_apl_ord_prc_amt_avg_all/d360_apl_ord_prc_amt_avg_all end as d60_d360_apl_ord_prc_amt_avg_rat_all
       ,case when d180_apl_ord_prc_amt_avg_all = 0 then -1 else d90_apl_ord_prc_amt_avg_all/d180_apl_ord_prc_amt_avg_all end as d90_d180_apl_ord_prc_amt_avg_rat_all
       ,case when d360_apl_ord_prc_amt_avg_all = 0 then -1 else d90_apl_ord_prc_amt_avg_all/d360_apl_ord_prc_amt_avg_all end as d90_d360_apl_ord_prc_amt_avg_rat_all
       ,case when d360_apl_ord_prc_amt_avg_all = 0 then -1 else d180_apl_ord_prc_amt_avg_all/d360_apl_ord_prc_amt_avg_all end as d180_d360_apl_ord_prc_amt_avg_rat_all
       
       --/*--------------成功订单---------------*/
       -- /*订单数*/ 
       ,case when d15_suc_ord_cnt_all = 0 then -1 else d7_suc_ord_cnt_all/d15_suc_ord_cnt_all end as d7_d15_suc_ord_cnt_rat_all
       ,case when d30_suc_ord_cnt_all = 0 then -1 else d7_suc_ord_cnt_all/d30_suc_ord_cnt_all end as d7_d30_suc_ord_cnt_rat_all
       ,case when d60_suc_ord_cnt_all = 0 then -1 else d7_suc_ord_cnt_all/d60_suc_ord_cnt_all end as d7_d60_suc_ord_cnt_rat_all
       ,case when d90_suc_ord_cnt_all = 0 then -1 else d7_suc_ord_cnt_all/d90_suc_ord_cnt_all end as d7_d90_suc_ord_cnt_rat_all
       ,case when d180_suc_ord_cnt_all = 0 then -1 else d7_suc_ord_cnt_all/d180_suc_ord_cnt_all end as d7_d180_suc_ord_cnt_rat_all
       ,case when d360_suc_ord_cnt_all = 0 then -1 else d7_suc_ord_cnt_all/d360_suc_ord_cnt_all end as d7_d360_suc_ord_cnt_rat_all
       
       ,case when d30_suc_ord_cnt_all = 0 then -1 else d15_suc_ord_cnt_all/d30_suc_ord_cnt_all end as d15_d30_suc_ord_cnt_rat_all
       ,case when d60_suc_ord_cnt_all = 0 then -1 else d15_suc_ord_cnt_all/d60_suc_ord_cnt_all end as d15_d60_suc_ord_cnt_rat_all
       ,case when d90_suc_ord_cnt_all = 0 then -1 else d15_suc_ord_cnt_all/d90_suc_ord_cnt_all end as d15_d90_suc_ord_cnt_rat_all
       ,case when d180_suc_ord_cnt_all = 0 then -1 else d15_suc_ord_cnt_all/d180_suc_ord_cnt_all end as d15_d180_suc_ord_cnt_rat_all
       ,case when d360_suc_ord_cnt_all = 0 then -1 else d15_suc_ord_cnt_all/d360_suc_ord_cnt_all end as d15_d360_suc_ord_cnt_rat_all
       ,case when d60_suc_ord_cnt_all = 0 then -1 else d30_suc_ord_cnt_all/d60_suc_ord_cnt_all end as d30_d60_suc_ord_cnt_rat_all
       ,case when d90_suc_ord_cnt_all = 0 then -1 else d30_suc_ord_cnt_all/d90_suc_ord_cnt_all end as d30_d90_suc_ord_cnt_rat_all
       ,case when d180_suc_ord_cnt_all = 0 then -1 else d30_suc_ord_cnt_all/d180_suc_ord_cnt_all end as d30_d180_suc_ord_cnt_rat_all
       ,case when d360_suc_ord_cnt_all = 0 then -1 else d30_suc_ord_cnt_all/d360_suc_ord_cnt_all end as d30_d360_suc_ord_cnt_rat_all
       ,case when d90_suc_ord_cnt_all = 0 then -1 else d60_suc_ord_cnt_all/d90_suc_ord_cnt_all end as d60_d90_suc_ord_cnt_rat_all
       ,case when d180_suc_ord_cnt_all = 0 then -1 else d60_suc_ord_cnt_all/d180_suc_ord_cnt_all end as d60_d180_suc_ord_cnt_rat_all
       ,case when d360_suc_ord_cnt_all = 0 then -1 else d60_suc_ord_cnt_all/d360_suc_ord_cnt_all end as d60_d360_suc_ord_cnt_rat_all
       ,case when d180_suc_ord_cnt_all = 0 then -1 else d90_suc_ord_cnt_all/d180_suc_ord_cnt_all end as d90_d180_suc_ord_cnt_rat_all
       ,case when d360_suc_ord_cnt_all = 0 then -1 else d90_suc_ord_cnt_all/d360_suc_ord_cnt_all end as d90_d360_suc_ord_cnt_rat_all
       ,case when d360_suc_ord_cnt_all = 0 then -1 else d180_suc_ord_cnt_all/d360_suc_ord_cnt_all end as d180_d360_suc_ord_cnt_rat_all
       -- /*订单金额*/
       ,case when d15_suc_ord_prc_amt_avg_all = 0 then -1 else d7_suc_ord_prc_amt_avg_all/d15_suc_ord_prc_amt_avg_all end as d7_d15_suc_ord_prc_amt_avg_rat_all
       ,case when d30_suc_ord_prc_amt_avg_all = 0 then -1 else d7_suc_ord_prc_amt_avg_all/d30_suc_ord_prc_amt_avg_all end as d7_d30_suc_ord_prc_amt_avg_rat_all
       ,case when d60_suc_ord_prc_amt_avg_all = 0 then -1 else d7_suc_ord_prc_amt_avg_all/d60_suc_ord_prc_amt_avg_all end as d7_d60_suc_ord_prc_amt_avg_rat_all
       ,case when d90_suc_ord_prc_amt_avg_all = 0 then -1 else d7_suc_ord_prc_amt_avg_all/d90_suc_ord_prc_amt_avg_all end as d7_d90_suc_ord_prc_amt_avg_rat_all
       ,case when d180_suc_ord_prc_amt_avg_all = 0 then -1 else d7_suc_ord_prc_amt_avg_all/d180_suc_ord_prc_amt_avg_all end as d7_d180_suc_ord_prc_amt_avg_rat_all
       ,case when d360_suc_ord_prc_amt_avg_all = 0 then -1 else d7_suc_ord_prc_amt_avg_all/d360_suc_ord_prc_amt_avg_all end as d7_d360_suc_ord_prc_amt_avg_rat_all
       
       ,case when d30_suc_ord_prc_amt_avg_all = 0 then -1 else d15_suc_ord_prc_amt_avg_all/d30_suc_ord_prc_amt_avg_all end as d15_d30_suc_ord_prc_amt_avg_rat_all
       ,case when d60_suc_ord_prc_amt_avg_all = 0 then -1 else d15_suc_ord_prc_amt_avg_all/d60_suc_ord_prc_amt_avg_all end as d15_d60_suc_ord_prc_amt_avg_rat_all
       ,case when d90_suc_ord_prc_amt_avg_all = 0 then -1 else d15_suc_ord_prc_amt_avg_all/d90_suc_ord_prc_amt_avg_all end as d15_d90_suc_ord_prc_amt_avg_rat_all
       ,case when d180_suc_ord_prc_amt_avg_all = 0 then -1 else d15_suc_ord_prc_amt_avg_all/d180_suc_ord_prc_amt_avg_all end as d15_d180_suc_ord_prc_amt_avg_rat_all
       ,case when d360_suc_ord_prc_amt_avg_all = 0 then -1 else d15_suc_ord_prc_amt_avg_all/d360_suc_ord_prc_amt_avg_all end as d15_d360_suc_ord_prc_amt_avg_rat_all
       ,case when d60_suc_ord_prc_amt_avg_all = 0 then -1 else d30_suc_ord_prc_amt_avg_all/d60_suc_ord_prc_amt_avg_all end as d30_d60_suc_ord_prc_amt_avg_rat_all
       ,case when d90_suc_ord_prc_amt_avg_all = 0 then -1 else d30_suc_ord_prc_amt_avg_all/d90_suc_ord_prc_amt_avg_all end as d30_d90_suc_ord_prc_amt_avg_rat_all
       ,case when d180_suc_ord_prc_amt_avg_all = 0 then -1 else d30_suc_ord_prc_amt_avg_all/d180_suc_ord_prc_amt_avg_all end as d30_d180_suc_ord_prc_amt_avg_rat_all
       ,case when d360_suc_ord_prc_amt_avg_all = 0 then -1 else d30_suc_ord_prc_amt_avg_all/d360_suc_ord_prc_amt_avg_all end as d30_d360_suc_ord_prc_amt_avg_rat_all
       ,case when d90_suc_ord_prc_amt_avg_all = 0 then -1 else d60_suc_ord_prc_amt_avg_all/d90_suc_ord_prc_amt_avg_all end as d60_d90_suc_ord_prc_amt_avg_rat_all
       ,case when d180_suc_ord_prc_amt_avg_all = 0 then -1 else d60_suc_ord_prc_amt_avg_all/d180_suc_ord_prc_amt_avg_all end as d60_d180_suc_ord_prc_amt_avg_rat_all
       ,case when d360_suc_ord_prc_amt_avg_all = 0 then -1 else d60_suc_ord_prc_amt_avg_all/d360_suc_ord_prc_amt_avg_all end as d60_d360_suc_ord_prc_amt_avg_rat_all
       ,case when d180_suc_ord_prc_amt_avg_all = 0 then -1 else d90_suc_ord_prc_amt_avg_all/d180_suc_ord_prc_amt_avg_all end as d90_d180_suc_ord_prc_amt_avg_rat_all
       ,case when d360_suc_ord_prc_amt_avg_all = 0 then -1 else d90_suc_ord_prc_amt_avg_all/d360_suc_ord_prc_amt_avg_all end as d90_d360_suc_ord_prc_amt_avg_rat_all
       ,case when d360_suc_ord_prc_amt_avg_all = 0 then -1 else d180_suc_ord_prc_amt_avg_all/d360_suc_ord_prc_amt_avg_all end as d180_d360_suc_ord_prc_amt_avg_rat_all
from ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp3 as a
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp4 as b
on a.uid = b.uid and a.mdl_dte = b.mdl_dte
;


set odps.stage.mapper.split.size=20; 

insert overwrite table ${pdm_risk}.pdm_risk_dz_model_final_order_info_df partition(ds = '${bizdate}')
select main_table.uid,
       main_table.mdl_dte,

       d7_apl_ord_cnt, d7_apl_ord_prc_amt_sum, d7_apl_ord_prc_amt_max , d7_apl_ord_prc_amt_min, d7_apl_ord_prc_amt_avg, d7_apl_ord_prc_amt_per_stg_sum, d7_apl_ord_prc_amt_per_stg_max, d7_apl_ord_prc_amt_per_stg_min , d7_apl_ord_prc_amt_per_stg_avg, d7_apl_ord_days_cnt, d7_apl_ord_ddf_mdl_ord_crt_dte_max, d7_apl_ord_ddf_mdl_ord_crt_dte_min, d7_apl_ord_stg_num_sum , d7_apl_ord_stg_num_max, d7_apl_ord_stg_num_min, d7_apl_ord_stg_num_avg, d7_prc_amt_mor_3_000_apl_ord_cnt, d7_prc_amt_mor_5_000_apl_ord_cnt , d7_prc_amt_mor_10_000_apl_ord_cnt, d7_prc_amt_mor_20_000_apl_ord_cnt, d7_prc_amt_mor_50_000_apl_ord_cnt, d15_apl_ord_cnt, d15_apl_ord_prc_amt_sum , d15_apl_ord_prc_amt_max, d15_apl_ord_prc_amt_min, d15_apl_ord_prc_amt_avg, d15_apl_ord_prc_amt_per_stg_sum, d15_apl_ord_prc_amt_per_stg_max , d15_apl_ord_prc_amt_per_stg_min, d15_apl_ord_prc_amt_per_stg_avg, d15_apl_ord_days_cnt, d15_apl_ord_ddf_mdl_ord_crt_dte_max, d15_apl_ord_ddf_mdl_ord_crt_dte_min , d15_apl_ord_stg_num_sum, d15_apl_ord_stg_num_max, d15_apl_ord_stg_num_min, d15_apl_ord_stg_num_avg, d15_prc_amt_mor_3_000_apl_ord_cnt , d15_prc_amt_mor_5_000_apl_ord_cnt, d15_prc_amt_mor_10_000_apl_ord_cnt, d15_prc_amt_mor_20_000_apl_ord_cnt, d15_prc_amt_mor_50_000_apl_ord_cnt, d30_apl_ord_cnt , d30_apl_ord_prc_amt_sum, d30_apl_ord_prc_amt_max, d30_apl_ord_prc_amt_min, d30_apl_ord_prc_amt_avg, d30_apl_ord_prc_amt_per_stg_sum , d30_apl_ord_prc_amt_per_stg_max, d30_apl_ord_prc_amt_per_stg_min, d30_apl_ord_prc_amt_per_stg_avg, d30_apl_ord_days_cnt, d30_apl_ord_ddf_mdl_ord_crt_dte_max , d30_apl_ord_ddf_mdl_ord_crt_dte_min, d30_apl_ord_stg_num_sum, d30_apl_ord_stg_num_max, d30_apl_ord_stg_num_min, d30_apl_ord_stg_num_avg , d30_prc_amt_mor_3_000_apl_ord_cnt, d30_prc_amt_mor_5_000_apl_ord_cnt, d30_prc_amt_mor_10_000_apl_ord_cnt, d30_prc_amt_mor_20_000_apl_ord_cnt, d30_prc_amt_mor_50_000_apl_ord_cnt , d60_apl_ord_cnt, d60_apl_ord_prc_amt_sum, d60_apl_ord_prc_amt_max, d60_apl_ord_prc_amt_min, d60_apl_ord_prc_amt_avg , d60_apl_ord_prc_amt_per_stg_sum, d60_apl_ord_prc_amt_per_stg_max, d60_apl_ord_prc_amt_per_stg_min, d60_apl_ord_prc_amt_per_stg_avg, d60_apl_ord_days_cnt , d60_apl_ord_ddf_mdl_ord_crt_dte_max, d60_apl_ord_ddf_mdl_ord_crt_dte_min, d60_apl_ord_stg_num_sum, d60_apl_ord_stg_num_max, d60_apl_ord_stg_num_min , d60_apl_ord_stg_num_avg, d60_prc_amt_mor_3_000_apl_ord_cnt, d60_prc_amt_mor_5_000_apl_ord_cnt, d60_prc_amt_mor_10_000_apl_ord_cnt, d60_prc_amt_mor_20_000_apl_ord_cnt , d60_prc_amt_mor_50_000_apl_ord_cnt, d90_apl_ord_cnt, d90_apl_ord_prc_amt_sum, d90_apl_ord_prc_amt_max, d90_apl_ord_prc_amt_min , d90_apl_ord_prc_amt_avg, d90_apl_ord_prc_amt_per_stg_sum, d90_apl_ord_prc_amt_per_stg_max, d90_apl_ord_prc_amt_per_stg_min, d90_apl_ord_prc_amt_per_stg_avg , d90_apl_ord_days_cnt, d90_apl_ord_ddf_mdl_ord_crt_dte_max, d90_apl_ord_ddf_mdl_ord_crt_dte_min, d90_apl_ord_stg_num_sum, d90_apl_ord_stg_num_max , d90_apl_ord_stg_num_min, d90_apl_ord_stg_num_avg, d90_prc_amt_mor_3_000_apl_ord_cnt, d90_prc_amt_mor_5_000_apl_ord_cnt, d90_prc_amt_mor_10_000_apl_ord_cnt , d90_prc_amt_mor_20_000_apl_ord_cnt, d90_prc_amt_mor_50_000_apl_ord_cnt, d180_apl_ord_cnt, d180_apl_ord_prc_amt_sum, d180_apl_ord_prc_amt_max , d180_apl_ord_prc_amt_min, d180_apl_ord_prc_amt_avg, d180_apl_ord_prc_amt_per_stg_sum, d180_apl_ord_prc_amt_per_stg_max, d180_apl_ord_prc_amt_per_stg_min , d180_apl_ord_prc_amt_per_stg_avg, d180_apl_ord_days_cnt, d180_apl_ord_ddf_mdl_ord_crt_dte_max, d180_apl_ord_ddf_mdl_ord_crt_dte_min, d180_apl_ord_stg_num_sum , d180_apl_ord_stg_num_max, d180_apl_ord_stg_num_min, d180_apl_ord_stg_num_avg, d180_prc_amt_mor_3_000_apl_ord_cnt, d180_prc_amt_mor_5_000_apl_ord_cnt , d180_prc_amt_mor_10_000_apl_ord_cnt, d180_prc_amt_mor_20_000_apl_ord_cnt, d180_prc_amt_mor_50_000_apl_ord_cnt, d360_apl_ord_cnt, d360_apl_ord_prc_amt_sum , d360_apl_ord_prc_amt_max, d360_apl_ord_prc_amt_min, d360_apl_ord_prc_amt_avg, d360_apl_ord_prc_amt_per_stg_sum, d360_apl_ord_prc_amt_per_stg_max , d360_apl_ord_prc_amt_per_stg_min, d360_apl_ord_prc_amt_per_stg_avg, d360_apl_ord_days_cnt, d360_apl_ord_ddf_mdl_ord_crt_dte_max, d360_apl_ord_ddf_mdl_ord_crt_dte_min , d360_apl_ord_stg_num_sum, d360_apl_ord_stg_num_max, d360_apl_ord_stg_num_min, d360_apl_ord_stg_num_avg, d360_prc_amt_mor_3_000_apl_ord_cnt , d360_prc_amt_mor_5_000_apl_ord_cnt, d360_prc_amt_mor_10_000_apl_ord_cnt, d360_prc_amt_mor_20_000_apl_ord_cnt, d360_prc_amt_mor_50_000_apl_ord_cnt,

d7_suc_ord_cnt, d7_suc_ord_prc_amt_sum, d7_suc_ord_prc_amt_max , d7_suc_ord_prc_amt_min, d7_suc_ord_prc_amt_avg, d7_suc_ord_prc_amt_per_stg_sum, d7_suc_ord_prc_amt_per_stg_max, d7_suc_ord_prc_amt_per_stg_min , d7_suc_ord_prc_amt_per_stg_avg, d7_suc_ord_days_cnt, d7_suc_ord_ddf_mdl_ord_crt_dte_max, d7_suc_ord_ddf_mdl_ord_crt_dte_min, d7_suc_ord_stg_num_sum , d7_suc_ord_stg_num_max, d7_suc_ord_stg_num_min, d7_suc_ord_stg_num_avg, d7_prc_amt_mor_3_000_suc_ord_cnt, d7_prc_amt_mor_5_000_suc_ord_cnt , d7_prc_amt_mor_10_000_suc_ord_cnt, d7_prc_amt_mor_20_000_suc_ord_cnt, d7_prc_amt_mor_50_000_suc_ord_cnt, d15_suc_ord_cnt, d15_suc_ord_prc_amt_sum , d15_suc_ord_prc_amt_max, d15_suc_ord_prc_amt_min, d15_suc_ord_prc_amt_avg, d15_suc_ord_prc_amt_per_stg_sum, d15_suc_ord_prc_amt_per_stg_max , d15_suc_ord_prc_amt_per_stg_min, d15_suc_ord_prc_amt_per_stg_avg, d15_suc_ord_days_cnt, d15_suc_ord_ddf_mdl_ord_crt_dte_max, d15_suc_ord_ddf_mdl_ord_crt_dte_min , d15_suc_ord_stg_num_sum, d15_suc_ord_stg_num_max, d15_suc_ord_stg_num_min, d15_suc_ord_stg_num_avg, d15_prc_amt_mor_3_000_suc_ord_cnt , d15_prc_amt_mor_5_000_suc_ord_cnt, d15_prc_amt_mor_10_000_suc_ord_cnt, d15_prc_amt_mor_20_000_suc_ord_cnt, d15_prc_amt_mor_50_000_suc_ord_cnt, d30_suc_ord_cnt , d30_suc_ord_prc_amt_sum, d30_suc_ord_prc_amt_max, d30_suc_ord_prc_amt_min, d30_suc_ord_prc_amt_avg, d30_suc_ord_prc_amt_per_stg_sum , d30_suc_ord_prc_amt_per_stg_max, d30_suc_ord_prc_amt_per_stg_min, d30_suc_ord_prc_amt_per_stg_avg, d30_suc_ord_days_cnt, d30_suc_ord_ddf_mdl_ord_crt_dte_max , d30_suc_ord_ddf_mdl_ord_crt_dte_min, d30_suc_ord_stg_num_sum, d30_suc_ord_stg_num_max, d30_suc_ord_stg_num_min, d30_suc_ord_stg_num_avg , d30_prc_amt_mor_3_000_suc_ord_cnt, d30_prc_amt_mor_5_000_suc_ord_cnt, d30_prc_amt_mor_10_000_suc_ord_cnt, d30_prc_amt_mor_20_000_suc_ord_cnt, d30_prc_amt_mor_50_000_suc_ord_cnt , d60_suc_ord_cnt, d60_suc_ord_prc_amt_sum, d60_suc_ord_prc_amt_max, d60_suc_ord_prc_amt_min, d60_suc_ord_prc_amt_avg , d60_suc_ord_prc_amt_per_stg_sum, d60_suc_ord_prc_amt_per_stg_max, d60_suc_ord_prc_amt_per_stg_min, d60_suc_ord_prc_amt_per_stg_avg, d60_suc_ord_days_cnt , d60_suc_ord_ddf_mdl_ord_crt_dte_max, d60_suc_ord_ddf_mdl_ord_crt_dte_min, d60_suc_ord_stg_num_sum, d60_suc_ord_stg_num_max, d60_suc_ord_stg_num_min , d60_suc_ord_stg_num_avg, d60_prc_amt_mor_3_000_suc_ord_cnt, d60_prc_amt_mor_5_000_suc_ord_cnt, d60_prc_amt_mor_10_000_suc_ord_cnt, d60_prc_amt_mor_20_000_suc_ord_cnt , d60_prc_amt_mor_50_000_suc_ord_cnt, d90_suc_ord_cnt, d90_suc_ord_prc_amt_sum, d90_suc_ord_prc_amt_max, d90_suc_ord_prc_amt_min , d90_suc_ord_prc_amt_avg, d90_suc_ord_prc_amt_per_stg_sum, d90_suc_ord_prc_amt_per_stg_max, d90_suc_ord_prc_amt_per_stg_min, d90_suc_ord_prc_amt_per_stg_avg , d90_suc_ord_days_cnt, d90_suc_ord_ddf_mdl_ord_crt_dte_max, d90_suc_ord_ddf_mdl_ord_crt_dte_min, d90_suc_ord_stg_num_sum, d90_suc_ord_stg_num_max , d90_suc_ord_stg_num_min, d90_suc_ord_stg_num_avg, d90_prc_amt_mor_3_000_suc_ord_cnt, d90_prc_amt_mor_5_000_suc_ord_cnt, d90_prc_amt_mor_10_000_suc_ord_cnt , d90_prc_amt_mor_20_000_suc_ord_cnt, d90_prc_amt_mor_50_000_suc_ord_cnt, d180_suc_ord_cnt, d180_suc_ord_prc_amt_sum, d180_suc_ord_prc_amt_max , d180_suc_ord_prc_amt_min, d180_suc_ord_prc_amt_avg, d180_suc_ord_prc_amt_per_stg_sum, d180_suc_ord_prc_amt_per_stg_max, d180_suc_ord_prc_amt_per_stg_min , d180_suc_ord_prc_amt_per_stg_avg, d180_suc_ord_days_cnt, d180_suc_ord_ddf_mdl_ord_crt_dte_max, d180_suc_ord_ddf_mdl_ord_crt_dte_min, d180_suc_ord_stg_num_sum , d180_suc_ord_stg_num_max, d180_suc_ord_stg_num_min, d180_suc_ord_stg_num_avg, d180_prc_amt_mor_3_000_suc_ord_cnt, d180_prc_amt_mor_5_000_suc_ord_cnt , d180_prc_amt_mor_10_000_suc_ord_cnt, d180_prc_amt_mor_20_000_suc_ord_cnt, d180_prc_amt_mor_50_000_suc_ord_cnt, d360_suc_ord_cnt, d360_suc_ord_prc_amt_sum , d360_suc_ord_prc_amt_max, d360_suc_ord_prc_amt_min, d360_suc_ord_prc_amt_avg, d360_suc_ord_prc_amt_per_stg_sum, d360_suc_ord_prc_amt_per_stg_max , d360_suc_ord_prc_amt_per_stg_min, d360_suc_ord_prc_amt_per_stg_avg, d360_suc_ord_days_cnt, d360_suc_ord_ddf_mdl_ord_crt_dte_max, d360_suc_ord_ddf_mdl_ord_crt_dte_min , d360_suc_ord_stg_num_sum, d360_suc_ord_stg_num_max, d360_suc_ord_stg_num_min, d360_suc_ord_stg_num_avg, d360_prc_amt_mor_3_000_suc_ord_cnt , d360_prc_amt_mor_5_000_suc_ord_cnt, d360_prc_amt_mor_10_000_suc_ord_cnt, d360_prc_amt_mor_20_000_suc_ord_cnt, d360_prc_amt_mor_50_000_suc_ord_cnt,

d7_d15_apl_ord_cnt_rat, d7_d30_apl_ord_cnt_rat, d7_d60_apl_ord_cnt_rat , d7_d90_apl_ord_cnt_rat, d7_d180_apl_ord_cnt_rat, d7_d360_apl_ord_cnt_rat, d15_d30_apl_ord_cnt_rat, d15_d60_apl_ord_cnt_rat , d15_d90_apl_ord_cnt_rat, d15_d180_apl_ord_cnt_rat, d15_d360_apl_ord_cnt_rat, d30_d60_apl_ord_cnt_rat, d30_d90_apl_ord_cnt_rat , d30_d180_apl_ord_cnt_rat, d30_d360_apl_ord_cnt_rat, d60_d90_apl_ord_cnt_rat, d60_d180_apl_ord_cnt_rat, d60_d360_apl_ord_cnt_rat , d90_d180_apl_ord_cnt_rat, d90_d360_apl_ord_cnt_rat, d180_d360_apl_ord_cnt_rat, d7_d15_apl_ord_prc_amt_avg_rat, d7_d30_apl_ord_prc_amt_avg_rat , d7_d60_apl_ord_prc_amt_avg_rat, d7_d90_apl_ord_prc_amt_avg_rat, d7_d180_apl_ord_prc_amt_avg_rat, d7_d360_apl_ord_prc_amt_avg_rat, d15_d30_apl_ord_prc_amt_avg_rat , d15_d60_apl_ord_prc_amt_avg_rat, d15_d90_apl_ord_prc_amt_avg_rat, d15_d180_apl_ord_prc_amt_avg_rat, d15_d360_apl_ord_prc_amt_avg_rat, d30_d60_apl_ord_prc_amt_avg_rat , d30_d90_apl_ord_prc_amt_avg_rat, d30_d180_apl_ord_prc_amt_avg_rat, d30_d360_apl_ord_prc_amt_avg_rat, d60_d90_apl_ord_prc_amt_avg_rat, d60_d180_apl_ord_prc_amt_avg_rat , d60_d360_apl_ord_prc_amt_avg_rat, d90_d180_apl_ord_prc_amt_avg_rat, d90_d360_apl_ord_prc_amt_avg_rat, d180_d360_apl_ord_prc_amt_avg_rat, d7_d15_suc_ord_cnt_rat , d7_d30_suc_ord_cnt_rat, d7_d60_suc_ord_cnt_rat, d7_d90_suc_ord_cnt_rat, d7_d180_suc_ord_cnt_rat, d7_d360_suc_ord_cnt_rat , d15_d30_suc_ord_cnt_rat, d15_d60_suc_ord_cnt_rat, d15_d90_suc_ord_cnt_rat, d15_d180_suc_ord_cnt_rat, d15_d360_suc_ord_cnt_rat , d30_d60_suc_ord_cnt_rat, d30_d90_suc_ord_cnt_rat, d30_d180_suc_ord_cnt_rat, d30_d360_suc_ord_cnt_rat, d60_d90_suc_ord_cnt_rat , d60_d180_suc_ord_cnt_rat, d60_d360_suc_ord_cnt_rat, d90_d180_suc_ord_cnt_rat, d90_d360_suc_ord_cnt_rat, d180_d360_suc_ord_cnt_rat , d7_d15_suc_ord_prc_amt_avg_rat, d7_d30_suc_ord_prc_amt_avg_rat, d7_d60_suc_ord_prc_amt_avg_rat, d7_d90_suc_ord_prc_amt_avg_rat, d7_d180_suc_ord_prc_amt_avg_rat , d7_d360_suc_ord_prc_amt_avg_rat, d15_d30_suc_ord_prc_amt_avg_rat, d15_d60_suc_ord_prc_amt_avg_rat, d15_d90_suc_ord_prc_amt_avg_rat, d15_d180_suc_ord_prc_amt_avg_rat , d15_d360_suc_ord_prc_amt_avg_rat, d30_d60_suc_ord_prc_amt_avg_rat, d30_d90_suc_ord_prc_amt_avg_rat, d30_d180_suc_ord_prc_amt_avg_rat, d30_d360_suc_ord_prc_amt_avg_rat , d60_d90_suc_ord_prc_amt_avg_rat, d60_d180_suc_ord_prc_amt_avg_rat, d60_d360_suc_ord_prc_amt_avg_rat, d90_d180_suc_ord_prc_amt_avg_rat, d90_d360_suc_ord_prc_amt_avg_rat , d180_d360_suc_ord_prc_amt_avg_rat,

d7_apl_ord_dis_bsy_typ_cnt_all, d7_apl_ord_bsy_typ_cnt_all, d7_apl_ord_cnt_all , d7_bsy_typ_bt_cash_apl_ord_cnt_all, d7_bsy_typ_api_apl_ord_cnt_all, d7_bsy_typ_bl_apl_ord_cnt_all, d7_bsy_typ_ep_apl_ord_cnt_all, d7_apl_ord_prc_amt_sum_all , d7_apl_ord_prc_amt_max_all, d7_apl_ord_prc_amt_min_all, d7_apl_ord_prc_amt_avg_all, d7_apl_ord_prc_amt_per_stg_sum_all, d7_apl_ord_prc_amt_per_stg_max_all , d7_apl_ord_prc_amt_per_stg_min_all, d7_apl_ord_prc_amt_per_stg_avg_all, d7_apl_ord_stg_num_sum_all, d7_apl_ord_stg_num_max_all, d7_apl_ord_stg_num_min_all , d7_apl_ord_stg_num_avg_all, d7_apl_ord_days_cnt_all, d15_apl_ord_dis_bsy_typ_cnt_all, d15_apl_ord_bsy_typ_cnt_all, d15_apl_ord_cnt_all , d15_bsy_typ_bt_cash_apl_ord_cnt_all, d15_bsy_typ_api_apl_ord_cnt_all, d15_bsy_typ_bl_apl_ord_cnt_all, d15_bsy_typ_ep_apl_ord_cnt_all, d15_apl_ord_prc_amt_sum_all , d15_apl_ord_prc_amt_max_all, d15_apl_ord_prc_amt_min_all, d15_apl_ord_prc_amt_avg_all, d15_apl_ord_prc_amt_per_stg_sum_all, d15_apl_ord_prc_amt_per_stg_max_all , d15_apl_ord_prc_amt_per_stg_min_all, d15_apl_ord_prc_amt_per_stg_avg_all, d15_apl_ord_stg_num_sum_all, d15_apl_ord_stg_num_max_all, d15_apl_ord_stg_num_min_all , d15_apl_ord_stg_num_avg_all, d15_apl_ord_days_cnt_all, d30_apl_ord_dis_bsy_typ_cnt_all, d30_apl_ord_bsy_typ_cnt_all, d30_apl_ord_cnt_all , d30_bsy_typ_bt_cash_apl_ord_cnt_all, d30_bsy_typ_api_apl_ord_cnt_all, d30_bsy_typ_bl_apl_ord_cnt_all, d30_bsy_typ_ep_apl_ord_cnt_all, d30_apl_ord_prc_amt_sum_all , d30_apl_ord_prc_amt_max_all, d30_apl_ord_prc_amt_min_all, d30_apl_ord_prc_amt_avg_all, d30_apl_ord_prc_amt_per_stg_sum_all, d30_apl_ord_prc_amt_per_stg_max_all , d30_apl_ord_prc_amt_per_stg_min_all, d30_apl_ord_prc_amt_per_stg_avg_all, d30_apl_ord_stg_num_sum_all, d30_apl_ord_stg_num_max_all, d30_apl_ord_stg_num_min_all , d30_apl_ord_stg_num_avg_all, d30_apl_ord_days_cnt_all, d60_apl_ord_dis_bsy_typ_cnt_all, d60_apl_ord_bsy_typ_cnt_all, d60_apl_ord_cnt_all , d60_bsy_typ_bt_cash_apl_ord_cnt_all, d60_bsy_typ_api_apl_ord_cnt_all, d60_bsy_typ_bl_apl_ord_cnt_all, d60_bsy_typ_ep_apl_ord_cnt_all, d60_apl_ord_prc_amt_sum_all , d60_apl_ord_prc_amt_max_all, d60_apl_ord_prc_amt_min_all, d60_apl_ord_prc_amt_avg_all, d60_apl_ord_prc_amt_per_stg_sum_all, d60_apl_ord_prc_amt_per_stg_max_all , d60_apl_ord_prc_amt_per_stg_min_all, d60_apl_ord_prc_amt_per_stg_avg_all, d60_apl_ord_stg_num_sum_all, d60_apl_ord_stg_num_max_all, d60_apl_ord_stg_num_min_all , d60_apl_ord_stg_num_avg_all, d60_apl_ord_days_cnt_all, d90_apl_ord_dis_bsy_typ_cnt_all, d90_apl_ord_bsy_typ_cnt_all, d90_apl_ord_cnt_all , d90_bsy_typ_bt_cash_apl_ord_cnt_all, d90_bsy_typ_api_apl_ord_cnt_all, d90_bsy_typ_bl_apl_ord_cnt_all, d90_bsy_typ_ep_apl_ord_cnt_all, d90_apl_ord_prc_amt_sum_all , d90_apl_ord_prc_amt_max_all, d90_apl_ord_prc_amt_min_all, d90_apl_ord_prc_amt_avg_all, d90_apl_ord_prc_amt_per_stg_sum_all, d90_apl_ord_prc_amt_per_stg_max_all , d90_apl_ord_prc_amt_per_stg_min_all, d90_apl_ord_prc_amt_per_stg_avg_all, d90_apl_ord_stg_num_sum_all, d90_apl_ord_stg_num_max_all, d90_apl_ord_stg_num_min_all , d90_apl_ord_stg_num_avg_all, d90_apl_ord_days_cnt_all, d180_apl_ord_dis_bsy_typ_cnt_all, d180_apl_ord_bsy_typ_cnt_all, d180_apl_ord_cnt_all , d180_bsy_typ_bt_cash_apl_ord_cnt_all, d180_bsy_typ_api_apl_ord_cnt_all, d180_bsy_typ_bl_apl_ord_cnt_all, d180_bsy_typ_ep_apl_ord_cnt_all, d180_apl_ord_prc_amt_sum_all , d180_apl_ord_prc_amt_max_all, d180_apl_ord_prc_amt_min_all, d180_apl_ord_prc_amt_avg_all, d180_apl_ord_prc_amt_per_stg_sum_all, d180_apl_ord_prc_amt_per_stg_max_all , d180_apl_ord_prc_amt_per_stg_min_all, d180_apl_ord_prc_amt_per_stg_avg_all, d180_apl_ord_stg_num_sum_all, d180_apl_ord_stg_num_max_all, d180_apl_ord_stg_num_min_all , d180_apl_ord_stg_num_avg_all, d180_apl_ord_days_cnt_all, d360_apl_ord_dis_bsy_typ_cnt_all, d360_apl_ord_bsy_typ_cnt_all, d360_apl_ord_cnt_all , d360_bsy_typ_bt_cash_apl_ord_cnt_all, d360_bsy_typ_api_apl_ord_cnt_all, d360_bsy_typ_bl_apl_ord_cnt_all, d360_bsy_typ_ep_apl_ord_cnt_all, d360_apl_ord_prc_amt_sum_all , d360_apl_ord_prc_amt_max_all, d360_apl_ord_prc_amt_min_all, d360_apl_ord_prc_amt_avg_all, d360_apl_ord_prc_amt_per_stg_sum_all, d360_apl_ord_prc_amt_per_stg_max_all , d360_apl_ord_prc_amt_per_stg_min_all, d360_apl_ord_prc_amt_per_stg_avg_all, d360_apl_ord_stg_num_sum_all, d360_apl_ord_stg_num_max_all, d360_apl_ord_stg_num_min_all , d360_apl_ord_stg_num_avg_all, d360_apl_ord_days_cnt_all,

d7_suc_ord_dis_bsy_typ_cnt_all, d7_suc_ord_bsy_typ_cnt_all, d7_suc_ord_cnt_all , d7_bsy_typ_bt_cash_suc_ord_cnt_all, d7_bsy_typ_api_suc_ord_cnt_all, d7_bsy_typ_bl_suc_ord_cnt_all, d7_bsy_typ_ep_suc_ord_cnt_all, d7_suc_ord_prc_amt_sum_all , d7_suc_ord_prc_amt_max_all, d7_suc_ord_prc_amt_min_all, d7_suc_ord_prc_amt_avg_all, d7_suc_ord_prc_amt_per_stg_sum_all, d7_suc_ord_prc_amt_per_stg_max_all , d7_suc_ord_prc_amt_per_stg_min_all, d7_suc_ord_prc_amt_per_stg_avg_all, d7_suc_ord_stg_num_sum_all, d7_suc_ord_stg_num_max_all, d7_suc_ord_stg_num_min_all , d7_suc_ord_stg_num_avg_all, d7_suc_ord_days_cnt_all, d15_suc_ord_dis_bsy_typ_cnt_all, d15_suc_ord_bsy_typ_cnt_all, d15_suc_ord_cnt_all , d15_bsy_typ_bt_cash_suc_ord_cnt_all, d15_bsy_typ_api_suc_ord_cnt_all, d15_bsy_typ_bl_suc_ord_cnt_all, d15_bsy_typ_ep_suc_ord_cnt_all, d15_suc_ord_prc_amt_sum_all , d15_suc_ord_prc_amt_max_all, d15_suc_ord_prc_amt_min_all, d15_suc_ord_prc_amt_avg_all, d15_suc_ord_prc_amt_per_stg_sum_all, d15_suc_ord_prc_amt_per_stg_max_all , d15_suc_ord_prc_amt_per_stg_min_all, d15_suc_ord_prc_amt_per_stg_avg_all, d15_suc_ord_stg_num_sum_all, d15_suc_ord_stg_num_max_all, d15_suc_ord_stg_num_min_all , d15_suc_ord_stg_num_avg_all, d15_suc_ord_days_cnt_all, d30_suc_ord_dis_bsy_typ_cnt_all, d30_suc_ord_bsy_typ_cnt_all, d30_suc_ord_cnt_all , d30_bsy_typ_bt_cash_suc_ord_cnt_all, d30_bsy_typ_api_suc_ord_cnt_all, d30_bsy_typ_bl_suc_ord_cnt_all, d30_bsy_typ_ep_suc_ord_cnt_all, d30_suc_ord_prc_amt_sum_all , d30_suc_ord_prc_amt_max_all, d30_suc_ord_prc_amt_min_all, d30_suc_ord_prc_amt_avg_all, d30_suc_ord_prc_amt_per_stg_sum_all, d30_suc_ord_prc_amt_per_stg_max_all , d30_suc_ord_prc_amt_per_stg_min_all, d30_suc_ord_prc_amt_per_stg_avg_all, d30_suc_ord_stg_num_sum_all, d30_suc_ord_stg_num_max_all, d30_suc_ord_stg_num_min_all , d30_suc_ord_stg_num_avg_all, d30_suc_ord_days_cnt_all, d60_suc_ord_dis_bsy_typ_cnt_all, d60_suc_ord_bsy_typ_cnt_all, d60_suc_ord_cnt_all , d60_bsy_typ_bt_cash_suc_ord_cnt_all, d60_bsy_typ_api_suc_ord_cnt_all, d60_bsy_typ_bl_suc_ord_cnt_all, d60_bsy_typ_ep_suc_ord_cnt_all, d60_suc_ord_prc_amt_sum_all , d60_suc_ord_prc_amt_max_all, d60_suc_ord_prc_amt_min_all, d60_suc_ord_prc_amt_avg_all, d60_suc_ord_prc_amt_per_stg_sum_all, d60_suc_ord_prc_amt_per_stg_max_all , d60_suc_ord_prc_amt_per_stg_min_all, d60_suc_ord_prc_amt_per_stg_avg_all, d60_suc_ord_stg_num_sum_all, d60_suc_ord_stg_num_max_all, d60_suc_ord_stg_num_min_all , d60_suc_ord_stg_num_avg_all, d60_suc_ord_days_cnt_all, d90_suc_ord_dis_bsy_typ_cnt_all, d90_suc_ord_bsy_typ_cnt_all, d90_suc_ord_cnt_all , d90_bsy_typ_bt_cash_suc_ord_cnt_all, d90_bsy_typ_api_suc_ord_cnt_all, d90_bsy_typ_bl_suc_ord_cnt_all, d90_bsy_typ_ep_suc_ord_cnt_all, d90_suc_ord_prc_amt_sum_all , d90_suc_ord_prc_amt_max_all, d90_suc_ord_prc_amt_min_all, d90_suc_ord_prc_amt_avg_all, d90_suc_ord_prc_amt_per_stg_sum_all, d90_suc_ord_prc_amt_per_stg_max_all , d90_suc_ord_prc_amt_per_stg_min_all, d90_suc_ord_prc_amt_per_stg_avg_all, d90_suc_ord_stg_num_sum_all, d90_suc_ord_stg_num_max_all, d90_suc_ord_stg_num_min_all , d90_suc_ord_stg_num_avg_all, d90_suc_ord_days_cnt_all, d180_suc_ord_dis_bsy_typ_cnt_all, d180_suc_ord_bsy_typ_cnt_all, d180_suc_ord_cnt_all , d180_bsy_typ_bt_cash_suc_ord_cnt_all, d180_bsy_typ_api_suc_ord_cnt_all, d180_bsy_typ_bl_suc_ord_cnt_all, d180_bsy_typ_ep_suc_ord_cnt_all, d180_suc_ord_prc_amt_sum_all , d180_suc_ord_prc_amt_max_all, d180_suc_ord_prc_amt_min_all, d180_suc_ord_prc_amt_avg_all, d180_suc_ord_prc_amt_per_stg_sum_all, d180_suc_ord_prc_amt_per_stg_max_all , d180_suc_ord_prc_amt_per_stg_min_all, d180_suc_ord_prc_amt_per_stg_avg_all, d180_suc_ord_stg_num_sum_all, d180_suc_ord_stg_num_max_all, d180_suc_ord_stg_num_min_all , d180_suc_ord_stg_num_avg_all, d180_suc_ord_days_cnt_all, d360_suc_ord_dis_bsy_typ_cnt_all, d360_suc_ord_bsy_typ_cnt_all, d360_suc_ord_cnt_all , d360_bsy_typ_bt_cash_suc_ord_cnt_all, d360_bsy_typ_api_suc_ord_cnt_all, d360_bsy_typ_bl_suc_ord_cnt_all, d360_bsy_typ_ep_suc_ord_cnt_all, d360_suc_ord_prc_amt_sum_all , d360_suc_ord_prc_amt_max_all, d360_suc_ord_prc_amt_min_all, d360_suc_ord_prc_amt_avg_all, d360_suc_ord_prc_amt_per_stg_sum_all, d360_suc_ord_prc_amt_per_stg_max_all , d360_suc_ord_prc_amt_per_stg_min_all, d360_suc_ord_prc_amt_per_stg_avg_all, d360_suc_ord_stg_num_sum_all, d360_suc_ord_stg_num_max_all, d360_suc_ord_stg_num_min_all , d360_suc_ord_stg_num_avg_all, d360_suc_ord_days_cnt_all,

d7_d15_apl_ord_cnt_rat_all, d7_d30_apl_ord_cnt_rat_all, d7_d60_apl_ord_cnt_rat_all , d7_d90_apl_ord_cnt_rat_all, d7_d180_apl_ord_cnt_rat_all, d7_d360_apl_ord_cnt_rat_all, d15_d30_apl_ord_cnt_rat_all, d15_d60_apl_ord_cnt_rat_all , d15_d90_apl_ord_cnt_rat_all, d15_d180_apl_ord_cnt_rat_all, d15_d360_apl_ord_cnt_rat_all, d30_d60_apl_ord_cnt_rat_all, d30_d90_apl_ord_cnt_rat_all , d30_d180_apl_ord_cnt_rat_all, d30_d360_apl_ord_cnt_rat_all, d60_d90_apl_ord_cnt_rat_all, d60_d180_apl_ord_cnt_rat_all, d60_d360_apl_ord_cnt_rat_all , d90_d180_apl_ord_cnt_rat_all, d90_d360_apl_ord_cnt_rat_all, d180_d360_apl_ord_cnt_rat_all, d7_d15_apl_ord_prc_amt_avg_rat_all, d7_d30_apl_ord_prc_amt_avg_rat_all , d7_d60_apl_ord_prc_amt_avg_rat_all, d7_d90_apl_ord_prc_amt_avg_rat_all, d7_d180_apl_ord_prc_amt_avg_rat_all, d7_d360_apl_ord_prc_amt_avg_rat_all, d15_d30_apl_ord_prc_amt_avg_rat_all , d15_d60_apl_ord_prc_amt_avg_rat_all, d15_d90_apl_ord_prc_amt_avg_rat_all, d15_d180_apl_ord_prc_amt_avg_rat_all, d15_d360_apl_ord_prc_amt_avg_rat_all, d30_d60_apl_ord_prc_amt_avg_rat_all , d30_d90_apl_ord_prc_amt_avg_rat_all, d30_d180_apl_ord_prc_amt_avg_rat_all, d30_d360_apl_ord_prc_amt_avg_rat_all, d60_d90_apl_ord_prc_amt_avg_rat_all, d60_d180_apl_ord_prc_amt_avg_rat_all , d60_d360_apl_ord_prc_amt_avg_rat_all, d90_d180_apl_ord_prc_amt_avg_rat_all, d90_d360_apl_ord_prc_amt_avg_rat_all, d180_d360_apl_ord_prc_amt_avg_rat_all, d7_d15_suc_ord_cnt_rat_all , d7_d30_suc_ord_cnt_rat_all, d7_d60_suc_ord_cnt_rat_all, d7_d90_suc_ord_cnt_rat_all, d7_d180_suc_ord_cnt_rat_all, d7_d360_suc_ord_cnt_rat_all , d15_d30_suc_ord_cnt_rat_all, d15_d60_suc_ord_cnt_rat_all, d15_d90_suc_ord_cnt_rat_all, d15_d180_suc_ord_cnt_rat_all, d15_d360_suc_ord_cnt_rat_all , d30_d60_suc_ord_cnt_rat_all, d30_d90_suc_ord_cnt_rat_all, d30_d180_suc_ord_cnt_rat_all, d30_d360_suc_ord_cnt_rat_all, d60_d90_suc_ord_cnt_rat_all , d60_d180_suc_ord_cnt_rat_all, d60_d360_suc_ord_cnt_rat_all, d90_d180_suc_ord_cnt_rat_all, d90_d360_suc_ord_cnt_rat_all, d180_d360_suc_ord_cnt_rat_all , d7_d15_suc_ord_prc_amt_avg_rat_all, d7_d30_suc_ord_prc_amt_avg_rat_all, d7_d60_suc_ord_prc_amt_avg_rat_all, d7_d90_suc_ord_prc_amt_avg_rat_all, d7_d180_suc_ord_prc_amt_avg_rat_all , d7_d360_suc_ord_prc_amt_avg_rat_all, d15_d30_suc_ord_prc_amt_avg_rat_all, d15_d60_suc_ord_prc_amt_avg_rat_all, d15_d90_suc_ord_prc_amt_avg_rat_all, d15_d180_suc_ord_prc_amt_avg_rat_all , d15_d360_suc_ord_prc_amt_avg_rat_all, d30_d60_suc_ord_prc_amt_avg_rat_all, d30_d90_suc_ord_prc_amt_avg_rat_all, d30_d180_suc_ord_prc_amt_avg_rat_all, d30_d360_suc_ord_prc_amt_avg_rat_all , d60_d90_suc_ord_prc_amt_avg_rat_all, d60_d180_suc_ord_prc_amt_avg_rat_all, d60_d360_suc_ord_prc_amt_avg_rat_all, d90_d180_suc_ord_prc_amt_avg_rat_all, d90_d360_suc_ord_prc_amt_avg_rat_all , d180_d360_suc_ord_prc_amt_avg_rat_all

from 
(
        select uid
                ,date_add(date(to_date(ds,'yyyymmdd')),1) as mdl_dte
        from dwt.dwt_heavy_order_df
        where ds = '${bizdate}'
        and loan_success_flag = 1  
        group by uid,ds
) as main_table
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp as t1
on main_table.uid = t1.uid and main_table.mdl_dte = t1.mdl_dte 
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp1 as t2
on main_table.uid = t2.uid and main_table.mdl_dte = t2.mdl_dte
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp2 as t3
on main_table.uid = t3.uid and main_table.mdl_dte = t3.mdl_dte
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp3 as t4
on main_table.uid = t4.uid and main_table.mdl_dte = t4.mdl_dte
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp4 as t5
on main_table.uid = t5.uid and main_table.mdl_dte = t5.mdl_dte
left join ${pdm_risk}.pdm_risk_dz_model_final_order_info_df_tmp5 as t6
on main_table.uid = t6.uid and main_table.mdl_dte = t6.mdl_dte
where t4.uid is not null
;
-- feature-copilot:node-end ordinal=0
