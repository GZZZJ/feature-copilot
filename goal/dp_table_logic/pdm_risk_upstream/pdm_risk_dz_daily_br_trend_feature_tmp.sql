-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_daily_br_trend_feature_tmp
-- node_id: n_3771986170808762368
-- task_name: pdm_risk_dz_daily_br_trend_feature
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dz_daily_br_trend_feature_tmp.json
-- source_json_sha256: 1514134796d9dfe634d3a674bb4522e984604f7df555d34ee8c19d534e3c974c
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_trend_feature_tmp
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_cast_float_feature

--MaxCompute_SQL
--********************************************************************--
--所属主题: 贷中模型变量通用调度
--功能描述: 百融多头变量通用逻辑, 趋势变量, 每日查询样本更新, 贷前贷中两张表union
--创建者: 周志华
--创建日期: 2022-06-22 17:56:01
--修改日期	修改人	修改内容
--20220622	周志华	初始化
--********************************************************************--

-- create table ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature
-- (
--     uid string comment '用户ID',

--     als_d7_d15_id_pdl_allnum_rte float comment "按身份证号查询，近7天_15天申请线上小额现金贷的次数的比例",
--     als_d15_m1_id_pdl_allnum_rte float comment "按身份证号查询，近15天_1个月申请线上小额现金贷的次数的比例",
--     als_m1_m3_id_pdl_allnum_rte float comment "按身份证号查询，近1个月_3个月申请线上小额现金贷的次数的比例",
--     als_m3_m12_id_pdl_allnum_rte float comment "按身份证号查询，近3个月_12个月申请线上小额现金贷的次数的比例",
--     als_m6_m12_id_pdl_allnum_rte float comment "按身份证号查询，近6个月_12个月申请线上小额现金贷的次数的比例",
--     als_d7_d15_id_pdl_orgnum_rte float comment "按身份证号查询，近7天_15天申请线上小额现金贷的机构数的比例",
--     als_d15_m1_id_pdl_orgnum_rte float comment "按身份证号查询，近15天_1个月申请线上小额现金贷的机构数的比例",
--     als_m1_m3_id_pdl_orgnum_rte float comment "按身份证号查询，近1个月_3个月申请线上小额现金贷的机构数的比例",
--     als_m3_m12_id_pdl_orgnum_rte float comment "按身份证号查询，近3个月_12个月申请线上小额现金贷的机构数的比例",
--     als_m6_m12_id_pdl_orgnum_rte float comment "按身份证号查询，近6个月_12个月申请线上小额现金贷的机构数的比例",
--     als_d7_d15_id_caon_allnum_rte float comment "按身份证号查询，近7天_15天申请线上现金分期的次数的比例",
--     als_d15_m1_id_caon_allnum_rte float comment "按身份证号查询，近15天_1个月申请线上现金分期的次数的比例",
--     als_m1_m3_id_caon_allnum_rte float comment "按身份证号查询，近1个月_3个月申请线上现金分期的次数的比例",
--     als_m3_m12_id_caon_allnum_rte float comment "按身份证号查询，近3个月_12个月申请线上现金分期的次数的比例",
--     als_m6_m12_id_caon_allnum_rte float comment "按身份证号查询，近6个月_12个月申请线上现金分期的次数的比例",
--     als_d7_d15_id_rel_allnum_rte float comment "按身份证号查询，近7天_15天申请信用卡（类信用卡）的次数的比例",
--     als_d15_m1_id_rel_allnum_rte float comment "按身份证号查询，近15天_1个月申请信用卡（类信用卡）的次数的比例",
--     als_m1_m3_id_rel_allnum_rte float comment "按身份证号查询，近1个月_3个月申请信用卡（类信用卡）的次数的比例",
--     als_m3_m12_id_rel_allnum_rte float comment "按身份证号查询，近3个月_12个月申请信用卡（类信用卡）的次数的比例",
--     als_m6_m12_id_rel_allnum_rte float comment "按身份证号查询，近6个月_12个月申请信用卡（类信用卡）的次数的比例",
--     als_d7_d15_id_cooff_allnum_rte float comment "按身份证号查询，近7天_15天申请线下消费分期的次数的比例",
--     als_d15_m1_id_cooff_allnum_rte float comment "按身份证号查询，近15天_1个月申请线下消费分期的次数的比例",
--     als_m1_m3_id_cooff_allnum_rte float comment "按身份证号查询，近1个月_3个月申请线下消费分期的次数的比例",
--     als_m3_m12_id_cooff_allnum_rte float comment "按身份证号查询，近3个月_12个月申请线下消费分期的次数的比例",
--     als_m6_m12_id_cooff_allnum_rte float comment "按身份证号查询，近6个月_12个月申请线下消费分期的次数的比例",
--     als_d7_d15_id_coon_allnum_rte float comment "按身份证号查询，近7天_15天申请线上消费分期的次数的比例",
--     als_d15_m1_id_coon_allnum_rte float comment "按身份证号查询，近15天_1个月申请线上消费分期的次数的比例",
--     als_m1_m3_id_coon_allnum_rte float comment "按身份证号查询，近1个月_3个月申请线上消费分期的次数的比例",
--     als_m3_m12_id_coon_allnum_rte float comment "按身份证号查询，近3个月_12个月申请线上消费分期的次数的比例",
--     als_m6_m12_id_coon_allnum_rte float comment "按身份证号查询，近6个月_12个月申请线上消费分期的次数的比例",
--     als_d7_d15_id_oth_allnum_rte float comment "按身份证号查询，近7天_15天申请其他的次数的比例",
--     als_d15_m1_id_oth_allnum_rte float comment "按身份证号查询，近15天_1个月申请其他的次数的比例",
--     als_m1_m3_id_oth_allnum_rte float comment "按身份证号查询，近1个月_3个月申请其他的次数的比例",
--     als_m3_m12_id_oth_allnum_rte float comment "按身份证号查询，近3个月_12个月申请其他的次数的比例",
--     als_m6_m12_id_oth_allnum_rte float comment "按身份证号查询，近6个月_12个月申请其他的次数的比例",
--     als_d7_d15_id_oth_orgnum_rte float comment "按身份证号查询，近7天_15天申请其他的机构数的比例",
--     als_d15_m1_id_oth_orgnum_rte float comment "按身份证号查询，近15天_1个月申请其他的机构数的比例",
--     als_m1_m3_id_oth_orgnum_rte float comment "按身份证号查询，近1个月_3个月申请其他的机构数的比例",
--     als_m3_m12_id_oth_orgnum_rte float comment "按身份证号查询，近3个月_12个月申请其他的机构数的比例",
--     als_m6_m12_id_oth_orgnum_rte float comment "按身份证号查询，近6个月_12个月申请其他的机构数的比例",
--     als_d7_d15_id_bank_selfnum_rte float comment "按身份证号查询，近7天_15天在本机构(本机构为银行)的申请次数的比例",
--     als_d15_m1_id_bank_selfnum_rte float comment "按身份证号查询，近15天_1个月在本机构(本机构为银行)的申请次数的比例",
--     als_m1_m3_id_bank_selfnum_rte float comment "按身份证号查询，近1个月_3个月在本机构(本机构为银行)的申请次数的比例",
--     als_m3_m12_id_bank_selfnum_rte float comment "按身份证号查询，近3个月_12个月在本机构(本机构为银行)的申请次数的比例",
--     als_m6_m12_id_bank_selfnum_rte float comment "按身份证号查询，近6个月_12个月在本机构(本机构为银行)的申请次数的比例",
--     als_d7_d15_id_bank_allnum_rte float comment "按身份证号查询，近7天_15天在银行机构申请次数的比例",
--     als_d15_m1_id_bank_allnum_rte float comment "按身份证号查询，近15天_1个月在银行机构申请次数的比例",
--     als_m1_m3_id_bank_allnum_rte float comment "按身份证号查询，近1个月_3个月在银行机构申请次数的比例",
--     als_m3_m12_id_bank_allnum_rte float comment "按身份证号查询，近3个月_12个月在银行机构申请次数的比例",
--     als_m6_m12_id_bank_allnum_rte float comment "按身份证号查询，近6个月_12个月在银行机构申请次数的比例",
--     als_d7_d15_id_bank_tra_allnum_rte float comment "按身份证号查询，近7天_15天在银行机构-传统银行申请次数的比例",
--     als_d15_m1_id_bank_tra_allnum_rte float comment "按身份证号查询，近15天_1个月在银行机构-传统银行申请次数的比例",
--     als_m1_m3_id_bank_tra_allnum_rte float comment "按身份证号查询，近1个月_3个月在银行机构-传统银行申请次数的比例",
--     als_m3_m12_id_bank_tra_allnum_rte float comment "按身份证号查询，近3个月_12个月在银行机构-传统银行申请次数的比例",
--     als_m6_m12_id_bank_tra_allnum_rte float comment "按身份证号查询，近6个月_12个月在银行机构-传统银行申请次数的比例",
--     als_d7_d15_id_bank_orgnum_rte float comment "按身份证号查询，近7天_15天在银行机构申请机构数的比例",
--     als_d15_m1_id_bank_orgnum_rte float comment "按身份证号查询，近15天_1个月在银行机构申请机构数的比例",
--     als_m1_m3_id_bank_orgnum_rte float comment "按身份证号查询，近1个月_3个月在银行机构申请机构数的比例",
--     als_m3_m12_id_bank_orgnum_rte float comment "按身份证号查询，近3个月_12个月在银行机构申请机构数的比例",
--     als_m6_m12_id_bank_orgnum_rte float comment "按身份证号查询，近6个月_12个月在银行机构申请机构数的比例",
--     als_d7_d15_id_bank_tra_orgnum_rte float comment "按身份证号查询，近7天_15天在银行机构-传统银行申请机构数的比例",
--     als_d15_m1_id_bank_tra_orgnum_rte float comment "按身份证号查询，近15天_1个月在银行机构-传统银行申请机构数的比例",
--     als_m1_m3_id_bank_tra_orgnum_rte float comment "按身份证号查询，近1个月_3个月在银行机构-传统银行申请机构数的比例",
--     als_m3_m12_id_bank_tra_orgnum_rte float comment "按身份证号查询，近3个月_12个月在银行机构-传统银行申请机构数的比例",
--     als_m6_m12_id_bank_tra_orgnum_rte float comment "按身份证号查询，近6个月_12个月在银行机构-传统银行申请机构数的比例",
--     als_d7_d15_id_nbank_selfnum_rte float comment "按身份证号查询，近7天_15天在本机构(本机构为非银)申请次数的比例",
--     als_d15_m1_id_nbank_selfnum_rte float comment "按身份证号查询，近15天_1个月在本机构(本机构为非银)申请次数的比例",
--     als_m1_m3_id_nbank_selfnum_rte float comment "按身份证号查询，近1个月_3个月在本机构(本机构为非银)申请次数的比例",
--     als_m3_m12_id_nbank_selfnum_rte float comment "按身份证号查询，近3个月_12个月在本机构(本机构为非银)申请次数的比例",
--     als_m6_m12_id_nbank_selfnum_rte float comment "按身份证号查询，近6个月_12个月在本机构(本机构为非银)申请次数的比例",
--     als_d7_d15_id_nbank_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构申请次数的比例",
--     als_d15_m1_id_nbank_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构申请次数的比例",
--     als_m1_m3_id_nbank_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构申请次数的比例",
--     als_m3_m12_id_nbank_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构申请次数的比例",
--     als_m6_m12_id_nbank_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构申请次数的比例",
--     als_d7_d15_id_nbank_mc_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-小贷机构申请次数的比例",
--     als_d15_m1_id_nbank_mc_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-小贷机构申请次数的比例",
--     als_m1_m3_id_nbank_mc_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-小贷机构申请次数的比例",
--     als_m3_m12_id_nbank_mc_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-小贷机构申请次数的比例",
--     als_m6_m12_id_nbank_mc_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-小贷机构申请次数的比例",
--     als_d7_d15_id_nbank_ca_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-现金类分期机构申请次数的比例",
--     als_d15_m1_id_nbank_ca_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-现金类分期机构申请次数的比例",
--     als_m1_m3_id_nbank_ca_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-现金类分期机构申请次数的比例",
--     als_m3_m12_id_nbank_ca_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-现金类分期机构申请次数的比例",
--     als_m6_m12_id_nbank_ca_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-现金类分期机构申请次数的比例",
--     als_d7_d15_id_nbank_cf_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-消费类分期机构申请次数的比例",
--     als_d15_m1_id_nbank_cf_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-消费类分期机构申请次数的比例",
--     als_m1_m3_id_nbank_cf_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-消费类分期机构申请次数的比例",
--     als_m3_m12_id_nbank_cf_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-消费类分期机构申请次数的比例",
--     als_m6_m12_id_nbank_cf_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-消费类分期机构申请次数的比例",
--     als_d7_d15_id_nbank_oth_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-其他申请次数的比例",
--     als_d15_m1_id_nbank_oth_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-其他申请次数的比例",
--     als_m1_m3_id_nbank_oth_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-其他申请次数的比例",
--     als_m3_m12_id_nbank_oth_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-其他申请次数的比例",
--     als_m6_m12_id_nbank_oth_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-其他申请次数的比例",
--     als_d7_d15_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-持牌网络小贷机构申请次数的比例",
--     als_d15_m1_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_m1_m3_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_m3_m12_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_m6_m12_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_d7_d15_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-持牌小贷机构申请次数的比例",
--     als_d15_m1_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-持牌小贷机构申请次数的比例",
--     als_m1_m3_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-持牌小贷机构申请次数的比例",
--     als_m3_m12_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-持牌小贷机构申请次数的比例",
--     als_m6_m12_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-持牌小贷机构申请次数的比例",
--     als_d7_d15_id_nbank_cons_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-持牌消费金融机构申请次数的比例",
--     als_d15_m1_id_nbank_cons_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_m1_m3_id_nbank_cons_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_m3_m12_id_nbank_cons_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_m6_m12_id_nbank_cons_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_d7_d15_id_nbank_else_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构-其他申请次数的比例",
--     als_d15_m1_id_nbank_else_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-其他申请次数的比例",
--     als_m1_m3_id_nbank_else_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-其他申请次数的比例",
--     als_m3_m12_id_nbank_else_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-其他申请次数的比例",
--     als_m6_m12_id_nbank_else_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-其他申请次数的比例",
--     als_d7_d15_id_nbank_orgnum_rte float comment "按身份证号查询，近7天_15天在非银机构申请机构数的比例",
--     als_d15_m1_id_nbank_orgnum_rte float comment "按身份证号查询，近15天_1个月在非银机构申请机构数的比例",
--     als_m1_m3_id_nbank_orgnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构申请机构数的比例",
--     als_m3_m12_id_nbank_orgnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构申请机构数的比例",
--     als_m6_m12_id_nbank_orgnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构申请机构数的比例",
--     als_d7_d15_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近7天_15天在非银机构-小贷申请机构数的比例",
--     als_d15_m1_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-小贷申请机构数的比例",
--     als_m1_m3_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-小贷申请机构数的比例",
--     als_m3_m12_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-小贷申请机构数的比例",
--     als_m6_m12_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-小贷申请机构数的比例",
--     als_d7_d15_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近7天_15天在非银机构-其他申请机构数的比例",
--     als_d15_m1_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-其他申请机构数的比例",
--     als_m1_m3_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-其他申请机构数的比例",
--     als_m3_m12_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-其他申请机构数的比例",
--     als_m6_m12_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-其他申请机构数的比例",
--     als_d7_d15_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近7天_15天在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_d15_m1_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_m1_m3_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_m3_m12_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_m6_m12_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_d7_d15_id_nbank_else_orgnum_rte float comment "按身份证号查询，近7天_15天在非银机构-其他申请机构数的比例",
--     als_d15_m1_id_nbank_else_orgnum_rte float comment "按身份证号查询，近15天_1个月在非银机构-其他申请机构数的比例",
--     als_m1_m3_id_nbank_else_orgnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构-其他申请机构数的比例",
--     als_m3_m12_id_nbank_else_orgnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构-其他申请机构数的比例",
--     als_m6_m12_id_nbank_else_orgnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构-其他申请机构数的比例",
--     als_d7_d15_id_nbank_week_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构周末申请次数的比例",
--     als_d15_m1_id_nbank_week_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构周末申请次数的比例",
--     als_m1_m3_id_nbank_week_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构周末申请次数的比例",
--     als_m3_m12_id_nbank_week_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构周末申请次数的比例",
--     als_m6_m12_id_nbank_week_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构周末申请次数的比例",
--     als_d7_d15_id_nbank_week_orgnum_rte float comment "按身份证号查询，近7天_15天在非银机构周末申请机构数的比例",
--     als_d15_m1_id_nbank_week_orgnum_rte float comment "按身份证号查询，近15天_1个月在非银机构周末申请机构数的比例",
--     als_m1_m3_id_nbank_week_orgnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构周末申请机构数的比例",
--     als_m3_m12_id_nbank_week_orgnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构周末申请机构数的比例",
--     als_m6_m12_id_nbank_week_orgnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构周末申请机构数的比例",
--     als_d7_d15_id_nbank_night_allnum_rte float comment "按身份证号查询，近7天_15天在非银机构夜间申请次数的比例",
--     als_d15_m1_id_nbank_night_allnum_rte float comment "按身份证号查询，近15天_1个月在非银机构夜间申请次数的比例",
--     als_m1_m3_id_nbank_night_allnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构夜间申请次数的比例",
--     als_m3_m12_id_nbank_night_allnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构夜间申请次数的比例",
--     als_m6_m12_id_nbank_night_allnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构夜间申请次数的比例",
--     als_d7_d15_id_nbank_night_orgnum_rte float comment "按身份证号查询，近7天_15天在非银机构夜间申请机构数的比例",
--     als_d15_m1_id_nbank_night_orgnum_rte float comment "按身份证号查询，近15天_1个月在非银机构夜间申请机构数的比例",
--     als_m1_m3_id_nbank_night_orgnum_rte float comment "按身份证号查询，近1个月_3个月在非银机构夜间申请机构数的比例",
--     als_m3_m12_id_nbank_night_orgnum_rte float comment "按身份证号查询，近3个月_12个月在非银机构夜间申请机构数的比例",
--     als_m6_m12_id_nbank_night_orgnum_rte float comment "按身份证号查询，近6个月_12个月在非银机构夜间申请机构数的比例",
--     als_d7_d7_d15_id_pdl_allnum_rte float comment "按身份证号查询，近7天_第7_15天申请线上小额现金贷的次数的比例",
--     als_d15_d15_m1_id_pdl_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请线上小额现金贷的次数的比例",
--     als_m1_m1_m3_id_pdl_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请线上小额现金贷的次数的比例",
--     als_m3_m6_m12_id_pdl_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请线上小额现金贷的次数的比例",
--     als_m6_m6_m12_id_pdl_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请线上小额现金贷的次数的比例",
--     als_d7_d7_d15_id_pdl_orgnum_rte float comment "按身份证号查询，近7天_第7_15天申请线上小额现金贷的机构数的比例",
--     als_d15_d15_m1_id_pdl_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请线上小额现金贷的机构数的比例",
--     als_m1_m1_m3_id_pdl_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请线上小额现金贷的机构数的比例",
--     als_m3_m6_m12_id_pdl_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请线上小额现金贷的机构数的比例",
--     als_m6_m6_m12_id_pdl_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请线上小额现金贷的机构数的比例",
--     als_d7_d7_d15_id_caon_allnum_rte float comment "按身份证号查询，近7天_第7_15天申请线上现金分期的次数的比例",
--     als_d15_d15_m1_id_caon_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请线上现金分期的次数的比例",
--     als_m1_m1_m3_id_caon_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请线上现金分期的次数的比例",
--     als_m3_m6_m12_id_caon_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请线上现金分期的次数的比例",
--     als_m6_m6_m12_id_caon_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请线上现金分期的次数的比例",
--     als_d7_d7_d15_id_rel_allnum_rte float comment "按身份证号查询，近7天_第7_15天申请信用卡（类信用卡）的次数的比例",
--     als_d15_d15_m1_id_rel_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请信用卡（类信用卡）的次数的比例",
--     als_m1_m1_m3_id_rel_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请信用卡（类信用卡）的次数的比例",
--     als_m3_m6_m12_id_rel_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请信用卡（类信用卡）的次数的比例",
--     als_m6_m6_m12_id_rel_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请信用卡（类信用卡）的次数的比例",
--     als_d7_d7_d15_id_cooff_allnum_rte float comment "按身份证号查询，近7天_第7_15天申请线下消费分期的次数的比例",
--     als_d15_d15_m1_id_cooff_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请线下消费分期的次数的比例",
--     als_m1_m1_m3_id_cooff_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请线下消费分期的次数的比例",
--     als_m3_m6_m12_id_cooff_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请线下消费分期的次数的比例",
--     als_m6_m6_m12_id_cooff_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请线下消费分期的次数的比例",
--     als_d7_d7_d15_id_coon_allnum_rte float comment "按身份证号查询，近7天_第7_15天申请线上消费分期的次数的比例",
--     als_d15_d15_m1_id_coon_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请线上消费分期的次数的比例",
--     als_m1_m1_m3_id_coon_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请线上消费分期的次数的比例",
--     als_m3_m6_m12_id_coon_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请线上消费分期的次数的比例",
--     als_m6_m6_m12_id_coon_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请线上消费分期的次数的比例",
--     als_d7_d7_d15_id_oth_allnum_rte float comment "按身份证号查询，近7天_第7_15天申请其他的次数的比例",
--     als_d15_d15_m1_id_oth_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请其他的次数的比例",
--     als_m1_m1_m3_id_oth_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请其他的次数的比例",
--     als_m3_m6_m12_id_oth_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请其他的次数的比例",
--     als_m6_m6_m12_id_oth_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请其他的次数的比例",
--     als_d7_d7_d15_id_oth_orgnum_rte float comment "按身份证号查询，近7天_第7_15天申请其他的机构数的比例",
--     als_d15_d15_m1_id_oth_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月申请其他的机构数的比例",
--     als_m1_m1_m3_id_oth_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月申请其他的机构数的比例",
--     als_m3_m6_m12_id_oth_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月申请其他的机构数的比例",
--     als_m6_m6_m12_id_oth_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月申请其他的机构数的比例",
--     als_d7_d7_d15_id_bank_selfnum_rte float comment "按身份证号查询，近7天_第7_15天在本机构(本机构为银行)的申请次数的比例",
--     als_d15_d15_m1_id_bank_selfnum_rte float comment "按身份证号查询，近15天_第15天_1个月在本机构(本机构为银行)的申请次数的比例",
--     als_m1_m1_m3_id_bank_selfnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在本机构(本机构为银行)的申请次数的比例",
--     als_m3_m6_m12_id_bank_selfnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在本机构(本机构为银行)的申请次数的比例",
--     als_m6_m6_m12_id_bank_selfnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在本机构(本机构为银行)的申请次数的比例",
--     als_d7_d7_d15_id_bank_allnum_rte float comment "按身份证号查询，近7天_第7_15天在银行机构申请次数的比例",
--     als_d15_d15_m1_id_bank_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在银行机构申请次数的比例",
--     als_m1_m1_m3_id_bank_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在银行机构申请次数的比例",
--     als_m3_m6_m12_id_bank_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在银行机构申请次数的比例",
--     als_m6_m6_m12_id_bank_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在银行机构申请次数的比例",
--     als_d7_d7_d15_id_bank_tra_allnum_rte float comment "按身份证号查询，近7天_第7_15天在银行机构-传统银行申请次数的比例",
--     als_d15_d15_m1_id_bank_tra_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在银行机构-传统银行申请次数的比例",
--     als_m1_m1_m3_id_bank_tra_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在银行机构-传统银行申请次数的比例",
--     als_m3_m6_m12_id_bank_tra_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在银行机构-传统银行申请次数的比例",
--     als_m6_m6_m12_id_bank_tra_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在银行机构-传统银行申请次数的比例",
--     als_d7_d7_d15_id_bank_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在银行机构申请机构数的比例",
--     als_d15_d15_m1_id_bank_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在银行机构申请机构数的比例",
--     als_m1_m1_m3_id_bank_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在银行机构申请机构数的比例",
--     als_m3_m6_m12_id_bank_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在银行机构申请机构数的比例",
--     als_m6_m6_m12_id_bank_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在银行机构申请机构数的比例",
--     als_d7_d7_d15_id_bank_tra_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在银行机构-传统银行申请机构数的比例",
--     als_d15_d15_m1_id_bank_tra_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在银行机构-传统银行申请机构数的比例",
--     als_m1_m1_m3_id_bank_tra_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在银行机构-传统银行申请机构数的比例",
--     als_m3_m6_m12_id_bank_tra_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在银行机构-传统银行申请机构数的比例",
--     als_m6_m6_m12_id_bank_tra_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在银行机构-传统银行申请机构数的比例",
--     als_d7_d7_d15_id_nbank_selfnum_rte float comment "按身份证号查询，近7天_第7_15天在本机构(本机构为非银)申请次数的比例",
--     als_d15_d15_m1_id_nbank_selfnum_rte float comment "按身份证号查询，近15天_第15天_1个月在本机构(本机构为非银)申请次数的比例",
--     als_m1_m1_m3_id_nbank_selfnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在本机构(本机构为非银)申请次数的比例",
--     als_m3_m6_m12_id_nbank_selfnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在本机构(本机构为非银)申请次数的比例",
--     als_m6_m6_m12_id_nbank_selfnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在本机构(本机构为非银)申请次数的比例",
--     als_d7_d7_d15_id_nbank_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构申请次数的比例",
--     als_d15_d15_m1_id_nbank_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构申请次数的比例",
--     als_m1_m1_m3_id_nbank_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构申请次数的比例",
--     als_m3_m6_m12_id_nbank_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构申请次数的比例",
--     als_m6_m6_m12_id_nbank_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构申请次数的比例",
--     als_d7_d7_d15_id_nbank_mc_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-小贷机构申请次数的比例",
--     als_d15_d15_m1_id_nbank_mc_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-小贷机构申请次数的比例",
--     als_m1_m1_m3_id_nbank_mc_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-小贷机构申请次数的比例",
--     als_m3_m6_m12_id_nbank_mc_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-小贷机构申请次数的比例",
--     als_m6_m6_m12_id_nbank_mc_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-小贷机构申请次数的比例",
--     als_d7_d7_d15_id_nbank_ca_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-现金类分期机构申请次数的比例",
--     als_d15_d15_m1_id_nbank_ca_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-现金类分期机构申请次数的比例",
--     als_m1_m1_m3_id_nbank_ca_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-现金类分期机构申请次数的比例",
--     als_m3_m6_m12_id_nbank_ca_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-现金类分期机构申请次数的比例",
--     als_m6_m6_m12_id_nbank_ca_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-现金类分期机构申请次数的比例",
--     als_d7_d7_d15_id_nbank_cf_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-消费类分期机构申请次数的比例",
--     als_d15_d15_m1_id_nbank_cf_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-消费类分期机构申请次数的比例",
--     als_m1_m1_m3_id_nbank_cf_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-消费类分期机构申请次数的比例",
--     als_m3_m6_m12_id_nbank_cf_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-消费类分期机构申请次数的比例",
--     als_m6_m6_m12_id_nbank_cf_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-消费类分期机构申请次数的比例",
--     als_d7_d7_d15_id_nbank_oth_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-其他申请次数的比例",
--     als_d15_d15_m1_id_nbank_oth_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-其他申请次数的比例",
--     als_m1_m1_m3_id_nbank_oth_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-其他申请次数的比例",
--     als_m3_m6_m12_id_nbank_oth_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-其他申请次数的比例",
--     als_m6_m6_m12_id_nbank_oth_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-其他申请次数的比例",
--     als_d7_d7_d15_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-持牌网络小贷机构申请次数的比例",
--     als_d15_d15_m1_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_m1_m1_m3_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_m3_m6_m12_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_m6_m6_m12_id_nbank_nsloan_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-持牌网络小贷机构申请次数的比例",
--     als_d7_d7_d15_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-持牌小贷机构申请次数的比例",
--     als_d15_d15_m1_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-持牌小贷机构申请次数的比例",
--     als_m1_m1_m3_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-持牌小贷机构申请次数的比例",
--     als_m3_m6_m12_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-持牌小贷机构申请次数的比例",
--     als_m6_m6_m12_id_nbank_sloan_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-持牌小贷机构申请次数的比例",
--     als_d7_d7_d15_id_nbank_cons_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-持牌消费金融机构申请次数的比例",
--     als_d15_d15_m1_id_nbank_cons_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_m1_m1_m3_id_nbank_cons_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_m3_m6_m12_id_nbank_cons_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_m6_m6_m12_id_nbank_cons_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-持牌消费金融机构申请次数的比例",
--     als_d7_d7_d15_id_nbank_else_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-其他申请次数的比例",
--     als_d15_d15_m1_id_nbank_else_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-其他申请次数的比例",
--     als_m1_m1_m3_id_nbank_else_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-其他申请次数的比例",
--     als_m3_m6_m12_id_nbank_else_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-其他申请次数的比例",
--     als_m6_m6_m12_id_nbank_else_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-其他申请次数的比例",
--     als_d7_d7_d15_id_nbank_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构申请机构数的比例",
--     als_d15_d15_m1_id_nbank_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构申请机构数的比例",
--     als_m1_m1_m3_id_nbank_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构申请机构数的比例",
--     als_m3_m6_m12_id_nbank_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构申请机构数的比例",
--     als_m6_m6_m12_id_nbank_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构申请机构数的比例",
--     als_d7_d7_d15_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-小贷申请机构数的比例",
--     als_d15_d15_m1_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-小贷申请机构数的比例",
--     als_m1_m1_m3_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-小贷申请机构数的比例",
--     als_m3_m6_m12_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-小贷申请机构数的比例",
--     als_m6_m6_m12_id_nbank_mc_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-小贷申请机构数的比例",
--     als_d7_d7_d15_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-其他申请机构数的比例",
--     als_d15_d15_m1_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-其他申请机构数的比例",
--     als_m1_m1_m3_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-其他申请机构数的比例",
--     als_m3_m6_m12_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-其他申请机构数的比例",
--     als_m6_m6_m12_id_nbank_oth_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-其他申请机构数的比例",
--     als_d7_d7_d15_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_d15_d15_m1_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_m1_m1_m3_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_m3_m6_m12_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_m6_m6_m12_id_nbank_nsloan_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-持牌网络小贷机构申请机构数的比例",
--     als_d7_d7_d15_id_nbank_else_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构-其他申请机构数的比例",
--     als_d15_d15_m1_id_nbank_else_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构-其他申请机构数的比例",
--     als_m1_m1_m3_id_nbank_else_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构-其他申请机构数的比例",
--     als_m3_m6_m12_id_nbank_else_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构-其他申请机构数的比例",
--     als_m6_m6_m12_id_nbank_else_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构-其他申请机构数的比例",
--     als_d7_d7_d15_id_nbank_week_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构周末申请次数的比例",
--     als_d15_d15_m1_id_nbank_week_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构周末申请次数的比例",
--     als_m1_m1_m3_id_nbank_week_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构周末申请次数的比例",
--     als_m3_m6_m12_id_nbank_week_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构周末申请次数的比例",
--     als_m6_m6_m12_id_nbank_week_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构周末申请次数的比例",
--     als_d7_d7_d15_id_nbank_week_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构周末申请机构数的比例",
--     als_d15_d15_m1_id_nbank_week_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构周末申请机构数的比例",
--     als_m1_m1_m3_id_nbank_week_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构周末申请机构数的比例",
--     als_m3_m6_m12_id_nbank_week_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构周末申请机构数的比例",
--     als_m6_m6_m12_id_nbank_week_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构周末申请机构数的比例",
--     als_d7_d7_d15_id_nbank_night_allnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构夜间申请次数的比例",
--     als_d15_d15_m1_id_nbank_night_allnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构夜间申请次数的比例",
--     als_m1_m1_m3_id_nbank_night_allnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构夜间申请次数的比例",
--     als_m3_m6_m12_id_nbank_night_allnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构夜间申请次数的比例",
--     als_m6_m6_m12_id_nbank_night_allnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构夜间申请次数的比例",
--     als_d7_d7_d15_id_nbank_night_orgnum_rte float comment "按身份证号查询，近7天_第7_15天在非银机构夜间申请机构数的比例",
--     als_d15_d15_m1_id_nbank_night_orgnum_rte float comment "按身份证号查询，近15天_第15天_1个月在非银机构夜间申请机构数的比例",
--     als_m1_m1_m3_id_nbank_night_orgnum_rte float comment "按身份证号查询，近1个月_第1个月_3个月在非银机构夜间申请机构数的比例",
--     als_m3_m6_m12_id_nbank_night_orgnum_rte float comment "按身份证号查询，近3个月_第6个月_12个月在非银机构夜间申请机构数的比例",
--     als_m6_m6_m12_id_nbank_night_orgnum_rte float comment "按身份证号查询，近6个月_第6个月_12个月在非银机构夜间申请机构数的比例",

--     data_id string comment '数据ID',
--     code string comment '响应码',
--     flag_applyloanstr string comment '借贷意向验证产品输出标识',
--     swift_number string comment '操作流水号',
--     created_at timestamp comment '创建时间',
--     updated_at timestamp comment '更新时间',
--     rcd_tim timestamp comment '数据更新时间'
-- ) comment '百融多头变量通用逻辑, 趋势变量, 每日查询样本更新, 贷前贷中两张表union'
-- partitioned by (ds string);


