-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2
-- node_id: n_7014197334062661632
-- task_name: pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di
-- owner_name: 曹佳程
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2.json
-- source_json_sha256: 6f3be59794fdb91c3118ba998f7f1b2c7e897153e1d44ff254d32a192808196e
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_two_report_rct_two_coalesce
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two_coalesce
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_two_report_rct_two
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_max_feature

create table if not exists pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di(
uid string comment '用户id',
data_id STRING COMMENT '数据ID',
code STRING COMMENT '响应码',
flag_applyloanstr STRING COMMENT '借贷意向验证产品输出标识',
swift_number STRING COMMENT '操作流水号',
created_at TIMESTAMP COMMENT '创建时间',
updated_at TIMESTAMP COMMENT '更新时间'
-- 1. 最近一份报文
, rct_two_dte_len float comment '与最近一份报文时间差'
, als_m1_nbank_orgnum_max_rct_two_diff float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_else_orgnum_max_rct_two_diff float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_allnum_max_rct_two_diff float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_oth_orgnum_max_rct_two_diff float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_else_allnum_max_rct_two_diff float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_oth_allnum_max_rct_two_diff float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_caon_orgnum_max_rct_two_diff float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_orgnum_max_rct_two_diff float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_allnum_max_rct_two_diff float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_caon_allnum_max_rct_two_diff float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_pdl_orgnum_max_rct_two_diff float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_cons_orgnum_max_rct_two_diff float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_else_orgnum_max_rct_two_diff float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_cons_allnum_max_rct_two_diff float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_else_allnum_max_rct_two_diff float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_nsloan_orgnum_max_rct_two_diff float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_pdl_allnum_max_rct_two_diff float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_oth_orgnum_max_rct_two_diff float comment '近15天在非银机构-其他申请机构数(other身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_oth_allnum_max_rct_two_diff float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_week_orgnum_max_rct_two_diff float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_cf_orgnum_max_rct_two_diff float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_week_allnum_max_rct_two_diff float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_cf_allnum_max_rct_two_diff float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_lst_nbank_inteday_max_rct_two_diff float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_coon_orgnum_max_rct_two_diff float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_coon_allnum_max_rct_two_diff float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_nsloan_allnum_max_rct_two_diff float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_caon_orgnum_max_rct_two_diff float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_caon_allnum_max_rct_two_diff float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_week_orgnum_max_rct_two_diff float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_week_allnum_max_rct_two_diff float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_pdl_orgnum_max_rct_two_diff float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_cons_orgnum_max_rct_two_diff float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_pdl_allnum_max_rct_two_diff float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_cons_allnum_max_rct_two_diff float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d7_nbank_orgnum_max_rct_two_diff float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d7_nbank_allnum_max_rct_two_diff float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_night_allnum_max_rct_two_diff float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_m1_nbank_night_orgnum_max_rct_two_diff float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d7_nbank_else_allnum_max_rct_two_diff float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_nsloan_orgnum_max_rct_two_diff float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d7_nbank_else_orgnum_max_rct_two_diff float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_night_allnum_max_rct_two_diff float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_night_orgnum_max_rct_two_diff float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d7_nbank_oth_orgnum_max_rct_two_diff float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文差值'
, als_d7_nbank_oth_allnum_max_rct_two_diff float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_cf_orgnum_max_rct_two_diff float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_cf_allnum_max_rct_two_diff float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_selfnum_max_rct_two_diff float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_nbank_nsloan_allnum_max_rct_two_diff float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与最近一份报文差值'
, als_d15_coon_allnum_max_rct_two_diff float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_与最近一份报文差值'

, als_m1_nbank_orgnum_max_rct_two_dvd float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_else_orgnum_max_rct_two_dvd float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_allnum_max_rct_two_dvd float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_oth_orgnum_max_rct_two_dvd float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_else_allnum_max_rct_two_dvd float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_oth_allnum_max_rct_two_dvd float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_caon_orgnum_max_rct_two_dvd float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_orgnum_max_rct_two_dvd float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_allnum_max_rct_two_dvd float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_caon_allnum_max_rct_two_dvd float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_pdl_orgnum_max_rct_two_dvd float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_cons_orgnum_max_rct_two_dvd float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_else_orgnum_max_rct_two_dvd float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_cons_allnum_max_rct_two_dvd float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_else_allnum_max_rct_two_dvd float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_nsloan_orgnum_max_rct_two_dvd float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_pdl_allnum_max_rct_two_dvd float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_oth_orgnum_max_rct_two_dvd float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_oth_allnum_max_rct_two_dvd float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_week_orgnum_max_rct_two_dvd float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_cf_orgnum_max_rct_two_dvd float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_week_allnum_max_rct_two_dvd float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_cf_allnum_max_rct_two_dvd float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_lst_nbank_inteday_max_rct_two_dvd float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_coon_orgnum_max_rct_two_dvd float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_coon_allnum_max_rct_two_dvd float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_nsloan_allnum_max_rct_two_dvd float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_caon_orgnum_max_rct_two_dvd float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_caon_allnum_max_rct_two_dvd float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_week_orgnum_max_rct_two_dvd float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_week_allnum_max_rct_two_dvd float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_pdl_orgnum_max_rct_two_dvd float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_cons_orgnum_max_rct_two_dvd float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_pdl_allnum_max_rct_two_dvd float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_cons_allnum_max_rct_two_dvd float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d7_nbank_orgnum_max_rct_two_dvd float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d7_nbank_allnum_max_rct_two_dvd float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_night_allnum_max_rct_two_dvd float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_m1_nbank_night_orgnum_max_rct_two_dvd float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d7_nbank_else_allnum_max_rct_two_dvd float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_nsloan_orgnum_max_rct_two_dvd float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d7_nbank_else_orgnum_max_rct_two_dvd float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_night_allnum_max_rct_two_dvd float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_night_orgnum_max_rct_two_dvd float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d7_nbank_oth_orgnum_max_rct_two_dvd float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文比值'
, als_d7_nbank_oth_allnum_max_rct_two_dvd float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_cf_orgnum_max_rct_two_dvd float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_cf_allnum_max_rct_two_dvd float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_selfnum_max_rct_two_dvd float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_nbank_nsloan_allnum_max_rct_two_dvd float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与最近一份报文比值'
, als_d15_coon_allnum_max_rct_two_dvd float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_与最近一份报文比值'

, als_m1_nbank_orgnum_max_rct_two_roc float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_else_orgnum_max_rct_two_roc float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_allnum_max_rct_two_roc float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_oth_orgnum_max_rct_two_roc float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_else_allnum_max_rct_two_roc float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_oth_allnum_max_rct_two_roc float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_caon_orgnum_max_rct_two_roc float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_orgnum_max_rct_two_roc float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_allnum_max_rct_two_roc float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_caon_allnum_max_rct_two_roc float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_pdl_orgnum_max_rct_two_roc float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_cons_orgnum_max_rct_two_roc float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_else_orgnum_max_rct_two_roc float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_cons_allnum_max_rct_two_roc float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_else_allnum_max_rct_two_roc float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_nsloan_orgnum_max_rct_two_roc float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_pdl_allnum_max_rct_two_roc float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_oth_orgnum_max_rct_two_roc float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_oth_allnum_max_rct_two_roc float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_week_orgnum_max_rct_two_roc float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_cf_orgnum_max_rct_two_roc float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_week_allnum_max_rct_two_roc float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_cf_allnum_max_rct_two_roc float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_lst_nbank_inteday_max_rct_two_roc float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_coon_orgnum_max_rct_two_roc float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_coon_allnum_max_rct_two_roc float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_nsloan_allnum_max_rct_two_roc float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_caon_orgnum_max_rct_two_roc float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_caon_allnum_max_rct_two_roc float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_week_orgnum_max_rct_two_roc float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_week_allnum_max_rct_two_roc float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_pdl_orgnum_max_rct_two_roc float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_cons_orgnum_max_rct_two_roc float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_pdl_allnum_max_rct_two_roc float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_cons_allnum_max_rct_two_roc float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d7_nbank_orgnum_max_rct_two_roc float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d7_nbank_allnum_max_rct_two_roc float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_night_allnum_max_rct_two_roc float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_m1_nbank_night_orgnum_max_rct_two_roc float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d7_nbank_else_allnum_max_rct_two_roc float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_nsloan_orgnum_max_rct_two_roc float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d7_nbank_else_orgnum_max_rct_two_roc float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_night_allnum_max_rct_two_roc float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_night_orgnum_max_rct_two_roc float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d7_nbank_oth_orgnum_max_rct_two_roc float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d7_nbank_oth_allnum_max_rct_two_roc float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_cf_orgnum_max_rct_two_roc float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_cf_allnum_max_rct_two_roc float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_selfnum_max_rct_two_roc float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_nbank_nsloan_allnum_max_rct_two_roc float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与最近一份报文变化率'
, als_d15_coon_allnum_max_rct_two_roc float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_与最近一份报文变化率'
-- 2. 上月最近一份报文
, rct_mon_two_dte_len float comment '与上月最近一份报文时间差'
, als_m1_nbank_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_else_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_oth_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_else_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_oth_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_caon_orgnum_max_rct_mon_two_diff float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_allnum_max_rct_mon_two_diff float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_caon_allnum_max_rct_mon_two_diff float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_pdl_orgnum_max_rct_mon_two_diff float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_cons_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_else_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_cons_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_else_allnum_max_rct_mon_two_diff float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_pdl_allnum_max_rct_mon_two_diff float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_oth_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_oth_allnum_max_rct_mon_two_diff float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_week_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_cf_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_week_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_cf_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_lst_nbank_inteday_max_rct_mon_two_diff float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_coon_orgnum_max_rct_mon_two_diff float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_coon_allnum_max_rct_mon_two_diff float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_caon_orgnum_max_rct_mon_two_diff float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_caon_allnum_max_rct_mon_two_diff float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_week_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_week_allnum_max_rct_mon_two_diff float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_pdl_orgnum_max_rct_mon_two_diff float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_cons_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_pdl_allnum_max_rct_mon_two_diff float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_cons_allnum_max_rct_mon_two_diff float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d7_nbank_orgnum_max_rct_mon_two_diff float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d7_nbank_allnum_max_rct_mon_two_diff float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_night_allnum_max_rct_mon_two_diff float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_m1_nbank_night_orgnum_max_rct_mon_two_diff float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d7_nbank_else_allnum_max_rct_mon_two_diff float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d7_nbank_else_orgnum_max_rct_mon_two_diff float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_night_allnum_max_rct_mon_two_diff float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_night_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d7_nbank_oth_orgnum_max_rct_mon_two_diff float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d7_nbank_oth_allnum_max_rct_mon_two_diff float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_cf_orgnum_max_rct_mon_two_diff float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_cf_allnum_max_rct_mon_two_diff float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_selfnum_max_rct_mon_two_diff float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_diff float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与上月最近一份报文差值'
, als_d15_coon_allnum_max_rct_mon_two_diff float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_与上月最近一份报文差值'

, als_m1_nbank_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_else_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_oth_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_else_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_oth_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_caon_orgnum_max_rct_mon_two_dvd float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_caon_allnum_max_rct_mon_two_dvd float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_pdl_orgnum_max_rct_mon_two_dvd float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_cons_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_else_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_cons_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_else_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_pdl_allnum_max_rct_mon_two_dvd float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_oth_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_oth_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_week_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_cf_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_week_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_cf_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_lst_nbank_inteday_max_rct_mon_two_dvd float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_coon_orgnum_max_rct_mon_two_dvd float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_coon_allnum_max_rct_mon_two_dvd float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_caon_orgnum_max_rct_mon_two_dvd float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_caon_allnum_max_rct_mon_two_dvd float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_week_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_week_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_pdl_orgnum_max_rct_mon_two_dvd float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_cons_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_pdl_allnum_max_rct_mon_two_dvd float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_cons_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d7_nbank_orgnum_max_rct_mon_two_dvd float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d7_nbank_allnum_max_rct_mon_two_dvd float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_night_allnum_max_rct_mon_two_dvd float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_m1_nbank_night_orgnum_max_rct_mon_two_dvd float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d7_nbank_else_allnum_max_rct_mon_two_dvd float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d7_nbank_else_orgnum_max_rct_mon_two_dvd float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_night_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_night_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d7_nbank_oth_orgnum_max_rct_mon_two_dvd float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d7_nbank_oth_allnum_max_rct_mon_two_dvd float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_cf_orgnum_max_rct_mon_two_dvd float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_cf_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_selfnum_max_rct_mon_two_dvd float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_dvd float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与上月最近一份报文比值'
, als_d15_coon_allnum_max_rct_mon_two_dvd float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_与上月最近一份报文比值'

, als_m1_nbank_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_else_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_oth_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_else_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_oth_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_caon_orgnum_max_rct_mon_two_roc float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_allnum_max_rct_mon_two_roc float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_caon_allnum_max_rct_mon_two_roc float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_pdl_orgnum_max_rct_mon_two_roc float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_cons_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_else_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_cons_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_else_allnum_max_rct_mon_two_roc float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_pdl_allnum_max_rct_mon_two_roc float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_oth_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_oth_allnum_max_rct_mon_two_roc float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_week_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_cf_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_week_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_cf_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_lst_nbank_inteday_max_rct_mon_two_roc float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_coon_orgnum_max_rct_mon_two_roc float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_coon_allnum_max_rct_mon_two_roc float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_caon_orgnum_max_rct_mon_two_roc float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_caon_allnum_max_rct_mon_two_roc float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_week_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_week_allnum_max_rct_mon_two_roc float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_pdl_orgnum_max_rct_mon_two_roc float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_cons_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_pdl_allnum_max_rct_mon_two_roc float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_cons_allnum_max_rct_mon_two_roc float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d7_nbank_orgnum_max_rct_mon_two_roc float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d7_nbank_allnum_max_rct_mon_two_roc float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_night_allnum_max_rct_mon_two_roc float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_m1_nbank_night_orgnum_max_rct_mon_two_roc float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d7_nbank_else_allnum_max_rct_mon_two_roc float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d7_nbank_else_orgnum_max_rct_mon_two_roc float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_night_allnum_max_rct_mon_two_roc float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_night_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d7_nbank_oth_orgnum_max_rct_mon_two_roc float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d7_nbank_oth_allnum_max_rct_mon_two_roc float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_cf_orgnum_max_rct_mon_two_roc float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_cf_allnum_max_rct_mon_two_roc float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_selfnum_max_rct_mon_two_roc float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_roc float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
, als_d15_coon_allnum_max_rct_mon_two_roc float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_与上月最近一份报文变化率'
) comment '百融max_多报文特征中间表_近2份报文'
partitioned by (ds string)

