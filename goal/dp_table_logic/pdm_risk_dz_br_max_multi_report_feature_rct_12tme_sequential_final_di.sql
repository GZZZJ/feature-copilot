-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di
-- node_id: n_7014291239227293696
-- task_name: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di
-- owner_name: 曹佳程
-- source_json: goal/dp_table_logic/pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di.json
-- source_json_sha256: cbf90516bdbdea94404f354d62fea946227a8db85cc154dda9552ea4eeb0ed0a
-- upstream_table: pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_size
-- upstream_table: pdm_risk.dz_br_max_multi_report_feature_rct_12tme_lag
-- upstream_table: pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_id
-- upstream_table: pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
-- upstream_table: pdm_risk.dz_br_max_multi_report_feature_rct_12tme_seq
-- upstream_table: pdm_risk.dz_br_max_multi_report_feature_rct_12tme_coalesce

-- drop table if exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di;
create table if not exists pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di(
uid string comment '用户id',
data_id STRING COMMENT '数据ID',
code STRING COMMENT '响应码',
flag_applyloanstr STRING COMMENT '借贷意向验证产品输出标识',
swift_number STRING COMMENT '操作流水号',
created_at TIMESTAMP COMMENT '创建时间',
updated_at TIMESTAMP COMMENT '更新时间'

-- 2. 近12份
, als_m1_nbank_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_else_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_caon_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_caon_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_pdl_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_cons_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_cons_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_else_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_pdl_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_week_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_cf_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_week_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_cf_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_lst_nbank_inteday_max_rct_12tme_inc_seq_cnt float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_coon_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_coon_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_caon_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_caon_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_week_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_week_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_pdl_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_cons_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_pdl_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_cons_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d7_nbank_orgnum_max_rct_12tme_inc_seq_cnt float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d7_nbank_allnum_max_rct_12tme_inc_seq_cnt float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_night_allnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_night_orgnum_max_rct_12tme_inc_seq_cnt float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d7_nbank_else_allnum_max_rct_12tme_inc_seq_cnt float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d7_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_night_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_night_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d7_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d7_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_cf_orgnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_cf_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_selfnum_max_rct_12tme_inc_seq_cnt float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_d15_coon_allnum_max_rct_12tme_inc_seq_cnt float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12份连续上升最大次数'
, als_m1_nbank_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_else_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_caon_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_caon_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_pdl_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_cons_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_cons_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_else_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_pdl_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_week_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_cf_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_week_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_cf_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_lst_nbank_inteday_max_rct_12tme_dec_seq_cnt float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_coon_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_coon_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_caon_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_caon_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_week_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_week_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_pdl_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_cons_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_pdl_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_cons_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d7_nbank_orgnum_max_rct_12tme_dec_seq_cnt float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d7_nbank_allnum_max_rct_12tme_dec_seq_cnt float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_night_allnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_night_orgnum_max_rct_12tme_dec_seq_cnt float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d7_nbank_else_allnum_max_rct_12tme_dec_seq_cnt float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d7_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_night_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_night_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d7_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d7_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_cf_orgnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_cf_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_selfnum_max_rct_12tme_dec_seq_cnt float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_d15_coon_allnum_max_rct_12tme_dec_seq_cnt float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12份连续下降最大次数'
, als_m1_nbank_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_else_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_oth_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_else_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_oth_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_caon_orgnum_max_rct_12tme_inc_rto float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_caon_allnum_max_rct_12tme_inc_rto float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_pdl_orgnum_max_rct_12tme_inc_rto float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_cons_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_else_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_cons_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_else_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_pdl_allnum_max_rct_12tme_inc_rto float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_oth_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_oth_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_week_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_cf_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_week_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_cf_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_lst_nbank_inteday_max_rct_12tme_inc_rto float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_coon_orgnum_max_rct_12tme_inc_rto float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_coon_allnum_max_rct_12tme_inc_rto float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_caon_orgnum_max_rct_12tme_inc_rto float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_caon_allnum_max_rct_12tme_inc_rto float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_week_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_week_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_pdl_orgnum_max_rct_12tme_inc_rto float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_cons_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_pdl_allnum_max_rct_12tme_inc_rto float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_cons_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d7_nbank_orgnum_max_rct_12tme_inc_rto float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d7_nbank_allnum_max_rct_12tme_inc_rto float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_night_allnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_night_orgnum_max_rct_12tme_inc_rto float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d7_nbank_else_allnum_max_rct_12tme_inc_rto float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d7_nbank_else_orgnum_max_rct_12tme_inc_rto float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_night_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_night_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d7_nbank_oth_orgnum_max_rct_12tme_inc_rto float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份上升次数占比'
, als_d7_nbank_oth_allnum_max_rct_12tme_inc_rto float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_cf_orgnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_cf_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_selfnum_max_rct_12tme_inc_rto float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_inc_rto float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_d15_coon_allnum_max_rct_12tme_inc_rto float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12份上升次数占比'
, als_m1_nbank_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_else_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_oth_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_else_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-其他申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_oth_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_caon_orgnum_max_rct_12tme_dec_rto float comment '近1个月申请线上现金分期的机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_caon_allnum_max_rct_12tme_dec_rto float comment '近1个月申请线上现金分期的次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_pdl_orgnum_max_rct_12tme_dec_rto float comment '近1个月申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_cons_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_else_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_cons_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_else_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_pdl_allnum_max_rct_12tme_dec_rto float comment '近1个月申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_oth_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_oth_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_week_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构周末申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_cf_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_week_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构周末申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_cf_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_lst_nbank_inteday_max_rct_12tme_dec_rto float comment '距最近在非银行机构申请的间隔天数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_coon_orgnum_max_rct_12tme_dec_rto float comment '近1个月申请线上消费分期的机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_coon_allnum_max_rct_12tme_dec_rto float comment '近1个月申请线上消费分期的次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_nsloan_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_caon_orgnum_max_rct_12tme_dec_rto float comment '近15天申请线上现金分期的机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_caon_allnum_max_rct_12tme_dec_rto float comment '近15天申请线上现金分期的次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_week_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构周末申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_week_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构周末申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_pdl_orgnum_max_rct_12tme_dec_rto float comment '近15天申请线上小额现金贷的机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_cons_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-持牌消费金融机构申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_pdl_allnum_max_rct_12tme_dec_rto float comment '近15天申请线上小额现金贷的次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_cons_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-持牌消费金融机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d7_nbank_orgnum_max_rct_12tme_dec_rto float comment '近7天在非银机构申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d7_nbank_allnum_max_rct_12tme_dec_rto float comment '近7天在非银机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_night_allnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构夜间申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_m1_nbank_night_orgnum_max_rct_12tme_dec_rto float comment '近1个月在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d7_nbank_else_allnum_max_rct_12tme_dec_rto float comment '近7天在非银机构-其他申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-持牌网络小贷机构申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d7_nbank_else_orgnum_max_rct_12tme_dec_rto float comment '近7天在非银机构-其他申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_night_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构夜间申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_night_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构夜间申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d7_nbank_oth_orgnum_max_rct_12tme_dec_rto float comment '近7天在非银机构-其他申请机构数other(身份证和手机号查询取max)_近12份下降次数占比'
, als_d7_nbank_oth_allnum_max_rct_12tme_dec_rto float comment '近7天在非银机构-其他申请次数other(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_cf_orgnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-消费类分期申请机构数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_cf_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-消费类分期机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_selfnum_max_rct_12tme_dec_rto float comment '近15天在本机构(本机构为非银)申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_nbank_nsloan_allnum_max_rct_12tme_dec_rto float comment '近15天在非银机构-持牌网络小贷机构申请次数(身份证和手机号查询取max)_近12份下降次数占比'
, als_d15_coon_allnum_max_rct_12tme_dec_rto float comment '近15天申请线上消费分期的次数(身份证和手机号查询取max)_近12份下降次数占比'

) comment '百融max_多报文特征中间表_多份报文连续变化_近12份'
partitioned by (ds string)