drop table if exists ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_tmp;
create table ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_tmp as 
select uid
    ,als_m1_id_coon_allnum
    ,als_m3_id_nbank_nsloan_allnum
    ,als_m1_id_nbank_cf_allnum
    ,als_m6_id_bank_allnum
    ,als_m1_id_bank_tra_allnum
    ,als_m12_id_nbank_cf_allnum
    ,als_m6_id_nbank_mc_allnum
    ,als_d15_id_bank_selfnum
    ,als_m6_id_nbank_selfnum
    ,als_m12_id_nbank_night_allnum
    ,als_d7_id_nbank_else_allnum
    ,als_m6_id_nbank_night_orgnum
    ,als_m3_id_nbank_else_allnum
    ,als_d7_id_pdl_orgnum
    ,als_m6_id_bank_tra_allnum
    ,als_m6_id_bank_tra_orgnum
    ,als_m3_id_nbank_sloan_allnum
    ,als_m1_id_oth_allnum
    ,als_m6_id_nbank_else_allnum
    ,als_m12_id_nbank_else_allnum
    ,als_m12_id_nbank_mc_allnum
    ,als_m6_id_cooff_allnum
    ,als_m6_id_nbank_week_allnum
    ,als_m3_id_oth_allnum
    ,als_m6_id_oth_orgnum
    ,als_m3_id_nbank_ca_allnum
    ,als_m12_id_oth_allnum
    ,als_m12_id_coon_allnum
    ,als_m3_id_bank_tra_allnum
    ,als_d15_id_pdl_orgnum
    ,als_d7_id_nbank_else_orgnum
    ,als_d7_id_nbank_week_allnum
    ,als_m1_id_nbank_selfnum
    ,als_d15_id_nbank_night_allnum
    ,als_m3_id_rel_allnum
    ,als_m1_id_nbank_else_orgnum
    ,als_m6_id_coon_allnum
    ,als_d15_id_oth_orgnum
    ,als_m3_id_cooff_allnum
    ,als_m1_id_rel_allnum
    ,als_m3_id_nbank_oth_allnum
    ,als_m12_id_nbank_oth_orgnum
    ,als_m6_id_nbank_sloan_allnum
    ,als_m6_id_nbank_mc_orgnum
    ,als_m6_id_nbank_oth_orgnum
    ,als_m1_id_nbank_allnum
    ,als_d7_id_nbank_nsloan_allnum
    ,als_d7_id_nbank_cf_allnum
    ,als_m3_id_nbank_week_orgnum
    ,als_m6_id_caon_allnum
    ,als_d15_id_coon_allnum
    ,als_m12_id_pdl_allnum
    ,als_d15_id_caon_allnum
    ,als_d15_id_oth_allnum
    ,als_d15_id_nbank_oth_orgnum
    ,als_m6_id_nbank_week_orgnum
    ,als_m1_id_nbank_oth_orgnum
    ,als_d7_id_nbank_nsloan_orgnum
    ,als_d7_id_nbank_ca_allnum
    ,als_d7_id_bank_orgnum
    ,als_d15_id_nbank_mc_orgnum
    ,als_m6_id_bank_orgnum
    ,als_d15_id_pdl_allnum
    ,als_m12_id_rel_allnum
    ,als_d15_id_cooff_allnum
    ,als_m3_id_nbank_cf_allnum
    ,als_m1_id_nbank_mc_allnum
    ,als_m3_id_oth_orgnum
    ,als_m3_id_nbank_night_allnum
    ,als_d7_id_nbank_mc_allnum
    ,als_m3_id_pdl_allnum
    ,als_d15_id_nbank_cf_allnum
    ,als_m12_id_bank_selfnum
    ,als_m6_id_nbank_cons_allnum
    ,als_m3_id_bank_tra_orgnum
    ,als_d15_id_nbank_mc_allnum
    ,als_m3_id_nbank_mc_orgnum
    ,als_m3_id_nbank_oth_orgnum
    ,als_m3_id_coon_allnum
    ,als_m1_id_bank_allnum
    ,als_m12_id_cooff_allnum
    ,als_m6_id_pdl_orgnum
    ,als_d7_id_nbank_oth_orgnum
    ,als_m12_id_nbank_oth_allnum
    ,als_d15_id_bank_tra_allnum
    ,als_m3_id_bank_orgnum
    ,als_m6_id_nbank_orgnum
    ,als_m6_id_nbank_allnum
    ,als_m1_id_bank_tra_orgnum
    ,als_m3_id_nbank_week_allnum
    ,als_d15_id_nbank_allnum
    ,als_d7_id_nbank_cons_allnum
    ,als_m3_id_nbank_orgnum
    ,als_m1_id_nbank_week_orgnum
    ,als_m3_id_caon_allnum
    ,als_m12_id_nbank_orgnum
    ,als_m12_id_nbank_allnum
    ,als_m12_id_nbank_nsloan_orgnum
    ,als_m3_id_nbank_night_orgnum
    ,als_m6_id_nbank_nsloan_orgnum
    ,als_m1_id_nbank_else_allnum
    ,als_d15_id_nbank_night_orgnum
    ,als_d7_id_nbank_oth_allnum
    ,als_d15_id_bank_tra_orgnum
    ,als_m3_id_nbank_allnum
    ,als_m1_id_nbank_oth_allnum
    ,als_m12_id_bank_allnum
    ,als_m1_id_nbank_orgnum
    ,als_m1_id_nbank_night_orgnum
    ,als_m12_id_caon_allnum
    ,als_d15_id_nbank_ca_allnum
    ,als_m12_id_oth_orgnum
    ,als_d15_id_nbank_selfnum
    ,als_m3_id_nbank_mc_allnum
    ,als_d15_id_nbank_nsloan_allnum
    ,als_m6_id_rel_allnum
    ,als_m12_id_nbank_cons_allnum
    ,als_d15_id_nbank_week_allnum
    ,als_m1_id_nbank_ca_allnum
    ,als_m12_id_bank_orgnum
    ,als_m1_id_nbank_nsloan_allnum
    ,als_d7_id_nbank_orgnum
    ,als_d7_id_nbank_night_orgnum
    ,als_m3_id_pdl_orgnum
    ,als_d15_id_nbank_oth_allnum
    ,als_d7_id_pdl_allnum
    ,als_m1_id_bank_selfnum
    ,als_d7_id_bank_allnum
    ,als_m1_id_nbank_cons_allnum
    ,als_d15_id_nbank_orgnum
    ,als_d15_id_bank_allnum
    ,als_m1_id_nbank_night_allnum
    ,als_d7_id_oth_allnum
    ,als_d7_id_nbank_sloan_allnum
    ,als_m6_id_nbank_cf_allnum
    ,als_d7_id_caon_allnum
    ,als_m1_id_nbank_sloan_allnum
    ,als_m1_id_caon_allnum
    ,als_d15_id_rel_allnum
    ,als_d15_id_nbank_else_orgnum
    ,als_d15_id_nbank_sloan_allnum
    ,als_m3_id_nbank_cons_allnum
    ,als_d7_id_nbank_mc_orgnum
    ,als_m1_id_bank_orgnum
    ,als_m6_id_nbank_else_orgnum
    ,als_d7_id_nbank_night_allnum
    ,als_m6_id_nbank_night_allnum
    ,als_m3_id_bank_selfnum
    ,als_m12_id_nbank_nsloan_allnum
    ,als_d15_id_nbank_nsloan_orgnum
    ,als_d7_id_oth_orgnum
    ,als_d15_id_bank_orgnum
    ,als_m1_id_cooff_allnum
    ,als_m1_id_nbank_nsloan_orgnum
    ,als_m6_id_pdl_allnum
    ,als_m1_id_pdl_orgnum
    ,als_m12_id_bank_tra_allnum
    ,als_d7_id_bank_selfnum
    ,als_m6_id_nbank_ca_allnum
    ,als_m3_id_bank_allnum
    ,als_d7_id_cooff_allnum
    ,als_m1_id_nbank_mc_orgnum
    ,als_m12_id_nbank_week_allnum
    ,als_m1_id_oth_orgnum
    ,als_m6_id_nbank_oth_allnum
    ,als_m12_id_nbank_sloan_allnum
    ,als_d7_id_coon_allnum
    ,als_m12_id_nbank_mc_orgnum
    ,als_d15_id_nbank_week_orgnum
    ,als_m12_id_nbank_week_orgnum
    ,als_m6_id_oth_allnum
    ,als_d7_id_nbank_week_orgnum
    ,als_d7_id_nbank_allnum
    ,als_m6_id_bank_selfnum
    ,als_d15_id_nbank_cons_allnum
    ,als_d7_id_bank_tra_orgnum
    ,als_m12_id_nbank_else_orgnum
    ,als_m1_id_nbank_week_allnum
    ,als_m12_id_nbank_ca_allnum
    ,als_m6_id_nbank_nsloan_allnum
    ,als_d7_id_nbank_selfnum
    ,als_m12_id_nbank_selfnum
    ,als_d15_id_nbank_else_allnum
    ,als_m1_id_pdl_allnum
    ,als_d7_id_bank_tra_allnum
    ,als_m3_id_nbank_selfnum
    ,als_m3_id_nbank_nsloan_orgnum
    ,als_m3_id_nbank_else_orgnum
    ,als_m12_id_nbank_night_orgnum
    ,als_d7_id_rel_allnum
    ,als_m12_id_pdl_orgnum
    ,als_m12_id_bank_tra_orgnum

    ,als_d15_id_pdl_allnum - als_d7_id_pdl_allnum as als_d7_d15_id_pdl_allnum
    ,als_m1_id_pdl_allnum - als_d15_id_pdl_allnum as als_d15_m1_id_pdl_allnum
    ,als_m3_id_pdl_allnum - als_m1_id_pdl_allnum as als_m1_m3_id_pdl_allnum
    ,als_m6_id_pdl_allnum - als_m3_id_pdl_allnum as als_m3_m6_id_pdl_allnum
    ,als_m12_id_pdl_allnum - als_m6_id_pdl_allnum as als_m6_m12_id_pdl_allnum
    ,als_d15_id_pdl_orgnum - als_d7_id_pdl_orgnum as als_d7_d15_id_pdl_orgnum
    ,als_m1_id_pdl_orgnum - als_d15_id_pdl_orgnum as als_d15_m1_id_pdl_orgnum
    ,als_m3_id_pdl_orgnum - als_m1_id_pdl_orgnum as als_m1_m3_id_pdl_orgnum
    ,als_m6_id_pdl_orgnum - als_m3_id_pdl_orgnum as als_m3_m6_id_pdl_orgnum
    ,als_m12_id_pdl_orgnum - als_m6_id_pdl_orgnum as als_m6_m12_id_pdl_orgnum
    ,als_d15_id_caon_allnum - als_d7_id_caon_allnum as als_d7_d15_id_caon_allnum
    ,als_m1_id_caon_allnum - als_d15_id_caon_allnum as als_d15_m1_id_caon_allnum
    ,als_m3_id_caon_allnum - als_m1_id_caon_allnum as als_m1_m3_id_caon_allnum
    ,als_m6_id_caon_allnum - als_m3_id_caon_allnum as als_m3_m6_id_caon_allnum
    ,als_m12_id_caon_allnum - als_m6_id_caon_allnum as als_m6_m12_id_caon_allnum
    ,als_d15_id_rel_allnum - als_d7_id_rel_allnum as als_d7_d15_id_rel_allnum
    ,als_m1_id_rel_allnum - als_d15_id_rel_allnum as als_d15_m1_id_rel_allnum
    ,als_m3_id_rel_allnum - als_m1_id_rel_allnum as als_m1_m3_id_rel_allnum
    ,als_m6_id_rel_allnum - als_m3_id_rel_allnum as als_m3_m6_id_rel_allnum
    ,als_m12_id_rel_allnum - als_m6_id_rel_allnum as als_m6_m12_id_rel_allnum
    ,als_d15_id_cooff_allnum - als_d7_id_cooff_allnum as als_d7_d15_id_cooff_allnum
    ,als_m1_id_cooff_allnum - als_d15_id_cooff_allnum as als_d15_m1_id_cooff_allnum
    ,als_m3_id_cooff_allnum - als_m1_id_cooff_allnum as als_m1_m3_id_cooff_allnum
    ,als_m6_id_cooff_allnum - als_m3_id_cooff_allnum as als_m3_m6_id_cooff_allnum
    ,als_m12_id_cooff_allnum - als_m6_id_cooff_allnum as als_m6_m12_id_cooff_allnum
    ,als_d15_id_coon_allnum - als_d7_id_coon_allnum as als_d7_d15_id_coon_allnum
    ,als_m1_id_coon_allnum - als_d15_id_coon_allnum as als_d15_m1_id_coon_allnum
    ,als_m3_id_coon_allnum - als_m1_id_coon_allnum as als_m1_m3_id_coon_allnum
    ,als_m6_id_coon_allnum - als_m3_id_coon_allnum as als_m3_m6_id_coon_allnum
    ,als_m12_id_coon_allnum - als_m6_id_coon_allnum as als_m6_m12_id_coon_allnum
    ,als_d15_id_oth_allnum - als_d7_id_oth_allnum as als_d7_d15_id_oth_allnum
    ,als_m1_id_oth_allnum - als_d15_id_oth_allnum as als_d15_m1_id_oth_allnum
    ,als_m3_id_oth_allnum - als_m1_id_oth_allnum as als_m1_m3_id_oth_allnum
    ,als_m6_id_oth_allnum - als_m3_id_oth_allnum as als_m3_m6_id_oth_allnum
    ,als_m12_id_oth_allnum - als_m6_id_oth_allnum as als_m6_m12_id_oth_allnum
    ,als_d15_id_oth_orgnum - als_d7_id_oth_orgnum as als_d7_d15_id_oth_orgnum
    ,als_m1_id_oth_orgnum - als_d15_id_oth_orgnum as als_d15_m1_id_oth_orgnum
    ,als_m3_id_oth_orgnum - als_m1_id_oth_orgnum as als_m1_m3_id_oth_orgnum
    ,als_m6_id_oth_orgnum - als_m3_id_oth_orgnum as als_m3_m6_id_oth_orgnum
    ,als_m12_id_oth_orgnum - als_m6_id_oth_orgnum as als_m6_m12_id_oth_orgnum
    ,als_d15_id_bank_selfnum - als_d7_id_bank_selfnum as als_d7_d15_id_bank_selfnum
    ,als_m1_id_bank_selfnum - als_d15_id_bank_selfnum as als_d15_m1_id_bank_selfnum
    ,als_m3_id_bank_selfnum - als_m1_id_bank_selfnum as als_m1_m3_id_bank_selfnum
    ,als_m6_id_bank_selfnum - als_m3_id_bank_selfnum as als_m3_m6_id_bank_selfnum
    ,als_m12_id_bank_selfnum - als_m6_id_bank_selfnum as als_m6_m12_id_bank_selfnum
    ,als_d15_id_bank_allnum - als_d7_id_bank_allnum as als_d7_d15_id_bank_allnum
    ,als_m1_id_bank_allnum - als_d15_id_bank_allnum as als_d15_m1_id_bank_allnum
    ,als_m3_id_bank_allnum - als_m1_id_bank_allnum as als_m1_m3_id_bank_allnum
    ,als_m6_id_bank_allnum - als_m3_id_bank_allnum as als_m3_m6_id_bank_allnum
    ,als_m12_id_bank_allnum - als_m6_id_bank_allnum as als_m6_m12_id_bank_allnum
    ,als_d15_id_bank_tra_allnum - als_d7_id_bank_tra_allnum as als_d7_d15_id_bank_tra_allnum
    ,als_m1_id_bank_tra_allnum - als_d15_id_bank_tra_allnum as als_d15_m1_id_bank_tra_allnum
    ,als_m3_id_bank_tra_allnum - als_m1_id_bank_tra_allnum as als_m1_m3_id_bank_tra_allnum
    ,als_m6_id_bank_tra_allnum - als_m3_id_bank_tra_allnum as als_m3_m6_id_bank_tra_allnum
    ,als_m12_id_bank_tra_allnum - als_m6_id_bank_tra_allnum as als_m6_m12_id_bank_tra_allnum
    ,als_d15_id_bank_orgnum - als_d7_id_bank_orgnum as als_d7_d15_id_bank_orgnum
    ,als_m1_id_bank_orgnum - als_d15_id_bank_orgnum as als_d15_m1_id_bank_orgnum
    ,als_m3_id_bank_orgnum - als_m1_id_bank_orgnum as als_m1_m3_id_bank_orgnum
    ,als_m6_id_bank_orgnum - als_m3_id_bank_orgnum as als_m3_m6_id_bank_orgnum
    ,als_m12_id_bank_orgnum - als_m6_id_bank_orgnum as als_m6_m12_id_bank_orgnum
    ,als_d15_id_bank_tra_orgnum - als_d7_id_bank_tra_orgnum as als_d7_d15_id_bank_tra_orgnum
    ,als_m1_id_bank_tra_orgnum - als_d15_id_bank_tra_orgnum as als_d15_m1_id_bank_tra_orgnum
    ,als_m3_id_bank_tra_orgnum - als_m1_id_bank_tra_orgnum as als_m1_m3_id_bank_tra_orgnum
    ,als_m6_id_bank_tra_orgnum - als_m3_id_bank_tra_orgnum as als_m3_m6_id_bank_tra_orgnum
    ,als_m12_id_bank_tra_orgnum - als_m6_id_bank_tra_orgnum as als_m6_m12_id_bank_tra_orgnum
    ,als_d15_id_nbank_selfnum - als_d7_id_nbank_selfnum as als_d7_d15_id_nbank_selfnum
    ,als_m1_id_nbank_selfnum - als_d15_id_nbank_selfnum as als_d15_m1_id_nbank_selfnum
    ,als_m3_id_nbank_selfnum - als_m1_id_nbank_selfnum as als_m1_m3_id_nbank_selfnum
    ,als_m6_id_nbank_selfnum - als_m3_id_nbank_selfnum as als_m3_m6_id_nbank_selfnum
    ,als_m12_id_nbank_selfnum - als_m6_id_nbank_selfnum as als_m6_m12_id_nbank_selfnum
    ,als_d15_id_nbank_allnum - als_d7_id_nbank_allnum as als_d7_d15_id_nbank_allnum
    ,als_m1_id_nbank_allnum - als_d15_id_nbank_allnum as als_d15_m1_id_nbank_allnum
    ,als_m3_id_nbank_allnum - als_m1_id_nbank_allnum as als_m1_m3_id_nbank_allnum
    ,als_m6_id_nbank_allnum - als_m3_id_nbank_allnum as als_m3_m6_id_nbank_allnum
    ,als_m12_id_nbank_allnum - als_m6_id_nbank_allnum as als_m6_m12_id_nbank_allnum
    ,als_d15_id_nbank_mc_allnum - als_d7_id_nbank_mc_allnum as als_d7_d15_id_nbank_mc_allnum
    ,als_m1_id_nbank_mc_allnum - als_d15_id_nbank_mc_allnum as als_d15_m1_id_nbank_mc_allnum
    ,als_m3_id_nbank_mc_allnum - als_m1_id_nbank_mc_allnum as als_m1_m3_id_nbank_mc_allnum
    ,als_m6_id_nbank_mc_allnum - als_m3_id_nbank_mc_allnum as als_m3_m6_id_nbank_mc_allnum
    ,als_m12_id_nbank_mc_allnum - als_m6_id_nbank_mc_allnum as als_m6_m12_id_nbank_mc_allnum
    ,als_d15_id_nbank_ca_allnum - als_d7_id_nbank_ca_allnum as als_d7_d15_id_nbank_ca_allnum
    ,als_m1_id_nbank_ca_allnum - als_d15_id_nbank_ca_allnum as als_d15_m1_id_nbank_ca_allnum
    ,als_m3_id_nbank_ca_allnum - als_m1_id_nbank_ca_allnum as als_m1_m3_id_nbank_ca_allnum
    ,als_m6_id_nbank_ca_allnum - als_m3_id_nbank_ca_allnum as als_m3_m6_id_nbank_ca_allnum
    ,als_m12_id_nbank_ca_allnum - als_m6_id_nbank_ca_allnum as als_m6_m12_id_nbank_ca_allnum
    ,als_d15_id_nbank_cf_allnum - als_d7_id_nbank_cf_allnum as als_d7_d15_id_nbank_cf_allnum
    ,als_m1_id_nbank_cf_allnum - als_d15_id_nbank_cf_allnum as als_d15_m1_id_nbank_cf_allnum
    ,als_m3_id_nbank_cf_allnum - als_m1_id_nbank_cf_allnum as als_m1_m3_id_nbank_cf_allnum
    ,als_m6_id_nbank_cf_allnum - als_m3_id_nbank_cf_allnum as als_m3_m6_id_nbank_cf_allnum
    ,als_m12_id_nbank_cf_allnum - als_m6_id_nbank_cf_allnum as als_m6_m12_id_nbank_cf_allnum
    ,als_d15_id_nbank_oth_allnum - als_d7_id_nbank_oth_allnum as als_d7_d15_id_nbank_oth_allnum
    ,als_m1_id_nbank_oth_allnum - als_d15_id_nbank_oth_allnum as als_d15_m1_id_nbank_oth_allnum
    ,als_m3_id_nbank_oth_allnum - als_m1_id_nbank_oth_allnum as als_m1_m3_id_nbank_oth_allnum
    ,als_m6_id_nbank_oth_allnum - als_m3_id_nbank_oth_allnum as als_m3_m6_id_nbank_oth_allnum
    ,als_m12_id_nbank_oth_allnum - als_m6_id_nbank_oth_allnum as als_m6_m12_id_nbank_oth_allnum
    ,als_d15_id_nbank_nsloan_allnum - als_d7_id_nbank_nsloan_allnum as als_d7_d15_id_nbank_nsloan_allnum
    ,als_m1_id_nbank_nsloan_allnum - als_d15_id_nbank_nsloan_allnum as als_d15_m1_id_nbank_nsloan_allnum
    ,als_m3_id_nbank_nsloan_allnum - als_m1_id_nbank_nsloan_allnum as als_m1_m3_id_nbank_nsloan_allnum
    ,als_m6_id_nbank_nsloan_allnum - als_m3_id_nbank_nsloan_allnum as als_m3_m6_id_nbank_nsloan_allnum
    ,als_m12_id_nbank_nsloan_allnum - als_m6_id_nbank_nsloan_allnum as als_m6_m12_id_nbank_nsloan_allnum
    ,als_d15_id_nbank_sloan_allnum - als_d7_id_nbank_sloan_allnum as als_d7_d15_id_nbank_sloan_allnum
    ,als_m1_id_nbank_sloan_allnum - als_d15_id_nbank_sloan_allnum as als_d15_m1_id_nbank_sloan_allnum
    ,als_m3_id_nbank_sloan_allnum - als_m1_id_nbank_sloan_allnum as als_m1_m3_id_nbank_sloan_allnum
    ,als_m6_id_nbank_sloan_allnum - als_m3_id_nbank_sloan_allnum as als_m3_m6_id_nbank_sloan_allnum
    ,als_m12_id_nbank_sloan_allnum - als_m6_id_nbank_sloan_allnum as als_m6_m12_id_nbank_sloan_allnum
    ,als_d15_id_nbank_cons_allnum - als_d7_id_nbank_cons_allnum as als_d7_d15_id_nbank_cons_allnum
    ,als_m1_id_nbank_cons_allnum - als_d15_id_nbank_cons_allnum as als_d15_m1_id_nbank_cons_allnum
    ,als_m3_id_nbank_cons_allnum - als_m1_id_nbank_cons_allnum as als_m1_m3_id_nbank_cons_allnum
    ,als_m6_id_nbank_cons_allnum - als_m3_id_nbank_cons_allnum as als_m3_m6_id_nbank_cons_allnum
    ,als_m12_id_nbank_cons_allnum - als_m6_id_nbank_cons_allnum as als_m6_m12_id_nbank_cons_allnum
    ,als_d15_id_nbank_else_allnum - als_d7_id_nbank_else_allnum as als_d7_d15_id_nbank_else_allnum
    ,als_m1_id_nbank_else_allnum - als_d15_id_nbank_else_allnum as als_d15_m1_id_nbank_else_allnum
    ,als_m3_id_nbank_else_allnum - als_m1_id_nbank_else_allnum as als_m1_m3_id_nbank_else_allnum
    ,als_m6_id_nbank_else_allnum - als_m3_id_nbank_else_allnum as als_m3_m6_id_nbank_else_allnum
    ,als_m12_id_nbank_else_allnum - als_m6_id_nbank_else_allnum as als_m6_m12_id_nbank_else_allnum
    ,als_d15_id_nbank_orgnum - als_d7_id_nbank_orgnum as als_d7_d15_id_nbank_orgnum
    ,als_m1_id_nbank_orgnum - als_d15_id_nbank_orgnum as als_d15_m1_id_nbank_orgnum
    ,als_m3_id_nbank_orgnum - als_m1_id_nbank_orgnum as als_m1_m3_id_nbank_orgnum
    ,als_m6_id_nbank_orgnum - als_m3_id_nbank_orgnum as als_m3_m6_id_nbank_orgnum
    ,als_m12_id_nbank_orgnum - als_m6_id_nbank_orgnum as als_m6_m12_id_nbank_orgnum
    ,als_d15_id_nbank_mc_orgnum - als_d7_id_nbank_mc_orgnum as als_d7_d15_id_nbank_mc_orgnum
    ,als_m1_id_nbank_mc_orgnum - als_d15_id_nbank_mc_orgnum as als_d15_m1_id_nbank_mc_orgnum
    ,als_m3_id_nbank_mc_orgnum - als_m1_id_nbank_mc_orgnum as als_m1_m3_id_nbank_mc_orgnum
    ,als_m6_id_nbank_mc_orgnum - als_m3_id_nbank_mc_orgnum as als_m3_m6_id_nbank_mc_orgnum
    ,als_m12_id_nbank_mc_orgnum - als_m6_id_nbank_mc_orgnum as als_m6_m12_id_nbank_mc_orgnum
    ,als_d15_id_nbank_oth_orgnum - als_d7_id_nbank_oth_orgnum as als_d7_d15_id_nbank_oth_orgnum
    ,als_m1_id_nbank_oth_orgnum - als_d15_id_nbank_oth_orgnum as als_d15_m1_id_nbank_oth_orgnum
    ,als_m3_id_nbank_oth_orgnum - als_m1_id_nbank_oth_orgnum as als_m1_m3_id_nbank_oth_orgnum
    ,als_m6_id_nbank_oth_orgnum - als_m3_id_nbank_oth_orgnum as als_m3_m6_id_nbank_oth_orgnum
    ,als_m12_id_nbank_oth_orgnum - als_m6_id_nbank_oth_orgnum as als_m6_m12_id_nbank_oth_orgnum
    ,als_d15_id_nbank_nsloan_orgnum - als_d7_id_nbank_nsloan_orgnum as als_d7_d15_id_nbank_nsloan_orgnum
    ,als_m1_id_nbank_nsloan_orgnum - als_d15_id_nbank_nsloan_orgnum as als_d15_m1_id_nbank_nsloan_orgnum
    ,als_m3_id_nbank_nsloan_orgnum - als_m1_id_nbank_nsloan_orgnum as als_m1_m3_id_nbank_nsloan_orgnum
    ,als_m6_id_nbank_nsloan_orgnum - als_m3_id_nbank_nsloan_orgnum as als_m3_m6_id_nbank_nsloan_orgnum
    ,als_m12_id_nbank_nsloan_orgnum - als_m6_id_nbank_nsloan_orgnum as als_m6_m12_id_nbank_nsloan_orgnum
    ,als_d15_id_nbank_else_orgnum - als_d7_id_nbank_else_orgnum as als_d7_d15_id_nbank_else_orgnum
    ,als_m1_id_nbank_else_orgnum - als_d15_id_nbank_else_orgnum as als_d15_m1_id_nbank_else_orgnum
    ,als_m3_id_nbank_else_orgnum - als_m1_id_nbank_else_orgnum as als_m1_m3_id_nbank_else_orgnum
    ,als_m6_id_nbank_else_orgnum - als_m3_id_nbank_else_orgnum as als_m3_m6_id_nbank_else_orgnum
    ,als_m12_id_nbank_else_orgnum - als_m6_id_nbank_else_orgnum as als_m6_m12_id_nbank_else_orgnum
    ,als_d15_id_nbank_week_allnum - als_d7_id_nbank_week_allnum as als_d7_d15_id_nbank_week_allnum
    ,als_m1_id_nbank_week_allnum - als_d15_id_nbank_week_allnum as als_d15_m1_id_nbank_week_allnum
    ,als_m3_id_nbank_week_allnum - als_m1_id_nbank_week_allnum as als_m1_m3_id_nbank_week_allnum
    ,als_m6_id_nbank_week_allnum - als_m3_id_nbank_week_allnum as als_m3_m6_id_nbank_week_allnum
    ,als_m12_id_nbank_week_allnum - als_m6_id_nbank_week_allnum as als_m6_m12_id_nbank_week_allnum
    ,als_d15_id_nbank_week_orgnum - als_d7_id_nbank_week_orgnum as als_d7_d15_id_nbank_week_orgnum
    ,als_m1_id_nbank_week_orgnum - als_d15_id_nbank_week_orgnum as als_d15_m1_id_nbank_week_orgnum
    ,als_m3_id_nbank_week_orgnum - als_m1_id_nbank_week_orgnum as als_m1_m3_id_nbank_week_orgnum
    ,als_m6_id_nbank_week_orgnum - als_m3_id_nbank_week_orgnum as als_m3_m6_id_nbank_week_orgnum
    ,als_m12_id_nbank_week_orgnum - als_m6_id_nbank_week_orgnum as als_m6_m12_id_nbank_week_orgnum
    ,als_d15_id_nbank_night_allnum - als_d7_id_nbank_night_allnum as als_d7_d15_id_nbank_night_allnum
    ,als_m1_id_nbank_night_allnum - als_d15_id_nbank_night_allnum as als_d15_m1_id_nbank_night_allnum
    ,als_m3_id_nbank_night_allnum - als_m1_id_nbank_night_allnum as als_m1_m3_id_nbank_night_allnum
    ,als_m6_id_nbank_night_allnum - als_m3_id_nbank_night_allnum as als_m3_m6_id_nbank_night_allnum
    ,als_m12_id_nbank_night_allnum - als_m6_id_nbank_night_allnum as als_m6_m12_id_nbank_night_allnum
    ,als_d15_id_nbank_night_orgnum - als_d7_id_nbank_night_orgnum as als_d7_d15_id_nbank_night_orgnum
    ,als_m1_id_nbank_night_orgnum - als_d15_id_nbank_night_orgnum as als_d15_m1_id_nbank_night_orgnum
    ,als_m3_id_nbank_night_orgnum - als_m1_id_nbank_night_orgnum as als_m1_m3_id_nbank_night_orgnum
    ,als_m6_id_nbank_night_orgnum - als_m3_id_nbank_night_orgnum as als_m3_m6_id_nbank_night_orgnum
    ,als_m12_id_nbank_night_orgnum - als_m6_id_nbank_night_orgnum as als_m6_m12_id_nbank_night_orgnum

    ,data_id
    ,code
    ,flag_applyloanstr
    ,swift_number
    ,created_at
    ,updated_at
