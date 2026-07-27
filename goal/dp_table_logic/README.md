# pdm_risk 上游表建表逻辑汇总

- **项目空间**: pdm_risk
- **表数量**: 31
- **生成时间**: 2026-07-16

## 文件说明

每个 `{table_name}.sql` 包含该表的 DDL/DML 与文件头元数据；文件头记录任务、负责人和直接上游表，支持同一表保留多个任务节点。

```sql
-- feature-copilot:node-begin ordinal=0
-- table_name: <table_name>
-- node_id: ...
-- task_name: ...
-- owner_name: ...
-- upstream_table: db.table1

CREATE TABLE / INSERT OVERWRITE ...;
-- feature-copilot:node-end ordinal=0
```

## 表清单

| 序号 | 表名 | 任务数 | 文件大小 | 上游表数 |
|---|---|---|---|---|
| 1 | `pdm_risk_applist_exists_category_di_v3` | 1 | 166.0 KB | 9 |
| 2 | `pdm_risk_applist_feature_newfeature_di_v3` | 1 | 27.8 KB | 7 |
| 3 | `pdm_risk_common_appname_onehot` | 1 | 121.8 KB | 1 |
| 4 | `pdm_risk_dh_model_15ai_call_record` | 2 | 43.8 KB | 10 |
| 5 | `pdm_risk_dh_model_final_13collection_call_info_di` | 1 | 17.3 KB | 5 |
| 6 | `pdm_risk_dh_model_final_13collection_call_info_trend_features_di` | 2 | 121.6 KB | 4 |
| 7 | `pdm_risk_dh_model_final_13collection_notes_di` | 1 | 26.2 KB | 5 |
| 8 | `pdm_risk_dh_model_final_13collection_notes_trend_features` | 2 | 269.7 KB | 4 |
| 9 | `pdm_risk_dh_model_final_telemarket_call_info_features_di` | 2 | 33.2 KB | 13 |
| 10 | `pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 1 | 555.8 KB | 7 |
| 11 | `pdm_risk_dz_br_horizontal_multi_report_feature_sequential_rct_12mon_lst_final_di` | 1 | 429.9 KB | 6 |
| 12 | `pdm_risk_dz_br_horizontal_multi_report_feature_sequential_rct_12tme_final_di` | 1 | 404.1 KB | 6 |
| 13 | `pdm_risk_dz_br_horizontal_two_report_feature_final_di` | 1 | 375.5 KB | 7 |
| 14 | `pdm_risk_dz_br_max_multi_report_feature_final_di` | 1 | 198.3 KB | 7 |
| 15 | `pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di` | 1 | 157.3 KB | 6 |
| 16 | `pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di` | 1 | 146.1 KB | 6 |
| 17 | `pdm_risk_dz_br_max_two_report_feature_final_di` | 1 | 136.8 KB | 7 |
| 18 | `pdm_risk_dz_daily_br_horizontal_trend_feature_v3_di` | 1 | 129.7 KB | 1 |
| 19 | `pdm_risk_dz_daily_br_max_feature` | 1 | 195.2 KB | 1 |
| 20 | `pdm_risk_dz_daily_br_trend_feature` | 1 | 143.9 KB | 2 |
| 21 | `pdm_risk_dz_daily_br_trend_feature_v2` | 1 | 118.9 KB | 2 |
| 22 | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di` | 1 | 167.3 KB | 5 |
| 23 | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 1 | 67.6 KB | 11 |
| 24 | `pdm_risk_dz_model_daily_dcp_trade_feature_info1_df` | 1 | 191.9 KB | 2 |
| 25 | `pdm_risk_dz_model_daily_dcp_trade_feature_info2_df` | 1 | 186.5 KB | 2 |
| 26 | `pdm_risk_dz_model_daily_dcp_trade_feature_info3_df` | 1 | 188.8 KB | 2 |
| 27 | `pdm_risk_dz_model_daily_dcp_trade_feature_info4_df` | 1 | 188.7 KB | 2 |
| 28 | `pdm_risk_dz_model_daily_dcp_trade_feature_info5_df` | 1 | 196.2 KB | 2 |
| 29 | `pdm_risk_dz_model_daily_dcp_trade_feature_info6_df` | 1 | 187.2 KB | 2 |
| 30 | `pdm_risk_dz_model_daily_dcp_trade_feature_info7_df` | 1 | 160.4 KB | 2 |
| 31 | `pdm_risk_dz_model_final_order_info_df` | 1 | 205.3 KB | 9 |

## 上游表明细

### pdm_risk_applist_exists_category_di_v3

