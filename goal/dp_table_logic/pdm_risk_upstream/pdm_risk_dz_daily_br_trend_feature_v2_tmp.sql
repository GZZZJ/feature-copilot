-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_daily_br_trend_feature_v2_tmp
-- node_id: n_3771988438551298048
-- task_name: pdm_risk_dz_daily_br_trend_feature_v2
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dz_daily_br_trend_feature_v2_tmp.json
-- source_json_sha256: 1c78838db0f02943643b1696666f4650f4b2bc4da531073022d547298d297b75
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_trend_feature_v2_tmp
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_cast_float_feature

--MaxCompute_SQL
--********************************************************************--
--所属主题: 贷中模型变量通用调度
--功能描述: 百融多头变量通用逻辑, 趋势变量v2, 每日查询样本更新, 贷前贷中两张表union
--创建者: 周志华
--创建日期: 2022-06-22 18:11:21
--修改日期	修改人	修改内容
--20220622	周志华	初始化
--********************************************************************--

-- create table ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_v2
-- (
--     uid string comment '用户ID',
    
--     als_least_id_pdl_orgnum float comment "按身份证号查询，申请线上小额现金贷的机构数_距离首次查得时间",
--     als_least_id_caon_orgnum float comment "按身份证号查询，申请线上现金分期的机构数_距离首次查得时间",
--     als_least_id_rel_orgnum float comment "按身份证号查询，申请信用卡（类信用卡）的机构数_距离首次查得时间",
--     als_least_id_caoff_orgnum float comment "按身份证号查询，申请线下现金分期的机构数_距离首次查得时间",
--     als_least_id_cooff_orgnum float comment "按身份证号查询，申请线下消费分期的机构数_距离首次查得时间",
--     als_least_id_af_orgnum float comment "按身份证号查询，申请汽车金融的机构数_距离首次查得时间",
--     als_least_id_coon_orgnum float comment "按身份证号查询，申请线上消费分期的机构数_距离首次查得时间",
--     als_least_id_oth_orgnum float comment "按身份证号查询，申请其他的机构数_距离首次查得时间",
--     als_least_id_bank_orgnum float comment "按身份证号查询，在银行机构申请机构数_距离首次查得时间",
--     als_least_id_bank_tra_orgnum float comment "按身份证号查询，在银行机构-传统银行申请机构数_距离首次查得时间",
--     als_least_id_bank_ret_orgnum float comment "按身份证号查询，在银行机构-网络零售银行申请机构数_距离首次查得时间",
--     als_least_id_bank_week_orgnum float comment "按身份证号查询，在银行机构周末申请机构数_距离首次查得时间",
--     als_least_id_bank_night_orgnum float comment "按身份证号查询，在银行机构夜间申请机构数_距离首次查得时间",
--     als_least_id_nbank_orgnum float comment "按身份证号查询，在非银机构申请机构数_距离首次查得时间",
--     als_least_id_nbank_p2p_orgnum float comment "按身份证号查询，在非银机构-p2p申请机构数_距离首次查得时间",
--     als_least_id_nbank_mc_orgnum float comment "按身份证号查询，在非银机构-小贷申请机构数_距离首次查得时间",
--     als_least_id_nbank_ca_orgnum float comment "按身份证号查询，在非银机构-现金类分期申请机构数_距离首次查得时间",
--     als_least_id_nbank_cf_orgnum float comment "按身份证号查询，在非银机构-消费类分期申请机构数_距离首次查得时间",
--     als_least_id_nbank_com_orgnum float comment "按身份证号查询，在非银机构-代偿类分期申请机构数_距离首次查得时间",
--     als_least_id_nbank_oth_orgnum float comment "按身份证号查询，在非银机构-其他申请机构数_距离首次查得时间",
--     als_least_id_nbank_nsloan_orgnum float comment "按身份证号查询，在非银机构-持牌网络小贷机构申请机构数_距离首次查得时间",
--     als_least_id_nbank_autofin_orgnum float comment "按身份证号查询，在非银机构-持牌汽车金融机构申请机构数_距离首次查得时间",
--     als_least_id_nbank_sloan_orgnum float comment "按身份证号查询，在非银机构-持牌小贷机构申请机构数_距离首次查得时间",
--     als_least_id_nbank_cons_orgnum float comment "按身份证号查询，在非银机构-持牌消费金融机构申请机构数_距离首次查得时间",
--     als_least_id_nbank_finlea_orgnum float comment "按身份证号查询，在非银机构-持牌融资租赁机构申请机构数_距离首次查得时间",
--     als_least_id_nbank_else_orgnum float comment "按身份证号查询，在非银机构-其他申请机构数_距离首次查得时间",
--     als_least_id_nbank_week_orgnum float comment "按身份证号查询，在非银机构周末申请机构数_距离首次查得时间",
--     als_least_id_nbank_night_orgnum float comment "按身份证号查询，在非银机构夜间申请机构数_距离首次查得时间",
--     als_greast_id_pdl_orgnum float comment "按身份证号查询，申请线上小额现金贷的机构数_距离首次查询时间",
--     als_greast_id_caon_orgnum float comment "按身份证号查询，申请线上现金分期的机构数_距离首次查询时间",
--     als_greast_id_rel_orgnum float comment "按身份证号查询，申请信用卡（类信用卡）的机构数_距离首次查询时间",
--     als_greast_id_caoff_orgnum float comment "按身份证号查询，申请线下现金分期的机构数_距离首次查询时间",
--     als_greast_id_cooff_orgnum float comment "按身份证号查询，申请线下消费分期的机构数_距离首次查询时间",
--     als_greast_id_af_orgnum float comment "按身份证号查询，申请汽车金融的机构数_距离首次查询时间",
--     als_greast_id_coon_orgnum float comment "按身份证号查询，申请线上消费分期的机构数_距离首次查询时间",
--     als_greast_id_oth_orgnum float comment "按身份证号查询，申请其他的机构数_距离首次查询时间",
--     als_greast_id_bank_orgnum float comment "按身份证号查询，在银行机构申请机构数_距离首次查询时间",
--     als_greast_id_bank_tra_orgnum float comment "按身份证号查询，在银行机构-传统银行申请机构数_距离首次查询时间",
--     als_greast_id_bank_ret_orgnum float comment "按身份证号查询，在银行机构-网络零售银行申请机构数_距离首次查询时间",
--     als_greast_id_bank_week_orgnum float comment "按身份证号查询，在银行机构周末申请机构数_距离首次查询时间",
--     als_greast_id_bank_night_orgnum float comment "按身份证号查询，在银行机构夜间申请机构数_距离首次查询时间",
--     als_greast_id_nbank_orgnum float comment "按身份证号查询，在非银机构申请机构数_距离首次查询时间",
--     als_greast_id_nbank_p2p_orgnum float comment "按身份证号查询，在非银机构-p2p申请机构数_距离首次查询时间",
--     als_greast_id_nbank_mc_orgnum float comment "按身份证号查询，在非银机构-小贷申请机构数_距离首次查询时间",
--     als_greast_id_nbank_ca_orgnum float comment "按身份证号查询，在非银机构-现金类分期申请机构数_距离首次查询时间",
--     als_greast_id_nbank_cf_orgnum float comment "按身份证号查询，在非银机构-消费类分期申请机构数_距离首次查询时间",
--     als_greast_id_nbank_com_orgnum float comment "按身份证号查询，在非银机构-代偿类分期申请机构数_距离首次查询时间",
--     als_greast_id_nbank_oth_orgnum float comment "按身份证号查询，在非银机构-其他申请机构数_距离首次查询时间",
--     als_greast_id_nbank_nsloan_orgnum float comment "按身份证号查询，在非银机构-持牌网络小贷机构申请机构数_距离首次查询时间",
--     als_greast_id_nbank_autofin_orgnum float comment "按身份证号查询，在非银机构-持牌汽车金融机构申请机构数_距离首次查询时间",
--     als_greast_id_nbank_sloan_orgnum float comment "按身份证号查询，在非银机构-持牌小贷机构申请机构数_距离首次查询时间",
--     als_greast_id_nbank_cons_orgnum float comment "按身份证号查询，在非银机构-持牌消费金融机构申请机构数_距离首次查询时间",
--     als_greast_id_nbank_finlea_orgnum float comment "按身份证号查询，在非银机构-持牌融资租赁机构申请机构数_距离首次查询时间",
--     als_greast_id_nbank_else_orgnum float comment "按身份证号查询，在非银机构-其他申请机构数_距离首次查询时间",
--     als_greast_id_nbank_week_orgnum float comment "按身份证号查询，在非银机构周末申请机构数_距离首次查询时间",
--     als_greast_id_nbank_night_orgnum float comment "按身份证号查询，在非银机构夜间申请机构数_距离首次查询时间",
--     als_other_allnum float comment "其他申请次数",
--     als_car_loan_allnum float comment "汽车金融申请次数",
--     als_petty_loan_allnum float comment "小贷申请次数",
--     als_other_orgnum float comment "其他申请机构数",
--     als_car_loan_orgnum float comment "汽车金融申请机构数",
--     als_petty_loan_orgnum float comment "小贷申请机构数",
--     als_other_sum_typ_orgnum_rte float comment "als_other_orgnum_占所有查询的比例",
--     als_licensed_net_loan_sum_typ_orgnum_rte float comment "als_licensed_net_loan_orgnum_占所有查询的比例",
--     als_old_bank_sum_typ_orgnum_rte float comment "als_old_bank_orgnum_占所有查询的比例",
--     als_car_loan_sum_typ_orgnum_rte float comment "als_car_loan_orgnum_占所有查询的比例",
--     als_net_bank_sum_typ_orgnum_rte float comment "als_net_bank_orgnum_占所有查询的比例",
--     als_cash_stage_sum_typ_orgnum_rte float comment "als_cash_stage_orgnum_占所有查询的比例",
--     als_consume_stage_sum_typ_orgnum_rte float comment "als_consume_stage_orgnum_占所有查询的比例",
--     als_consume_loan_sum_typ_orgnum_rte float comment "als_consume_loan_orgnum_占所有查询的比例",
--     als_petty_loan_sum_typ_orgnum_rte float comment "als_petty_loan_orgnum_占所有查询的比例",
--     als_credit_card_sum_typ_orgnum_rte float comment "als_credit_card_orgnum_占所有查询的比例",
--     als_other_sum_typ_allnum_rte float comment "als_other_allnum_占所有查询的比例",
--     als_licensed_net_loan_sum_typ_allnum_rte float comment "als_licensed_net_loan_allnum_占所有查询的比例",
--     als_old_bank_sum_typ_allnum_rte float comment "als_old_bank_allnum_占所有查询的比例",
--     als_car_loan_sum_typ_allnum_rte float comment "als_car_loan_allnum_占所有查询的比例",
--     als_net_bank_sum_typ_allnum_rte float comment "als_net_bank_allnum_占所有查询的比例",
--     als_cash_stage_sum_typ_allnum_rte float comment "als_cash_stage_allnum_占所有查询的比例",
--     als_consume_stage_sum_typ_allnum_rte float comment "als_consume_stage_allnum_占所有查询的比例",
--     als_consume_loan_sum_typ_allnum_rte float comment "als_consume_loan_allnum_占所有查询的比例",
--     als_petty_loan_sum_typ_allnum_rte float comment "als_petty_loan_allnum_占所有查询的比例",
--     als_credit_card_sum_typ_allnum_rte float comment "als_credit_card_allnum_占所有查询的比例",
--     als_org_score float comment "百融多头机构加权总得分",
--     als_org_score_avg float comment "百融多头机构加权平均得分",
--     sum_typ_orgnum float comment '指定类别查询机构数之和',
--     sum_typ_allnum float comment '指定类别查询次数之和',

--     data_id string comment '数据ID',
--     code string comment '响应码',
--     flag_applyloanstr string comment '借贷意向验证产品输出标识',
--     swift_number string comment '操作流水号',
--     created_at timestamp comment '创建时间',
--     updated_at timestamp comment '更新时间',
--     rcd_tim timestamp comment '数据更新时间'
-- ) comment '百融多头变量通用逻辑, 趋势变量v2, 每日查询样本更新, 贷前贷中两张表union'
-- partitioned by (ds string);