from 
(
    select uid
        ,case when als_d7_id_pdl_allnum is null then 0 else als_d7_id_pdl_allnum end as als_d7_id_pdl_allnum
        ,case when als_d15_id_pdl_allnum is null then 0 else als_d15_id_pdl_allnum end as als_d15_id_pdl_allnum
        ,case when als_m1_id_pdl_allnum is null then 0 else als_m1_id_pdl_allnum end as als_m1_id_pdl_allnum
        ,case when als_m3_id_pdl_allnum is null then 0 else als_m3_id_pdl_allnum end as als_m3_id_pdl_allnum
        ,case when als_m6_id_pdl_allnum is null then 0 else als_m6_id_pdl_allnum end as als_m6_id_pdl_allnum
        ,case when als_m12_id_pdl_allnum is null then 0 else als_m12_id_pdl_allnum end as als_m12_id_pdl_allnum
        ,case when als_d7_id_pdl_orgnum is null then 0 else als_d7_id_pdl_orgnum end as als_d7_id_pdl_orgnum
        ,case when als_d15_id_pdl_orgnum is null then 0 else als_d15_id_pdl_orgnum end as als_d15_id_pdl_orgnum
        ,case when als_m1_id_pdl_orgnum is null then 0 else als_m1_id_pdl_orgnum end as als_m1_id_pdl_orgnum
        ,case when als_m3_id_pdl_orgnum is null then 0 else als_m3_id_pdl_orgnum end as als_m3_id_pdl_orgnum
        ,case when als_m6_id_pdl_orgnum is null then 0 else als_m6_id_pdl_orgnum end as als_m6_id_pdl_orgnum
        ,case when als_m12_id_pdl_orgnum is null then 0 else als_m12_id_pdl_orgnum end as als_m12_id_pdl_orgnum
        ,case when als_d7_id_caon_allnum is null then 0 else als_d7_id_caon_allnum end as als_d7_id_caon_allnum
        ,case when als_d15_id_caon_allnum is null then 0 else als_d15_id_caon_allnum end as als_d15_id_caon_allnum
        ,case when als_m1_id_caon_allnum is null then 0 else als_m1_id_caon_allnum end as als_m1_id_caon_allnum
        ,case when als_m3_id_caon_allnum is null then 0 else als_m3_id_caon_allnum end as als_m3_id_caon_allnum
        ,case when als_m6_id_caon_allnum is null then 0 else als_m6_id_caon_allnum end as als_m6_id_caon_allnum
        ,case when als_m12_id_caon_allnum is null then 0 else als_m12_id_caon_allnum end as als_m12_id_caon_allnum
        ,case when als_d7_id_caon_orgnum is null then 0 else als_d7_id_caon_orgnum end as als_d7_id_caon_orgnum
        ,case when als_d15_id_caon_orgnum is null then 0 else als_d15_id_caon_orgnum end as als_d15_id_caon_orgnum
        ,case when als_m1_id_caon_orgnum is null then 0 else als_m1_id_caon_orgnum end as als_m1_id_caon_orgnum
        ,case when als_m3_id_caon_orgnum is null then 0 else als_m3_id_caon_orgnum end as als_m3_id_caon_orgnum
        ,case when als_m6_id_caon_orgnum is null then 0 else als_m6_id_caon_orgnum end as als_m6_id_caon_orgnum
        ,case when als_m12_id_caon_orgnum is null then 0 else als_m12_id_caon_orgnum end as als_m12_id_caon_orgnum
        ,case when als_d7_id_rel_allnum is null then 0 else als_d7_id_rel_allnum end as als_d7_id_rel_allnum
        ,case when als_d15_id_rel_allnum is null then 0 else als_d15_id_rel_allnum end as als_d15_id_rel_allnum
        ,case when als_m1_id_rel_allnum is null then 0 else als_m1_id_rel_allnum end as als_m1_id_rel_allnum
        ,case when als_m3_id_rel_allnum is null then 0 else als_m3_id_rel_allnum end as als_m3_id_rel_allnum
        ,case when als_m6_id_rel_allnum is null then 0 else als_m6_id_rel_allnum end as als_m6_id_rel_allnum
        ,case when als_m12_id_rel_allnum is null then 0 else als_m12_id_rel_allnum end as als_m12_id_rel_allnum
        ,case when als_d7_id_rel_orgnum is null then 0 else als_d7_id_rel_orgnum end as als_d7_id_rel_orgnum
        ,case when als_d15_id_rel_orgnum is null then 0 else als_d15_id_rel_orgnum end as als_d15_id_rel_orgnum
        ,case when als_m1_id_rel_orgnum is null then 0 else als_m1_id_rel_orgnum end as als_m1_id_rel_orgnum
        ,case when als_m3_id_rel_orgnum is null then 0 else als_m3_id_rel_orgnum end as als_m3_id_rel_orgnum
        ,case when als_m6_id_rel_orgnum is null then 0 else als_m6_id_rel_orgnum end as als_m6_id_rel_orgnum
        ,case when als_m12_id_rel_orgnum is null then 0 else als_m12_id_rel_orgnum end as als_m12_id_rel_orgnum
        ,case when als_d7_id_caoff_allnum is null then 0 else als_d7_id_caoff_allnum end as als_d7_id_caoff_allnum
        ,case when als_d15_id_caoff_allnum is null then 0 else als_d15_id_caoff_allnum end as als_d15_id_caoff_allnum
        ,case when als_m1_id_caoff_allnum is null then 0 else als_m1_id_caoff_allnum end as als_m1_id_caoff_allnum
        ,case when als_m3_id_caoff_allnum is null then 0 else als_m3_id_caoff_allnum end as als_m3_id_caoff_allnum
        ,case when als_m6_id_caoff_allnum is null then 0 else als_m6_id_caoff_allnum end as als_m6_id_caoff_allnum
        ,case when als_m12_id_caoff_allnum is null then 0 else als_m12_id_caoff_allnum end as als_m12_id_caoff_allnum
        ,case when als_d7_id_caoff_orgnum is null then 0 else als_d7_id_caoff_orgnum end as als_d7_id_caoff_orgnum
        ,case when als_d15_id_caoff_orgnum is null then 0 else als_d15_id_caoff_orgnum end as als_d15_id_caoff_orgnum
        ,case when als_m1_id_caoff_orgnum is null then 0 else als_m1_id_caoff_orgnum end as als_m1_id_caoff_orgnum
        ,case when als_m3_id_caoff_orgnum is null then 0 else als_m3_id_caoff_orgnum end as als_m3_id_caoff_orgnum
        ,case when als_m6_id_caoff_orgnum is null then 0 else als_m6_id_caoff_orgnum end as als_m6_id_caoff_orgnum
        ,case when als_m12_id_caoff_orgnum is null then 0 else als_m12_id_caoff_orgnum end as als_m12_id_caoff_orgnum
        ,case when als_d7_id_cooff_allnum is null then 0 else als_d7_id_cooff_allnum end as als_d7_id_cooff_allnum
        ,case when als_d15_id_cooff_allnum is null then 0 else als_d15_id_cooff_allnum end as als_d15_id_cooff_allnum
        ,case when als_m1_id_cooff_allnum is null then 0 else als_m1_id_cooff_allnum end as als_m1_id_cooff_allnum
        ,case when als_m3_id_cooff_allnum is null then 0 else als_m3_id_cooff_allnum end as als_m3_id_cooff_allnum
        ,case when als_m6_id_cooff_allnum is null then 0 else als_m6_id_cooff_allnum end as als_m6_id_cooff_allnum
        ,case when als_m12_id_cooff_allnum is null then 0 else als_m12_id_cooff_allnum end as als_m12_id_cooff_allnum
        ,case when als_d7_id_cooff_orgnum is null then 0 else als_d7_id_cooff_orgnum end as als_d7_id_cooff_orgnum
        ,case when als_d15_id_cooff_orgnum is null then 0 else als_d15_id_cooff_orgnum end as als_d15_id_cooff_orgnum
        ,case when als_m1_id_cooff_orgnum is null then 0 else als_m1_id_cooff_orgnum end as als_m1_id_cooff_orgnum
        ,case when als_m3_id_cooff_orgnum is null then 0 else als_m3_id_cooff_orgnum end as als_m3_id_cooff_orgnum
        ,case when als_m6_id_cooff_orgnum is null then 0 else als_m6_id_cooff_orgnum end as als_m6_id_cooff_orgnum
        ,case when als_m12_id_cooff_orgnum is null then 0 else als_m12_id_cooff_orgnum end as als_m12_id_cooff_orgnum
        ,case when als_d7_id_af_allnum is null then 0 else als_d7_id_af_allnum end as als_d7_id_af_allnum
        ,case when als_d15_id_af_allnum is null then 0 else als_d15_id_af_allnum end as als_d15_id_af_allnum
        ,case when als_m1_id_af_allnum is null then 0 else als_m1_id_af_allnum end as als_m1_id_af_allnum
        ,case when als_m3_id_af_allnum is null then 0 else als_m3_id_af_allnum end as als_m3_id_af_allnum
        ,case when als_m6_id_af_allnum is null then 0 else als_m6_id_af_allnum end as als_m6_id_af_allnum
        ,case when als_m12_id_af_allnum is null then 0 else als_m12_id_af_allnum end as als_m12_id_af_allnum
        ,case when als_d7_id_af_orgnum is null then 0 else als_d7_id_af_orgnum end as als_d7_id_af_orgnum
        ,case when als_d15_id_af_orgnum is null then 0 else als_d15_id_af_orgnum end as als_d15_id_af_orgnum
        ,case when als_m1_id_af_orgnum is null then 0 else als_m1_id_af_orgnum end as als_m1_id_af_orgnum
        ,case when als_m3_id_af_orgnum is null then 0 else als_m3_id_af_orgnum end as als_m3_id_af_orgnum
        ,case when als_m6_id_af_orgnum is null then 0 else als_m6_id_af_orgnum end as als_m6_id_af_orgnum
        ,case when als_m12_id_af_orgnum is null then 0 else als_m12_id_af_orgnum end as als_m12_id_af_orgnum
        ,case when als_d7_id_coon_allnum is null then 0 else als_d7_id_coon_allnum end as als_d7_id_coon_allnum
        ,case when als_d15_id_coon_allnum is null then 0 else als_d15_id_coon_allnum end as als_d15_id_coon_allnum
        ,case when als_m1_id_coon_allnum is null then 0 else als_m1_id_coon_allnum end as als_m1_id_coon_allnum
        ,case when als_m3_id_coon_allnum is null then 0 else als_m3_id_coon_allnum end as als_m3_id_coon_allnum
        ,case when als_m6_id_coon_allnum is null then 0 else als_m6_id_coon_allnum end as als_m6_id_coon_allnum
        ,case when als_m12_id_coon_allnum is null then 0 else als_m12_id_coon_allnum end as als_m12_id_coon_allnum
        ,case when als_d7_id_coon_orgnum is null then 0 else als_d7_id_coon_orgnum end as als_d7_id_coon_orgnum
        ,case when als_d15_id_coon_orgnum is null then 0 else als_d15_id_coon_orgnum end as als_d15_id_coon_orgnum
        ,case when als_m1_id_coon_orgnum is null then 0 else als_m1_id_coon_orgnum end as als_m1_id_coon_orgnum
        ,case when als_m3_id_coon_orgnum is null then 0 else als_m3_id_coon_orgnum end as als_m3_id_coon_orgnum
        ,case when als_m6_id_coon_orgnum is null then 0 else als_m6_id_coon_orgnum end as als_m6_id_coon_orgnum
        ,case when als_m12_id_coon_orgnum is null then 0 else als_m12_id_coon_orgnum end as als_m12_id_coon_orgnum
        ,case when als_d7_id_oth_allnum is null then 0 else als_d7_id_oth_allnum end as als_d7_id_oth_allnum
        ,case when als_d15_id_oth_allnum is null then 0 else als_d15_id_oth_allnum end as als_d15_id_oth_allnum
        ,case when als_m1_id_oth_allnum is null then 0 else als_m1_id_oth_allnum end as als_m1_id_oth_allnum
        ,case when als_m3_id_oth_allnum is null then 0 else als_m3_id_oth_allnum end as als_m3_id_oth_allnum
        ,case when als_m6_id_oth_allnum is null then 0 else als_m6_id_oth_allnum end as als_m6_id_oth_allnum
        ,case when als_m12_id_oth_allnum is null then 0 else als_m12_id_oth_allnum end as als_m12_id_oth_allnum
        ,case when als_d7_id_oth_orgnum is null then 0 else als_d7_id_oth_orgnum end as als_d7_id_oth_orgnum
        ,case when als_d15_id_oth_orgnum is null then 0 else als_d15_id_oth_orgnum end as als_d15_id_oth_orgnum
        ,case when als_m1_id_oth_orgnum is null then 0 else als_m1_id_oth_orgnum end as als_m1_id_oth_orgnum
        ,case when als_m3_id_oth_orgnum is null then 0 else als_m3_id_oth_orgnum end as als_m3_id_oth_orgnum
        ,case when als_m6_id_oth_orgnum is null then 0 else als_m6_id_oth_orgnum end as als_m6_id_oth_orgnum
        ,case when als_m12_id_oth_orgnum is null then 0 else als_m12_id_oth_orgnum end as als_m12_id_oth_orgnum
        ,case when als_d7_id_bank_selfnum is null then 0 else als_d7_id_bank_selfnum end as als_d7_id_bank_selfnum
        ,case when als_d15_id_bank_selfnum is null then 0 else als_d15_id_bank_selfnum end as als_d15_id_bank_selfnum
        ,case when als_m1_id_bank_selfnum is null then 0 else als_m1_id_bank_selfnum end as als_m1_id_bank_selfnum
        ,case when als_m3_id_bank_selfnum is null then 0 else als_m3_id_bank_selfnum end as als_m3_id_bank_selfnum
        ,case when als_m6_id_bank_selfnum is null then 0 else als_m6_id_bank_selfnum end as als_m6_id_bank_selfnum
        ,case when als_m12_id_bank_selfnum is null then 0 else als_m12_id_bank_selfnum end as als_m12_id_bank_selfnum
        ,case when als_d7_id_bank_allnum is null then 0 else als_d7_id_bank_allnum end as als_d7_id_bank_allnum
        ,case when als_d15_id_bank_allnum is null then 0 else als_d15_id_bank_allnum end as als_d15_id_bank_allnum
        ,case when als_m1_id_bank_allnum is null then 0 else als_m1_id_bank_allnum end as als_m1_id_bank_allnum
        ,case when als_m3_id_bank_allnum is null then 0 else als_m3_id_bank_allnum end as als_m3_id_bank_allnum
        ,case when als_m6_id_bank_allnum is null then 0 else als_m6_id_bank_allnum end as als_m6_id_bank_allnum
        ,case when als_m12_id_bank_allnum is null then 0 else als_m12_id_bank_allnum end as als_m12_id_bank_allnum
        ,case when als_d7_id_bank_tra_allnum is null then 0 else als_d7_id_bank_tra_allnum end as als_d7_id_bank_tra_allnum
        ,case when als_d15_id_bank_tra_allnum is null then 0 else als_d15_id_bank_tra_allnum end as als_d15_id_bank_tra_allnum
        ,case when als_m1_id_bank_tra_allnum is null then 0 else als_m1_id_bank_tra_allnum end as als_m1_id_bank_tra_allnum
        ,case when als_m3_id_bank_tra_allnum is null then 0 else als_m3_id_bank_tra_allnum end as als_m3_id_bank_tra_allnum
        ,case when als_m6_id_bank_tra_allnum is null then 0 else als_m6_id_bank_tra_allnum end as als_m6_id_bank_tra_allnum
        ,case when als_m12_id_bank_tra_allnum is null then 0 else als_m12_id_bank_tra_allnum end as als_m12_id_bank_tra_allnum
        ,case when als_d7_id_bank_ret_allnum is null then 0 else als_d7_id_bank_ret_allnum end as als_d7_id_bank_ret_allnum
        ,case when als_d15_id_bank_ret_allnum is null then 0 else als_d15_id_bank_ret_allnum end as als_d15_id_bank_ret_allnum
        ,case when als_m1_id_bank_ret_allnum is null then 0 else als_m1_id_bank_ret_allnum end as als_m1_id_bank_ret_allnum
        ,case when als_m3_id_bank_ret_allnum is null then 0 else als_m3_id_bank_ret_allnum end as als_m3_id_bank_ret_allnum
        ,case when als_m6_id_bank_ret_allnum is null then 0 else als_m6_id_bank_ret_allnum end as als_m6_id_bank_ret_allnum
        ,case when als_m12_id_bank_ret_allnum is null then 0 else als_m12_id_bank_ret_allnum end as als_m12_id_bank_ret_allnum
        ,case when als_d7_id_bank_orgnum is null then 0 else als_d7_id_bank_orgnum end as als_d7_id_bank_orgnum
        ,case when als_d15_id_bank_orgnum is null then 0 else als_d15_id_bank_orgnum end as als_d15_id_bank_orgnum
        ,case when als_m1_id_bank_orgnum is null then 0 else als_m1_id_bank_orgnum end as als_m1_id_bank_orgnum
        ,case when als_m3_id_bank_orgnum is null then 0 else als_m3_id_bank_orgnum end as als_m3_id_bank_orgnum
        ,case when als_m6_id_bank_orgnum is null then 0 else als_m6_id_bank_orgnum end as als_m6_id_bank_orgnum
        ,case when als_m12_id_bank_orgnum is null then 0 else als_m12_id_bank_orgnum end as als_m12_id_bank_orgnum
        ,case when als_d7_id_bank_tra_orgnum is null then 0 else als_d7_id_bank_tra_orgnum end as als_d7_id_bank_tra_orgnum
        ,case when als_d15_id_bank_tra_orgnum is null then 0 else als_d15_id_bank_tra_orgnum end as als_d15_id_bank_tra_orgnum
        ,case when als_m1_id_bank_tra_orgnum is null then 0 else als_m1_id_bank_tra_orgnum end as als_m1_id_bank_tra_orgnum
        ,case when als_m3_id_bank_tra_orgnum is null then 0 else als_m3_id_bank_tra_orgnum end as als_m3_id_bank_tra_orgnum
        ,case when als_m6_id_bank_tra_orgnum is null then 0 else als_m6_id_bank_tra_orgnum end as als_m6_id_bank_tra_orgnum
        ,case when als_m12_id_bank_tra_orgnum is null then 0 else als_m12_id_bank_tra_orgnum end as als_m12_id_bank_tra_orgnum
        ,case when als_d7_id_bank_ret_orgnum is null then 0 else als_d7_id_bank_ret_orgnum end as als_d7_id_bank_ret_orgnum
        ,case when als_d15_id_bank_ret_orgnum is null then 0 else als_d15_id_bank_ret_orgnum end as als_d15_id_bank_ret_orgnum
        ,case when als_m1_id_bank_ret_orgnum is null then 0 else als_m1_id_bank_ret_orgnum end as als_m1_id_bank_ret_orgnum
        ,case when als_m3_id_bank_ret_orgnum is null then 0 else als_m3_id_bank_ret_orgnum end as als_m3_id_bank_ret_orgnum
        ,case when als_m6_id_bank_ret_orgnum is null then 0 else als_m6_id_bank_ret_orgnum end as als_m6_id_bank_ret_orgnum
        ,case when als_m12_id_bank_ret_orgnum is null then 0 else als_m12_id_bank_ret_orgnum end as als_m12_id_bank_ret_orgnum
        ,case when als_d7_id_bank_week_allnum is null then 0 else als_d7_id_bank_week_allnum end as als_d7_id_bank_week_allnum
        ,case when als_d15_id_bank_week_allnum is null then 0 else als_d15_id_bank_week_allnum end as als_d15_id_bank_week_allnum
        ,case when als_m1_id_bank_week_allnum is null then 0 else als_m1_id_bank_week_allnum end as als_m1_id_bank_week_allnum
        ,case when als_m3_id_bank_week_allnum is null then 0 else als_m3_id_bank_week_allnum end as als_m3_id_bank_week_allnum
        ,case when als_m6_id_bank_week_allnum is null then 0 else als_m6_id_bank_week_allnum end as als_m6_id_bank_week_allnum
        ,case when als_m12_id_bank_week_allnum is null then 0 else als_m12_id_bank_week_allnum end as als_m12_id_bank_week_allnum
        ,case when als_d7_id_bank_week_orgnum is null then 0 else als_d7_id_bank_week_orgnum end as als_d7_id_bank_week_orgnum
        ,case when als_d15_id_bank_week_orgnum is null then 0 else als_d15_id_bank_week_orgnum end as als_d15_id_bank_week_orgnum
        ,case when als_m1_id_bank_week_orgnum is null then 0 else als_m1_id_bank_week_orgnum end as als_m1_id_bank_week_orgnum
        ,case when als_m3_id_bank_week_orgnum is null then 0 else als_m3_id_bank_week_orgnum end as als_m3_id_bank_week_orgnum
        ,case when als_m6_id_bank_week_orgnum is null then 0 else als_m6_id_bank_week_orgnum end as als_m6_id_bank_week_orgnum
        ,case when als_m12_id_bank_week_orgnum is null then 0 else als_m12_id_bank_week_orgnum end as als_m12_id_bank_week_orgnum
        ,case when als_d7_id_bank_night_allnum is null then 0 else als_d7_id_bank_night_allnum end as als_d7_id_bank_night_allnum
        ,case when als_d15_id_bank_night_allnum is null then 0 else als_d15_id_bank_night_allnum end as als_d15_id_bank_night_allnum
        ,case when als_m1_id_bank_night_allnum is null then 0 else als_m1_id_bank_night_allnum end as als_m1_id_bank_night_allnum
        ,case when als_m3_id_bank_night_allnum is null then 0 else als_m3_id_bank_night_allnum end as als_m3_id_bank_night_allnum
        ,case when als_m6_id_bank_night_allnum is null then 0 else als_m6_id_bank_night_allnum end as als_m6_id_bank_night_allnum
        ,case when als_m12_id_bank_night_allnum is null then 0 else als_m12_id_bank_night_allnum end as als_m12_id_bank_night_allnum
        ,case when als_d7_id_bank_night_orgnum is null then 0 else als_d7_id_bank_night_orgnum end as als_d7_id_bank_night_orgnum
        ,case when als_d15_id_bank_night_orgnum is null then 0 else als_d15_id_bank_night_orgnum end as als_d15_id_bank_night_orgnum
        ,case when als_m1_id_bank_night_orgnum is null then 0 else als_m1_id_bank_night_orgnum end as als_m1_id_bank_night_orgnum
        ,case when als_m3_id_bank_night_orgnum is null then 0 else als_m3_id_bank_night_orgnum end as als_m3_id_bank_night_orgnum
        ,case when als_m6_id_bank_night_orgnum is null then 0 else als_m6_id_bank_night_orgnum end as als_m6_id_bank_night_orgnum
        ,case when als_m12_id_bank_night_orgnum is null then 0 else als_m12_id_bank_night_orgnum end as als_m12_id_bank_night_orgnum
        ,case when als_d7_id_nbank_selfnum is null then 0 else als_d7_id_nbank_selfnum end as als_d7_id_nbank_selfnum
        ,case when als_d15_id_nbank_selfnum is null then 0 else als_d15_id_nbank_selfnum end as als_d15_id_nbank_selfnum
        ,case when als_m1_id_nbank_selfnum is null then 0 else als_m1_id_nbank_selfnum end as als_m1_id_nbank_selfnum
        ,case when als_m3_id_nbank_selfnum is null then 0 else als_m3_id_nbank_selfnum end as als_m3_id_nbank_selfnum
        ,case when als_m6_id_nbank_selfnum is null then 0 else als_m6_id_nbank_selfnum end as als_m6_id_nbank_selfnum
        ,case when als_m12_id_nbank_selfnum is null then 0 else als_m12_id_nbank_selfnum end as als_m12_id_nbank_selfnum
        ,case when als_d7_id_nbank_allnum is null then 0 else als_d7_id_nbank_allnum end as als_d7_id_nbank_allnum
        ,case when als_d15_id_nbank_allnum is null then 0 else als_d15_id_nbank_allnum end as als_d15_id_nbank_allnum
        ,case when als_m1_id_nbank_allnum is null then 0 else als_m1_id_nbank_allnum end as als_m1_id_nbank_allnum
        ,case when als_m3_id_nbank_allnum is null then 0 else als_m3_id_nbank_allnum end as als_m3_id_nbank_allnum
        ,case when als_m6_id_nbank_allnum is null then 0 else als_m6_id_nbank_allnum end as als_m6_id_nbank_allnum
        ,case when als_m12_id_nbank_allnum is null then 0 else als_m12_id_nbank_allnum end as als_m12_id_nbank_allnum
        ,case when als_d7_id_nbank_p2p_allnum is null then 0 else als_d7_id_nbank_p2p_allnum end as als_d7_id_nbank_p2p_allnum
        ,case when als_d15_id_nbank_p2p_allnum is null then 0 else als_d15_id_nbank_p2p_allnum end as als_d15_id_nbank_p2p_allnum
        ,case when als_m1_id_nbank_p2p_allnum is null then 0 else als_m1_id_nbank_p2p_allnum end as als_m1_id_nbank_p2p_allnum
        ,case when als_m3_id_nbank_p2p_allnum is null then 0 else als_m3_id_nbank_p2p_allnum end as als_m3_id_nbank_p2p_allnum
        ,case when als_m6_id_nbank_p2p_allnum is null then 0 else als_m6_id_nbank_p2p_allnum end as als_m6_id_nbank_p2p_allnum
        ,case when als_m12_id_nbank_p2p_allnum is null then 0 else als_m12_id_nbank_p2p_allnum end as als_m12_id_nbank_p2p_allnum
        ,case when als_d7_id_nbank_mc_allnum is null then 0 else als_d7_id_nbank_mc_allnum end as als_d7_id_nbank_mc_allnum
        ,case when als_d15_id_nbank_mc_allnum is null then 0 else als_d15_id_nbank_mc_allnum end as als_d15_id_nbank_mc_allnum
        ,case when als_m1_id_nbank_mc_allnum is null then 0 else als_m1_id_nbank_mc_allnum end as als_m1_id_nbank_mc_allnum
        ,case when als_m3_id_nbank_mc_allnum is null then 0 else als_m3_id_nbank_mc_allnum end as als_m3_id_nbank_mc_allnum
        ,case when als_m6_id_nbank_mc_allnum is null then 0 else als_m6_id_nbank_mc_allnum end as als_m6_id_nbank_mc_allnum
        ,case when als_m12_id_nbank_mc_allnum is null then 0 else als_m12_id_nbank_mc_allnum end as als_m12_id_nbank_mc_allnum
        ,case when als_d7_id_nbank_ca_allnum is null then 0 else als_d7_id_nbank_ca_allnum end as als_d7_id_nbank_ca_allnum
        ,case when als_d15_id_nbank_ca_allnum is null then 0 else als_d15_id_nbank_ca_allnum end as als_d15_id_nbank_ca_allnum
        ,case when als_m1_id_nbank_ca_allnum is null then 0 else als_m1_id_nbank_ca_allnum end as als_m1_id_nbank_ca_allnum
        ,case when als_m3_id_nbank_ca_allnum is null then 0 else als_m3_id_nbank_ca_allnum end as als_m3_id_nbank_ca_allnum
        ,case when als_m6_id_nbank_ca_allnum is null then 0 else als_m6_id_nbank_ca_allnum end as als_m6_id_nbank_ca_allnum
        ,case when als_m12_id_nbank_ca_allnum is null then 0 else als_m12_id_nbank_ca_allnum end as als_m12_id_nbank_ca_allnum
        ,case when als_d7_id_nbank_cf_allnum is null then 0 else als_d7_id_nbank_cf_allnum end as als_d7_id_nbank_cf_allnum
        ,case when als_d15_id_nbank_cf_allnum is null then 0 else als_d15_id_nbank_cf_allnum end as als_d15_id_nbank_cf_allnum
        ,case when als_m1_id_nbank_cf_allnum is null then 0 else als_m1_id_nbank_cf_allnum end as als_m1_id_nbank_cf_allnum
        ,case when als_m3_id_nbank_cf_allnum is null then 0 else als_m3_id_nbank_cf_allnum end as als_m3_id_nbank_cf_allnum
        ,case when als_m6_id_nbank_cf_allnum is null then 0 else als_m6_id_nbank_cf_allnum end as als_m6_id_nbank_cf_allnum
        ,case when als_m12_id_nbank_cf_allnum is null then 0 else als_m12_id_nbank_cf_allnum end as als_m12_id_nbank_cf_allnum
        ,case when als_d7_id_nbank_com_allnum is null then 0 else als_d7_id_nbank_com_allnum end as als_d7_id_nbank_com_allnum
        ,case when als_d15_id_nbank_com_allnum is null then 0 else als_d15_id_nbank_com_allnum end as als_d15_id_nbank_com_allnum
        ,case when als_m1_id_nbank_com_allnum is null then 0 else als_m1_id_nbank_com_allnum end as als_m1_id_nbank_com_allnum
        ,case when als_m3_id_nbank_com_allnum is null then 0 else als_m3_id_nbank_com_allnum end as als_m3_id_nbank_com_allnum
        ,case when als_m6_id_nbank_com_allnum is null then 0 else als_m6_id_nbank_com_allnum end as als_m6_id_nbank_com_allnum
        ,case when als_m12_id_nbank_com_allnum is null then 0 else als_m12_id_nbank_com_allnum end as als_m12_id_nbank_com_allnum
        ,case when als_d7_id_nbank_oth_allnum is null then 0 else als_d7_id_nbank_oth_allnum end as als_d7_id_nbank_oth_allnum
        ,case when als_d15_id_nbank_oth_allnum is null then 0 else als_d15_id_nbank_oth_allnum end as als_d15_id_nbank_oth_allnum
        ,case when als_m1_id_nbank_oth_allnum is null then 0 else als_m1_id_nbank_oth_allnum end as als_m1_id_nbank_oth_allnum
        ,case when als_m3_id_nbank_oth_allnum is null then 0 else als_m3_id_nbank_oth_allnum end as als_m3_id_nbank_oth_allnum
        ,case when als_m6_id_nbank_oth_allnum is null then 0 else als_m6_id_nbank_oth_allnum end as als_m6_id_nbank_oth_allnum
        ,case when als_m12_id_nbank_oth_allnum is null then 0 else als_m12_id_nbank_oth_allnum end as als_m12_id_nbank_oth_allnum
        ,case when als_d7_id_nbank_nsloan_allnum is null then 0 else als_d7_id_nbank_nsloan_allnum end as als_d7_id_nbank_nsloan_allnum
        ,case when als_d15_id_nbank_nsloan_allnum is null then 0 else als_d15_id_nbank_nsloan_allnum end as als_d15_id_nbank_nsloan_allnum
        ,case when als_m1_id_nbank_nsloan_allnum is null then 0 else als_m1_id_nbank_nsloan_allnum end as als_m1_id_nbank_nsloan_allnum
        ,case when als_m3_id_nbank_nsloan_allnum is null then 0 else als_m3_id_nbank_nsloan_allnum end as als_m3_id_nbank_nsloan_allnum
        ,case when als_m6_id_nbank_nsloan_allnum is null then 0 else als_m6_id_nbank_nsloan_allnum end as als_m6_id_nbank_nsloan_allnum
        ,case when als_m12_id_nbank_nsloan_allnum is null then 0 else als_m12_id_nbank_nsloan_allnum end as als_m12_id_nbank_nsloan_allnum
        ,case when als_d7_id_nbank_autofin_allnum is null then 0 else als_d7_id_nbank_autofin_allnum end as als_d7_id_nbank_autofin_allnum
        ,case when als_d15_id_nbank_autofin_allnum is null then 0 else als_d15_id_nbank_autofin_allnum end as als_d15_id_nbank_autofin_allnum
        ,case when als_m1_id_nbank_autofin_allnum is null then 0 else als_m1_id_nbank_autofin_allnum end as als_m1_id_nbank_autofin_allnum
        ,case when als_m3_id_nbank_autofin_allnum is null then 0 else als_m3_id_nbank_autofin_allnum end as als_m3_id_nbank_autofin_allnum
        ,case when als_m6_id_nbank_autofin_allnum is null then 0 else als_m6_id_nbank_autofin_allnum end as als_m6_id_nbank_autofin_allnum
        ,case when als_m12_id_nbank_autofin_allnum is null then 0 else als_m12_id_nbank_autofin_allnum end as als_m12_id_nbank_autofin_allnum
        ,case when als_d7_id_nbank_sloan_allnum is null then 0 else als_d7_id_nbank_sloan_allnum end as als_d7_id_nbank_sloan_allnum
        ,case when als_d15_id_nbank_sloan_allnum is null then 0 else als_d15_id_nbank_sloan_allnum end as als_d15_id_nbank_sloan_allnum
        ,case when als_m1_id_nbank_sloan_allnum is null then 0 else als_m1_id_nbank_sloan_allnum end as als_m1_id_nbank_sloan_allnum
        ,case when als_m3_id_nbank_sloan_allnum is null then 0 else als_m3_id_nbank_sloan_allnum end as als_m3_id_nbank_sloan_allnum
        ,case when als_m6_id_nbank_sloan_allnum is null then 0 else als_m6_id_nbank_sloan_allnum end as als_m6_id_nbank_sloan_allnum
        ,case when als_m12_id_nbank_sloan_allnum is null then 0 else als_m12_id_nbank_sloan_allnum end as als_m12_id_nbank_sloan_allnum
        ,case when als_d7_id_nbank_cons_allnum is null then 0 else als_d7_id_nbank_cons_allnum end as als_d7_id_nbank_cons_allnum
        ,case when als_d15_id_nbank_cons_allnum is null then 0 else als_d15_id_nbank_cons_allnum end as als_d15_id_nbank_cons_allnum
        ,case when als_m1_id_nbank_cons_allnum is null then 0 else als_m1_id_nbank_cons_allnum end as als_m1_id_nbank_cons_allnum
        ,case when als_m3_id_nbank_cons_allnum is null then 0 else als_m3_id_nbank_cons_allnum end as als_m3_id_nbank_cons_allnum
        ,case when als_m6_id_nbank_cons_allnum is null then 0 else als_m6_id_nbank_cons_allnum end as als_m6_id_nbank_cons_allnum
        ,case when als_m12_id_nbank_cons_allnum is null then 0 else als_m12_id_nbank_cons_allnum end as als_m12_id_nbank_cons_allnum
        ,case when als_d7_id_nbank_finlea_allnum is null then 0 else als_d7_id_nbank_finlea_allnum end as als_d7_id_nbank_finlea_allnum
        ,case when als_d15_id_nbank_finlea_allnum is null then 0 else als_d15_id_nbank_finlea_allnum end as als_d15_id_nbank_finlea_allnum
        ,case when als_m1_id_nbank_finlea_allnum is null then 0 else als_m1_id_nbank_finlea_allnum end as als_m1_id_nbank_finlea_allnum
        ,case when als_m3_id_nbank_finlea_allnum is null then 0 else als_m3_id_nbank_finlea_allnum end as als_m3_id_nbank_finlea_allnum
        ,case when als_m6_id_nbank_finlea_allnum is null then 0 else als_m6_id_nbank_finlea_allnum end as als_m6_id_nbank_finlea_allnum
        ,case when als_m12_id_nbank_finlea_allnum is null then 0 else als_m12_id_nbank_finlea_allnum end as als_m12_id_nbank_finlea_allnum
        ,case when als_d7_id_nbank_else_allnum is null then 0 else als_d7_id_nbank_else_allnum end as als_d7_id_nbank_else_allnum
        ,case when als_d15_id_nbank_else_allnum is null then 0 else als_d15_id_nbank_else_allnum end as als_d15_id_nbank_else_allnum
        ,case when als_m1_id_nbank_else_allnum is null then 0 else als_m1_id_nbank_else_allnum end as als_m1_id_nbank_else_allnum
        ,case when als_m3_id_nbank_else_allnum is null then 0 else als_m3_id_nbank_else_allnum end as als_m3_id_nbank_else_allnum
        ,case when als_m6_id_nbank_else_allnum is null then 0 else als_m6_id_nbank_else_allnum end as als_m6_id_nbank_else_allnum
        ,case when als_m12_id_nbank_else_allnum is null then 0 else als_m12_id_nbank_else_allnum end as als_m12_id_nbank_else_allnum
        ,case when als_d7_id_nbank_orgnum is null then 0 else als_d7_id_nbank_orgnum end as als_d7_id_nbank_orgnum
        ,case when als_d15_id_nbank_orgnum is null then 0 else als_d15_id_nbank_orgnum end as als_d15_id_nbank_orgnum
        ,case when als_m1_id_nbank_orgnum is null then 0 else als_m1_id_nbank_orgnum end as als_m1_id_nbank_orgnum
        ,case when als_m3_id_nbank_orgnum is null then 0 else als_m3_id_nbank_orgnum end as als_m3_id_nbank_orgnum
        ,case when als_m6_id_nbank_orgnum is null then 0 else als_m6_id_nbank_orgnum end as als_m6_id_nbank_orgnum
        ,case when als_m12_id_nbank_orgnum is null then 0 else als_m12_id_nbank_orgnum end as als_m12_id_nbank_orgnum
        ,case when als_d7_id_nbank_p2p_orgnum is null then 0 else als_d7_id_nbank_p2p_orgnum end as als_d7_id_nbank_p2p_orgnum
        ,case when als_d15_id_nbank_p2p_orgnum is null then 0 else als_d15_id_nbank_p2p_orgnum end as als_d15_id_nbank_p2p_orgnum
        ,case when als_m1_id_nbank_p2p_orgnum is null then 0 else als_m1_id_nbank_p2p_orgnum end as als_m1_id_nbank_p2p_orgnum
        ,case when als_m3_id_nbank_p2p_orgnum is null then 0 else als_m3_id_nbank_p2p_orgnum end as als_m3_id_nbank_p2p_orgnum
        ,case when als_m6_id_nbank_p2p_orgnum is null then 0 else als_m6_id_nbank_p2p_orgnum end as als_m6_id_nbank_p2p_orgnum
        ,case when als_m12_id_nbank_p2p_orgnum is null then 0 else als_m12_id_nbank_p2p_orgnum end as als_m12_id_nbank_p2p_orgnum
        ,case when als_d7_id_nbank_mc_orgnum is null then 0 else als_d7_id_nbank_mc_orgnum end as als_d7_id_nbank_mc_orgnum
        ,case when als_d15_id_nbank_mc_orgnum is null then 0 else als_d15_id_nbank_mc_orgnum end as als_d15_id_nbank_mc_orgnum
        ,case when als_m1_id_nbank_mc_orgnum is null then 0 else als_m1_id_nbank_mc_orgnum end as als_m1_id_nbank_mc_orgnum
        ,case when als_m3_id_nbank_mc_orgnum is null then 0 else als_m3_id_nbank_mc_orgnum end as als_m3_id_nbank_mc_orgnum
        ,case when als_m6_id_nbank_mc_orgnum is null then 0 else als_m6_id_nbank_mc_orgnum end as als_m6_id_nbank_mc_orgnum
        ,case when als_m12_id_nbank_mc_orgnum is null then 0 else als_m12_id_nbank_mc_orgnum end as als_m12_id_nbank_mc_orgnum
        ,case when als_d7_id_nbank_ca_orgnum is null then 0 else als_d7_id_nbank_ca_orgnum end as als_d7_id_nbank_ca_orgnum
        ,case when als_d15_id_nbank_ca_orgnum is null then 0 else als_d15_id_nbank_ca_orgnum end as als_d15_id_nbank_ca_orgnum
        ,case when als_m1_id_nbank_ca_orgnum is null then 0 else als_m1_id_nbank_ca_orgnum end as als_m1_id_nbank_ca_orgnum
        ,case when als_m3_id_nbank_ca_orgnum is null then 0 else als_m3_id_nbank_ca_orgnum end as als_m3_id_nbank_ca_orgnum
        ,case when als_m6_id_nbank_ca_orgnum is null then 0 else als_m6_id_nbank_ca_orgnum end as als_m6_id_nbank_ca_orgnum
        ,case when als_m12_id_nbank_ca_orgnum is null then 0 else als_m12_id_nbank_ca_orgnum end as als_m12_id_nbank_ca_orgnum
        ,case when als_d7_id_nbank_cf_orgnum is null then 0 else als_d7_id_nbank_cf_orgnum end as als_d7_id_nbank_cf_orgnum
        ,case when als_d15_id_nbank_cf_orgnum is null then 0 else als_d15_id_nbank_cf_orgnum end as als_d15_id_nbank_cf_orgnum
        ,case when als_m1_id_nbank_cf_orgnum is null then 0 else als_m1_id_nbank_cf_orgnum end as als_m1_id_nbank_cf_orgnum
        ,case when als_m3_id_nbank_cf_orgnum is null then 0 else als_m3_id_nbank_cf_orgnum end as als_m3_id_nbank_cf_orgnum
        ,case when als_m6_id_nbank_cf_orgnum is null then 0 else als_m6_id_nbank_cf_orgnum end as als_m6_id_nbank_cf_orgnum
        ,case when als_m12_id_nbank_cf_orgnum is null then 0 else als_m12_id_nbank_cf_orgnum end as als_m12_id_nbank_cf_orgnum
        ,case when als_d7_id_nbank_com_orgnum is null then 0 else als_d7_id_nbank_com_orgnum end as als_d7_id_nbank_com_orgnum
        ,case when als_d15_id_nbank_com_orgnum is null then 0 else als_d15_id_nbank_com_orgnum end as als_d15_id_nbank_com_orgnum
        ,case when als_m1_id_nbank_com_orgnum is null then 0 else als_m1_id_nbank_com_orgnum end as als_m1_id_nbank_com_orgnum
        ,case when als_m3_id_nbank_com_orgnum is null then 0 else als_m3_id_nbank_com_orgnum end as als_m3_id_nbank_com_orgnum
        ,case when als_m6_id_nbank_com_orgnum is null then 0 else als_m6_id_nbank_com_orgnum end as als_m6_id_nbank_com_orgnum
        ,case when als_m12_id_nbank_com_orgnum is null then 0 else als_m12_id_nbank_com_orgnum end as als_m12_id_nbank_com_orgnum
        ,case when als_d7_id_nbank_oth_orgnum is null then 0 else als_d7_id_nbank_oth_orgnum end as als_d7_id_nbank_oth_orgnum
        ,case when als_d15_id_nbank_oth_orgnum is null then 0 else als_d15_id_nbank_oth_orgnum end as als_d15_id_nbank_oth_orgnum
        ,case when als_m1_id_nbank_oth_orgnum is null then 0 else als_m1_id_nbank_oth_orgnum end as als_m1_id_nbank_oth_orgnum
        ,case when als_m3_id_nbank_oth_orgnum is null then 0 else als_m3_id_nbank_oth_orgnum end as als_m3_id_nbank_oth_orgnum
        ,case when als_m6_id_nbank_oth_orgnum is null then 0 else als_m6_id_nbank_oth_orgnum end as als_m6_id_nbank_oth_orgnum
        ,case when als_m12_id_nbank_oth_orgnum is null then 0 else als_m12_id_nbank_oth_orgnum end as als_m12_id_nbank_oth_orgnum
        ,case when als_d7_id_nbank_nsloan_orgnum is null then 0 else als_d7_id_nbank_nsloan_orgnum end as als_d7_id_nbank_nsloan_orgnum
        ,case when als_d15_id_nbank_nsloan_orgnum is null then 0 else als_d15_id_nbank_nsloan_orgnum end as als_d15_id_nbank_nsloan_orgnum
        ,case when als_m1_id_nbank_nsloan_orgnum is null then 0 else als_m1_id_nbank_nsloan_orgnum end as als_m1_id_nbank_nsloan_orgnum
        ,case when als_m3_id_nbank_nsloan_orgnum is null then 0 else als_m3_id_nbank_nsloan_orgnum end as als_m3_id_nbank_nsloan_orgnum
        ,case when als_m6_id_nbank_nsloan_orgnum is null then 0 else als_m6_id_nbank_nsloan_orgnum end as als_m6_id_nbank_nsloan_orgnum
        ,case when als_m12_id_nbank_nsloan_orgnum is null then 0 else als_m12_id_nbank_nsloan_orgnum end as als_m12_id_nbank_nsloan_orgnum
        ,case when als_d7_id_nbank_autofin_orgnum is null then 0 else als_d7_id_nbank_autofin_orgnum end as als_d7_id_nbank_autofin_orgnum
        ,case when als_d15_id_nbank_autofin_orgnum is null then 0 else als_d15_id_nbank_autofin_orgnum end as als_d15_id_nbank_autofin_orgnum
        ,case when als_m1_id_nbank_autofin_orgnum is null then 0 else als_m1_id_nbank_autofin_orgnum end as als_m1_id_nbank_autofin_orgnum
        ,case when als_m3_id_nbank_autofin_orgnum is null then 0 else als_m3_id_nbank_autofin_orgnum end as als_m3_id_nbank_autofin_orgnum
        ,case when als_m6_id_nbank_autofin_orgnum is null then 0 else als_m6_id_nbank_autofin_orgnum end as als_m6_id_nbank_autofin_orgnum
        ,case when als_m12_id_nbank_autofin_orgnum is null then 0 else als_m12_id_nbank_autofin_orgnum end as als_m12_id_nbank_autofin_orgnum
        ,case when als_d7_id_nbank_sloan_orgnum is null then 0 else als_d7_id_nbank_sloan_orgnum end as als_d7_id_nbank_sloan_orgnum
        ,case when als_d15_id_nbank_sloan_orgnum is null then 0 else als_d15_id_nbank_sloan_orgnum end as als_d15_id_nbank_sloan_orgnum
        ,case when als_m1_id_nbank_sloan_orgnum is null then 0 else als_m1_id_nbank_sloan_orgnum end as als_m1_id_nbank_sloan_orgnum
        ,case when als_m3_id_nbank_sloan_orgnum is null then 0 else als_m3_id_nbank_sloan_orgnum end as als_m3_id_nbank_sloan_orgnum
        ,case when als_m6_id_nbank_sloan_orgnum is null then 0 else als_m6_id_nbank_sloan_orgnum end as als_m6_id_nbank_sloan_orgnum
        ,case when als_m12_id_nbank_sloan_orgnum is null then 0 else als_m12_id_nbank_sloan_orgnum end as als_m12_id_nbank_sloan_orgnum
        ,case when als_d7_id_nbank_cons_orgnum is null then 0 else als_d7_id_nbank_cons_orgnum end as als_d7_id_nbank_cons_orgnum
        ,case when als_d15_id_nbank_cons_orgnum is null then 0 else als_d15_id_nbank_cons_orgnum end as als_d15_id_nbank_cons_orgnum
        ,case when als_m1_id_nbank_cons_orgnum is null then 0 else als_m1_id_nbank_cons_orgnum end as als_m1_id_nbank_cons_orgnum
        ,case when als_m3_id_nbank_cons_orgnum is null then 0 else als_m3_id_nbank_cons_orgnum end as als_m3_id_nbank_cons_orgnum
        ,case when als_m6_id_nbank_cons_orgnum is null then 0 else als_m6_id_nbank_cons_orgnum end as als_m6_id_nbank_cons_orgnum
        ,case when als_m12_id_nbank_cons_orgnum is null then 0 else als_m12_id_nbank_cons_orgnum end as als_m12_id_nbank_cons_orgnum
        ,case when als_d7_id_nbank_finlea_orgnum is null then 0 else als_d7_id_nbank_finlea_orgnum end as als_d7_id_nbank_finlea_orgnum
        ,case when als_d15_id_nbank_finlea_orgnum is null then 0 else als_d15_id_nbank_finlea_orgnum end as als_d15_id_nbank_finlea_orgnum
        ,case when als_m1_id_nbank_finlea_orgnum is null then 0 else als_m1_id_nbank_finlea_orgnum end as als_m1_id_nbank_finlea_orgnum
        ,case when als_m3_id_nbank_finlea_orgnum is null then 0 else als_m3_id_nbank_finlea_orgnum end as als_m3_id_nbank_finlea_orgnum
        ,case when als_m6_id_nbank_finlea_orgnum is null then 0 else als_m6_id_nbank_finlea_orgnum end as als_m6_id_nbank_finlea_orgnum
        ,case when als_m12_id_nbank_finlea_orgnum is null then 0 else als_m12_id_nbank_finlea_orgnum end as als_m12_id_nbank_finlea_orgnum
        ,case when als_d7_id_nbank_else_orgnum is null then 0 else als_d7_id_nbank_else_orgnum end as als_d7_id_nbank_else_orgnum
        ,case when als_d15_id_nbank_else_orgnum is null then 0 else als_d15_id_nbank_else_orgnum end as als_d15_id_nbank_else_orgnum
        ,case when als_m1_id_nbank_else_orgnum is null then 0 else als_m1_id_nbank_else_orgnum end as als_m1_id_nbank_else_orgnum
        ,case when als_m3_id_nbank_else_orgnum is null then 0 else als_m3_id_nbank_else_orgnum end as als_m3_id_nbank_else_orgnum
        ,case when als_m6_id_nbank_else_orgnum is null then 0 else als_m6_id_nbank_else_orgnum end as als_m6_id_nbank_else_orgnum
        ,case when als_m12_id_nbank_else_orgnum is null then 0 else als_m12_id_nbank_else_orgnum end as als_m12_id_nbank_else_orgnum
        ,case when als_d7_id_nbank_week_allnum is null then 0 else als_d7_id_nbank_week_allnum end as als_d7_id_nbank_week_allnum
        ,case when als_d15_id_nbank_week_allnum is null then 0 else als_d15_id_nbank_week_allnum end as als_d15_id_nbank_week_allnum
        ,case when als_m1_id_nbank_week_allnum is null then 0 else als_m1_id_nbank_week_allnum end as als_m1_id_nbank_week_allnum
        ,case when als_m3_id_nbank_week_allnum is null then 0 else als_m3_id_nbank_week_allnum end as als_m3_id_nbank_week_allnum
        ,case when als_m6_id_nbank_week_allnum is null then 0 else als_m6_id_nbank_week_allnum end as als_m6_id_nbank_week_allnum
        ,case when als_m12_id_nbank_week_allnum is null then 0 else als_m12_id_nbank_week_allnum end as als_m12_id_nbank_week_allnum
        ,case when als_d7_id_nbank_week_orgnum is null then 0 else als_d7_id_nbank_week_orgnum end as als_d7_id_nbank_week_orgnum
        ,case when als_d15_id_nbank_week_orgnum is null then 0 else als_d15_id_nbank_week_orgnum end as als_d15_id_nbank_week_orgnum
        ,case when als_m1_id_nbank_week_orgnum is null then 0 else als_m1_id_nbank_week_orgnum end as als_m1_id_nbank_week_orgnum
        ,case when als_m3_id_nbank_week_orgnum is null then 0 else als_m3_id_nbank_week_orgnum end as als_m3_id_nbank_week_orgnum
        ,case when als_m6_id_nbank_week_orgnum is null then 0 else als_m6_id_nbank_week_orgnum end as als_m6_id_nbank_week_orgnum
        ,case when als_m12_id_nbank_week_orgnum is null then 0 else als_m12_id_nbank_week_orgnum end as als_m12_id_nbank_week_orgnum
        ,case when als_d7_id_nbank_night_allnum is null then 0 else als_d7_id_nbank_night_allnum end as als_d7_id_nbank_night_allnum
        ,case when als_d15_id_nbank_night_allnum is null then 0 else als_d15_id_nbank_night_allnum end as als_d15_id_nbank_night_allnum
        ,case when als_m1_id_nbank_night_allnum is null then 0 else als_m1_id_nbank_night_allnum end as als_m1_id_nbank_night_allnum
        ,case when als_m3_id_nbank_night_allnum is null then 0 else als_m3_id_nbank_night_allnum end as als_m3_id_nbank_night_allnum
        ,case when als_m6_id_nbank_night_allnum is null then 0 else als_m6_id_nbank_night_allnum end as als_m6_id_nbank_night_allnum
        ,case when als_m12_id_nbank_night_allnum is null then 0 else als_m12_id_nbank_night_allnum end as als_m12_id_nbank_night_allnum
        ,case when als_d7_id_nbank_night_orgnum is null then 0 else als_d7_id_nbank_night_orgnum end as als_d7_id_nbank_night_orgnum
        ,case when als_d15_id_nbank_night_orgnum is null then 0 else als_d15_id_nbank_night_orgnum end as als_d15_id_nbank_night_orgnum
        ,case when als_m1_id_nbank_night_orgnum is null then 0 else als_m1_id_nbank_night_orgnum end as als_m1_id_nbank_night_orgnum
        ,case when als_m3_id_nbank_night_orgnum is null then 0 else als_m3_id_nbank_night_orgnum end as als_m3_id_nbank_night_orgnum
        ,case when als_m6_id_nbank_night_orgnum is null then 0 else als_m6_id_nbank_night_orgnum end as als_m6_id_nbank_night_orgnum
        ,case when als_m12_id_nbank_night_orgnum is null then 0 else als_m12_id_nbank_night_orgnum end as als_m12_id_nbank_night_orgnum

        ,data_id
        ,code
        ,flag_applyloanstr
        ,swift_number
        ,created_at
        ,updated_at
    from ${pdm_risk}.pdm_risk_dz_daily_br_cast_float_feature
    where ds = '${bizdate}'
) t;