;




-- 1. 近2次
drop table if exists pdm_risk.pdm_risk_dz_br_max_two_report_rct_two_coalesce;
create table pdm_risk.pdm_risk_dz_br_max_two_report_rct_two_coalesce as
select uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
, coalesce(als_m1_nbank_orgnum_max, 0) as als_m1_nbank_orgnum_max
, coalesce(als_m1_nbank_else_orgnum_max, 0) as als_m1_nbank_else_orgnum_max
, coalesce(als_m1_nbank_allnum_max, 0) as als_m1_nbank_allnum_max
, coalesce(als_m1_nbank_oth_orgnum_max, 0) as als_m1_nbank_oth_orgnum_max
, coalesce(als_m1_nbank_else_allnum_max, 0) as als_m1_nbank_else_allnum_max
, coalesce(als_m1_nbank_oth_allnum_max, 0) as als_m1_nbank_oth_allnum_max
, coalesce(als_m1_caon_orgnum_max, 0) as als_m1_caon_orgnum_max
, coalesce(als_d15_nbank_orgnum_max, 0) as als_d15_nbank_orgnum_max
, coalesce(als_d15_nbank_allnum_max, 0) as als_d15_nbank_allnum_max
, coalesce(als_m1_caon_allnum_max, 0) as als_m1_caon_allnum_max
, coalesce(als_m1_pdl_orgnum_max, 0) as als_m1_pdl_orgnum_max
, coalesce(als_m1_nbank_cons_orgnum_max, 0) as als_m1_nbank_cons_orgnum_max
, coalesce(als_d15_nbank_else_orgnum_max, 0) as als_d15_nbank_else_orgnum_max
, coalesce(als_m1_nbank_cons_allnum_max, 0) as als_m1_nbank_cons_allnum_max
, coalesce(als_d15_nbank_else_allnum_max, 0) as als_d15_nbank_else_allnum_max
, coalesce(als_m1_nbank_nsloan_orgnum_max, 0) as als_m1_nbank_nsloan_orgnum_max
, coalesce(als_m1_pdl_allnum_max, 0) as als_m1_pdl_allnum_max
, coalesce(als_d15_nbank_oth_orgnum_max, 0) as als_d15_nbank_oth_orgnum_max
, coalesce(als_d15_nbank_oth_allnum_max, 0) as als_d15_nbank_oth_allnum_max
, coalesce(als_m1_nbank_week_orgnum_max, 0) as als_m1_nbank_week_orgnum_max
, coalesce(als_m1_nbank_cf_orgnum_max, 0) as als_m1_nbank_cf_orgnum_max
, coalesce(als_m1_nbank_week_allnum_max, 0) as als_m1_nbank_week_allnum_max
, coalesce(als_m1_nbank_cf_allnum_max, 0) as als_m1_nbank_cf_allnum_max
, coalesce(als_lst_nbank_inteday_max, 0) as als_lst_nbank_inteday_max
, coalesce(als_m1_coon_orgnum_max, 0) as als_m1_coon_orgnum_max
, coalesce(als_m1_coon_allnum_max, 0) as als_m1_coon_allnum_max
, coalesce(als_m1_nbank_nsloan_allnum_max, 0) as als_m1_nbank_nsloan_allnum_max
, coalesce(als_d15_caon_orgnum_max, 0) as als_d15_caon_orgnum_max
, coalesce(als_d15_caon_allnum_max, 0) as als_d15_caon_allnum_max
, coalesce(als_d15_nbank_week_orgnum_max, 0) as als_d15_nbank_week_orgnum_max
, coalesce(als_d15_nbank_week_allnum_max, 0) as als_d15_nbank_week_allnum_max
, coalesce(als_d15_pdl_orgnum_max, 0) as als_d15_pdl_orgnum_max
, coalesce(als_d15_nbank_cons_orgnum_max, 0) as als_d15_nbank_cons_orgnum_max
, coalesce(als_d15_pdl_allnum_max, 0) as als_d15_pdl_allnum_max
, coalesce(als_d15_nbank_cons_allnum_max, 0) as als_d15_nbank_cons_allnum_max
, coalesce(als_d7_nbank_orgnum_max, 0) as als_d7_nbank_orgnum_max
, coalesce(als_d7_nbank_allnum_max, 0) as als_d7_nbank_allnum_max
, coalesce(als_m1_nbank_night_allnum_max, 0) as als_m1_nbank_night_allnum_max
, coalesce(als_m1_nbank_night_orgnum_max, 0) as als_m1_nbank_night_orgnum_max
, coalesce(als_d7_nbank_else_allnum_max, 0) as als_d7_nbank_else_allnum_max
, coalesce(als_d15_nbank_nsloan_orgnum_max, 0) as als_d15_nbank_nsloan_orgnum_max
, coalesce(als_d7_nbank_else_orgnum_max, 0) as als_d7_nbank_else_orgnum_max
, coalesce(als_d15_nbank_night_allnum_max, 0) as als_d15_nbank_night_allnum_max
, coalesce(als_d15_nbank_night_orgnum_max, 0) as als_d15_nbank_night_orgnum_max
, coalesce(als_d7_nbank_oth_orgnum_max, 0) as als_d7_nbank_oth_orgnum_max
, coalesce(als_d7_nbank_oth_allnum_max, 0) as als_d7_nbank_oth_allnum_max
, coalesce(als_d15_nbank_cf_orgnum_max, 0) as als_d15_nbank_cf_orgnum_max
, coalesce(als_d15_nbank_cf_allnum_max, 0) as als_d15_nbank_cf_allnum_max
, coalesce(als_d15_nbank_selfnum_max, 0) as als_d15_nbank_selfnum_max
, coalesce(als_d15_nbank_nsloan_allnum_max, 0) as als_d15_nbank_nsloan_allnum_max
, coalesce(als_d15_coon_allnum_max, 0) as als_d15_coon_allnum_max
from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
where ds = '${bizdate}'
and last_rn <= 2


;

-- 0. 百融查询uid样本表
-- 多头查询是针对uid维度 一天查一次 需要对uid去重
drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2;
create table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2 as
select uid
from pdm_risk.pdm_risk_dz_daily_br_max_feature
where ds = '${bizdate}'
group by uid;