;







-- 2. 近12份
drop table if exists pdm_risk.dz_br_max_multi_report_feature_rct_12tme_coalesce
create table pdm_risk.dz_br_max_multi_report_feature_rct_12tme_coalesce as
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

drop table if exists pdm_risk.dz_br_max_multi_report_feature_rct_12tme_lag;
CREATE table pdm_risk.dz_br_max_multi_report_feature_rct_12tme_lag as
SELECT *
, lag(als_m1_nbank_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_else_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_else_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_caon_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_caon_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_caon_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_caon_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_pdl_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_pdl_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_else_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_else_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_pdl_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_pdl_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_week_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_week_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd_lag
, lag(als_lst_nbank_inteday_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_lst_nbank_inteday_max_rct_12tme_diff_trd_lag
, lag(als_m1_coon_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_coon_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_coon_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_coon_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_caon_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_caon_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_caon_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_caon_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_week_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_week_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_pdl_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_pdl_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_pdl_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_pdl_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d7_nbank_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d7_nbank_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d7_nbank_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d7_nbank_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_night_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_night_allnum_max_rct_12tme_diff_trd_lag
, lag(als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d7_nbank_else_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d7_nbank_else_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_night_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_night_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_selfnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_selfnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd_lag
, lag(als_d15_coon_allnum_max_rct_12tme_diff_trd, 1, -999) OVER (PARTITION BY uid ORDER BY created_at desc) as als_d15_coon_allnum_max_rct_12tme_diff_trd_lag
from(
    SELECT uid, created_at, rct_12tme_cnt
    -- >0 : 1, =0 : 0, <0 : -1
    , sign(als_m1_nbank_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_else_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_oth_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_else_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_else_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_oth_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_caon_orgnum_max_rct_12tme_nxt_diff) as als_m1_caon_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_caon_allnum_max_rct_12tme_nxt_diff) as als_m1_caon_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_pdl_orgnum_max_rct_12tme_nxt_diff) as als_m1_pdl_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_cons_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_else_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_cons_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_else_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_else_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_nsloan_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_pdl_allnum_max_rct_12tme_nxt_diff) as als_m1_pdl_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_oth_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_oth_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_week_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_cf_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_week_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_week_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_cf_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd
    , sign(als_lst_nbank_inteday_max_rct_12tme_nxt_diff) as als_lst_nbank_inteday_max_rct_12tme_diff_trd
    , sign(als_m1_coon_orgnum_max_rct_12tme_nxt_diff) as als_m1_coon_orgnum_max_rct_12tme_diff_trd
    , sign(als_m1_coon_allnum_max_rct_12tme_nxt_diff) as als_m1_coon_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_nsloan_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_caon_orgnum_max_rct_12tme_nxt_diff) as als_d15_caon_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_caon_allnum_max_rct_12tme_nxt_diff) as als_d15_caon_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_week_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_week_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_week_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_pdl_orgnum_max_rct_12tme_nxt_diff) as als_d15_pdl_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_cons_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_pdl_allnum_max_rct_12tme_nxt_diff) as als_d15_pdl_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_cons_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd
    , sign(als_d7_nbank_orgnum_max_rct_12tme_nxt_diff) as als_d7_nbank_orgnum_max_rct_12tme_diff_trd
    , sign(als_d7_nbank_allnum_max_rct_12tme_nxt_diff) as als_d7_nbank_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_night_allnum_max_rct_12tme_nxt_diff) as als_m1_nbank_night_allnum_max_rct_12tme_diff_trd
    , sign(als_m1_nbank_night_orgnum_max_rct_12tme_nxt_diff) as als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd
    , sign(als_d7_nbank_else_allnum_max_rct_12tme_nxt_diff) as als_d7_nbank_else_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_nsloan_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd
    , sign(als_d7_nbank_else_orgnum_max_rct_12tme_nxt_diff) as als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_night_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_night_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_night_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd
    , sign(als_d7_nbank_oth_orgnum_max_rct_12tme_nxt_diff) as als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd
    , sign(als_d7_nbank_oth_allnum_max_rct_12tme_nxt_diff) as als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_cf_orgnum_max_rct_12tme_nxt_diff) as als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_cf_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_selfnum_max_rct_12tme_nxt_diff) as als_d15_nbank_selfnum_max_rct_12tme_diff_trd
    , sign(als_d15_nbank_nsloan_allnum_max_rct_12tme_nxt_diff) as als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd
    , sign(als_d15_coon_allnum_max_rct_12tme_nxt_diff) as als_d15_coon_allnum_max_rct_12tme_diff_trd
    from(
        SELECT uid, created_at
        , count(data_id)over(partition by uid) as rct_12tme_cnt 
        , lead(als_m1_nbank_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_orgnum_max as als_m1_nbank_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_else_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_else_orgnum_max as als_m1_nbank_else_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_allnum_max as als_m1_nbank_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_oth_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_oth_orgnum_max as als_m1_nbank_oth_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_else_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_else_allnum_max as als_m1_nbank_else_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_oth_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_oth_allnum_max as als_m1_nbank_oth_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_caon_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_caon_orgnum_max as als_m1_caon_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_orgnum_max as als_d15_nbank_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_allnum_max as als_d15_nbank_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_caon_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_caon_allnum_max as als_m1_caon_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_pdl_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_pdl_orgnum_max as als_m1_pdl_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_cons_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_cons_orgnum_max as als_m1_nbank_cons_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_else_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_else_orgnum_max as als_d15_nbank_else_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_cons_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_cons_allnum_max as als_m1_nbank_cons_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_else_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_else_allnum_max as als_d15_nbank_else_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_nsloan_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_nsloan_orgnum_max as als_m1_nbank_nsloan_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_pdl_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_pdl_allnum_max as als_m1_pdl_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_oth_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_oth_orgnum_max as als_d15_nbank_oth_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_oth_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_oth_allnum_max as als_d15_nbank_oth_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_week_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_week_orgnum_max as als_m1_nbank_week_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_cf_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_cf_orgnum_max as als_m1_nbank_cf_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_week_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_week_allnum_max as als_m1_nbank_week_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_cf_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_cf_allnum_max as als_m1_nbank_cf_allnum_max_rct_12tme_nxt_diff
        , lead(als_lst_nbank_inteday_max, 1, -999)over(partition by uid order by created_at) - als_lst_nbank_inteday_max as als_lst_nbank_inteday_max_rct_12tme_nxt_diff
        , lead(als_m1_coon_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_coon_orgnum_max as als_m1_coon_orgnum_max_rct_12tme_nxt_diff
        , lead(als_m1_coon_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_coon_allnum_max as als_m1_coon_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_nsloan_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_nsloan_allnum_max as als_m1_nbank_nsloan_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_caon_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_caon_orgnum_max as als_d15_caon_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_caon_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_caon_allnum_max as als_d15_caon_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_week_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_week_orgnum_max as als_d15_nbank_week_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_week_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_week_allnum_max as als_d15_nbank_week_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_pdl_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_pdl_orgnum_max as als_d15_pdl_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_cons_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_cons_orgnum_max as als_d15_nbank_cons_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_pdl_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_pdl_allnum_max as als_d15_pdl_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_cons_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_cons_allnum_max as als_d15_nbank_cons_allnum_max_rct_12tme_nxt_diff
        , lead(als_d7_nbank_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d7_nbank_orgnum_max as als_d7_nbank_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d7_nbank_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d7_nbank_allnum_max as als_d7_nbank_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_night_allnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_night_allnum_max as als_m1_nbank_night_allnum_max_rct_12tme_nxt_diff
        , lead(als_m1_nbank_night_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_m1_nbank_night_orgnum_max as als_m1_nbank_night_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d7_nbank_else_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d7_nbank_else_allnum_max as als_d7_nbank_else_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_nsloan_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_nsloan_orgnum_max as als_d15_nbank_nsloan_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d7_nbank_else_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d7_nbank_else_orgnum_max as als_d7_nbank_else_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_night_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_night_allnum_max as als_d15_nbank_night_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_night_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_night_orgnum_max as als_d15_nbank_night_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d7_nbank_oth_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d7_nbank_oth_orgnum_max as als_d7_nbank_oth_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d7_nbank_oth_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d7_nbank_oth_allnum_max as als_d7_nbank_oth_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_cf_orgnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_cf_orgnum_max as als_d15_nbank_cf_orgnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_cf_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_cf_allnum_max as als_d15_nbank_cf_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_selfnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_selfnum_max as als_d15_nbank_selfnum_max_rct_12tme_nxt_diff
        , lead(als_d15_nbank_nsloan_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_nbank_nsloan_allnum_max as als_d15_nbank_nsloan_allnum_max_rct_12tme_nxt_diff
        , lead(als_d15_coon_allnum_max, 1, -999)over(partition by uid order by created_at) - als_d15_coon_allnum_max as als_d15_coon_allnum_max_rct_12tme_nxt_diff
        from pdm_risk.dz_br_max_multi_report_feature_rct_12tme_coalesce
        -- where uid in ('002bfccd-d509-4e27-8ec6-f0d2c72b2797')
    )a
)a

;




drop table if exists pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_id;
CREATE table pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_id as
            select uid, rct_12tme_cnt, created_at, als_m1_nbank_orgnum_max_rct_12tme_diff_trd_lag
            , als_m1_nbank_orgnum_max_rct_12tme_diff_trd
            , als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd
            , als_m1_nbank_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd
            , als_m1_nbank_else_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd
            , als_m1_caon_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_allnum_max_rct_12tme_diff_trd
            , als_m1_caon_allnum_max_rct_12tme_diff_trd
            , als_m1_pdl_orgnum_max_rct_12tme_diff_trd
            , als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd
            , als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_else_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd
            , als_m1_pdl_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd
            , als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd
            , als_m1_nbank_week_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd
            , als_lst_nbank_inteday_max_rct_12tme_diff_trd
            , als_m1_coon_orgnum_max_rct_12tme_diff_trd
            , als_m1_coon_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd
            , als_d15_caon_orgnum_max_rct_12tme_diff_trd
            , als_d15_caon_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_week_allnum_max_rct_12tme_diff_trd
            , als_d15_pdl_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd
            , als_d15_pdl_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd
            , als_d7_nbank_orgnum_max_rct_12tme_diff_trd
            , als_d7_nbank_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_night_allnum_max_rct_12tme_diff_trd
            , als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd
            , als_d7_nbank_else_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd
            , als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_night_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd
            , als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd
            , als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd
            , als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd
            , als_d15_nbank_selfnum_max_rct_12tme_diff_trd
            , als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd
            , als_d15_coon_allnum_max_rct_12tme_diff_trd
            , sum(CASE WHEN als_m1_nbank_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_else_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_allnum_max_rct_12tme_diff_trd != als_m1_nbank_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_oth_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_else_allnum_max_rct_12tme_diff_trd != als_m1_nbank_else_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_else_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd != als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_oth_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_caon_orgnum_max_rct_12tme_diff_trd != als_m1_caon_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_caon_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_allnum_max_rct_12tme_diff_trd != als_d15_nbank_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_caon_allnum_max_rct_12tme_diff_trd != als_m1_caon_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_caon_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_pdl_orgnum_max_rct_12tme_diff_trd != als_m1_pdl_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_pdl_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_cons_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_else_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd != als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_cons_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_else_allnum_max_rct_12tme_diff_trd != als_d15_nbank_else_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_else_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_pdl_allnum_max_rct_12tme_diff_trd != als_m1_pdl_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_pdl_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_oth_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd != als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_oth_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_week_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_cf_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_week_allnum_max_rct_12tme_diff_trd != als_m1_nbank_week_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_week_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd != als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_cf_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_lst_nbank_inteday_max_rct_12tme_diff_trd != als_lst_nbank_inteday_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_lst_nbank_inteday_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_coon_orgnum_max_rct_12tme_diff_trd != als_m1_coon_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_coon_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_coon_allnum_max_rct_12tme_diff_trd != als_m1_coon_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_coon_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd != als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_caon_orgnum_max_rct_12tme_diff_trd != als_d15_caon_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_caon_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_caon_allnum_max_rct_12tme_diff_trd != als_d15_caon_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_caon_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_week_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_week_allnum_max_rct_12tme_diff_trd != als_d15_nbank_week_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_week_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_pdl_orgnum_max_rct_12tme_diff_trd != als_d15_pdl_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_pdl_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_cons_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_pdl_allnum_max_rct_12tme_diff_trd != als_d15_pdl_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_pdl_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd != als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_cons_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d7_nbank_orgnum_max_rct_12tme_diff_trd != als_d7_nbank_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d7_nbank_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d7_nbank_allnum_max_rct_12tme_diff_trd != als_d7_nbank_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d7_nbank_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_night_allnum_max_rct_12tme_diff_trd != als_m1_nbank_night_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_night_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd != als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_m1_nbank_night_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d7_nbank_else_allnum_max_rct_12tme_diff_trd != als_d7_nbank_else_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d7_nbank_else_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd != als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d7_nbank_else_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_night_allnum_max_rct_12tme_diff_trd != als_d15_nbank_night_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_night_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_night_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd != als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d7_nbank_oth_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd != als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d7_nbank_oth_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd != als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_cf_orgnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd != als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_cf_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_selfnum_max_rct_12tme_diff_trd != als_d15_nbank_selfnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_selfnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd != als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_id
            , sum(CASE WHEN als_d15_coon_allnum_max_rct_12tme_diff_trd != als_d15_coon_allnum_max_rct_12tme_diff_trd_lag THEN 1 ELSE 0 END) OVER (PARTITION BY uid ORDER BY created_at desc) AS als_d15_coon_allnum_max_rct_12tme_grp_id
            from pdm_risk.dz_br_max_multi_report_feature_rct_12tme_lag
        


;




drop table if exists pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_size;
CREATE table pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_size as
    SELECT uid, rct_12tme_cnt, created_at
    , als_m1_nbank_orgnum_max_rct_12tme_diff_trd
    , als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd
    , als_m1_nbank_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd
    , als_m1_nbank_else_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd
    , als_m1_caon_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_allnum_max_rct_12tme_diff_trd
    , als_m1_caon_allnum_max_rct_12tme_diff_trd
    , als_m1_pdl_orgnum_max_rct_12tme_diff_trd
    , als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd
    , als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_else_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd
    , als_m1_pdl_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd
    , als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd
    , als_m1_nbank_week_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd
    , als_lst_nbank_inteday_max_rct_12tme_diff_trd
    , als_m1_coon_orgnum_max_rct_12tme_diff_trd
    , als_m1_coon_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd
    , als_d15_caon_orgnum_max_rct_12tme_diff_trd
    , als_d15_caon_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_week_allnum_max_rct_12tme_diff_trd
    , als_d15_pdl_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd
    , als_d15_pdl_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd
    , als_d7_nbank_orgnum_max_rct_12tme_diff_trd
    , als_d7_nbank_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_night_allnum_max_rct_12tme_diff_trd
    , als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd
    , als_d7_nbank_else_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd
    , als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_night_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd
    , als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd
    , als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd
    , als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd
    , als_d15_nbank_selfnum_max_rct_12tme_diff_trd
    , als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd
    , als_d15_coon_allnum_max_rct_12tme_diff_trd
    , case when als_m1_nbank_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_orgnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_else_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_else_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_else_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_else_orgnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_oth_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_oth_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_oth_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_oth_orgnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_else_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_else_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_else_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_else_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_oth_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_oth_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_oth_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_oth_allnum_max_rct_12tme_grp_size
    , case when als_m1_caon_orgnum_max_rct_12tme_grp_id=1 then als_m1_caon_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_caon_orgnum_max_rct_12tme_grp_size_org end as als_m1_caon_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_allnum_max_rct_12tme_grp_size
    , case when als_m1_caon_allnum_max_rct_12tme_grp_id=1 then als_m1_caon_allnum_max_rct_12tme_grp_size_org-1 else als_m1_caon_allnum_max_rct_12tme_grp_size_org end as als_m1_caon_allnum_max_rct_12tme_grp_size
    , case when als_m1_pdl_orgnum_max_rct_12tme_grp_id=1 then als_m1_pdl_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_pdl_orgnum_max_rct_12tme_grp_size_org end as als_m1_pdl_orgnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_cons_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_cons_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_cons_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_cons_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_else_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_else_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_else_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_else_orgnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_cons_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_cons_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_cons_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_cons_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_else_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_else_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_else_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_else_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_size
    , case when als_m1_pdl_allnum_max_rct_12tme_grp_id=1 then als_m1_pdl_allnum_max_rct_12tme_grp_size_org-1 else als_m1_pdl_allnum_max_rct_12tme_grp_size_org end as als_m1_pdl_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_oth_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_oth_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_oth_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_oth_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_oth_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_oth_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_oth_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_oth_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_week_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_week_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_week_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_week_orgnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_cf_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_cf_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_cf_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_cf_orgnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_week_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_week_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_week_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_week_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_cf_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_cf_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_cf_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_cf_allnum_max_rct_12tme_grp_size
    , case when als_lst_nbank_inteday_max_rct_12tme_grp_id=1 then als_lst_nbank_inteday_max_rct_12tme_grp_size_org-1 else als_lst_nbank_inteday_max_rct_12tme_grp_size_org end as als_lst_nbank_inteday_max_rct_12tme_grp_size
    , case when als_m1_coon_orgnum_max_rct_12tme_grp_id=1 then als_m1_coon_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_coon_orgnum_max_rct_12tme_grp_size_org end as als_m1_coon_orgnum_max_rct_12tme_grp_size
    , case when als_m1_coon_allnum_max_rct_12tme_grp_id=1 then als_m1_coon_allnum_max_rct_12tme_grp_size_org-1 else als_m1_coon_allnum_max_rct_12tme_grp_size_org end as als_m1_coon_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_size
    , case when als_d15_caon_orgnum_max_rct_12tme_grp_id=1 then als_d15_caon_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_caon_orgnum_max_rct_12tme_grp_size_org end as als_d15_caon_orgnum_max_rct_12tme_grp_size
    , case when als_d15_caon_allnum_max_rct_12tme_grp_id=1 then als_d15_caon_allnum_max_rct_12tme_grp_size_org-1 else als_d15_caon_allnum_max_rct_12tme_grp_size_org end as als_d15_caon_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_week_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_week_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_week_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_week_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_week_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_week_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_week_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_week_allnum_max_rct_12tme_grp_size
    , case when als_d15_pdl_orgnum_max_rct_12tme_grp_id=1 then als_d15_pdl_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_pdl_orgnum_max_rct_12tme_grp_size_org end as als_d15_pdl_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_cons_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_cons_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_cons_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_cons_orgnum_max_rct_12tme_grp_size
    , case when als_d15_pdl_allnum_max_rct_12tme_grp_id=1 then als_d15_pdl_allnum_max_rct_12tme_grp_size_org-1 else als_d15_pdl_allnum_max_rct_12tme_grp_size_org end as als_d15_pdl_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_cons_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_cons_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_cons_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_cons_allnum_max_rct_12tme_grp_size
    , case when als_d7_nbank_orgnum_max_rct_12tme_grp_id=1 then als_d7_nbank_orgnum_max_rct_12tme_grp_size_org-1 else als_d7_nbank_orgnum_max_rct_12tme_grp_size_org end as als_d7_nbank_orgnum_max_rct_12tme_grp_size
    , case when als_d7_nbank_allnum_max_rct_12tme_grp_id=1 then als_d7_nbank_allnum_max_rct_12tme_grp_size_org-1 else als_d7_nbank_allnum_max_rct_12tme_grp_size_org end as als_d7_nbank_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_night_allnum_max_rct_12tme_grp_id=1 then als_m1_nbank_night_allnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_night_allnum_max_rct_12tme_grp_size_org end as als_m1_nbank_night_allnum_max_rct_12tme_grp_size
    , case when als_m1_nbank_night_orgnum_max_rct_12tme_grp_id=1 then als_m1_nbank_night_orgnum_max_rct_12tme_grp_size_org-1 else als_m1_nbank_night_orgnum_max_rct_12tme_grp_size_org end as als_m1_nbank_night_orgnum_max_rct_12tme_grp_size
    , case when als_d7_nbank_else_allnum_max_rct_12tme_grp_id=1 then als_d7_nbank_else_allnum_max_rct_12tme_grp_size_org-1 else als_d7_nbank_else_allnum_max_rct_12tme_grp_size_org end as als_d7_nbank_else_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_size
    , case when als_d7_nbank_else_orgnum_max_rct_12tme_grp_id=1 then als_d7_nbank_else_orgnum_max_rct_12tme_grp_size_org-1 else als_d7_nbank_else_orgnum_max_rct_12tme_grp_size_org end as als_d7_nbank_else_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_night_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_night_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_night_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_night_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_night_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_night_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_night_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_night_orgnum_max_rct_12tme_grp_size
    , case when als_d7_nbank_oth_orgnum_max_rct_12tme_grp_id=1 then als_d7_nbank_oth_orgnum_max_rct_12tme_grp_size_org-1 else als_d7_nbank_oth_orgnum_max_rct_12tme_grp_size_org end as als_d7_nbank_oth_orgnum_max_rct_12tme_grp_size
    , case when als_d7_nbank_oth_allnum_max_rct_12tme_grp_id=1 then als_d7_nbank_oth_allnum_max_rct_12tme_grp_size_org-1 else als_d7_nbank_oth_allnum_max_rct_12tme_grp_size_org end as als_d7_nbank_oth_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_cf_orgnum_max_rct_12tme_grp_id=1 then als_d15_nbank_cf_orgnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_cf_orgnum_max_rct_12tme_grp_size_org end as als_d15_nbank_cf_orgnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_cf_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_cf_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_cf_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_cf_allnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_selfnum_max_rct_12tme_grp_id=1 then als_d15_nbank_selfnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_selfnum_max_rct_12tme_grp_size_org end as als_d15_nbank_selfnum_max_rct_12tme_grp_size
    , case when als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_id=1 then als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_size_org-1 else als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_size_org end as als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_size
    , case when als_d15_coon_allnum_max_rct_12tme_grp_id=1 then als_d15_coon_allnum_max_rct_12tme_grp_size_org-1 else als_d15_coon_allnum_max_rct_12tme_grp_size_org end as als_d15_coon_allnum_max_rct_12tme_grp_size
    from(
        SELECT *
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_else_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_else_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_allnum_max_rct_12tme_grp_id) as als_m1_nbank_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_oth_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_oth_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_else_allnum_max_rct_12tme_grp_id) as als_m1_nbank_else_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_oth_allnum_max_rct_12tme_grp_id) as als_m1_nbank_oth_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_caon_orgnum_max_rct_12tme_grp_id) as als_m1_caon_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_allnum_max_rct_12tme_grp_id) as als_d15_nbank_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_caon_allnum_max_rct_12tme_grp_id) as als_m1_caon_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_pdl_orgnum_max_rct_12tme_grp_id) as als_m1_pdl_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_cons_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_cons_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_else_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_else_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_cons_allnum_max_rct_12tme_grp_id) as als_m1_nbank_cons_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_else_allnum_max_rct_12tme_grp_id) as als_d15_nbank_else_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_pdl_allnum_max_rct_12tme_grp_id) as als_m1_pdl_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_oth_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_oth_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_oth_allnum_max_rct_12tme_grp_id) as als_d15_nbank_oth_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_week_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_week_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_cf_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_cf_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_week_allnum_max_rct_12tme_grp_id) as als_m1_nbank_week_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_cf_allnum_max_rct_12tme_grp_id) as als_m1_nbank_cf_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_lst_nbank_inteday_max_rct_12tme_grp_id) as als_lst_nbank_inteday_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_coon_orgnum_max_rct_12tme_grp_id) as als_m1_coon_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_coon_allnum_max_rct_12tme_grp_id) as als_m1_coon_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_id) as als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_caon_orgnum_max_rct_12tme_grp_id) as als_d15_caon_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_caon_allnum_max_rct_12tme_grp_id) as als_d15_caon_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_week_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_week_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_week_allnum_max_rct_12tme_grp_id) as als_d15_nbank_week_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_pdl_orgnum_max_rct_12tme_grp_id) as als_d15_pdl_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_cons_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_cons_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_pdl_allnum_max_rct_12tme_grp_id) as als_d15_pdl_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_cons_allnum_max_rct_12tme_grp_id) as als_d15_nbank_cons_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d7_nbank_orgnum_max_rct_12tme_grp_id) as als_d7_nbank_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d7_nbank_allnum_max_rct_12tme_grp_id) as als_d7_nbank_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_night_allnum_max_rct_12tme_grp_id) as als_m1_nbank_night_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_m1_nbank_night_orgnum_max_rct_12tme_grp_id) as als_m1_nbank_night_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d7_nbank_else_allnum_max_rct_12tme_grp_id) as als_d7_nbank_else_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d7_nbank_else_orgnum_max_rct_12tme_grp_id) as als_d7_nbank_else_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_night_allnum_max_rct_12tme_grp_id) as als_d15_nbank_night_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_night_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_night_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d7_nbank_oth_orgnum_max_rct_12tme_grp_id) as als_d7_nbank_oth_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d7_nbank_oth_allnum_max_rct_12tme_grp_id) as als_d7_nbank_oth_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_cf_orgnum_max_rct_12tme_grp_id) as als_d15_nbank_cf_orgnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_cf_allnum_max_rct_12tme_grp_id) as als_d15_nbank_cf_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_selfnum_max_rct_12tme_grp_id) as als_d15_nbank_selfnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_id) as als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_size_org
            , COUNT(*) OVER (PARTITION BY uid, als_d15_coon_allnum_max_rct_12tme_grp_id) as als_d15_coon_allnum_max_rct_12tme_grp_size_org
            from pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_id
    where als_m1_nbank_orgnum_max_rct_12tme_diff_trd_lag != -999
)a