insert overwrite table ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature partition (ds='${bizdate}')
select uid

    ,als_d7_id_pdl_allnum / als_d15_id_pdl_allnum as als_d7_d15_id_pdl_allnum_rte
    ,als_d15_id_pdl_allnum / als_m1_id_pdl_allnum as als_d15_m1_id_pdl_allnum_rte
    ,als_m1_id_pdl_allnum / als_m3_id_pdl_allnum as als_m1_m3_id_pdl_allnum_rte
    ,als_m3_id_pdl_allnum / als_m12_id_pdl_allnum as als_m3_m12_id_pdl_allnum_rte
    ,als_m6_id_pdl_allnum / als_m12_id_pdl_allnum as als_m6_m12_id_pdl_allnum_rte
    ,als_d7_id_pdl_orgnum / als_d15_id_pdl_orgnum as als_d7_d15_id_pdl_orgnum_rte
    ,als_d15_id_pdl_orgnum / als_m1_id_pdl_orgnum as als_d15_m1_id_pdl_orgnum_rte
    ,als_m1_id_pdl_orgnum / als_m3_id_pdl_orgnum as als_m1_m3_id_pdl_orgnum_rte
    ,als_m3_id_pdl_orgnum / als_m12_id_pdl_orgnum as als_m3_m12_id_pdl_orgnum_rte
    ,als_m6_id_pdl_orgnum / als_m12_id_pdl_orgnum as als_m6_m12_id_pdl_orgnum_rte
    ,als_d7_id_caon_allnum / als_d15_id_caon_allnum as als_d7_d15_id_caon_allnum_rte
    ,als_d15_id_caon_allnum / als_m1_id_caon_allnum as als_d15_m1_id_caon_allnum_rte
    ,als_m1_id_caon_allnum / als_m3_id_caon_allnum as als_m1_m3_id_caon_allnum_rte
    ,als_m3_id_caon_allnum / als_m12_id_caon_allnum as als_m3_m12_id_caon_allnum_rte
    ,als_m6_id_caon_allnum / als_m12_id_caon_allnum as als_m6_m12_id_caon_allnum_rte
    ,als_d7_id_rel_allnum / als_d15_id_rel_allnum as als_d7_d15_id_rel_allnum_rte
    ,als_d15_id_rel_allnum / als_m1_id_rel_allnum as als_d15_m1_id_rel_allnum_rte
    ,als_m1_id_rel_allnum / als_m3_id_rel_allnum as als_m1_m3_id_rel_allnum_rte
    ,als_m3_id_rel_allnum / als_m12_id_rel_allnum as als_m3_m12_id_rel_allnum_rte
    ,als_m6_id_rel_allnum / als_m12_id_rel_allnum as als_m6_m12_id_rel_allnum_rte
    ,als_d7_id_cooff_allnum / als_d15_id_cooff_allnum as als_d7_d15_id_cooff_allnum_rte
    ,als_d15_id_cooff_allnum / als_m1_id_cooff_allnum as als_d15_m1_id_cooff_allnum_rte
    ,als_m1_id_cooff_allnum / als_m3_id_cooff_allnum as als_m1_m3_id_cooff_allnum_rte
    ,als_m3_id_cooff_allnum / als_m12_id_cooff_allnum as als_m3_m12_id_cooff_allnum_rte
    ,als_m6_id_cooff_allnum / als_m12_id_cooff_allnum as als_m6_m12_id_cooff_allnum_rte
    ,als_d7_id_coon_allnum / als_d15_id_coon_allnum as als_d7_d15_id_coon_allnum_rte
    ,als_d15_id_coon_allnum / als_m1_id_coon_allnum as als_d15_m1_id_coon_allnum_rte
    ,als_m1_id_coon_allnum / als_m3_id_coon_allnum as als_m1_m3_id_coon_allnum_rte
    ,als_m3_id_coon_allnum / als_m12_id_coon_allnum as als_m3_m12_id_coon_allnum_rte
    ,als_m6_id_coon_allnum / als_m12_id_coon_allnum as als_m6_m12_id_coon_allnum_rte
    ,als_d7_id_oth_allnum / als_d15_id_oth_allnum as als_d7_d15_id_oth_allnum_rte
    ,als_d15_id_oth_allnum / als_m1_id_oth_allnum as als_d15_m1_id_oth_allnum_rte
    ,als_m1_id_oth_allnum / als_m3_id_oth_allnum as als_m1_m3_id_oth_allnum_rte
    ,als_m3_id_oth_allnum / als_m12_id_oth_allnum as als_m3_m12_id_oth_allnum_rte
    ,als_m6_id_oth_allnum / als_m12_id_oth_allnum as als_m6_m12_id_oth_allnum_rte
    ,als_d7_id_oth_orgnum / als_d15_id_oth_orgnum as als_d7_d15_id_oth_orgnum_rte
    ,als_d15_id_oth_orgnum / als_m1_id_oth_orgnum as als_d15_m1_id_oth_orgnum_rte
    ,als_m1_id_oth_orgnum / als_m3_id_oth_orgnum as als_m1_m3_id_oth_orgnum_rte
    ,als_m3_id_oth_orgnum / als_m12_id_oth_orgnum as als_m3_m12_id_oth_orgnum_rte
    ,als_m6_id_oth_orgnum / als_m12_id_oth_orgnum as als_m6_m12_id_oth_orgnum_rte
    ,als_d7_id_bank_selfnum / als_d15_id_bank_selfnum as als_d7_d15_id_bank_selfnum_rte
    ,als_d15_id_bank_selfnum / als_m1_id_bank_selfnum as als_d15_m1_id_bank_selfnum_rte
    ,als_m1_id_bank_selfnum / als_m3_id_bank_selfnum as als_m1_m3_id_bank_selfnum_rte
    ,als_m3_id_bank_selfnum / als_m12_id_bank_selfnum as als_m3_m12_id_bank_selfnum_rte
    ,als_m6_id_bank_selfnum / als_m12_id_bank_selfnum as als_m6_m12_id_bank_selfnum_rte
    ,als_d7_id_bank_allnum / als_d15_id_bank_allnum as als_d7_d15_id_bank_allnum_rte
    ,als_d15_id_bank_allnum / als_m1_id_bank_allnum as als_d15_m1_id_bank_allnum_rte
    ,als_m1_id_bank_allnum / als_m3_id_bank_allnum as als_m1_m3_id_bank_allnum_rte
    ,als_m3_id_bank_allnum / als_m12_id_bank_allnum as als_m3_m12_id_bank_allnum_rte
    ,als_m6_id_bank_allnum / als_m12_id_bank_allnum as als_m6_m12_id_bank_allnum_rte
    ,als_d7_id_bank_tra_allnum / als_d15_id_bank_tra_allnum as als_d7_d15_id_bank_tra_allnum_rte
    ,als_d15_id_bank_tra_allnum / als_m1_id_bank_tra_allnum as als_d15_m1_id_bank_tra_allnum_rte
    ,als_m1_id_bank_tra_allnum / als_m3_id_bank_tra_allnum as als_m1_m3_id_bank_tra_allnum_rte
    ,als_m3_id_bank_tra_allnum / als_m12_id_bank_tra_allnum as als_m3_m12_id_bank_tra_allnum_rte
    ,als_m6_id_bank_tra_allnum / als_m12_id_bank_tra_allnum as als_m6_m12_id_bank_tra_allnum_rte
    ,als_d7_id_bank_orgnum / als_d15_id_bank_orgnum as als_d7_d15_id_bank_orgnum_rte
    ,als_d15_id_bank_orgnum / als_m1_id_bank_orgnum as als_d15_m1_id_bank_orgnum_rte
    ,als_m1_id_bank_orgnum / als_m3_id_bank_orgnum as als_m1_m3_id_bank_orgnum_rte
    ,als_m3_id_bank_orgnum / als_m12_id_bank_orgnum as als_m3_m12_id_bank_orgnum_rte
    ,als_m6_id_bank_orgnum / als_m12_id_bank_orgnum as als_m6_m12_id_bank_orgnum_rte
    ,als_d7_id_bank_tra_orgnum / als_d15_id_bank_tra_orgnum as als_d7_d15_id_bank_tra_orgnum_rte
    ,als_d15_id_bank_tra_orgnum / als_m1_id_bank_tra_orgnum as als_d15_m1_id_bank_tra_orgnum_rte
    ,als_m1_id_bank_tra_orgnum / als_m3_id_bank_tra_orgnum as als_m1_m3_id_bank_tra_orgnum_rte
    ,als_m3_id_bank_tra_orgnum / als_m12_id_bank_tra_orgnum as als_m3_m12_id_bank_tra_orgnum_rte
    ,als_m6_id_bank_tra_orgnum / als_m12_id_bank_tra_orgnum as als_m6_m12_id_bank_tra_orgnum_rte
    ,als_d7_id_nbank_selfnum / als_d15_id_nbank_selfnum as als_d7_d15_id_nbank_selfnum_rte
    ,als_d15_id_nbank_selfnum / als_m1_id_nbank_selfnum as als_d15_m1_id_nbank_selfnum_rte
    ,als_m1_id_nbank_selfnum / als_m3_id_nbank_selfnum as als_m1_m3_id_nbank_selfnum_rte
    ,als_m3_id_nbank_selfnum / als_m12_id_nbank_selfnum as als_m3_m12_id_nbank_selfnum_rte
    ,als_m6_id_nbank_selfnum / als_m12_id_nbank_selfnum as als_m6_m12_id_nbank_selfnum_rte
    ,als_d7_id_nbank_allnum / als_d15_id_nbank_allnum as als_d7_d15_id_nbank_allnum_rte
    ,als_d15_id_nbank_allnum / als_m1_id_nbank_allnum as als_d15_m1_id_nbank_allnum_rte
    ,als_m1_id_nbank_allnum / als_m3_id_nbank_allnum as als_m1_m3_id_nbank_allnum_rte
    ,als_m3_id_nbank_allnum / als_m12_id_nbank_allnum as als_m3_m12_id_nbank_allnum_rte
    ,als_m6_id_nbank_allnum / als_m12_id_nbank_allnum as als_m6_m12_id_nbank_allnum_rte
    ,als_d7_id_nbank_mc_allnum / als_d15_id_nbank_mc_allnum as als_d7_d15_id_nbank_mc_allnum_rte
    ,als_d15_id_nbank_mc_allnum / als_m1_id_nbank_mc_allnum as als_d15_m1_id_nbank_mc_allnum_rte
    ,als_m1_id_nbank_mc_allnum / als_m3_id_nbank_mc_allnum as als_m1_m3_id_nbank_mc_allnum_rte
    ,als_m3_id_nbank_mc_allnum / als_m12_id_nbank_mc_allnum as als_m3_m12_id_nbank_mc_allnum_rte
    ,als_m6_id_nbank_mc_allnum / als_m12_id_nbank_mc_allnum as als_m6_m12_id_nbank_mc_allnum_rte
    ,als_d7_id_nbank_ca_allnum / als_d15_id_nbank_ca_allnum as als_d7_d15_id_nbank_ca_allnum_rte
    ,als_d15_id_nbank_ca_allnum / als_m1_id_nbank_ca_allnum as als_d15_m1_id_nbank_ca_allnum_rte
    ,als_m1_id_nbank_ca_allnum / als_m3_id_nbank_ca_allnum as als_m1_m3_id_nbank_ca_allnum_rte
    ,als_m3_id_nbank_ca_allnum / als_m12_id_nbank_ca_allnum as als_m3_m12_id_nbank_ca_allnum_rte
    ,als_m6_id_nbank_ca_allnum / als_m12_id_nbank_ca_allnum as als_m6_m12_id_nbank_ca_allnum_rte
    ,als_d7_id_nbank_cf_allnum / als_d15_id_nbank_cf_allnum as als_d7_d15_id_nbank_cf_allnum_rte
    ,als_d15_id_nbank_cf_allnum / als_m1_id_nbank_cf_allnum as als_d15_m1_id_nbank_cf_allnum_rte
    ,als_m1_id_nbank_cf_allnum / als_m3_id_nbank_cf_allnum as als_m1_m3_id_nbank_cf_allnum_rte
    ,als_m3_id_nbank_cf_allnum / als_m12_id_nbank_cf_allnum as als_m3_m12_id_nbank_cf_allnum_rte
    ,als_m6_id_nbank_cf_allnum / als_m12_id_nbank_cf_allnum as als_m6_m12_id_nbank_cf_allnum_rte
    ,als_d7_id_nbank_oth_allnum / als_d15_id_nbank_oth_allnum as als_d7_d15_id_nbank_oth_allnum_rte
    ,als_d15_id_nbank_oth_allnum / als_m1_id_nbank_oth_allnum as als_d15_m1_id_nbank_oth_allnum_rte
    ,als_m1_id_nbank_oth_allnum / als_m3_id_nbank_oth_allnum as als_m1_m3_id_nbank_oth_allnum_rte
    ,als_m3_id_nbank_oth_allnum / als_m12_id_nbank_oth_allnum as als_m3_m12_id_nbank_oth_allnum_rte
    ,als_m6_id_nbank_oth_allnum / als_m12_id_nbank_oth_allnum as als_m6_m12_id_nbank_oth_allnum_rte
    ,als_d7_id_nbank_nsloan_allnum / als_d15_id_nbank_nsloan_allnum as als_d7_d15_id_nbank_nsloan_allnum_rte
    ,als_d15_id_nbank_nsloan_allnum / als_m1_id_nbank_nsloan_allnum as als_d15_m1_id_nbank_nsloan_allnum_rte
    ,als_m1_id_nbank_nsloan_allnum / als_m3_id_nbank_nsloan_allnum as als_m1_m3_id_nbank_nsloan_allnum_rte
    ,als_m3_id_nbank_nsloan_allnum / als_m12_id_nbank_nsloan_allnum as als_m3_m12_id_nbank_nsloan_allnum_rte
    ,als_m6_id_nbank_nsloan_allnum / als_m12_id_nbank_nsloan_allnum as als_m6_m12_id_nbank_nsloan_allnum_rte
    ,als_d7_id_nbank_sloan_allnum / als_d15_id_nbank_sloan_allnum as als_d7_d15_id_nbank_sloan_allnum_rte
    ,als_d15_id_nbank_sloan_allnum / als_m1_id_nbank_sloan_allnum as als_d15_m1_id_nbank_sloan_allnum_rte
    ,als_m1_id_nbank_sloan_allnum / als_m3_id_nbank_sloan_allnum as als_m1_m3_id_nbank_sloan_allnum_rte
    ,als_m3_id_nbank_sloan_allnum / als_m12_id_nbank_sloan_allnum as als_m3_m12_id_nbank_sloan_allnum_rte
    ,als_m6_id_nbank_sloan_allnum / als_m12_id_nbank_sloan_allnum as als_m6_m12_id_nbank_sloan_allnum_rte
    ,als_d7_id_nbank_cons_allnum / als_d15_id_nbank_cons_allnum as als_d7_d15_id_nbank_cons_allnum_rte
    ,als_d15_id_nbank_cons_allnum / als_m1_id_nbank_cons_allnum as als_d15_m1_id_nbank_cons_allnum_rte
    ,als_m1_id_nbank_cons_allnum / als_m3_id_nbank_cons_allnum as als_m1_m3_id_nbank_cons_allnum_rte
    ,als_m3_id_nbank_cons_allnum / als_m12_id_nbank_cons_allnum as als_m3_m12_id_nbank_cons_allnum_rte
    ,als_m6_id_nbank_cons_allnum / als_m12_id_nbank_cons_allnum as als_m6_m12_id_nbank_cons_allnum_rte
    ,als_d7_id_nbank_else_allnum / als_d15_id_nbank_else_allnum as als_d7_d15_id_nbank_else_allnum_rte
    ,als_d15_id_nbank_else_allnum / als_m1_id_nbank_else_allnum as als_d15_m1_id_nbank_else_allnum_rte
    ,als_m1_id_nbank_else_allnum / als_m3_id_nbank_else_allnum as als_m1_m3_id_nbank_else_allnum_rte
    ,als_m3_id_nbank_else_allnum / als_m12_id_nbank_else_allnum as als_m3_m12_id_nbank_else_allnum_rte
    ,als_m6_id_nbank_else_allnum / als_m12_id_nbank_else_allnum as als_m6_m12_id_nbank_else_allnum_rte
    ,als_d7_id_nbank_orgnum / als_d15_id_nbank_orgnum as als_d7_d15_id_nbank_orgnum_rte
    ,als_d15_id_nbank_orgnum / als_m1_id_nbank_orgnum as als_d15_m1_id_nbank_orgnum_rte
    ,als_m1_id_nbank_orgnum / als_m3_id_nbank_orgnum as als_m1_m3_id_nbank_orgnum_rte
    ,als_m3_id_nbank_orgnum / als_m12_id_nbank_orgnum as als_m3_m12_id_nbank_orgnum_rte
    ,als_m6_id_nbank_orgnum / als_m12_id_nbank_orgnum as als_m6_m12_id_nbank_orgnum_rte
    ,als_d7_id_nbank_mc_orgnum / als_d15_id_nbank_mc_orgnum as als_d7_d15_id_nbank_mc_orgnum_rte
    ,als_d15_id_nbank_mc_orgnum / als_m1_id_nbank_mc_orgnum as als_d15_m1_id_nbank_mc_orgnum_rte
    ,als_m1_id_nbank_mc_orgnum / als_m3_id_nbank_mc_orgnum as als_m1_m3_id_nbank_mc_orgnum_rte
    ,als_m3_id_nbank_mc_orgnum / als_m12_id_nbank_mc_orgnum as als_m3_m12_id_nbank_mc_orgnum_rte
    ,als_m6_id_nbank_mc_orgnum / als_m12_id_nbank_mc_orgnum as als_m6_m12_id_nbank_mc_orgnum_rte
    ,als_d7_id_nbank_oth_orgnum / als_d15_id_nbank_oth_orgnum as als_d7_d15_id_nbank_oth_orgnum_rte
    ,als_d15_id_nbank_oth_orgnum / als_m1_id_nbank_oth_orgnum as als_d15_m1_id_nbank_oth_orgnum_rte
    ,als_m1_id_nbank_oth_orgnum / als_m3_id_nbank_oth_orgnum as als_m1_m3_id_nbank_oth_orgnum_rte
    ,als_m3_id_nbank_oth_orgnum / als_m12_id_nbank_oth_orgnum as als_m3_m12_id_nbank_oth_orgnum_rte
    ,als_m6_id_nbank_oth_orgnum / als_m12_id_nbank_oth_orgnum as als_m6_m12_id_nbank_oth_orgnum_rte
    ,als_d7_id_nbank_nsloan_orgnum / als_d15_id_nbank_nsloan_orgnum as als_d7_d15_id_nbank_nsloan_orgnum_rte
    ,als_d15_id_nbank_nsloan_orgnum / als_m1_id_nbank_nsloan_orgnum as als_d15_m1_id_nbank_nsloan_orgnum_rte
    ,als_m1_id_nbank_nsloan_orgnum / als_m3_id_nbank_nsloan_orgnum as als_m1_m3_id_nbank_nsloan_orgnum_rte
    ,als_m3_id_nbank_nsloan_orgnum / als_m12_id_nbank_nsloan_orgnum as als_m3_m12_id_nbank_nsloan_orgnum_rte
    ,als_m6_id_nbank_nsloan_orgnum / als_m12_id_nbank_nsloan_orgnum as als_m6_m12_id_nbank_nsloan_orgnum_rte
    ,als_d7_id_nbank_else_orgnum / als_d15_id_nbank_else_orgnum as als_d7_d15_id_nbank_else_orgnum_rte
    ,als_d15_id_nbank_else_orgnum / als_m1_id_nbank_else_orgnum as als_d15_m1_id_nbank_else_orgnum_rte
    ,als_m1_id_nbank_else_orgnum / als_m3_id_nbank_else_orgnum as als_m1_m3_id_nbank_else_orgnum_rte
    ,als_m3_id_nbank_else_orgnum / als_m12_id_nbank_else_orgnum as als_m3_m12_id_nbank_else_orgnum_rte
    ,als_m6_id_nbank_else_orgnum / als_m12_id_nbank_else_orgnum as als_m6_m12_id_nbank_else_orgnum_rte
    ,als_d7_id_nbank_week_allnum / als_d15_id_nbank_week_allnum as als_d7_d15_id_nbank_week_allnum_rte
    ,als_d15_id_nbank_week_allnum / als_m1_id_nbank_week_allnum as als_d15_m1_id_nbank_week_allnum_rte
    ,als_m1_id_nbank_week_allnum / als_m3_id_nbank_week_allnum as als_m1_m3_id_nbank_week_allnum_rte
    ,als_m3_id_nbank_week_allnum / als_m12_id_nbank_week_allnum as als_m3_m12_id_nbank_week_allnum_rte
    ,als_m6_id_nbank_week_allnum / als_m12_id_nbank_week_allnum as als_m6_m12_id_nbank_week_allnum_rte
    ,als_d7_id_nbank_week_orgnum / als_d15_id_nbank_week_orgnum as als_d7_d15_id_nbank_week_orgnum_rte
    ,als_d15_id_nbank_week_orgnum / als_m1_id_nbank_week_orgnum as als_d15_m1_id_nbank_week_orgnum_rte
    ,als_m1_id_nbank_week_orgnum / als_m3_id_nbank_week_orgnum as als_m1_m3_id_nbank_week_orgnum_rte
    ,als_m3_id_nbank_week_orgnum / als_m12_id_nbank_week_orgnum as als_m3_m12_id_nbank_week_orgnum_rte
    ,als_m6_id_nbank_week_orgnum / als_m12_id_nbank_week_orgnum as als_m6_m12_id_nbank_week_orgnum_rte
    ,als_d7_id_nbank_night_allnum / als_d15_id_nbank_night_allnum as als_d7_d15_id_nbank_night_allnum_rte
    ,als_d15_id_nbank_night_allnum / als_m1_id_nbank_night_allnum as als_d15_m1_id_nbank_night_allnum_rte
    ,als_m1_id_nbank_night_allnum / als_m3_id_nbank_night_allnum as als_m1_m3_id_nbank_night_allnum_rte
    ,als_m3_id_nbank_night_allnum / als_m12_id_nbank_night_allnum as als_m3_m12_id_nbank_night_allnum_rte
    ,als_m6_id_nbank_night_allnum / als_m12_id_nbank_night_allnum as als_m6_m12_id_nbank_night_allnum_rte
    ,als_d7_id_nbank_night_orgnum / als_d15_id_nbank_night_orgnum as als_d7_d15_id_nbank_night_orgnum_rte
    ,als_d15_id_nbank_night_orgnum / als_m1_id_nbank_night_orgnum as als_d15_m1_id_nbank_night_orgnum_rte
    ,als_m1_id_nbank_night_orgnum / als_m3_id_nbank_night_orgnum as als_m1_m3_id_nbank_night_orgnum_rte
    ,als_m3_id_nbank_night_orgnum / als_m12_id_nbank_night_orgnum as als_m3_m12_id_nbank_night_orgnum_rte
    ,als_m6_id_nbank_night_orgnum / als_m12_id_nbank_night_orgnum as als_m6_m12_id_nbank_night_orgnum_rte

    ,als_d7_id_pdl_allnum / als_d7_d15_id_pdl_allnum as als_d7_d7_d15_id_pdl_allnum_rte
    ,als_d15_id_pdl_allnum / als_d15_m1_id_pdl_allnum as als_d15_d15_m1_id_pdl_allnum_rte
    ,als_m1_id_pdl_allnum / als_m1_m3_id_pdl_allnum as als_m1_m1_m3_id_pdl_allnum_rte
    ,als_m3_id_pdl_allnum / als_m6_m12_id_pdl_allnum as als_m3_m6_m12_id_pdl_allnum_rte
    ,als_m6_id_pdl_allnum / als_m6_m12_id_pdl_allnum as als_m6_m6_m12_id_pdl_allnum_rte
    ,als_d7_id_pdl_orgnum / als_d7_d15_id_pdl_orgnum as als_d7_d7_d15_id_pdl_orgnum_rte
    ,als_d15_id_pdl_orgnum / als_d15_m1_id_pdl_orgnum as als_d15_d15_m1_id_pdl_orgnum_rte
    ,als_m1_id_pdl_orgnum / als_m1_m3_id_pdl_orgnum as als_m1_m1_m3_id_pdl_orgnum_rte
    ,als_m3_id_pdl_orgnum / als_m6_m12_id_pdl_orgnum as als_m3_m6_m12_id_pdl_orgnum_rte
    ,als_m6_id_pdl_orgnum / als_m6_m12_id_pdl_orgnum as als_m6_m6_m12_id_pdl_orgnum_rte
    ,als_d7_id_caon_allnum / als_d7_d15_id_caon_allnum as als_d7_d7_d15_id_caon_allnum_rte
    ,als_d15_id_caon_allnum / als_d15_m1_id_caon_allnum as als_d15_d15_m1_id_caon_allnum_rte
    ,als_m1_id_caon_allnum / als_m1_m3_id_caon_allnum as als_m1_m1_m3_id_caon_allnum_rte
    ,als_m3_id_caon_allnum / als_m6_m12_id_caon_allnum as als_m3_m6_m12_id_caon_allnum_rte
    ,als_m6_id_caon_allnum / als_m6_m12_id_caon_allnum as als_m6_m6_m12_id_caon_allnum_rte
    ,als_d7_id_rel_allnum / als_d7_d15_id_rel_allnum as als_d7_d7_d15_id_rel_allnum_rte
    ,als_d15_id_rel_allnum / als_d15_m1_id_rel_allnum as als_d15_d15_m1_id_rel_allnum_rte
    ,als_m1_id_rel_allnum / als_m1_m3_id_rel_allnum as als_m1_m1_m3_id_rel_allnum_rte
    ,als_m3_id_rel_allnum / als_m6_m12_id_rel_allnum as als_m3_m6_m12_id_rel_allnum_rte
    ,als_m6_id_rel_allnum / als_m6_m12_id_rel_allnum as als_m6_m6_m12_id_rel_allnum_rte
    ,als_d7_id_cooff_allnum / als_d7_d15_id_cooff_allnum as als_d7_d7_d15_id_cooff_allnum_rte
    ,als_d15_id_cooff_allnum / als_d15_m1_id_cooff_allnum as als_d15_d15_m1_id_cooff_allnum_rte
    ,als_m1_id_cooff_allnum / als_m1_m3_id_cooff_allnum as als_m1_m1_m3_id_cooff_allnum_rte
    ,als_m3_id_cooff_allnum / als_m6_m12_id_cooff_allnum as als_m3_m6_m12_id_cooff_allnum_rte
    ,als_m6_id_cooff_allnum / als_m6_m12_id_cooff_allnum as als_m6_m6_m12_id_cooff_allnum_rte
    ,als_d7_id_coon_allnum / als_d7_d15_id_coon_allnum as als_d7_d7_d15_id_coon_allnum_rte
    ,als_d15_id_coon_allnum / als_d15_m1_id_coon_allnum as als_d15_d15_m1_id_coon_allnum_rte
    ,als_m1_id_coon_allnum / als_m1_m3_id_coon_allnum as als_m1_m1_m3_id_coon_allnum_rte
    ,als_m3_id_coon_allnum / als_m6_m12_id_coon_allnum as als_m3_m6_m12_id_coon_allnum_rte
    ,als_m6_id_coon_allnum / als_m6_m12_id_coon_allnum as als_m6_m6_m12_id_coon_allnum_rte
    ,als_d7_id_oth_allnum / als_d7_d15_id_oth_allnum as als_d7_d7_d15_id_oth_allnum_rte
    ,als_d15_id_oth_allnum / als_d15_m1_id_oth_allnum as als_d15_d15_m1_id_oth_allnum_rte
    ,als_m1_id_oth_allnum / als_m1_m3_id_oth_allnum as als_m1_m1_m3_id_oth_allnum_rte
    ,als_m3_id_oth_allnum / als_m6_m12_id_oth_allnum as als_m3_m6_m12_id_oth_allnum_rte
    ,als_m6_id_oth_allnum / als_m6_m12_id_oth_allnum as als_m6_m6_m12_id_oth_allnum_rte
    ,als_d7_id_oth_orgnum / als_d7_d15_id_oth_orgnum as als_d7_d7_d15_id_oth_orgnum_rte
    ,als_d15_id_oth_orgnum / als_d15_m1_id_oth_orgnum as als_d15_d15_m1_id_oth_orgnum_rte
    ,als_m1_id_oth_orgnum / als_m1_m3_id_oth_orgnum as als_m1_m1_m3_id_oth_orgnum_rte
    ,als_m3_id_oth_orgnum / als_m6_m12_id_oth_orgnum as als_m3_m6_m12_id_oth_orgnum_rte
    ,als_m6_id_oth_orgnum / als_m6_m12_id_oth_orgnum as als_m6_m6_m12_id_oth_orgnum_rte
    ,als_d7_id_bank_selfnum / als_d7_d15_id_bank_selfnum as als_d7_d7_d15_id_bank_selfnum_rte
    ,als_d15_id_bank_selfnum / als_d15_m1_id_bank_selfnum as als_d15_d15_m1_id_bank_selfnum_rte
    ,als_m1_id_bank_selfnum / als_m1_m3_id_bank_selfnum as als_m1_m1_m3_id_bank_selfnum_rte
    ,als_m3_id_bank_selfnum / als_m6_m12_id_bank_selfnum as als_m3_m6_m12_id_bank_selfnum_rte
    ,als_m6_id_bank_selfnum / als_m6_m12_id_bank_selfnum as als_m6_m6_m12_id_bank_selfnum_rte
    ,als_d7_id_bank_allnum / als_d7_d15_id_bank_allnum as als_d7_d7_d15_id_bank_allnum_rte
    ,als_d15_id_bank_allnum / als_d15_m1_id_bank_allnum as als_d15_d15_m1_id_bank_allnum_rte
    ,als_m1_id_bank_allnum / als_m1_m3_id_bank_allnum as als_m1_m1_m3_id_bank_allnum_rte
    ,als_m3_id_bank_allnum / als_m6_m12_id_bank_allnum as als_m3_m6_m12_id_bank_allnum_rte
    ,als_m6_id_bank_allnum / als_m6_m12_id_bank_allnum as als_m6_m6_m12_id_bank_allnum_rte
    ,als_d7_id_bank_tra_allnum / als_d7_d15_id_bank_tra_allnum as als_d7_d7_d15_id_bank_tra_allnum_rte
    ,als_d15_id_bank_tra_allnum / als_d15_m1_id_bank_tra_allnum as als_d15_d15_m1_id_bank_tra_allnum_rte
    ,als_m1_id_bank_tra_allnum / als_m1_m3_id_bank_tra_allnum as als_m1_m1_m3_id_bank_tra_allnum_rte
    ,als_m3_id_bank_tra_allnum / als_m6_m12_id_bank_tra_allnum as als_m3_m6_m12_id_bank_tra_allnum_rte
    ,als_m6_id_bank_tra_allnum / als_m6_m12_id_bank_tra_allnum as als_m6_m6_m12_id_bank_tra_allnum_rte
    ,als_d7_id_bank_orgnum / als_d7_d15_id_bank_orgnum as als_d7_d7_d15_id_bank_orgnum_rte
    ,als_d15_id_bank_orgnum / als_d15_m1_id_bank_orgnum as als_d15_d15_m1_id_bank_orgnum_rte
    ,als_m1_id_bank_orgnum / als_m1_m3_id_bank_orgnum as als_m1_m1_m3_id_bank_orgnum_rte
    ,als_m3_id_bank_orgnum / als_m6_m12_id_bank_orgnum as als_m3_m6_m12_id_bank_orgnum_rte
    ,als_m6_id_bank_orgnum / als_m6_m12_id_bank_orgnum as als_m6_m6_m12_id_bank_orgnum_rte
    ,als_d7_id_bank_tra_orgnum / als_d7_d15_id_bank_tra_orgnum as als_d7_d7_d15_id_bank_tra_orgnum_rte
    ,als_d15_id_bank_tra_orgnum / als_d15_m1_id_bank_tra_orgnum as als_d15_d15_m1_id_bank_tra_orgnum_rte
    ,als_m1_id_bank_tra_orgnum / als_m1_m3_id_bank_tra_orgnum as als_m1_m1_m3_id_bank_tra_orgnum_rte
    ,als_m3_id_bank_tra_orgnum / als_m6_m12_id_bank_tra_orgnum as als_m3_m6_m12_id_bank_tra_orgnum_rte
    ,als_m6_id_bank_tra_orgnum / als_m6_m12_id_bank_tra_orgnum as als_m6_m6_m12_id_bank_tra_orgnum_rte
    ,als_d7_id_nbank_selfnum / als_d7_d15_id_nbank_selfnum as als_d7_d7_d15_id_nbank_selfnum_rte
    ,als_d15_id_nbank_selfnum / als_d15_m1_id_nbank_selfnum as als_d15_d15_m1_id_nbank_selfnum_rte
    ,als_m1_id_nbank_selfnum / als_m1_m3_id_nbank_selfnum as als_m1_m1_m3_id_nbank_selfnum_rte
    ,als_m3_id_nbank_selfnum / als_m6_m12_id_nbank_selfnum as als_m3_m6_m12_id_nbank_selfnum_rte
    ,als_m6_id_nbank_selfnum / als_m6_m12_id_nbank_selfnum as als_m6_m6_m12_id_nbank_selfnum_rte
    ,als_d7_id_nbank_allnum / als_d7_d15_id_nbank_allnum as als_d7_d7_d15_id_nbank_allnum_rte
    ,als_d15_id_nbank_allnum / als_d15_m1_id_nbank_allnum as als_d15_d15_m1_id_nbank_allnum_rte
    ,als_m1_id_nbank_allnum / als_m1_m3_id_nbank_allnum as als_m1_m1_m3_id_nbank_allnum_rte
    ,als_m3_id_nbank_allnum / als_m6_m12_id_nbank_allnum as als_m3_m6_m12_id_nbank_allnum_rte
    ,als_m6_id_nbank_allnum / als_m6_m12_id_nbank_allnum as als_m6_m6_m12_id_nbank_allnum_rte
    ,als_d7_id_nbank_mc_allnum / als_d7_d15_id_nbank_mc_allnum as als_d7_d7_d15_id_nbank_mc_allnum_rte
    ,als_d15_id_nbank_mc_allnum / als_d15_m1_id_nbank_mc_allnum as als_d15_d15_m1_id_nbank_mc_allnum_rte
    ,als_m1_id_nbank_mc_allnum / als_m1_m3_id_nbank_mc_allnum as als_m1_m1_m3_id_nbank_mc_allnum_rte
    ,als_m3_id_nbank_mc_allnum / als_m6_m12_id_nbank_mc_allnum as als_m3_m6_m12_id_nbank_mc_allnum_rte
    ,als_m6_id_nbank_mc_allnum / als_m6_m12_id_nbank_mc_allnum as als_m6_m6_m12_id_nbank_mc_allnum_rte
    ,als_d7_id_nbank_ca_allnum / als_d7_d15_id_nbank_ca_allnum as als_d7_d7_d15_id_nbank_ca_allnum_rte
    ,als_d15_id_nbank_ca_allnum / als_d15_m1_id_nbank_ca_allnum as als_d15_d15_m1_id_nbank_ca_allnum_rte
    ,als_m1_id_nbank_ca_allnum / als_m1_m3_id_nbank_ca_allnum as als_m1_m1_m3_id_nbank_ca_allnum_rte
    ,als_m3_id_nbank_ca_allnum / als_m6_m12_id_nbank_ca_allnum as als_m3_m6_m12_id_nbank_ca_allnum_rte
    ,als_m6_id_nbank_ca_allnum / als_m6_m12_id_nbank_ca_allnum as als_m6_m6_m12_id_nbank_ca_allnum_rte
    ,als_d7_id_nbank_cf_allnum / als_d7_d15_id_nbank_cf_allnum as als_d7_d7_d15_id_nbank_cf_allnum_rte
    ,als_d15_id_nbank_cf_allnum / als_d15_m1_id_nbank_cf_allnum as als_d15_d15_m1_id_nbank_cf_allnum_rte
    ,als_m1_id_nbank_cf_allnum / als_m1_m3_id_nbank_cf_allnum as als_m1_m1_m3_id_nbank_cf_allnum_rte
    ,als_m3_id_nbank_cf_allnum / als_m6_m12_id_nbank_cf_allnum as als_m3_m6_m12_id_nbank_cf_allnum_rte
    ,als_m6_id_nbank_cf_allnum / als_m6_m12_id_nbank_cf_allnum as als_m6_m6_m12_id_nbank_cf_allnum_rte
    ,als_d7_id_nbank_oth_allnum / als_d7_d15_id_nbank_oth_allnum as als_d7_d7_d15_id_nbank_oth_allnum_rte
    ,als_d15_id_nbank_oth_allnum / als_d15_m1_id_nbank_oth_allnum as als_d15_d15_m1_id_nbank_oth_allnum_rte
    ,als_m1_id_nbank_oth_allnum / als_m1_m3_id_nbank_oth_allnum as als_m1_m1_m3_id_nbank_oth_allnum_rte
    ,als_m3_id_nbank_oth_allnum / als_m6_m12_id_nbank_oth_allnum as als_m3_m6_m12_id_nbank_oth_allnum_rte
    ,als_m6_id_nbank_oth_allnum / als_m6_m12_id_nbank_oth_allnum as als_m6_m6_m12_id_nbank_oth_allnum_rte
    ,als_d7_id_nbank_nsloan_allnum / als_d7_d15_id_nbank_nsloan_allnum as als_d7_d7_d15_id_nbank_nsloan_allnum_rte
    ,als_d15_id_nbank_nsloan_allnum / als_d15_m1_id_nbank_nsloan_allnum as als_d15_d15_m1_id_nbank_nsloan_allnum_rte
    ,als_m1_id_nbank_nsloan_allnum / als_m1_m3_id_nbank_nsloan_allnum as als_m1_m1_m3_id_nbank_nsloan_allnum_rte
    ,als_m3_id_nbank_nsloan_allnum / als_m6_m12_id_nbank_nsloan_allnum as als_m3_m6_m12_id_nbank_nsloan_allnum_rte
    ,als_m6_id_nbank_nsloan_allnum / als_m6_m12_id_nbank_nsloan_allnum as als_m6_m6_m12_id_nbank_nsloan_allnum_rte
    ,als_d7_id_nbank_sloan_allnum / als_d7_d15_id_nbank_sloan_allnum as als_d7_d7_d15_id_nbank_sloan_allnum_rte
    ,als_d15_id_nbank_sloan_allnum / als_d15_m1_id_nbank_sloan_allnum as als_d15_d15_m1_id_nbank_sloan_allnum_rte
    ,als_m1_id_nbank_sloan_allnum / als_m1_m3_id_nbank_sloan_allnum as als_m1_m1_m3_id_nbank_sloan_allnum_rte
    ,als_m3_id_nbank_sloan_allnum / als_m6_m12_id_nbank_sloan_allnum as als_m3_m6_m12_id_nbank_sloan_allnum_rte
    ,als_m6_id_nbank_sloan_allnum / als_m6_m12_id_nbank_sloan_allnum as als_m6_m6_m12_id_nbank_sloan_allnum_rte
    ,als_d7_id_nbank_cons_allnum / als_d7_d15_id_nbank_cons_allnum as als_d7_d7_d15_id_nbank_cons_allnum_rte
    ,als_d15_id_nbank_cons_allnum / als_d15_m1_id_nbank_cons_allnum as als_d15_d15_m1_id_nbank_cons_allnum_rte
    ,als_m1_id_nbank_cons_allnum / als_m1_m3_id_nbank_cons_allnum as als_m1_m1_m3_id_nbank_cons_allnum_rte
    ,als_m3_id_nbank_cons_allnum / als_m6_m12_id_nbank_cons_allnum as als_m3_m6_m12_id_nbank_cons_allnum_rte
    ,als_m6_id_nbank_cons_allnum / als_m6_m12_id_nbank_cons_allnum as als_m6_m6_m12_id_nbank_cons_allnum_rte
    ,als_d7_id_nbank_else_allnum / als_d7_d15_id_nbank_else_allnum as als_d7_d7_d15_id_nbank_else_allnum_rte
    ,als_d15_id_nbank_else_allnum / als_d15_m1_id_nbank_else_allnum as als_d15_d15_m1_id_nbank_else_allnum_rte
    ,als_m1_id_nbank_else_allnum / als_m1_m3_id_nbank_else_allnum as als_m1_m1_m3_id_nbank_else_allnum_rte
    ,als_m3_id_nbank_else_allnum / als_m6_m12_id_nbank_else_allnum as als_m3_m6_m12_id_nbank_else_allnum_rte
    ,als_m6_id_nbank_else_allnum / als_m6_m12_id_nbank_else_allnum as als_m6_m6_m12_id_nbank_else_allnum_rte
    ,als_d7_id_nbank_orgnum / als_d7_d15_id_nbank_orgnum as als_d7_d7_d15_id_nbank_orgnum_rte
    ,als_d15_id_nbank_orgnum / als_d15_m1_id_nbank_orgnum as als_d15_d15_m1_id_nbank_orgnum_rte
    ,als_m1_id_nbank_orgnum / als_m1_m3_id_nbank_orgnum as als_m1_m1_m3_id_nbank_orgnum_rte
    ,als_m3_id_nbank_orgnum / als_m6_m12_id_nbank_orgnum as als_m3_m6_m12_id_nbank_orgnum_rte
    ,als_m6_id_nbank_orgnum / als_m6_m12_id_nbank_orgnum as als_m6_m6_m12_id_nbank_orgnum_rte
    ,als_d7_id_nbank_mc_orgnum / als_d7_d15_id_nbank_mc_orgnum as als_d7_d7_d15_id_nbank_mc_orgnum_rte
    ,als_d15_id_nbank_mc_orgnum / als_d15_m1_id_nbank_mc_orgnum as als_d15_d15_m1_id_nbank_mc_orgnum_rte
    ,als_m1_id_nbank_mc_orgnum / als_m1_m3_id_nbank_mc_orgnum as als_m1_m1_m3_id_nbank_mc_orgnum_rte
    ,als_m3_id_nbank_mc_orgnum / als_m6_m12_id_nbank_mc_orgnum as als_m3_m6_m12_id_nbank_mc_orgnum_rte
    ,als_m6_id_nbank_mc_orgnum / als_m6_m12_id_nbank_mc_orgnum as als_m6_m6_m12_id_nbank_mc_orgnum_rte
    ,als_d7_id_nbank_oth_orgnum / als_d7_d15_id_nbank_oth_orgnum as als_d7_d7_d15_id_nbank_oth_orgnum_rte
    ,als_d15_id_nbank_oth_orgnum / als_d15_m1_id_nbank_oth_orgnum as als_d15_d15_m1_id_nbank_oth_orgnum_rte
    ,als_m1_id_nbank_oth_orgnum / als_m1_m3_id_nbank_oth_orgnum as als_m1_m1_m3_id_nbank_oth_orgnum_rte
    ,als_m3_id_nbank_oth_orgnum / als_m6_m12_id_nbank_oth_orgnum as als_m3_m6_m12_id_nbank_oth_orgnum_rte
    ,als_m6_id_nbank_oth_orgnum / als_m6_m12_id_nbank_oth_orgnum as als_m6_m6_m12_id_nbank_oth_orgnum_rte
    ,als_d7_id_nbank_nsloan_orgnum / als_d7_d15_id_nbank_nsloan_orgnum as als_d7_d7_d15_id_nbank_nsloan_orgnum_rte
    ,als_d15_id_nbank_nsloan_orgnum / als_d15_m1_id_nbank_nsloan_orgnum as als_d15_d15_m1_id_nbank_nsloan_orgnum_rte
    ,als_m1_id_nbank_nsloan_orgnum / als_m1_m3_id_nbank_nsloan_orgnum as als_m1_m1_m3_id_nbank_nsloan_orgnum_rte
    ,als_m3_id_nbank_nsloan_orgnum / als_m6_m12_id_nbank_nsloan_orgnum as als_m3_m6_m12_id_nbank_nsloan_orgnum_rte
    ,als_m6_id_nbank_nsloan_orgnum / als_m6_m12_id_nbank_nsloan_orgnum as als_m6_m6_m12_id_nbank_nsloan_orgnum_rte
    ,als_d7_id_nbank_else_orgnum / als_d7_d15_id_nbank_else_orgnum as als_d7_d7_d15_id_nbank_else_orgnum_rte
    ,als_d15_id_nbank_else_orgnum / als_d15_m1_id_nbank_else_orgnum as als_d15_d15_m1_id_nbank_else_orgnum_rte
    ,als_m1_id_nbank_else_orgnum / als_m1_m3_id_nbank_else_orgnum as als_m1_m1_m3_id_nbank_else_orgnum_rte
    ,als_m3_id_nbank_else_orgnum / als_m6_m12_id_nbank_else_orgnum as als_m3_m6_m12_id_nbank_else_orgnum_rte
    ,als_m6_id_nbank_else_orgnum / als_m6_m12_id_nbank_else_orgnum as als_m6_m6_m12_id_nbank_else_orgnum_rte
    ,als_d7_id_nbank_week_allnum / als_d7_d15_id_nbank_week_allnum as als_d7_d7_d15_id_nbank_week_allnum_rte
    ,als_d15_id_nbank_week_allnum / als_d15_m1_id_nbank_week_allnum as als_d15_d15_m1_id_nbank_week_allnum_rte
    ,als_m1_id_nbank_week_allnum / als_m1_m3_id_nbank_week_allnum as als_m1_m1_m3_id_nbank_week_allnum_rte
    ,als_m3_id_nbank_week_allnum / als_m6_m12_id_nbank_week_allnum as als_m3_m6_m12_id_nbank_week_allnum_rte
    ,als_m6_id_nbank_week_allnum / als_m6_m12_id_nbank_week_allnum as als_m6_m6_m12_id_nbank_week_allnum_rte
    ,als_d7_id_nbank_week_orgnum / als_d7_d15_id_nbank_week_orgnum as als_d7_d7_d15_id_nbank_week_orgnum_rte
    ,als_d15_id_nbank_week_orgnum / als_d15_m1_id_nbank_week_orgnum as als_d15_d15_m1_id_nbank_week_orgnum_rte
    ,als_m1_id_nbank_week_orgnum / als_m1_m3_id_nbank_week_orgnum as als_m1_m1_m3_id_nbank_week_orgnum_rte
    ,als_m3_id_nbank_week_orgnum / als_m6_m12_id_nbank_week_orgnum as als_m3_m6_m12_id_nbank_week_orgnum_rte
    ,als_m6_id_nbank_week_orgnum / als_m6_m12_id_nbank_week_orgnum as als_m6_m6_m12_id_nbank_week_orgnum_rte
    ,als_d7_id_nbank_night_allnum / als_d7_d15_id_nbank_night_allnum as als_d7_d7_d15_id_nbank_night_allnum_rte
    ,als_d15_id_nbank_night_allnum / als_d15_m1_id_nbank_night_allnum as als_d15_d15_m1_id_nbank_night_allnum_rte
    ,als_m1_id_nbank_night_allnum / als_m1_m3_id_nbank_night_allnum as als_m1_m1_m3_id_nbank_night_allnum_rte
    ,als_m3_id_nbank_night_allnum / als_m6_m12_id_nbank_night_allnum as als_m3_m6_m12_id_nbank_night_allnum_rte
    ,als_m6_id_nbank_night_allnum / als_m6_m12_id_nbank_night_allnum as als_m6_m6_m12_id_nbank_night_allnum_rte
    ,als_d7_id_nbank_night_orgnum / als_d7_d15_id_nbank_night_orgnum as als_d7_d7_d15_id_nbank_night_orgnum_rte
    ,als_d15_id_nbank_night_orgnum / als_d15_m1_id_nbank_night_orgnum as als_d15_d15_m1_id_nbank_night_orgnum_rte
    ,als_m1_id_nbank_night_orgnum / als_m1_m3_id_nbank_night_orgnum as als_m1_m1_m3_id_nbank_night_orgnum_rte
    ,als_m3_id_nbank_night_orgnum / als_m6_m12_id_nbank_night_orgnum as als_m3_m6_m12_id_nbank_night_orgnum_rte
    ,als_m6_id_nbank_night_orgnum / als_m6_m12_id_nbank_night_orgnum as als_m6_m6_m12_id_nbank_night_orgnum_rte

    ,data_id
    ,code
    ,flag_applyloanstr
    ,swift_number
    ,created_at
    ,updated_at
    ,current_timestamp() as rcd_tim
from ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_tmp;
-- feature-copilot:node-end ordinal=0
