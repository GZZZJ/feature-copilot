# pdm_risk 上游表建表逻辑汇总

- 总表数：95
- 总文件大小：19,247,519 bytes

## 上游项目空间分布

| 项目空间 | 被依赖次数 |
|----------|------------|
| pdm_risk | 530 |
| ods_pdw_loan | 34 |
| dwa_risk | 28 |
| dwt | 26 |
| pdw_manual | 11 |
| dbus | 5 |
| cdmx | 3 |
| dp_ods_credit_sec_views | 2 |

## 表清单

| 序号 | 表名 | 任务名 | 文件大小 | 上游表数 |
|------|------|--------|----------|----------|
| 1 | `dh_model_final_13collection_call_info_tmp` | `pdm_risk_dh_model_final_13collection_call_info_di` | 17,731 | 5 |
| 2 | `dh_model_final_13collection_notes_tmp` | `pdm_risk_dh_model_final_13collection_notes_di` | 26,779 | 5 |
| 3 | `dz_br_horizontal_multi_report_feature_rct_12mon_lst_coalesce` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_sequential_final_di` | 440,192 | 6 |
| 4 | `dz_br_horizontal_multi_report_feature_rct_12mon_lst_grp_id` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_sequential_final_di` | 440,192 | 6 |
| 5 | `dz_br_horizontal_multi_report_feature_rct_12mon_lst_grp_size` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_sequential_final_di` | 440,192 | 6 |
| 6 | `dz_br_horizontal_multi_report_feature_rct_12mon_lst_lag` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_sequential_final_di` | 440,192 | 6 |
| 7 | `dz_br_horizontal_multi_report_feature_rct_12mon_lst_seq` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_sequential_final_di` | 440,192 | 6 |
| 8 | `dz_br_horizontal_multi_report_feature_rct_12tme_coalesce` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_sequential_final_di` | 413,805 | 6 |
| 9 | `dz_br_horizontal_multi_report_feature_rct_12tme_grp_id` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_sequential_final_di` | 413,805 | 6 |
| 10 | `dz_br_horizontal_multi_report_feature_rct_12tme_grp_size` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_sequential_final_di` | 413,805 | 6 |
| 11 | `dz_br_horizontal_multi_report_feature_rct_12tme_lag` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_sequential_final_di` | 413,805 | 6 |
| 12 | `dz_br_horizontal_multi_report_feature_rct_12tme_seq` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_sequential_final_di` | 413,805 | 6 |
| 13 | `dz_br_max_multi_report_feature_rct_12mon_lst_coalesce` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di` | 161,060 | 6 |
| 14 | `dz_br_max_multi_report_feature_rct_12mon_lst_grp_id` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di` | 161,060 | 6 |
| 15 | `dz_br_max_multi_report_feature_rct_12mon_lst_grp_size` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di` | 161,060 | 6 |
| 16 | `dz_br_max_multi_report_feature_rct_12mon_lst_lag` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di` | 161,060 | 6 |
| 17 | `dz_br_max_multi_report_feature_rct_12mon_lst_seq` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_sequential_final_di` | 161,060 | 6 |
| 18 | `dz_br_max_multi_report_feature_rct_12tme_coalesce` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di` | 149,613 | 6 |
| 19 | `dz_br_max_multi_report_feature_rct_12tme_grp_id` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di` | 149,613 | 6 |
| 20 | `dz_br_max_multi_report_feature_rct_12tme_grp_size` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di` | 149,613 | 6 |
| 21 | `dz_br_max_multi_report_feature_rct_12tme_lag` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di` | 149,613 | 6 |
| 22 | `dz_br_max_multi_report_feature_rct_12tme_seq` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di` | 149,613 | 6 |
| 23 | `pdm_risk_account_lmt_daily_12m_tmp` | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 69,211 | 11 |
| 24 | `pdm_risk_account_lmt_daily_1m_tmp` | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 69,211 | 11 |
| 25 | `pdm_risk_account_lmt_daily_3m_tmp` | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 69,211 | 11 |
| 26 | `pdm_risk_account_lmt_daily_6m_tmp` | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 69,211 | 11 |
| 27 | `pdm_risk_applist_new_cate_v3_tmp01` | `pdm_risk_applist_feature_newfeature_di_v3` | 28,354 | 7 |
| 28 | `pdm_risk_applist_new_cate_v3_tmp02` | `pdm_risk_applist_feature_newfeature_di_v3` | 28,354 | 7 |
| 29 | `pdm_risk_applist_new_cate_v3_tmp03` | `pdm_risk_applist_feature_newfeature_di_v3` | 28,354 | 7 |
| 30 | `pdm_risk_applist_new_cate_v3_tmp04` | `pdm_risk_applist_feature_newfeature_di_v3` | 28,354 | 7 |
| 31 | `pdm_risk_applist_new_cate_v3_tmp06` | `pdm_risk_applist_feature_newfeature_di_v3` | 28,354 | 7 |
| 32 | `pdm_risk_applist_v3_exists_cate_tmp01` | `pdm_risk_applist_exists_category_di_v3` | 180,575 | 9 |
| 33 | `pdm_risk_applist_v3_exists_cate_tmp02` | `pdm_risk_applist_exists_category_di_v3` | 180,575 | 9 |
| 34 | `pdm_risk_applist_v3_exists_cate_tmp03` | `pdm_risk_applist_exists_category_di_v3` | 180,575 | 9 |
| 35 | `pdm_risk_applist_v3_exists_cate_tmp04` | `pdm_risk_applist_exists_category_di_v3` | 180,575 | 9 |
| 36 | `pdm_risk_applist_v3_exists_cate_tmp05` | `pdm_risk_applist_exists_category_di_v3` | 180,575 | 9 |
| 37 | `pdm_risk_applist_v3_exists_cate_tmp0501` | `pdm_risk_applist_exists_category_di_v3` | 180,575 | 9 |
| 38 | `pdm_risk_applist_v3_exists_cate_tmp06` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 39 | `pdm_risk_dh_model_15ai_call_record_sample_yesterday` | `pdm_risk_dh_model_15ai_call_record_recall` | 66,649 | 5 |
| 40 | `pdm_risk_dh_model_15ai_call_record_tmp1` | `pdm_risk_dh_model_15ai_call_record_recall` | 66,649 | 5 |
| 41 | `pdm_risk_dh_model_15ai_call_record_yesterday` | `pdm_risk_dh_model_15ai_call_record_recall` | 66,649 | 5 |
| 42 | `pdm_risk_dh_model_final_13collection_call_info_di_sample_yesterday` | `pdm_risk_dh_model_final_13collection_call_info_di` | 17,731 | 5 |
| 43 | `pdm_risk_dh_model_final_13collection_notes_di_sample_yesterday` | `pdm_risk_dh_model_final_13collection_notes_di` | 26,779 | 5 |
| 44 | `pdm_risk_dh_model_final_telemarket_call_info_features_di_tmp` | `pdm_risk_dh_model_final_telemarket_call_info_features_di` | 18,568 | 8 |
| 45 | `pdm_risk_dh_model_final_telemarket_call_info_sample_di_tmp` | `pdm_risk_dh_model_final_telemarket_call_info_features_di` | 18,568 | 8 |
| 46 | `pdm_risk_dh_model_final_telemarket_call_info_tmp` | `pdm_risk_dh_model_final_telemarket_call_info_features_di` | 18,568 | 8 |
| 47 | `pdm_risk_dh_model_sample_yesterday` | `dh_sample` | 2,053 | 1 |
| 48 | `pdm_risk_dz_br_horizontal_multi_report_feature_mid_table_final_di` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 568,973 | 7 |
| 49 | `pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_base_dim` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 568,973 | 7 |
| 50 | `pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_coalesce` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 568,973 | 7 |
| 51 | `pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_base_dim` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 568,973 | 7 |
| 52 | `pdm_risk_dz_br_horizontal_multi_report_feature_rct_12mon_lst_coalesce` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 568,973 | 7 |
| 53 | `pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_base_dim` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 568,973 | 7 |
| 54 | `pdm_risk_dz_br_horizontal_multi_report_feature_rct_12tme_coalesce` | `pdm_risk.pdm_risk_dz_br_horizontal_multi_report_feature_final_di` | 568,973 | 7 |
| 55 | `pdm_risk_dz_br_horizontal_multi_report_feature_sample_table_temp2` | `pdm_risk.pdm_risk_dz_br_horizontal_two_report_feature_final_di` | 384,525 | 7 |
| 56 | `pdm_risk_dz_br_horizontal_two_report_rct_mon_two` | `pdm_risk.pdm_risk_dz_br_horizontal_two_report_feature_final_di` | 384,525 | 7 |
| 57 | `pdm_risk_dz_br_horizontal_two_report_rct_mon_two_coalesce` | `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di` | 140,122 | 7 |
| 58 | `pdm_risk_dz_br_horizontal_two_report_rct_two` | `pdm_risk.pdm_risk_dz_br_horizontal_two_report_feature_final_di` | 384,525 | 7 |
| 59 | `pdm_risk_dz_br_horizontal_two_report_rct_two_coalesce` | `pdm_risk.pdm_risk_dz_br_horizontal_two_report_feature_final_di` | 384,525 | 7 |
| 60 | `pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di` | `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di` | 140,122 | 7 |
| 61 | `pdm_risk_dz_br_max_multi_report_feature_rct_12mon_base_dim` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di` | 203,081 | 7 |
| 62 | `pdm_risk_dz_br_max_multi_report_feature_rct_12mon_coalesce` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di` | 203,081 | 7 |
| 63 | `pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_base_dim` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di` | 203,081 | 7 |
| 64 | `pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_coalesce` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di` | 203,081 | 7 |
| 65 | `pdm_risk_dz_br_max_multi_report_feature_rct_12tme_base_dim` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di` | 203,081 | 7 |
| 66 | `pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce` | `pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di` | 203,081 | 7 |
| 67 | `pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2` | `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di` | 140,122 | 7 |
| 68 | `pdm_risk_dz_br_max_two_report_rct_mon_two` | `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di` | 140,122 | 7 |
| 69 | `pdm_risk_dz_br_max_two_report_rct_mon_two_coalesce` | `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di` | 140,122 | 7 |
| 70 | `pdm_risk_dz_br_max_two_report_rct_two` | `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di` | 140,122 | 7 |
| 71 | `pdm_risk_dz_br_max_two_report_rct_two_coalesce` | `pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di` | 140,122 | 7 |
| 72 | `pdm_risk_dz_daily_br_cast_float_feature` | `pdm_risk_dz_daily_br_cast_float_feature` | 168,641 | 1 |
| 73 | `pdm_risk_dz_daily_br_horizontal_trend_feature_v3_di` | `pdm_risk_dz_daily_br_horizontal_trend_feature_v3_di` | 132,817 | 1 |
| 74 | `pdm_risk_dz_daily_br_max_feature` | `pdm_risk_dz_daily_br_max_feature` | 199,842 | 1 |
| 75 | `pdm_risk_dz_daily_br_raw_feature` | `pdm_risk_dz_daily_br_raw_feature` | 159,941 | 2 |
| 76 | `pdm_risk_dz_daily_br_trend_feature_tmp` | `pdm_risk_dz_daily_br_trend_feature` | 147,514 | 2 |
| 77 | `pdm_risk_dz_daily_br_trend_feature_v2_tmp` | `pdm_risk_dz_daily_br_trend_feature_v2` | 122,816 | 2 |
| 78 | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1` | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di` | 171,314 | 5 |
| 79 | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp2` | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di` | 171,314 | 5 |
| 80 | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp3` | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di` | 171,314 | 5 |
| 81 | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp4` | `pdm_risk_dz_daily_br_vertical_trend_feature_v3_di` | 171,314 | 5 |
| 82 | `pdm_risk_dz_model_account_lmt_feature_sample_lmt_list_lft_rep_new_tmp` | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 77,085 | 11 |
| 83 | `pdm_risk_dz_model_account_lmt_feature_sample_lmt_temp` | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 77,085 | 11 |
| 84 | `pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp1` | `pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3` | 9,797 | 5 |
| 85 | `pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp2` | `pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3` | 9,785 | 5 |
| 86 | `pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3` | `pdm_risk_dz_model_daily_dcp_trade_feature_info_tmp3` | 9,797 | 5 |
| 87 | `pdm_risk_dz_model_final_order_info_df_tmp` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 88 | `pdm_risk_dz_model_final_order_info_df_tmp1` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 89 | `pdm_risk_dz_model_final_order_info_df_tmp2` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 90 | `pdm_risk_dz_model_final_order_info_df_tmp3` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 91 | `pdm_risk_dz_model_final_order_info_df_tmp4` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 92 | `pdm_risk_dz_model_final_order_info_df_tmp5` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 93 | `pdm_risk_dz_model_lmt_list_lft_rep_new_tmp` | `pdm_risk_dz_model_account_lmt_feature_sample_final_df` | 77,085 | 11 |
| 94 | `pdm_risk_f_heavy_order_info_basic_tmp` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |
| 95 | `pdm_risk_f_heavy_order_info_detail_tmp` | `pdm_risk_dz_model_final_order_info_df` | 219,741 | 9 |

## 说明

- 每个 SQL 文件包含对应表的完整 DDL+DML 逻辑及其直接上游表元数据。
- 若多个表名指向同一 dp-mcp 任务，其 SQL 内容相同。