- **任务**: `pdm_risk_applist_exists_category_di_v3`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_applist_v3_exists_cate_tmp02`, `pdm_risk.pdm_risk_applist_v3_exists_cate_tmp03`, `pdm_risk.pdm_risk_applist_v3_exists_cate_tmp05`, `pdm_risk.pdm_risk_applist_v3_exists_cate_tmp0501`, `pdm_risk.pdm_risk_applist_v3_exists_cate_tmp06`, `pdm_risk.pdm_risk_applist_v3_exists_cate_tmp04`, `pdw_manual.pdw_manual_applist_category_202303_v3`, `ods_pdw_loan.ods_pdw_loan_oss_lattebank_client_collect_applist_di`, `pdm_risk.pdm_risk_applist_v3_exists_cate_tmp01`
- **SQL 长度**: 160079 字符

### pdm_risk_applist_feature_newfeature_di_v3

- **任务**: `pdm_risk_applist_feature_newfeature_di_v3`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_applist_new_cate_v3_tmp02`, `pdw_manual.pdw_manual_applist_category_202303_v3`, `ods_pdw_loan.ods_pdw_loan_oss_lattebank_client_collect_applist_di`, `pdm_risk.pdm_risk_applist_new_cate_v3_tmp03`, `pdm_risk.pdm_risk_applist_new_cate_v3_tmp06`, `pdm_risk.pdm_risk_applist_new_cate_v3_tmp04`, `pdm_risk.pdm_risk_applist_new_cate_v3_tmp01`
- **SQL 长度**: 26319 字符

### pdm_risk_common_appname_onehot

- **任务**: `pdm_risk_common_appname_onehot`
- **负责人**: 牛莲泽
- **上游表**: `ods_pdw_loan.ods_pdw_loan_oss_lattebank_client_collect_applist_di`
- **SQL 长度**: 106539 字符

### pdm_risk_dh_model_15ai_call_record

- **任务**: `pdm_risk_dh_model_15ai_call_record_recall`
- **负责人**: 曹薇1926
- **上游表**: `pdm_risk.pdm_risk_dh_model_15ai_call_record_yesterday`, `pdm_risk.pdm_risk_dh_model_15ai_call_record_sample_yesterday`, `dwt.dwt_collection_call_record_detail_di`, `dwt.dwt_heavy_order_df`, `pdm_risk.pdm_risk_dh_model_15ai_call_record_tmp1`
- **SQL 长度**: 19345 字符
- **任务**: `pdm_risk_dh_model_15ai_call_record`
- **负责人**: 曹薇1926
- **上游表**: `dwt.dwt_heavy_order_df`, `pdm_risk.pdm_risk_dh_model_15ai_call_record_yesterday`, `pdm_risk.pdm_risk_dh_model_15ai_call_record_sample_yesterday`, `dwt.dwt_collection_call_record_detail_di`, `pdm_risk.pdm_risk_dh_model_15ai_call_record_tmp1`
- **SQL 长度**: 19031 字符

### pdm_risk_dh_model_final_13collection_call_info_di

- **任务**: `pdm_risk_dh_model_final_13collection_call_info_di`
- **负责人**: 海宜真
- **上游表**: `pdm_risk.dh_model_final_13collection_call_info_tmp`, `dwt.dwt_heavy_order_df`, `pdm_risk.pdm_risk_dh_model_final_13collection_call_info_di_sample_yesterday`, `ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_case_info_df`, `ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_call_record_df`
- **SQL 长度**: 15475 字符

### pdm_risk_dh_model_final_13collection_call_info_trend_features_di

- **任务**: `call_info_trend`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dh_model_sample_yesterday`, `dwt.dwt_collection_call_record_detail_di`
- **SQL 长度**: 46060 字符
- **任务**: `pdm_risk_dh_model_final_13collection_call_info_trend_features`
- **负责人**: 海宜真
- **上游表**: `pdm_risk.pdm_risk_dh_model_sample_yesterday`, `dwt.dwt_collection_call_record_detail_di`
- **SQL 长度**: 74353 字符

### pdm_risk_dh_model_final_13collection_notes_di

- **任务**: `pdm_risk_dh_model_final_13collection_notes_di`
- **负责人**: 海宜真
- **上游表**: `ods_pdw_loan.ods_pdw_loan_dsaresali_ares_plc_case_followup_record_df`, `ods_pdw_loan.ods_pdw_loan_dwd_dsaresali_ares_plc_case_info_df`, `pdm_risk.pdm_risk_dh_model_final_13collection_notes_di_sample_yesterday`, `pdm_risk.dh_model_final_13collection_notes_tmp`, `dwt.dwt_heavy_order_df`
- **SQL 长度**: 22837 字符

### pdm_risk_dh_model_final_13collection_notes_trend_features

- **任务**: `coll_notes_trend`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dh_model_sample_yesterday`, `dwt.dwt_collection_call_record_detail_di`
- **SQL 长度**: 105730 字符
- **任务**: `pdm_risk_dh_model_final_13collection_notes_trend_features`
- **负责人**: 海宜真
- **上游表**: `pdm_risk.pdm_risk_dh_model_sample_yesterday`, `dwt.dwt_collection_call_record_detail_di`
- **SQL 长度**: 162575 字符