;



drop table if exists pdm_risk.dz_br_max_multi_report_feature_rct_12tme_seq;
CREATE table pdm_risk.dz_br_max_multi_report_feature_rct_12tme_seq as
SELECT uid, rct_12tme_cnt
-- inc_seq_cnt
, max(case when als_m1_nbank_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_else_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_oth_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_else_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_else_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_else_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_oth_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_caon_orgnum_max_rct_12tme_diff_trd>0 then als_m1_caon_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_caon_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_caon_allnum_max_rct_12tme_diff_trd>0 then als_m1_caon_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_caon_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_pdl_orgnum_max_rct_12tme_diff_trd>0 then als_m1_pdl_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_pdl_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_cons_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cons_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_else_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_cons_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cons_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_else_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_else_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_else_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_pdl_allnum_max_rct_12tme_diff_trd>0 then als_m1_pdl_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_pdl_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_oth_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_oth_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_week_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_week_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_cf_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cf_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_week_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_week_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_week_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_cf_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cf_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_lst_nbank_inteday_max_rct_12tme_diff_trd>0 then als_lst_nbank_inteday_max_rct_12tme_grp_size else 0 end) as als_lst_nbank_inteday_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_coon_orgnum_max_rct_12tme_diff_trd>0 then als_m1_coon_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_coon_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_coon_allnum_max_rct_12tme_diff_trd>0 then als_m1_coon_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_coon_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_nsloan_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_caon_orgnum_max_rct_12tme_diff_trd>0 then als_d15_caon_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_caon_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_caon_allnum_max_rct_12tme_diff_trd>0 then als_d15_caon_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_caon_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_week_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_week_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_week_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_week_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_week_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_pdl_orgnum_max_rct_12tme_diff_trd>0 then als_d15_pdl_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_pdl_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_cons_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cons_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_pdl_allnum_max_rct_12tme_diff_trd>0 then als_d15_pdl_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_pdl_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_cons_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cons_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d7_nbank_orgnum_max_rct_12tme_diff_trd>0 then als_d7_nbank_orgnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d7_nbank_allnum_max_rct_12tme_diff_trd>0 then als_d7_nbank_allnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_night_allnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_night_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_night_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd>0 then als_m1_nbank_night_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_night_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d7_nbank_else_allnum_max_rct_12tme_diff_trd>0 then als_d7_nbank_else_allnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_else_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd>0 then als_d7_nbank_else_orgnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_night_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_night_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_night_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_night_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_night_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd>0 then als_d7_nbank_oth_orgnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd>0 then als_d7_nbank_oth_allnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_cf_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cf_orgnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_cf_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cf_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_selfnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_selfnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_selfnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd>0 then als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_nsloan_allnum_max_rct_12tme_inc_seq_cnt
, max(case when als_d15_coon_allnum_max_rct_12tme_diff_trd>0 then als_d15_coon_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_coon_allnum_max_rct_12tme_inc_seq_cnt
-- dec_seq_cnt
, max(case when als_m1_nbank_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_else_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_oth_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_else_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_else_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_else_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_oth_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_caon_orgnum_max_rct_12tme_diff_trd<0 then als_m1_caon_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_caon_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_caon_allnum_max_rct_12tme_diff_trd<0 then als_m1_caon_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_caon_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_pdl_orgnum_max_rct_12tme_diff_trd<0 then als_m1_pdl_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_pdl_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_cons_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cons_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_else_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_cons_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cons_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_else_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_else_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_else_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_nsloan_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_pdl_allnum_max_rct_12tme_diff_trd<0 then als_m1_pdl_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_pdl_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_oth_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_oth_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_week_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_week_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_cf_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cf_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_week_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_week_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_week_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_cf_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_cf_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_lst_nbank_inteday_max_rct_12tme_diff_trd<0 then als_lst_nbank_inteday_max_rct_12tme_grp_size else 0 end) as als_lst_nbank_inteday_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_coon_orgnum_max_rct_12tme_diff_trd<0 then als_m1_coon_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_coon_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_coon_allnum_max_rct_12tme_diff_trd<0 then als_m1_coon_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_coon_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_nsloan_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_nsloan_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_caon_orgnum_max_rct_12tme_diff_trd<0 then als_d15_caon_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_caon_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_caon_allnum_max_rct_12tme_diff_trd<0 then als_d15_caon_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_caon_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_week_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_week_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_week_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_week_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_week_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_pdl_orgnum_max_rct_12tme_diff_trd<0 then als_d15_pdl_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_pdl_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_cons_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cons_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_pdl_allnum_max_rct_12tme_diff_trd<0 then als_d15_pdl_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_pdl_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_cons_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cons_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d7_nbank_orgnum_max_rct_12tme_diff_trd<0 then als_d7_nbank_orgnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d7_nbank_allnum_max_rct_12tme_diff_trd<0 then als_d7_nbank_allnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_night_allnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_night_allnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_night_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd<0 then als_m1_nbank_night_orgnum_max_rct_12tme_grp_size else 0 end) as als_m1_nbank_night_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d7_nbank_else_allnum_max_rct_12tme_diff_trd<0 then als_d7_nbank_else_allnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_else_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_nsloan_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd<0 then als_d7_nbank_else_orgnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_night_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_night_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_night_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_night_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_night_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd<0 then als_d7_nbank_oth_orgnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd<0 then als_d7_nbank_oth_allnum_max_rct_12tme_grp_size else 0 end) as als_d7_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_cf_orgnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cf_orgnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_cf_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_cf_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_selfnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_selfnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_selfnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd<0 then als_d15_nbank_nsloan_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_nbank_nsloan_allnum_max_rct_12tme_dec_seq_cnt
, max(case when als_d15_coon_allnum_max_rct_12tme_diff_trd<0 then als_d15_coon_allnum_max_rct_12tme_grp_size else 0 end) as als_d15_coon_allnum_max_rct_12tme_dec_seq_cnt
-- inc_rto
, sum(case when als_m1_nbank_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_else_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_oth_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_else_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_else_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_oth_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_caon_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_caon_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_caon_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_caon_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_pdl_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_pdl_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cons_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_else_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cons_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_else_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_else_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_pdl_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_pdl_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_oth_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_oth_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_week_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cf_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_week_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_week_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cf_allnum_max_rct_12tme_inc_rto
, sum(case when als_lst_nbank_inteday_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_lst_nbank_inteday_max_rct_12tme_inc_rto
, sum(case when als_m1_coon_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_coon_orgnum_max_rct_12tme_inc_rto
, sum(case when als_m1_coon_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_coon_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_nsloan_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_caon_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_caon_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_caon_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_caon_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_week_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_week_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_week_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_pdl_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_pdl_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cons_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_pdl_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_pdl_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cons_allnum_max_rct_12tme_inc_rto
, sum(case when als_d7_nbank_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d7_nbank_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_night_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_night_allnum_max_rct_12tme_inc_rto
, sum(case when als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_night_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d7_nbank_else_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_else_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_else_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_night_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_night_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_night_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_oth_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_oth_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cf_orgnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cf_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_selfnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_selfnum_max_rct_12tme_inc_rto
, sum(case when als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_nsloan_allnum_max_rct_12tme_inc_rto
, sum(case when als_d15_coon_allnum_max_rct_12tme_diff_trd>0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_coon_allnum_max_rct_12tme_inc_rto
-- dec_rto
, sum(case when als_m1_nbank_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_else_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_else_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_oth_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_oth_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_else_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_else_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_oth_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_oth_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_caon_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_caon_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_caon_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_caon_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_pdl_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_pdl_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_cons_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cons_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_else_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_else_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_cons_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cons_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_else_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_else_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_nsloan_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_nsloan_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_pdl_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_pdl_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_oth_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_oth_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_oth_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_oth_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_week_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_week_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_cf_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cf_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_week_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_week_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_cf_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_cf_allnum_max_rct_12tme_dec_rto
, sum(case when als_lst_nbank_inteday_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_lst_nbank_inteday_max_rct_12tme_dec_rto
, sum(case when als_m1_coon_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_coon_orgnum_max_rct_12tme_dec_rto
, sum(case when als_m1_coon_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_coon_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_nsloan_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_nsloan_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_caon_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_caon_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_caon_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_caon_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_week_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_week_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_week_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_week_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_pdl_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_pdl_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_cons_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cons_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_pdl_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_pdl_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_cons_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cons_allnum_max_rct_12tme_dec_rto
, sum(case when als_d7_nbank_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d7_nbank_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_night_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_night_allnum_max_rct_12tme_dec_rto
, sum(case when als_m1_nbank_night_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_m1_nbank_night_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d7_nbank_else_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_else_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_nsloan_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_nsloan_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d7_nbank_else_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_else_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_night_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_night_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_night_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_night_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d7_nbank_oth_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_oth_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d7_nbank_oth_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d7_nbank_oth_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_cf_orgnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cf_orgnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_cf_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_cf_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_selfnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_selfnum_max_rct_12tme_dec_rto
, sum(case when als_d15_nbank_nsloan_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_nbank_nsloan_allnum_max_rct_12tme_dec_rto
, sum(case when als_d15_coon_allnum_max_rct_12tme_diff_trd<0 then 1 else 0 end)/max(rct_12tme_cnt-1) as als_d15_coon_allnum_max_rct_12tme_dec_rto
from pdm_risk.dz_br_max_multi_report_feature_rct_12tme_grp_size
group by uid, rct_12tme_cnt

;


insert overwrite table pdm_risk.pdm_risk_dz_br_max_multi_report_feature_rct_12tme_sequential_final_di partition(ds='${bizdate}')
SELECT a.uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at
, als_m1_nbank_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_else_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_caon_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_caon_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_pdl_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_cons_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_cons_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_else_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_pdl_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_week_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_cf_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_week_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_cf_allnum_max_rct_12tme_inc_seq_cnt
, als_lst_nbank_inteday_max_rct_12tme_inc_seq_cnt
, als_m1_coon_orgnum_max_rct_12tme_inc_seq_cnt
, als_m1_coon_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_nsloan_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_caon_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_caon_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_week_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_week_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_pdl_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_cons_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_pdl_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_cons_allnum_max_rct_12tme_inc_seq_cnt
, als_d7_nbank_orgnum_max_rct_12tme_inc_seq_cnt
, als_d7_nbank_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_night_allnum_max_rct_12tme_inc_seq_cnt
, als_m1_nbank_night_orgnum_max_rct_12tme_inc_seq_cnt
, als_d7_nbank_else_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_inc_seq_cnt
, als_d7_nbank_else_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_night_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_night_orgnum_max_rct_12tme_inc_seq_cnt
, als_d7_nbank_oth_orgnum_max_rct_12tme_inc_seq_cnt
, als_d7_nbank_oth_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_cf_orgnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_cf_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_selfnum_max_rct_12tme_inc_seq_cnt
, als_d15_nbank_nsloan_allnum_max_rct_12tme_inc_seq_cnt
, als_d15_coon_allnum_max_rct_12tme_inc_seq_cnt

, als_m1_nbank_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_else_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_caon_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_caon_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_pdl_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_cons_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_cons_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_else_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_pdl_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_week_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_cf_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_week_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_cf_allnum_max_rct_12tme_dec_seq_cnt
, als_lst_nbank_inteday_max_rct_12tme_dec_seq_cnt
, als_m1_coon_orgnum_max_rct_12tme_dec_seq_cnt
, als_m1_coon_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_nsloan_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_caon_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_caon_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_week_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_week_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_pdl_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_cons_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_pdl_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_cons_allnum_max_rct_12tme_dec_seq_cnt
, als_d7_nbank_orgnum_max_rct_12tme_dec_seq_cnt
, als_d7_nbank_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_night_allnum_max_rct_12tme_dec_seq_cnt
, als_m1_nbank_night_orgnum_max_rct_12tme_dec_seq_cnt
, als_d7_nbank_else_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_dec_seq_cnt
, als_d7_nbank_else_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_night_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_night_orgnum_max_rct_12tme_dec_seq_cnt
, als_d7_nbank_oth_orgnum_max_rct_12tme_dec_seq_cnt
, als_d7_nbank_oth_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_cf_orgnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_cf_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_selfnum_max_rct_12tme_dec_seq_cnt
, als_d15_nbank_nsloan_allnum_max_rct_12tme_dec_seq_cnt
, als_d15_coon_allnum_max_rct_12tme_dec_seq_cnt

, als_m1_nbank_orgnum_max_rct_12tme_inc_rto
, als_m1_nbank_else_orgnum_max_rct_12tme_inc_rto
, als_m1_nbank_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_oth_orgnum_max_rct_12tme_inc_rto
, als_m1_nbank_else_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_oth_allnum_max_rct_12tme_inc_rto
, als_m1_caon_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_allnum_max_rct_12tme_inc_rto
, als_m1_caon_allnum_max_rct_12tme_inc_rto
, als_m1_pdl_orgnum_max_rct_12tme_inc_rto
, als_m1_nbank_cons_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_else_orgnum_max_rct_12tme_inc_rto
, als_m1_nbank_cons_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_else_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_inc_rto
, als_m1_pdl_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_oth_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_oth_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_week_orgnum_max_rct_12tme_inc_rto
, als_m1_nbank_cf_orgnum_max_rct_12tme_inc_rto
, als_m1_nbank_week_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_cf_allnum_max_rct_12tme_inc_rto
, als_lst_nbank_inteday_max_rct_12tme_inc_rto
, als_m1_coon_orgnum_max_rct_12tme_inc_rto
, als_m1_coon_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_nsloan_allnum_max_rct_12tme_inc_rto
, als_d15_caon_orgnum_max_rct_12tme_inc_rto
, als_d15_caon_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_week_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_week_allnum_max_rct_12tme_inc_rto
, als_d15_pdl_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_cons_orgnum_max_rct_12tme_inc_rto
, als_d15_pdl_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_cons_allnum_max_rct_12tme_inc_rto
, als_d7_nbank_orgnum_max_rct_12tme_inc_rto
, als_d7_nbank_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_night_allnum_max_rct_12tme_inc_rto
, als_m1_nbank_night_orgnum_max_rct_12tme_inc_rto
, als_d7_nbank_else_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_inc_rto
, als_d7_nbank_else_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_night_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_night_orgnum_max_rct_12tme_inc_rto
, als_d7_nbank_oth_orgnum_max_rct_12tme_inc_rto
, als_d7_nbank_oth_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_cf_orgnum_max_rct_12tme_inc_rto
, als_d15_nbank_cf_allnum_max_rct_12tme_inc_rto
, als_d15_nbank_selfnum_max_rct_12tme_inc_rto
, als_d15_nbank_nsloan_allnum_max_rct_12tme_inc_rto
, als_d15_coon_allnum_max_rct_12tme_inc_rto

, als_m1_nbank_orgnum_max_rct_12tme_dec_rto
, als_m1_nbank_else_orgnum_max_rct_12tme_dec_rto
, als_m1_nbank_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_oth_orgnum_max_rct_12tme_dec_rto
, als_m1_nbank_else_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_oth_allnum_max_rct_12tme_dec_rto
, als_m1_caon_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_allnum_max_rct_12tme_dec_rto
, als_m1_caon_allnum_max_rct_12tme_dec_rto
, als_m1_pdl_orgnum_max_rct_12tme_dec_rto
, als_m1_nbank_cons_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_else_orgnum_max_rct_12tme_dec_rto
, als_m1_nbank_cons_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_else_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_nsloan_orgnum_max_rct_12tme_dec_rto
, als_m1_pdl_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_oth_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_oth_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_week_orgnum_max_rct_12tme_dec_rto
, als_m1_nbank_cf_orgnum_max_rct_12tme_dec_rto
, als_m1_nbank_week_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_cf_allnum_max_rct_12tme_dec_rto
, als_lst_nbank_inteday_max_rct_12tme_dec_rto
, als_m1_coon_orgnum_max_rct_12tme_dec_rto
, als_m1_coon_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_nsloan_allnum_max_rct_12tme_dec_rto
, als_d15_caon_orgnum_max_rct_12tme_dec_rto
, als_d15_caon_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_week_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_week_allnum_max_rct_12tme_dec_rto
, als_d15_pdl_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_cons_orgnum_max_rct_12tme_dec_rto
, als_d15_pdl_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_cons_allnum_max_rct_12tme_dec_rto
, als_d7_nbank_orgnum_max_rct_12tme_dec_rto
, als_d7_nbank_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_night_allnum_max_rct_12tme_dec_rto
, als_m1_nbank_night_orgnum_max_rct_12tme_dec_rto
, als_d7_nbank_else_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_nsloan_orgnum_max_rct_12tme_dec_rto
, als_d7_nbank_else_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_night_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_night_orgnum_max_rct_12tme_dec_rto
, als_d7_nbank_oth_orgnum_max_rct_12tme_dec_rto
, als_d7_nbank_oth_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_cf_orgnum_max_rct_12tme_dec_rto
, als_d15_nbank_cf_allnum_max_rct_12tme_dec_rto
, als_d15_nbank_selfnum_max_rct_12tme_dec_rto
, als_d15_nbank_nsloan_allnum_max_rct_12tme_dec_rto
, als_d15_coon_allnum_max_rct_12tme_dec_rto

from(
    SELECT uid, data_id, code, flag_applyloanstr, swift_number, created_at, updated_at
    from pdm_risk.pdm_risk_dz_br_max_multi_report_feature_mid_table_final_di
    where ds = '${bizdate}'
    and last_rn = 1
)a
-- left join pdm_risk.dz_br_max_multi_report_feature_rct_12mon_seq b
-- on a.uid = b.uid
left join pdm_risk.dz_br_max_multi_report_feature_rct_12tme_seq c
on a.uid = c.uid
-- left join pdm_risk.dz_br_max_multi_report_feature_rct_12mon_lst_seq d
-- on a.uid = d.uid
-- feature-copilot:node-end ordinal=0