drop table if exists ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_v2_tmp;
create table ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_v2_tmp as 
select uid

    ,als_m3_id_nbank_finlea_orgnum + als_m3_id_nbank_p2p_orgnum + als_m3_id_nbank_else_orgnum + als_m3_id_nbank_oth_orgnum as als_other_orgnum
    ,als_m3_id_nbank_nsloan_orgnum as als_licensed_net_loan_orgnum
    ,als_m3_id_bank_tra_orgnum as als_old_bank_orgnum
    ,als_m3_id_af_orgnum + als_m3_id_nbank_autofin_orgnum as als_car_loan_orgnum
    ,als_m3_id_bank_ret_orgnum as als_net_bank_orgnum
    ,als_m3_id_nbank_ca_orgnum as als_cash_stage_orgnum
    ,als_m3_id_nbank_cf_orgnum as als_consume_stage_orgnum
    ,als_m3_id_nbank_cons_orgnum as als_consume_loan_orgnum
    ,als_m3_id_nbank_sloan_orgnum + als_m3_id_nbank_mc_orgnum as als_petty_loan_orgnum
    ,als_m3_id_rel_orgnum as als_credit_card_orgnum

    ,als_m3_id_nbank_finlea_allnum + als_m3_id_nbank_p2p_allnum + als_m3_id_nbank_else_allnum + als_m3_id_nbank_oth_allnum as als_other_allnum
    ,als_m3_id_nbank_nsloan_allnum as als_licensed_net_loan_allnum
    ,als_m3_id_bank_tra_allnum as als_old_bank_allnum
    ,als_m3_id_af_allnum + als_m3_id_nbank_autofin_allnum as als_car_loan_allnum
    ,als_m3_id_bank_ret_allnum as als_net_bank_allnum
    ,als_m3_id_nbank_ca_allnum as als_cash_stage_allnum
    ,als_m3_id_nbank_cf_allnum as als_consume_stage_allnum
    ,als_m3_id_nbank_cons_allnum as als_consume_loan_allnum
    ,als_m3_id_nbank_sloan_allnum + als_m3_id_nbank_mc_allnum as als_petty_loan_allnum
    ,als_m3_id_rel_allnum as als_credit_card_allnum

    ,least(als_d7_id_pdl_orgnum_diff,als_d15_id_pdl_orgnum_diff,als_m1_id_pdl_orgnum_diff,als_m3_id_pdl_orgnum_diff,als_m6_id_pdl_orgnum_diff,als_m12_id_pdl_orgnum_diff) as als_least_id_pdl_orgnum
    ,least(als_d7_id_caon_orgnum_diff,als_d15_id_caon_orgnum_diff,als_m1_id_caon_orgnum_diff,als_m3_id_caon_orgnum_diff,als_m6_id_caon_orgnum_diff,als_m12_id_caon_orgnum_diff) as als_least_id_caon_orgnum
    ,least(als_d7_id_rel_orgnum_diff,als_d15_id_rel_orgnum_diff,als_m1_id_rel_orgnum_diff,als_m3_id_rel_orgnum_diff,als_m6_id_rel_orgnum_diff,als_m12_id_rel_orgnum_diff) as als_least_id_rel_orgnum
    ,least(als_d7_id_caoff_orgnum_diff,als_d15_id_caoff_orgnum_diff,als_m1_id_caoff_orgnum_diff,als_m3_id_caoff_orgnum_diff,als_m6_id_caoff_orgnum_diff,als_m12_id_caoff_orgnum_diff) as als_least_id_caoff_orgnum
    ,least(als_d7_id_cooff_orgnum_diff,als_d15_id_cooff_orgnum_diff,als_m1_id_cooff_orgnum_diff,als_m3_id_cooff_orgnum_diff,als_m6_id_cooff_orgnum_diff,als_m12_id_cooff_orgnum_diff) as als_least_id_cooff_orgnum
    ,least(als_d7_id_af_orgnum_diff,als_d15_id_af_orgnum_diff,als_m1_id_af_orgnum_diff,als_m3_id_af_orgnum_diff,als_m6_id_af_orgnum_diff,als_m12_id_af_orgnum_diff) as als_least_id_af_orgnum
    ,least(als_d7_id_coon_orgnum_diff,als_d15_id_coon_orgnum_diff,als_m1_id_coon_orgnum_diff,als_m3_id_coon_orgnum_diff,als_m6_id_coon_orgnum_diff,als_m12_id_coon_orgnum_diff) as als_least_id_coon_orgnum
    ,least(als_d7_id_oth_orgnum_diff,als_d15_id_oth_orgnum_diff,als_m1_id_oth_orgnum_diff,als_m3_id_oth_orgnum_diff,als_m6_id_oth_orgnum_diff,als_m12_id_oth_orgnum_diff) as als_least_id_oth_orgnum
    ,least(als_d7_id_bank_orgnum_diff,als_d15_id_bank_orgnum_diff,als_m1_id_bank_orgnum_diff,als_m3_id_bank_orgnum_diff,als_m6_id_bank_orgnum_diff,als_m12_id_bank_orgnum_diff) as als_least_id_bank_orgnum
    ,least(als_d7_id_bank_tra_orgnum_diff,als_d15_id_bank_tra_orgnum_diff,als_m1_id_bank_tra_orgnum_diff,als_m3_id_bank_tra_orgnum_diff,als_m6_id_bank_tra_orgnum_diff,als_m12_id_bank_tra_orgnum_diff) as als_least_id_bank_tra_orgnum
    ,least(als_d7_id_bank_ret_orgnum_diff,als_d15_id_bank_ret_orgnum_diff,als_m1_id_bank_ret_orgnum_diff,als_m3_id_bank_ret_orgnum_diff,als_m6_id_bank_ret_orgnum_diff,als_m12_id_bank_ret_orgnum_diff) as als_least_id_bank_ret_orgnum
    ,least(als_d7_id_bank_week_orgnum_diff,als_d15_id_bank_week_orgnum_diff,als_m1_id_bank_week_orgnum_diff,als_m3_id_bank_week_orgnum_diff,als_m6_id_bank_week_orgnum_diff,als_m12_id_bank_week_orgnum_diff) as als_least_id_bank_week_orgnum
    ,least(als_d7_id_bank_night_orgnum_diff,als_d15_id_bank_night_orgnum_diff,als_m1_id_bank_night_orgnum_diff,als_m3_id_bank_night_orgnum_diff,als_m6_id_bank_night_orgnum_diff,als_m12_id_bank_night_orgnum_diff) as als_least_id_bank_night_orgnum
    ,least(als_d7_id_nbank_orgnum_diff,als_d15_id_nbank_orgnum_diff,als_m1_id_nbank_orgnum_diff,als_m3_id_nbank_orgnum_diff,als_m6_id_nbank_orgnum_diff,als_m12_id_nbank_orgnum_diff) as als_least_id_nbank_orgnum
    ,least(als_d7_id_nbank_p2p_orgnum_diff,als_d15_id_nbank_p2p_orgnum_diff,als_m1_id_nbank_p2p_orgnum_diff,als_m3_id_nbank_p2p_orgnum_diff,als_m6_id_nbank_p2p_orgnum_diff,als_m12_id_nbank_p2p_orgnum_diff) as als_least_id_nbank_p2p_orgnum
    ,least(als_d7_id_nbank_mc_orgnum_diff,als_d15_id_nbank_mc_orgnum_diff,als_m1_id_nbank_mc_orgnum_diff,als_m3_id_nbank_mc_orgnum_diff,als_m6_id_nbank_mc_orgnum_diff,als_m12_id_nbank_mc_orgnum_diff) as als_least_id_nbank_mc_orgnum
    ,least(als_d7_id_nbank_ca_orgnum_diff,als_d15_id_nbank_ca_orgnum_diff,als_m1_id_nbank_ca_orgnum_diff,als_m3_id_nbank_ca_orgnum_diff,als_m6_id_nbank_ca_orgnum_diff,als_m12_id_nbank_ca_orgnum_diff) as als_least_id_nbank_ca_orgnum
    ,least(als_d7_id_nbank_cf_orgnum_diff,als_d15_id_nbank_cf_orgnum_diff,als_m1_id_nbank_cf_orgnum_diff,als_m3_id_nbank_cf_orgnum_diff,als_m6_id_nbank_cf_orgnum_diff,als_m12_id_nbank_cf_orgnum_diff) as als_least_id_nbank_cf_orgnum
    ,least(als_d7_id_nbank_com_orgnum_diff,als_d15_id_nbank_com_orgnum_diff,als_m1_id_nbank_com_orgnum_diff,als_m3_id_nbank_com_orgnum_diff,als_m6_id_nbank_com_orgnum_diff,als_m12_id_nbank_com_orgnum_diff) as als_least_id_nbank_com_orgnum
    ,least(als_d7_id_nbank_oth_orgnum_diff,als_d15_id_nbank_oth_orgnum_diff,als_m1_id_nbank_oth_orgnum_diff,als_m3_id_nbank_oth_orgnum_diff,als_m6_id_nbank_oth_orgnum_diff,als_m12_id_nbank_oth_orgnum_diff) as als_least_id_nbank_oth_orgnum
    ,least(als_d7_id_nbank_nsloan_orgnum_diff,als_d15_id_nbank_nsloan_orgnum_diff,als_m1_id_nbank_nsloan_orgnum_diff,als_m3_id_nbank_nsloan_orgnum_diff,als_m6_id_nbank_nsloan_orgnum_diff,als_m12_id_nbank_nsloan_orgnum_diff) as als_least_id_nbank_nsloan_orgnum
    ,least(als_d7_id_nbank_autofin_orgnum_diff,als_d15_id_nbank_autofin_orgnum_diff,als_m1_id_nbank_autofin_orgnum_diff,als_m3_id_nbank_autofin_orgnum_diff,als_m6_id_nbank_autofin_orgnum_diff,als_m12_id_nbank_autofin_orgnum_diff) as als_least_id_nbank_autofin_orgnum
    ,least(als_d7_id_nbank_sloan_orgnum_diff,als_d15_id_nbank_sloan_orgnum_diff,als_m1_id_nbank_sloan_orgnum_diff,als_m3_id_nbank_sloan_orgnum_diff,als_m6_id_nbank_sloan_orgnum_diff,als_m12_id_nbank_sloan_orgnum_diff) as als_least_id_nbank_sloan_orgnum
    ,least(als_d7_id_nbank_cons_orgnum_diff,als_d15_id_nbank_cons_orgnum_diff,als_m1_id_nbank_cons_orgnum_diff,als_m3_id_nbank_cons_orgnum_diff,als_m6_id_nbank_cons_orgnum_diff,als_m12_id_nbank_cons_orgnum_diff) as als_least_id_nbank_cons_orgnum
    ,least(als_d7_id_nbank_finlea_orgnum_diff,als_d15_id_nbank_finlea_orgnum_diff,als_m1_id_nbank_finlea_orgnum_diff,als_m3_id_nbank_finlea_orgnum_diff,als_m6_id_nbank_finlea_orgnum_diff,als_m12_id_nbank_finlea_orgnum_diff) as als_least_id_nbank_finlea_orgnum
    ,least(als_d7_id_nbank_else_orgnum_diff,als_d15_id_nbank_else_orgnum_diff,als_m1_id_nbank_else_orgnum_diff,als_m3_id_nbank_else_orgnum_diff,als_m6_id_nbank_else_orgnum_diff,als_m12_id_nbank_else_orgnum_diff) as als_least_id_nbank_else_orgnum
    ,least(als_d7_id_nbank_week_orgnum_diff,als_d15_id_nbank_week_orgnum_diff,als_m1_id_nbank_week_orgnum_diff,als_m3_id_nbank_week_orgnum_diff,als_m6_id_nbank_week_orgnum_diff,als_m12_id_nbank_week_orgnum_diff) as als_least_id_nbank_week_orgnum
    ,least(als_d7_id_nbank_night_orgnum_diff,als_d15_id_nbank_night_orgnum_diff,als_m1_id_nbank_night_orgnum_diff,als_m3_id_nbank_night_orgnum_diff,als_m6_id_nbank_night_orgnum_diff,als_m12_id_nbank_night_orgnum_diff) as als_least_id_nbank_night_orgnum

    ,als_d15_id_pdl_orgnum - als_d7_id_pdl_orgnum as als_d7_d15_id_pdl_orgnum
    ,als_m1_id_pdl_orgnum - als_d15_id_pdl_orgnum as als_d15_m1_id_pdl_orgnum
    ,als_m3_id_pdl_orgnum - als_m1_id_pdl_orgnum as als_m1_m3_id_pdl_orgnum
    ,als_m6_id_pdl_orgnum - als_m3_id_pdl_orgnum as als_m3_m6_id_pdl_orgnum
    ,als_m12_id_pdl_orgnum - als_m6_id_pdl_orgnum as als_m6_m12_id_pdl_orgnum
    ,als_d15_id_caon_orgnum - als_d7_id_caon_orgnum as als_d7_d15_id_caon_orgnum
    ,als_m1_id_caon_orgnum - als_d15_id_caon_orgnum as als_d15_m1_id_caon_orgnum
    ,als_m3_id_caon_orgnum - als_m1_id_caon_orgnum as als_m1_m3_id_caon_orgnum
    ,als_m6_id_caon_orgnum - als_m3_id_caon_orgnum as als_m3_m6_id_caon_orgnum
    ,als_m12_id_caon_orgnum - als_m6_id_caon_orgnum as als_m6_m12_id_caon_orgnum
    ,als_d15_id_rel_orgnum - als_d7_id_rel_orgnum as als_d7_d15_id_rel_orgnum
    ,als_m1_id_rel_orgnum - als_d15_id_rel_orgnum as als_d15_m1_id_rel_orgnum
    ,als_m3_id_rel_orgnum - als_m1_id_rel_orgnum as als_m1_m3_id_rel_orgnum
    ,als_m6_id_rel_orgnum - als_m3_id_rel_orgnum as als_m3_m6_id_rel_orgnum
    ,als_m12_id_rel_orgnum - als_m6_id_rel_orgnum as als_m6_m12_id_rel_orgnum
    ,als_d15_id_caoff_orgnum - als_d7_id_caoff_orgnum as als_d7_d15_id_caoff_orgnum
    ,als_m1_id_caoff_orgnum - als_d15_id_caoff_orgnum as als_d15_m1_id_caoff_orgnum
    ,als_m3_id_caoff_orgnum - als_m1_id_caoff_orgnum as als_m1_m3_id_caoff_orgnum
    ,als_m6_id_caoff_orgnum - als_m3_id_caoff_orgnum as als_m3_m6_id_caoff_orgnum
    ,als_m12_id_caoff_orgnum - als_m6_id_caoff_orgnum as als_m6_m12_id_caoff_orgnum
    ,als_d15_id_cooff_orgnum - als_d7_id_cooff_orgnum as als_d7_d15_id_cooff_orgnum
    ,als_m1_id_cooff_orgnum - als_d15_id_cooff_orgnum as als_d15_m1_id_cooff_orgnum
    ,als_m3_id_cooff_orgnum - als_m1_id_cooff_orgnum as als_m1_m3_id_cooff_orgnum
    ,als_m6_id_cooff_orgnum - als_m3_id_cooff_orgnum as als_m3_m6_id_cooff_orgnum
    ,als_m12_id_cooff_orgnum - als_m6_id_cooff_orgnum as als_m6_m12_id_cooff_orgnum
    ,als_d15_id_af_orgnum - als_d7_id_af_orgnum as als_d7_d15_id_af_orgnum
    ,als_m1_id_af_orgnum - als_d15_id_af_orgnum as als_d15_m1_id_af_orgnum
    ,als_m3_id_af_orgnum - als_m1_id_af_orgnum as als_m1_m3_id_af_orgnum
    ,als_m6_id_af_orgnum - als_m3_id_af_orgnum as als_m3_m6_id_af_orgnum
    ,als_m12_id_af_orgnum - als_m6_id_af_orgnum as als_m6_m12_id_af_orgnum
    ,als_d15_id_coon_orgnum - als_d7_id_coon_orgnum as als_d7_d15_id_coon_orgnum
    ,als_m1_id_coon_orgnum - als_d15_id_coon_orgnum as als_d15_m1_id_coon_orgnum
    ,als_m3_id_coon_orgnum - als_m1_id_coon_orgnum as als_m1_m3_id_coon_orgnum
    ,als_m6_id_coon_orgnum - als_m3_id_coon_orgnum as als_m3_m6_id_coon_orgnum
    ,als_m12_id_coon_orgnum - als_m6_id_coon_orgnum as als_m6_m12_id_coon_orgnum
    ,als_d15_id_oth_orgnum - als_d7_id_oth_orgnum as als_d7_d15_id_oth_orgnum
    ,als_m1_id_oth_orgnum - als_d15_id_oth_orgnum as als_d15_m1_id_oth_orgnum
    ,als_m3_id_oth_orgnum - als_m1_id_oth_orgnum as als_m1_m3_id_oth_orgnum
    ,als_m6_id_oth_orgnum - als_m3_id_oth_orgnum as als_m3_m6_id_oth_orgnum
    ,als_m12_id_oth_orgnum - als_m6_id_oth_orgnum as als_m6_m12_id_oth_orgnum
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
    ,als_d15_id_bank_ret_orgnum - als_d7_id_bank_ret_orgnum as als_d7_d15_id_bank_ret_orgnum
    ,als_m1_id_bank_ret_orgnum - als_d15_id_bank_ret_orgnum as als_d15_m1_id_bank_ret_orgnum
    ,als_m3_id_bank_ret_orgnum - als_m1_id_bank_ret_orgnum as als_m1_m3_id_bank_ret_orgnum
    ,als_m6_id_bank_ret_orgnum - als_m3_id_bank_ret_orgnum as als_m3_m6_id_bank_ret_orgnum
    ,als_m12_id_bank_ret_orgnum - als_m6_id_bank_ret_orgnum as als_m6_m12_id_bank_ret_orgnum
    ,als_d15_id_bank_week_orgnum - als_d7_id_bank_week_orgnum as als_d7_d15_id_bank_week_orgnum
    ,als_m1_id_bank_week_orgnum - als_d15_id_bank_week_orgnum as als_d15_m1_id_bank_week_orgnum
    ,als_m3_id_bank_week_orgnum - als_m1_id_bank_week_orgnum as als_m1_m3_id_bank_week_orgnum
    ,als_m6_id_bank_week_orgnum - als_m3_id_bank_week_orgnum as als_m3_m6_id_bank_week_orgnum
    ,als_m12_id_bank_week_orgnum - als_m6_id_bank_week_orgnum as als_m6_m12_id_bank_week_orgnum
    ,als_d15_id_bank_night_orgnum - als_d7_id_bank_night_orgnum as als_d7_d15_id_bank_night_orgnum
    ,als_m1_id_bank_night_orgnum - als_d15_id_bank_night_orgnum as als_d15_m1_id_bank_night_orgnum
    ,als_m3_id_bank_night_orgnum - als_m1_id_bank_night_orgnum as als_m1_m3_id_bank_night_orgnum
    ,als_m6_id_bank_night_orgnum - als_m3_id_bank_night_orgnum as als_m3_m6_id_bank_night_orgnum
    ,als_m12_id_bank_night_orgnum - als_m6_id_bank_night_orgnum as als_m6_m12_id_bank_night_orgnum
    ,als_d15_id_nbank_orgnum - als_d7_id_nbank_orgnum as als_d7_d15_id_nbank_orgnum
    ,als_m1_id_nbank_orgnum - als_d15_id_nbank_orgnum as als_d15_m1_id_nbank_orgnum
    ,als_m3_id_nbank_orgnum - als_m1_id_nbank_orgnum as als_m1_m3_id_nbank_orgnum
    ,als_m6_id_nbank_orgnum - als_m3_id_nbank_orgnum as als_m3_m6_id_nbank_orgnum
    ,als_m12_id_nbank_orgnum - als_m6_id_nbank_orgnum as als_m6_m12_id_nbank_orgnum
    ,als_d15_id_nbank_p2p_orgnum - als_d7_id_nbank_p2p_orgnum as als_d7_d15_id_nbank_p2p_orgnum
    ,als_m1_id_nbank_p2p_orgnum - als_d15_id_nbank_p2p_orgnum as als_d15_m1_id_nbank_p2p_orgnum
    ,als_m3_id_nbank_p2p_orgnum - als_m1_id_nbank_p2p_orgnum as als_m1_m3_id_nbank_p2p_orgnum
    ,als_m6_id_nbank_p2p_orgnum - als_m3_id_nbank_p2p_orgnum as als_m3_m6_id_nbank_p2p_orgnum
    ,als_m12_id_nbank_p2p_orgnum - als_m6_id_nbank_p2p_orgnum as als_m6_m12_id_nbank_p2p_orgnum
    ,als_d15_id_nbank_mc_orgnum - als_d7_id_nbank_mc_orgnum as als_d7_d15_id_nbank_mc_orgnum
    ,als_m1_id_nbank_mc_orgnum - als_d15_id_nbank_mc_orgnum as als_d15_m1_id_nbank_mc_orgnum
    ,als_m3_id_nbank_mc_orgnum - als_m1_id_nbank_mc_orgnum as als_m1_m3_id_nbank_mc_orgnum
    ,als_m6_id_nbank_mc_orgnum - als_m3_id_nbank_mc_orgnum as als_m3_m6_id_nbank_mc_orgnum
    ,als_m12_id_nbank_mc_orgnum - als_m6_id_nbank_mc_orgnum as als_m6_m12_id_nbank_mc_orgnum
    ,als_d15_id_nbank_ca_orgnum - als_d7_id_nbank_ca_orgnum as als_d7_d15_id_nbank_ca_orgnum
    ,als_m1_id_nbank_ca_orgnum - als_d15_id_nbank_ca_orgnum as als_d15_m1_id_nbank_ca_orgnum
    ,als_m3_id_nbank_ca_orgnum - als_m1_id_nbank_ca_orgnum as als_m1_m3_id_nbank_ca_orgnum
    ,als_m6_id_nbank_ca_orgnum - als_m3_id_nbank_ca_orgnum as als_m3_m6_id_nbank_ca_orgnum
    ,als_m12_id_nbank_ca_orgnum - als_m6_id_nbank_ca_orgnum as als_m6_m12_id_nbank_ca_orgnum
    ,als_d15_id_nbank_cf_orgnum - als_d7_id_nbank_cf_orgnum as als_d7_d15_id_nbank_cf_orgnum
    ,als_m1_id_nbank_cf_orgnum - als_d15_id_nbank_cf_orgnum as als_d15_m1_id_nbank_cf_orgnum
    ,als_m3_id_nbank_cf_orgnum - als_m1_id_nbank_cf_orgnum as als_m1_m3_id_nbank_cf_orgnum
    ,als_m6_id_nbank_cf_orgnum - als_m3_id_nbank_cf_orgnum as als_m3_m6_id_nbank_cf_orgnum
    ,als_m12_id_nbank_cf_orgnum - als_m6_id_nbank_cf_orgnum as als_m6_m12_id_nbank_cf_orgnum
    ,als_d15_id_nbank_com_orgnum - als_d7_id_nbank_com_orgnum as als_d7_d15_id_nbank_com_orgnum
    ,als_m1_id_nbank_com_orgnum - als_d15_id_nbank_com_orgnum as als_d15_m1_id_nbank_com_orgnum
    ,als_m3_id_nbank_com_orgnum - als_m1_id_nbank_com_orgnum as als_m1_m3_id_nbank_com_orgnum
    ,als_m6_id_nbank_com_orgnum - als_m3_id_nbank_com_orgnum as als_m3_m6_id_nbank_com_orgnum
    ,als_m12_id_nbank_com_orgnum - als_m6_id_nbank_com_orgnum as als_m6_m12_id_nbank_com_orgnum
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
    ,als_d15_id_nbank_autofin_orgnum - als_d7_id_nbank_autofin_orgnum as als_d7_d15_id_nbank_autofin_orgnum
    ,als_m1_id_nbank_autofin_orgnum - als_d15_id_nbank_autofin_orgnum as als_d15_m1_id_nbank_autofin_orgnum
    ,als_m3_id_nbank_autofin_orgnum - als_m1_id_nbank_autofin_orgnum as als_m1_m3_id_nbank_autofin_orgnum
    ,als_m6_id_nbank_autofin_orgnum - als_m3_id_nbank_autofin_orgnum as als_m3_m6_id_nbank_autofin_orgnum
    ,als_m12_id_nbank_autofin_orgnum - als_m6_id_nbank_autofin_orgnum as als_m6_m12_id_nbank_autofin_orgnum
    ,als_d15_id_nbank_sloan_orgnum - als_d7_id_nbank_sloan_orgnum as als_d7_d15_id_nbank_sloan_orgnum
    ,als_m1_id_nbank_sloan_orgnum - als_d15_id_nbank_sloan_orgnum as als_d15_m1_id_nbank_sloan_orgnum
    ,als_m3_id_nbank_sloan_orgnum - als_m1_id_nbank_sloan_orgnum as als_m1_m3_id_nbank_sloan_orgnum
    ,als_m6_id_nbank_sloan_orgnum - als_m3_id_nbank_sloan_orgnum as als_m3_m6_id_nbank_sloan_orgnum
    ,als_m12_id_nbank_sloan_orgnum - als_m6_id_nbank_sloan_orgnum as als_m6_m12_id_nbank_sloan_orgnum
    ,als_d15_id_nbank_cons_orgnum - als_d7_id_nbank_cons_orgnum as als_d7_d15_id_nbank_cons_orgnum
    ,als_m1_id_nbank_cons_orgnum - als_d15_id_nbank_cons_orgnum as als_d15_m1_id_nbank_cons_orgnum
    ,als_m3_id_nbank_cons_orgnum - als_m1_id_nbank_cons_orgnum as als_m1_m3_id_nbank_cons_orgnum
    ,als_m6_id_nbank_cons_orgnum - als_m3_id_nbank_cons_orgnum as als_m3_m6_id_nbank_cons_orgnum
    ,als_m12_id_nbank_cons_orgnum - als_m6_id_nbank_cons_orgnum as als_m6_m12_id_nbank_cons_orgnum
    ,als_d15_id_nbank_finlea_orgnum - als_d7_id_nbank_finlea_orgnum as als_d7_d15_id_nbank_finlea_orgnum
    ,als_m1_id_nbank_finlea_orgnum - als_d15_id_nbank_finlea_orgnum as als_d15_m1_id_nbank_finlea_orgnum
    ,als_m3_id_nbank_finlea_orgnum - als_m1_id_nbank_finlea_orgnum as als_m1_m3_id_nbank_finlea_orgnum
    ,als_m6_id_nbank_finlea_orgnum - als_m3_id_nbank_finlea_orgnum as als_m3_m6_id_nbank_finlea_orgnum
    ,als_m12_id_nbank_finlea_orgnum - als_m6_id_nbank_finlea_orgnum as als_m6_m12_id_nbank_finlea_orgnum
    ,als_d15_id_nbank_else_orgnum - als_d7_id_nbank_else_orgnum as als_d7_d15_id_nbank_else_orgnum
    ,als_m1_id_nbank_else_orgnum - als_d15_id_nbank_else_orgnum as als_d15_m1_id_nbank_else_orgnum
    ,als_m3_id_nbank_else_orgnum - als_m1_id_nbank_else_orgnum as als_m1_m3_id_nbank_else_orgnum
    ,als_m6_id_nbank_else_orgnum - als_m3_id_nbank_else_orgnum as als_m3_m6_id_nbank_else_orgnum
    ,als_m12_id_nbank_else_orgnum - als_m6_id_nbank_else_orgnum as als_m6_m12_id_nbank_else_orgnum
    ,als_d15_id_nbank_week_orgnum - als_d7_id_nbank_week_orgnum as als_d7_d15_id_nbank_week_orgnum
    ,als_m1_id_nbank_week_orgnum - als_d15_id_nbank_week_orgnum as als_d15_m1_id_nbank_week_orgnum
    ,als_m3_id_nbank_week_orgnum - als_m1_id_nbank_week_orgnum as als_m1_m3_id_nbank_week_orgnum
    ,als_m6_id_nbank_week_orgnum - als_m3_id_nbank_week_orgnum as als_m3_m6_id_nbank_week_orgnum
    ,als_m12_id_nbank_week_orgnum - als_m6_id_nbank_week_orgnum as als_m6_m12_id_nbank_week_orgnum
    ,als_d15_id_nbank_night_orgnum - als_d7_id_nbank_night_orgnum as als_d7_d15_id_nbank_night_orgnum
    ,als_m1_id_nbank_night_orgnum - als_d15_id_nbank_night_orgnum as als_d15_m1_id_nbank_night_orgnum
    ,als_m3_id_nbank_night_orgnum - als_m1_id_nbank_night_orgnum as als_m1_m3_id_nbank_night_orgnum
    ,als_m6_id_nbank_night_orgnum - als_m3_id_nbank_night_orgnum as als_m3_m6_id_nbank_night_orgnum
    ,als_m12_id_nbank_night_orgnum - als_m6_id_nbank_night_orgnum as als_m6_m12_id_nbank_night_orgnum

    -- 缺失填充为0的原始变量
    ,als_d7_id_pdl_allnum
    ,als_d7_id_pdl_orgnum
    ,als_d7_id_caon_allnum
    ,als_d7_id_caon_orgnum
    ,als_d7_id_rel_allnum
    ,als_d7_id_rel_orgnum
    ,als_d7_id_caoff_allnum
    ,als_d7_id_caoff_orgnum
    ,als_d7_id_cooff_allnum
    ,als_d7_id_cooff_orgnum
    ,als_d7_id_af_allnum
    ,als_d7_id_af_orgnum
    ,als_d7_id_coon_allnum
    ,als_d7_id_coon_orgnum
    ,als_d7_id_oth_allnum
    ,als_d7_id_oth_orgnum
    ,als_d7_id_bank_selfnum
    ,als_d7_id_bank_allnum
    ,als_d7_id_bank_tra_allnum
    ,als_d7_id_bank_ret_allnum
    ,als_d7_id_bank_orgnum
    ,als_d7_id_bank_tra_orgnum
    ,als_d7_id_bank_ret_orgnum
    ,als_d7_id_bank_week_allnum
    ,als_d7_id_bank_week_orgnum
    ,als_d7_id_bank_night_allnum
    ,als_d7_id_bank_night_orgnum
    ,als_d7_id_nbank_selfnum
    ,als_d7_id_nbank_allnum
    ,als_d7_id_nbank_p2p_allnum
    ,als_d7_id_nbank_mc_allnum
    ,als_d7_id_nbank_ca_allnum
    ,als_d7_id_nbank_cf_allnum
    ,als_d7_id_nbank_com_allnum
    ,als_d7_id_nbank_oth_allnum
    ,als_d7_id_nbank_nsloan_allnum
    ,als_d7_id_nbank_autofin_allnum
    ,als_d7_id_nbank_sloan_allnum
    ,als_d7_id_nbank_cons_allnum
    ,als_d7_id_nbank_finlea_allnum
    ,als_d7_id_nbank_else_allnum
    ,als_d7_id_nbank_orgnum
    ,als_d7_id_nbank_p2p_orgnum
    ,als_d7_id_nbank_mc_orgnum
    ,als_d7_id_nbank_ca_orgnum
    ,als_d7_id_nbank_cf_orgnum
    ,als_d7_id_nbank_com_orgnum
    ,als_d7_id_nbank_oth_orgnum
    ,als_d7_id_nbank_nsloan_orgnum
    ,als_d7_id_nbank_autofin_orgnum
    ,als_d7_id_nbank_sloan_orgnum
    ,als_d7_id_nbank_cons_orgnum
    ,als_d7_id_nbank_finlea_orgnum
    ,als_d7_id_nbank_else_orgnum
    ,als_d7_id_nbank_week_allnum
    ,als_d7_id_nbank_week_orgnum
    ,als_d7_id_nbank_night_allnum
    ,als_d7_id_nbank_night_orgnum

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

        ,case when als_d7_id_pdl_orgnum is null or als_d7_id_pdl_orgnum=0 then 361 else 7 end as als_d7_id_pdl_orgnum_diff
        ,case when als_d15_id_pdl_orgnum is null or als_d15_id_pdl_orgnum=0 then 361 else 15 end as als_d15_id_pdl_orgnum_diff
        ,case when als_m1_id_pdl_orgnum is null or als_m1_id_pdl_orgnum=0 then 361 else 30 end as als_m1_id_pdl_orgnum_diff
        ,case when als_m3_id_pdl_orgnum is null or als_m3_id_pdl_orgnum=0 then 361 else 90 end as als_m3_id_pdl_orgnum_diff
        ,case when als_m6_id_pdl_orgnum is null or als_m6_id_pdl_orgnum=0 then 361 else 180 end as als_m6_id_pdl_orgnum_diff
        ,case when als_m12_id_pdl_orgnum is null or als_m12_id_pdl_orgnum=0 then 361 else 360 end as als_m12_id_pdl_orgnum_diff
        ,case when als_d7_id_caon_orgnum is null or als_d7_id_caon_orgnum=0 then 361 else 7 end as als_d7_id_caon_orgnum_diff
        ,case when als_d15_id_caon_orgnum is null or als_d15_id_caon_orgnum=0 then 361 else 15 end as als_d15_id_caon_orgnum_diff
        ,case when als_m1_id_caon_orgnum is null or als_m1_id_caon_orgnum=0 then 361 else 30 end as als_m1_id_caon_orgnum_diff
        ,case when als_m3_id_caon_orgnum is null or als_m3_id_caon_orgnum=0 then 361 else 90 end as als_m3_id_caon_orgnum_diff
        ,case when als_m6_id_caon_orgnum is null or als_m6_id_caon_orgnum=0 then 361 else 180 end as als_m6_id_caon_orgnum_diff
        ,case when als_m12_id_caon_orgnum is null or als_m12_id_caon_orgnum=0 then 361 else 360 end as als_m12_id_caon_orgnum_diff
        ,case when als_d7_id_rel_orgnum is null or als_d7_id_rel_orgnum=0 then 361 else 7 end as als_d7_id_rel_orgnum_diff
        ,case when als_d15_id_rel_orgnum is null or als_d15_id_rel_orgnum=0 then 361 else 15 end as als_d15_id_rel_orgnum_diff
        ,case when als_m1_id_rel_orgnum is null or als_m1_id_rel_orgnum=0 then 361 else 30 end as als_m1_id_rel_orgnum_diff
        ,case when als_m3_id_rel_orgnum is null or als_m3_id_rel_orgnum=0 then 361 else 90 end as als_m3_id_rel_orgnum_diff
        ,case when als_m6_id_rel_orgnum is null or als_m6_id_rel_orgnum=0 then 361 else 180 end as als_m6_id_rel_orgnum_diff
        ,case when als_m12_id_rel_orgnum is null or als_m12_id_rel_orgnum=0 then 361 else 360 end as als_m12_id_rel_orgnum_diff
        ,case when als_d7_id_caoff_orgnum is null or als_d7_id_caoff_orgnum=0 then 361 else 7 end as als_d7_id_caoff_orgnum_diff
        ,case when als_d15_id_caoff_orgnum is null or als_d15_id_caoff_orgnum=0 then 361 else 15 end as als_d15_id_caoff_orgnum_diff
        ,case when als_m1_id_caoff_orgnum is null or als_m1_id_caoff_orgnum=0 then 361 else 30 end as als_m1_id_caoff_orgnum_diff
        ,case when als_m3_id_caoff_orgnum is null or als_m3_id_caoff_orgnum=0 then 361 else 90 end as als_m3_id_caoff_orgnum_diff
        ,case when als_m6_id_caoff_orgnum is null or als_m6_id_caoff_orgnum=0 then 361 else 180 end as als_m6_id_caoff_orgnum_diff
        ,case when als_m12_id_caoff_orgnum is null or als_m12_id_caoff_orgnum=0 then 361 else 360 end as als_m12_id_caoff_orgnum_diff
        ,case when als_d7_id_cooff_orgnum is null or als_d7_id_cooff_orgnum=0 then 361 else 7 end as als_d7_id_cooff_orgnum_diff
        ,case when als_d15_id_cooff_orgnum is null or als_d15_id_cooff_orgnum=0 then 361 else 15 end as als_d15_id_cooff_orgnum_diff
        ,case when als_m1_id_cooff_orgnum is null or als_m1_id_cooff_orgnum=0 then 361 else 30 end as als_m1_id_cooff_orgnum_diff
        ,case when als_m3_id_cooff_orgnum is null or als_m3_id_cooff_orgnum=0 then 361 else 90 end as als_m3_id_cooff_orgnum_diff
        ,case when als_m6_id_cooff_orgnum is null or als_m6_id_cooff_orgnum=0 then 361 else 180 end as als_m6_id_cooff_orgnum_diff
        ,case when als_m12_id_cooff_orgnum is null or als_m12_id_cooff_orgnum=0 then 361 else 360 end as als_m12_id_cooff_orgnum_diff
        ,case when als_d7_id_af_orgnum is null or als_d7_id_af_orgnum=0 then 361 else 7 end as als_d7_id_af_orgnum_diff
        ,case when als_d15_id_af_orgnum is null or als_d15_id_af_orgnum=0 then 361 else 15 end as als_d15_id_af_orgnum_diff
        ,case when als_m1_id_af_orgnum is null or als_m1_id_af_orgnum=0 then 361 else 30 end as als_m1_id_af_orgnum_diff
        ,case when als_m3_id_af_orgnum is null or als_m3_id_af_orgnum=0 then 361 else 90 end as als_m3_id_af_orgnum_diff
        ,case when als_m6_id_af_orgnum is null or als_m6_id_af_orgnum=0 then 361 else 180 end as als_m6_id_af_orgnum_diff
        ,case when als_m12_id_af_orgnum is null or als_m12_id_af_orgnum=0 then 361 else 360 end as als_m12_id_af_orgnum_diff
        ,case when als_d7_id_coon_orgnum is null or als_d7_id_coon_orgnum=0 then 361 else 7 end as als_d7_id_coon_orgnum_diff
        ,case when als_d15_id_coon_orgnum is null or als_d15_id_coon_orgnum=0 then 361 else 15 end as als_d15_id_coon_orgnum_diff
        ,case when als_m1_id_coon_orgnum is null or als_m1_id_coon_orgnum=0 then 361 else 30 end as als_m1_id_coon_orgnum_diff
        ,case when als_m3_id_coon_orgnum is null or als_m3_id_coon_orgnum=0 then 361 else 90 end as als_m3_id_coon_orgnum_diff
        ,case when als_m6_id_coon_orgnum is null or als_m6_id_coon_orgnum=0 then 361 else 180 end as als_m6_id_coon_orgnum_diff
        ,case when als_m12_id_coon_orgnum is null or als_m12_id_coon_orgnum=0 then 361 else 360 end as als_m12_id_coon_orgnum_diff
        ,case when als_d7_id_oth_orgnum is null or als_d7_id_oth_orgnum=0 then 361 else 7 end as als_d7_id_oth_orgnum_diff
        ,case when als_d15_id_oth_orgnum is null or als_d15_id_oth_orgnum=0 then 361 else 15 end as als_d15_id_oth_orgnum_diff
        ,case when als_m1_id_oth_orgnum is null or als_m1_id_oth_orgnum=0 then 361 else 30 end as als_m1_id_oth_orgnum_diff
        ,case when als_m3_id_oth_orgnum is null or als_m3_id_oth_orgnum=0 then 361 else 90 end as als_m3_id_oth_orgnum_diff
        ,case when als_m6_id_oth_orgnum is null or als_m6_id_oth_orgnum=0 then 361 else 180 end as als_m6_id_oth_orgnum_diff
        ,case when als_m12_id_oth_orgnum is null or als_m12_id_oth_orgnum=0 then 361 else 360 end as als_m12_id_oth_orgnum_diff
        ,case when als_d7_id_bank_orgnum is null or als_d7_id_bank_orgnum=0 then 361 else 7 end as als_d7_id_bank_orgnum_diff
        ,case when als_d15_id_bank_orgnum is null or als_d15_id_bank_orgnum=0 then 361 else 15 end as als_d15_id_bank_orgnum_diff
        ,case when als_m1_id_bank_orgnum is null or als_m1_id_bank_orgnum=0 then 361 else 30 end as als_m1_id_bank_orgnum_diff
        ,case when als_m3_id_bank_orgnum is null or als_m3_id_bank_orgnum=0 then 361 else 90 end as als_m3_id_bank_orgnum_diff
        ,case when als_m6_id_bank_orgnum is null or als_m6_id_bank_orgnum=0 then 361 else 180 end as als_m6_id_bank_orgnum_diff
        ,case when als_m12_id_bank_orgnum is null or als_m12_id_bank_orgnum=0 then 361 else 360 end as als_m12_id_bank_orgnum_diff
        ,case when als_d7_id_bank_tra_orgnum is null or als_d7_id_bank_tra_orgnum=0 then 361 else 7 end as als_d7_id_bank_tra_orgnum_diff
        ,case when als_d15_id_bank_tra_orgnum is null or als_d15_id_bank_tra_orgnum=0 then 361 else 15 end as als_d15_id_bank_tra_orgnum_diff
        ,case when als_m1_id_bank_tra_orgnum is null or als_m1_id_bank_tra_orgnum=0 then 361 else 30 end as als_m1_id_bank_tra_orgnum_diff
        ,case when als_m3_id_bank_tra_orgnum is null or als_m3_id_bank_tra_orgnum=0 then 361 else 90 end as als_m3_id_bank_tra_orgnum_diff
        ,case when als_m6_id_bank_tra_orgnum is null or als_m6_id_bank_tra_orgnum=0 then 361 else 180 end as als_m6_id_bank_tra_orgnum_diff
        ,case when als_m12_id_bank_tra_orgnum is null or als_m12_id_bank_tra_orgnum=0 then 361 else 360 end as als_m12_id_bank_tra_orgnum_diff
        ,case when als_d7_id_bank_ret_orgnum is null or als_d7_id_bank_ret_orgnum=0 then 361 else 7 end as als_d7_id_bank_ret_orgnum_diff
        ,case when als_d15_id_bank_ret_orgnum is null or als_d15_id_bank_ret_orgnum=0 then 361 else 15 end as als_d15_id_bank_ret_orgnum_diff
        ,case when als_m1_id_bank_ret_orgnum is null or als_m1_id_bank_ret_orgnum=0 then 361 else 30 end as als_m1_id_bank_ret_orgnum_diff
        ,case when als_m3_id_bank_ret_orgnum is null or als_m3_id_bank_ret_orgnum=0 then 361 else 90 end as als_m3_id_bank_ret_orgnum_diff
        ,case when als_m6_id_bank_ret_orgnum is null or als_m6_id_bank_ret_orgnum=0 then 361 else 180 end as als_m6_id_bank_ret_orgnum_diff
        ,case when als_m12_id_bank_ret_orgnum is null or als_m12_id_bank_ret_orgnum=0 then 361 else 360 end as als_m12_id_bank_ret_orgnum_diff
        ,case when als_d7_id_bank_week_orgnum is null or als_d7_id_bank_week_orgnum=0 then 361 else 7 end as als_d7_id_bank_week_orgnum_diff
        ,case when als_d15_id_bank_week_orgnum is null or als_d15_id_bank_week_orgnum=0 then 361 else 15 end as als_d15_id_bank_week_orgnum_diff
        ,case when als_m1_id_bank_week_orgnum is null or als_m1_id_bank_week_orgnum=0 then 361 else 30 end as als_m1_id_bank_week_orgnum_diff
        ,case when als_m3_id_bank_week_orgnum is null or als_m3_id_bank_week_orgnum=0 then 361 else 90 end as als_m3_id_bank_week_orgnum_diff
        ,case when als_m6_id_bank_week_orgnum is null or als_m6_id_bank_week_orgnum=0 then 361 else 180 end as als_m6_id_bank_week_orgnum_diff
        ,case when als_m12_id_bank_week_orgnum is null or als_m12_id_bank_week_orgnum=0 then 361 else 360 end as als_m12_id_bank_week_orgnum_diff
        ,case when als_d7_id_bank_night_orgnum is null or als_d7_id_bank_night_orgnum=0 then 361 else 7 end as als_d7_id_bank_night_orgnum_diff
        ,case when als_d15_id_bank_night_orgnum is null or als_d15_id_bank_night_orgnum=0 then 361 else 15 end as als_d15_id_bank_night_orgnum_diff
        ,case when als_m1_id_bank_night_orgnum is null or als_m1_id_bank_night_orgnum=0 then 361 else 30 end as als_m1_id_bank_night_orgnum_diff
        ,case when als_m3_id_bank_night_orgnum is null or als_m3_id_bank_night_orgnum=0 then 361 else 90 end as als_m3_id_bank_night_orgnum_diff
        ,case when als_m6_id_bank_night_orgnum is null or als_m6_id_bank_night_orgnum=0 then 361 else 180 end as als_m6_id_bank_night_orgnum_diff
        ,case when als_m12_id_bank_night_orgnum is null or als_m12_id_bank_night_orgnum=0 then 361 else 360 end as als_m12_id_bank_night_orgnum_diff
        ,case when als_d7_id_nbank_orgnum is null or als_d7_id_nbank_orgnum=0 then 361 else 7 end as als_d7_id_nbank_orgnum_diff
        ,case when als_d15_id_nbank_orgnum is null or als_d15_id_nbank_orgnum=0 then 361 else 15 end as als_d15_id_nbank_orgnum_diff
        ,case when als_m1_id_nbank_orgnum is null or als_m1_id_nbank_orgnum=0 then 361 else 30 end as als_m1_id_nbank_orgnum_diff
        ,case when als_m3_id_nbank_orgnum is null or als_m3_id_nbank_orgnum=0 then 361 else 90 end as als_m3_id_nbank_orgnum_diff
        ,case when als_m6_id_nbank_orgnum is null or als_m6_id_nbank_orgnum=0 then 361 else 180 end as als_m6_id_nbank_orgnum_diff
        ,case when als_m12_id_nbank_orgnum is null or als_m12_id_nbank_orgnum=0 then 361 else 360 end as als_m12_id_nbank_orgnum_diff
        ,case when als_d7_id_nbank_p2p_orgnum is null or als_d7_id_nbank_p2p_orgnum=0 then 361 else 7 end as als_d7_id_nbank_p2p_orgnum_diff
        ,case when als_d15_id_nbank_p2p_orgnum is null or als_d15_id_nbank_p2p_orgnum=0 then 361 else 15 end as als_d15_id_nbank_p2p_orgnum_diff
        ,case when als_m1_id_nbank_p2p_orgnum is null or als_m1_id_nbank_p2p_orgnum=0 then 361 else 30 end as als_m1_id_nbank_p2p_orgnum_diff
        ,case when als_m3_id_nbank_p2p_orgnum is null or als_m3_id_nbank_p2p_orgnum=0 then 361 else 90 end as als_m3_id_nbank_p2p_orgnum_diff
        ,case when als_m6_id_nbank_p2p_orgnum is null or als_m6_id_nbank_p2p_orgnum=0 then 361 else 180 end as als_m6_id_nbank_p2p_orgnum_diff
        ,case when als_m12_id_nbank_p2p_orgnum is null or als_m12_id_nbank_p2p_orgnum=0 then 361 else 360 end as als_m12_id_nbank_p2p_orgnum_diff
        ,case when als_d7_id_nbank_mc_orgnum is null or als_d7_id_nbank_mc_orgnum=0 then 361 else 7 end as als_d7_id_nbank_mc_orgnum_diff
        ,case when als_d15_id_nbank_mc_orgnum is null or als_d15_id_nbank_mc_orgnum=0 then 361 else 15 end as als_d15_id_nbank_mc_orgnum_diff
        ,case when als_m1_id_nbank_mc_orgnum is null or als_m1_id_nbank_mc_orgnum=0 then 361 else 30 end as als_m1_id_nbank_mc_orgnum_diff
        ,case when als_m3_id_nbank_mc_orgnum is null or als_m3_id_nbank_mc_orgnum=0 then 361 else 90 end as als_m3_id_nbank_mc_orgnum_diff
        ,case when als_m6_id_nbank_mc_orgnum is null or als_m6_id_nbank_mc_orgnum=0 then 361 else 180 end as als_m6_id_nbank_mc_orgnum_diff
        ,case when als_m12_id_nbank_mc_orgnum is null or als_m12_id_nbank_mc_orgnum=0 then 361 else 360 end as als_m12_id_nbank_mc_orgnum_diff
        ,case when als_d7_id_nbank_ca_orgnum is null or als_d7_id_nbank_ca_orgnum=0 then 361 else 7 end as als_d7_id_nbank_ca_orgnum_diff
        ,case when als_d15_id_nbank_ca_orgnum is null or als_d15_id_nbank_ca_orgnum=0 then 361 else 15 end as als_d15_id_nbank_ca_orgnum_diff
        ,case when als_m1_id_nbank_ca_orgnum is null or als_m1_id_nbank_ca_orgnum=0 then 361 else 30 end as als_m1_id_nbank_ca_orgnum_diff
        ,case when als_m3_id_nbank_ca_orgnum is null or als_m3_id_nbank_ca_orgnum=0 then 361 else 90 end as als_m3_id_nbank_ca_orgnum_diff
        ,case when als_m6_id_nbank_ca_orgnum is null or als_m6_id_nbank_ca_orgnum=0 then 361 else 180 end as als_m6_id_nbank_ca_orgnum_diff
        ,case when als_m12_id_nbank_ca_orgnum is null or als_m12_id_nbank_ca_orgnum=0 then 361 else 360 end as als_m12_id_nbank_ca_orgnum_diff
        ,case when als_d7_id_nbank_cf_orgnum is null or als_d7_id_nbank_cf_orgnum=0 then 361 else 7 end as als_d7_id_nbank_cf_orgnum_diff
        ,case when als_d15_id_nbank_cf_orgnum is null or als_d15_id_nbank_cf_orgnum=0 then 361 else 15 end as als_d15_id_nbank_cf_orgnum_diff
        ,case when als_m1_id_nbank_cf_orgnum is null or als_m1_id_nbank_cf_orgnum=0 then 361 else 30 end as als_m1_id_nbank_cf_orgnum_diff
        ,case when als_m3_id_nbank_cf_orgnum is null or als_m3_id_nbank_cf_orgnum=0 then 361 else 90 end as als_m3_id_nbank_cf_orgnum_diff
        ,case when als_m6_id_nbank_cf_orgnum is null or als_m6_id_nbank_cf_orgnum=0 then 361 else 180 end as als_m6_id_nbank_cf_orgnum_diff
        ,case when als_m12_id_nbank_cf_orgnum is null or als_m12_id_nbank_cf_orgnum=0 then 361 else 360 end as als_m12_id_nbank_cf_orgnum_diff
        ,case when als_d7_id_nbank_com_orgnum is null or als_d7_id_nbank_com_orgnum=0 then 361 else 7 end as als_d7_id_nbank_com_orgnum_diff
        ,case when als_d15_id_nbank_com_orgnum is null or als_d15_id_nbank_com_orgnum=0 then 361 else 15 end as als_d15_id_nbank_com_orgnum_diff
        ,case when als_m1_id_nbank_com_orgnum is null or als_m1_id_nbank_com_orgnum=0 then 361 else 30 end as als_m1_id_nbank_com_orgnum_diff
        ,case when als_m3_id_nbank_com_orgnum is null or als_m3_id_nbank_com_orgnum=0 then 361 else 90 end as als_m3_id_nbank_com_orgnum_diff
        ,case when als_m6_id_nbank_com_orgnum is null or als_m6_id_nbank_com_orgnum=0 then 361 else 180 end as als_m6_id_nbank_com_orgnum_diff
        ,case when als_m12_id_nbank_com_orgnum is null or als_m12_id_nbank_com_orgnum=0 then 361 else 360 end as als_m12_id_nbank_com_orgnum_diff
        ,case when als_d7_id_nbank_oth_orgnum is null or als_d7_id_nbank_oth_orgnum=0 then 361 else 7 end as als_d7_id_nbank_oth_orgnum_diff
        ,case when als_d15_id_nbank_oth_orgnum is null or als_d15_id_nbank_oth_orgnum=0 then 361 else 15 end as als_d15_id_nbank_oth_orgnum_diff
        ,case when als_m1_id_nbank_oth_orgnum is null or als_m1_id_nbank_oth_orgnum=0 then 361 else 30 end as als_m1_id_nbank_oth_orgnum_diff
        ,case when als_m3_id_nbank_oth_orgnum is null or als_m3_id_nbank_oth_orgnum=0 then 361 else 90 end as als_m3_id_nbank_oth_orgnum_diff
        ,case when als_m6_id_nbank_oth_orgnum is null or als_m6_id_nbank_oth_orgnum=0 then 361 else 180 end as als_m6_id_nbank_oth_orgnum_diff
        ,case when als_m12_id_nbank_oth_orgnum is null or als_m12_id_nbank_oth_orgnum=0 then 361 else 360 end as als_m12_id_nbank_oth_orgnum_diff
        ,case when als_d7_id_nbank_nsloan_orgnum is null or als_d7_id_nbank_nsloan_orgnum=0 then 361 else 7 end as als_d7_id_nbank_nsloan_orgnum_diff
        ,case when als_d15_id_nbank_nsloan_orgnum is null or als_d15_id_nbank_nsloan_orgnum=0 then 361 else 15 end as als_d15_id_nbank_nsloan_orgnum_diff
        ,case when als_m1_id_nbank_nsloan_orgnum is null or als_m1_id_nbank_nsloan_orgnum=0 then 361 else 30 end as als_m1_id_nbank_nsloan_orgnum_diff
        ,case when als_m3_id_nbank_nsloan_orgnum is null or als_m3_id_nbank_nsloan_orgnum=0 then 361 else 90 end as als_m3_id_nbank_nsloan_orgnum_diff
        ,case when als_m6_id_nbank_nsloan_orgnum is null or als_m6_id_nbank_nsloan_orgnum=0 then 361 else 180 end as als_m6_id_nbank_nsloan_orgnum_diff
        ,case when als_m12_id_nbank_nsloan_orgnum is null or als_m12_id_nbank_nsloan_orgnum=0 then 361 else 360 end as als_m12_id_nbank_nsloan_orgnum_diff
        ,case when als_d7_id_nbank_autofin_orgnum is null or als_d7_id_nbank_autofin_orgnum=0 then 361 else 7 end as als_d7_id_nbank_autofin_orgnum_diff
        ,case when als_d15_id_nbank_autofin_orgnum is null or als_d15_id_nbank_autofin_orgnum=0 then 361 else 15 end as als_d15_id_nbank_autofin_orgnum_diff
        ,case when als_m1_id_nbank_autofin_orgnum is null or als_m1_id_nbank_autofin_orgnum=0 then 361 else 30 end as als_m1_id_nbank_autofin_orgnum_diff
        ,case when als_m3_id_nbank_autofin_orgnum is null or als_m3_id_nbank_autofin_orgnum=0 then 361 else 90 end as als_m3_id_nbank_autofin_orgnum_diff
        ,case when als_m6_id_nbank_autofin_orgnum is null or als_m6_id_nbank_autofin_orgnum=0 then 361 else 180 end as als_m6_id_nbank_autofin_orgnum_diff
        ,case when als_m12_id_nbank_autofin_orgnum is null or als_m12_id_nbank_autofin_orgnum=0 then 361 else 360 end as als_m12_id_nbank_autofin_orgnum_diff
        ,case when als_d7_id_nbank_sloan_orgnum is null or als_d7_id_nbank_sloan_orgnum=0 then 361 else 7 end as als_d7_id_nbank_sloan_orgnum_diff
        ,case when als_d15_id_nbank_sloan_orgnum is null or als_d15_id_nbank_sloan_orgnum=0 then 361 else 15 end as als_d15_id_nbank_sloan_orgnum_diff
        ,case when als_m1_id_nbank_sloan_orgnum is null or als_m1_id_nbank_sloan_orgnum=0 then 361 else 30 end as als_m1_id_nbank_sloan_orgnum_diff
        ,case when als_m3_id_nbank_sloan_orgnum is null or als_m3_id_nbank_sloan_orgnum=0 then 361 else 90 end as als_m3_id_nbank_sloan_orgnum_diff
        ,case when als_m6_id_nbank_sloan_orgnum is null or als_m6_id_nbank_sloan_orgnum=0 then 361 else 180 end as als_m6_id_nbank_sloan_orgnum_diff
        ,case when als_m12_id_nbank_sloan_orgnum is null or als_m12_id_nbank_sloan_orgnum=0 then 361 else 360 end as als_m12_id_nbank_sloan_orgnum_diff
        ,case when als_d7_id_nbank_cons_orgnum is null or als_d7_id_nbank_cons_orgnum=0 then 361 else 7 end as als_d7_id_nbank_cons_orgnum_diff
        ,case when als_d15_id_nbank_cons_orgnum is null or als_d15_id_nbank_cons_orgnum=0 then 361 else 15 end as als_d15_id_nbank_cons_orgnum_diff
        ,case when als_m1_id_nbank_cons_orgnum is null or als_m1_id_nbank_cons_orgnum=0 then 361 else 30 end as als_m1_id_nbank_cons_orgnum_diff
        ,case when als_m3_id_nbank_cons_orgnum is null or als_m3_id_nbank_cons_orgnum=0 then 361 else 90 end as als_m3_id_nbank_cons_orgnum_diff
        ,case when als_m6_id_nbank_cons_orgnum is null or als_m6_id_nbank_cons_orgnum=0 then 361 else 180 end as als_m6_id_nbank_cons_orgnum_diff
        ,case when als_m12_id_nbank_cons_orgnum is null or als_m12_id_nbank_cons_orgnum=0 then 361 else 360 end as als_m12_id_nbank_cons_orgnum_diff
        ,case when als_d7_id_nbank_finlea_orgnum is null or als_d7_id_nbank_finlea_orgnum=0 then 361 else 7 end as als_d7_id_nbank_finlea_orgnum_diff
        ,case when als_d15_id_nbank_finlea_orgnum is null or als_d15_id_nbank_finlea_orgnum=0 then 361 else 15 end as als_d15_id_nbank_finlea_orgnum_diff
        ,case when als_m1_id_nbank_finlea_orgnum is null or als_m1_id_nbank_finlea_orgnum=0 then 361 else 30 end as als_m1_id_nbank_finlea_orgnum_diff
        ,case when als_m3_id_nbank_finlea_orgnum is null or als_m3_id_nbank_finlea_orgnum=0 then 361 else 90 end as als_m3_id_nbank_finlea_orgnum_diff
        ,case when als_m6_id_nbank_finlea_orgnum is null or als_m6_id_nbank_finlea_orgnum=0 then 361 else 180 end as als_m6_id_nbank_finlea_orgnum_diff
        ,case when als_m12_id_nbank_finlea_orgnum is null or als_m12_id_nbank_finlea_orgnum=0 then 361 else 360 end as als_m12_id_nbank_finlea_orgnum_diff
        ,case when als_d7_id_nbank_else_orgnum is null or als_d7_id_nbank_else_orgnum=0 then 361 else 7 end as als_d7_id_nbank_else_orgnum_diff
        ,case when als_d15_id_nbank_else_orgnum is null or als_d15_id_nbank_else_orgnum=0 then 361 else 15 end as als_d15_id_nbank_else_orgnum_diff
        ,case when als_m1_id_nbank_else_orgnum is null or als_m1_id_nbank_else_orgnum=0 then 361 else 30 end as als_m1_id_nbank_else_orgnum_diff
        ,case when als_m3_id_nbank_else_orgnum is null or als_m3_id_nbank_else_orgnum=0 then 361 else 90 end as als_m3_id_nbank_else_orgnum_diff
        ,case when als_m6_id_nbank_else_orgnum is null or als_m6_id_nbank_else_orgnum=0 then 361 else 180 end as als_m6_id_nbank_else_orgnum_diff
        ,case when als_m12_id_nbank_else_orgnum is null or als_m12_id_nbank_else_orgnum=0 then 361 else 360 end as als_m12_id_nbank_else_orgnum_diff
        ,case when als_d7_id_nbank_week_orgnum is null or als_d7_id_nbank_week_orgnum=0 then 361 else 7 end as als_d7_id_nbank_week_orgnum_diff
        ,case when als_d15_id_nbank_week_orgnum is null or als_d15_id_nbank_week_orgnum=0 then 361 else 15 end as als_d15_id_nbank_week_orgnum_diff
        ,case when als_m1_id_nbank_week_orgnum is null or als_m1_id_nbank_week_orgnum=0 then 361 else 30 end as als_m1_id_nbank_week_orgnum_diff
        ,case when als_m3_id_nbank_week_orgnum is null or als_m3_id_nbank_week_orgnum=0 then 361 else 90 end as als_m3_id_nbank_week_orgnum_diff
        ,case when als_m6_id_nbank_week_orgnum is null or als_m6_id_nbank_week_orgnum=0 then 361 else 180 end as als_m6_id_nbank_week_orgnum_diff
        ,case when als_m12_id_nbank_week_orgnum is null or als_m12_id_nbank_week_orgnum=0 then 361 else 360 end as als_m12_id_nbank_week_orgnum_diff
        ,case when als_d7_id_nbank_night_orgnum is null or als_d7_id_nbank_night_orgnum=0 then 361 else 7 end as als_d7_id_nbank_night_orgnum_diff
        ,case when als_d15_id_nbank_night_orgnum is null or als_d15_id_nbank_night_orgnum=0 then 361 else 15 end as als_d15_id_nbank_night_orgnum_diff
        ,case when als_m1_id_nbank_night_orgnum is null or als_m1_id_nbank_night_orgnum=0 then 361 else 30 end as als_m1_id_nbank_night_orgnum_diff
        ,case when als_m3_id_nbank_night_orgnum is null or als_m3_id_nbank_night_orgnum=0 then 361 else 90 end as als_m3_id_nbank_night_orgnum_diff
        ,case when als_m6_id_nbank_night_orgnum is null or als_m6_id_nbank_night_orgnum=0 then 361 else 180 end as als_m6_id_nbank_night_orgnum_diff
        ,case when als_m12_id_nbank_night_orgnum is null or als_m12_id_nbank_night_orgnum=0 then 361 else 360 end as als_m12_id_nbank_night_orgnum_diff

        ,data_id
        ,code
        ,flag_applyloanstr
        ,swift_number
        ,created_at
        ,updated_at
    from ${pdm_risk}.pdm_risk_dz_daily_br_cast_float_feature
    where ds = '${bizdate}'
) t;