### pdm_risk_dh_model_final_telemarket_call_info_features_di

- **任务**: `pdm_risk_dh_model_final_telemarket_call_info_features_di`
- **负责人**: 牛莲泽
- **上游表**: `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_tag_his`, `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_event_his`, `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_elitewo3task_his`, `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_objective_his`, `dwt.dwt_heavy_order_df`
- **SQL 长度**: 14122 字符
- **任务**: `pdm_risk_dh_model_final_telemarket_call_info_features_di`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_sample_di_tmp`, `pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_tmp`, `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_tag_his`, `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_event_his`, `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_sh_elitewo3task_his`, `ods_pdw_loan.ods_pdw_loan_pribigcrmali_bigcrm_objective_his`, `pdm_risk.pdm_risk_dh_model_final_telemarket_call_info_features_di_tmp`, `dwt.dwt_heavy_order_df`
- **SQL 长度**: 15742 字符

### pdm_risk_dz_br_horizontal_multi_report_feature_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_coalesce`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_base_dim`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_mid_table_final_di`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_base_dim`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_base_dim`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_coalesce`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_coalesce`
- **SQL 长度**: 461568 字符

### pdm_risk_dz_br_horizontal_multi_report_feature_sequential_rct_12mon_lst_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_sequential_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_mid_table_final_di`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12mon_lst_grp_id`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12mon_lst_lag`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12mon_lst_grp_size`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12mon_lst_coalesce`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12mon_lst_seq`
- **SQL 长度**: 395751 字符

### pdm_risk_dz_br_horizontal_multi_report_feature_sequential_rct_12tme_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_sequential_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12tme_coalesce`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12tme_lag`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12tme_grp_id`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_mid_table_final_di`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12tme_seq`, `pdm_risk.dz_br_horizontal_multi_report_feature_rct_12tme_grp_size`
- **SQL 长度**: 375210 字符

### pdm_risk_dz_br_horizontal_two_report_feature_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_horizontal_two_report_feature_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_mid_table_final_di`, `pdm_risk.pdm_risk_dz_daily_br_horizontal_trend_feature_v3_di`, `pdm_risk.pdm_risk_dz_br_horizontal_two_report_rct_two_coalesce`, `pdm_risk.pdm_risk_dz_br_horizontal_two_report_rct_mon_two`, `pdm_risk.pdm_risk_dz_br_horizontal_two_report_rct_two`, `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_sample_table_temp2`, `pdm_risk.pdm_risk_dz_br_horizontal_two_report_rct_mon_two_coalesce`
- **SQL 长度**: 325866 字符

### pdm_risk_dz_br_max_multi_report_feature_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_coalesce`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_coalesce`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_base_dim`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_base_dim`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_base_dim`
- **SQL 长度**: 159610 字符

### pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.dz_br_max_multi_report_feature_rct_12mon_lst_grp_size`, `pdm_risk.dz_br_max_multi_report_feature_rct_12mon_lst_lag`, `pdm_risk.dz_br_max_multi_report_feature_rct_12mon_lst_seq`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di`, `pdm_risk.dz_br_max_multi_report_feature_rct_12mon_lst_grp_id`, `pdm_risk.dz_br_max_multi_report_feature_rct_12mon_lst_coalesce`
- **SQL 长度**: 142597 字符

### pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_size`, `pdm_risk.dz_br_max_multi_report_feature_rct_12tme_lag`, `pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_id`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di`, `pdm_risk.dz_br_max_multi_report_feature_rct_12tme_seq`, `pdm_risk.dz_br_max_multi_report_feature_rct_12tme_coalesce`
- **SQL 长度**: 133669 字符

### pdm_risk_dz_br_max_two_report_feature_final_di

- **任务**: `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di`
- **负责人**: 曹佳程
- **上游表**: `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di`, `pdm_risk.pdm_risk_dz_br_max_two_report_rct_two_coalesce`, `pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two_coalesce`, `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2`, `pdm_risk.pdm_risk_dz_br_max_two_report_rct_two`, `pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two`, `pdm_risk.pdm_risk_dz_daily_br_max_feature`
- **SQL 长度**: 116035 字符

### pdm_risk_dz_daily_br_horizontal_trend_feature_v3_di

- **任务**: `pdm_risk_dz_daily_br_horizontal_trend_feature_v3_di`
- **负责人**: 刘诗涵
- **上游表**: `dbus.dbus_dz_daily_br_trend_feature_v3_base_di`
- **SQL 长度**: 131387 字符

### pdm_risk_dz_daily_br_max_feature