-- 1. 最近一份
drop table if exists pdm_risk.pdm_risk_dz_br_max_two_report_rct_two;
create table pdm_risk.pdm_risk_dz_br_max_two_report_rct_two as
select uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
, datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as rct_two_dte_len
-- 1-2
, als_m1_nbank_orgnum_max_rct_two_diff
, als_m1_nbank_else_orgnum_max_rct_two_diff
, als_m1_nbank_allnum_max_rct_two_diff
, als_m1_nbank_oth_orgnum_max_rct_two_diff
, als_m1_nbank_else_allnum_max_rct_two_diff
, als_m1_nbank_oth_allnum_max_rct_two_diff
, als_m1_caon_orgnum_max_rct_two_diff
, als_d15_nbank_orgnum_max_rct_two_diff
, als_d15_nbank_allnum_max_rct_two_diff
, als_m1_caon_allnum_max_rct_two_diff
, als_m1_pdl_orgnum_max_rct_two_diff
, als_m1_nbank_cons_orgnum_max_rct_two_diff
, als_d15_nbank_else_orgnum_max_rct_two_diff
, als_m1_nbank_cons_allnum_max_rct_two_diff
, als_d15_nbank_else_allnum_max_rct_two_diff
, als_m1_nbank_nsloan_orgnum_max_rct_two_diff
, als_m1_pdl_allnum_max_rct_two_diff
, als_d15_nbank_oth_orgnum_max_rct_two_diff
, als_d15_nbank_oth_allnum_max_rct_two_diff
, als_m1_nbank_week_orgnum_max_rct_two_diff
, als_m1_nbank_cf_orgnum_max_rct_two_diff
, als_m1_nbank_week_allnum_max_rct_two_diff
, als_m1_nbank_cf_allnum_max_rct_two_diff
, als_lst_nbank_inteday_max_rct_two_diff
, als_m1_coon_orgnum_max_rct_two_diff
, als_m1_coon_allnum_max_rct_two_diff
, als_m1_nbank_nsloan_allnum_max_rct_two_diff
, als_d15_caon_orgnum_max_rct_two_diff
, als_d15_caon_allnum_max_rct_two_diff
, als_d15_nbank_week_orgnum_max_rct_two_diff
, als_d15_nbank_week_allnum_max_rct_two_diff
, als_d15_pdl_orgnum_max_rct_two_diff
, als_d15_nbank_cons_orgnum_max_rct_two_diff
, als_d15_pdl_allnum_max_rct_two_diff
, als_d15_nbank_cons_allnum_max_rct_two_diff
, als_d7_nbank_orgnum_max_rct_two_diff
, als_d7_nbank_allnum_max_rct_two_diff
, als_m1_nbank_night_allnum_max_rct_two_diff
, als_m1_nbank_night_orgnum_max_rct_two_diff
, als_d7_nbank_else_allnum_max_rct_two_diff
, als_d15_nbank_nsloan_orgnum_max_rct_two_diff
, als_d7_nbank_else_orgnum_max_rct_two_diff
, als_d15_nbank_night_allnum_max_rct_two_diff
, als_d15_nbank_night_orgnum_max_rct_two_diff
, als_d7_nbank_oth_orgnum_max_rct_two_diff
, als_d7_nbank_oth_allnum_max_rct_two_diff
, als_d15_nbank_cf_orgnum_max_rct_two_diff
, als_d15_nbank_cf_allnum_max_rct_two_diff
, als_d15_nbank_selfnum_max_rct_two_diff
, als_d15_nbank_nsloan_allnum_max_rct_two_diff
, als_d15_coon_allnum_max_rct_two_diff
-- 1/2
, als_m1_nbank_orgnum_max_rct_two_dvd
, als_m1_nbank_else_orgnum_max_rct_two_dvd
, als_m1_nbank_allnum_max_rct_two_dvd
, als_m1_nbank_oth_orgnum_max_rct_two_dvd
, als_m1_nbank_else_allnum_max_rct_two_dvd
, als_m1_nbank_oth_allnum_max_rct_two_dvd
, als_m1_caon_orgnum_max_rct_two_dvd
, als_d15_nbank_orgnum_max_rct_two_dvd
, als_d15_nbank_allnum_max_rct_two_dvd
, als_m1_caon_allnum_max_rct_two_dvd
, als_m1_pdl_orgnum_max_rct_two_dvd
, als_m1_nbank_cons_orgnum_max_rct_two_dvd
, als_d15_nbank_else_orgnum_max_rct_two_dvd
, als_m1_nbank_cons_allnum_max_rct_two_dvd
, als_d15_nbank_else_allnum_max_rct_two_dvd
, als_m1_nbank_nsloan_orgnum_max_rct_two_dvd
, als_m1_pdl_allnum_max_rct_two_dvd
, als_d15_nbank_oth_orgnum_max_rct_two_dvd
, als_d15_nbank_oth_allnum_max_rct_two_dvd
, als_m1_nbank_week_orgnum_max_rct_two_dvd
, als_m1_nbank_cf_orgnum_max_rct_two_dvd
, als_m1_nbank_week_allnum_max_rct_two_dvd
, als_m1_nbank_cf_allnum_max_rct_two_dvd
, als_lst_nbank_inteday_max_rct_two_dvd
, als_m1_coon_orgnum_max_rct_two_dvd
, als_m1_coon_allnum_max_rct_two_dvd
, als_m1_nbank_nsloan_allnum_max_rct_two_dvd
, als_d15_caon_orgnum_max_rct_two_dvd
, als_d15_caon_allnum_max_rct_two_dvd
, als_d15_nbank_week_orgnum_max_rct_two_dvd
, als_d15_nbank_week_allnum_max_rct_two_dvd
, als_d15_pdl_orgnum_max_rct_two_dvd
, als_d15_nbank_cons_orgnum_max_rct_two_dvd
, als_d15_pdl_allnum_max_rct_two_dvd
, als_d15_nbank_cons_allnum_max_rct_two_dvd
, als_d7_nbank_orgnum_max_rct_two_dvd
, als_d7_nbank_allnum_max_rct_two_dvd
, als_m1_nbank_night_allnum_max_rct_two_dvd
, als_m1_nbank_night_orgnum_max_rct_two_dvd
, als_d7_nbank_else_allnum_max_rct_two_dvd
, als_d15_nbank_nsloan_orgnum_max_rct_two_dvd
, als_d7_nbank_else_orgnum_max_rct_two_dvd
, als_d15_nbank_night_allnum_max_rct_two_dvd
, als_d15_nbank_night_orgnum_max_rct_two_dvd
, als_d7_nbank_oth_orgnum_max_rct_two_dvd
, als_d7_nbank_oth_allnum_max_rct_two_dvd
, als_d15_nbank_cf_orgnum_max_rct_two_dvd
, als_d15_nbank_cf_allnum_max_rct_two_dvd
, als_d15_nbank_selfnum_max_rct_two_dvd
, als_d15_nbank_nsloan_allnum_max_rct_two_dvd
, als_d15_coon_allnum_max_rct_two_dvd
-- 1-2/tme_len
, als_m1_nbank_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_orgnum_max_rct_two_roc
, als_m1_nbank_else_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_else_orgnum_max_rct_two_roc
, als_m1_nbank_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_allnum_max_rct_two_roc
, als_m1_nbank_oth_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_oth_orgnum_max_rct_two_roc
, als_m1_nbank_else_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_else_allnum_max_rct_two_roc
, als_m1_nbank_oth_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_oth_allnum_max_rct_two_roc
, als_m1_caon_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_caon_orgnum_max_rct_two_roc
, als_d15_nbank_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_orgnum_max_rct_two_roc
, als_d15_nbank_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_allnum_max_rct_two_roc
, als_m1_caon_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_caon_allnum_max_rct_two_roc
, als_m1_pdl_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_pdl_orgnum_max_rct_two_roc
, als_m1_nbank_cons_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_cons_orgnum_max_rct_two_roc
, als_d15_nbank_else_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_else_orgnum_max_rct_two_roc
, als_m1_nbank_cons_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_cons_allnum_max_rct_two_roc
, als_d15_nbank_else_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_else_allnum_max_rct_two_roc
, als_m1_nbank_nsloan_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_nsloan_orgnum_max_rct_two_roc
, als_m1_pdl_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_pdl_allnum_max_rct_two_roc
, als_d15_nbank_oth_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_oth_orgnum_max_rct_two_roc
, als_d15_nbank_oth_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_oth_allnum_max_rct_two_roc
, als_m1_nbank_week_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_week_orgnum_max_rct_two_roc
, als_m1_nbank_cf_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_cf_orgnum_max_rct_two_roc
, als_m1_nbank_week_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_week_allnum_max_rct_two_roc
, als_m1_nbank_cf_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_cf_allnum_max_rct_two_roc
, als_lst_nbank_inteday_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_lst_nbank_inteday_max_rct_two_roc
, als_m1_coon_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_coon_orgnum_max_rct_two_roc
, als_m1_coon_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_coon_allnum_max_rct_two_roc
, als_m1_nbank_nsloan_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_nsloan_allnum_max_rct_two_roc
, als_d15_caon_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_caon_orgnum_max_rct_two_roc
, als_d15_caon_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_caon_allnum_max_rct_two_roc
, als_d15_nbank_week_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_week_orgnum_max_rct_two_roc
, als_d15_nbank_week_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_week_allnum_max_rct_two_roc
, als_d15_pdl_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_pdl_orgnum_max_rct_two_roc
, als_d15_nbank_cons_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_cons_orgnum_max_rct_two_roc
, als_d15_pdl_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_pdl_allnum_max_rct_two_roc
, als_d15_nbank_cons_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_cons_allnum_max_rct_two_roc
, als_d7_nbank_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d7_nbank_orgnum_max_rct_two_roc
, als_d7_nbank_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d7_nbank_allnum_max_rct_two_roc
, als_m1_nbank_night_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_night_allnum_max_rct_two_roc
, als_m1_nbank_night_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_m1_nbank_night_orgnum_max_rct_two_roc
, als_d7_nbank_else_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d7_nbank_else_allnum_max_rct_two_roc
, als_d15_nbank_nsloan_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_nsloan_orgnum_max_rct_two_roc
, als_d7_nbank_else_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d7_nbank_else_orgnum_max_rct_two_roc
, als_d15_nbank_night_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_night_allnum_max_rct_two_roc
, als_d15_nbank_night_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_night_orgnum_max_rct_two_roc
, als_d7_nbank_oth_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d7_nbank_oth_orgnum_max_rct_two_roc
, als_d7_nbank_oth_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d7_nbank_oth_allnum_max_rct_two_roc
, als_d15_nbank_cf_orgnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_cf_orgnum_max_rct_two_roc
, als_d15_nbank_cf_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_cf_allnum_max_rct_two_roc
, als_d15_nbank_selfnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_selfnum_max_rct_two_roc
, als_d15_nbank_nsloan_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_nbank_nsloan_allnum_max_rct_two_roc
, als_d15_coon_allnum_max_rct_two_diff/datediff(substr(created_at, 1, 10), substr(lst_created_at, 1, 10)) as als_d15_coon_allnum_max_rct_two_roc
from(
    select uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
    , als_m1_nbank_orgnum_max - lead(als_m1_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_orgnum_max_rct_two_diff
    , als_m1_nbank_else_orgnum_max - lead(als_m1_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_orgnum_max_rct_two_diff
    , als_m1_nbank_allnum_max - lead(als_m1_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_allnum_max_rct_two_diff
    , als_m1_nbank_oth_orgnum_max - lead(als_m1_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_orgnum_max_rct_two_diff
    , als_m1_nbank_else_allnum_max - lead(als_m1_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_allnum_max_rct_two_diff
    , als_m1_nbank_oth_allnum_max - lead(als_m1_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_allnum_max_rct_two_diff
    , als_m1_caon_orgnum_max - lead(als_m1_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_orgnum_max_rct_two_diff
    , als_d15_nbank_orgnum_max - lead(als_d15_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_orgnum_max_rct_two_diff
    , als_d15_nbank_allnum_max - lead(als_d15_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_allnum_max_rct_two_diff
    , als_m1_caon_allnum_max - lead(als_m1_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_allnum_max_rct_two_diff
    , als_m1_pdl_orgnum_max - lead(als_m1_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_orgnum_max_rct_two_diff
    , als_m1_nbank_cons_orgnum_max - lead(als_m1_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_orgnum_max_rct_two_diff
    , als_d15_nbank_else_orgnum_max - lead(als_d15_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_orgnum_max_rct_two_diff
    , als_m1_nbank_cons_allnum_max - lead(als_m1_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_allnum_max_rct_two_diff
    , als_d15_nbank_else_allnum_max - lead(als_d15_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_allnum_max_rct_two_diff
    , als_m1_nbank_nsloan_orgnum_max - lead(als_m1_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_orgnum_max_rct_two_diff
    , als_m1_pdl_allnum_max - lead(als_m1_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_allnum_max_rct_two_diff
    , als_d15_nbank_oth_orgnum_max - lead(als_d15_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_orgnum_max_rct_two_diff
    , als_d15_nbank_oth_allnum_max - lead(als_d15_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_allnum_max_rct_two_diff
    , als_m1_nbank_week_orgnum_max - lead(als_m1_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_orgnum_max_rct_two_diff
    , als_m1_nbank_cf_orgnum_max - lead(als_m1_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_orgnum_max_rct_two_diff
    , als_m1_nbank_week_allnum_max - lead(als_m1_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_allnum_max_rct_two_diff
    , als_m1_nbank_cf_allnum_max - lead(als_m1_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_allnum_max_rct_two_diff
    , als_lst_nbank_inteday_max - lead(als_lst_nbank_inteday_max, 1, null) over(partition by uid order by last_rn asc) as als_lst_nbank_inteday_max_rct_two_diff
    , als_m1_coon_orgnum_max - lead(als_m1_coon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_orgnum_max_rct_two_diff
    , als_m1_coon_allnum_max - lead(als_m1_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_allnum_max_rct_two_diff
    , als_m1_nbank_nsloan_allnum_max - lead(als_m1_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_allnum_max_rct_two_diff
    , als_d15_caon_orgnum_max - lead(als_d15_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_orgnum_max_rct_two_diff
    , als_d15_caon_allnum_max - lead(als_d15_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_allnum_max_rct_two_diff
    , als_d15_nbank_week_orgnum_max - lead(als_d15_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_orgnum_max_rct_two_diff
    , als_d15_nbank_week_allnum_max - lead(als_d15_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_allnum_max_rct_two_diff
    , als_d15_pdl_orgnum_max - lead(als_d15_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_orgnum_max_rct_two_diff
    , als_d15_nbank_cons_orgnum_max - lead(als_d15_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_orgnum_max_rct_two_diff
    , als_d15_pdl_allnum_max - lead(als_d15_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_allnum_max_rct_two_diff
    , als_d15_nbank_cons_allnum_max - lead(als_d15_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_allnum_max_rct_two_diff
    , als_d7_nbank_orgnum_max - lead(als_d7_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_orgnum_max_rct_two_diff
    , als_d7_nbank_allnum_max - lead(als_d7_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_allnum_max_rct_two_diff
    , als_m1_nbank_night_allnum_max - lead(als_m1_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_allnum_max_rct_two_diff
    , als_m1_nbank_night_orgnum_max - lead(als_m1_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_orgnum_max_rct_two_diff
    , als_d7_nbank_else_allnum_max - lead(als_d7_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_allnum_max_rct_two_diff
    , als_d15_nbank_nsloan_orgnum_max - lead(als_d15_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_orgnum_max_rct_two_diff
    , als_d7_nbank_else_orgnum_max - lead(als_d7_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_orgnum_max_rct_two_diff
    , als_d15_nbank_night_allnum_max - lead(als_d15_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_allnum_max_rct_two_diff
    , als_d15_nbank_night_orgnum_max - lead(als_d15_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_orgnum_max_rct_two_diff
    , als_d7_nbank_oth_orgnum_max - lead(als_d7_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_orgnum_max_rct_two_diff
    , als_d7_nbank_oth_allnum_max - lead(als_d7_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_allnum_max_rct_two_diff
    , als_d15_nbank_cf_orgnum_max - lead(als_d15_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_orgnum_max_rct_two_diff
    , als_d15_nbank_cf_allnum_max - lead(als_d15_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_allnum_max_rct_two_diff
    , als_d15_nbank_selfnum_max - lead(als_d15_nbank_selfnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_selfnum_max_rct_two_diff
    , als_d15_nbank_nsloan_allnum_max - lead(als_d15_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_allnum_max_rct_two_diff
    , als_d15_coon_allnum_max - lead(als_d15_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_coon_allnum_max_rct_two_diff
    , als_m1_nbank_orgnum_max / lead(als_m1_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_orgnum_max_rct_two_dvd
    , als_m1_nbank_else_orgnum_max / lead(als_m1_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_orgnum_max_rct_two_dvd
    , als_m1_nbank_allnum_max / lead(als_m1_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_allnum_max_rct_two_dvd
    , als_m1_nbank_oth_orgnum_max / lead(als_m1_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_orgnum_max_rct_two_dvd
    , als_m1_nbank_else_allnum_max / lead(als_m1_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_allnum_max_rct_two_dvd
    , als_m1_nbank_oth_allnum_max / lead(als_m1_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_allnum_max_rct_two_dvd
    , als_m1_caon_orgnum_max / lead(als_m1_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_orgnum_max_rct_two_dvd
    , als_d15_nbank_orgnum_max / lead(als_d15_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_orgnum_max_rct_two_dvd
    , als_d15_nbank_allnum_max / lead(als_d15_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_allnum_max_rct_two_dvd
    , als_m1_caon_allnum_max / lead(als_m1_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_allnum_max_rct_two_dvd
    , als_m1_pdl_orgnum_max / lead(als_m1_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_orgnum_max_rct_two_dvd
    , als_m1_nbank_cons_orgnum_max / lead(als_m1_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_orgnum_max_rct_two_dvd
    , als_d15_nbank_else_orgnum_max / lead(als_d15_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_orgnum_max_rct_two_dvd
    , als_m1_nbank_cons_allnum_max / lead(als_m1_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_allnum_max_rct_two_dvd
    , als_d15_nbank_else_allnum_max / lead(als_d15_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_allnum_max_rct_two_dvd
    , als_m1_nbank_nsloan_orgnum_max / lead(als_m1_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_orgnum_max_rct_two_dvd
    , als_m1_pdl_allnum_max / lead(als_m1_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_allnum_max_rct_two_dvd
    , als_d15_nbank_oth_orgnum_max / lead(als_d15_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_orgnum_max_rct_two_dvd
    , als_d15_nbank_oth_allnum_max / lead(als_d15_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_allnum_max_rct_two_dvd
    , als_m1_nbank_week_orgnum_max / lead(als_m1_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_orgnum_max_rct_two_dvd
    , als_m1_nbank_cf_orgnum_max / lead(als_m1_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_orgnum_max_rct_two_dvd
    , als_m1_nbank_week_allnum_max / lead(als_m1_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_allnum_max_rct_two_dvd
    , als_m1_nbank_cf_allnum_max / lead(als_m1_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_allnum_max_rct_two_dvd
    , als_lst_nbank_inteday_max / lead(als_lst_nbank_inteday_max, 1, null) over(partition by uid order by last_rn asc) as als_lst_nbank_inteday_max_rct_two_dvd
    , als_m1_coon_orgnum_max / lead(als_m1_coon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_orgnum_max_rct_two_dvd
    , als_m1_coon_allnum_max / lead(als_m1_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_allnum_max_rct_two_dvd
    , als_m1_nbank_nsloan_allnum_max / lead(als_m1_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_allnum_max_rct_two_dvd
    , als_d15_caon_orgnum_max / lead(als_d15_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_orgnum_max_rct_two_dvd
    , als_d15_caon_allnum_max / lead(als_d15_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_allnum_max_rct_two_dvd
    , als_d15_nbank_week_orgnum_max / lead(als_d15_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_orgnum_max_rct_two_dvd
    , als_d15_nbank_week_allnum_max / lead(als_d15_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_allnum_max_rct_two_dvd
    , als_d15_pdl_orgnum_max / lead(als_d15_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_orgnum_max_rct_two_dvd
    , als_d15_nbank_cons_orgnum_max / lead(als_d15_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_orgnum_max_rct_two_dvd
    , als_d15_pdl_allnum_max / lead(als_d15_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_allnum_max_rct_two_dvd
    , als_d15_nbank_cons_allnum_max / lead(als_d15_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_allnum_max_rct_two_dvd
    , als_d7_nbank_orgnum_max / lead(als_d7_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_orgnum_max_rct_two_dvd
    , als_d7_nbank_allnum_max / lead(als_d7_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_allnum_max_rct_two_dvd
    , als_m1_nbank_night_allnum_max / lead(als_m1_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_allnum_max_rct_two_dvd
    , als_m1_nbank_night_orgnum_max / lead(als_m1_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_orgnum_max_rct_two_dvd
    , als_d7_nbank_else_allnum_max / lead(als_d7_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_allnum_max_rct_two_dvd
    , als_d15_nbank_nsloan_orgnum_max / lead(als_d15_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_orgnum_max_rct_two_dvd
    , als_d7_nbank_else_orgnum_max / lead(als_d7_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_orgnum_max_rct_two_dvd
    , als_d15_nbank_night_allnum_max / lead(als_d15_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_allnum_max_rct_two_dvd
    , als_d15_nbank_night_orgnum_max / lead(als_d15_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_orgnum_max_rct_two_dvd
    , als_d7_nbank_oth_orgnum_max / lead(als_d7_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_orgnum_max_rct_two_dvd
    , als_d7_nbank_oth_allnum_max / lead(als_d7_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_allnum_max_rct_two_dvd
    , als_d15_nbank_cf_orgnum_max / lead(als_d15_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_orgnum_max_rct_two_dvd
    , als_d15_nbank_cf_allnum_max / lead(als_d15_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_allnum_max_rct_two_dvd
    , als_d15_nbank_selfnum_max / lead(als_d15_nbank_selfnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_selfnum_max_rct_two_dvd
    , als_d15_nbank_nsloan_allnum_max / lead(als_d15_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_allnum_max_rct_two_dvd
    , als_d15_coon_allnum_max / lead(als_d15_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_coon_allnum_max_rct_two_dvd
    , lead(date(created_at), 1, null) over(partition by uid order by last_rn asc) as lst_created_at
    from pdm_risk.pdm_risk_dz_br_max_two_report_rct_two_coalesce
    -- where uid in ('00025809-325c-4ef5-bec0-6f10c56e0435', '00025809-325c-4ef5-bec0-6f10c56e0435', '002bfccd-d509-4e27-8ec6-f0d2c72b2797')  
)a
where last_rn = 1

;



-- 2. 上个月最近
drop table if exists pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two_coalesce;
create table pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two_coalesce as
select *
from pdm_risk.pdm_risk_dz_br_max_two_report_rct_two_coalesce
where last_rn = 1
union all
select uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
, coalesce(als_m1_nbank_orgnum_max, 0) as als_m1_nbank_orgnum_max
, coalesce(als_m1_nbank_else_orgnum_max, 0) as als_m1_nbank_else_orgnum_max
, coalesce(als_m1_nbank_allnum_max, 0) as als_m1_nbank_allnum_max
, coalesce(als_m1_nbank_oth_orgnum_max, 0) as als_m1_nbank_oth_orgnum_max
, coalesce(als_m1_nbank_else_allnum_max, 0) as als_m1_nbank_else_allnum_max
, coalesce(als_m1_nbank_oth_allnum_max, 0) as als_m1_nbank_oth_allnum_max
, coalesce(als_m1_caon_orgnum_max, 0) as als_m1_caon_orgnum_max
, coalesce(als_d15_nbank_orgnum_max, 0) as als_d15_nbank_orgnum_max
, coalesce(als_d15_nbank_allnum_max, 0) as als_d15_nbank_allnum_max
, coalesce(als_m1_caon_allnum_max, 0) as als_m1_caon_allnum_max
, coalesce(als_m1_pdl_orgnum_max, 0) as als_m1_pdl_orgnum_max
, coalesce(als_m1_nbank_cons_orgnum_max, 0) as als_m1_nbank_cons_orgnum_max
, coalesce(als_d15_nbank_else_orgnum_max, 0) as als_d15_nbank_else_orgnum_max
, coalesce(als_m1_nbank_cons_allnum_max, 0) as als_m1_nbank_cons_allnum_max
, coalesce(als_d15_nbank_else_allnum_max, 0) as als_d15_nbank_else_allnum_max
, coalesce(als_m1_nbank_nsloan_orgnum_max, 0) as als_m1_nbank_nsloan_orgnum_max
, coalesce(als_m1_pdl_allnum_max, 0) as als_m1_pdl_allnum_max
, coalesce(als_d15_nbank_oth_orgnum_max, 0) as als_d15_nbank_oth_orgnum_max
, coalesce(als_d15_nbank_oth_allnum_max, 0) as als_d15_nbank_oth_allnum_max
, coalesce(als_m1_nbank_week_orgnum_max, 0) as als_m1_nbank_week_orgnum_max
, coalesce(als_m1_nbank_cf_orgnum_max, 0) as als_m1_nbank_cf_orgnum_max
, coalesce(als_m1_nbank_week_allnum_max, 0) as als_m1_nbank_week_allnum_max
, coalesce(als_m1_nbank_cf_allnum_max, 0) as als_m1_nbank_cf_allnum_max
, coalesce(als_lst_nbank_inteday_max, 0) as als_lst_nbank_inteday_max
, coalesce(als_m1_coon_orgnum_max, 0) as als_m1_coon_orgnum_max
, coalesce(als_m1_coon_allnum_max, 0) as als_m1_coon_allnum_max
, coalesce(als_m1_nbank_nsloan_allnum_max, 0) as als_m1_nbank_nsloan_allnum_max
, coalesce(als_d15_caon_orgnum_max, 0) as als_d15_caon_orgnum_max
, coalesce(als_d15_caon_allnum_max, 0) as als_d15_caon_allnum_max
, coalesce(als_d15_nbank_week_orgnum_max, 0) as als_d15_nbank_week_orgnum_max
, coalesce(als_d15_nbank_week_allnum_max, 0) as als_d15_nbank_week_allnum_max
, coalesce(als_d15_pdl_orgnum_max, 0) as als_d15_pdl_orgnum_max
, coalesce(als_d15_nbank_cons_orgnum_max, 0) as als_d15_nbank_cons_orgnum_max
, coalesce(als_d15_pdl_allnum_max, 0) as als_d15_pdl_allnum_max
, coalesce(als_d15_nbank_cons_allnum_max, 0) as als_d15_nbank_cons_allnum_max
, coalesce(als_d7_nbank_orgnum_max, 0) as als_d7_nbank_orgnum_max
, coalesce(als_d7_nbank_allnum_max, 0) as als_d7_nbank_allnum_max
, coalesce(als_m1_nbank_night_allnum_max, 0) as als_m1_nbank_night_allnum_max
, coalesce(als_m1_nbank_night_orgnum_max, 0) as als_m1_nbank_night_orgnum_max
, coalesce(als_d7_nbank_else_allnum_max, 0) as als_d7_nbank_else_allnum_max
, coalesce(als_d15_nbank_nsloan_orgnum_max, 0) as als_d15_nbank_nsloan_orgnum_max
, coalesce(als_d7_nbank_else_orgnum_max, 0) as als_d7_nbank_else_orgnum_max
, coalesce(als_d15_nbank_night_allnum_max, 0) as als_d15_nbank_night_allnum_max
, coalesce(als_d15_nbank_night_orgnum_max, 0) as als_d15_nbank_night_orgnum_max
, coalesce(als_d7_nbank_oth_orgnum_max, 0) as als_d7_nbank_oth_orgnum_max
, coalesce(als_d7_nbank_oth_allnum_max, 0) as als_d7_nbank_oth_allnum_max
, coalesce(als_d15_nbank_cf_orgnum_max, 0) as als_d15_nbank_cf_orgnum_max
, coalesce(als_d15_nbank_cf_allnum_max, 0) as als_d15_nbank_cf_allnum_max
, coalesce(als_d15_nbank_selfnum_max, 0) as als_d15_nbank_selfnum_max
, coalesce(als_d15_nbank_nsloan_allnum_max, 0) as als_d15_nbank_nsloan_allnum_max
, coalesce(als_d15_coon_allnum_max, 0) as als_d15_coon_allnum_max
from(
    select *
	, row_number() over(partition by uid order by created_at desc) as rn
    from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
    where ds = '${bizdate}'
    and substr(created_at, 1, 10) <= last_day(ADD_MONTHS(to_date('${bizdate}', 'yyyymmdd'), -1)) -- <=上个月最后一天
	-- and uid IN ('00025809-325c-4ef5-bec0-6f10c56e0435','002bfccd-d509-4e27-8ec6-f0d2c72b2797')
) as b
where b.rn = 1

;


drop table if exists pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two;
create table pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two as
select uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
, datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as rct_mon_two_dte_len
-- 1-2
, als_m1_nbank_orgnum_max_rct_mon_two_diff
, als_m1_nbank_else_orgnum_max_rct_mon_two_diff
, als_m1_nbank_allnum_max_rct_mon_two_diff
, als_m1_nbank_oth_orgnum_max_rct_mon_two_diff
, als_m1_nbank_else_allnum_max_rct_mon_two_diff
, als_m1_nbank_oth_allnum_max_rct_mon_two_diff
, als_m1_caon_orgnum_max_rct_mon_two_diff
, als_d15_nbank_orgnum_max_rct_mon_two_diff
, als_d15_nbank_allnum_max_rct_mon_two_diff
, als_m1_caon_allnum_max_rct_mon_two_diff
, als_m1_pdl_orgnum_max_rct_mon_two_diff
, als_m1_nbank_cons_orgnum_max_rct_mon_two_diff
, als_d15_nbank_else_orgnum_max_rct_mon_two_diff
, als_m1_nbank_cons_allnum_max_rct_mon_two_diff
, als_d15_nbank_else_allnum_max_rct_mon_two_diff
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_diff
, als_m1_pdl_allnum_max_rct_mon_two_diff
, als_d15_nbank_oth_orgnum_max_rct_mon_two_diff
, als_d15_nbank_oth_allnum_max_rct_mon_two_diff
, als_m1_nbank_week_orgnum_max_rct_mon_two_diff
, als_m1_nbank_cf_orgnum_max_rct_mon_two_diff
, als_m1_nbank_week_allnum_max_rct_mon_two_diff
, als_m1_nbank_cf_allnum_max_rct_mon_two_diff
, als_lst_nbank_inteday_max_rct_mon_two_diff
, als_m1_coon_orgnum_max_rct_mon_two_diff
, als_m1_coon_allnum_max_rct_mon_two_diff
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_diff
, als_d15_caon_orgnum_max_rct_mon_two_diff
, als_d15_caon_allnum_max_rct_mon_two_diff
, als_d15_nbank_week_orgnum_max_rct_mon_two_diff
, als_d15_nbank_week_allnum_max_rct_mon_two_diff
, als_d15_pdl_orgnum_max_rct_mon_two_diff
, als_d15_nbank_cons_orgnum_max_rct_mon_two_diff
, als_d15_pdl_allnum_max_rct_mon_two_diff
, als_d15_nbank_cons_allnum_max_rct_mon_two_diff
, als_d7_nbank_orgnum_max_rct_mon_two_diff
, als_d7_nbank_allnum_max_rct_mon_two_diff
, als_m1_nbank_night_allnum_max_rct_mon_two_diff
, als_m1_nbank_night_orgnum_max_rct_mon_two_diff
, als_d7_nbank_else_allnum_max_rct_mon_two_diff
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_diff
, als_d7_nbank_else_orgnum_max_rct_mon_two_diff
, als_d15_nbank_night_allnum_max_rct_mon_two_diff
, als_d15_nbank_night_orgnum_max_rct_mon_two_diff
, als_d7_nbank_oth_orgnum_max_rct_mon_two_diff
, als_d7_nbank_oth_allnum_max_rct_mon_two_diff
, als_d15_nbank_cf_orgnum_max_rct_mon_two_diff
, als_d15_nbank_cf_allnum_max_rct_mon_two_diff
, als_d15_nbank_selfnum_max_rct_mon_two_diff
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_diff
, als_d15_coon_allnum_max_rct_mon_two_diff
-- 1/2
, als_m1_nbank_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_else_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_allnum_max_rct_mon_two_dvd
, als_m1_nbank_oth_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_else_allnum_max_rct_mon_two_dvd
, als_m1_nbank_oth_allnum_max_rct_mon_two_dvd
, als_m1_caon_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_allnum_max_rct_mon_two_dvd
, als_m1_caon_allnum_max_rct_mon_two_dvd
, als_m1_pdl_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_cons_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_else_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_cons_allnum_max_rct_mon_two_dvd
, als_d15_nbank_else_allnum_max_rct_mon_two_dvd
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_dvd
, als_m1_pdl_allnum_max_rct_mon_two_dvd
, als_d15_nbank_oth_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_oth_allnum_max_rct_mon_two_dvd
, als_m1_nbank_week_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_cf_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_week_allnum_max_rct_mon_two_dvd
, als_m1_nbank_cf_allnum_max_rct_mon_two_dvd
, als_lst_nbank_inteday_max_rct_mon_two_dvd
, als_m1_coon_orgnum_max_rct_mon_two_dvd
, als_m1_coon_allnum_max_rct_mon_two_dvd
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_dvd
, als_d15_caon_orgnum_max_rct_mon_two_dvd
, als_d15_caon_allnum_max_rct_mon_two_dvd
, als_d15_nbank_week_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_week_allnum_max_rct_mon_two_dvd
, als_d15_pdl_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_cons_orgnum_max_rct_mon_two_dvd
, als_d15_pdl_allnum_max_rct_mon_two_dvd
, als_d15_nbank_cons_allnum_max_rct_mon_two_dvd
, als_d7_nbank_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_allnum_max_rct_mon_two_dvd
, als_m1_nbank_night_allnum_max_rct_mon_two_dvd
, als_m1_nbank_night_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_else_allnum_max_rct_mon_two_dvd
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_else_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_night_allnum_max_rct_mon_two_dvd
, als_d15_nbank_night_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_oth_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_oth_allnum_max_rct_mon_two_dvd
, als_d15_nbank_cf_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_cf_allnum_max_rct_mon_two_dvd
, als_d15_nbank_selfnum_max_rct_mon_two_dvd
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_dvd
, als_d15_coon_allnum_max_rct_mon_two_dvd
-- 1-2/tme_len
, als_m1_nbank_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_orgnum_max_rct_mon_two_roc
, als_m1_nbank_else_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_else_orgnum_max_rct_mon_two_roc
, als_m1_nbank_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_allnum_max_rct_mon_two_roc
, als_m1_nbank_oth_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_oth_orgnum_max_rct_mon_two_roc
, als_m1_nbank_else_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_else_allnum_max_rct_mon_two_roc
, als_m1_nbank_oth_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_oth_allnum_max_rct_mon_two_roc
, als_m1_caon_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_caon_orgnum_max_rct_mon_two_roc
, als_d15_nbank_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_orgnum_max_rct_mon_two_roc
, als_d15_nbank_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_allnum_max_rct_mon_two_roc
, als_m1_caon_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_caon_allnum_max_rct_mon_two_roc
, als_m1_pdl_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_pdl_orgnum_max_rct_mon_two_roc
, als_m1_nbank_cons_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_cons_orgnum_max_rct_mon_two_roc
, als_d15_nbank_else_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_else_orgnum_max_rct_mon_two_roc
, als_m1_nbank_cons_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_cons_allnum_max_rct_mon_two_roc
, als_d15_nbank_else_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_else_allnum_max_rct_mon_two_roc
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_nsloan_orgnum_max_rct_mon_two_roc
, als_m1_pdl_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_pdl_allnum_max_rct_mon_two_roc
, als_d15_nbank_oth_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_oth_orgnum_max_rct_mon_two_roc
, als_d15_nbank_oth_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_oth_allnum_max_rct_mon_two_roc
, als_m1_nbank_week_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_week_orgnum_max_rct_mon_two_roc
, als_m1_nbank_cf_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_cf_orgnum_max_rct_mon_two_roc
, als_m1_nbank_week_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_week_allnum_max_rct_mon_two_roc
, als_m1_nbank_cf_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_cf_allnum_max_rct_mon_two_roc
, als_lst_nbank_inteday_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_lst_nbank_inteday_max_rct_mon_two_roc
, als_m1_coon_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_coon_orgnum_max_rct_mon_two_roc
, als_m1_coon_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_coon_allnum_max_rct_mon_two_roc
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_nsloan_allnum_max_rct_mon_two_roc
, als_d15_caon_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_caon_orgnum_max_rct_mon_two_roc
, als_d15_caon_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_caon_allnum_max_rct_mon_two_roc
, als_d15_nbank_week_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_week_orgnum_max_rct_mon_two_roc
, als_d15_nbank_week_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_week_allnum_max_rct_mon_two_roc
, als_d15_pdl_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_pdl_orgnum_max_rct_mon_two_roc
, als_d15_nbank_cons_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_cons_orgnum_max_rct_mon_two_roc
, als_d15_pdl_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_pdl_allnum_max_rct_mon_two_roc
, als_d15_nbank_cons_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_cons_allnum_max_rct_mon_two_roc
, als_d7_nbank_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d7_nbank_orgnum_max_rct_mon_two_roc
, als_d7_nbank_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d7_nbank_allnum_max_rct_mon_two_roc
, als_m1_nbank_night_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_night_allnum_max_rct_mon_two_roc
, als_m1_nbank_night_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_m1_nbank_night_orgnum_max_rct_mon_two_roc
, als_d7_nbank_else_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d7_nbank_else_allnum_max_rct_mon_two_roc
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_nsloan_orgnum_max_rct_mon_two_roc
, als_d7_nbank_else_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d7_nbank_else_orgnum_max_rct_mon_two_roc
, als_d15_nbank_night_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_night_allnum_max_rct_mon_two_roc
, als_d15_nbank_night_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_night_orgnum_max_rct_mon_two_roc
, als_d7_nbank_oth_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d7_nbank_oth_orgnum_max_rct_mon_two_roc
, als_d7_nbank_oth_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d7_nbank_oth_allnum_max_rct_mon_two_roc
, als_d15_nbank_cf_orgnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_cf_orgnum_max_rct_mon_two_roc
, als_d15_nbank_cf_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_cf_allnum_max_rct_mon_two_roc
, als_d15_nbank_selfnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_selfnum_max_rct_mon_two_roc
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_nbank_nsloan_allnum_max_rct_mon_two_roc
, als_d15_coon_allnum_max_rct_mon_two_diff/datediff(substr(created_at, 1, 10), substr(rct_mon_lst_created_at, 1, 10)) as als_d15_coon_allnum_max_rct_mon_two_roc
from(
    select uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
    , als_m1_nbank_orgnum_max - lead(als_m1_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_orgnum_max_rct_mon_two_diff
    , als_m1_nbank_else_orgnum_max - lead(als_m1_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_orgnum_max_rct_mon_two_diff
    , als_m1_nbank_allnum_max - lead(als_m1_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_allnum_max_rct_mon_two_diff
    , als_m1_nbank_oth_orgnum_max - lead(als_m1_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_orgnum_max_rct_mon_two_diff
    , als_m1_nbank_else_allnum_max - lead(als_m1_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_allnum_max_rct_mon_two_diff
    , als_m1_nbank_oth_allnum_max - lead(als_m1_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_allnum_max_rct_mon_two_diff
    , als_m1_caon_orgnum_max - lead(als_m1_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_orgnum_max - lead(als_d15_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_allnum_max - lead(als_d15_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_allnum_max_rct_mon_two_diff
    , als_m1_caon_allnum_max - lead(als_m1_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_allnum_max_rct_mon_two_diff
    , als_m1_pdl_orgnum_max - lead(als_m1_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_orgnum_max_rct_mon_two_diff
    , als_m1_nbank_cons_orgnum_max - lead(als_m1_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_else_orgnum_max - lead(als_d15_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_orgnum_max_rct_mon_two_diff
    , als_m1_nbank_cons_allnum_max - lead(als_m1_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_allnum_max_rct_mon_two_diff
    , als_d15_nbank_else_allnum_max - lead(als_d15_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_allnum_max_rct_mon_two_diff
    , als_m1_nbank_nsloan_orgnum_max - lead(als_m1_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_orgnum_max_rct_mon_two_diff
    , als_m1_pdl_allnum_max - lead(als_m1_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_allnum_max_rct_mon_two_diff
    , als_d15_nbank_oth_orgnum_max - lead(als_d15_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_oth_allnum_max - lead(als_d15_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_allnum_max_rct_mon_two_diff
    , als_m1_nbank_week_orgnum_max - lead(als_m1_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_orgnum_max_rct_mon_two_diff
    , als_m1_nbank_cf_orgnum_max - lead(als_m1_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_orgnum_max_rct_mon_two_diff
    , als_m1_nbank_week_allnum_max - lead(als_m1_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_allnum_max_rct_mon_two_diff
    , als_m1_nbank_cf_allnum_max - lead(als_m1_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_allnum_max_rct_mon_two_diff
    , als_lst_nbank_inteday_max - lead(als_lst_nbank_inteday_max, 1, null) over(partition by uid order by last_rn asc) as als_lst_nbank_inteday_max_rct_mon_two_diff
    , als_m1_coon_orgnum_max - lead(als_m1_coon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_orgnum_max_rct_mon_two_diff
    , als_m1_coon_allnum_max - lead(als_m1_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_allnum_max_rct_mon_two_diff
    , als_m1_nbank_nsloan_allnum_max - lead(als_m1_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_allnum_max_rct_mon_two_diff
    , als_d15_caon_orgnum_max - lead(als_d15_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_orgnum_max_rct_mon_two_diff
    , als_d15_caon_allnum_max - lead(als_d15_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_allnum_max_rct_mon_two_diff
    , als_d15_nbank_week_orgnum_max - lead(als_d15_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_week_allnum_max - lead(als_d15_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_allnum_max_rct_mon_two_diff
    , als_d15_pdl_orgnum_max - lead(als_d15_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_cons_orgnum_max - lead(als_d15_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_orgnum_max_rct_mon_two_diff
    , als_d15_pdl_allnum_max - lead(als_d15_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_allnum_max_rct_mon_two_diff
    , als_d15_nbank_cons_allnum_max - lead(als_d15_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_allnum_max_rct_mon_two_diff
    , als_d7_nbank_orgnum_max - lead(als_d7_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_orgnum_max_rct_mon_two_diff
    , als_d7_nbank_allnum_max - lead(als_d7_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_allnum_max_rct_mon_two_diff
    , als_m1_nbank_night_allnum_max - lead(als_m1_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_allnum_max_rct_mon_two_diff
    , als_m1_nbank_night_orgnum_max - lead(als_m1_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_orgnum_max_rct_mon_two_diff
    , als_d7_nbank_else_allnum_max - lead(als_d7_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_allnum_max_rct_mon_two_diff
    , als_d15_nbank_nsloan_orgnum_max - lead(als_d15_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_orgnum_max_rct_mon_two_diff
    , als_d7_nbank_else_orgnum_max - lead(als_d7_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_night_allnum_max - lead(als_d15_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_allnum_max_rct_mon_two_diff
    , als_d15_nbank_night_orgnum_max - lead(als_d15_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_orgnum_max_rct_mon_two_diff
    , als_d7_nbank_oth_orgnum_max - lead(als_d7_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_orgnum_max_rct_mon_two_diff
    , als_d7_nbank_oth_allnum_max - lead(als_d7_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_allnum_max_rct_mon_two_diff
    , als_d15_nbank_cf_orgnum_max - lead(als_d15_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_orgnum_max_rct_mon_two_diff
    , als_d15_nbank_cf_allnum_max - lead(als_d15_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_allnum_max_rct_mon_two_diff
    , als_d15_nbank_selfnum_max - lead(als_d15_nbank_selfnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_selfnum_max_rct_mon_two_diff
    , als_d15_nbank_nsloan_allnum_max - lead(als_d15_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_allnum_max_rct_mon_two_diff
    , als_d15_coon_allnum_max - lead(als_d15_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_coon_allnum_max_rct_mon_two_diff
    , als_m1_nbank_orgnum_max / lead(als_m1_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_orgnum_max_rct_mon_two_dvd
    , als_m1_nbank_else_orgnum_max / lead(als_m1_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_orgnum_max_rct_mon_two_dvd
    , als_m1_nbank_allnum_max / lead(als_m1_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_oth_orgnum_max / lead(als_m1_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_orgnum_max_rct_mon_two_dvd
    , als_m1_nbank_else_allnum_max / lead(als_m1_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_else_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_oth_allnum_max / lead(als_m1_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_oth_allnum_max_rct_mon_two_dvd
    , als_m1_caon_orgnum_max / lead(als_m1_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_orgnum_max / lead(als_d15_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_allnum_max / lead(als_d15_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_allnum_max_rct_mon_two_dvd
    , als_m1_caon_allnum_max / lead(als_m1_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_caon_allnum_max_rct_mon_two_dvd
    , als_m1_pdl_orgnum_max / lead(als_m1_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_orgnum_max_rct_mon_two_dvd
    , als_m1_nbank_cons_orgnum_max / lead(als_m1_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_else_orgnum_max / lead(als_d15_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_orgnum_max_rct_mon_two_dvd
    , als_m1_nbank_cons_allnum_max / lead(als_m1_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cons_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_else_allnum_max / lead(als_d15_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_else_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_nsloan_orgnum_max / lead(als_m1_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_orgnum_max_rct_mon_two_dvd
    , als_m1_pdl_allnum_max / lead(als_m1_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_pdl_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_oth_orgnum_max / lead(als_d15_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_oth_allnum_max / lead(als_d15_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_oth_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_week_orgnum_max / lead(als_m1_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_orgnum_max_rct_mon_two_dvd
    , als_m1_nbank_cf_orgnum_max / lead(als_m1_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_orgnum_max_rct_mon_two_dvd
    , als_m1_nbank_week_allnum_max / lead(als_m1_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_week_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_cf_allnum_max / lead(als_m1_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_cf_allnum_max_rct_mon_two_dvd
    , als_lst_nbank_inteday_max / lead(als_lst_nbank_inteday_max, 1, null) over(partition by uid order by last_rn asc) as als_lst_nbank_inteday_max_rct_mon_two_dvd
    , als_m1_coon_orgnum_max / lead(als_m1_coon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_orgnum_max_rct_mon_two_dvd
    , als_m1_coon_allnum_max / lead(als_m1_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_coon_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_nsloan_allnum_max / lead(als_m1_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_nsloan_allnum_max_rct_mon_two_dvd
    , als_d15_caon_orgnum_max / lead(als_d15_caon_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_orgnum_max_rct_mon_two_dvd
    , als_d15_caon_allnum_max / lead(als_d15_caon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_caon_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_week_orgnum_max / lead(als_d15_nbank_week_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_week_allnum_max / lead(als_d15_nbank_week_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_week_allnum_max_rct_mon_two_dvd
    , als_d15_pdl_orgnum_max / lead(als_d15_pdl_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_cons_orgnum_max / lead(als_d15_nbank_cons_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_orgnum_max_rct_mon_two_dvd
    , als_d15_pdl_allnum_max / lead(als_d15_pdl_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_pdl_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_cons_allnum_max / lead(als_d15_nbank_cons_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cons_allnum_max_rct_mon_two_dvd
    , als_d7_nbank_orgnum_max / lead(als_d7_nbank_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_orgnum_max_rct_mon_two_dvd
    , als_d7_nbank_allnum_max / lead(als_d7_nbank_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_night_allnum_max / lead(als_m1_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_allnum_max_rct_mon_two_dvd
    , als_m1_nbank_night_orgnum_max / lead(als_m1_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_m1_nbank_night_orgnum_max_rct_mon_two_dvd
    , als_d7_nbank_else_allnum_max / lead(als_d7_nbank_else_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_nsloan_orgnum_max / lead(als_d15_nbank_nsloan_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_orgnum_max_rct_mon_two_dvd
    , als_d7_nbank_else_orgnum_max / lead(als_d7_nbank_else_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_else_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_night_allnum_max / lead(als_d15_nbank_night_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_night_orgnum_max / lead(als_d15_nbank_night_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_night_orgnum_max_rct_mon_two_dvd
    , als_d7_nbank_oth_orgnum_max / lead(als_d7_nbank_oth_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_orgnum_max_rct_mon_two_dvd
    , als_d7_nbank_oth_allnum_max / lead(als_d7_nbank_oth_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d7_nbank_oth_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_cf_orgnum_max / lead(als_d15_nbank_cf_orgnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_orgnum_max_rct_mon_two_dvd
    , als_d15_nbank_cf_allnum_max / lead(als_d15_nbank_cf_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_cf_allnum_max_rct_mon_two_dvd
    , als_d15_nbank_selfnum_max / lead(als_d15_nbank_selfnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_selfnum_max_rct_mon_two_dvd
    , als_d15_nbank_nsloan_allnum_max / lead(als_d15_nbank_nsloan_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_nbank_nsloan_allnum_max_rct_mon_two_dvd
    , als_d15_coon_allnum_max / lead(als_d15_coon_allnum_max, 1, null) over(partition by uid order by last_rn asc) as als_d15_coon_allnum_max_rct_mon_two_dvd
    , lead(date(created_at), 1, null) over(partition by uid order by last_rn asc) as rct_mon_lst_created_at
    from pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two_coalesce
    -- where uid in ('00025809-325c-4ef5-bec0-6f10c56e0435', '00025809-325c-4ef5-bec0-6f10c56e0435', '002bfccd-d509-4e27-8ec6-f0d2c72b2797')  
)a
where last_rn = 1

;




insert overwrite table pdm_risk.pdm_risk_dz_br_max_two_report_feature_final_di partition(ds='${bizdate}')
select a.uid, b.data_id, b.code, b.flag_applyloanstr, b.swift_number, b.created_at, b.updated_at
-- 1. 最近一份
, rct_two_dte_len
, als_m1_nbank_orgnum_max_rct_two_diff
, als_m1_nbank_else_orgnum_max_rct_two_diff
, als_m1_nbank_allnum_max_rct_two_diff
, als_m1_nbank_oth_orgnum_max_rct_two_diff
, als_m1_nbank_else_allnum_max_rct_two_diff
, als_m1_nbank_oth_allnum_max_rct_two_diff
, als_m1_caon_orgnum_max_rct_two_diff
, als_d15_nbank_orgnum_max_rct_two_diff
, als_d15_nbank_allnum_max_rct_two_diff
, als_m1_caon_allnum_max_rct_two_diff
, als_m1_pdl_orgnum_max_rct_two_diff
, als_m1_nbank_cons_orgnum_max_rct_two_diff
, als_d15_nbank_else_orgnum_max_rct_two_diff
, als_m1_nbank_cons_allnum_max_rct_two_diff
, als_d15_nbank_else_allnum_max_rct_two_diff
, als_m1_nbank_nsloan_orgnum_max_rct_two_diff
, als_m1_pdl_allnum_max_rct_two_diff
, als_d15_nbank_oth_orgnum_max_rct_two_diff
, als_d15_nbank_oth_allnum_max_rct_two_diff
, als_m1_nbank_week_orgnum_max_rct_two_diff
, als_m1_nbank_cf_orgnum_max_rct_two_diff
, als_m1_nbank_week_allnum_max_rct_two_diff
, als_m1_nbank_cf_allnum_max_rct_two_diff
, als_lst_nbank_inteday_max_rct_two_diff
, als_m1_coon_orgnum_max_rct_two_diff
, als_m1_coon_allnum_max_rct_two_diff
, als_m1_nbank_nsloan_allnum_max_rct_two_diff
, als_d15_caon_orgnum_max_rct_two_diff
, als_d15_caon_allnum_max_rct_two_diff
, als_d15_nbank_week_orgnum_max_rct_two_diff
, als_d15_nbank_week_allnum_max_rct_two_diff
, als_d15_pdl_orgnum_max_rct_two_diff
, als_d15_nbank_cons_orgnum_max_rct_two_diff
, als_d15_pdl_allnum_max_rct_two_diff
, als_d15_nbank_cons_allnum_max_rct_two_diff
, als_d7_nbank_orgnum_max_rct_two_diff
, als_d7_nbank_allnum_max_rct_two_diff
, als_m1_nbank_night_allnum_max_rct_two_diff
, als_m1_nbank_night_orgnum_max_rct_two_diff
, als_d7_nbank_else_allnum_max_rct_two_diff
, als_d15_nbank_nsloan_orgnum_max_rct_two_diff
, als_d7_nbank_else_orgnum_max_rct_two_diff
, als_d15_nbank_night_allnum_max_rct_two_diff
, als_d15_nbank_night_orgnum_max_rct_two_diff
, als_d7_nbank_oth_orgnum_max_rct_two_diff
, als_d7_nbank_oth_allnum_max_rct_two_diff
, als_d15_nbank_cf_orgnum_max_rct_two_diff
, als_d15_nbank_cf_allnum_max_rct_two_diff
, als_d15_nbank_selfnum_max_rct_two_diff
, als_d15_nbank_nsloan_allnum_max_rct_two_diff
, als_d15_coon_allnum_max_rct_two_diff
, als_m1_nbank_orgnum_max_rct_two_dvd
, als_m1_nbank_else_orgnum_max_rct_two_dvd
, als_m1_nbank_allnum_max_rct_two_dvd
, als_m1_nbank_oth_orgnum_max_rct_two_dvd
, als_m1_nbank_else_allnum_max_rct_two_dvd
, als_m1_nbank_oth_allnum_max_rct_two_dvd
, als_m1_caon_orgnum_max_rct_two_dvd
, als_d15_nbank_orgnum_max_rct_two_dvd
, als_d15_nbank_allnum_max_rct_two_dvd
, als_m1_caon_allnum_max_rct_two_dvd
, als_m1_pdl_orgnum_max_rct_two_dvd
, als_m1_nbank_cons_orgnum_max_rct_two_dvd
, als_d15_nbank_else_orgnum_max_rct_two_dvd
, als_m1_nbank_cons_allnum_max_rct_two_dvd
, als_d15_nbank_else_allnum_max_rct_two_dvd
, als_m1_nbank_nsloan_orgnum_max_rct_two_dvd
, als_m1_pdl_allnum_max_rct_two_dvd
, als_d15_nbank_oth_orgnum_max_rct_two_dvd
, als_d15_nbank_oth_allnum_max_rct_two_dvd
, als_m1_nbank_week_orgnum_max_rct_two_dvd
, als_m1_nbank_cf_orgnum_max_rct_two_dvd
, als_m1_nbank_week_allnum_max_rct_two_dvd
, als_m1_nbank_cf_allnum_max_rct_two_dvd
, als_lst_nbank_inteday_max_rct_two_dvd
, als_m1_coon_orgnum_max_rct_two_dvd
, als_m1_coon_allnum_max_rct_two_dvd
, als_m1_nbank_nsloan_allnum_max_rct_two_dvd
, als_d15_caon_orgnum_max_rct_two_dvd
, als_d15_caon_allnum_max_rct_two_dvd
, als_d15_nbank_week_orgnum_max_rct_two_dvd
, als_d15_nbank_week_allnum_max_rct_two_dvd
, als_d15_pdl_orgnum_max_rct_two_dvd
, als_d15_nbank_cons_orgnum_max_rct_two_dvd
, als_d15_pdl_allnum_max_rct_two_dvd
, als_d15_nbank_cons_allnum_max_rct_two_dvd
, als_d7_nbank_orgnum_max_rct_two_dvd
, als_d7_nbank_allnum_max_rct_two_dvd
, als_m1_nbank_night_allnum_max_rct_two_dvd
, als_m1_nbank_night_orgnum_max_rct_two_dvd
, als_d7_nbank_else_allnum_max_rct_two_dvd
, als_d15_nbank_nsloan_orgnum_max_rct_two_dvd
, als_d7_nbank_else_orgnum_max_rct_two_dvd
, als_d15_nbank_night_allnum_max_rct_two_dvd
, als_d15_nbank_night_orgnum_max_rct_two_dvd
, als_d7_nbank_oth_orgnum_max_rct_two_dvd
, als_d7_nbank_oth_allnum_max_rct_two_dvd
, als_d15_nbank_cf_orgnum_max_rct_two_dvd
, als_d15_nbank_cf_allnum_max_rct_two_dvd
, als_d15_nbank_selfnum_max_rct_two_dvd
, als_d15_nbank_nsloan_allnum_max_rct_two_dvd
, als_d15_coon_allnum_max_rct_two_dvd
, als_m1_nbank_orgnum_max_rct_two_roc
, als_m1_nbank_else_orgnum_max_rct_two_roc
, als_m1_nbank_allnum_max_rct_two_roc
, als_m1_nbank_oth_orgnum_max_rct_two_roc
, als_m1_nbank_else_allnum_max_rct_two_roc
, als_m1_nbank_oth_allnum_max_rct_two_roc
, als_m1_caon_orgnum_max_rct_two_roc
, als_d15_nbank_orgnum_max_rct_two_roc
, als_d15_nbank_allnum_max_rct_two_roc
, als_m1_caon_allnum_max_rct_two_roc
, als_m1_pdl_orgnum_max_rct_two_roc
, als_m1_nbank_cons_orgnum_max_rct_two_roc
, als_d15_nbank_else_orgnum_max_rct_two_roc
, als_m1_nbank_cons_allnum_max_rct_two_roc
, als_d15_nbank_else_allnum_max_rct_two_roc
, als_m1_nbank_nsloan_orgnum_max_rct_two_roc
, als_m1_pdl_allnum_max_rct_two_roc
, als_d15_nbank_oth_orgnum_max_rct_two_roc
, als_d15_nbank_oth_allnum_max_rct_two_roc
, als_m1_nbank_week_orgnum_max_rct_two_roc
, als_m1_nbank_cf_orgnum_max_rct_two_roc
, als_m1_nbank_week_allnum_max_rct_two_roc
, als_m1_nbank_cf_allnum_max_rct_two_roc
, als_lst_nbank_inteday_max_rct_two_roc
, als_m1_coon_orgnum_max_rct_two_roc
, als_m1_coon_allnum_max_rct_two_roc
, als_m1_nbank_nsloan_allnum_max_rct_two_roc
, als_d15_caon_orgnum_max_rct_two_roc
, als_d15_caon_allnum_max_rct_two_roc
, als_d15_nbank_week_orgnum_max_rct_two_roc
, als_d15_nbank_week_allnum_max_rct_two_roc
, als_d15_pdl_orgnum_max_rct_two_roc
, als_d15_nbank_cons_orgnum_max_rct_two_roc
, als_d15_pdl_allnum_max_rct_two_roc
, als_d15_nbank_cons_allnum_max_rct_two_roc
, als_d7_nbank_orgnum_max_rct_two_roc
, als_d7_nbank_allnum_max_rct_two_roc
, als_m1_nbank_night_allnum_max_rct_two_roc
, als_m1_nbank_night_orgnum_max_rct_two_roc
, als_d7_nbank_else_allnum_max_rct_two_roc
, als_d15_nbank_nsloan_orgnum_max_rct_two_roc
, als_d7_nbank_else_orgnum_max_rct_two_roc
, als_d15_nbank_night_allnum_max_rct_two_roc
, als_d15_nbank_night_orgnum_max_rct_two_roc
, als_d7_nbank_oth_orgnum_max_rct_two_roc
, als_d7_nbank_oth_allnum_max_rct_two_roc
, als_d15_nbank_cf_orgnum_max_rct_two_roc
, als_d15_nbank_cf_allnum_max_rct_two_roc
, als_d15_nbank_selfnum_max_rct_two_roc
, als_d15_nbank_nsloan_allnum_max_rct_two_roc
, als_d15_coon_allnum_max_rct_two_roc

-- 2. 上月最近一份
, rct_mon_two_dte_len
, als_m1_nbank_orgnum_max_rct_mon_two_diff
, als_m1_nbank_else_orgnum_max_rct_mon_two_diff
, als_m1_nbank_allnum_max_rct_mon_two_diff
, als_m1_nbank_oth_orgnum_max_rct_mon_two_diff
, als_m1_nbank_else_allnum_max_rct_mon_two_diff
, als_m1_nbank_oth_allnum_max_rct_mon_two_diff
, als_m1_caon_orgnum_max_rct_mon_two_diff
, als_d15_nbank_orgnum_max_rct_mon_two_diff
, als_d15_nbank_allnum_max_rct_mon_two_diff
, als_m1_caon_allnum_max_rct_mon_two_diff
, als_m1_pdl_orgnum_max_rct_mon_two_diff
, als_m1_nbank_cons_orgnum_max_rct_mon_two_diff
, als_d15_nbank_else_orgnum_max_rct_mon_two_diff
, als_m1_nbank_cons_allnum_max_rct_mon_two_diff
, als_d15_nbank_else_allnum_max_rct_mon_two_diff
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_diff
, als_m1_pdl_allnum_max_rct_mon_two_diff
, als_d15_nbank_oth_orgnum_max_rct_mon_two_diff
, als_d15_nbank_oth_allnum_max_rct_mon_two_diff
, als_m1_nbank_week_orgnum_max_rct_mon_two_diff
, als_m1_nbank_cf_orgnum_max_rct_mon_two_diff
, als_m1_nbank_week_allnum_max_rct_mon_two_diff
, als_m1_nbank_cf_allnum_max_rct_mon_two_diff
, als_lst_nbank_inteday_max_rct_mon_two_diff
, als_m1_coon_orgnum_max_rct_mon_two_diff
, als_m1_coon_allnum_max_rct_mon_two_diff
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_diff
, als_d15_caon_orgnum_max_rct_mon_two_diff
, als_d15_caon_allnum_max_rct_mon_two_diff
, als_d15_nbank_week_orgnum_max_rct_mon_two_diff
, als_d15_nbank_week_allnum_max_rct_mon_two_diff
, als_d15_pdl_orgnum_max_rct_mon_two_diff
, als_d15_nbank_cons_orgnum_max_rct_mon_two_diff
, als_d15_pdl_allnum_max_rct_mon_two_diff
, als_d15_nbank_cons_allnum_max_rct_mon_two_diff
, als_d7_nbank_orgnum_max_rct_mon_two_diff
, als_d7_nbank_allnum_max_rct_mon_two_diff
, als_m1_nbank_night_allnum_max_rct_mon_two_diff
, als_m1_nbank_night_orgnum_max_rct_mon_two_diff
, als_d7_nbank_else_allnum_max_rct_mon_two_diff
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_diff
, als_d7_nbank_else_orgnum_max_rct_mon_two_diff
, als_d15_nbank_night_allnum_max_rct_mon_two_diff
, als_d15_nbank_night_orgnum_max_rct_mon_two_diff
, als_d7_nbank_oth_orgnum_max_rct_mon_two_diff
, als_d7_nbank_oth_allnum_max_rct_mon_two_diff
, als_d15_nbank_cf_orgnum_max_rct_mon_two_diff
, als_d15_nbank_cf_allnum_max_rct_mon_two_diff
, als_d15_nbank_selfnum_max_rct_mon_two_diff
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_diff
, als_d15_coon_allnum_max_rct_mon_two_diff
, als_m1_nbank_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_else_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_allnum_max_rct_mon_two_dvd
, als_m1_nbank_oth_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_else_allnum_max_rct_mon_two_dvd
, als_m1_nbank_oth_allnum_max_rct_mon_two_dvd
, als_m1_caon_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_allnum_max_rct_mon_two_dvd
, als_m1_caon_allnum_max_rct_mon_two_dvd
, als_m1_pdl_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_cons_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_else_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_cons_allnum_max_rct_mon_two_dvd
, als_d15_nbank_else_allnum_max_rct_mon_two_dvd
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_dvd
, als_m1_pdl_allnum_max_rct_mon_two_dvd
, als_d15_nbank_oth_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_oth_allnum_max_rct_mon_two_dvd
, als_m1_nbank_week_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_cf_orgnum_max_rct_mon_two_dvd
, als_m1_nbank_week_allnum_max_rct_mon_two_dvd
, als_m1_nbank_cf_allnum_max_rct_mon_two_dvd
, als_lst_nbank_inteday_max_rct_mon_two_dvd
, als_m1_coon_orgnum_max_rct_mon_two_dvd
, als_m1_coon_allnum_max_rct_mon_two_dvd
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_dvd
, als_d15_caon_orgnum_max_rct_mon_two_dvd
, als_d15_caon_allnum_max_rct_mon_two_dvd
, als_d15_nbank_week_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_week_allnum_max_rct_mon_two_dvd
, als_d15_pdl_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_cons_orgnum_max_rct_mon_two_dvd
, als_d15_pdl_allnum_max_rct_mon_two_dvd
, als_d15_nbank_cons_allnum_max_rct_mon_two_dvd
, als_d7_nbank_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_allnum_max_rct_mon_two_dvd
, als_m1_nbank_night_allnum_max_rct_mon_two_dvd
, als_m1_nbank_night_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_else_allnum_max_rct_mon_two_dvd
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_else_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_night_allnum_max_rct_mon_two_dvd
, als_d15_nbank_night_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_oth_orgnum_max_rct_mon_two_dvd
, als_d7_nbank_oth_allnum_max_rct_mon_two_dvd
, als_d15_nbank_cf_orgnum_max_rct_mon_two_dvd
, als_d15_nbank_cf_allnum_max_rct_mon_two_dvd
, als_d15_nbank_selfnum_max_rct_mon_two_dvd
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_dvd
, als_d15_coon_allnum_max_rct_mon_two_dvd
, als_m1_nbank_orgnum_max_rct_mon_two_roc
, als_m1_nbank_else_orgnum_max_rct_mon_two_roc
, als_m1_nbank_allnum_max_rct_mon_two_roc
, als_m1_nbank_oth_orgnum_max_rct_mon_two_roc
, als_m1_nbank_else_allnum_max_rct_mon_two_roc
, als_m1_nbank_oth_allnum_max_rct_mon_two_roc
, als_m1_caon_orgnum_max_rct_mon_two_roc
, als_d15_nbank_orgnum_max_rct_mon_two_roc
, als_d15_nbank_allnum_max_rct_mon_two_roc
, als_m1_caon_allnum_max_rct_mon_two_roc
, als_m1_pdl_orgnum_max_rct_mon_two_roc
, als_m1_nbank_cons_orgnum_max_rct_mon_two_roc
, als_d15_nbank_else_orgnum_max_rct_mon_two_roc
, als_m1_nbank_cons_allnum_max_rct_mon_two_roc
, als_d15_nbank_else_allnum_max_rct_mon_two_roc
, als_m1_nbank_nsloan_orgnum_max_rct_mon_two_roc
, als_m1_pdl_allnum_max_rct_mon_two_roc
, als_d15_nbank_oth_orgnum_max_rct_mon_two_roc
, als_d15_nbank_oth_allnum_max_rct_mon_two_roc
, als_m1_nbank_week_orgnum_max_rct_mon_two_roc
, als_m1_nbank_cf_orgnum_max_rct_mon_two_roc
, als_m1_nbank_week_allnum_max_rct_mon_two_roc
, als_m1_nbank_cf_allnum_max_rct_mon_two_roc
, als_lst_nbank_inteday_max_rct_mon_two_roc
, als_m1_coon_orgnum_max_rct_mon_two_roc
, als_m1_coon_allnum_max_rct_mon_two_roc
, als_m1_nbank_nsloan_allnum_max_rct_mon_two_roc
, als_d15_caon_orgnum_max_rct_mon_two_roc
, als_d15_caon_allnum_max_rct_mon_two_roc
, als_d15_nbank_week_orgnum_max_rct_mon_two_roc
, als_d15_nbank_week_allnum_max_rct_mon_two_roc
, als_d15_pdl_orgnum_max_rct_mon_two_roc
, als_d15_nbank_cons_orgnum_max_rct_mon_two_roc
, als_d15_pdl_allnum_max_rct_mon_two_roc
, als_d15_nbank_cons_allnum_max_rct_mon_two_roc
, als_d7_nbank_orgnum_max_rct_mon_two_roc
, als_d7_nbank_allnum_max_rct_mon_two_roc
, als_m1_nbank_night_allnum_max_rct_mon_two_roc
, als_m1_nbank_night_orgnum_max_rct_mon_two_roc
, als_d7_nbank_else_allnum_max_rct_mon_two_roc
, als_d15_nbank_nsloan_orgnum_max_rct_mon_two_roc
, als_d7_nbank_else_orgnum_max_rct_mon_two_roc
, als_d15_nbank_night_allnum_max_rct_mon_two_roc
, als_d15_nbank_night_orgnum_max_rct_mon_two_roc
, als_d7_nbank_oth_orgnum_max_rct_mon_two_roc
, als_d7_nbank_oth_allnum_max_rct_mon_two_roc
, als_d15_nbank_cf_orgnum_max_rct_mon_two_roc
, als_d15_nbank_cf_allnum_max_rct_mon_two_roc
, als_d15_nbank_selfnum_max_rct_mon_two_roc
, als_d15_nbank_nsloan_allnum_max_rct_mon_two_roc
, als_d15_coon_allnum_max_rct_mon_two_roc
from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_sample_table_temp2 a
left join pdm_risk.pdm_risk_dz_br_max_two_report_rct_two as b -- 最近一份
on a.uid = b.uid
left join pdm_risk.pdm_risk_dz_br_max_two_report_rct_mon_two as c -- 上月最近一份
on a.uid = c.uid
-- feature-copilot:node-end ordinal=0