insert overwrite table ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_v2 partition (ds='${bizdate}')
select uid

    -- 距离 首次查得时间
    ,als_least_id_pdl_orgnum
    ,als_least_id_caon_orgnum
    ,als_least_id_rel_orgnum
    ,als_least_id_caoff_orgnum
    ,als_least_id_cooff_orgnum
    ,als_least_id_af_orgnum
    ,als_least_id_coon_orgnum
    ,als_least_id_oth_orgnum
    ,als_least_id_bank_orgnum
    ,als_least_id_bank_tra_orgnum
    ,als_least_id_bank_ret_orgnum
    ,als_least_id_bank_week_orgnum
    ,als_least_id_bank_night_orgnum
    ,als_least_id_nbank_orgnum
    ,als_least_id_nbank_p2p_orgnum
    ,als_least_id_nbank_mc_orgnum
    ,als_least_id_nbank_ca_orgnum
    ,als_least_id_nbank_cf_orgnum
    ,als_least_id_nbank_com_orgnum
    ,als_least_id_nbank_oth_orgnum
    ,als_least_id_nbank_nsloan_orgnum
    ,als_least_id_nbank_autofin_orgnum
    ,als_least_id_nbank_sloan_orgnum
    ,als_least_id_nbank_cons_orgnum
    ,als_least_id_nbank_finlea_orgnum
    ,als_least_id_nbank_else_orgnum
    ,als_least_id_nbank_week_orgnum
    ,als_least_id_nbank_night_orgnum

    ,als_greast_id_pdl_orgnum
    ,als_greast_id_caon_orgnum
    ,als_greast_id_rel_orgnum
    ,als_greast_id_caoff_orgnum
    ,als_greast_id_cooff_orgnum
    ,als_greast_id_af_orgnum
    ,als_greast_id_coon_orgnum
    ,als_greast_id_oth_orgnum
    ,als_greast_id_bank_orgnum
    ,als_greast_id_bank_tra_orgnum
    ,als_greast_id_bank_ret_orgnum
    ,als_greast_id_bank_week_orgnum
    ,als_greast_id_bank_night_orgnum
    ,als_greast_id_nbank_orgnum
    ,als_greast_id_nbank_p2p_orgnum
    ,als_greast_id_nbank_mc_orgnum
    ,als_greast_id_nbank_ca_orgnum
    ,als_greast_id_nbank_cf_orgnum
    ,als_greast_id_nbank_com_orgnum
    ,als_greast_id_nbank_oth_orgnum
    ,als_greast_id_nbank_nsloan_orgnum
    ,als_greast_id_nbank_autofin_orgnum
    ,als_greast_id_nbank_sloan_orgnum
    ,als_greast_id_nbank_cons_orgnum
    ,als_greast_id_nbank_finlea_orgnum
    ,als_greast_id_nbank_else_orgnum
    ,als_greast_id_nbank_week_orgnum
    ,als_greast_id_nbank_night_orgnum

    ,als_other_allnum
    ,als_car_loan_allnum
    ,als_petty_loan_allnum

    ,als_other_orgnum
    ,als_car_loan_orgnum
    ,als_petty_loan_orgnum

    -- 查得 占比  ** 错误需要修改 %% 已修改

    ,als_other_orgnum / sum_typ_orgnum as als_other_sum_typ_orgnum_rte
    ,als_licensed_net_loan_orgnum / sum_typ_orgnum as als_licensed_net_loan_sum_typ_orgnum_rte
    ,als_old_bank_orgnum / sum_typ_orgnum as als_old_bank_sum_typ_orgnum_rte
    ,als_car_loan_orgnum / sum_typ_orgnum as als_car_loan_sum_typ_orgnum_rte
    ,als_net_bank_orgnum / sum_typ_orgnum as als_net_bank_sum_typ_orgnum_rte
    ,als_cash_stage_orgnum / sum_typ_orgnum as als_cash_stage_sum_typ_orgnum_rte
    ,als_consume_stage_orgnum / sum_typ_orgnum as als_consume_stage_sum_typ_orgnum_rte
    ,als_consume_loan_orgnum / sum_typ_orgnum as als_consume_loan_sum_typ_orgnum_rte
    ,als_petty_loan_orgnum / sum_typ_orgnum as als_petty_loan_sum_typ_orgnum_rte
    ,als_credit_card_orgnum / sum_typ_orgnum as als_credit_card_sum_typ_orgnum_rte
    ,als_other_allnum / sum_typ_allnum as als_other_sum_typ_allnum_rte
    ,als_licensed_net_loan_allnum / sum_typ_allnum as als_licensed_net_loan_sum_typ_allnum_rte
    ,als_old_bank_allnum / sum_typ_allnum as als_old_bank_sum_typ_allnum_rte
    ,als_car_loan_allnum / sum_typ_allnum as als_car_loan_sum_typ_allnum_rte
    ,als_net_bank_allnum / sum_typ_allnum as als_net_bank_sum_typ_allnum_rte
    ,als_cash_stage_allnum / sum_typ_allnum as als_cash_stage_sum_typ_allnum_rte
    ,als_consume_stage_allnum / sum_typ_allnum as als_consume_stage_sum_typ_allnum_rte
    ,als_consume_loan_allnum / sum_typ_allnum as als_consume_loan_sum_typ_allnum_rte
    ,als_petty_loan_allnum / sum_typ_allnum as als_petty_loan_sum_typ_allnum_rte
    ,als_credit_card_allnum / sum_typ_allnum as als_credit_card_sum_typ_allnum_rte

    -- 机构构成得分
    ,als_org_score
    ,als_org_score / sum_typ_orgnum as als_org_score_avg
    ,sum_typ_orgnum
    ,sum_typ_allnum

    ,data_id
    ,code
    ,flag_applyloanstr
    ,swift_number
    ,created_at
    ,updated_at
    ,current_timestamp() as rcd_tim
