-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce
-- node_id: n_7014229872734765056
-- task_name: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di
-- owner_name: 曹佳程
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce.json
-- source_json_sha256: b83119d2da8ddf27e1e99eb7dcb8489127ca41a9996213371601202a4f3aa6cd
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_coalesce
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_coalesce
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_base_dim
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_base_dim
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_base_dim

create table if not exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di(
uid string comment '用户id',
data_id STRING COMMENT '数据ID',
code STRING COMMENT '响应码',
flag_applyloanstr STRING COMMENT '借贷意向验证产品输出标识',
swift_number STRING COMMENT '操作流水号',
created_at TIMESTAMP COMMENT '创建时间',
updated_at TIMESTAMP COMMENT '更新时间'
, rct_12mon_cnt float comment '百融12个月内_实际查询次数'
, created_at_rct_12mon_interval float comment '百融12个月内_实际查询时间间隔'
, als_m1_nbank_orgnum_max_rct_12mon_max float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_else_orgnum_max_rct_12mon_max float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_allnum_max_rct_12mon_max float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_oth_orgnum_max_rct_12mon_max float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_else_allnum_max_rct_12mon_max float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_oth_allnum_max_rct_12mon_max float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_caon_orgnum_max_rct_12mon_max float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_orgnum_max_rct_12mon_max float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_allnum_max_rct_12mon_max float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_caon_allnum_max_rct_12mon_max float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_pdl_orgnum_max_rct_12mon_max float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_cons_orgnum_max_rct_12mon_max float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_else_orgnum_max_rct_12mon_max float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_cons_allnum_max_rct_12mon_max float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_else_allnum_max_rct_12mon_max float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_max float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_pdl_allnum_max_rct_12mon_max float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_oth_orgnum_max_rct_12mon_max float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_oth_allnum_max_rct_12mon_max float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_week_orgnum_max_rct_12mon_max float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_cf_orgnum_max_rct_12mon_max float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_week_allnum_max_rct_12mon_max float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_cf_allnum_max_rct_12mon_max float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_lst_nbank_inteday_max_rct_12mon_max float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_coon_orgnum_max_rct_12mon_max float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_coon_allnum_max_rct_12mon_max float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_max float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_caon_orgnum_max_rct_12mon_max float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_caon_allnum_max_rct_12mon_max float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_week_orgnum_max_rct_12mon_max float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_week_allnum_max_rct_12mon_max float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_pdl_orgnum_max_rct_12mon_max float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_cons_orgnum_max_rct_12mon_max float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_pdl_allnum_max_rct_12mon_max float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_cons_allnum_max_rct_12mon_max float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d7_nbank_orgnum_max_rct_12mon_max float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d7_nbank_allnum_max_rct_12mon_max float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_night_allnum_max_rct_12mon_max float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_m1_nbank_night_orgnum_max_rct_12mon_max float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d7_nbank_else_allnum_max_rct_12mon_max float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_max float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d7_nbank_else_orgnum_max_rct_12mon_max float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_night_allnum_max_rct_12mon_max float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_night_orgnum_max_rct_12mon_max float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d7_nbank_oth_orgnum_max_rct_12mon_max float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内最大值'
, als_d7_nbank_oth_allnum_max_rct_12mon_max float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_cf_orgnum_max_rct_12mon_max float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_cf_allnum_max_rct_12mon_max float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_selfnum_max_rct_12mon_max float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_max float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内最大值'
, als_d15_coon_allnum_max_rct_12mon_max float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_12个月内最大值'

, als_m1_nbank_orgnum_max_rct_12mon_min float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_else_orgnum_max_rct_12mon_min float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_allnum_max_rct_12mon_min float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_oth_orgnum_max_rct_12mon_min float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_else_allnum_max_rct_12mon_min float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_oth_allnum_max_rct_12mon_min float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内最小值'
, als_m1_caon_orgnum_max_rct_12mon_min float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_orgnum_max_rct_12mon_min float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_allnum_max_rct_12mon_min float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_caon_allnum_max_rct_12mon_min float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_pdl_orgnum_max_rct_12mon_min float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_cons_orgnum_max_rct_12mon_min float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_else_orgnum_max_rct_12mon_min float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_cons_allnum_max_rct_12mon_min float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_else_allnum_max_rct_12mon_min float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_min float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_pdl_allnum_max_rct_12mon_min float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_oth_orgnum_max_rct_12mon_min float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_oth_allnum_max_rct_12mon_min float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_week_orgnum_max_rct_12mon_min float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_cf_orgnum_max_rct_12mon_min float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_week_allnum_max_rct_12mon_min float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_cf_allnum_max_rct_12mon_min float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_lst_nbank_inteday_max_rct_12mon_min float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_coon_orgnum_max_rct_12mon_min float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_coon_allnum_max_rct_12mon_min float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_min float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_caon_orgnum_max_rct_12mon_min float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_caon_allnum_max_rct_12mon_min float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_week_orgnum_max_rct_12mon_min float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_week_allnum_max_rct_12mon_min float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_pdl_orgnum_max_rct_12mon_min float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_cons_orgnum_max_rct_12mon_min float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_pdl_allnum_max_rct_12mon_min float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_cons_allnum_max_rct_12mon_min float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d7_nbank_orgnum_max_rct_12mon_min float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d7_nbank_allnum_max_rct_12mon_min float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_night_allnum_max_rct_12mon_min float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_night_orgnum_max_rct_12mon_min float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d7_nbank_else_allnum_max_rct_12mon_min float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_min float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d7_nbank_else_orgnum_max_rct_12mon_min float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_night_allnum_max_rct_12mon_min float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_night_orgnum_max_rct_12mon_min float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d7_nbank_oth_orgnum_max_rct_12mon_min float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内最小值'
, als_d7_nbank_oth_allnum_max_rct_12mon_min float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_cf_orgnum_max_rct_12mon_min float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_cf_allnum_max_rct_12mon_min float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_selfnum_max_rct_12mon_min float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_min float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内最小值'
, als_d15_coon_allnum_max_rct_12mon_min float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_12个月内最小值'
, als_m1_nbank_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_else_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_allnum_max_rct_12mon_avg float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_oth_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_else_allnum_max_rct_12mon_avg float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_oth_allnum_max_rct_12mon_avg float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内平均值'
, als_m1_caon_orgnum_max_rct_12mon_avg float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_orgnum_max_rct_12mon_avg float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_allnum_max_rct_12mon_avg float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_caon_allnum_max_rct_12mon_avg float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_pdl_orgnum_max_rct_12mon_avg float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_cons_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_else_orgnum_max_rct_12mon_avg float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_cons_allnum_max_rct_12mon_avg float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_else_allnum_max_rct_12mon_avg float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_pdl_allnum_max_rct_12mon_avg float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_oth_orgnum_max_rct_12mon_avg float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_oth_allnum_max_rct_12mon_avg float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_week_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_cf_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_week_allnum_max_rct_12mon_avg float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_cf_allnum_max_rct_12mon_avg float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_lst_nbank_inteday_max_rct_12mon_avg float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_coon_orgnum_max_rct_12mon_avg float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_coon_allnum_max_rct_12mon_avg float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_avg float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_caon_orgnum_max_rct_12mon_avg float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_caon_allnum_max_rct_12mon_avg float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_week_orgnum_max_rct_12mon_avg float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_week_allnum_max_rct_12mon_avg float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_pdl_orgnum_max_rct_12mon_avg float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_cons_orgnum_max_rct_12mon_avg float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_pdl_allnum_max_rct_12mon_avg float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_cons_allnum_max_rct_12mon_avg float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d7_nbank_orgnum_max_rct_12mon_avg float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d7_nbank_allnum_max_rct_12mon_avg float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_night_allnum_max_rct_12mon_avg float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_night_orgnum_max_rct_12mon_avg float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d7_nbank_else_allnum_max_rct_12mon_avg float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_avg float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d7_nbank_else_orgnum_max_rct_12mon_avg float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_night_allnum_max_rct_12mon_avg float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_night_orgnum_max_rct_12mon_avg float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d7_nbank_oth_orgnum_max_rct_12mon_avg float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内平均值'
, als_d7_nbank_oth_allnum_max_rct_12mon_avg float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_cf_orgnum_max_rct_12mon_avg float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_cf_allnum_max_rct_12mon_avg float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_selfnum_max_rct_12mon_avg float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_avg float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内平均值'
, als_d15_coon_allnum_max_rct_12mon_avg float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_12个月内平均值'
, als_m1_nbank_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_else_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_oth_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_else_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_oth_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内标准差'
, als_m1_caon_orgnum_max_rct_12mon_stddev float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_allnum_max_rct_12mon_stddev float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_caon_allnum_max_rct_12mon_stddev float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_pdl_orgnum_max_rct_12mon_stddev float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_cons_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_else_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_cons_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_else_allnum_max_rct_12mon_stddev float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_pdl_allnum_max_rct_12mon_stddev float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_oth_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_oth_allnum_max_rct_12mon_stddev float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_week_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_cf_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_week_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_cf_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_lst_nbank_inteday_max_rct_12mon_stddev float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_coon_orgnum_max_rct_12mon_stddev float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_coon_allnum_max_rct_12mon_stddev float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_caon_orgnum_max_rct_12mon_stddev float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_caon_allnum_max_rct_12mon_stddev float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_week_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_week_allnum_max_rct_12mon_stddev float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_pdl_orgnum_max_rct_12mon_stddev float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_cons_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_pdl_allnum_max_rct_12mon_stddev float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_cons_allnum_max_rct_12mon_stddev float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d7_nbank_orgnum_max_rct_12mon_stddev float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d7_nbank_allnum_max_rct_12mon_stddev float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_night_allnum_max_rct_12mon_stddev float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_m1_nbank_night_orgnum_max_rct_12mon_stddev float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d7_nbank_else_allnum_max_rct_12mon_stddev float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d7_nbank_else_orgnum_max_rct_12mon_stddev float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_night_allnum_max_rct_12mon_stddev float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_night_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d7_nbank_oth_orgnum_max_rct_12mon_stddev float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_12个月内标准差'
, als_d7_nbank_oth_allnum_max_rct_12mon_stddev float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_cf_orgnum_max_rct_12mon_stddev float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_cf_allnum_max_rct_12mon_stddev float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_selfnum_max_rct_12mon_stddev float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_stddev float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_12个月内标准差'
, als_d15_coon_allnum_max_rct_12mon_stddev float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_12个月内标准差'
, rct_12tme_cnt float comment '百融最近12份实际查询次数'
, created_at_rct_12tme_interval float comment '百融最近12份实际查询时间间隔'
, als_m1_nbank_orgnum_max_rct_12tme_max float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_else_orgnum_max_rct_12tme_max float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_allnum_max_rct_12tme_max float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_oth_orgnum_max_rct_12tme_max float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_else_allnum_max_rct_12tme_max float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_oth_allnum_max_rct_12tme_max float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份最大值'
, als_m1_caon_orgnum_max_rct_12tme_max float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_orgnum_max_rct_12tme_max float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_allnum_max_rct_12tme_max float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_caon_allnum_max_rct_12tme_max float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_pdl_orgnum_max_rct_12tme_max float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_cons_orgnum_max_rct_12tme_max float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_else_orgnum_max_rct_12tme_max float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_cons_allnum_max_rct_12tme_max float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_else_allnum_max_rct_12tme_max float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_max float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_pdl_allnum_max_rct_12tme_max float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_oth_orgnum_max_rct_12tme_max float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_oth_allnum_max_rct_12tme_max float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_week_orgnum_max_rct_12tme_max float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_cf_orgnum_max_rct_12tme_max float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_week_allnum_max_rct_12tme_max float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_cf_allnum_max_rct_12tme_max float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_lst_nbank_inteday_max_rct_12tme_max float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_coon_orgnum_max_rct_12tme_max float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_coon_allnum_max_rct_12tme_max float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_max float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_caon_orgnum_max_rct_12tme_max float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_caon_allnum_max_rct_12tme_max float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_week_orgnum_max_rct_12tme_max float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_week_allnum_max_rct_12tme_max float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_pdl_orgnum_max_rct_12tme_max float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_cons_orgnum_max_rct_12tme_max float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_pdl_allnum_max_rct_12tme_max float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_cons_allnum_max_rct_12tme_max float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d7_nbank_orgnum_max_rct_12tme_max float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d7_nbank_allnum_max_rct_12tme_max float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_night_allnum_max_rct_12tme_max float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_night_orgnum_max_rct_12tme_max float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d7_nbank_else_allnum_max_rct_12tme_max float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_max float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d7_nbank_else_orgnum_max_rct_12tme_max float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_night_allnum_max_rct_12tme_max float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_night_orgnum_max_rct_12tme_max float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d7_nbank_oth_orgnum_max_rct_12tme_max float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份最大值'
, als_d7_nbank_oth_allnum_max_rct_12tme_max float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_cf_orgnum_max_rct_12tme_max float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_cf_allnum_max_rct_12tme_max float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_selfnum_max_rct_12tme_max float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_max float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份最大值'
, als_d15_coon_allnum_max_rct_12tme_max float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_最近12份最大值'
, als_m1_nbank_orgnum_max_rct_12tme_min float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_else_orgnum_max_rct_12tme_min float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_allnum_max_rct_12tme_min float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_oth_orgnum_max_rct_12tme_min float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_else_allnum_max_rct_12tme_min float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_oth_allnum_max_rct_12tme_min float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份最小值'
, als_m1_caon_orgnum_max_rct_12tme_min float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_orgnum_max_rct_12tme_min float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_allnum_max_rct_12tme_min float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_caon_allnum_max_rct_12tme_min float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_pdl_orgnum_max_rct_12tme_min float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_cons_orgnum_max_rct_12tme_min float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_else_orgnum_max_rct_12tme_min float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_cons_allnum_max_rct_12tme_min float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_else_allnum_max_rct_12tme_min float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_min float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_pdl_allnum_max_rct_12tme_min float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_oth_orgnum_max_rct_12tme_min float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_oth_allnum_max_rct_12tme_min float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_week_orgnum_max_rct_12tme_min float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_cf_orgnum_max_rct_12tme_min float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_week_allnum_max_rct_12tme_min float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_cf_allnum_max_rct_12tme_min float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_lst_nbank_inteday_max_rct_12tme_min float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_coon_orgnum_max_rct_12tme_min float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_coon_allnum_max_rct_12tme_min float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_min float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_caon_orgnum_max_rct_12tme_min float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_caon_allnum_max_rct_12tme_min float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_week_orgnum_max_rct_12tme_min float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_week_allnum_max_rct_12tme_min float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_pdl_orgnum_max_rct_12tme_min float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_cons_orgnum_max_rct_12tme_min float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_pdl_allnum_max_rct_12tme_min float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_cons_allnum_max_rct_12tme_min float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d7_nbank_orgnum_max_rct_12tme_min float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d7_nbank_allnum_max_rct_12tme_min float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_night_allnum_max_rct_12tme_min float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_night_orgnum_max_rct_12tme_min float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d7_nbank_else_allnum_max_rct_12tme_min float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_min float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d7_nbank_else_orgnum_max_rct_12tme_min float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_night_allnum_max_rct_12tme_min float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_night_orgnum_max_rct_12tme_min float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d7_nbank_oth_orgnum_max_rct_12tme_min float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份最小值'
, als_d7_nbank_oth_allnum_max_rct_12tme_min float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_cf_orgnum_max_rct_12tme_min float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_cf_allnum_max_rct_12tme_min float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_selfnum_max_rct_12tme_min float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_min float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份最小值'
, als_d15_coon_allnum_max_rct_12tme_min float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_最近12份最小值'
, als_m1_nbank_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_else_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_allnum_max_rct_12tme_avg float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_oth_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_else_allnum_max_rct_12tme_avg float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_oth_allnum_max_rct_12tme_avg float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份平均值'
, als_m1_caon_orgnum_max_rct_12tme_avg float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_orgnum_max_rct_12tme_avg float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_allnum_max_rct_12tme_avg float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_caon_allnum_max_rct_12tme_avg float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_pdl_orgnum_max_rct_12tme_avg float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_cons_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_else_orgnum_max_rct_12tme_avg float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_cons_allnum_max_rct_12tme_avg float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_else_allnum_max_rct_12tme_avg float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_pdl_allnum_max_rct_12tme_avg float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_oth_orgnum_max_rct_12tme_avg float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_oth_allnum_max_rct_12tme_avg float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_week_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_cf_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_week_allnum_max_rct_12tme_avg float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_cf_allnum_max_rct_12tme_avg float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_lst_nbank_inteday_max_rct_12tme_avg float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_coon_orgnum_max_rct_12tme_avg float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_coon_allnum_max_rct_12tme_avg float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_avg float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_caon_orgnum_max_rct_12tme_avg float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_caon_allnum_max_rct_12tme_avg float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_week_orgnum_max_rct_12tme_avg float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_week_allnum_max_rct_12tme_avg float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_pdl_orgnum_max_rct_12tme_avg float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_cons_orgnum_max_rct_12tme_avg float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_pdl_allnum_max_rct_12tme_avg float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_cons_allnum_max_rct_12tme_avg float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d7_nbank_orgnum_max_rct_12tme_avg float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d7_nbank_allnum_max_rct_12tme_avg float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_night_allnum_max_rct_12tme_avg float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_night_orgnum_max_rct_12tme_avg float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d7_nbank_else_allnum_max_rct_12tme_avg float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_avg float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d7_nbank_else_orgnum_max_rct_12tme_avg float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_night_allnum_max_rct_12tme_avg float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_night_orgnum_max_rct_12tme_avg float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d7_nbank_oth_orgnum_max_rct_12tme_avg float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份平均值'
, als_d7_nbank_oth_allnum_max_rct_12tme_avg float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_cf_orgnum_max_rct_12tme_avg float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_cf_allnum_max_rct_12tme_avg float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_selfnum_max_rct_12tme_avg float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_avg float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份平均值'
, als_d15_coon_allnum_max_rct_12tme_avg float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_最近12份平均值'
, als_m1_nbank_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_else_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_oth_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_else_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_oth_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份标准差'
, als_m1_caon_orgnum_max_rct_12tme_stddev float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_allnum_max_rct_12tme_stddev float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_caon_allnum_max_rct_12tme_stddev float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_pdl_orgnum_max_rct_12tme_stddev float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_cons_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_else_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_cons_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_else_allnum_max_rct_12tme_stddev float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_pdl_allnum_max_rct_12tme_stddev float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_oth_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_oth_allnum_max_rct_12tme_stddev float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_week_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_cf_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_week_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_cf_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_lst_nbank_inteday_max_rct_12tme_stddev float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_coon_orgnum_max_rct_12tme_stddev float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_coon_allnum_max_rct_12tme_stddev float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_caon_orgnum_max_rct_12tme_stddev float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_caon_allnum_max_rct_12tme_stddev float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_week_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_week_allnum_max_rct_12tme_stddev float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_pdl_orgnum_max_rct_12tme_stddev float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_cons_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_pdl_allnum_max_rct_12tme_stddev float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_cons_allnum_max_rct_12tme_stddev float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d7_nbank_orgnum_max_rct_12tme_stddev float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d7_nbank_allnum_max_rct_12tme_stddev float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_night_allnum_max_rct_12tme_stddev float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_m1_nbank_night_orgnum_max_rct_12tme_stddev float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d7_nbank_else_allnum_max_rct_12tme_stddev float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d7_nbank_else_orgnum_max_rct_12tme_stddev float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_night_allnum_max_rct_12tme_stddev float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_night_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d7_nbank_oth_orgnum_max_rct_12tme_stddev float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_最近12份标准差'
, als_d7_nbank_oth_allnum_max_rct_12tme_stddev float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_cf_orgnum_max_rct_12tme_stddev float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_cf_allnum_max_rct_12tme_stddev float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_selfnum_max_rct_12tme_stddev float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_stddev float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_最近12份标准差'
, als_d15_coon_allnum_max_rct_12tme_stddev float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_最近12份标准差'
, rct_12mon_lst_cnt float comment '百融近12月每月最近一次_实际查询次数'
, created_at_rct_12mon_lst_interval float comment '百融近12月每月最近一次_实际查询时间间隔'
, als_m1_nbank_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_else_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_oth_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_else_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_oth_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_caon_orgnum_max_rct_12mon_lst_max float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_caon_allnum_max_rct_12mon_lst_max float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_pdl_orgnum_max_rct_12mon_lst_max float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_cons_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_else_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_cons_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_else_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_pdl_allnum_max_rct_12mon_lst_max float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_oth_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_oth_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_week_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_cf_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_week_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_cf_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_lst_nbank_inteday_max_rct_12mon_lst_max float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_coon_orgnum_max_rct_12mon_lst_max float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_coon_allnum_max_rct_12mon_lst_max float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_caon_orgnum_max_rct_12mon_lst_max float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_caon_allnum_max_rct_12mon_lst_max float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_week_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_week_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_pdl_orgnum_max_rct_12mon_lst_max float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_cons_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_pdl_allnum_max_rct_12mon_lst_max float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_cons_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d7_nbank_orgnum_max_rct_12mon_lst_max float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d7_nbank_allnum_max_rct_12mon_lst_max float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_night_allnum_max_rct_12mon_lst_max float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_night_orgnum_max_rct_12mon_lst_max float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d7_nbank_else_allnum_max_rct_12mon_lst_max float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d7_nbank_else_orgnum_max_rct_12mon_lst_max float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_night_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_night_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d7_nbank_oth_orgnum_max_rct_12mon_lst_max float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d7_nbank_oth_allnum_max_rct_12mon_lst_max float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_cf_orgnum_max_rct_12mon_lst_max float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_cf_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_selfnum_max_rct_12mon_lst_max float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_max float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_d15_coon_allnum_max_rct_12mon_lst_max float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次最大值'
, als_m1_nbank_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_else_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_oth_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_else_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_oth_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_caon_orgnum_max_rct_12mon_lst_min float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_caon_allnum_max_rct_12mon_lst_min float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_pdl_orgnum_max_rct_12mon_lst_min float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_cons_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_else_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_cons_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_else_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_pdl_allnum_max_rct_12mon_lst_min float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_oth_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_oth_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_week_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_cf_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_week_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_cf_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_lst_nbank_inteday_max_rct_12mon_lst_min float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_coon_orgnum_max_rct_12mon_lst_min float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_coon_allnum_max_rct_12mon_lst_min float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_caon_orgnum_max_rct_12mon_lst_min float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_caon_allnum_max_rct_12mon_lst_min float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_week_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_week_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_pdl_orgnum_max_rct_12mon_lst_min float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_cons_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_pdl_allnum_max_rct_12mon_lst_min float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_cons_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d7_nbank_orgnum_max_rct_12mon_lst_min float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d7_nbank_allnum_max_rct_12mon_lst_min float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_night_allnum_max_rct_12mon_lst_min float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_night_orgnum_max_rct_12mon_lst_min float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d7_nbank_else_allnum_max_rct_12mon_lst_min float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d7_nbank_else_orgnum_max_rct_12mon_lst_min float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_night_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_night_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d7_nbank_oth_orgnum_max_rct_12mon_lst_min float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d7_nbank_oth_allnum_max_rct_12mon_lst_min float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_cf_orgnum_max_rct_12mon_lst_min float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_cf_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_selfnum_max_rct_12mon_lst_min float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_min float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_d15_coon_allnum_max_rct_12mon_lst_min float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次最小值'
, als_m1_nbank_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_else_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_oth_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_else_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_oth_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_caon_orgnum_max_rct_12mon_lst_avg float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_caon_allnum_max_rct_12mon_lst_avg float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_pdl_orgnum_max_rct_12mon_lst_avg float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_cons_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_else_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_cons_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_else_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_pdl_allnum_max_rct_12mon_lst_avg float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_oth_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_oth_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_week_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_cf_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_week_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_cf_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_lst_nbank_inteday_max_rct_12mon_lst_avg float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_coon_orgnum_max_rct_12mon_lst_avg float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_coon_allnum_max_rct_12mon_lst_avg float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_caon_orgnum_max_rct_12mon_lst_avg float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_caon_allnum_max_rct_12mon_lst_avg float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_week_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_week_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_pdl_orgnum_max_rct_12mon_lst_avg float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_cons_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_pdl_allnum_max_rct_12mon_lst_avg float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_cons_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d7_nbank_orgnum_max_rct_12mon_lst_avg float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d7_nbank_allnum_max_rct_12mon_lst_avg float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_night_allnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_night_orgnum_max_rct_12mon_lst_avg float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d7_nbank_else_allnum_max_rct_12mon_lst_avg float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d7_nbank_else_orgnum_max_rct_12mon_lst_avg float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_night_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_night_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d7_nbank_oth_orgnum_max_rct_12mon_lst_avg float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d7_nbank_oth_allnum_max_rct_12mon_lst_avg float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_cf_orgnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_cf_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_selfnum_max_rct_12mon_lst_avg float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_avg float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_d15_coon_allnum_max_rct_12mon_lst_avg float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次平均值'
, als_m1_nbank_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_else_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_oth_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_else_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_oth_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_caon_orgnum_max_rct_12mon_lst_stddev float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_caon_allnum_max_rct_12mon_lst_stddev float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_pdl_orgnum_max_rct_12mon_lst_stddev float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_cons_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_else_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_cons_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_else_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_pdl_allnum_max_rct_12mon_lst_stddev float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_oth_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_oth_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_week_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_cf_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_week_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_cf_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_lst_nbank_inteday_max_rct_12mon_lst_stddev float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_coon_orgnum_max_rct_12mon_lst_stddev float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_coon_allnum_max_rct_12mon_lst_stddev float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_caon_orgnum_max_rct_12mon_lst_stddev float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_caon_allnum_max_rct_12mon_lst_stddev float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_week_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_week_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_pdl_orgnum_max_rct_12mon_lst_stddev float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_cons_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_pdl_allnum_max_rct_12mon_lst_stddev float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_cons_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d7_nbank_orgnum_max_rct_12mon_lst_stddev float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d7_nbank_allnum_max_rct_12mon_lst_stddev float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_night_allnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_m1_nbank_night_orgnum_max_rct_12mon_lst_stddev float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d7_nbank_else_allnum_max_rct_12mon_lst_stddev float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d7_nbank_else_orgnum_max_rct_12mon_lst_stddev float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_night_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_night_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d7_nbank_oth_orgnum_max_rct_12mon_lst_stddev float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d7_nbank_oth_allnum_max_rct_12mon_lst_stddev float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_cf_orgnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_cf_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_selfnum_max_rct_12mon_lst_stddev float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_stddev float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
, als_d15_coon_allnum_max_rct_12mon_lst_stddev float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12月每月最近一次标准差'
) comment '百融max_多报文特征中间表_多份报文'
partitioned by (ds string)