- **任务**: `pdm_risk_dz_daily_br_max_feature`
- **负责人**: 周志华
- **上游表**: `pdm_risk.pdm_risk_dz_daily_br_cast_float_feature`
- **SQL 长度**: 198913 字符

### pdm_risk_dz_daily_br_trend_feature

- **任务**: `pdm_risk_dz_daily_br_trend_feature`
- **负责人**: 周志华
- **上游表**: `pdm_risk.pdm_risk_dz_daily_br_trend_feature_tmp`, `pdm_risk.pdm_risk_dz_daily_br_cast_float_feature`
- **SQL 长度**: 126081 字符

### pdm_risk_dz_daily_br_trend_feature_v2

- **任务**: `pdm_risk_dz_daily_br_trend_feature_v2`
- **负责人**: 周志华
- **上游表**: `pdm_risk.pdm_risk_dz_daily_br_trend_feature_v2_tmp`, `pdm_risk.pdm_risk_dz_daily_br_cast_float_feature`
- **SQL 长度**: 115692 字符

### pdm_risk_dz_daily_br_vertical_trend_feature_v3_di

- **任务**: `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di`
- **负责人**: 刘诗涵
- **上游表**: `dbus.dbus_dz_daily_br_trend_feature_v3_base_di`, `pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp4`, `pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp2`, `pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1`, `pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp3`
- **SQL 长度**: 168674 字符

### pdm_risk_dz_model_account_lmt_feature_sample_final_df

- **任务**: `pdm_risk_dz_model_account_lmt_feature_sample_final_df`
- **负责人**: 周志华
- **上游表**: `dwa_risk.dwa_risk_f_heavy_stage_plan_basic`, `dwa_risk.dwa_risk_tmp_order_stage_account_union_all`, `dwa_risk.dwa_risk_f_dz_model_data_base`, `pdm_risk.pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp`, `pdm_risk.pdm_risk_dz_model_lmt_list_lft_rep_new_tmp`, `pdm_risk.pdm_risk_account_lmt_daily_6m_tmp`, `pdm_risk.pdm_risk_account_lmt_daily_1m_tmp`, `pdm_risk.pdm_risk_account_lmt_daily_12m_tmp`, `pdm_risk.pdm_risk_account_lmt_daily_3m_tmp`, `pdm_risk.pdm_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_new_tmp`, `dwa_risk.dwa_risk_f_heavy_order_info_basic`
- **SQL 长度**: 60883 字符

### pdm_risk_dz_model_daily_dcp_trade_feature_info1_df

- **任务**: `pdm_risk_dz_model_daily_dcp_trade_feature_info1_df`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1`, `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3`
- **SQL 长度**: 194131 字符

### pdm_risk_dz_model_daily_dcp_trade_feature_info2_df

- **任务**: `pdm_risk_dz_model_daily_dcp_trade_feature_info2_df`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1`, `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3`
- **SQL 长度**: 188697 字符

### pdm_risk_dz_model_daily_dcp_trade_feature_info3_df

- **任务**: `pdm_risk_dz_model_daily_dcp_trade_feature_info3_df`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1`, `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3`
- **SQL 长度**: 191750 字符

### pdm_risk_dz_model_daily_dcp_trade_feature_info4_df

- **任务**: `pdm_risk_dz_model_daily_dcp_trade_feature_info4_df`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1`, `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3`
- **SQL 长度**: 191604 字符

### pdm_risk_dz_model_daily_dcp_trade_feature_info5_df

- **任务**: `pdm_risk_dz_model_daily_dcp_trade_feature_info5_df`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1`, `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3`
- **SQL 长度**: 199499 字符

### pdm_risk_dz_model_daily_dcp_trade_feature_info6_df

- **任务**: `pdm_risk_dz_model_daily_dcp_trade_feature_info6_df`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1`, `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3`
- **SQL 长度**: 190150 字符

### pdm_risk_dz_model_daily_dcp_trade_feature_info7_df

- **任务**: `pdm_risk_dz_model_daily_dcp_trade_feature_info7_df`
- **负责人**: 牛莲泽
- **上游表**: `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1`, `pdm_risk.pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3`
- **SQL 长度**: 162795 字符

### pdm_risk_dz_model_final_order_info_df

- **任务**: `pdm_risk_dz_model_final_order_info_df`
- **负责人**: 刘诗涵
- **上游表**: `pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp4`, `pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp3`, `pdm_risk.pdm_risk_f_heavy_order_info_detail_tmp`, `pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp1`, `pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp5`, `pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp`, `dwt.dwt_heavy_order_df`, `pdm_risk.pdm_risk_dz_model_final_order_info_df_tmp2`, `pdm_risk.pdm_risk_f_heavy_order_info_basic_tmp`
- **SQL 长度**: 175620 字符