from 
(
    select uid

        ,als_other_allnum
        ,als_licensed_net_loan_allnum
        ,als_old_bank_allnum
        ,als_car_loan_allnum
        ,als_net_bank_allnum
        ,als_cash_stage_allnum
        ,als_consume_stage_allnum
        ,als_consume_loan_allnum
        ,als_petty_loan_allnum
        ,als_credit_card_allnum
        ,als_other_orgnum
        ,als_licensed_net_loan_orgnum
        ,als_old_bank_orgnum
        ,als_car_loan_orgnum
        ,als_net_bank_orgnum
        ,als_cash_stage_orgnum
        ,als_consume_stage_orgnum
        ,als_consume_loan_orgnum
        ,als_petty_loan_orgnum
        ,als_credit_card_orgnum

        ,als_least_id_pdl_orgnum
        ,als_least_id_caon_orgnum
        ,als_least_id_rel_orgnum
        ,als_least_id_caoff_orgnum
        ,als_least_id_cooff_orgnum
        ,als_least_id_af_orgnum
        ,als_least_id_coon_orgnum
        ,als_least_id_oth_orgnum
        ,als_least_id_bank_orgnum
        ,als_least_id_bank_tra_orgnum
        ,als_least_id_bank_ret_orgnum
        ,als_least_id_bank_week_orgnum
        ,als_least_id_bank_night_orgnum
        ,als_least_id_nbank_orgnum
        ,als_least_id_nbank_p2p_orgnum
        ,als_least_id_nbank_mc_orgnum
        ,als_least_id_nbank_ca_orgnum
        ,als_least_id_nbank_cf_orgnum
        ,als_least_id_nbank_com_orgnum
        ,als_least_id_nbank_oth_orgnum
        ,als_least_id_nbank_nsloan_orgnum
        ,als_least_id_nbank_autofin_orgnum
        ,als_least_id_nbank_sloan_orgnum
        ,als_least_id_nbank_cons_orgnum
        ,als_least_id_nbank_finlea_orgnum
        ,als_least_id_nbank_else_orgnum
        ,als_least_id_nbank_week_orgnum
        ,als_least_id_nbank_night_orgnum

        ,case when als_m6_m12_id_pdl_orgnum > 0 then 360
            when als_m3_m6_id_pdl_orgnum > 0 then 180
            when als_m1_m3_id_pdl_orgnum > 0 then 90
            when als_d15_m1_id_pdl_orgnum > 0 then 30
            when als_d7_d15_id_pdl_orgnum > 0 then 15
            when als_d7_id_pdl_orgnum > 0 then 7 
            else null 
        end as als_greast_id_pdl_orgnum

        ,case when als_m6_m12_id_caon_orgnum > 0 then 360
            when als_m3_m6_id_caon_orgnum > 0 then 180
            when als_m1_m3_id_caon_orgnum > 0 then 90
            when als_d15_m1_id_caon_orgnum > 0 then 30
            when als_d7_d15_id_caon_orgnum > 0 then 15
            when als_d7_id_caon_orgnum > 0 then 7 
            else null 
        end as als_greast_id_caon_orgnum

        ,case when als_m6_m12_id_rel_orgnum > 0 then 360
            when als_m3_m6_id_rel_orgnum > 0 then 180
            when als_m1_m3_id_rel_orgnum > 0 then 90
            when als_d15_m1_id_rel_orgnum > 0 then 30
            when als_d7_d15_id_rel_orgnum > 0 then 15
            when als_d7_id_rel_orgnum > 0 then 7 
            else null 
        end as als_greast_id_rel_orgnum

        ,case when als_m6_m12_id_caoff_orgnum > 0 then 360
            when als_m3_m6_id_caoff_orgnum > 0 then 180
            when als_m1_m3_id_caoff_orgnum > 0 then 90
            when als_d15_m1_id_caoff_orgnum > 0 then 30
            when als_d7_d15_id_caoff_orgnum > 0 then 15
            when als_d7_id_caoff_orgnum > 0 then 7 
            else null 
        end as als_greast_id_caoff_orgnum

        ,case when als_m6_m12_id_cooff_orgnum > 0 then 360
            when als_m3_m6_id_cooff_orgnum > 0 then 180
            when als_m1_m3_id_cooff_orgnum > 0 then 90
            when als_d15_m1_id_cooff_orgnum > 0 then 30
            when als_d7_d15_id_cooff_orgnum > 0 then 15
            when als_d7_id_cooff_orgnum > 0 then 7 
            else null 
        end as als_greast_id_cooff_orgnum

        ,case when als_m6_m12_id_af_orgnum > 0 then 360
            when als_m3_m6_id_af_orgnum > 0 then 180
            when als_m1_m3_id_af_orgnum > 0 then 90
            when als_d15_m1_id_af_orgnum > 0 then 30
            when als_d7_d15_id_af_orgnum > 0 then 15
            when als_d7_id_af_orgnum > 0 then 7 
            else null 
        end as als_greast_id_af_orgnum

        ,case when als_m6_m12_id_coon_orgnum > 0 then 360
            when als_m3_m6_id_coon_orgnum > 0 then 180
            when als_m1_m3_id_coon_orgnum > 0 then 90
            when als_d15_m1_id_coon_orgnum > 0 then 30
            when als_d7_d15_id_coon_orgnum > 0 then 15
            when als_d7_id_coon_orgnum > 0 then 7 
            else null 
        end as als_greast_id_coon_orgnum

        ,case when als_m6_m12_id_oth_orgnum > 0 then 360
            when als_m3_m6_id_oth_orgnum > 0 then 180
            when als_m1_m3_id_oth_orgnum > 0 then 90
            when als_d15_m1_id_oth_orgnum > 0 then 30
            when als_d7_d15_id_oth_orgnum > 0 then 15
            when als_d7_id_oth_orgnum > 0 then 7 
            else null 
        end as als_greast_id_oth_orgnum

        ,case when als_m6_m12_id_bank_orgnum > 0 then 360
            when als_m3_m6_id_bank_orgnum > 0 then 180
            when als_m1_m3_id_bank_orgnum > 0 then 90
            when als_d15_m1_id_bank_orgnum > 0 then 30
            when als_d7_d15_id_bank_orgnum > 0 then 15
            when als_d7_id_bank_orgnum > 0 then 7 
            else null 
        end as als_greast_id_bank_orgnum

        ,case when als_m6_m12_id_bank_tra_orgnum > 0 then 360
            when als_m3_m6_id_bank_tra_orgnum > 0 then 180
            when als_m1_m3_id_bank_tra_orgnum > 0 then 90
            when als_d15_m1_id_bank_tra_orgnum > 0 then 30
            when als_d7_d15_id_bank_tra_orgnum > 0 then 15
            when als_d7_id_bank_tra_orgnum > 0 then 7 
            else null 
        end as als_greast_id_bank_tra_orgnum

        ,case when als_m6_m12_id_bank_ret_orgnum > 0 then 360
            when als_m3_m6_id_bank_ret_orgnum > 0 then 180
            when als_m1_m3_id_bank_ret_orgnum > 0 then 90
            when als_d15_m1_id_bank_ret_orgnum > 0 then 30
            when als_d7_d15_id_bank_ret_orgnum > 0 then 15
            when als_d7_id_bank_ret_orgnum > 0 then 7 
            else null 
        end as als_greast_id_bank_ret_orgnum

        ,case when als_m6_m12_id_bank_week_orgnum > 0 then 360
            when als_m3_m6_id_bank_week_orgnum > 0 then 180
            when als_m1_m3_id_bank_week_orgnum > 0 then 90
            when als_d15_m1_id_bank_week_orgnum > 0 then 30
            when als_d7_d15_id_bank_week_orgnum > 0 then 15
            when als_d7_id_bank_week_orgnum > 0 then 7 
            else null 
        end as als_greast_id_bank_week_orgnum

        ,case when als_m6_m12_id_bank_night_orgnum > 0 then 360
            when als_m3_m6_id_bank_night_orgnum > 0 then 180
            when als_m1_m3_id_bank_night_orgnum > 0 then 90
            when als_d15_m1_id_bank_night_orgnum > 0 then 30
            when als_d7_d15_id_bank_night_orgnum > 0 then 15
            when als_d7_id_bank_night_orgnum > 0 then 7 
            else null 
        end as als_greast_id_bank_night_orgnum

        ,case when als_m6_m12_id_nbank_orgnum > 0 then 360
            when als_m3_m6_id_nbank_orgnum > 0 then 180
            when als_m1_m3_id_nbank_orgnum > 0 then 90
            when als_d15_m1_id_nbank_orgnum > 0 then 30
            when als_d7_d15_id_nbank_orgnum > 0 then 15
            when als_d7_id_nbank_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_orgnum

        ,case when als_m6_m12_id_nbank_p2p_orgnum > 0 then 360
            when als_m3_m6_id_nbank_p2p_orgnum > 0 then 180
            when als_m1_m3_id_nbank_p2p_orgnum > 0 then 90
            when als_d15_m1_id_nbank_p2p_orgnum > 0 then 30
            when als_d7_d15_id_nbank_p2p_orgnum > 0 then 15
            when als_d7_id_nbank_p2p_orgnum > 0 then 7 
        else null end as als_greast_id_nbank_p2p_orgnum

        ,case when als_m6_m12_id_nbank_mc_orgnum > 0 then 360
            when als_m3_m6_id_nbank_mc_orgnum > 0 then 180
            when als_m1_m3_id_nbank_mc_orgnum > 0 then 90
            when als_d15_m1_id_nbank_mc_orgnum > 0 then 30
            when als_d7_d15_id_nbank_mc_orgnum > 0 then 15
            when als_d7_id_nbank_mc_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_mc_orgnum

        ,case when als_m6_m12_id_nbank_ca_orgnum > 0 then 360
            when als_m3_m6_id_nbank_ca_orgnum > 0 then 180
            when als_m1_m3_id_nbank_ca_orgnum > 0 then 90
            when als_d15_m1_id_nbank_ca_orgnum > 0 then 30
            when als_d7_d15_id_nbank_ca_orgnum > 0 then 15
            when als_d7_id_nbank_ca_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_ca_orgnum

        ,case when als_m6_m12_id_nbank_cf_orgnum > 0 then 360
            when als_m3_m6_id_nbank_cf_orgnum > 0 then 180
            when als_m1_m3_id_nbank_cf_orgnum > 0 then 90
            when als_d15_m1_id_nbank_cf_orgnum > 0 then 30
            when als_d7_d15_id_nbank_cf_orgnum > 0 then 15
            when als_d7_id_nbank_cf_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_cf_orgnum

        ,case when als_m6_m12_id_nbank_com_orgnum > 0 then 360
            when als_m3_m6_id_nbank_com_orgnum > 0 then 180
            when als_m1_m3_id_nbank_com_orgnum > 0 then 90
            when als_d15_m1_id_nbank_com_orgnum > 0 then 30
            when als_d7_d15_id_nbank_com_orgnum > 0 then 15
            when als_d7_id_nbank_com_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_com_orgnum

        ,case when als_m6_m12_id_nbank_oth_orgnum > 0 then 360
            when als_m3_m6_id_nbank_oth_orgnum > 0 then 180
            when als_m1_m3_id_nbank_oth_orgnum > 0 then 90
            when als_d15_m1_id_nbank_oth_orgnum > 0 then 30
            when als_d7_d15_id_nbank_oth_orgnum > 0 then 15
            when als_d7_id_nbank_oth_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_oth_orgnum

        ,case when als_m6_m12_id_nbank_nsloan_orgnum > 0 then 360
            when als_m3_m6_id_nbank_nsloan_orgnum > 0 then 180
            when als_m1_m3_id_nbank_nsloan_orgnum > 0 then 90
            when als_d15_m1_id_nbank_nsloan_orgnum > 0 then 30
            when als_d7_d15_id_nbank_nsloan_orgnum > 0 then 15
            when als_d7_id_nbank_nsloan_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_nsloan_orgnum

        ,case when als_m6_m12_id_nbank_autofin_orgnum > 0 then 360
            when als_m3_m6_id_nbank_autofin_orgnum > 0 then 180
            when als_m1_m3_id_nbank_autofin_orgnum > 0 then 90
            when als_d15_m1_id_nbank_autofin_orgnum > 0 then 30
            when als_d7_d15_id_nbank_autofin_orgnum > 0 then 15
            when als_d7_id_nbank_autofin_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_autofin_orgnum

        ,case when als_m6_m12_id_nbank_sloan_orgnum > 0 then 360
            when als_m3_m6_id_nbank_sloan_orgnum > 0 then 180
            when als_m1_m3_id_nbank_sloan_orgnum > 0 then 90
            when als_d15_m1_id_nbank_sloan_orgnum > 0 then 30
            when als_d7_d15_id_nbank_sloan_orgnum > 0 then 15
            when als_d7_id_nbank_sloan_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_sloan_orgnum

        ,case when als_m6_m12_id_nbank_cons_orgnum > 0 then 360
            when als_m3_m6_id_nbank_cons_orgnum > 0 then 180
            when als_m1_m3_id_nbank_cons_orgnum > 0 then 90
            when als_d15_m1_id_nbank_cons_orgnum > 0 then 30
            when als_d7_d15_id_nbank_cons_orgnum > 0 then 15
            when als_d7_id_nbank_cons_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_cons_orgnum

        ,case when als_m6_m12_id_nbank_finlea_orgnum > 0 then 360
            when als_m3_m6_id_nbank_finlea_orgnum > 0 then 180
            when als_m1_m3_id_nbank_finlea_orgnum > 0 then 90
            when als_d15_m1_id_nbank_finlea_orgnum > 0 then 30
            when als_d7_d15_id_nbank_finlea_orgnum > 0 then 15
            when als_d7_id_nbank_finlea_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_finlea_orgnum

        ,case when als_m6_m12_id_nbank_else_orgnum > 0 then 360
            when als_m3_m6_id_nbank_else_orgnum > 0 then 180
            when als_m1_m3_id_nbank_else_orgnum > 0 then 90
            when als_d15_m1_id_nbank_else_orgnum > 0 then 30
            when als_d7_d15_id_nbank_else_orgnum > 0 then 15
            when als_d7_id_nbank_else_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_else_orgnum

        ,case when als_m6_m12_id_nbank_week_orgnum > 0 then 360
            when als_m3_m6_id_nbank_week_orgnum > 0 then 180
            when als_m1_m3_id_nbank_week_orgnum > 0 then 90
            when als_d15_m1_id_nbank_week_orgnum > 0 then 30
            when als_d7_d15_id_nbank_week_orgnum > 0 then 15
            when als_d7_id_nbank_week_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_week_orgnum

        ,case when als_m6_m12_id_nbank_night_orgnum > 0 then 360
            when als_m3_m6_id_nbank_night_orgnum > 0 then 180
            when als_m1_m3_id_nbank_night_orgnum > 0 then 90
            when als_d15_m1_id_nbank_night_orgnum > 0 then 30
            when als_d7_d15_id_nbank_night_orgnum > 0 then 15
            when als_d7_id_nbank_night_orgnum > 0 then 7 
            else null 
        end as als_greast_id_nbank_night_orgnum

        -- 用于计算 距离首借的时间
        ,als_other_orgnum * 8 + als_licensed_net_loan_orgnum * 2 + als_old_bank_orgnum * 4 + als_car_loan_orgnum * 10 + als_net_bank_orgnum * 1 + als_cash_stage_orgnum * 7 + als_consume_stage_orgnum * 5 + als_consume_loan_orgnum * 6 + als_petty_loan_orgnum * 9 + als_credit_card_orgnum * 3 as als_org_score
        ,als_other_orgnum + als_licensed_net_loan_orgnum + als_old_bank_orgnum + als_car_loan_orgnum + als_net_bank_orgnum + als_cash_stage_orgnum + als_consume_stage_orgnum + als_consume_loan_orgnum + als_petty_loan_orgnum + als_credit_card_orgnum as sum_typ_orgnum
        ,als_other_allnum + als_licensed_net_loan_allnum + als_old_bank_allnum + als_car_loan_allnum + als_net_bank_allnum + als_cash_stage_allnum + als_consume_stage_allnum + als_consume_loan_allnum + als_petty_loan_allnum + als_credit_card_allnum as sum_typ_allnum
    
        ,data_id
        ,code
        ,flag_applyloanstr
        ,swift_number
        ,created_at
        ,updated_at
    from ${pdm_risk}.pdm_risk_dz_daily_br_trend_feature_v2_tmp
) t;
-- feature-copilot:node-end ordinal=0