;






-- 1. 固定窗口12个月（实际是最近一次查询往前12个月）
drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_coalesce;
create table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_coalesce as
select uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
, count(data_id)over(partition by uid) as rct_12mon_cnt
, datediff(created_at_rct_12mon_max, created_at_rct_12mon_min) as created_at_rct_12mon_interval
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
    , max(created_at)over(partition by uid) as created_at_rct_12mon_max
    , min(created_at)over(partition by uid) as created_at_rct_12mon_min
    from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
    where ds = '${bizdate}'
    and substr(created_at, 1, 10) >= add_months(to_date('${bizdate}', 'yyyymmdd'), -12) -- 从12个月前开始算起
) a

;

drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_base_dim;
create table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_base_dim as
select uid, rct_12mon_cnt, created_at_rct_12mon_interval
-- max
, max(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_max
, max(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_max
, max(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_max
, max(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_max
, max(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_max
, max(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_max
, max(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_max
, max(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_max
, max(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_max
, max(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_max
, max(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_max
, max(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_max
, max(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_max
, max(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_max
, max(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_max
, max(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_max
, max(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_max
, max(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_max
, max(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_max
, max(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_max
, max(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_max
, max(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_max
, max(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_max
, max(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_max
, max(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_max
, max(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_max
, max(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_max
, max(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_max
, max(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_max
, max(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_max
, max(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_max
, max(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_max
, max(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_max
, max(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_max
, max(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_max
, max(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_max
, max(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_max
, max(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_max
, max(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_max
, max(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_max
, max(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_max
, max(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_max
, max(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_max
, max(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_max
, max(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_max
, max(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_max
, max(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_max
, max(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_max
, max(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_max
, max(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_max
, max(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_max
-- min
, min(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_min
, min(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_min
, min(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_min
, min(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_min
, min(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_min
, min(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_min
, min(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_min
, min(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_min
, min(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_min
, min(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_min
, min(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_min
, min(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_min
, min(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_min
, min(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_min
, min(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_min
, min(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_min
, min(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_min
, min(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_min
, min(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_min
, min(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_min
, min(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_min
, min(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_min
, min(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_min
, min(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_min
, min(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_min
, min(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_min
, min(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_min
, min(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_min
, min(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_min
, min(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_min
, min(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_min
, min(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_min
, min(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_min
, min(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_min
, min(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_min
, min(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_min
, min(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_min
, min(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_min
, min(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_min
, min(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_min
, min(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_min
, min(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_min
, min(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_min
, min(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_min
, min(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_min
, min(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_min
, min(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_min
, min(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_min
, min(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_min
, min(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_min
, min(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_min
--avg
, avg(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_avg
, avg(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_avg
, avg(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_avg
, avg(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_avg
, avg(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_avg
, avg(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_avg
, avg(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_avg
, avg(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_avg
, avg(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_avg
, avg(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_avg
, avg(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_avg
, avg(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_avg
, avg(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_avg
, avg(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_avg
, avg(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_avg
, avg(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_avg
, avg(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_avg
, avg(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_avg
, avg(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_avg
, avg(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_avg
, avg(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_avg
, avg(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_avg
, avg(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_avg
, avg(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_avg
, avg(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_avg
, avg(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_avg
, avg(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_avg
, avg(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_avg
, avg(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_avg
, avg(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_avg
-- stddev
, stddev(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_stddev
, stddev(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_stddev
, stddev(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_stddev
, stddev(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_stddev
, stddev(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_stddev
, stddev(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_stddev
, stddev(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_stddev
, stddev(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_stddev
, stddev(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_stddev
, stddev(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_stddev
, stddev(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_stddev
, stddev(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_stddev
, stddev(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_stddev
, stddev(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_stddev
, stddev(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_stddev
, stddev(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_stddev
, stddev(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_stddev
, stddev(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_stddev
, stddev(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_stddev
, stddev(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_stddev
, stddev(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_stddev
from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_coalesce
group by uid, rct_12mon_cnt, created_at_rct_12mon_interval



---------------------------------------------------------------------------------------------------------------



-- 2. 近12份
drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce
create table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce as
select uid,data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
, count(data_id)over(partition by uid) as rct_12tme_cnt
, datediff(created_at_rct_12tme_max, created_at_rct_12tme_min) as created_at_rct_12tme_interval
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
    , max(created_at)over(partition by uid) as created_at_rct_12tme_max
    , min(created_at)over(partition by uid) as created_at_rct_12tme_min
    from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
    where ds = '${bizdate}'
    and last_rn <= 12
)a

;

drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_base_dim;
create table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_base_dim as
select uid, rct_12tme_cnt, created_at_rct_12tme_interval
-- max
, max(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12tme_max
, max(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12tme_max
, max(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12tme_max
, max(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12tme_max
, max(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12tme_max
, max(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12tme_max
, max(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12tme_max
, max(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12tme_max
, max(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12tme_max
, max(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12tme_max
, max(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12tme_max
, max(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12tme_max
, max(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12tme_max
, max(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12tme_max
, max(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12tme_max
, max(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_max
, max(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12tme_max
, max(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12tme_max
, max(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12tme_max
, max(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12tme_max
, max(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12tme_max
, max(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12tme_max
, max(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12tme_max
, max(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12tme_max
, max(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12tme_max
, max(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12tme_max
, max(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12tme_max
, max(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12tme_max
, max(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12tme_max
, max(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12tme_max
, max(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12tme_max
, max(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12tme_max
, max(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12tme_max
, max(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12tme_max
, max(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12tme_max
, max(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12tme_max
, max(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12tme_max
, max(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12tme_max
, max(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12tme_max
, max(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12tme_max
, max(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_max
, max(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12tme_max
, max(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12tme_max
, max(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12tme_max
, max(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12tme_max
, max(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12tme_max
, max(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12tme_max
, max(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12tme_max
, max(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12tme_max
, max(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12tme_max
, max(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12tme_max
-- min
, min(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12tme_min
, min(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12tme_min
, min(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12tme_min
, min(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12tme_min
, min(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12tme_min
, min(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12tme_min
, min(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12tme_min
, min(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12tme_min
, min(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12tme_min
, min(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12tme_min
, min(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12tme_min
, min(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12tme_min
, min(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12tme_min
, min(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12tme_min
, min(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12tme_min
, min(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_min
, min(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12tme_min
, min(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12tme_min
, min(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12tme_min
, min(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12tme_min
, min(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12tme_min
, min(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12tme_min
, min(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12tme_min
, min(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12tme_min
, min(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12tme_min
, min(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12tme_min
, min(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12tme_min
, min(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12tme_min
, min(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12tme_min
, min(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12tme_min
, min(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12tme_min
, min(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12tme_min
, min(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12tme_min
, min(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12tme_min
, min(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12tme_min
, min(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12tme_min
, min(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12tme_min
, min(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12tme_min
, min(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12tme_min
, min(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12tme_min
, min(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_min
, min(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12tme_min
, min(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12tme_min
, min(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12tme_min
, min(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12tme_min
, min(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12tme_min
, min(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12tme_min
, min(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12tme_min
, min(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12tme_min
, min(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12tme_min
, min(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12tme_min
--avg
, avg(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12tme_avg
, avg(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12tme_avg
, avg(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12tme_avg
, avg(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12tme_avg
, avg(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12tme_avg
, avg(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12tme_avg
, avg(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12tme_avg
, avg(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12tme_avg
, avg(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_avg
, avg(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12tme_avg
, avg(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12tme_avg
, avg(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12tme_avg
, avg(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12tme_avg
, avg(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12tme_avg
, avg(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12tme_avg
, avg(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12tme_avg
, avg(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12tme_avg
, avg(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12tme_avg
, avg(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12tme_avg
, avg(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12tme_avg
, avg(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12tme_avg
, avg(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12tme_avg
, avg(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_avg
, avg(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12tme_avg
, avg(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12tme_avg
, avg(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12tme_avg
, avg(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12tme_avg
, avg(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12tme_avg
, avg(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12tme_avg
, avg(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12tme_avg
-- stddev
, stddev(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12tme_stddev
, stddev(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12tme_stddev
, stddev(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12tme_stddev
, stddev(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_stddev
, stddev(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12tme_stddev
, stddev(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12tme_stddev
, stddev(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12tme_stddev
, stddev(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12tme_stddev
, stddev(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12tme_stddev
, stddev(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12tme_stddev
, stddev(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12tme_stddev
, stddev(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12tme_stddev
, stddev(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12tme_stddev
, stddev(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12tme_stddev
, stddev(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12tme_stddev
, stddev(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_stddev
, stddev(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12tme_stddev
, stddev(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12tme_stddev
, stddev(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12tme_stddev
, stddev(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12tme_stddev
, stddev(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12tme_stddev
from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_coalesce
group by uid, rct_12tme_cnt, created_at_rct_12tme_interval



---------------------------------------------------------------------------------------------------------------



-- 3. 近12个月每月最近一次
drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_coalesce ;
create table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_coalesce as
select uid,data_id, code, flag_applyloanstr, swift_number, created_at, updated_at, last_rn
, count(data_id)over(partition by uid) as rct_12mon_lst_cnt
, datediff(created_at_rct_12mon_lst_max, created_at_rct_12mon_lst_min) as created_at_rct_12mon_lst_interval
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
    , max(created_at)over(partition by uid) as created_at_rct_12mon_lst_max
    , min(created_at)over(partition by uid) as created_at_rct_12mon_lst_min
    , row_number() over(partition by uid, year(created_at), month(created_at) order by created_at desc) as rn -- 每月最后一次 aka 最近一次
    from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
    where ds = '${bizdate}'
    and date(created_at) >= add_months(last_day(add_months(to_date('${bizdate}', 'yyyymmdd'), -1)), -12)
) as a
where a.rn = 1

;


drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_base_dim;
create table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_base_dim as
select uid, rct_12mon_lst_cnt, created_at_rct_12mon_lst_interval
-- max
, max(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_lst_max
, max(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_lst_max
, max(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_lst_max
, max(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_lst_max
, max(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_lst_max
, max(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_lst_max
, max(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_lst_max
, max(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_lst_max
, max(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_max
, max(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_lst_max
, max(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_lst_max
, max(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_lst_max
, max(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_lst_max
, max(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_lst_max
, max(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_max
, max(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_lst_max
, max(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_lst_max
, max(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_lst_max
, max(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_lst_max
, max(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_lst_max
, max(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_lst_max
, max(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_lst_max
, max(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_max
, max(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_lst_max
, max(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_lst_max
, max(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_lst_max
, max(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_lst_max
, max(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_lst_max
, max(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_max
, max(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_lst_max
-- min
, min(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_lst_min
, min(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_lst_min
, min(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_lst_min
, min(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_lst_min
, min(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_lst_min
, min(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_lst_min
, min(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_lst_min
, min(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_lst_min
, min(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_min
, min(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_lst_min
, min(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_lst_min
, min(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_lst_min
, min(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_lst_min
, min(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_lst_min
, min(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_min
, min(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_lst_min
, min(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_lst_min
, min(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_lst_min
, min(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_lst_min
, min(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_lst_min
, min(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_lst_min
, min(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_lst_min
, min(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_min
, min(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_lst_min
, min(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_lst_min
, min(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_lst_min
, min(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_lst_min
, min(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_lst_min
, min(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_min
, min(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_lst_min
--avg
, avg(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_lst_avg
, avg(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_lst_avg
, avg(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_lst_avg
, avg(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_lst_avg
, avg(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_lst_avg
, avg(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_lst_avg
, avg(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_avg
, avg(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_lst_avg
, avg(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_lst_avg
, avg(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_lst_avg
, avg(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_lst_avg
, avg(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_lst_avg
, avg(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_avg
, avg(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_lst_avg
, avg(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_lst_avg
, avg(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_lst_avg
, avg(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_avg
, avg(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_lst_avg
-- stddev
, stddev(als_m1_nbank_orgnum_max) as als_m1_nbank_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_else_orgnum_max) as als_m1_nbank_else_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_allnum_max) as als_m1_nbank_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_oth_orgnum_max) as als_m1_nbank_oth_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_else_allnum_max) as als_m1_nbank_else_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_oth_allnum_max) as als_m1_nbank_oth_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_caon_orgnum_max) as als_m1_caon_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_orgnum_max) as als_d15_nbank_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_allnum_max) as als_d15_nbank_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_caon_allnum_max) as als_m1_caon_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_pdl_orgnum_max) as als_m1_pdl_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_cons_orgnum_max) as als_m1_nbank_cons_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_else_orgnum_max) as als_d15_nbank_else_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_cons_allnum_max) as als_m1_nbank_cons_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_else_allnum_max) as als_d15_nbank_else_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_nsloan_orgnum_max) as als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_pdl_allnum_max) as als_m1_pdl_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_oth_orgnum_max) as als_d15_nbank_oth_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_oth_allnum_max) as als_d15_nbank_oth_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_week_orgnum_max) as als_m1_nbank_week_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_cf_orgnum_max) as als_m1_nbank_cf_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_week_allnum_max) as als_m1_nbank_week_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_cf_allnum_max) as als_m1_nbank_cf_allnum_max_rct_12mon_lst_stddev
, stddev(als_lst_nbank_inteday_max) as als_lst_nbank_inteday_max_rct_12mon_lst_stddev
, stddev(als_m1_coon_orgnum_max) as als_m1_coon_orgnum_max_rct_12mon_lst_stddev
, stddev(als_m1_coon_allnum_max) as als_m1_coon_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_nsloan_allnum_max) as als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_caon_orgnum_max) as als_d15_caon_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_caon_allnum_max) as als_d15_caon_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_week_orgnum_max) as als_d15_nbank_week_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_week_allnum_max) as als_d15_nbank_week_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_pdl_orgnum_max) as als_d15_pdl_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_cons_orgnum_max) as als_d15_nbank_cons_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_pdl_allnum_max) as als_d15_pdl_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_cons_allnum_max) as als_d15_nbank_cons_allnum_max_rct_12mon_lst_stddev
, stddev(als_d7_nbank_orgnum_max) as als_d7_nbank_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d7_nbank_allnum_max) as als_d7_nbank_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_night_allnum_max) as als_m1_nbank_night_allnum_max_rct_12mon_lst_stddev
, stddev(als_m1_nbank_night_orgnum_max) as als_m1_nbank_night_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d7_nbank_else_allnum_max) as als_d7_nbank_else_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_nsloan_orgnum_max) as als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d7_nbank_else_orgnum_max) as als_d7_nbank_else_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_night_allnum_max) as als_d15_nbank_night_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_night_orgnum_max) as als_d15_nbank_night_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d7_nbank_oth_orgnum_max) as als_d7_nbank_oth_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d7_nbank_oth_allnum_max) as als_d7_nbank_oth_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_cf_orgnum_max) as als_d15_nbank_cf_orgnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_cf_allnum_max) as als_d15_nbank_cf_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_selfnum_max) as als_d15_nbank_selfnum_max_rct_12mon_lst_stddev
, stddev(als_d15_nbank_nsloan_allnum_max) as als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_stddev
, stddev(als_d15_coon_allnum_max) as als_d15_coon_allnum_max_rct_12mon_lst_stddev
from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_coalesce
group by uid, rct_12mon_lst_cnt, created_at_rct_12mon_lst_interval

  
;




insert overwrite table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_final_di partition(ds='${bizdate}')
SELECT a.uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at
,b.rct_12mon_cnt
,b.created_at_rct_12mon_interval
,b.als_m1_nbank_orgnum_max_rct_12mon_max
,b.als_m1_nbank_else_orgnum_max_rct_12mon_max
,b.als_m1_nbank_allnum_max_rct_12mon_max
,b.als_m1_nbank_oth_orgnum_max_rct_12mon_max
,b.als_m1_nbank_else_allnum_max_rct_12mon_max
,b.als_m1_nbank_oth_allnum_max_rct_12mon_max
,b.als_m1_caon_orgnum_max_rct_12mon_max
,b.als_d15_nbank_orgnum_max_rct_12mon_max
,b.als_d15_nbank_allnum_max_rct_12mon_max
,b.als_m1_caon_allnum_max_rct_12mon_max
,b.als_m1_pdl_orgnum_max_rct_12mon_max
,b.als_m1_nbank_cons_orgnum_max_rct_12mon_max
,b.als_d15_nbank_else_orgnum_max_rct_12mon_max
,b.als_m1_nbank_cons_allnum_max_rct_12mon_max
,b.als_d15_nbank_else_allnum_max_rct_12mon_max
,b.als_m1_nbank_nsloan_orgnum_max_rct_12mon_max
,b.als_m1_pdl_allnum_max_rct_12mon_max
,b.als_d15_nbank_oth_orgnum_max_rct_12mon_max
,b.als_d15_nbank_oth_allnum_max_rct_12mon_max
,b.als_m1_nbank_week_orgnum_max_rct_12mon_max
,b.als_m1_nbank_cf_orgnum_max_rct_12mon_max
,b.als_m1_nbank_week_allnum_max_rct_12mon_max
,b.als_m1_nbank_cf_allnum_max_rct_12mon_max
,b.als_lst_nbank_inteday_max_rct_12mon_max
,b.als_m1_coon_orgnum_max_rct_12mon_max
,b.als_m1_coon_allnum_max_rct_12mon_max
,b.als_m1_nbank_nsloan_allnum_max_rct_12mon_max
,b.als_d15_caon_orgnum_max_rct_12mon_max
,b.als_d15_caon_allnum_max_rct_12mon_max
,b.als_d15_nbank_week_orgnum_max_rct_12mon_max
,b.als_d15_nbank_week_allnum_max_rct_12mon_max
,b.als_d15_pdl_orgnum_max_rct_12mon_max
,b.als_d15_nbank_cons_orgnum_max_rct_12mon_max
,b.als_d15_pdl_allnum_max_rct_12mon_max
,b.als_d15_nbank_cons_allnum_max_rct_12mon_max
,b.als_d7_nbank_orgnum_max_rct_12mon_max
,b.als_d7_nbank_allnum_max_rct_12mon_max
,b.als_m1_nbank_night_allnum_max_rct_12mon_max
,b.als_m1_nbank_night_orgnum_max_rct_12mon_max
,b.als_d7_nbank_else_allnum_max_rct_12mon_max
,b.als_d15_nbank_nsloan_orgnum_max_rct_12mon_max
,b.als_d7_nbank_else_orgnum_max_rct_12mon_max
,b.als_d15_nbank_night_allnum_max_rct_12mon_max
,b.als_d15_nbank_night_orgnum_max_rct_12mon_max
,b.als_d7_nbank_oth_orgnum_max_rct_12mon_max
,b.als_d7_nbank_oth_allnum_max_rct_12mon_max
,b.als_d15_nbank_cf_orgnum_max_rct_12mon_max
,b.als_d15_nbank_cf_allnum_max_rct_12mon_max
,b.als_d15_nbank_selfnum_max_rct_12mon_max
,b.als_d15_nbank_nsloan_allnum_max_rct_12mon_max
,b.als_d15_coon_allnum_max_rct_12mon_max
,b.als_m1_nbank_orgnum_max_rct_12mon_min
,b.als_m1_nbank_else_orgnum_max_rct_12mon_min
,b.als_m1_nbank_allnum_max_rct_12mon_min
,b.als_m1_nbank_oth_orgnum_max_rct_12mon_min
,b.als_m1_nbank_else_allnum_max_rct_12mon_min
,b.als_m1_nbank_oth_allnum_max_rct_12mon_min
,b.als_m1_caon_orgnum_max_rct_12mon_min
,b.als_d15_nbank_orgnum_max_rct_12mon_min
,b.als_d15_nbank_allnum_max_rct_12mon_min
,b.als_m1_caon_allnum_max_rct_12mon_min
,b.als_m1_pdl_orgnum_max_rct_12mon_min
,b.als_m1_nbank_cons_orgnum_max_rct_12mon_min
,b.als_d15_nbank_else_orgnum_max_rct_12mon_min
,b.als_m1_nbank_cons_allnum_max_rct_12mon_min
,b.als_d15_nbank_else_allnum_max_rct_12mon_min
,b.als_m1_nbank_nsloan_orgnum_max_rct_12mon_min
,b.als_m1_pdl_allnum_max_rct_12mon_min
,b.als_d15_nbank_oth_orgnum_max_rct_12mon_min
,b.als_d15_nbank_oth_allnum_max_rct_12mon_min
,b.als_m1_nbank_week_orgnum_max_rct_12mon_min
,b.als_m1_nbank_cf_orgnum_max_rct_12mon_min
,b.als_m1_nbank_week_allnum_max_rct_12mon_min
,b.als_m1_nbank_cf_allnum_max_rct_12mon_min
,b.als_lst_nbank_inteday_max_rct_12mon_min
,b.als_m1_coon_orgnum_max_rct_12mon_min
,b.als_m1_coon_allnum_max_rct_12mon_min
,b.als_m1_nbank_nsloan_allnum_max_rct_12mon_min
,b.als_d15_caon_orgnum_max_rct_12mon_min
,b.als_d15_caon_allnum_max_rct_12mon_min
,b.als_d15_nbank_week_orgnum_max_rct_12mon_min
,b.als_d15_nbank_week_allnum_max_rct_12mon_min
,b.als_d15_pdl_orgnum_max_rct_12mon_min
,b.als_d15_nbank_cons_orgnum_max_rct_12mon_min
,b.als_d15_pdl_allnum_max_rct_12mon_min
,b.als_d15_nbank_cons_allnum_max_rct_12mon_min
,b.als_d7_nbank_orgnum_max_rct_12mon_min
,b.als_d7_nbank_allnum_max_rct_12mon_min
,b.als_m1_nbank_night_allnum_max_rct_12mon_min
,b.als_m1_nbank_night_orgnum_max_rct_12mon_min
,b.als_d7_nbank_else_allnum_max_rct_12mon_min
,b.als_d15_nbank_nsloan_orgnum_max_rct_12mon_min
,b.als_d7_nbank_else_orgnum_max_rct_12mon_min
,b.als_d15_nbank_night_allnum_max_rct_12mon_min
,b.als_d15_nbank_night_orgnum_max_rct_12mon_min
,b.als_d7_nbank_oth_orgnum_max_rct_12mon_min
,b.als_d7_nbank_oth_allnum_max_rct_12mon_min
,b.als_d15_nbank_cf_orgnum_max_rct_12mon_min
,b.als_d15_nbank_cf_allnum_max_rct_12mon_min
,b.als_d15_nbank_selfnum_max_rct_12mon_min
,b.als_d15_nbank_nsloan_allnum_max_rct_12mon_min
,b.als_d15_coon_allnum_max_rct_12mon_min
,b.als_m1_nbank_orgnum_max_rct_12mon_avg
,b.als_m1_nbank_else_orgnum_max_rct_12mon_avg
,b.als_m1_nbank_allnum_max_rct_12mon_avg
,b.als_m1_nbank_oth_orgnum_max_rct_12mon_avg
,b.als_m1_nbank_else_allnum_max_rct_12mon_avg
,b.als_m1_nbank_oth_allnum_max_rct_12mon_avg
,b.als_m1_caon_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_allnum_max_rct_12mon_avg
,b.als_m1_caon_allnum_max_rct_12mon_avg
,b.als_m1_pdl_orgnum_max_rct_12mon_avg
,b.als_m1_nbank_cons_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_else_orgnum_max_rct_12mon_avg
,b.als_m1_nbank_cons_allnum_max_rct_12mon_avg
,b.als_d15_nbank_else_allnum_max_rct_12mon_avg
,b.als_m1_nbank_nsloan_orgnum_max_rct_12mon_avg
,b.als_m1_pdl_allnum_max_rct_12mon_avg
,b.als_d15_nbank_oth_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_oth_allnum_max_rct_12mon_avg
,b.als_m1_nbank_week_orgnum_max_rct_12mon_avg
,b.als_m1_nbank_cf_orgnum_max_rct_12mon_avg
,b.als_m1_nbank_week_allnum_max_rct_12mon_avg
,b.als_m1_nbank_cf_allnum_max_rct_12mon_avg
,b.als_lst_nbank_inteday_max_rct_12mon_avg
,b.als_m1_coon_orgnum_max_rct_12mon_avg
,b.als_m1_coon_allnum_max_rct_12mon_avg
,b.als_m1_nbank_nsloan_allnum_max_rct_12mon_avg
,b.als_d15_caon_orgnum_max_rct_12mon_avg
,b.als_d15_caon_allnum_max_rct_12mon_avg
,b.als_d15_nbank_week_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_week_allnum_max_rct_12mon_avg
,b.als_d15_pdl_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_cons_orgnum_max_rct_12mon_avg
,b.als_d15_pdl_allnum_max_rct_12mon_avg
,b.als_d15_nbank_cons_allnum_max_rct_12mon_avg
,b.als_d7_nbank_orgnum_max_rct_12mon_avg
,b.als_d7_nbank_allnum_max_rct_12mon_avg
,b.als_m1_nbank_night_allnum_max_rct_12mon_avg
,b.als_m1_nbank_night_orgnum_max_rct_12mon_avg
,b.als_d7_nbank_else_allnum_max_rct_12mon_avg
,b.als_d15_nbank_nsloan_orgnum_max_rct_12mon_avg
,b.als_d7_nbank_else_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_night_allnum_max_rct_12mon_avg
,b.als_d15_nbank_night_orgnum_max_rct_12mon_avg
,b.als_d7_nbank_oth_orgnum_max_rct_12mon_avg
,b.als_d7_nbank_oth_allnum_max_rct_12mon_avg
,b.als_d15_nbank_cf_orgnum_max_rct_12mon_avg
,b.als_d15_nbank_cf_allnum_max_rct_12mon_avg
,b.als_d15_nbank_selfnum_max_rct_12mon_avg
,b.als_d15_nbank_nsloan_allnum_max_rct_12mon_avg
,b.als_d15_coon_allnum_max_rct_12mon_avg
,b.als_m1_nbank_orgnum_max_rct_12mon_stddev
,b.als_m1_nbank_else_orgnum_max_rct_12mon_stddev
,b.als_m1_nbank_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_oth_orgnum_max_rct_12mon_stddev
,b.als_m1_nbank_else_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_oth_allnum_max_rct_12mon_stddev
,b.als_m1_caon_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_allnum_max_rct_12mon_stddev
,b.als_m1_caon_allnum_max_rct_12mon_stddev
,b.als_m1_pdl_orgnum_max_rct_12mon_stddev
,b.als_m1_nbank_cons_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_else_orgnum_max_rct_12mon_stddev
,b.als_m1_nbank_cons_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_else_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_nsloan_orgnum_max_rct_12mon_stddev
,b.als_m1_pdl_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_oth_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_oth_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_week_orgnum_max_rct_12mon_stddev
,b.als_m1_nbank_cf_orgnum_max_rct_12mon_stddev
,b.als_m1_nbank_week_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_cf_allnum_max_rct_12mon_stddev
,b.als_lst_nbank_inteday_max_rct_12mon_stddev
,b.als_m1_coon_orgnum_max_rct_12mon_stddev
,b.als_m1_coon_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_nsloan_allnum_max_rct_12mon_stddev
,b.als_d15_caon_orgnum_max_rct_12mon_stddev
,b.als_d15_caon_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_week_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_week_allnum_max_rct_12mon_stddev
,b.als_d15_pdl_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_cons_orgnum_max_rct_12mon_stddev
,b.als_d15_pdl_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_cons_allnum_max_rct_12mon_stddev
,b.als_d7_nbank_orgnum_max_rct_12mon_stddev
,b.als_d7_nbank_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_night_allnum_max_rct_12mon_stddev
,b.als_m1_nbank_night_orgnum_max_rct_12mon_stddev
,b.als_d7_nbank_else_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_nsloan_orgnum_max_rct_12mon_stddev
,b.als_d7_nbank_else_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_night_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_night_orgnum_max_rct_12mon_stddev
,b.als_d7_nbank_oth_orgnum_max_rct_12mon_stddev
,b.als_d7_nbank_oth_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_cf_orgnum_max_rct_12mon_stddev
,b.als_d15_nbank_cf_allnum_max_rct_12mon_stddev
,b.als_d15_nbank_selfnum_max_rct_12mon_stddev
,b.als_d15_nbank_nsloan_allnum_max_rct_12mon_stddev
,b.als_d15_coon_allnum_max_rct_12mon_stddev

,c.rct_12tme_cnt
,c.created_at_rct_12tme_interval
,c.als_m1_nbank_orgnum_max_rct_12tme_max
,c.als_m1_nbank_else_orgnum_max_rct_12tme_max
,c.als_m1_nbank_allnum_max_rct_12tme_max
,c.als_m1_nbank_oth_orgnum_max_rct_12tme_max
,c.als_m1_nbank_else_allnum_max_rct_12tme_max
,c.als_m1_nbank_oth_allnum_max_rct_12tme_max
,c.als_m1_caon_orgnum_max_rct_12tme_max
,c.als_d15_nbank_orgnum_max_rct_12tme_max
,c.als_d15_nbank_allnum_max_rct_12tme_max
,c.als_m1_caon_allnum_max_rct_12tme_max
,c.als_m1_pdl_orgnum_max_rct_12tme_max
,c.als_m1_nbank_cons_orgnum_max_rct_12tme_max
,c.als_d15_nbank_else_orgnum_max_rct_12tme_max
,c.als_m1_nbank_cons_allnum_max_rct_12tme_max
,c.als_d15_nbank_else_allnum_max_rct_12tme_max
,c.als_m1_nbank_nsloan_orgnum_max_rct_12tme_max
,c.als_m1_pdl_allnum_max_rct_12tme_max
,c.als_d15_nbank_oth_orgnum_max_rct_12tme_max
,c.als_d15_nbank_oth_allnum_max_rct_12tme_max
,c.als_m1_nbank_week_orgnum_max_rct_12tme_max
,c.als_m1_nbank_cf_orgnum_max_rct_12tme_max
,c.als_m1_nbank_week_allnum_max_rct_12tme_max
,c.als_m1_nbank_cf_allnum_max_rct_12tme_max
,c.als_lst_nbank_inteday_max_rct_12tme_max
,c.als_m1_coon_orgnum_max_rct_12tme_max
,c.als_m1_coon_allnum_max_rct_12tme_max
,c.als_m1_nbank_nsloan_allnum_max_rct_12tme_max
,c.als_d15_caon_orgnum_max_rct_12tme_max
,c.als_d15_caon_allnum_max_rct_12tme_max
,c.als_d15_nbank_week_orgnum_max_rct_12tme_max
,c.als_d15_nbank_week_allnum_max_rct_12tme_max
,c.als_d15_pdl_orgnum_max_rct_12tme_max
,c.als_d15_nbank_cons_orgnum_max_rct_12tme_max
,c.als_d15_pdl_allnum_max_rct_12tme_max
,c.als_d15_nbank_cons_allnum_max_rct_12tme_max
,c.als_d7_nbank_orgnum_max_rct_12tme_max
,c.als_d7_nbank_allnum_max_rct_12tme_max
,c.als_m1_nbank_night_allnum_max_rct_12tme_max
,c.als_m1_nbank_night_orgnum_max_rct_12tme_max
,c.als_d7_nbank_else_allnum_max_rct_12tme_max
,c.als_d15_nbank_nsloan_orgnum_max_rct_12tme_max
,c.als_d7_nbank_else_orgnum_max_rct_12tme_max
,c.als_d15_nbank_night_allnum_max_rct_12tme_max
,c.als_d15_nbank_night_orgnum_max_rct_12tme_max
,c.als_d7_nbank_oth_orgnum_max_rct_12tme_max
,c.als_d7_nbank_oth_allnum_max_rct_12tme_max
,c.als_d15_nbank_cf_orgnum_max_rct_12tme_max
,c.als_d15_nbank_cf_allnum_max_rct_12tme_max
,c.als_d15_nbank_selfnum_max_rct_12tme_max
,c.als_d15_nbank_nsloan_allnum_max_rct_12tme_max
,c.als_d15_coon_allnum_max_rct_12tme_max
,c.als_m1_nbank_orgnum_max_rct_12tme_min
,c.als_m1_nbank_else_orgnum_max_rct_12tme_min
,c.als_m1_nbank_allnum_max_rct_12tme_min
,c.als_m1_nbank_oth_orgnum_max_rct_12tme_min
,c.als_m1_nbank_else_allnum_max_rct_12tme_min
,c.als_m1_nbank_oth_allnum_max_rct_12tme_min
,c.als_m1_caon_orgnum_max_rct_12tme_min
,c.als_d15_nbank_orgnum_max_rct_12tme_min
,c.als_d15_nbank_allnum_max_rct_12tme_min
,c.als_m1_caon_allnum_max_rct_12tme_min
,c.als_m1_pdl_orgnum_max_rct_12tme_min
,c.als_m1_nbank_cons_orgnum_max_rct_12tme_min
,c.als_d15_nbank_else_orgnum_max_rct_12tme_min
,c.als_m1_nbank_cons_allnum_max_rct_12tme_min
,c.als_d15_nbank_else_allnum_max_rct_12tme_min
,c.als_m1_nbank_nsloan_orgnum_max_rct_12tme_min
,c.als_m1_pdl_allnum_max_rct_12tme_min
,c.als_d15_nbank_oth_orgnum_max_rct_12tme_min
,c.als_d15_nbank_oth_allnum_max_rct_12tme_min
,c.als_m1_nbank_week_orgnum_max_rct_12tme_min
,c.als_m1_nbank_cf_orgnum_max_rct_12tme_min
,c.als_m1_nbank_week_allnum_max_rct_12tme_min
,c.als_m1_nbank_cf_allnum_max_rct_12tme_min
,c.als_lst_nbank_inteday_max_rct_12tme_min
,c.als_m1_coon_orgnum_max_rct_12tme_min
,c.als_m1_coon_allnum_max_rct_12tme_min
,c.als_m1_nbank_nsloan_allnum_max_rct_12tme_min
,c.als_d15_caon_orgnum_max_rct_12tme_min
,c.als_d15_caon_allnum_max_rct_12tme_min
,c.als_d15_nbank_week_orgnum_max_rct_12tme_min
,c.als_d15_nbank_week_allnum_max_rct_12tme_min
,c.als_d15_pdl_orgnum_max_rct_12tme_min
,c.als_d15_nbank_cons_orgnum_max_rct_12tme_min
,c.als_d15_pdl_allnum_max_rct_12tme_min
,c.als_d15_nbank_cons_allnum_max_rct_12tme_min
,c.als_d7_nbank_orgnum_max_rct_12tme_min
,c.als_d7_nbank_allnum_max_rct_12tme_min
,c.als_m1_nbank_night_allnum_max_rct_12tme_min
,c.als_m1_nbank_night_orgnum_max_rct_12tme_min
,c.als_d7_nbank_else_allnum_max_rct_12tme_min
,c.als_d15_nbank_nsloan_orgnum_max_rct_12tme_min
,c.als_d7_nbank_else_orgnum_max_rct_12tme_min
,c.als_d15_nbank_night_allnum_max_rct_12tme_min
,c.als_d15_nbank_night_orgnum_max_rct_12tme_min
,c.als_d7_nbank_oth_orgnum_max_rct_12tme_min
,c.als_d7_nbank_oth_allnum_max_rct_12tme_min
,c.als_d15_nbank_cf_orgnum_max_rct_12tme_min
,c.als_d15_nbank_cf_allnum_max_rct_12tme_min
,c.als_d15_nbank_selfnum_max_rct_12tme_min
,c.als_d15_nbank_nsloan_allnum_max_rct_12tme_min
,c.als_d15_coon_allnum_max_rct_12tme_min
,c.als_m1_nbank_orgnum_max_rct_12tme_avg
,c.als_m1_nbank_else_orgnum_max_rct_12tme_avg
,c.als_m1_nbank_allnum_max_rct_12tme_avg
,c.als_m1_nbank_oth_orgnum_max_rct_12tme_avg
,c.als_m1_nbank_else_allnum_max_rct_12tme_avg
,c.als_m1_nbank_oth_allnum_max_rct_12tme_avg
,c.als_m1_caon_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_allnum_max_rct_12tme_avg
,c.als_m1_caon_allnum_max_rct_12tme_avg
,c.als_m1_pdl_orgnum_max_rct_12tme_avg
,c.als_m1_nbank_cons_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_else_orgnum_max_rct_12tme_avg
,c.als_m1_nbank_cons_allnum_max_rct_12tme_avg
,c.als_d15_nbank_else_allnum_max_rct_12tme_avg
,c.als_m1_nbank_nsloan_orgnum_max_rct_12tme_avg
,c.als_m1_pdl_allnum_max_rct_12tme_avg
,c.als_d15_nbank_oth_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_oth_allnum_max_rct_12tme_avg
,c.als_m1_nbank_week_orgnum_max_rct_12tme_avg
,c.als_m1_nbank_cf_orgnum_max_rct_12tme_avg
,c.als_m1_nbank_week_allnum_max_rct_12tme_avg
,c.als_m1_nbank_cf_allnum_max_rct_12tme_avg
,c.als_lst_nbank_inteday_max_rct_12tme_avg
,c.als_m1_coon_orgnum_max_rct_12tme_avg
,c.als_m1_coon_allnum_max_rct_12tme_avg
,c.als_m1_nbank_nsloan_allnum_max_rct_12tme_avg
,c.als_d15_caon_orgnum_max_rct_12tme_avg
,c.als_d15_caon_allnum_max_rct_12tme_avg
,c.als_d15_nbank_week_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_week_allnum_max_rct_12tme_avg
,c.als_d15_pdl_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_cons_orgnum_max_rct_12tme_avg
,c.als_d15_pdl_allnum_max_rct_12tme_avg
,c.als_d15_nbank_cons_allnum_max_rct_12tme_avg
,c.als_d7_nbank_orgnum_max_rct_12tme_avg
,c.als_d7_nbank_allnum_max_rct_12tme_avg
,c.als_m1_nbank_night_allnum_max_rct_12tme_avg
,c.als_m1_nbank_night_orgnum_max_rct_12tme_avg
,c.als_d7_nbank_else_allnum_max_rct_12tme_avg
,c.als_d15_nbank_nsloan_orgnum_max_rct_12tme_avg
,c.als_d7_nbank_else_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_night_allnum_max_rct_12tme_avg
,c.als_d15_nbank_night_orgnum_max_rct_12tme_avg
,c.als_d7_nbank_oth_orgnum_max_rct_12tme_avg
,c.als_d7_nbank_oth_allnum_max_rct_12tme_avg
,c.als_d15_nbank_cf_orgnum_max_rct_12tme_avg
,c.als_d15_nbank_cf_allnum_max_rct_12tme_avg
,c.als_d15_nbank_selfnum_max_rct_12tme_avg
,c.als_d15_nbank_nsloan_allnum_max_rct_12tme_avg
,c.als_d15_coon_allnum_max_rct_12tme_avg
,c.als_m1_nbank_orgnum_max_rct_12tme_stddev
,c.als_m1_nbank_else_orgnum_max_rct_12tme_stddev
,c.als_m1_nbank_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_oth_orgnum_max_rct_12tme_stddev
,c.als_m1_nbank_else_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_oth_allnum_max_rct_12tme_stddev
,c.als_m1_caon_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_allnum_max_rct_12tme_stddev
,c.als_m1_caon_allnum_max_rct_12tme_stddev
,c.als_m1_pdl_orgnum_max_rct_12tme_stddev
,c.als_m1_nbank_cons_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_else_orgnum_max_rct_12tme_stddev
,c.als_m1_nbank_cons_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_else_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_nsloan_orgnum_max_rct_12tme_stddev
,c.als_m1_pdl_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_oth_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_oth_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_week_orgnum_max_rct_12tme_stddev
,c.als_m1_nbank_cf_orgnum_max_rct_12tme_stddev
,c.als_m1_nbank_week_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_cf_allnum_max_rct_12tme_stddev
,c.als_lst_nbank_inteday_max_rct_12tme_stddev
,c.als_m1_coon_orgnum_max_rct_12tme_stddev
,c.als_m1_coon_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_nsloan_allnum_max_rct_12tme_stddev
,c.als_d15_caon_orgnum_max_rct_12tme_stddev
,c.als_d15_caon_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_week_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_week_allnum_max_rct_12tme_stddev
,c.als_d15_pdl_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_cons_orgnum_max_rct_12tme_stddev
,c.als_d15_pdl_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_cons_allnum_max_rct_12tme_stddev
,c.als_d7_nbank_orgnum_max_rct_12tme_stddev
,c.als_d7_nbank_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_night_allnum_max_rct_12tme_stddev
,c.als_m1_nbank_night_orgnum_max_rct_12tme_stddev
,c.als_d7_nbank_else_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_nsloan_orgnum_max_rct_12tme_stddev
,c.als_d7_nbank_else_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_night_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_night_orgnum_max_rct_12tme_stddev
,c.als_d7_nbank_oth_orgnum_max_rct_12tme_stddev
,c.als_d7_nbank_oth_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_cf_orgnum_max_rct_12tme_stddev
,c.als_d15_nbank_cf_allnum_max_rct_12tme_stddev
,c.als_d15_nbank_selfnum_max_rct_12tme_stddev
,c.als_d15_nbank_nsloan_allnum_max_rct_12tme_stddev
,c.als_d15_coon_allnum_max_rct_12tme_stddev

,d.rct_12mon_lst_cnt
,d.created_at_rct_12mon_lst_interval
,d.als_m1_nbank_orgnum_max_rct_12mon_lst_max
,d.als_m1_nbank_else_orgnum_max_rct_12mon_lst_max
,d.als_m1_nbank_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_oth_orgnum_max_rct_12mon_lst_max
,d.als_m1_nbank_else_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_oth_allnum_max_rct_12mon_lst_max
,d.als_m1_caon_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_allnum_max_rct_12mon_lst_max
,d.als_m1_caon_allnum_max_rct_12mon_lst_max
,d.als_m1_pdl_orgnum_max_rct_12mon_lst_max
,d.als_m1_nbank_cons_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_else_orgnum_max_rct_12mon_lst_max
,d.als_m1_nbank_cons_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_else_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_max
,d.als_m1_pdl_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_oth_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_oth_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_week_orgnum_max_rct_12mon_lst_max
,d.als_m1_nbank_cf_orgnum_max_rct_12mon_lst_max
,d.als_m1_nbank_week_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_cf_allnum_max_rct_12mon_lst_max
,d.als_lst_nbank_inteday_max_rct_12mon_lst_max
,d.als_m1_coon_orgnum_max_rct_12mon_lst_max
,d.als_m1_coon_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_max
,d.als_d15_caon_orgnum_max_rct_12mon_lst_max
,d.als_d15_caon_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_week_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_week_allnum_max_rct_12mon_lst_max
,d.als_d15_pdl_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_cons_orgnum_max_rct_12mon_lst_max
,d.als_d15_pdl_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_cons_allnum_max_rct_12mon_lst_max
,d.als_d7_nbank_orgnum_max_rct_12mon_lst_max
,d.als_d7_nbank_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_night_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_night_orgnum_max_rct_12mon_lst_max
,d.als_d7_nbank_else_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_max
,d.als_d7_nbank_else_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_night_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_night_orgnum_max_rct_12mon_lst_max
,d.als_d7_nbank_oth_orgnum_max_rct_12mon_lst_max
,d.als_d7_nbank_oth_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_cf_orgnum_max_rct_12mon_lst_max
,d.als_d15_nbank_cf_allnum_max_rct_12mon_lst_max
,d.als_d15_nbank_selfnum_max_rct_12mon_lst_max
,d.als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_max
,d.als_d15_coon_allnum_max_rct_12mon_lst_max
,d.als_m1_nbank_orgnum_max_rct_12mon_lst_min
,d.als_m1_nbank_else_orgnum_max_rct_12mon_lst_min
,d.als_m1_nbank_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_oth_orgnum_max_rct_12mon_lst_min
,d.als_m1_nbank_else_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_oth_allnum_max_rct_12mon_lst_min
,d.als_m1_caon_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_allnum_max_rct_12mon_lst_min
,d.als_m1_caon_allnum_max_rct_12mon_lst_min
,d.als_m1_pdl_orgnum_max_rct_12mon_lst_min
,d.als_m1_nbank_cons_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_else_orgnum_max_rct_12mon_lst_min
,d.als_m1_nbank_cons_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_else_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_min
,d.als_m1_pdl_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_oth_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_oth_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_week_orgnum_max_rct_12mon_lst_min
,d.als_m1_nbank_cf_orgnum_max_rct_12mon_lst_min
,d.als_m1_nbank_week_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_cf_allnum_max_rct_12mon_lst_min
,d.als_lst_nbank_inteday_max_rct_12mon_lst_min
,d.als_m1_coon_orgnum_max_rct_12mon_lst_min
,d.als_m1_coon_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_min
,d.als_d15_caon_orgnum_max_rct_12mon_lst_min
,d.als_d15_caon_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_week_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_week_allnum_max_rct_12mon_lst_min
,d.als_d15_pdl_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_cons_orgnum_max_rct_12mon_lst_min
,d.als_d15_pdl_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_cons_allnum_max_rct_12mon_lst_min
,d.als_d7_nbank_orgnum_max_rct_12mon_lst_min
,d.als_d7_nbank_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_night_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_night_orgnum_max_rct_12mon_lst_min
,d.als_d7_nbank_else_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_min
,d.als_d7_nbank_else_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_night_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_night_orgnum_max_rct_12mon_lst_min
,d.als_d7_nbank_oth_orgnum_max_rct_12mon_lst_min
,d.als_d7_nbank_oth_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_cf_orgnum_max_rct_12mon_lst_min
,d.als_d15_nbank_cf_allnum_max_rct_12mon_lst_min
,d.als_d15_nbank_selfnum_max_rct_12mon_lst_min
,d.als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_min
,d.als_d15_coon_allnum_max_rct_12mon_lst_min
,d.als_m1_nbank_orgnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_else_orgnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_oth_orgnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_else_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_oth_allnum_max_rct_12mon_lst_avg
,d.als_m1_caon_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_allnum_max_rct_12mon_lst_avg
,d.als_m1_caon_allnum_max_rct_12mon_lst_avg
,d.als_m1_pdl_orgnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_cons_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_else_orgnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_cons_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_else_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_avg
,d.als_m1_pdl_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_oth_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_oth_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_week_orgnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_cf_orgnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_week_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_cf_allnum_max_rct_12mon_lst_avg
,d.als_lst_nbank_inteday_max_rct_12mon_lst_avg
,d.als_m1_coon_orgnum_max_rct_12mon_lst_avg
,d.als_m1_coon_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_avg
,d.als_d15_caon_orgnum_max_rct_12mon_lst_avg
,d.als_d15_caon_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_week_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_week_allnum_max_rct_12mon_lst_avg
,d.als_d15_pdl_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_cons_orgnum_max_rct_12mon_lst_avg
,d.als_d15_pdl_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_cons_allnum_max_rct_12mon_lst_avg
,d.als_d7_nbank_orgnum_max_rct_12mon_lst_avg
,d.als_d7_nbank_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_night_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_night_orgnum_max_rct_12mon_lst_avg
,d.als_d7_nbank_else_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_avg
,d.als_d7_nbank_else_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_night_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_night_orgnum_max_rct_12mon_lst_avg
,d.als_d7_nbank_oth_orgnum_max_rct_12mon_lst_avg
,d.als_d7_nbank_oth_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_cf_orgnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_cf_allnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_selfnum_max_rct_12mon_lst_avg
,d.als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_avg
,d.als_d15_coon_allnum_max_rct_12mon_lst_avg
,d.als_m1_nbank_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_else_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_oth_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_else_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_oth_allnum_max_rct_12mon_lst_stddev
,d.als_m1_caon_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_allnum_max_rct_12mon_lst_stddev
,d.als_m1_caon_allnum_max_rct_12mon_lst_stddev
,d.als_m1_pdl_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_cons_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_else_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_cons_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_else_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_nsloan_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_pdl_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_oth_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_oth_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_week_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_cf_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_week_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_cf_allnum_max_rct_12mon_lst_stddev
,d.als_lst_nbank_inteday_max_rct_12mon_lst_stddev
,d.als_m1_coon_orgnum_max_rct_12mon_lst_stddev
,d.als_m1_coon_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_nsloan_allnum_max_rct_12mon_lst_stddev
,d.als_d15_caon_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_caon_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_week_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_week_allnum_max_rct_12mon_lst_stddev
,d.als_d15_pdl_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_cons_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_pdl_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_cons_allnum_max_rct_12mon_lst_stddev
,d.als_d7_nbank_orgnum_max_rct_12mon_lst_stddev
,d.als_d7_nbank_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_night_allnum_max_rct_12mon_lst_stddev
,d.als_m1_nbank_night_orgnum_max_rct_12mon_lst_stddev
,d.als_d7_nbank_else_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_nsloan_orgnum_max_rct_12mon_lst_stddev
,d.als_d7_nbank_else_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_night_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_night_orgnum_max_rct_12mon_lst_stddev
,d.als_d7_nbank_oth_orgnum_max_rct_12mon_lst_stddev
,d.als_d7_nbank_oth_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_cf_orgnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_cf_allnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_selfnum_max_rct_12mon_lst_stddev
,d.als_d15_nbank_nsloan_allnum_max_rct_12mon_lst_stddev
,d.als_d15_coon_allnum_max_rct_12mon_lst_stddev
from(
    SELECT uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at
    from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
    where ds='${bizdate}'
    and last_rn = 1
)a
left join pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_base_dim b
on a.uid = b.uid
left join pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_base_dim c
on a.uid = c.uid
left join pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12mon_lst_base_dim d
on a.uid = d.uid
-- feature-copilot:node-end ordinal=0
