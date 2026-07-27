-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1
-- node_id: n_4434269715540541440
-- task_name: pdm_risk_dz_daily_br_vertical_trend_feature_v3_di
-- owner_name: 刘诗涵
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1.json
-- source_json_sha256: b6a2e99fe437ea52f6db25cae392f9e34dbf27982b4d77d4a57beffa98ca7cad
-- upstream_table: dbus.dbus_dz_daily_br_trend_feature_v3_base_di
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp4
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp2
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1
-- upstream_table: pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp3

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 百融多头三期趋势特征v3_2-纵向维度，描述用户在机构维度的借贷行为分布，每日查询样本更新, 贷前贷中两张表union
--创建者: 刘诗涵
--创建日期: 2023-02-01 14:27:14
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- 纵向趋势
set odps.stage.mapper.split.size=20;

-- 单变量趋势变化
drop table if exists pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1;
create table pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1 as
select uid
        ,swift_number
        -- 注：当多头数均为0赋值为-1
        -- 贷款/机构类型趋势
        ,case when als_id_d15_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_loan_typ_orgnum_sum/als_id_d15_loan_typ_orgnum_sum end as als_id_d7_d15_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_loan_typ_orgnum_sum/als_id_m1_loan_typ_orgnum_sum end as als_id_d7_m1_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_loan_typ_orgnum_sum/als_id_m3_loan_typ_orgnum_sum end as als_id_d7_m3_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_loan_typ_orgnum_sum/als_id_m6_loan_typ_orgnum_sum end as als_id_d7_m6_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_loan_typ_orgnum_sum/als_id_m12_loan_typ_orgnum_sum end as als_id_d7_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_loan_typ_orgnum_sum/als_id_m1_loan_typ_orgnum_sum end as als_id_d15_m1_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_loan_typ_orgnum_sum/als_id_m3_loan_typ_orgnum_sum end as als_id_d15_m3_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_loan_typ_orgnum_sum/als_id_m6_loan_typ_orgnum_sum end as als_id_d15_m6_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_loan_typ_orgnum_sum/als_id_m12_loan_typ_orgnum_sum end as als_id_d15_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_loan_typ_orgnum_sum/als_id_m3_loan_typ_orgnum_sum end as als_id_m1_m3_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_loan_typ_orgnum_sum/als_id_m6_loan_typ_orgnum_sum end as als_id_m1_m6_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_loan_typ_orgnum_sum/als_id_m12_loan_typ_orgnum_sum end as als_id_m1_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_loan_typ_orgnum_sum/als_id_m6_loan_typ_orgnum_sum end as als_id_m3_m6_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_loan_typ_orgnum_sum/als_id_m12_loan_typ_orgnum_sum end as als_id_m3_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_loan_typ_orgnum_sum = 0 then -1 else als_id_m6_loan_typ_orgnum_sum/als_id_m12_loan_typ_orgnum_sum end as als_id_m6_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_loan_typ_allnum_sum = 0 then -1 else als_id_d7_loan_typ_allnum_sum/als_id_d15_loan_typ_allnum_sum end as als_id_d7_d15_loan_typ_allnum_sum_rto
        ,case when als_id_m1_loan_typ_allnum_sum = 0 then -1 else als_id_d7_loan_typ_allnum_sum/als_id_m1_loan_typ_allnum_sum end as als_id_d7_m1_loan_typ_allnum_sum_rto
        ,case when als_id_m3_loan_typ_allnum_sum = 0 then -1 else als_id_d7_loan_typ_allnum_sum/als_id_m3_loan_typ_allnum_sum end as als_id_d7_m3_loan_typ_allnum_sum_rto
        ,case when als_id_m6_loan_typ_allnum_sum = 0 then -1 else als_id_d7_loan_typ_allnum_sum/als_id_m6_loan_typ_allnum_sum end as als_id_d7_m6_loan_typ_allnum_sum_rto
        ,case when als_id_m12_loan_typ_allnum_sum = 0 then -1 else als_id_d7_loan_typ_allnum_sum/als_id_m12_loan_typ_allnum_sum end as als_id_d7_m12_loan_typ_allnum_sum_rto
        ,case when als_id_m1_loan_typ_allnum_sum = 0 then -1 else als_id_d15_loan_typ_allnum_sum/als_id_m1_loan_typ_allnum_sum end as als_id_d15_m1_loan_typ_allnum_sum_rto
        ,case when als_id_m3_loan_typ_allnum_sum = 0 then -1 else als_id_d15_loan_typ_allnum_sum/als_id_m3_loan_typ_allnum_sum end as als_id_d15_m3_loan_typ_allnum_sum_rto
        ,case when als_id_m6_loan_typ_allnum_sum = 0 then -1 else als_id_d15_loan_typ_allnum_sum/als_id_m6_loan_typ_allnum_sum end as als_id_d15_m6_loan_typ_allnum_sum_rto
        ,case when als_id_m12_loan_typ_allnum_sum = 0 then -1 else als_id_d15_loan_typ_allnum_sum/als_id_m12_loan_typ_allnum_sum end as als_id_d15_m12_loan_typ_allnum_sum_rto
        ,case when als_id_m3_loan_typ_allnum_sum = 0 then -1 else als_id_m1_loan_typ_allnum_sum/als_id_m3_loan_typ_allnum_sum end as als_id_m1_m3_loan_typ_allnum_sum_rto
        ,case when als_id_m6_loan_typ_allnum_sum = 0 then -1 else als_id_m1_loan_typ_allnum_sum/als_id_m6_loan_typ_allnum_sum end as als_id_m1_m6_loan_typ_allnum_sum_rto
        ,case when als_id_m12_loan_typ_allnum_sum = 0 then -1 else als_id_m1_loan_typ_allnum_sum/als_id_m12_loan_typ_allnum_sum end as als_id_m1_m12_loan_typ_allnum_sum_rto
        ,case when als_id_m6_loan_typ_allnum_sum = 0 then -1 else als_id_m3_loan_typ_allnum_sum/als_id_m6_loan_typ_allnum_sum end as als_id_m3_m6_loan_typ_allnum_sum_rto
        ,case when als_id_m12_loan_typ_allnum_sum = 0 then -1 else als_id_m3_loan_typ_allnum_sum/als_id_m12_loan_typ_allnum_sum end as als_id_m3_m12_loan_typ_allnum_sum_rto
        ,case when als_id_m12_loan_typ_allnum_sum = 0 then -1 else als_id_m6_loan_typ_allnum_sum/als_id_m12_loan_typ_allnum_sum end as als_id_m6_m12_loan_typ_allnum_sum_rto
        ,case when als_id_d15_org_typ_orgnum_sum = 0 then -1 else als_id_d7_org_typ_orgnum_sum/als_id_d15_org_typ_orgnum_sum end as als_id_d7_d15_org_typ_orgnum_sum_rto
        ,case when als_id_m1_org_typ_orgnum_sum = 0 then -1 else als_id_d7_org_typ_orgnum_sum/als_id_m1_org_typ_orgnum_sum end as als_id_d7_m1_org_typ_orgnum_sum_rto
        ,case when als_id_m3_org_typ_orgnum_sum = 0 then -1 else als_id_d7_org_typ_orgnum_sum/als_id_m3_org_typ_orgnum_sum end as als_id_d7_m3_org_typ_orgnum_sum_rto
        ,case when als_id_m6_org_typ_orgnum_sum = 0 then -1 else als_id_d7_org_typ_orgnum_sum/als_id_m6_org_typ_orgnum_sum end as als_id_d7_m6_org_typ_orgnum_sum_rto
        ,case when als_id_m12_org_typ_orgnum_sum = 0 then -1 else als_id_d7_org_typ_orgnum_sum/als_id_m12_org_typ_orgnum_sum end as als_id_d7_m12_org_typ_orgnum_sum_rto
        ,case when als_id_m1_org_typ_orgnum_sum = 0 then -1 else als_id_d15_org_typ_orgnum_sum/als_id_m1_org_typ_orgnum_sum end as als_id_d15_m1_org_typ_orgnum_sum_rto
        ,case when als_id_m3_org_typ_orgnum_sum = 0 then -1 else als_id_d15_org_typ_orgnum_sum/als_id_m3_org_typ_orgnum_sum end as als_id_d15_m3_org_typ_orgnum_sum_rto
        ,case when als_id_m6_org_typ_orgnum_sum = 0 then -1 else als_id_d15_org_typ_orgnum_sum/als_id_m6_org_typ_orgnum_sum end as als_id_d15_m6_org_typ_orgnum_sum_rto
        ,case when als_id_m12_org_typ_orgnum_sum = 0 then -1 else als_id_d15_org_typ_orgnum_sum/als_id_m12_org_typ_orgnum_sum end as als_id_d15_m12_org_typ_orgnum_sum_rto
        ,case when als_id_m3_org_typ_orgnum_sum = 0 then -1 else als_id_m1_org_typ_orgnum_sum/als_id_m3_org_typ_orgnum_sum end as als_id_m1_m3_org_typ_orgnum_sum_rto
        ,case when als_id_m6_org_typ_orgnum_sum = 0 then -1 else als_id_m1_org_typ_orgnum_sum/als_id_m6_org_typ_orgnum_sum end as als_id_m1_m6_org_typ_orgnum_sum_rto
        ,case when als_id_m12_org_typ_orgnum_sum = 0 then -1 else als_id_m1_org_typ_orgnum_sum/als_id_m12_org_typ_orgnum_sum end as als_id_m1_m12_org_typ_orgnum_sum_rto
        ,case when als_id_m6_org_typ_orgnum_sum = 0 then -1 else als_id_m3_org_typ_orgnum_sum/als_id_m6_org_typ_orgnum_sum end as als_id_m3_m6_org_typ_orgnum_sum_rto
        ,case when als_id_m12_org_typ_orgnum_sum = 0 then -1 else als_id_m3_org_typ_orgnum_sum/als_id_m12_org_typ_orgnum_sum end as als_id_m3_m12_org_typ_orgnum_sum_rto
        ,case when als_id_m12_org_typ_orgnum_sum = 0 then -1 else als_id_m6_org_typ_orgnum_sum/als_id_m12_org_typ_orgnum_sum end as als_id_m6_m12_org_typ_orgnum_sum_rto
        ,case when als_id_d15_org_typ_allnum_sum = 0 then -1 else als_id_d7_org_typ_allnum_sum/als_id_d15_org_typ_allnum_sum end as als_id_d7_d15_org_typ_allnum_sum_rto
        ,case when als_id_m1_org_typ_allnum_sum = 0 then -1 else als_id_d7_org_typ_allnum_sum/als_id_m1_org_typ_allnum_sum end as als_id_d7_m1_org_typ_allnum_sum_rto
        ,case when als_id_m3_org_typ_allnum_sum = 0 then -1 else als_id_d7_org_typ_allnum_sum/als_id_m3_org_typ_allnum_sum end as als_id_d7_m3_org_typ_allnum_sum_rto
        ,case when als_id_m6_org_typ_allnum_sum = 0 then -1 else als_id_d7_org_typ_allnum_sum/als_id_m6_org_typ_allnum_sum end as als_id_d7_m6_org_typ_allnum_sum_rto
        ,case when als_id_m12_org_typ_allnum_sum = 0 then -1 else als_id_d7_org_typ_allnum_sum/als_id_m12_org_typ_allnum_sum end as als_id_d7_m12_org_typ_allnum_sum_rto
        ,case when als_id_m1_org_typ_allnum_sum = 0 then -1 else als_id_d15_org_typ_allnum_sum/als_id_m1_org_typ_allnum_sum end as als_id_d15_m1_org_typ_allnum_sum_rto
        ,case when als_id_m3_org_typ_allnum_sum = 0 then -1 else als_id_d15_org_typ_allnum_sum/als_id_m3_org_typ_allnum_sum end as als_id_d15_m3_org_typ_allnum_sum_rto
        ,case when als_id_m6_org_typ_allnum_sum = 0 then -1 else als_id_d15_org_typ_allnum_sum/als_id_m6_org_typ_allnum_sum end as als_id_d15_m6_org_typ_allnum_sum_rto
        ,case when als_id_m12_org_typ_allnum_sum = 0 then -1 else als_id_d15_org_typ_allnum_sum/als_id_m12_org_typ_allnum_sum end as als_id_d15_m12_org_typ_allnum_sum_rto
        ,case when als_id_m3_org_typ_allnum_sum = 0 then -1 else als_id_m1_org_typ_allnum_sum/als_id_m3_org_typ_allnum_sum end as als_id_m1_m3_org_typ_allnum_sum_rto
        ,case when als_id_m6_org_typ_allnum_sum = 0 then -1 else als_id_m1_org_typ_allnum_sum/als_id_m6_org_typ_allnum_sum end as als_id_m1_m6_org_typ_allnum_sum_rto
        ,case when als_id_m12_org_typ_allnum_sum = 0 then -1 else als_id_m1_org_typ_allnum_sum/als_id_m12_org_typ_allnum_sum end as als_id_m1_m12_org_typ_allnum_sum_rto
        ,case when als_id_m6_org_typ_allnum_sum = 0 then -1 else als_id_m3_org_typ_allnum_sum/als_id_m6_org_typ_allnum_sum end as als_id_m3_m6_org_typ_allnum_sum_rto
        ,case when als_id_m12_org_typ_allnum_sum = 0 then -1 else als_id_m3_org_typ_allnum_sum/als_id_m12_org_typ_allnum_sum end as als_id_m3_m12_org_typ_allnum_sum_rto
        ,case when als_id_m12_org_typ_allnum_sum = 0 then -1 else als_id_m6_org_typ_allnum_sum/als_id_m12_org_typ_allnum_sum end as als_id_m6_m12_org_typ_allnum_sum_rto

        -- 周末/夜间趋势
        ,case when als_id_d15_org_typ_week_orgnum_sum = 0 then -1 else als_id_d7_org_typ_week_orgnum_sum/als_id_d15_org_typ_week_orgnum_sum end as als_id_d7_d15_org_typ_week_orgnum_sum_rto
        ,case when als_id_m1_org_typ_week_orgnum_sum = 0 then -1 else als_id_d7_org_typ_week_orgnum_sum/als_id_m1_org_typ_week_orgnum_sum end as als_id_d7_m1_org_typ_week_orgnum_sum_rto
        ,case when als_id_m3_org_typ_week_orgnum_sum = 0 then -1 else als_id_d7_org_typ_week_orgnum_sum/als_id_m3_org_typ_week_orgnum_sum end as als_id_d7_m3_org_typ_week_orgnum_sum_rto
        ,case when als_id_m6_org_typ_week_orgnum_sum = 0 then -1 else als_id_d7_org_typ_week_orgnum_sum/als_id_m6_org_typ_week_orgnum_sum end as als_id_d7_m6_org_typ_week_orgnum_sum_rto
        ,case when als_id_m12_org_typ_week_orgnum_sum = 0 then -1 else als_id_d7_org_typ_week_orgnum_sum/als_id_m12_org_typ_week_orgnum_sum end as als_id_d7_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_m1_org_typ_week_orgnum_sum = 0 then -1 else als_id_d15_org_typ_week_orgnum_sum/als_id_m1_org_typ_week_orgnum_sum end as als_id_d15_m1_org_typ_week_orgnum_sum_rto
        ,case when als_id_m3_org_typ_week_orgnum_sum = 0 then -1 else als_id_d15_org_typ_week_orgnum_sum/als_id_m3_org_typ_week_orgnum_sum end as als_id_d15_m3_org_typ_week_orgnum_sum_rto
        ,case when als_id_m6_org_typ_week_orgnum_sum = 0 then -1 else als_id_d15_org_typ_week_orgnum_sum/als_id_m6_org_typ_week_orgnum_sum end as als_id_d15_m6_org_typ_week_orgnum_sum_rto
        ,case when als_id_m12_org_typ_week_orgnum_sum = 0 then -1 else als_id_d15_org_typ_week_orgnum_sum/als_id_m12_org_typ_week_orgnum_sum end as als_id_d15_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_m3_org_typ_week_orgnum_sum = 0 then -1 else als_id_m1_org_typ_week_orgnum_sum/als_id_m3_org_typ_week_orgnum_sum end as als_id_m1_m3_org_typ_week_orgnum_sum_rto
        ,case when als_id_m6_org_typ_week_orgnum_sum = 0 then -1 else als_id_m1_org_typ_week_orgnum_sum/als_id_m6_org_typ_week_orgnum_sum end as als_id_m1_m6_org_typ_week_orgnum_sum_rto
        ,case when als_id_m12_org_typ_week_orgnum_sum = 0 then -1 else als_id_m1_org_typ_week_orgnum_sum/als_id_m12_org_typ_week_orgnum_sum end as als_id_m1_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_m6_org_typ_week_orgnum_sum = 0 then -1 else als_id_m3_org_typ_week_orgnum_sum/als_id_m6_org_typ_week_orgnum_sum end as als_id_m3_m6_org_typ_week_orgnum_sum_rto
        ,case when als_id_m12_org_typ_week_orgnum_sum = 0 then -1 else als_id_m3_org_typ_week_orgnum_sum/als_id_m12_org_typ_week_orgnum_sum end as als_id_m3_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_m12_org_typ_week_orgnum_sum = 0 then -1 else als_id_m6_org_typ_week_orgnum_sum/als_id_m12_org_typ_week_orgnum_sum end as als_id_m6_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_d15_org_typ_week_allnum_sum = 0 then -1 else als_id_d7_org_typ_week_allnum_sum/als_id_d15_org_typ_week_allnum_sum end as als_id_d7_d15_org_typ_week_allnum_sum_rto
        ,case when als_id_m1_org_typ_week_allnum_sum = 0 then -1 else als_id_d7_org_typ_week_allnum_sum/als_id_m1_org_typ_week_allnum_sum end as als_id_d7_m1_org_typ_week_allnum_sum_rto
        ,case when als_id_m3_org_typ_week_allnum_sum = 0 then -1 else als_id_d7_org_typ_week_allnum_sum/als_id_m3_org_typ_week_allnum_sum end as als_id_d7_m3_org_typ_week_allnum_sum_rto
        ,case when als_id_m6_org_typ_week_allnum_sum = 0 then -1 else als_id_d7_org_typ_week_allnum_sum/als_id_m6_org_typ_week_allnum_sum end as als_id_d7_m6_org_typ_week_allnum_sum_rto
        ,case when als_id_m12_org_typ_week_allnum_sum = 0 then -1 else als_id_d7_org_typ_week_allnum_sum/als_id_m12_org_typ_week_allnum_sum end as als_id_d7_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_m1_org_typ_week_allnum_sum = 0 then -1 else als_id_d15_org_typ_week_allnum_sum/als_id_m1_org_typ_week_allnum_sum end as als_id_d15_m1_org_typ_week_allnum_sum_rto
        ,case when als_id_m3_org_typ_week_allnum_sum = 0 then -1 else als_id_d15_org_typ_week_allnum_sum/als_id_m3_org_typ_week_allnum_sum end as als_id_d15_m3_org_typ_week_allnum_sum_rto
        ,case when als_id_m6_org_typ_week_allnum_sum = 0 then -1 else als_id_d15_org_typ_week_allnum_sum/als_id_m6_org_typ_week_allnum_sum end as als_id_d15_m6_org_typ_week_allnum_sum_rto
        ,case when als_id_m12_org_typ_week_allnum_sum = 0 then -1 else als_id_d15_org_typ_week_allnum_sum/als_id_m12_org_typ_week_allnum_sum end as als_id_d15_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_m3_org_typ_week_allnum_sum = 0 then -1 else als_id_m1_org_typ_week_allnum_sum/als_id_m3_org_typ_week_allnum_sum end as als_id_m1_m3_org_typ_week_allnum_sum_rto
        ,case when als_id_m6_org_typ_week_allnum_sum = 0 then -1 else als_id_m1_org_typ_week_allnum_sum/als_id_m6_org_typ_week_allnum_sum end as als_id_m1_m6_org_typ_week_allnum_sum_rto
        ,case when als_id_m12_org_typ_week_allnum_sum = 0 then -1 else als_id_m1_org_typ_week_allnum_sum/als_id_m12_org_typ_week_allnum_sum end as als_id_m1_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_m6_org_typ_week_allnum_sum = 0 then -1 else als_id_m3_org_typ_week_allnum_sum/als_id_m6_org_typ_week_allnum_sum end as als_id_m3_m6_org_typ_week_allnum_sum_rto
        ,case when als_id_m12_org_typ_week_allnum_sum = 0 then -1 else als_id_m3_org_typ_week_allnum_sum/als_id_m12_org_typ_week_allnum_sum end as als_id_m3_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_m12_org_typ_week_allnum_sum = 0 then -1 else als_id_m6_org_typ_week_allnum_sum/als_id_m12_org_typ_week_allnum_sum end as als_id_m6_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_d15_org_typ_night_orgnum_sum = 0 then -1 else als_id_d7_org_typ_night_orgnum_sum/als_id_d15_org_typ_night_orgnum_sum end as als_id_d7_d15_org_typ_night_orgnum_sum_rto
        ,case when als_id_m1_org_typ_night_orgnum_sum = 0 then -1 else als_id_d7_org_typ_night_orgnum_sum/als_id_m1_org_typ_night_orgnum_sum end as als_id_d7_m1_org_typ_night_orgnum_sum_rto
        ,case when als_id_m3_org_typ_night_orgnum_sum = 0 then -1 else als_id_d7_org_typ_night_orgnum_sum/als_id_m3_org_typ_night_orgnum_sum end as als_id_d7_m3_org_typ_night_orgnum_sum_rto
        ,case when als_id_m6_org_typ_night_orgnum_sum = 0 then -1 else als_id_d7_org_typ_night_orgnum_sum/als_id_m6_org_typ_night_orgnum_sum end as als_id_d7_m6_org_typ_night_orgnum_sum_rto
        ,case when als_id_m12_org_typ_night_orgnum_sum = 0 then -1 else als_id_d7_org_typ_night_orgnum_sum/als_id_m12_org_typ_night_orgnum_sum end as als_id_d7_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_m1_org_typ_night_orgnum_sum = 0 then -1 else als_id_d15_org_typ_night_orgnum_sum/als_id_m1_org_typ_night_orgnum_sum end as als_id_d15_m1_org_typ_night_orgnum_sum_rto
        ,case when als_id_m3_org_typ_night_orgnum_sum = 0 then -1 else als_id_d15_org_typ_night_orgnum_sum/als_id_m3_org_typ_night_orgnum_sum end as als_id_d15_m3_org_typ_night_orgnum_sum_rto
        ,case when als_id_m6_org_typ_night_orgnum_sum = 0 then -1 else als_id_d15_org_typ_night_orgnum_sum/als_id_m6_org_typ_night_orgnum_sum end as als_id_d15_m6_org_typ_night_orgnum_sum_rto
        ,case when als_id_m12_org_typ_night_orgnum_sum = 0 then -1 else als_id_d15_org_typ_night_orgnum_sum/als_id_m12_org_typ_night_orgnum_sum end as als_id_d15_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_m3_org_typ_night_orgnum_sum = 0 then -1 else als_id_m1_org_typ_night_orgnum_sum/als_id_m3_org_typ_night_orgnum_sum end as als_id_m1_m3_org_typ_night_orgnum_sum_rto
        ,case when als_id_m6_org_typ_night_orgnum_sum = 0 then -1 else als_id_m1_org_typ_night_orgnum_sum/als_id_m6_org_typ_night_orgnum_sum end as als_id_m1_m6_org_typ_night_orgnum_sum_rto
        ,case when als_id_m12_org_typ_night_orgnum_sum = 0 then -1 else als_id_m1_org_typ_night_orgnum_sum/als_id_m12_org_typ_night_orgnum_sum end as als_id_m1_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_m6_org_typ_night_orgnum_sum = 0 then -1 else als_id_m3_org_typ_night_orgnum_sum/als_id_m6_org_typ_night_orgnum_sum end as als_id_m3_m6_org_typ_night_orgnum_sum_rto
        ,case when als_id_m12_org_typ_night_orgnum_sum = 0 then -1 else als_id_m3_org_typ_night_orgnum_sum/als_id_m12_org_typ_night_orgnum_sum end as als_id_m3_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_m12_org_typ_night_orgnum_sum = 0 then -1 else als_id_m6_org_typ_night_orgnum_sum/als_id_m12_org_typ_night_orgnum_sum end as als_id_m6_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_d15_org_typ_night_allnum_sum = 0 then -1 else als_id_d7_org_typ_night_allnum_sum/als_id_d15_org_typ_night_allnum_sum end as als_id_d7_d15_org_typ_night_allnum_sum_rto
        ,case when als_id_m1_org_typ_night_allnum_sum = 0 then -1 else als_id_d7_org_typ_night_allnum_sum/als_id_m1_org_typ_night_allnum_sum end as als_id_d7_m1_org_typ_night_allnum_sum_rto
        ,case when als_id_m3_org_typ_night_allnum_sum = 0 then -1 else als_id_d7_org_typ_night_allnum_sum/als_id_m3_org_typ_night_allnum_sum end as als_id_d7_m3_org_typ_night_allnum_sum_rto
        ,case when als_id_m6_org_typ_night_allnum_sum = 0 then -1 else als_id_d7_org_typ_night_allnum_sum/als_id_m6_org_typ_night_allnum_sum end as als_id_d7_m6_org_typ_night_allnum_sum_rto
        ,case when als_id_m12_org_typ_night_allnum_sum = 0 then -1 else als_id_d7_org_typ_night_allnum_sum/als_id_m12_org_typ_night_allnum_sum end as als_id_d7_m12_org_typ_night_allnum_sum_rto
        ,case when als_id_m1_org_typ_night_allnum_sum = 0 then -1 else als_id_d15_org_typ_night_allnum_sum/als_id_m1_org_typ_night_allnum_sum end as als_id_d15_m1_org_typ_night_allnum_sum_rto
        ,case when als_id_m3_org_typ_night_allnum_sum = 0 then -1 else als_id_d15_org_typ_night_allnum_sum/als_id_m3_org_typ_night_allnum_sum end as als_id_d15_m3_org_typ_night_allnum_sum_rto
        ,case when als_id_m6_org_typ_night_allnum_sum = 0 then -1 else als_id_d15_org_typ_night_allnum_sum/als_id_m6_org_typ_night_allnum_sum end as als_id_d15_m6_org_typ_night_allnum_sum_rto
        ,case when als_id_m12_org_typ_night_allnum_sum = 0 then -1 else als_id_d15_org_typ_night_allnum_sum/als_id_m12_org_typ_night_allnum_sum end as als_id_d15_m12_org_typ_night_allnum_sum_rto
        ,case when als_id_m3_org_typ_night_allnum_sum = 0 then -1 else als_id_m1_org_typ_night_allnum_sum/als_id_m3_org_typ_night_allnum_sum end as als_id_m1_m3_org_typ_night_allnum_sum_rto
        ,case when als_id_m6_org_typ_night_allnum_sum = 0 then -1 else als_id_m1_org_typ_night_allnum_sum/als_id_m6_org_typ_night_allnum_sum end as als_id_m1_m6_org_typ_night_allnum_sum_rto
        ,case when als_id_m12_org_typ_night_allnum_sum = 0 then -1 else als_id_m1_org_typ_night_allnum_sum/als_id_m12_org_typ_night_allnum_sum end as als_id_m1_m12_org_typ_night_allnum_sum_rto
        ,case when als_id_m6_org_typ_night_allnum_sum = 0 then -1 else als_id_m3_org_typ_night_allnum_sum/als_id_m6_org_typ_night_allnum_sum end as als_id_m3_m6_org_typ_night_allnum_sum_rto
        ,case when als_id_m12_org_typ_night_allnum_sum = 0 then -1 else als_id_m3_org_typ_night_allnum_sum/als_id_m12_org_typ_night_allnum_sum end as als_id_m3_m12_org_typ_night_allnum_sum_rto
        ,case when als_id_m12_org_typ_night_allnum_sum = 0 then -1 else als_id_m6_org_typ_night_allnum_sum/als_id_m12_org_typ_night_allnum_sum end as als_id_m6_m12_org_typ_night_allnum_sum_rto
     
        -- 分类贷款类型趋势
        ,case when als_id_d15_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_orgnum_sum/als_id_d15_ca_loan_typ_orgnum_sum end as als_id_d7_d15_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_orgnum_sum/als_id_m1_ca_loan_typ_orgnum_sum end as als_id_d7_m1_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_orgnum_sum/als_id_m3_ca_loan_typ_orgnum_sum end as als_id_d7_m3_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_orgnum_sum/als_id_m6_ca_loan_typ_orgnum_sum end as als_id_d7_m6_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_orgnum_sum/als_id_m12_ca_loan_typ_orgnum_sum end as als_id_d7_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_orgnum_sum/als_id_m1_ca_loan_typ_orgnum_sum end as als_id_d15_m1_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_orgnum_sum/als_id_m3_ca_loan_typ_orgnum_sum end as als_id_d15_m3_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_orgnum_sum/als_id_m6_ca_loan_typ_orgnum_sum end as als_id_d15_m6_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_orgnum_sum/als_id_m12_ca_loan_typ_orgnum_sum end as als_id_d15_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_ca_loan_typ_orgnum_sum/als_id_m3_ca_loan_typ_orgnum_sum end as als_id_m1_m3_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_ca_loan_typ_orgnum_sum/als_id_m6_ca_loan_typ_orgnum_sum end as als_id_m1_m6_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_ca_loan_typ_orgnum_sum/als_id_m12_ca_loan_typ_orgnum_sum end as als_id_m1_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_ca_loan_typ_orgnum_sum/als_id_m6_ca_loan_typ_orgnum_sum end as als_id_m3_m6_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_ca_loan_typ_orgnum_sum/als_id_m12_ca_loan_typ_orgnum_sum end as als_id_m3_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_orgnum_sum = 0 then -1 else als_id_m6_ca_loan_typ_orgnum_sum/als_id_m12_ca_loan_typ_orgnum_sum end as als_id_m6_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_allnum_sum/als_id_d15_ca_loan_typ_allnum_sum end as als_id_d7_d15_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_allnum_sum/als_id_m1_ca_loan_typ_allnum_sum end as als_id_d7_m1_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_allnum_sum/als_id_m3_ca_loan_typ_allnum_sum end as als_id_d7_m3_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_allnum_sum/als_id_m6_ca_loan_typ_allnum_sum end as als_id_d7_m6_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d7_ca_loan_typ_allnum_sum/als_id_m12_ca_loan_typ_allnum_sum end as als_id_d7_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_allnum_sum/als_id_m1_ca_loan_typ_allnum_sum end as als_id_d15_m1_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_allnum_sum/als_id_m3_ca_loan_typ_allnum_sum end as als_id_d15_m3_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_allnum_sum/als_id_m6_ca_loan_typ_allnum_sum end as als_id_d15_m6_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_allnum_sum = 0 then -1 else als_id_d15_ca_loan_typ_allnum_sum/als_id_m12_ca_loan_typ_allnum_sum end as als_id_d15_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_allnum_sum = 0 then -1 else als_id_m1_ca_loan_typ_allnum_sum/als_id_m3_ca_loan_typ_allnum_sum end as als_id_m1_m3_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_allnum_sum = 0 then -1 else als_id_m1_ca_loan_typ_allnum_sum/als_id_m6_ca_loan_typ_allnum_sum end as als_id_m1_m6_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_allnum_sum = 0 then -1 else als_id_m1_ca_loan_typ_allnum_sum/als_id_m12_ca_loan_typ_allnum_sum end as als_id_m1_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m6_ca_loan_typ_allnum_sum = 0 then -1 else als_id_m3_ca_loan_typ_allnum_sum/als_id_m6_ca_loan_typ_allnum_sum end as als_id_m3_m6_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_allnum_sum = 0 then -1 else als_id_m3_ca_loan_typ_allnum_sum/als_id_m12_ca_loan_typ_allnum_sum end as als_id_m3_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m12_ca_loan_typ_allnum_sum = 0 then -1 else als_id_m6_ca_loan_typ_allnum_sum/als_id_m12_ca_loan_typ_allnum_sum end as als_id_m6_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_d15_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_co_loan_typ_orgnum_sum/als_id_d15_co_loan_typ_orgnum_sum end as als_id_d7_d15_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_co_loan_typ_orgnum_sum/als_id_m1_co_loan_typ_orgnum_sum end as als_id_d7_m1_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_co_loan_typ_orgnum_sum/als_id_m3_co_loan_typ_orgnum_sum end as als_id_d7_m3_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_co_loan_typ_orgnum_sum/als_id_m6_co_loan_typ_orgnum_sum end as als_id_d7_m6_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_co_loan_typ_orgnum_sum/als_id_m12_co_loan_typ_orgnum_sum end as als_id_d7_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_co_loan_typ_orgnum_sum/als_id_m1_co_loan_typ_orgnum_sum end as als_id_d15_m1_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_co_loan_typ_orgnum_sum/als_id_m3_co_loan_typ_orgnum_sum end as als_id_d15_m3_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_co_loan_typ_orgnum_sum/als_id_m6_co_loan_typ_orgnum_sum end as als_id_d15_m6_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_co_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_co_loan_typ_orgnum_sum/als_id_m12_co_loan_typ_orgnum_sum end as als_id_d15_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_co_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_co_loan_typ_orgnum_sum/als_id_m3_co_loan_typ_orgnum_sum end as als_id_m1_m3_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_co_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_co_loan_typ_orgnum_sum/als_id_m6_co_loan_typ_orgnum_sum end as als_id_m1_m6_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_co_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_co_loan_typ_orgnum_sum/als_id_m12_co_loan_typ_orgnum_sum end as als_id_m1_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_co_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_co_loan_typ_orgnum_sum/als_id_m6_co_loan_typ_orgnum_sum end as als_id_m3_m6_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_co_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_co_loan_typ_orgnum_sum/als_id_m12_co_loan_typ_orgnum_sum end as als_id_m3_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_co_loan_typ_orgnum_sum = 0 then -1 else als_id_m6_co_loan_typ_orgnum_sum/als_id_m12_co_loan_typ_orgnum_sum end as als_id_m6_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_co_loan_typ_allnum_sum = 0 then -1 else als_id_d7_co_loan_typ_allnum_sum/als_id_d15_co_loan_typ_allnum_sum end as als_id_d7_d15_co_loan_typ_allnum_sum_rto
        ,case when als_id_m1_co_loan_typ_allnum_sum = 0 then -1 else als_id_d7_co_loan_typ_allnum_sum/als_id_m1_co_loan_typ_allnum_sum end as als_id_d7_m1_co_loan_typ_allnum_sum_rto
        ,case when als_id_m3_co_loan_typ_allnum_sum = 0 then -1 else als_id_d7_co_loan_typ_allnum_sum/als_id_m3_co_loan_typ_allnum_sum end as als_id_d7_m3_co_loan_typ_allnum_sum_rto
        ,case when als_id_m6_co_loan_typ_allnum_sum = 0 then -1 else als_id_d7_co_loan_typ_allnum_sum/als_id_m6_co_loan_typ_allnum_sum end as als_id_d7_m6_co_loan_typ_allnum_sum_rto
        ,case when als_id_m12_co_loan_typ_allnum_sum = 0 then -1 else als_id_d7_co_loan_typ_allnum_sum/als_id_m12_co_loan_typ_allnum_sum end as als_id_d7_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_m1_co_loan_typ_allnum_sum = 0 then -1 else als_id_d15_co_loan_typ_allnum_sum/als_id_m1_co_loan_typ_allnum_sum end as als_id_d15_m1_co_loan_typ_allnum_sum_rto
        ,case when als_id_m3_co_loan_typ_allnum_sum = 0 then -1 else als_id_d15_co_loan_typ_allnum_sum/als_id_m3_co_loan_typ_allnum_sum end as als_id_d15_m3_co_loan_typ_allnum_sum_rto
        ,case when als_id_m6_co_loan_typ_allnum_sum = 0 then -1 else als_id_d15_co_loan_typ_allnum_sum/als_id_m6_co_loan_typ_allnum_sum end as als_id_d15_m6_co_loan_typ_allnum_sum_rto
        ,case when als_id_m12_co_loan_typ_allnum_sum = 0 then -1 else als_id_d15_co_loan_typ_allnum_sum/als_id_m12_co_loan_typ_allnum_sum end as als_id_d15_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_m3_co_loan_typ_allnum_sum = 0 then -1 else als_id_m1_co_loan_typ_allnum_sum/als_id_m3_co_loan_typ_allnum_sum end as als_id_m1_m3_co_loan_typ_allnum_sum_rto
        ,case when als_id_m6_co_loan_typ_allnum_sum = 0 then -1 else als_id_m1_co_loan_typ_allnum_sum/als_id_m6_co_loan_typ_allnum_sum end as als_id_m1_m6_co_loan_typ_allnum_sum_rto
        ,case when als_id_m12_co_loan_typ_allnum_sum = 0 then -1 else als_id_m1_co_loan_typ_allnum_sum/als_id_m12_co_loan_typ_allnum_sum end as als_id_m1_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_m6_co_loan_typ_allnum_sum = 0 then -1 else als_id_m3_co_loan_typ_allnum_sum/als_id_m6_co_loan_typ_allnum_sum end as als_id_m3_m6_co_loan_typ_allnum_sum_rto
        ,case when als_id_m12_co_loan_typ_allnum_sum = 0 then -1 else als_id_m3_co_loan_typ_allnum_sum/als_id_m12_co_loan_typ_allnum_sum end as als_id_m3_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_m12_co_loan_typ_allnum_sum = 0 then -1 else als_id_m6_co_loan_typ_allnum_sum/als_id_m12_co_loan_typ_allnum_sum end as als_id_m6_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_d15_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_on_loan_typ_orgnum_sum/als_id_d15_on_loan_typ_orgnum_sum end as als_id_d7_d15_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_on_loan_typ_orgnum_sum/als_id_m1_on_loan_typ_orgnum_sum end as als_id_d7_m1_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_on_loan_typ_orgnum_sum/als_id_m3_on_loan_typ_orgnum_sum end as als_id_d7_m3_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_on_loan_typ_orgnum_sum/als_id_m6_on_loan_typ_orgnum_sum end as als_id_d7_m6_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_on_loan_typ_orgnum_sum/als_id_m12_on_loan_typ_orgnum_sum end as als_id_d7_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_on_loan_typ_orgnum_sum/als_id_m1_on_loan_typ_orgnum_sum end as als_id_d15_m1_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_on_loan_typ_orgnum_sum/als_id_m3_on_loan_typ_orgnum_sum end as als_id_d15_m3_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_on_loan_typ_orgnum_sum/als_id_m6_on_loan_typ_orgnum_sum end as als_id_d15_m6_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_on_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_on_loan_typ_orgnum_sum/als_id_m12_on_loan_typ_orgnum_sum end as als_id_d15_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_on_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_on_loan_typ_orgnum_sum/als_id_m3_on_loan_typ_orgnum_sum end as als_id_m1_m3_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_on_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_on_loan_typ_orgnum_sum/als_id_m6_on_loan_typ_orgnum_sum end as als_id_m1_m6_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_on_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_on_loan_typ_orgnum_sum/als_id_m12_on_loan_typ_orgnum_sum end as als_id_m1_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_on_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_on_loan_typ_orgnum_sum/als_id_m6_on_loan_typ_orgnum_sum end as als_id_m3_m6_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_on_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_on_loan_typ_orgnum_sum/als_id_m12_on_loan_typ_orgnum_sum end as als_id_m3_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_on_loan_typ_orgnum_sum = 0 then -1 else als_id_m6_on_loan_typ_orgnum_sum/als_id_m12_on_loan_typ_orgnum_sum end as als_id_m6_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_on_loan_typ_allnum_sum = 0 then -1 else als_id_d7_on_loan_typ_allnum_sum/als_id_d15_on_loan_typ_allnum_sum end as als_id_d7_d15_on_loan_typ_allnum_sum_rto
        ,case when als_id_m1_on_loan_typ_allnum_sum = 0 then -1 else als_id_d7_on_loan_typ_allnum_sum/als_id_m1_on_loan_typ_allnum_sum end as als_id_d7_m1_on_loan_typ_allnum_sum_rto
        ,case when als_id_m3_on_loan_typ_allnum_sum = 0 then -1 else als_id_d7_on_loan_typ_allnum_sum/als_id_m3_on_loan_typ_allnum_sum end as als_id_d7_m3_on_loan_typ_allnum_sum_rto
        ,case when als_id_m6_on_loan_typ_allnum_sum = 0 then -1 else als_id_d7_on_loan_typ_allnum_sum/als_id_m6_on_loan_typ_allnum_sum end as als_id_d7_m6_on_loan_typ_allnum_sum_rto
        ,case when als_id_m12_on_loan_typ_allnum_sum = 0 then -1 else als_id_d7_on_loan_typ_allnum_sum/als_id_m12_on_loan_typ_allnum_sum end as als_id_d7_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_m1_on_loan_typ_allnum_sum = 0 then -1 else als_id_d15_on_loan_typ_allnum_sum/als_id_m1_on_loan_typ_allnum_sum end as als_id_d15_m1_on_loan_typ_allnum_sum_rto
        ,case when als_id_m3_on_loan_typ_allnum_sum = 0 then -1 else als_id_d15_on_loan_typ_allnum_sum/als_id_m3_on_loan_typ_allnum_sum end as als_id_d15_m3_on_loan_typ_allnum_sum_rto
        ,case when als_id_m6_on_loan_typ_allnum_sum = 0 then -1 else als_id_d15_on_loan_typ_allnum_sum/als_id_m6_on_loan_typ_allnum_sum end as als_id_d15_m6_on_loan_typ_allnum_sum_rto
        ,case when als_id_m12_on_loan_typ_allnum_sum = 0 then -1 else als_id_d15_on_loan_typ_allnum_sum/als_id_m12_on_loan_typ_allnum_sum end as als_id_d15_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_m3_on_loan_typ_allnum_sum = 0 then -1 else als_id_m1_on_loan_typ_allnum_sum/als_id_m3_on_loan_typ_allnum_sum end as als_id_m1_m3_on_loan_typ_allnum_sum_rto
        ,case when als_id_m6_on_loan_typ_allnum_sum = 0 then -1 else als_id_m1_on_loan_typ_allnum_sum/als_id_m6_on_loan_typ_allnum_sum end as als_id_m1_m6_on_loan_typ_allnum_sum_rto
        ,case when als_id_m12_on_loan_typ_allnum_sum = 0 then -1 else als_id_m1_on_loan_typ_allnum_sum/als_id_m12_on_loan_typ_allnum_sum end as als_id_m1_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_m6_on_loan_typ_allnum_sum = 0 then -1 else als_id_m3_on_loan_typ_allnum_sum/als_id_m6_on_loan_typ_allnum_sum end as als_id_m3_m6_on_loan_typ_allnum_sum_rto
        ,case when als_id_m12_on_loan_typ_allnum_sum = 0 then -1 else als_id_m3_on_loan_typ_allnum_sum/als_id_m12_on_loan_typ_allnum_sum end as als_id_m3_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_m12_on_loan_typ_allnum_sum = 0 then -1 else als_id_m6_on_loan_typ_allnum_sum/als_id_m12_on_loan_typ_allnum_sum end as als_id_m6_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_d15_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_off_loan_typ_orgnum_sum/als_id_d15_off_loan_typ_orgnum_sum end as als_id_d7_d15_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_off_loan_typ_orgnum_sum/als_id_m1_off_loan_typ_orgnum_sum end as als_id_d7_m1_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_off_loan_typ_orgnum_sum/als_id_m3_off_loan_typ_orgnum_sum end as als_id_d7_m3_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_off_loan_typ_orgnum_sum/als_id_m6_off_loan_typ_orgnum_sum end as als_id_d7_m6_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d7_off_loan_typ_orgnum_sum/als_id_m12_off_loan_typ_orgnum_sum end as als_id_d7_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_off_loan_typ_orgnum_sum/als_id_m1_off_loan_typ_orgnum_sum end as als_id_d15_m1_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_off_loan_typ_orgnum_sum/als_id_m3_off_loan_typ_orgnum_sum end as als_id_d15_m3_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_off_loan_typ_orgnum_sum/als_id_m6_off_loan_typ_orgnum_sum end as als_id_d15_m6_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_off_loan_typ_orgnum_sum = 0 then -1 else als_id_d15_off_loan_typ_orgnum_sum/als_id_m12_off_loan_typ_orgnum_sum end as als_id_d15_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_off_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_off_loan_typ_orgnum_sum/als_id_m3_off_loan_typ_orgnum_sum end as als_id_m1_m3_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_off_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_off_loan_typ_orgnum_sum/als_id_m6_off_loan_typ_orgnum_sum end as als_id_m1_m6_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_off_loan_typ_orgnum_sum = 0 then -1 else als_id_m1_off_loan_typ_orgnum_sum/als_id_m12_off_loan_typ_orgnum_sum end as als_id_m1_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m6_off_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_off_loan_typ_orgnum_sum/als_id_m6_off_loan_typ_orgnum_sum end as als_id_m3_m6_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_off_loan_typ_orgnum_sum = 0 then -1 else als_id_m3_off_loan_typ_orgnum_sum/als_id_m12_off_loan_typ_orgnum_sum end as als_id_m3_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m12_off_loan_typ_orgnum_sum = 0 then -1 else als_id_m6_off_loan_typ_orgnum_sum/als_id_m12_off_loan_typ_orgnum_sum end as als_id_m6_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_off_loan_typ_allnum_sum = 0 then -1 else als_id_d7_off_loan_typ_allnum_sum/als_id_d15_off_loan_typ_allnum_sum end as als_id_d7_d15_off_loan_typ_allnum_sum_rto
        ,case when als_id_m1_off_loan_typ_allnum_sum = 0 then -1 else als_id_d7_off_loan_typ_allnum_sum/als_id_m1_off_loan_typ_allnum_sum end as als_id_d7_m1_off_loan_typ_allnum_sum_rto
        ,case when als_id_m3_off_loan_typ_allnum_sum = 0 then -1 else als_id_d7_off_loan_typ_allnum_sum/als_id_m3_off_loan_typ_allnum_sum end as als_id_d7_m3_off_loan_typ_allnum_sum_rto
        ,case when als_id_m6_off_loan_typ_allnum_sum = 0 then -1 else als_id_d7_off_loan_typ_allnum_sum/als_id_m6_off_loan_typ_allnum_sum end as als_id_d7_m6_off_loan_typ_allnum_sum_rto
        ,case when als_id_m12_off_loan_typ_allnum_sum = 0 then -1 else als_id_d7_off_loan_typ_allnum_sum/als_id_m12_off_loan_typ_allnum_sum end as als_id_d7_m12_off_loan_typ_allnum_sum_rto
        ,case when als_id_m1_off_loan_typ_allnum_sum = 0 then -1 else als_id_d15_off_loan_typ_allnum_sum/als_id_m1_off_loan_typ_allnum_sum end as als_id_d15_m1_off_loan_typ_allnum_sum_rto
        ,case when als_id_m3_off_loan_typ_allnum_sum = 0 then -1 else als_id_d15_off_loan_typ_allnum_sum/als_id_m3_off_loan_typ_allnum_sum end as als_id_d15_m3_off_loan_typ_allnum_sum_rto
        ,case when als_id_m6_off_loan_typ_allnum_sum = 0 then -1 else als_id_d15_off_loan_typ_allnum_sum/als_id_m6_off_loan_typ_allnum_sum end as als_id_d15_m6_off_loan_typ_allnum_sum_rto
        ,case when als_id_m12_off_loan_typ_allnum_sum = 0 then -1 else als_id_d15_off_loan_typ_allnum_sum/als_id_m12_off_loan_typ_allnum_sum end as als_id_d15_m12_off_loan_typ_allnum_sum_rto
        ,case when als_id_m3_off_loan_typ_allnum_sum = 0 then -1 else als_id_m1_off_loan_typ_allnum_sum/als_id_m3_off_loan_typ_allnum_sum end as als_id_m1_m3_off_loan_typ_allnum_sum_rto
        ,case when als_id_m6_off_loan_typ_allnum_sum = 0 then -1 else als_id_m1_off_loan_typ_allnum_sum/als_id_m6_off_loan_typ_allnum_sum end as als_id_m1_m6_off_loan_typ_allnum_sum_rto
        ,case when als_id_m12_off_loan_typ_allnum_sum = 0 then -1 else als_id_m1_off_loan_typ_allnum_sum/als_id_m12_off_loan_typ_allnum_sum end as als_id_m1_m12_off_loan_typ_allnum_sum_rto
        ,case when als_id_m6_off_loan_typ_allnum_sum = 0 then -1 else als_id_m3_off_loan_typ_allnum_sum/als_id_m6_off_loan_typ_allnum_sum end as als_id_m3_m6_off_loan_typ_allnum_sum_rto
        ,case when als_id_m12_off_loan_typ_allnum_sum = 0 then -1 else als_id_m3_off_loan_typ_allnum_sum/als_id_m12_off_loan_typ_allnum_sum end as als_id_m3_m12_off_loan_typ_allnum_sum_rto
        ,case when als_id_m12_off_loan_typ_allnum_sum = 0 then -1 else als_id_m6_off_loan_typ_allnum_sum/als_id_m12_off_loan_typ_allnum_sum end as als_id_m6_m12_off_loan_typ_allnum_sum_rto

        -- 分类机构类型趋势
        ,case when als_id_d15_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_orgnum_sum/als_id_d15_lsd_org_typ_orgnum_sum end as als_id_d7_d15_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_orgnum_sum/als_id_m1_lsd_org_typ_orgnum_sum end as als_id_d7_m1_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_orgnum_sum/als_id_m3_lsd_org_typ_orgnum_sum end as als_id_d7_m3_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_orgnum_sum/als_id_m6_lsd_org_typ_orgnum_sum end as als_id_d7_m6_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_orgnum_sum/als_id_m12_lsd_org_typ_orgnum_sum end as als_id_d7_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_orgnum_sum/als_id_m1_lsd_org_typ_orgnum_sum end as als_id_d15_m1_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_orgnum_sum/als_id_m3_lsd_org_typ_orgnum_sum end as als_id_d15_m3_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_orgnum_sum/als_id_m6_lsd_org_typ_orgnum_sum end as als_id_d15_m6_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_orgnum_sum/als_id_m12_lsd_org_typ_orgnum_sum end as als_id_d15_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_m1_lsd_org_typ_orgnum_sum/als_id_m3_lsd_org_typ_orgnum_sum end as als_id_m1_m3_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_m1_lsd_org_typ_orgnum_sum/als_id_m6_lsd_org_typ_orgnum_sum end as als_id_m1_m6_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_m1_lsd_org_typ_orgnum_sum/als_id_m12_lsd_org_typ_orgnum_sum end as als_id_m1_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_m3_lsd_org_typ_orgnum_sum/als_id_m6_lsd_org_typ_orgnum_sum end as als_id_m3_m6_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_m3_lsd_org_typ_orgnum_sum/als_id_m12_lsd_org_typ_orgnum_sum end as als_id_m3_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_orgnum_sum = 0 then -1 else als_id_m6_lsd_org_typ_orgnum_sum/als_id_m12_lsd_org_typ_orgnum_sum end as als_id_m6_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_d15_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_allnum_sum/als_id_d15_lsd_org_typ_allnum_sum end as als_id_d7_d15_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_allnum_sum/als_id_m1_lsd_org_typ_allnum_sum end as als_id_d7_m1_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_allnum_sum/als_id_m3_lsd_org_typ_allnum_sum end as als_id_d7_m3_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_allnum_sum/als_id_m6_lsd_org_typ_allnum_sum end as als_id_d7_m6_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d7_lsd_org_typ_allnum_sum/als_id_m12_lsd_org_typ_allnum_sum end as als_id_d7_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_allnum_sum/als_id_m1_lsd_org_typ_allnum_sum end as als_id_d15_m1_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_allnum_sum/als_id_m3_lsd_org_typ_allnum_sum end as als_id_d15_m3_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_allnum_sum/als_id_m6_lsd_org_typ_allnum_sum end as als_id_d15_m6_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_allnum_sum = 0 then -1 else als_id_d15_lsd_org_typ_allnum_sum/als_id_m12_lsd_org_typ_allnum_sum end as als_id_d15_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_allnum_sum = 0 then -1 else als_id_m1_lsd_org_typ_allnum_sum/als_id_m3_lsd_org_typ_allnum_sum end as als_id_m1_m3_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_allnum_sum = 0 then -1 else als_id_m1_lsd_org_typ_allnum_sum/als_id_m6_lsd_org_typ_allnum_sum end as als_id_m1_m6_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_allnum_sum = 0 then -1 else als_id_m1_lsd_org_typ_allnum_sum/als_id_m12_lsd_org_typ_allnum_sum end as als_id_m1_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m6_lsd_org_typ_allnum_sum = 0 then -1 else als_id_m3_lsd_org_typ_allnum_sum/als_id_m6_lsd_org_typ_allnum_sum end as als_id_m3_m6_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_allnum_sum = 0 then -1 else als_id_m3_lsd_org_typ_allnum_sum/als_id_m12_lsd_org_typ_allnum_sum end as als_id_m3_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m12_lsd_org_typ_allnum_sum = 0 then -1 else als_id_m6_lsd_org_typ_allnum_sum/als_id_m12_lsd_org_typ_allnum_sum end as als_id_m6_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_orgnum_sum/als_id_d15_sloan_org_typ_orgnum_sum end as als_id_d7_d15_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_orgnum_sum/als_id_m1_sloan_org_typ_orgnum_sum end as als_id_d7_m1_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_orgnum_sum/als_id_m3_sloan_org_typ_orgnum_sum end as als_id_d7_m3_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_orgnum_sum/als_id_m6_sloan_org_typ_orgnum_sum end as als_id_d7_m6_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_orgnum_sum/als_id_m12_sloan_org_typ_orgnum_sum end as als_id_d7_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_orgnum_sum/als_id_m1_sloan_org_typ_orgnum_sum end as als_id_d15_m1_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_orgnum_sum/als_id_m3_sloan_org_typ_orgnum_sum end as als_id_d15_m3_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_orgnum_sum/als_id_m6_sloan_org_typ_orgnum_sum end as als_id_d15_m6_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_orgnum_sum/als_id_m12_sloan_org_typ_orgnum_sum end as als_id_d15_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_m1_sloan_org_typ_orgnum_sum/als_id_m3_sloan_org_typ_orgnum_sum end as als_id_m1_m3_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_m1_sloan_org_typ_orgnum_sum/als_id_m6_sloan_org_typ_orgnum_sum end as als_id_m1_m6_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_m1_sloan_org_typ_orgnum_sum/als_id_m12_sloan_org_typ_orgnum_sum end as als_id_m1_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_m3_sloan_org_typ_orgnum_sum/als_id_m6_sloan_org_typ_orgnum_sum end as als_id_m3_m6_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_m3_sloan_org_typ_orgnum_sum/als_id_m12_sloan_org_typ_orgnum_sum end as als_id_m3_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_orgnum_sum = 0 then -1 else als_id_m6_sloan_org_typ_orgnum_sum/als_id_m12_sloan_org_typ_orgnum_sum end as als_id_m6_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_allnum_sum/als_id_d15_sloan_org_typ_allnum_sum end as als_id_d7_d15_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_allnum_sum/als_id_m1_sloan_org_typ_allnum_sum end as als_id_d7_m1_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_allnum_sum/als_id_m3_sloan_org_typ_allnum_sum end as als_id_d7_m3_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_allnum_sum/als_id_m6_sloan_org_typ_allnum_sum end as als_id_d7_m6_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d7_sloan_org_typ_allnum_sum/als_id_m12_sloan_org_typ_allnum_sum end as als_id_d7_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_allnum_sum/als_id_m1_sloan_org_typ_allnum_sum end as als_id_d15_m1_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_allnum_sum/als_id_m3_sloan_org_typ_allnum_sum end as als_id_d15_m3_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_allnum_sum/als_id_m6_sloan_org_typ_allnum_sum end as als_id_d15_m6_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_allnum_sum = 0 then -1 else als_id_d15_sloan_org_typ_allnum_sum/als_id_m12_sloan_org_typ_allnum_sum end as als_id_d15_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_allnum_sum = 0 then -1 else als_id_m1_sloan_org_typ_allnum_sum/als_id_m3_sloan_org_typ_allnum_sum end as als_id_m1_m3_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_allnum_sum = 0 then -1 else als_id_m1_sloan_org_typ_allnum_sum/als_id_m6_sloan_org_typ_allnum_sum end as als_id_m1_m6_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_allnum_sum = 0 then -1 else als_id_m1_sloan_org_typ_allnum_sum/als_id_m12_sloan_org_typ_allnum_sum end as als_id_m1_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m6_sloan_org_typ_allnum_sum = 0 then -1 else als_id_m3_sloan_org_typ_allnum_sum/als_id_m6_sloan_org_typ_allnum_sum end as als_id_m3_m6_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_allnum_sum = 0 then -1 else als_id_m3_sloan_org_typ_allnum_sum/als_id_m12_sloan_org_typ_allnum_sum end as als_id_m3_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m12_sloan_org_typ_allnum_sum = 0 then -1 else als_id_m6_sloan_org_typ_allnum_sum/als_id_m12_sloan_org_typ_allnum_sum end as als_id_m6_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_orgnum_sum/als_id_d15_all_oth_org_typ_orgnum_sum end as als_id_d7_d15_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_orgnum_sum/als_id_m1_all_oth_org_typ_orgnum_sum end as als_id_d7_m1_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_orgnum_sum/als_id_m3_all_oth_org_typ_orgnum_sum end as als_id_d7_m3_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_orgnum_sum/als_id_m6_all_oth_org_typ_orgnum_sum end as als_id_d7_m6_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_orgnum_sum/als_id_m12_all_oth_org_typ_orgnum_sum end as als_id_d7_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_orgnum_sum/als_id_m1_all_oth_org_typ_orgnum_sum end as als_id_d15_m1_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_orgnum_sum/als_id_m3_all_oth_org_typ_orgnum_sum end as als_id_d15_m3_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_orgnum_sum/als_id_m6_all_oth_org_typ_orgnum_sum end as als_id_d15_m6_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_orgnum_sum/als_id_m12_all_oth_org_typ_orgnum_sum end as als_id_d15_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_m1_all_oth_org_typ_orgnum_sum/als_id_m3_all_oth_org_typ_orgnum_sum end as als_id_m1_m3_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_m1_all_oth_org_typ_orgnum_sum/als_id_m6_all_oth_org_typ_orgnum_sum end as als_id_m1_m6_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_m1_all_oth_org_typ_orgnum_sum/als_id_m12_all_oth_org_typ_orgnum_sum end as als_id_m1_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_m3_all_oth_org_typ_orgnum_sum/als_id_m6_all_oth_org_typ_orgnum_sum end as als_id_m3_m6_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_m3_all_oth_org_typ_orgnum_sum/als_id_m12_all_oth_org_typ_orgnum_sum end as als_id_m3_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_orgnum_sum = 0 then -1 else als_id_m6_all_oth_org_typ_orgnum_sum/als_id_m12_all_oth_org_typ_orgnum_sum end as als_id_m6_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_allnum_sum/als_id_d15_all_oth_org_typ_allnum_sum end as als_id_d7_d15_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_allnum_sum/als_id_m1_all_oth_org_typ_allnum_sum end as als_id_d7_m1_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_allnum_sum/als_id_m3_all_oth_org_typ_allnum_sum end as als_id_d7_m3_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_allnum_sum/als_id_m6_all_oth_org_typ_allnum_sum end as als_id_d7_m6_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d7_all_oth_org_typ_allnum_sum/als_id_m12_all_oth_org_typ_allnum_sum end as als_id_d7_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_allnum_sum/als_id_m1_all_oth_org_typ_allnum_sum end as als_id_d15_m1_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_allnum_sum/als_id_m3_all_oth_org_typ_allnum_sum end as als_id_d15_m3_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_allnum_sum/als_id_m6_all_oth_org_typ_allnum_sum end as als_id_d15_m6_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_d15_all_oth_org_typ_allnum_sum/als_id_m12_all_oth_org_typ_allnum_sum end as als_id_d15_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_m1_all_oth_org_typ_allnum_sum/als_id_m3_all_oth_org_typ_allnum_sum end as als_id_m1_m3_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_m1_all_oth_org_typ_allnum_sum/als_id_m6_all_oth_org_typ_allnum_sum end as als_id_m1_m6_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_m1_all_oth_org_typ_allnum_sum/als_id_m12_all_oth_org_typ_allnum_sum end as als_id_m1_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m6_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_m3_all_oth_org_typ_allnum_sum/als_id_m6_all_oth_org_typ_allnum_sum end as als_id_m3_m6_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_m3_all_oth_org_typ_allnum_sum/als_id_m12_all_oth_org_typ_allnum_sum end as als_id_m3_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m12_all_oth_org_typ_allnum_sum = 0 then -1 else als_id_m6_all_oth_org_typ_allnum_sum/als_id_m12_all_oth_org_typ_allnum_sum end as als_id_m6_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_d15_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d7_stg_org_typ_orgnum_sum/als_id_d15_stg_org_typ_orgnum_sum end as als_id_d7_d15_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m1_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d7_stg_org_typ_orgnum_sum/als_id_m1_stg_org_typ_orgnum_sum end as als_id_d7_m1_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m3_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d7_stg_org_typ_orgnum_sum/als_id_m3_stg_org_typ_orgnum_sum end as als_id_d7_m3_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m6_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d7_stg_org_typ_orgnum_sum/als_id_m6_stg_org_typ_orgnum_sum end as als_id_d7_m6_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m12_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d7_stg_org_typ_orgnum_sum/als_id_m12_stg_org_typ_orgnum_sum end as als_id_d7_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m1_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d15_stg_org_typ_orgnum_sum/als_id_m1_stg_org_typ_orgnum_sum end as als_id_d15_m1_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m3_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d15_stg_org_typ_orgnum_sum/als_id_m3_stg_org_typ_orgnum_sum end as als_id_d15_m3_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m6_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d15_stg_org_typ_orgnum_sum/als_id_m6_stg_org_typ_orgnum_sum end as als_id_d15_m6_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m12_stg_org_typ_orgnum_sum = 0 then -1 else als_id_d15_stg_org_typ_orgnum_sum/als_id_m12_stg_org_typ_orgnum_sum end as als_id_d15_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m3_stg_org_typ_orgnum_sum = 0 then -1 else als_id_m1_stg_org_typ_orgnum_sum/als_id_m3_stg_org_typ_orgnum_sum end as als_id_m1_m3_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m6_stg_org_typ_orgnum_sum = 0 then -1 else als_id_m1_stg_org_typ_orgnum_sum/als_id_m6_stg_org_typ_orgnum_sum end as als_id_m1_m6_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m12_stg_org_typ_orgnum_sum = 0 then -1 else als_id_m1_stg_org_typ_orgnum_sum/als_id_m12_stg_org_typ_orgnum_sum end as als_id_m1_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m6_stg_org_typ_orgnum_sum = 0 then -1 else als_id_m3_stg_org_typ_orgnum_sum/als_id_m6_stg_org_typ_orgnum_sum end as als_id_m3_m6_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m12_stg_org_typ_orgnum_sum = 0 then -1 else als_id_m3_stg_org_typ_orgnum_sum/als_id_m12_stg_org_typ_orgnum_sum end as als_id_m3_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m12_stg_org_typ_orgnum_sum = 0 then -1 else als_id_m6_stg_org_typ_orgnum_sum/als_id_m12_stg_org_typ_orgnum_sum end as als_id_m6_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_d15_stg_org_typ_allnum_sum = 0 then -1 else als_id_d7_stg_org_typ_allnum_sum/als_id_d15_stg_org_typ_allnum_sum end as als_id_d7_d15_stg_org_typ_allnum_sum_rto
        ,case when als_id_m1_stg_org_typ_allnum_sum = 0 then -1 else als_id_d7_stg_org_typ_allnum_sum/als_id_m1_stg_org_typ_allnum_sum end as als_id_d7_m1_stg_org_typ_allnum_sum_rto
        ,case when als_id_m3_stg_org_typ_allnum_sum = 0 then -1 else als_id_d7_stg_org_typ_allnum_sum/als_id_m3_stg_org_typ_allnum_sum end as als_id_d7_m3_stg_org_typ_allnum_sum_rto
        ,case when als_id_m6_stg_org_typ_allnum_sum = 0 then -1 else als_id_d7_stg_org_typ_allnum_sum/als_id_m6_stg_org_typ_allnum_sum end as als_id_d7_m6_stg_org_typ_allnum_sum_rto
        ,case when als_id_m12_stg_org_typ_allnum_sum = 0 then -1 else als_id_d7_stg_org_typ_allnum_sum/als_id_m12_stg_org_typ_allnum_sum end as als_id_d7_m12_stg_org_typ_allnum_sum_rto
        ,case when als_id_m1_stg_org_typ_allnum_sum = 0 then -1 else als_id_d15_stg_org_typ_allnum_sum/als_id_m1_stg_org_typ_allnum_sum end as als_id_d15_m1_stg_org_typ_allnum_sum_rto
        ,case when als_id_m3_stg_org_typ_allnum_sum = 0 then -1 else als_id_d15_stg_org_typ_allnum_sum/als_id_m3_stg_org_typ_allnum_sum end as als_id_d15_m3_stg_org_typ_allnum_sum_rto
        ,case when als_id_m6_stg_org_typ_allnum_sum = 0 then -1 else als_id_d15_stg_org_typ_allnum_sum/als_id_m6_stg_org_typ_allnum_sum end as als_id_d15_m6_stg_org_typ_allnum_sum_rto
        ,case when als_id_m12_stg_org_typ_allnum_sum = 0 then -1 else als_id_d15_stg_org_typ_allnum_sum/als_id_m12_stg_org_typ_allnum_sum end as als_id_d15_m12_stg_org_typ_allnum_sum_rto
        ,case when als_id_m3_stg_org_typ_allnum_sum = 0 then -1 else als_id_m1_stg_org_typ_allnum_sum/als_id_m3_stg_org_typ_allnum_sum end as als_id_m1_m3_stg_org_typ_allnum_sum_rto
        ,case when als_id_m6_stg_org_typ_allnum_sum = 0 then -1 else als_id_m1_stg_org_typ_allnum_sum/als_id_m6_stg_org_typ_allnum_sum end as als_id_m1_m6_stg_org_typ_allnum_sum_rto
        ,case when als_id_m12_stg_org_typ_allnum_sum = 0 then -1 else als_id_m1_stg_org_typ_allnum_sum/als_id_m12_stg_org_typ_allnum_sum end as als_id_m1_m12_stg_org_typ_allnum_sum_rto
        ,case when als_id_m6_stg_org_typ_allnum_sum = 0 then -1 else als_id_m3_stg_org_typ_allnum_sum/als_id_m6_stg_org_typ_allnum_sum end as als_id_m3_m6_stg_org_typ_allnum_sum_rto
        ,case when als_id_m12_stg_org_typ_allnum_sum = 0 then -1 else als_id_m3_stg_org_typ_allnum_sum/als_id_m12_stg_org_typ_allnum_sum end as als_id_m3_m12_stg_org_typ_allnum_sum_rto
        ,case when als_id_m12_stg_org_typ_allnum_sum = 0 then -1 else als_id_m6_stg_org_typ_allnum_sum/als_id_m12_stg_org_typ_allnum_sum end as als_id_m6_m12_stg_org_typ_allnum_sum_rto      
from dbus.dbus_dz_daily_br_trend_feature_v3_base_di
where ds = '${bizdate}'
;

-- 单变量趋势变化2
drop table if exists pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp2;
create table pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp2 as
select *
        ------------- 贷款/机构类型------------
        ,als_id_m3_loan_typ_orgnum_sum-als_id_m1_loan_typ_orgnum_sum as als_id_m1_m3_loan_typ_orgnum_sum
        ,als_id_m6_loan_typ_orgnum_sum-als_id_m3_loan_typ_orgnum_sum as als_id_m3_m6_loan_typ_orgnum_sum
        ,als_id_m12_loan_typ_orgnum_sum-als_id_m6_loan_typ_orgnum_sum as als_id_m6_m12_loan_typ_orgnum_sum
        ,als_id_m3_loan_typ_allnum_sum-als_id_m1_loan_typ_allnum_sum as als_id_m1_m3_loan_typ_allnum_sum
        ,als_id_m6_loan_typ_allnum_sum-als_id_m3_loan_typ_allnum_sum as als_id_m3_m6_loan_typ_allnum_sum
        ,als_id_m12_loan_typ_allnum_sum-als_id_m6_loan_typ_allnum_sum as als_id_m6_m12_loan_typ_allnum_sum
        ,als_id_m3_org_typ_orgnum_sum-als_id_m1_org_typ_orgnum_sum as als_id_m1_m3_org_typ_orgnum_sum
        ,als_id_m6_org_typ_orgnum_sum-als_id_m3_org_typ_orgnum_sum as als_id_m3_m6_org_typ_orgnum_sum
        ,als_id_m12_org_typ_orgnum_sum-als_id_m6_org_typ_orgnum_sum as als_id_m6_m12_org_typ_orgnum_sum
        ,als_id_m3_org_typ_allnum_sum-als_id_m1_org_typ_allnum_sum as als_id_m1_m3_org_typ_allnum_sum
        ,als_id_m6_org_typ_allnum_sum-als_id_m3_org_typ_allnum_sum as als_id_m3_m6_org_typ_allnum_sum
        ,als_id_m12_org_typ_allnum_sum-als_id_m6_org_typ_allnum_sum as als_id_m6_m12_org_typ_allnum_sum

        ------------- 时间类型------------
        ,als_id_m3_org_typ_week_orgnum_sum-als_id_m1_org_typ_week_orgnum_sum as als_id_m1_m3_org_typ_week_orgnum_sum
        ,als_id_m6_org_typ_week_orgnum_sum-als_id_m3_org_typ_week_orgnum_sum as als_id_m3_m6_org_typ_week_orgnum_sum
        ,als_id_m12_org_typ_week_orgnum_sum-als_id_m6_org_typ_week_orgnum_sum as als_id_m6_m12_org_typ_week_orgnum_sum
        ,als_id_m3_org_typ_week_allnum_sum-als_id_m1_org_typ_week_allnum_sum as als_id_m1_m3_org_typ_week_allnum_sum
        ,als_id_m6_org_typ_week_allnum_sum-als_id_m3_org_typ_week_allnum_sum as als_id_m3_m6_org_typ_week_allnum_sum
        ,als_id_m12_org_typ_week_allnum_sum-als_id_m6_org_typ_week_allnum_sum as als_id_m6_m12_org_typ_week_allnum_sum
        ,als_id_m3_org_typ_night_orgnum_sum-als_id_m1_org_typ_night_orgnum_sum as als_id_m1_m3_org_typ_night_orgnum_sum
        ,als_id_m6_org_typ_night_orgnum_sum-als_id_m3_org_typ_night_orgnum_sum as als_id_m3_m6_org_typ_night_orgnum_sum
        ,als_id_m12_org_typ_night_orgnum_sum-als_id_m6_org_typ_night_orgnum_sum as als_id_m6_m12_org_typ_night_orgnum_sum
        ,als_id_m3_org_typ_night_allnum_sum-als_id_m1_org_typ_night_allnum_sum as als_id_m1_m3_org_typ_night_allnum_sum
        ,als_id_m6_org_typ_night_allnum_sum-als_id_m3_org_typ_night_allnum_sum as als_id_m3_m6_org_typ_night_allnum_sum
        ,als_id_m12_org_typ_night_allnum_sum-als_id_m6_org_typ_night_allnum_sum as als_id_m6_m12_org_typ_night_allnum_sum

        -- /**部分类型汇总**/--
        ------------- 贷款类型------------
        ,als_id_m3_ca_loan_typ_orgnum_sum-als_id_m1_ca_loan_typ_orgnum_sum as als_id_m1_m3_ca_loan_typ_orgnum_sum
        ,als_id_m6_ca_loan_typ_orgnum_sum-als_id_m3_ca_loan_typ_orgnum_sum as als_id_m3_m6_ca_loan_typ_orgnum_sum
        ,als_id_m12_ca_loan_typ_orgnum_sum-als_id_m6_ca_loan_typ_orgnum_sum as als_id_m6_m12_ca_loan_typ_orgnum_sum
        ,als_id_m3_ca_loan_typ_allnum_sum-als_id_m1_ca_loan_typ_allnum_sum as als_id_m1_m3_ca_loan_typ_allnum_sum
        ,als_id_m6_ca_loan_typ_allnum_sum-als_id_m3_ca_loan_typ_allnum_sum as als_id_m3_m6_ca_loan_typ_allnum_sum
        ,als_id_m12_ca_loan_typ_allnum_sum-als_id_m6_ca_loan_typ_allnum_sum as als_id_m6_m12_ca_loan_typ_allnum_sum
        ,als_id_m3_co_loan_typ_orgnum_sum-als_id_m1_co_loan_typ_orgnum_sum as als_id_m1_m3_co_loan_typ_orgnum_sum
        ,als_id_m6_co_loan_typ_orgnum_sum-als_id_m3_co_loan_typ_orgnum_sum as als_id_m3_m6_co_loan_typ_orgnum_sum
        ,als_id_m12_co_loan_typ_orgnum_sum-als_id_m6_co_loan_typ_orgnum_sum as als_id_m6_m12_co_loan_typ_orgnum_sum
        ,als_id_m3_co_loan_typ_allnum_sum-als_id_m1_co_loan_typ_allnum_sum as als_id_m1_m3_co_loan_typ_allnum_sum
        ,als_id_m6_co_loan_typ_allnum_sum-als_id_m3_co_loan_typ_allnum_sum as als_id_m3_m6_co_loan_typ_allnum_sum
        ,als_id_m12_co_loan_typ_allnum_sum-als_id_m6_co_loan_typ_allnum_sum as als_id_m6_m12_co_loan_typ_allnum_sum
        ,als_id_m3_on_loan_typ_orgnum_sum-als_id_m1_on_loan_typ_orgnum_sum as als_id_m1_m3_on_loan_typ_orgnum_sum
        ,als_id_m6_on_loan_typ_orgnum_sum-als_id_m3_on_loan_typ_orgnum_sum as als_id_m3_m6_on_loan_typ_orgnum_sum
        ,als_id_m12_on_loan_typ_orgnum_sum-als_id_m6_on_loan_typ_orgnum_sum as als_id_m6_m12_on_loan_typ_orgnum_sum
        ,als_id_m3_on_loan_typ_allnum_sum-als_id_m1_on_loan_typ_allnum_sum as als_id_m1_m3_on_loan_typ_allnum_sum
        ,als_id_m6_on_loan_typ_allnum_sum-als_id_m3_on_loan_typ_allnum_sum as als_id_m3_m6_on_loan_typ_allnum_sum
        ,als_id_m12_on_loan_typ_allnum_sum-als_id_m6_on_loan_typ_allnum_sum as als_id_m6_m12_on_loan_typ_allnum_sum
        ,als_id_m3_off_loan_typ_orgnum_sum-als_id_m1_off_loan_typ_orgnum_sum as als_id_m1_m3_off_loan_typ_orgnum_sum
        ,als_id_m6_off_loan_typ_orgnum_sum-als_id_m3_off_loan_typ_orgnum_sum as als_id_m3_m6_off_loan_typ_orgnum_sum
        ,als_id_m12_off_loan_typ_orgnum_sum-als_id_m6_off_loan_typ_orgnum_sum as als_id_m6_m12_off_loan_typ_orgnum_sum
        ,als_id_m3_off_loan_typ_allnum_sum-als_id_m1_off_loan_typ_allnum_sum as als_id_m1_m3_off_loan_typ_allnum_sum
        ,als_id_m6_off_loan_typ_allnum_sum-als_id_m3_off_loan_typ_allnum_sum as als_id_m3_m6_off_loan_typ_allnum_sum
        ,als_id_m12_off_loan_typ_allnum_sum-als_id_m6_off_loan_typ_allnum_sum as als_id_m6_m12_off_loan_typ_allnum_sum

        ------------- 机构类型------------
        ,als_id_m3_lsd_org_typ_orgnum_sum-als_id_m1_lsd_org_typ_orgnum_sum as als_id_m1_m3_lsd_org_typ_orgnum_sum
        ,als_id_m6_lsd_org_typ_orgnum_sum-als_id_m3_lsd_org_typ_orgnum_sum as als_id_m3_m6_lsd_org_typ_orgnum_sum
        ,als_id_m12_lsd_org_typ_orgnum_sum-als_id_m6_lsd_org_typ_orgnum_sum as als_id_m6_m12_lsd_org_typ_orgnum_sum
        ,als_id_m3_lsd_org_typ_allnum_sum-als_id_m1_lsd_org_typ_allnum_sum as als_id_m1_m3_lsd_org_typ_allnum_sum
        ,als_id_m6_lsd_org_typ_allnum_sum-als_id_m3_lsd_org_typ_allnum_sum as als_id_m3_m6_lsd_org_typ_allnum_sum
        ,als_id_m12_lsd_org_typ_allnum_sum-als_id_m6_lsd_org_typ_allnum_sum as als_id_m6_m12_lsd_org_typ_allnum_sum
        ,als_id_m3_sloan_org_typ_orgnum_sum-als_id_m1_sloan_org_typ_orgnum_sum as als_id_m1_m3_sloan_org_typ_orgnum_sum
        ,als_id_m6_sloan_org_typ_orgnum_sum-als_id_m3_sloan_org_typ_orgnum_sum as als_id_m3_m6_sloan_org_typ_orgnum_sum
        ,als_id_m12_sloan_org_typ_orgnum_sum-als_id_m6_sloan_org_typ_orgnum_sum as als_id_m6_m12_sloan_org_typ_orgnum_sum
        ,als_id_m3_sloan_org_typ_allnum_sum-als_id_m1_sloan_org_typ_allnum_sum as als_id_m1_m3_sloan_org_typ_allnum_sum
        ,als_id_m6_sloan_org_typ_allnum_sum-als_id_m3_sloan_org_typ_allnum_sum as als_id_m3_m6_sloan_org_typ_allnum_sum
        ,als_id_m12_sloan_org_typ_allnum_sum-als_id_m6_sloan_org_typ_allnum_sum as als_id_m6_m12_sloan_org_typ_allnum_sum
        ,als_id_m3_all_oth_org_typ_orgnum_sum-als_id_m1_all_oth_org_typ_orgnum_sum as als_id_m1_m3_all_oth_org_typ_orgnum_sum
        ,als_id_m6_all_oth_org_typ_orgnum_sum-als_id_m3_all_oth_org_typ_orgnum_sum as als_id_m3_m6_all_oth_org_typ_orgnum_sum
        ,als_id_m12_all_oth_org_typ_orgnum_sum-als_id_m6_all_oth_org_typ_orgnum_sum as als_id_m6_m12_all_oth_org_typ_orgnum_sum
        ,als_id_m3_all_oth_org_typ_allnum_sum-als_id_m1_all_oth_org_typ_allnum_sum as als_id_m1_m3_all_oth_org_typ_allnum_sum
        ,als_id_m6_all_oth_org_typ_allnum_sum-als_id_m3_all_oth_org_typ_allnum_sum as als_id_m3_m6_all_oth_org_typ_allnum_sum
        ,als_id_m12_all_oth_org_typ_allnum_sum-als_id_m6_all_oth_org_typ_allnum_sum as als_id_m6_m12_all_oth_org_typ_allnum_sum
        ,als_id_m3_stg_org_typ_orgnum_sum-als_id_m1_stg_org_typ_orgnum_sum as als_id_m1_m3_stg_org_typ_orgnum_sum
        ,als_id_m6_stg_org_typ_orgnum_sum-als_id_m3_stg_org_typ_orgnum_sum as als_id_m3_m6_stg_org_typ_orgnum_sum
        ,als_id_m12_stg_org_typ_orgnum_sum-als_id_m6_stg_org_typ_orgnum_sum as als_id_m6_m12_stg_org_typ_orgnum_sum
        ,als_id_m3_stg_org_typ_allnum_sum-als_id_m1_stg_org_typ_allnum_sum as als_id_m1_m3_stg_org_typ_allnum_sum
        ,als_id_m6_stg_org_typ_allnum_sum-als_id_m3_stg_org_typ_allnum_sum as als_id_m3_m6_stg_org_typ_allnum_sum
        ,als_id_m12_stg_org_typ_allnum_sum-als_id_m6_stg_org_typ_allnum_sum as als_id_m6_m12_stg_org_typ_allnum_sum
from dbus.dbus_dz_daily_br_trend_feature_v3_base_di
where ds = '${bizdate}'
;



drop table if exists pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp3;
create table pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp3 as
select uid
        ,swift_number
        -- 贷款/机构类型趋势
        ,case when als_id_d15_loan_typ_orgnum_sum = 0 and als_id_m1_m3_loan_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_loan_typ_orgnum_sum = 0 then als_id_d15_loan_typ_orgnum_sum else als_id_d15_loan_typ_orgnum_sum/als_id_m1_m3_loan_typ_orgnum_sum end as als_id_d15_m1_m3_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_loan_typ_orgnum_sum = 0 and als_id_m3_m6_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_loan_typ_orgnum_sum = 0 then als_id_d15_loan_typ_orgnum_sum else als_id_d15_loan_typ_orgnum_sum/als_id_m3_m6_loan_typ_orgnum_sum end as als_id_d15_m3_m6_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_loan_typ_orgnum_sum = 0 and als_id_m6_m12_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_loan_typ_orgnum_sum = 0 then als_id_d15_loan_typ_orgnum_sum else als_id_d15_loan_typ_orgnum_sum/als_id_m6_m12_loan_typ_orgnum_sum end as als_id_d15_m6_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_loan_typ_orgnum_sum = 0 and als_id_m3_m6_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_loan_typ_orgnum_sum = 0 then als_id_m1_loan_typ_orgnum_sum else als_id_m1_loan_typ_orgnum_sum/als_id_m3_m6_loan_typ_orgnum_sum end as als_id_m1_m3_m6_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_loan_typ_orgnum_sum = 0 and als_id_m6_m12_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_loan_typ_orgnum_sum = 0 then als_id_m1_loan_typ_orgnum_sum else als_id_m1_loan_typ_orgnum_sum/als_id_m6_m12_loan_typ_orgnum_sum end as als_id_m1_m6_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_loan_typ_orgnum_sum = 0 and als_id_m6_m12_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_loan_typ_orgnum_sum = 0 then als_id_m3_loan_typ_orgnum_sum else als_id_m3_loan_typ_orgnum_sum/als_id_m6_m12_loan_typ_orgnum_sum end as als_id_m3_m6_m12_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_loan_typ_allnum_sum = 0 and als_id_m1_m3_loan_typ_allnum_sum = 0 then -1 when als_id_m1_m3_loan_typ_allnum_sum = 0 then als_id_d15_loan_typ_allnum_sum else als_id_d15_loan_typ_allnum_sum/als_id_m1_m3_loan_typ_allnum_sum end as als_id_d15_m1_m3_loan_typ_allnum_sum_rto
        ,case when als_id_d15_loan_typ_allnum_sum = 0 and als_id_m3_m6_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_loan_typ_allnum_sum = 0 then als_id_d15_loan_typ_allnum_sum else als_id_d15_loan_typ_allnum_sum/als_id_m3_m6_loan_typ_allnum_sum end as als_id_d15_m3_m6_loan_typ_allnum_sum_rto
        ,case when als_id_d15_loan_typ_allnum_sum = 0 and als_id_m6_m12_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_loan_typ_allnum_sum = 0 then als_id_d15_loan_typ_allnum_sum else als_id_d15_loan_typ_allnum_sum/als_id_m6_m12_loan_typ_allnum_sum end as als_id_d15_m6_m12_loan_typ_allnum_sum_rto
        ,case when als_id_m1_loan_typ_allnum_sum = 0 and als_id_m3_m6_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_loan_typ_allnum_sum = 0 then als_id_m1_loan_typ_allnum_sum else als_id_m1_loan_typ_allnum_sum/als_id_m3_m6_loan_typ_allnum_sum end as als_id_m1_m3_m6_loan_typ_allnum_sum_rto
        ,case when als_id_m1_loan_typ_allnum_sum = 0 and als_id_m6_m12_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_loan_typ_allnum_sum = 0 then als_id_m1_loan_typ_allnum_sum else als_id_m1_loan_typ_allnum_sum/als_id_m6_m12_loan_typ_allnum_sum end as als_id_m1_m6_m12_loan_typ_allnum_sum_rto
        ,case when als_id_m3_loan_typ_allnum_sum = 0 and als_id_m6_m12_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_loan_typ_allnum_sum = 0 then als_id_m3_loan_typ_allnum_sum else als_id_m3_loan_typ_allnum_sum/als_id_m6_m12_loan_typ_allnum_sum end as als_id_m3_m6_m12_loan_typ_allnum_sum_rto
        ,case when als_id_d15_org_typ_orgnum_sum = 0 and als_id_m1_m3_org_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_org_typ_orgnum_sum = 0 then als_id_d15_org_typ_orgnum_sum else als_id_d15_org_typ_orgnum_sum/als_id_m1_m3_org_typ_orgnum_sum end as als_id_d15_m1_m3_org_typ_orgnum_sum_rto
        ,case when als_id_d15_org_typ_orgnum_sum = 0 and als_id_m3_m6_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_org_typ_orgnum_sum = 0 then als_id_d15_org_typ_orgnum_sum else als_id_d15_org_typ_orgnum_sum/als_id_m3_m6_org_typ_orgnum_sum end as als_id_d15_m3_m6_org_typ_orgnum_sum_rto
        ,case when als_id_d15_org_typ_orgnum_sum = 0 and als_id_m6_m12_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_orgnum_sum = 0 then als_id_d15_org_typ_orgnum_sum else als_id_d15_org_typ_orgnum_sum/als_id_m6_m12_org_typ_orgnum_sum end as als_id_d15_m6_m12_org_typ_orgnum_sum_rto
        ,case when als_id_m1_org_typ_orgnum_sum = 0 and als_id_m3_m6_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_org_typ_orgnum_sum = 0 then als_id_m1_org_typ_orgnum_sum else als_id_m1_org_typ_orgnum_sum/als_id_m3_m6_org_typ_orgnum_sum end as als_id_m1_m3_m6_org_typ_orgnum_sum_rto
        ,case when als_id_m1_org_typ_orgnum_sum = 0 and als_id_m6_m12_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_orgnum_sum = 0 then als_id_m1_org_typ_orgnum_sum else als_id_m1_org_typ_orgnum_sum/als_id_m6_m12_org_typ_orgnum_sum end as als_id_m1_m6_m12_org_typ_orgnum_sum_rto
        ,case when als_id_m3_org_typ_orgnum_sum = 0 and als_id_m6_m12_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_orgnum_sum = 0 then als_id_m3_org_typ_orgnum_sum else als_id_m3_org_typ_orgnum_sum/als_id_m6_m12_org_typ_orgnum_sum end as als_id_m3_m6_m12_org_typ_orgnum_sum_rto
        ,case when als_id_d15_org_typ_allnum_sum = 0 and als_id_m1_m3_org_typ_allnum_sum = 0 then -1 when als_id_m1_m3_org_typ_allnum_sum = 0 then als_id_d15_org_typ_allnum_sum else als_id_d15_org_typ_allnum_sum/als_id_m1_m3_org_typ_allnum_sum end as als_id_d15_m1_m3_org_typ_allnum_sum_rto
        ,case when als_id_d15_org_typ_allnum_sum = 0 and als_id_m3_m6_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_org_typ_allnum_sum = 0 then als_id_d15_org_typ_allnum_sum else als_id_d15_org_typ_allnum_sum/als_id_m3_m6_org_typ_allnum_sum end as als_id_d15_m3_m6_org_typ_allnum_sum_rto
        ,case when als_id_d15_org_typ_allnum_sum = 0 and als_id_m6_m12_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_allnum_sum = 0 then als_id_d15_org_typ_allnum_sum else als_id_d15_org_typ_allnum_sum/als_id_m6_m12_org_typ_allnum_sum end as als_id_d15_m6_m12_org_typ_allnum_sum_rto
        ,case when als_id_m1_org_typ_allnum_sum = 0 and als_id_m3_m6_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_org_typ_allnum_sum = 0 then als_id_m1_org_typ_allnum_sum else als_id_m1_org_typ_allnum_sum/als_id_m3_m6_org_typ_allnum_sum end as als_id_m1_m3_m6_org_typ_allnum_sum_rto
        ,case when als_id_m1_org_typ_allnum_sum = 0 and als_id_m6_m12_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_allnum_sum = 0 then als_id_m1_org_typ_allnum_sum else als_id_m1_org_typ_allnum_sum/als_id_m6_m12_org_typ_allnum_sum end as als_id_m1_m6_m12_org_typ_allnum_sum_rto
        ,case when als_id_m3_org_typ_allnum_sum = 0 and als_id_m6_m12_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_allnum_sum = 0 then als_id_m3_org_typ_allnum_sum else als_id_m3_org_typ_allnum_sum/als_id_m6_m12_org_typ_allnum_sum end as als_id_m3_m6_m12_org_typ_allnum_sum_rto

        -- 周末/夜间趋势
        ,case when als_id_d15_org_typ_week_orgnum_sum = 0 and als_id_m1_m3_org_typ_week_orgnum_sum = 0 then -1 when als_id_m1_m3_org_typ_week_orgnum_sum = 0 then als_id_d15_org_typ_week_orgnum_sum else als_id_d15_org_typ_week_orgnum_sum/als_id_m1_m3_org_typ_week_orgnum_sum end as als_id_d15_m1_m3_org_typ_week_orgnum_sum_rto
        ,case when als_id_d15_org_typ_week_orgnum_sum = 0 and als_id_m3_m6_org_typ_week_orgnum_sum = 0 then -1 when als_id_m3_m6_org_typ_week_orgnum_sum = 0 then als_id_d15_org_typ_week_orgnum_sum else als_id_d15_org_typ_week_orgnum_sum/als_id_m3_m6_org_typ_week_orgnum_sum end as als_id_d15_m3_m6_org_typ_week_orgnum_sum_rto
        ,case when als_id_d15_org_typ_week_orgnum_sum = 0 and als_id_m6_m12_org_typ_week_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_week_orgnum_sum = 0 then als_id_d15_org_typ_week_orgnum_sum else als_id_d15_org_typ_week_orgnum_sum/als_id_m6_m12_org_typ_week_orgnum_sum end as als_id_d15_m6_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_m1_org_typ_week_orgnum_sum = 0 and als_id_m3_m6_org_typ_week_orgnum_sum = 0 then -1 when als_id_m3_m6_org_typ_week_orgnum_sum = 0 then als_id_m1_org_typ_week_orgnum_sum else als_id_m1_org_typ_week_orgnum_sum/als_id_m3_m6_org_typ_week_orgnum_sum end as als_id_m1_m3_m6_org_typ_week_orgnum_sum_rto
        ,case when als_id_m1_org_typ_week_orgnum_sum = 0 and als_id_m6_m12_org_typ_week_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_week_orgnum_sum = 0 then als_id_m1_org_typ_week_orgnum_sum else als_id_m1_org_typ_week_orgnum_sum/als_id_m6_m12_org_typ_week_orgnum_sum end as als_id_m1_m6_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_m3_org_typ_week_orgnum_sum = 0 and als_id_m6_m12_org_typ_week_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_week_orgnum_sum = 0 then als_id_m3_org_typ_week_orgnum_sum else als_id_m3_org_typ_week_orgnum_sum/als_id_m6_m12_org_typ_week_orgnum_sum end as als_id_m3_m6_m12_org_typ_week_orgnum_sum_rto
        ,case when als_id_d15_org_typ_week_allnum_sum = 0 and als_id_m1_m3_org_typ_week_allnum_sum = 0 then -1 when als_id_m1_m3_org_typ_week_allnum_sum = 0 then als_id_d15_org_typ_week_allnum_sum else als_id_d15_org_typ_week_allnum_sum/als_id_m1_m3_org_typ_week_allnum_sum end as als_id_d15_m1_m3_org_typ_week_allnum_sum_rto
        ,case when als_id_d15_org_typ_week_allnum_sum = 0 and als_id_m3_m6_org_typ_week_allnum_sum = 0 then -1 when als_id_m3_m6_org_typ_week_allnum_sum = 0 then als_id_d15_org_typ_week_allnum_sum else als_id_d15_org_typ_week_allnum_sum/als_id_m3_m6_org_typ_week_allnum_sum end as als_id_d15_m3_m6_org_typ_week_allnum_sum_rto
        ,case when als_id_d15_org_typ_week_allnum_sum = 0 and als_id_m6_m12_org_typ_week_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_week_allnum_sum = 0 then als_id_d15_org_typ_week_allnum_sum else als_id_d15_org_typ_week_allnum_sum/als_id_m6_m12_org_typ_week_allnum_sum end as als_id_d15_m6_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_m1_org_typ_week_allnum_sum = 0 and als_id_m3_m6_org_typ_week_allnum_sum = 0 then -1 when als_id_m3_m6_org_typ_week_allnum_sum = 0 then als_id_m1_org_typ_week_allnum_sum else als_id_m1_org_typ_week_allnum_sum/als_id_m3_m6_org_typ_week_allnum_sum end as als_id_m1_m3_m6_org_typ_week_allnum_sum_rto
        ,case when als_id_m1_org_typ_week_allnum_sum = 0 and als_id_m6_m12_org_typ_week_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_week_allnum_sum = 0 then als_id_m1_org_typ_week_allnum_sum else als_id_m1_org_typ_week_allnum_sum/als_id_m6_m12_org_typ_week_allnum_sum end as als_id_m1_m6_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_m3_org_typ_week_allnum_sum = 0 and als_id_m6_m12_org_typ_week_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_week_allnum_sum = 0 then als_id_m3_org_typ_week_allnum_sum else als_id_m3_org_typ_week_allnum_sum/als_id_m6_m12_org_typ_week_allnum_sum end as als_id_m3_m6_m12_org_typ_week_allnum_sum_rto
        ,case when als_id_d15_org_typ_night_orgnum_sum = 0 and als_id_m1_m3_org_typ_night_orgnum_sum = 0 then -1 when als_id_m1_m3_org_typ_night_orgnum_sum = 0 then als_id_d15_org_typ_night_orgnum_sum else als_id_d15_org_typ_night_orgnum_sum/als_id_m1_m3_org_typ_night_orgnum_sum end as als_id_d15_m1_m3_org_typ_night_orgnum_sum_rto
        ,case when als_id_d15_org_typ_night_orgnum_sum = 0 and als_id_m3_m6_org_typ_night_orgnum_sum = 0 then -1 when als_id_m3_m6_org_typ_night_orgnum_sum = 0 then als_id_d15_org_typ_night_orgnum_sum else als_id_d15_org_typ_night_orgnum_sum/als_id_m3_m6_org_typ_night_orgnum_sum end as als_id_d15_m3_m6_org_typ_night_orgnum_sum_rto
        ,case when als_id_d15_org_typ_night_orgnum_sum = 0 and als_id_m6_m12_org_typ_night_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_night_orgnum_sum = 0 then als_id_d15_org_typ_night_orgnum_sum else als_id_d15_org_typ_night_orgnum_sum/als_id_m6_m12_org_typ_night_orgnum_sum end as als_id_d15_m6_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_m1_org_typ_night_orgnum_sum = 0 and als_id_m3_m6_org_typ_night_orgnum_sum = 0 then -1 when als_id_m3_m6_org_typ_night_orgnum_sum = 0 then als_id_m1_org_typ_night_orgnum_sum else als_id_m1_org_typ_night_orgnum_sum/als_id_m3_m6_org_typ_night_orgnum_sum end as als_id_m1_m3_m6_org_typ_night_orgnum_sum_rto
        ,case when als_id_m1_org_typ_night_orgnum_sum = 0 and als_id_m6_m12_org_typ_night_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_night_orgnum_sum = 0 then als_id_m1_org_typ_night_orgnum_sum else als_id_m1_org_typ_night_orgnum_sum/als_id_m6_m12_org_typ_night_orgnum_sum end as als_id_m1_m6_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_m3_org_typ_night_orgnum_sum = 0 and als_id_m6_m12_org_typ_night_orgnum_sum = 0 then -1 when als_id_m6_m12_org_typ_night_orgnum_sum = 0 then als_id_m3_org_typ_night_orgnum_sum else als_id_m3_org_typ_night_orgnum_sum/als_id_m6_m12_org_typ_night_orgnum_sum end as als_id_m3_m6_m12_org_typ_night_orgnum_sum_rto
        ,case when als_id_d15_org_typ_night_allnum_sum = 0 and als_id_m1_m3_org_typ_night_allnum_sum = 0 then -1 when als_id_m1_m3_org_typ_night_allnum_sum = 0 then als_id_d15_org_typ_night_allnum_sum else als_id_d15_org_typ_night_allnum_sum/als_id_m1_m3_org_typ_night_allnum_sum end as als_id_d15_m1_m3_org_typ_night_allnum_sum_rto
        ,case when als_id_d15_org_typ_night_allnum_sum = 0 and als_id_m3_m6_org_typ_night_allnum_sum = 0 then -1 when als_id_m3_m6_org_typ_night_allnum_sum = 0 then als_id_d15_org_typ_night_allnum_sum else als_id_d15_org_typ_night_allnum_sum/als_id_m3_m6_org_typ_night_allnum_sum end as als_id_d15_m3_m6_org_typ_night_allnum_sum_rto
        ,case when als_id_d15_org_typ_night_allnum_sum = 0 and als_id_m6_m12_org_typ_night_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_night_allnum_sum = 0 then als_id_d15_org_typ_night_allnum_sum else als_id_d15_org_typ_night_allnum_sum/als_id_m6_m12_org_typ_night_allnum_sum end as als_id_d15_m6_m12_org_typ_night_allnum_sum_rto
        ,case when als_id_m1_org_typ_night_allnum_sum = 0 and als_id_m3_m6_org_typ_night_allnum_sum = 0 then -1 when als_id_m3_m6_org_typ_night_allnum_sum = 0 then als_id_m1_org_typ_night_allnum_sum else als_id_m1_org_typ_night_allnum_sum/als_id_m3_m6_org_typ_night_allnum_sum end as als_id_m1_m3_m6_org_typ_night_allnum_sum_rto
        ,case when als_id_m1_org_typ_night_allnum_sum = 0 and als_id_m6_m12_org_typ_night_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_night_allnum_sum = 0 then als_id_m1_org_typ_night_allnum_sum else als_id_m1_org_typ_night_allnum_sum/als_id_m6_m12_org_typ_night_allnum_sum end as als_id_m1_m6_m12_org_typ_night_allnum_sum_rto
        ,case when als_id_m3_org_typ_night_allnum_sum = 0 and als_id_m6_m12_org_typ_night_allnum_sum = 0 then -1 when als_id_m6_m12_org_typ_night_allnum_sum = 0 then als_id_m3_org_typ_night_allnum_sum else als_id_m3_org_typ_night_allnum_sum/als_id_m6_m12_org_typ_night_allnum_sum end as als_id_m3_m6_m12_org_typ_night_allnum_sum_rto
       
        -- 分类贷款类型趋势
        ,case when als_id_d15_ca_loan_typ_orgnum_sum = 0 and als_id_m1_m3_ca_loan_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_ca_loan_typ_orgnum_sum = 0 then als_id_d15_ca_loan_typ_orgnum_sum else als_id_d15_ca_loan_typ_orgnum_sum/als_id_m1_m3_ca_loan_typ_orgnum_sum end as als_id_d15_m1_m3_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_ca_loan_typ_orgnum_sum = 0 and als_id_m3_m6_ca_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_ca_loan_typ_orgnum_sum = 0 then als_id_d15_ca_loan_typ_orgnum_sum else als_id_d15_ca_loan_typ_orgnum_sum/als_id_m3_m6_ca_loan_typ_orgnum_sum end as als_id_d15_m3_m6_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_ca_loan_typ_orgnum_sum = 0 and als_id_m6_m12_ca_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_ca_loan_typ_orgnum_sum = 0 then als_id_d15_ca_loan_typ_orgnum_sum else als_id_d15_ca_loan_typ_orgnum_sum/als_id_m6_m12_ca_loan_typ_orgnum_sum end as als_id_d15_m6_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_orgnum_sum = 0 and als_id_m3_m6_ca_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_ca_loan_typ_orgnum_sum = 0 then als_id_m1_ca_loan_typ_orgnum_sum else als_id_m1_ca_loan_typ_orgnum_sum/als_id_m3_m6_ca_loan_typ_orgnum_sum end as als_id_m1_m3_m6_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_orgnum_sum = 0 and als_id_m6_m12_ca_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_ca_loan_typ_orgnum_sum = 0 then als_id_m1_ca_loan_typ_orgnum_sum else als_id_m1_ca_loan_typ_orgnum_sum/als_id_m6_m12_ca_loan_typ_orgnum_sum end as als_id_m1_m6_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_orgnum_sum = 0 and als_id_m6_m12_ca_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_ca_loan_typ_orgnum_sum = 0 then als_id_m3_ca_loan_typ_orgnum_sum else als_id_m3_ca_loan_typ_orgnum_sum/als_id_m6_m12_ca_loan_typ_orgnum_sum end as als_id_m3_m6_m12_ca_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_ca_loan_typ_allnum_sum = 0 and als_id_m1_m3_ca_loan_typ_allnum_sum = 0 then -1 when als_id_m1_m3_ca_loan_typ_allnum_sum = 0 then als_id_d15_ca_loan_typ_allnum_sum else als_id_d15_ca_loan_typ_allnum_sum/als_id_m1_m3_ca_loan_typ_allnum_sum end as als_id_d15_m1_m3_ca_loan_typ_allnum_sum_rto
        ,case when als_id_d15_ca_loan_typ_allnum_sum = 0 and als_id_m3_m6_ca_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_ca_loan_typ_allnum_sum = 0 then als_id_d15_ca_loan_typ_allnum_sum else als_id_d15_ca_loan_typ_allnum_sum/als_id_m3_m6_ca_loan_typ_allnum_sum end as als_id_d15_m3_m6_ca_loan_typ_allnum_sum_rto
        ,case when als_id_d15_ca_loan_typ_allnum_sum = 0 and als_id_m6_m12_ca_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_ca_loan_typ_allnum_sum = 0 then als_id_d15_ca_loan_typ_allnum_sum else als_id_d15_ca_loan_typ_allnum_sum/als_id_m6_m12_ca_loan_typ_allnum_sum end as als_id_d15_m6_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_allnum_sum = 0 and als_id_m3_m6_ca_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_ca_loan_typ_allnum_sum = 0 then als_id_m1_ca_loan_typ_allnum_sum else als_id_m1_ca_loan_typ_allnum_sum/als_id_m3_m6_ca_loan_typ_allnum_sum end as als_id_m1_m3_m6_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m1_ca_loan_typ_allnum_sum = 0 and als_id_m6_m12_ca_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_ca_loan_typ_allnum_sum = 0 then als_id_m1_ca_loan_typ_allnum_sum else als_id_m1_ca_loan_typ_allnum_sum/als_id_m6_m12_ca_loan_typ_allnum_sum end as als_id_m1_m6_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_m3_ca_loan_typ_allnum_sum = 0 and als_id_m6_m12_ca_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_ca_loan_typ_allnum_sum = 0 then als_id_m3_ca_loan_typ_allnum_sum else als_id_m3_ca_loan_typ_allnum_sum/als_id_m6_m12_ca_loan_typ_allnum_sum end as als_id_m3_m6_m12_ca_loan_typ_allnum_sum_rto
        ,case when als_id_d15_co_loan_typ_orgnum_sum = 0 and als_id_m1_m3_co_loan_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_co_loan_typ_orgnum_sum = 0 then als_id_d15_co_loan_typ_orgnum_sum else als_id_d15_co_loan_typ_orgnum_sum/als_id_m1_m3_co_loan_typ_orgnum_sum end as als_id_d15_m1_m3_co_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_co_loan_typ_orgnum_sum = 0 and als_id_m3_m6_co_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_co_loan_typ_orgnum_sum = 0 then als_id_d15_co_loan_typ_orgnum_sum else als_id_d15_co_loan_typ_orgnum_sum/als_id_m3_m6_co_loan_typ_orgnum_sum end as als_id_d15_m3_m6_co_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_co_loan_typ_orgnum_sum = 0 and als_id_m6_m12_co_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_co_loan_typ_orgnum_sum = 0 then als_id_d15_co_loan_typ_orgnum_sum else als_id_d15_co_loan_typ_orgnum_sum/als_id_m6_m12_co_loan_typ_orgnum_sum end as als_id_d15_m6_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_co_loan_typ_orgnum_sum = 0 and als_id_m3_m6_co_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_co_loan_typ_orgnum_sum = 0 then als_id_m1_co_loan_typ_orgnum_sum else als_id_m1_co_loan_typ_orgnum_sum/als_id_m3_m6_co_loan_typ_orgnum_sum end as als_id_m1_m3_m6_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_co_loan_typ_orgnum_sum = 0 and als_id_m6_m12_co_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_co_loan_typ_orgnum_sum = 0 then als_id_m1_co_loan_typ_orgnum_sum else als_id_m1_co_loan_typ_orgnum_sum/als_id_m6_m12_co_loan_typ_orgnum_sum end as als_id_m1_m6_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_co_loan_typ_orgnum_sum = 0 and als_id_m6_m12_co_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_co_loan_typ_orgnum_sum = 0 then als_id_m3_co_loan_typ_orgnum_sum else als_id_m3_co_loan_typ_orgnum_sum/als_id_m6_m12_co_loan_typ_orgnum_sum end as als_id_m3_m6_m12_co_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_co_loan_typ_allnum_sum = 0 and als_id_m1_m3_co_loan_typ_allnum_sum = 0 then -1 when als_id_m1_m3_co_loan_typ_allnum_sum = 0 then als_id_d15_co_loan_typ_allnum_sum else als_id_d15_co_loan_typ_allnum_sum/als_id_m1_m3_co_loan_typ_allnum_sum end as als_id_d15_m1_m3_co_loan_typ_allnum_sum_rto
        ,case when als_id_d15_co_loan_typ_allnum_sum = 0 and als_id_m3_m6_co_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_co_loan_typ_allnum_sum = 0 then als_id_d15_co_loan_typ_allnum_sum else als_id_d15_co_loan_typ_allnum_sum/als_id_m3_m6_co_loan_typ_allnum_sum end as als_id_d15_m3_m6_co_loan_typ_allnum_sum_rto
        ,case when als_id_d15_co_loan_typ_allnum_sum = 0 and als_id_m6_m12_co_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_co_loan_typ_allnum_sum = 0 then als_id_d15_co_loan_typ_allnum_sum else als_id_d15_co_loan_typ_allnum_sum/als_id_m6_m12_co_loan_typ_allnum_sum end as als_id_d15_m6_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_m1_co_loan_typ_allnum_sum = 0 and als_id_m3_m6_co_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_co_loan_typ_allnum_sum = 0 then als_id_m1_co_loan_typ_allnum_sum else als_id_m1_co_loan_typ_allnum_sum/als_id_m3_m6_co_loan_typ_allnum_sum end as als_id_m1_m3_m6_co_loan_typ_allnum_sum_rto
        ,case when als_id_m1_co_loan_typ_allnum_sum = 0 and als_id_m6_m12_co_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_co_loan_typ_allnum_sum = 0 then als_id_m1_co_loan_typ_allnum_sum else als_id_m1_co_loan_typ_allnum_sum/als_id_m6_m12_co_loan_typ_allnum_sum end as als_id_m1_m6_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_m3_co_loan_typ_allnum_sum = 0 and als_id_m6_m12_co_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_co_loan_typ_allnum_sum = 0 then als_id_m3_co_loan_typ_allnum_sum else als_id_m3_co_loan_typ_allnum_sum/als_id_m6_m12_co_loan_typ_allnum_sum end as als_id_m3_m6_m12_co_loan_typ_allnum_sum_rto
        ,case when als_id_d15_on_loan_typ_orgnum_sum = 0 and als_id_m1_m3_on_loan_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_on_loan_typ_orgnum_sum = 0 then als_id_d15_on_loan_typ_orgnum_sum else als_id_d15_on_loan_typ_orgnum_sum/als_id_m1_m3_on_loan_typ_orgnum_sum end as als_id_d15_m1_m3_on_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_on_loan_typ_orgnum_sum = 0 and als_id_m3_m6_on_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_on_loan_typ_orgnum_sum = 0 then als_id_d15_on_loan_typ_orgnum_sum else als_id_d15_on_loan_typ_orgnum_sum/als_id_m3_m6_on_loan_typ_orgnum_sum end as als_id_d15_m3_m6_on_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_on_loan_typ_orgnum_sum = 0 and als_id_m6_m12_on_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_on_loan_typ_orgnum_sum = 0 then als_id_d15_on_loan_typ_orgnum_sum else als_id_d15_on_loan_typ_orgnum_sum/als_id_m6_m12_on_loan_typ_orgnum_sum end as als_id_d15_m6_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_on_loan_typ_orgnum_sum = 0 and als_id_m3_m6_on_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_on_loan_typ_orgnum_sum = 0 then als_id_m1_on_loan_typ_orgnum_sum else als_id_m1_on_loan_typ_orgnum_sum/als_id_m3_m6_on_loan_typ_orgnum_sum end as als_id_m1_m3_m6_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_on_loan_typ_orgnum_sum = 0 and als_id_m6_m12_on_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_on_loan_typ_orgnum_sum = 0 then als_id_m1_on_loan_typ_orgnum_sum else als_id_m1_on_loan_typ_orgnum_sum/als_id_m6_m12_on_loan_typ_orgnum_sum end as als_id_m1_m6_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_on_loan_typ_orgnum_sum = 0 and als_id_m6_m12_on_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_on_loan_typ_orgnum_sum = 0 then als_id_m3_on_loan_typ_orgnum_sum else als_id_m3_on_loan_typ_orgnum_sum/als_id_m6_m12_on_loan_typ_orgnum_sum end as als_id_m3_m6_m12_on_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_on_loan_typ_allnum_sum = 0 and als_id_m1_m3_on_loan_typ_allnum_sum = 0 then -1 when als_id_m1_m3_on_loan_typ_allnum_sum = 0 then als_id_d15_on_loan_typ_allnum_sum else als_id_d15_on_loan_typ_allnum_sum/als_id_m1_m3_on_loan_typ_allnum_sum end as als_id_d15_m1_m3_on_loan_typ_allnum_sum_rto
        ,case when als_id_d15_on_loan_typ_allnum_sum = 0 and als_id_m3_m6_on_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_on_loan_typ_allnum_sum = 0 then als_id_d15_on_loan_typ_allnum_sum else als_id_d15_on_loan_typ_allnum_sum/als_id_m3_m6_on_loan_typ_allnum_sum end as als_id_d15_m3_m6_on_loan_typ_allnum_sum_rto
        ,case when als_id_d15_on_loan_typ_allnum_sum = 0 and als_id_m6_m12_on_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_on_loan_typ_allnum_sum = 0 then als_id_d15_on_loan_typ_allnum_sum else als_id_d15_on_loan_typ_allnum_sum/als_id_m6_m12_on_loan_typ_allnum_sum end as als_id_d15_m6_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_m1_on_loan_typ_allnum_sum = 0 and als_id_m3_m6_on_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_on_loan_typ_allnum_sum = 0 then als_id_m1_on_loan_typ_allnum_sum else als_id_m1_on_loan_typ_allnum_sum/als_id_m3_m6_on_loan_typ_allnum_sum end as als_id_m1_m3_m6_on_loan_typ_allnum_sum_rto
        ,case when als_id_m1_on_loan_typ_allnum_sum = 0 and als_id_m6_m12_on_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_on_loan_typ_allnum_sum = 0 then als_id_m1_on_loan_typ_allnum_sum else als_id_m1_on_loan_typ_allnum_sum/als_id_m6_m12_on_loan_typ_allnum_sum end as als_id_m1_m6_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_m3_on_loan_typ_allnum_sum = 0 and als_id_m6_m12_on_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_on_loan_typ_allnum_sum = 0 then als_id_m3_on_loan_typ_allnum_sum else als_id_m3_on_loan_typ_allnum_sum/als_id_m6_m12_on_loan_typ_allnum_sum end as als_id_m3_m6_m12_on_loan_typ_allnum_sum_rto
        ,case when als_id_d15_off_loan_typ_orgnum_sum = 0 and als_id_m1_m3_off_loan_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_off_loan_typ_orgnum_sum = 0 then als_id_d15_off_loan_typ_orgnum_sum else als_id_d15_off_loan_typ_orgnum_sum/als_id_m1_m3_off_loan_typ_orgnum_sum end as als_id_d15_m1_m3_off_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_off_loan_typ_orgnum_sum = 0 and als_id_m3_m6_off_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_off_loan_typ_orgnum_sum = 0 then als_id_d15_off_loan_typ_orgnum_sum else als_id_d15_off_loan_typ_orgnum_sum/als_id_m3_m6_off_loan_typ_orgnum_sum end as als_id_d15_m3_m6_off_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_off_loan_typ_orgnum_sum = 0 and als_id_m6_m12_off_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_off_loan_typ_orgnum_sum = 0 then als_id_d15_off_loan_typ_orgnum_sum else als_id_d15_off_loan_typ_orgnum_sum/als_id_m6_m12_off_loan_typ_orgnum_sum end as als_id_d15_m6_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_off_loan_typ_orgnum_sum = 0 and als_id_m3_m6_off_loan_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_off_loan_typ_orgnum_sum = 0 then als_id_m1_off_loan_typ_orgnum_sum else als_id_m1_off_loan_typ_orgnum_sum/als_id_m3_m6_off_loan_typ_orgnum_sum end as als_id_m1_m3_m6_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m1_off_loan_typ_orgnum_sum = 0 and als_id_m6_m12_off_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_off_loan_typ_orgnum_sum = 0 then als_id_m1_off_loan_typ_orgnum_sum else als_id_m1_off_loan_typ_orgnum_sum/als_id_m6_m12_off_loan_typ_orgnum_sum end as als_id_m1_m6_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_m3_off_loan_typ_orgnum_sum = 0 and als_id_m6_m12_off_loan_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_off_loan_typ_orgnum_sum = 0 then als_id_m3_off_loan_typ_orgnum_sum else als_id_m3_off_loan_typ_orgnum_sum/als_id_m6_m12_off_loan_typ_orgnum_sum end as als_id_m3_m6_m12_off_loan_typ_orgnum_sum_rto
        ,case when als_id_d15_off_loan_typ_allnum_sum = 0 and als_id_m1_m3_off_loan_typ_allnum_sum = 0 then -1 when als_id_m1_m3_off_loan_typ_allnum_sum = 0 then als_id_d15_off_loan_typ_allnum_sum else als_id_d15_off_loan_typ_allnum_sum/als_id_m1_m3_off_loan_typ_allnum_sum end as als_id_d15_m1_m3_off_loan_typ_allnum_sum_rto
        ,case when als_id_d15_off_loan_typ_allnum_sum = 0 and als_id_m3_m6_off_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_off_loan_typ_allnum_sum = 0 then als_id_d15_off_loan_typ_allnum_sum else als_id_d15_off_loan_typ_allnum_sum/als_id_m3_m6_off_loan_typ_allnum_sum end as als_id_d15_m3_m6_off_loan_typ_allnum_sum_rto
        ,case when als_id_d15_off_loan_typ_allnum_sum = 0 and als_id_m6_m12_off_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_off_loan_typ_allnum_sum = 0 then als_id_d15_off_loan_typ_allnum_sum else als_id_d15_off_loan_typ_allnum_sum/als_id_m6_m12_off_loan_typ_allnum_sum end as als_id_d15_m6_m12_off_loan_typ_allnum_sum_rto
        ,case when als_id_m1_off_loan_typ_allnum_sum = 0 and als_id_m3_m6_off_loan_typ_allnum_sum = 0 then -1 when als_id_m3_m6_off_loan_typ_allnum_sum = 0 then als_id_m1_off_loan_typ_allnum_sum else als_id_m1_off_loan_typ_allnum_sum/als_id_m3_m6_off_loan_typ_allnum_sum end as als_id_m1_m3_m6_off_loan_typ_allnum_sum_rto
        ,case when als_id_m1_off_loan_typ_allnum_sum = 0 and als_id_m6_m12_off_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_off_loan_typ_allnum_sum = 0 then als_id_m1_off_loan_typ_allnum_sum else als_id_m1_off_loan_typ_allnum_sum/als_id_m6_m12_off_loan_typ_allnum_sum end as als_id_m1_m6_m12_off_loan_typ_allnum_sum_rto
        ,case when als_id_m3_off_loan_typ_allnum_sum = 0 and als_id_m6_m12_off_loan_typ_allnum_sum = 0 then -1 when als_id_m6_m12_off_loan_typ_allnum_sum = 0 then als_id_m3_off_loan_typ_allnum_sum else als_id_m3_off_loan_typ_allnum_sum/als_id_m6_m12_off_loan_typ_allnum_sum end as als_id_m3_m6_m12_off_loan_typ_allnum_sum_rto
        -- 分类机构类型趋势
        ,case when als_id_d15_lsd_org_typ_orgnum_sum = 0 and als_id_m1_m3_lsd_org_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_lsd_org_typ_orgnum_sum = 0 then als_id_d15_lsd_org_typ_orgnum_sum else als_id_d15_lsd_org_typ_orgnum_sum/als_id_m1_m3_lsd_org_typ_orgnum_sum end as als_id_d15_m1_m3_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_d15_lsd_org_typ_orgnum_sum = 0 and als_id_m3_m6_lsd_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_lsd_org_typ_orgnum_sum = 0 then als_id_d15_lsd_org_typ_orgnum_sum else als_id_d15_lsd_org_typ_orgnum_sum/als_id_m3_m6_lsd_org_typ_orgnum_sum end as als_id_d15_m3_m6_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_d15_lsd_org_typ_orgnum_sum = 0 and als_id_m6_m12_lsd_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_lsd_org_typ_orgnum_sum = 0 then als_id_d15_lsd_org_typ_orgnum_sum else als_id_d15_lsd_org_typ_orgnum_sum/als_id_m6_m12_lsd_org_typ_orgnum_sum end as als_id_d15_m6_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_orgnum_sum = 0 and als_id_m3_m6_lsd_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_lsd_org_typ_orgnum_sum = 0 then als_id_m1_lsd_org_typ_orgnum_sum else als_id_m1_lsd_org_typ_orgnum_sum/als_id_m3_m6_lsd_org_typ_orgnum_sum end as als_id_m1_m3_m6_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_orgnum_sum = 0 and als_id_m6_m12_lsd_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_lsd_org_typ_orgnum_sum = 0 then als_id_m1_lsd_org_typ_orgnum_sum else als_id_m1_lsd_org_typ_orgnum_sum/als_id_m6_m12_lsd_org_typ_orgnum_sum end as als_id_m1_m6_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_orgnum_sum = 0 and als_id_m6_m12_lsd_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_lsd_org_typ_orgnum_sum = 0 then als_id_m3_lsd_org_typ_orgnum_sum else als_id_m3_lsd_org_typ_orgnum_sum/als_id_m6_m12_lsd_org_typ_orgnum_sum end as als_id_m3_m6_m12_lsd_org_typ_orgnum_sum_rto
        ,case when als_id_d15_lsd_org_typ_allnum_sum = 0 and als_id_m1_m3_lsd_org_typ_allnum_sum = 0 then -1 when als_id_m1_m3_lsd_org_typ_allnum_sum = 0 then als_id_d15_lsd_org_typ_allnum_sum else als_id_d15_lsd_org_typ_allnum_sum/als_id_m1_m3_lsd_org_typ_allnum_sum end as als_id_d15_m1_m3_lsd_org_typ_allnum_sum_rto
        ,case when als_id_d15_lsd_org_typ_allnum_sum = 0 and als_id_m3_m6_lsd_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_lsd_org_typ_allnum_sum = 0 then als_id_d15_lsd_org_typ_allnum_sum else als_id_d15_lsd_org_typ_allnum_sum/als_id_m3_m6_lsd_org_typ_allnum_sum end as als_id_d15_m3_m6_lsd_org_typ_allnum_sum_rto
        ,case when als_id_d15_lsd_org_typ_allnum_sum = 0 and als_id_m6_m12_lsd_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_lsd_org_typ_allnum_sum = 0 then als_id_d15_lsd_org_typ_allnum_sum else als_id_d15_lsd_org_typ_allnum_sum/als_id_m6_m12_lsd_org_typ_allnum_sum end as als_id_d15_m6_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_allnum_sum = 0 and als_id_m3_m6_lsd_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_lsd_org_typ_allnum_sum = 0 then als_id_m1_lsd_org_typ_allnum_sum else als_id_m1_lsd_org_typ_allnum_sum/als_id_m3_m6_lsd_org_typ_allnum_sum end as als_id_m1_m3_m6_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m1_lsd_org_typ_allnum_sum = 0 and als_id_m6_m12_lsd_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_lsd_org_typ_allnum_sum = 0 then als_id_m1_lsd_org_typ_allnum_sum else als_id_m1_lsd_org_typ_allnum_sum/als_id_m6_m12_lsd_org_typ_allnum_sum end as als_id_m1_m6_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_m3_lsd_org_typ_allnum_sum = 0 and als_id_m6_m12_lsd_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_lsd_org_typ_allnum_sum = 0 then als_id_m3_lsd_org_typ_allnum_sum else als_id_m3_lsd_org_typ_allnum_sum/als_id_m6_m12_lsd_org_typ_allnum_sum end as als_id_m3_m6_m12_lsd_org_typ_allnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_orgnum_sum = 0 and als_id_m1_m3_sloan_org_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_sloan_org_typ_orgnum_sum = 0 then als_id_d15_sloan_org_typ_orgnum_sum else als_id_d15_sloan_org_typ_orgnum_sum/als_id_m1_m3_sloan_org_typ_orgnum_sum end as als_id_d15_m1_m3_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_orgnum_sum = 0 and als_id_m3_m6_sloan_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_sloan_org_typ_orgnum_sum = 0 then als_id_d15_sloan_org_typ_orgnum_sum else als_id_d15_sloan_org_typ_orgnum_sum/als_id_m3_m6_sloan_org_typ_orgnum_sum end as als_id_d15_m3_m6_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_orgnum_sum = 0 and als_id_m6_m12_sloan_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_sloan_org_typ_orgnum_sum = 0 then als_id_d15_sloan_org_typ_orgnum_sum else als_id_d15_sloan_org_typ_orgnum_sum/als_id_m6_m12_sloan_org_typ_orgnum_sum end as als_id_d15_m6_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_orgnum_sum = 0 and als_id_m3_m6_sloan_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_sloan_org_typ_orgnum_sum = 0 then als_id_m1_sloan_org_typ_orgnum_sum else als_id_m1_sloan_org_typ_orgnum_sum/als_id_m3_m6_sloan_org_typ_orgnum_sum end as als_id_m1_m3_m6_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_orgnum_sum = 0 and als_id_m6_m12_sloan_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_sloan_org_typ_orgnum_sum = 0 then als_id_m1_sloan_org_typ_orgnum_sum else als_id_m1_sloan_org_typ_orgnum_sum/als_id_m6_m12_sloan_org_typ_orgnum_sum end as als_id_m1_m6_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_orgnum_sum = 0 and als_id_m6_m12_sloan_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_sloan_org_typ_orgnum_sum = 0 then als_id_m3_sloan_org_typ_orgnum_sum else als_id_m3_sloan_org_typ_orgnum_sum/als_id_m6_m12_sloan_org_typ_orgnum_sum end as als_id_m3_m6_m12_sloan_org_typ_orgnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_allnum_sum = 0 and als_id_m1_m3_sloan_org_typ_allnum_sum = 0 then -1 when als_id_m1_m3_sloan_org_typ_allnum_sum = 0 then als_id_d15_sloan_org_typ_allnum_sum else als_id_d15_sloan_org_typ_allnum_sum/als_id_m1_m3_sloan_org_typ_allnum_sum end as als_id_d15_m1_m3_sloan_org_typ_allnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_allnum_sum = 0 and als_id_m3_m6_sloan_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_sloan_org_typ_allnum_sum = 0 then als_id_d15_sloan_org_typ_allnum_sum else als_id_d15_sloan_org_typ_allnum_sum/als_id_m3_m6_sloan_org_typ_allnum_sum end as als_id_d15_m3_m6_sloan_org_typ_allnum_sum_rto
        ,case when als_id_d15_sloan_org_typ_allnum_sum = 0 and als_id_m6_m12_sloan_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_sloan_org_typ_allnum_sum = 0 then als_id_d15_sloan_org_typ_allnum_sum else als_id_d15_sloan_org_typ_allnum_sum/als_id_m6_m12_sloan_org_typ_allnum_sum end as als_id_d15_m6_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_allnum_sum = 0 and als_id_m3_m6_sloan_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_sloan_org_typ_allnum_sum = 0 then als_id_m1_sloan_org_typ_allnum_sum else als_id_m1_sloan_org_typ_allnum_sum/als_id_m3_m6_sloan_org_typ_allnum_sum end as als_id_m1_m3_m6_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m1_sloan_org_typ_allnum_sum = 0 and als_id_m6_m12_sloan_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_sloan_org_typ_allnum_sum = 0 then als_id_m1_sloan_org_typ_allnum_sum else als_id_m1_sloan_org_typ_allnum_sum/als_id_m6_m12_sloan_org_typ_allnum_sum end as als_id_m1_m6_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_m3_sloan_org_typ_allnum_sum = 0 and als_id_m6_m12_sloan_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_sloan_org_typ_allnum_sum = 0 then als_id_m3_sloan_org_typ_allnum_sum else als_id_m3_sloan_org_typ_allnum_sum/als_id_m6_m12_sloan_org_typ_allnum_sum end as als_id_m3_m6_m12_sloan_org_typ_allnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_orgnum_sum = 0 and als_id_m1_m3_all_oth_org_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_all_oth_org_typ_orgnum_sum = 0 then als_id_d15_all_oth_org_typ_orgnum_sum else als_id_d15_all_oth_org_typ_orgnum_sum/als_id_m1_m3_all_oth_org_typ_orgnum_sum end as als_id_d15_m1_m3_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_orgnum_sum = 0 and als_id_m3_m6_all_oth_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_all_oth_org_typ_orgnum_sum = 0 then als_id_d15_all_oth_org_typ_orgnum_sum else als_id_d15_all_oth_org_typ_orgnum_sum/als_id_m3_m6_all_oth_org_typ_orgnum_sum end as als_id_d15_m3_m6_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_orgnum_sum = 0 and als_id_m6_m12_all_oth_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_all_oth_org_typ_orgnum_sum = 0 then als_id_d15_all_oth_org_typ_orgnum_sum else als_id_d15_all_oth_org_typ_orgnum_sum/als_id_m6_m12_all_oth_org_typ_orgnum_sum end as als_id_d15_m6_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_orgnum_sum = 0 and als_id_m3_m6_all_oth_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_all_oth_org_typ_orgnum_sum = 0 then als_id_m1_all_oth_org_typ_orgnum_sum else als_id_m1_all_oth_org_typ_orgnum_sum/als_id_m3_m6_all_oth_org_typ_orgnum_sum end as als_id_m1_m3_m6_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_orgnum_sum = 0 and als_id_m6_m12_all_oth_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_all_oth_org_typ_orgnum_sum = 0 then als_id_m1_all_oth_org_typ_orgnum_sum else als_id_m1_all_oth_org_typ_orgnum_sum/als_id_m6_m12_all_oth_org_typ_orgnum_sum end as als_id_m1_m6_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_orgnum_sum = 0 and als_id_m6_m12_all_oth_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_all_oth_org_typ_orgnum_sum = 0 then als_id_m3_all_oth_org_typ_orgnum_sum else als_id_m3_all_oth_org_typ_orgnum_sum/als_id_m6_m12_all_oth_org_typ_orgnum_sum end as als_id_m3_m6_m12_all_oth_org_typ_orgnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_allnum_sum = 0 and als_id_m1_m3_all_oth_org_typ_allnum_sum = 0 then -1 when als_id_m1_m3_all_oth_org_typ_allnum_sum = 0 then als_id_d15_all_oth_org_typ_allnum_sum else als_id_d15_all_oth_org_typ_allnum_sum/als_id_m1_m3_all_oth_org_typ_allnum_sum end as als_id_d15_m1_m3_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_allnum_sum = 0 and als_id_m3_m6_all_oth_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_all_oth_org_typ_allnum_sum = 0 then als_id_d15_all_oth_org_typ_allnum_sum else als_id_d15_all_oth_org_typ_allnum_sum/als_id_m3_m6_all_oth_org_typ_allnum_sum end as als_id_d15_m3_m6_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_d15_all_oth_org_typ_allnum_sum = 0 and als_id_m6_m12_all_oth_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_all_oth_org_typ_allnum_sum = 0 then als_id_d15_all_oth_org_typ_allnum_sum else als_id_d15_all_oth_org_typ_allnum_sum/als_id_m6_m12_all_oth_org_typ_allnum_sum end as als_id_d15_m6_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_allnum_sum = 0 and als_id_m3_m6_all_oth_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_all_oth_org_typ_allnum_sum = 0 then als_id_m1_all_oth_org_typ_allnum_sum else als_id_m1_all_oth_org_typ_allnum_sum/als_id_m3_m6_all_oth_org_typ_allnum_sum end as als_id_m1_m3_m6_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m1_all_oth_org_typ_allnum_sum = 0 and als_id_m6_m12_all_oth_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_all_oth_org_typ_allnum_sum = 0 then als_id_m1_all_oth_org_typ_allnum_sum else als_id_m1_all_oth_org_typ_allnum_sum/als_id_m6_m12_all_oth_org_typ_allnum_sum end as als_id_m1_m6_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_m3_all_oth_org_typ_allnum_sum = 0 and als_id_m6_m12_all_oth_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_all_oth_org_typ_allnum_sum = 0 then als_id_m3_all_oth_org_typ_allnum_sum else als_id_m3_all_oth_org_typ_allnum_sum/als_id_m6_m12_all_oth_org_typ_allnum_sum end as als_id_m3_m6_m12_all_oth_org_typ_allnum_sum_rto
        ,case when als_id_d15_stg_org_typ_orgnum_sum = 0 and als_id_m1_m3_stg_org_typ_orgnum_sum = 0 then -1 when als_id_m1_m3_stg_org_typ_orgnum_sum = 0 then als_id_d15_stg_org_typ_orgnum_sum else als_id_d15_stg_org_typ_orgnum_sum/als_id_m1_m3_stg_org_typ_orgnum_sum end as als_id_d15_m1_m3_stg_org_typ_orgnum_sum_rto
        ,case when als_id_d15_stg_org_typ_orgnum_sum = 0 and als_id_m3_m6_stg_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_stg_org_typ_orgnum_sum = 0 then als_id_d15_stg_org_typ_orgnum_sum else als_id_d15_stg_org_typ_orgnum_sum/als_id_m3_m6_stg_org_typ_orgnum_sum end as als_id_d15_m3_m6_stg_org_typ_orgnum_sum_rto
        ,case when als_id_d15_stg_org_typ_orgnum_sum = 0 and als_id_m6_m12_stg_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_stg_org_typ_orgnum_sum = 0 then als_id_d15_stg_org_typ_orgnum_sum else als_id_d15_stg_org_typ_orgnum_sum/als_id_m6_m12_stg_org_typ_orgnum_sum end as als_id_d15_m6_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m1_stg_org_typ_orgnum_sum = 0 and als_id_m3_m6_stg_org_typ_orgnum_sum = 0 then -1 when als_id_m3_m6_stg_org_typ_orgnum_sum = 0 then als_id_m1_stg_org_typ_orgnum_sum else als_id_m1_stg_org_typ_orgnum_sum/als_id_m3_m6_stg_org_typ_orgnum_sum end as als_id_m1_m3_m6_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m1_stg_org_typ_orgnum_sum = 0 and als_id_m6_m12_stg_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_stg_org_typ_orgnum_sum = 0 then als_id_m1_stg_org_typ_orgnum_sum else als_id_m1_stg_org_typ_orgnum_sum/als_id_m6_m12_stg_org_typ_orgnum_sum end as als_id_m1_m6_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_m3_stg_org_typ_orgnum_sum = 0 and als_id_m6_m12_stg_org_typ_orgnum_sum = 0 then -1 when als_id_m6_m12_stg_org_typ_orgnum_sum = 0 then als_id_m3_stg_org_typ_orgnum_sum else als_id_m3_stg_org_typ_orgnum_sum/als_id_m6_m12_stg_org_typ_orgnum_sum end as als_id_m3_m6_m12_stg_org_typ_orgnum_sum_rto
        ,case when als_id_d15_stg_org_typ_allnum_sum = 0 and als_id_m1_m3_stg_org_typ_allnum_sum = 0 then -1 when als_id_m1_m3_stg_org_typ_allnum_sum = 0 then als_id_d15_stg_org_typ_allnum_sum else als_id_d15_stg_org_typ_allnum_sum/als_id_m1_m3_stg_org_typ_allnum_sum end as als_id_d15_m1_m3_stg_org_typ_allnum_sum_rto
        ,case when als_id_d15_stg_org_typ_allnum_sum = 0 and als_id_m3_m6_stg_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_stg_org_typ_allnum_sum = 0 then als_id_d15_stg_org_typ_allnum_sum else als_id_d15_stg_org_typ_allnum_sum/als_id_m3_m6_stg_org_typ_allnum_sum end as als_id_d15_m3_m6_stg_org_typ_allnum_sum_rto
        ,case when als_id_d15_stg_org_typ_allnum_sum = 0 and als_id_m6_m12_stg_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_stg_org_typ_allnum_sum = 0 then als_id_d15_stg_org_typ_allnum_sum else als_id_d15_stg_org_typ_allnum_sum/als_id_m6_m12_stg_org_typ_allnum_sum end as als_id_d15_m6_m12_stg_org_typ_allnum_sum_rto
        ,case when als_id_m1_stg_org_typ_allnum_sum = 0 and als_id_m3_m6_stg_org_typ_allnum_sum = 0 then -1 when als_id_m3_m6_stg_org_typ_allnum_sum = 0 then als_id_m1_stg_org_typ_allnum_sum else als_id_m1_stg_org_typ_allnum_sum/als_id_m3_m6_stg_org_typ_allnum_sum end as als_id_m1_m3_m6_stg_org_typ_allnum_sum_rto
        ,case when als_id_m1_stg_org_typ_allnum_sum = 0 and als_id_m6_m12_stg_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_stg_org_typ_allnum_sum = 0 then als_id_m1_stg_org_typ_allnum_sum else als_id_m1_stg_org_typ_allnum_sum/als_id_m6_m12_stg_org_typ_allnum_sum end as als_id_m1_m6_m12_stg_org_typ_allnum_sum_rto
        ,case when als_id_m3_stg_org_typ_allnum_sum = 0 and als_id_m6_m12_stg_org_typ_allnum_sum = 0 then -1 when als_id_m6_m12_stg_org_typ_allnum_sum = 0 then als_id_m3_stg_org_typ_allnum_sum else als_id_m3_stg_org_typ_allnum_sum/als_id_m6_m12_stg_org_typ_allnum_sum end as als_id_m3_m6_m12_stg_org_typ_allnum_sum_rto        
from pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp2
;


-- 有申请记录月份数
set odps.stage.mapper.split.size=20;
drop table if exists pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp4;
create table pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp4 as
select *
        ,case when als_m6_id_avg_mons = 0 then -1 else als_m3_id_avg_mons/als_m6_id_avg_mons end as als_id_m3_m6_avg_mons_rto
        ,case when als_m12_id_avg_mons = 0 then -1 else als_m3_id_avg_mons/als_m12_id_avg_mons end as als_id_m3_m12_avg_mons_rto
        ,case when als_m12_id_avg_mons = 0 then -1 else als_m6_id_avg_mons/als_m12_id_avg_mons end as als_id_m6_m12_avg_mons_rto
        ,case when als_m6_id_bank_avg_mons = 0 then -1 else als_m3_id_bank_avg_mons/als_m6_id_bank_avg_mons end as als_id_m3_m6_bank_avg_mons_rto
        ,case when als_m12_id_bank_avg_mons = 0 then -1 else als_m3_id_bank_avg_mons/als_m12_id_bank_avg_mons end as als_id_m3_m12_bank_avg_mons_rto
        ,case when als_m12_id_bank_avg_mons = 0 then -1 else als_m6_id_bank_avg_mons/als_m12_id_bank_avg_mons end as als_id_m6_m12_bank_avg_mons_rto
        ,case when als_m6_id_nbank_avg_mons = 0 then -1 else als_m3_id_nbank_avg_mons/als_m6_id_nbank_avg_mons end as als_id_m3_m6_nbank_avg_mons_rto
        ,case when als_m12_id_nbank_avg_mons = 0 then -1 else als_m3_id_nbank_avg_mons/als_m12_id_nbank_avg_mons end as als_id_m3_m12_nbank_avg_mons_rto
        ,case when als_m12_id_nbank_avg_mons = 0 then -1 else als_m6_id_nbank_avg_mons/als_m12_id_nbank_avg_mons end as als_id_m6_m12_nbank_avg_mons_rto
        
        ,case when als_id_m3_m6_avg_mons = 0 then -1 else als_m3_id_avg_mons/als_id_m3_m6_avg_mons end as als_id_m3_m3_m6_avg_mons_rto
        ,case when als_id_m6_m12_avg_mons = 0 then -1 else als_m3_id_avg_mons/als_id_m6_m12_avg_mons end as als_id_m3_m6_m12_avg_mons_rto
        ,case when als_id_m3_m6_bank_avg_mons = 0 then -1 else als_m3_id_bank_avg_mons/als_id_m3_m6_bank_avg_mons end as als_id_m3_m3_m6_bank_avg_mons_rto
        ,case when als_id_m6_m12_bank_avg_mons = 0 then -1 else als_m3_id_bank_avg_mons/als_id_m6_m12_bank_avg_mons end as als_id_m3_m6_m12_bank_avg_mons_rto
        ,case when als_id_m6_m12_bank_avg_mons = 0 then -1 else als_m6_id_bank_avg_mons/als_id_m6_m12_bank_avg_mons end as als_id_m6_m6_m12_bank_avg_mons_rto
        ,case when als_id_m3_m6_nbank_avg_mons = 0 then -1 else als_m3_id_nbank_avg_mons/als_id_m3_m6_nbank_avg_mons end as als_id_m3_m3_m6_nbank_avg_mons_rto
        ,case when als_id_m6_m12_nbank_avg_mons = 0 then -1 else als_m3_id_nbank_avg_mons/als_id_m6_m12_nbank_avg_mons end as als_id_m3_m6_m12_nbank_avg_mons_rto
        ,case when als_id_m6_m12_nbank_avg_mons = 0 then -1 else als_m6_id_nbank_avg_mons/als_id_m6_m12_nbank_avg_mons end as als_id_m6_m6_m12_nbank_avg_mons_rto

        ,case when als_m3_id_nbank_tot_mons_rto = als_m6_id_nbank_tot_mons_rto then 0
              when als_m3_id_nbank_tot_mons_rto > als_m6_id_nbank_tot_mons_rto then 1
              else -1 end as als_m3_m6_id_nbank_tot_mons_rto_trend
        ,case when als_m6_id_nbank_tot_mons_rto = als_m12_id_nbank_tot_mons_rto then 0
              when als_m6_id_nbank_tot_mons_rto > als_m12_id_nbank_tot_mons_rto then 1
              else -1 end as als_m6_m12_id_nbank_tot_mons_rto_trend
        ,case when als_m3_id_bank_tot_mons_rto = als_m6_id_bank_tot_mons_rto then 0
              when als_m3_id_bank_tot_mons_rto > als_m6_id_bank_tot_mons_rto then 1
              else -1 end as als_m3_m6_id_bank_tot_mons_rto_trend
        ,case when als_m6_id_bank_tot_mons_rto = als_m12_id_bank_tot_mons_rto then 0
              when als_m6_id_bank_tot_mons_rto > als_m12_id_bank_tot_mons_rto then 1
              else -1 end as als_m6_m12_id_bank_tot_mons_rto_trend


from 
(
        select uid
                ,swift_number
                -- ,als_m3_id_tot_mons
                -- ,als_m6_id_tot_mons
                -- ,als_m12_id_tot_mons
                -- ,als_m3_id_nbank_tot_mons
                -- ,als_m6_id_nbank_tot_mons
                -- ,als_m12_id_nbank_tot_mons
                -- ,als_m3_id_bank_tot_mons
                -- ,als_m6_id_bank_tot_mons
                -- ,als_m12_id_bank_tot_mons
                -- ,als_m6_id_tot_mons-als_m3_id_tot_mons as als_id_m3_m6_tot_mons
                -- ,als_m12_id_tot_mons-als_m6_id_tot_mons as als_id_m6_m12_tot_mons
                -- ,als_m6_id_bank_tot_mons-als_m3_id_bank_tot_mons as als_id_m3_m6_bank_tot_mons
                -- ,als_m12_id_bank_tot_mons-als_m6_id_bank_tot_mons as als_id_m6_m12_bank_tot_mons
                -- ,als_m6_id_nbank_tot_mons-als_m3_id_nbank_tot_mons as als_id_m3_m6_nbank_tot_mons
                -- ,als_m12_id_nbank_tot_mons-als_m6_id_nbank_tot_mons as als_id_m6_m12_nbank_tot_mons
                ,als_m3_id_tot_mons/3 as als_m3_id_avg_mons
                ,als_m6_id_tot_mons/6 as als_m6_id_avg_mons
                ,als_m12_id_tot_mons/12 as als_m12_id_avg_mons
                ,als_m3_id_bank_tot_mons/3 as als_m3_id_bank_avg_mons
                ,als_m6_id_bank_tot_mons/6 as als_m6_id_bank_avg_mons
                ,als_m12_id_bank_tot_mons/12 as als_m12_id_bank_avg_mons
                ,als_m3_id_nbank_tot_mons/3 as als_m3_id_nbank_avg_mons
                ,als_m6_id_nbank_tot_mons/6 as als_m6_id_nbank_avg_mons
                ,als_m12_id_nbank_tot_mons/12 as als_m12_id_nbank_avg_mons
                ,(als_m6_id_tot_mons-als_m3_id_tot_mons)/3 as als_id_m3_m6_avg_mons
                ,(als_m12_id_tot_mons-als_m6_id_tot_mons)/6 as als_id_m6_m12_avg_mons
                ,(als_m6_id_bank_tot_mons-als_m3_id_bank_tot_mons)/3 as als_id_m3_m6_bank_avg_mons
                ,(als_m12_id_bank_tot_mons-als_m6_id_bank_tot_mons)/6 as als_id_m6_m12_bank_avg_mons
                ,(als_m6_id_nbank_tot_mons-als_m3_id_nbank_tot_mons)/3 as als_id_m3_m6_nbank_avg_mons
                ,(als_m12_id_nbank_tot_mons-als_m6_id_nbank_tot_mons)/6 as als_id_m6_m12_nbank_avg_mons

                ,case when als_m3_id_tot_mons = 0 then -1 else als_m3_id_bank_tot_mons/als_m3_id_tot_mons end as als_m3_id_bank_tot_mons_rto
                ,case when als_m3_id_tot_mons = 0 then -1 else als_m3_id_nbank_tot_mons/als_m3_id_tot_mons end as als_m3_id_nbank_tot_mons_rto
                ,case when als_m6_id_tot_mons = 0 then -1 else als_m6_id_bank_tot_mons/als_m6_id_tot_mons end as als_m6_id_bank_tot_mons_rto
                ,case when als_m6_id_tot_mons = 0 then -1 else als_m6_id_nbank_tot_mons/als_m6_id_tot_mons end as als_m6_id_nbank_tot_mons_rto
                ,case when als_m12_id_tot_mons = 0 then -1 else als_m12_id_bank_tot_mons/als_m12_id_tot_mons end as als_m12_id_bank_tot_mons_rto
                ,case when als_m12_id_tot_mons = 0 then -1 else als_m12_id_nbank_tot_mons/als_m12_id_tot_mons end as als_m12_id_nbank_tot_mons_rto                
        from dbus.dbus_dz_daily_br_trend_feature_v3_base_di
        where ds = '${bizdate}'
) as a
;


-- 横向趋势
set odps.stage.mapper.split.size=20;
insert overwrite table ${pdm_risk}.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di partition (ds)
select model_data.uid,

        als_id_d7_d15_loan_typ_orgnum_sum_rto,
        als_id_d7_m1_loan_typ_orgnum_sum_rto,
        als_id_d7_m3_loan_typ_orgnum_sum_rto ,
        als_id_d7_m6_loan_typ_orgnum_sum_rto,
        als_id_d7_m12_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_loan_typ_orgnum_sum_rto ,
        als_id_d15_m12_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_loan_typ_orgnum_sum_rto,
        als_id_m1_m12_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_loan_typ_orgnum_sum_rto ,
        als_id_m3_m12_loan_typ_orgnum_sum_rto,
        als_id_m6_m12_loan_typ_orgnum_sum_rto,
        als_id_d7_d15_loan_typ_allnum_sum_rto,
        als_id_d7_m1_loan_typ_allnum_sum_rto,
        als_id_d7_m3_loan_typ_allnum_sum_rto ,
        als_id_d7_m6_loan_typ_allnum_sum_rto,
        als_id_d7_m12_loan_typ_allnum_sum_rto,
        als_id_d15_m1_loan_typ_allnum_sum_rto,
        als_id_d15_m3_loan_typ_allnum_sum_rto,
        als_id_d15_m6_loan_typ_allnum_sum_rto ,
        als_id_d15_m12_loan_typ_allnum_sum_rto,
        als_id_m1_m3_loan_typ_allnum_sum_rto,
        als_id_m1_m6_loan_typ_allnum_sum_rto,
        als_id_m1_m12_loan_typ_allnum_sum_rto,
        als_id_m3_m6_loan_typ_allnum_sum_rto ,
        als_id_m3_m12_loan_typ_allnum_sum_rto,
        als_id_m6_m12_loan_typ_allnum_sum_rto,
        als_id_d7_d15_org_typ_orgnum_sum_rto,
        als_id_d7_m1_org_typ_orgnum_sum_rto,
        als_id_d7_m3_org_typ_orgnum_sum_rto ,
        als_id_d7_m6_org_typ_orgnum_sum_rto,
        als_id_d7_m12_org_typ_orgnum_sum_rto,
        als_id_d15_m1_org_typ_orgnum_sum_rto,
        als_id_d15_m3_org_typ_orgnum_sum_rto,
        als_id_d15_m6_org_typ_orgnum_sum_rto ,
        als_id_d15_m12_org_typ_orgnum_sum_rto,
        als_id_m1_m3_org_typ_orgnum_sum_rto,
        als_id_m1_m6_org_typ_orgnum_sum_rto,
        als_id_m1_m12_org_typ_orgnum_sum_rto,
        als_id_m3_m6_org_typ_orgnum_sum_rto ,
        als_id_m3_m12_org_typ_orgnum_sum_rto,
        als_id_m6_m12_org_typ_orgnum_sum_rto,
        als_id_d7_d15_org_typ_allnum_sum_rto,
        als_id_d7_m1_org_typ_allnum_sum_rto,
        als_id_d7_m3_org_typ_allnum_sum_rto ,
        als_id_d7_m6_org_typ_allnum_sum_rto,
        als_id_d7_m12_org_typ_allnum_sum_rto,
        als_id_d15_m1_org_typ_allnum_sum_rto,
        als_id_d15_m3_org_typ_allnum_sum_rto,
        als_id_d15_m6_org_typ_allnum_sum_rto ,
        als_id_d15_m12_org_typ_allnum_sum_rto,
        als_id_m1_m3_org_typ_allnum_sum_rto,
        als_id_m1_m6_org_typ_allnum_sum_rto,
        als_id_m1_m12_org_typ_allnum_sum_rto,
        als_id_m3_m6_org_typ_allnum_sum_rto ,
        als_id_m3_m12_org_typ_allnum_sum_rto,
        als_id_m6_m12_org_typ_allnum_sum_rto,
        als_id_d7_d15_org_typ_week_orgnum_sum_rto,
        als_id_d7_m1_org_typ_week_orgnum_sum_rto,
        als_id_d7_m3_org_typ_week_orgnum_sum_rto ,
        als_id_d7_m6_org_typ_week_orgnum_sum_rto,
        als_id_d7_m12_org_typ_week_orgnum_sum_rto,
        als_id_d15_m1_org_typ_week_orgnum_sum_rto,
        als_id_d15_m3_org_typ_week_orgnum_sum_rto,
        als_id_d15_m6_org_typ_week_orgnum_sum_rto ,
        als_id_d15_m12_org_typ_week_orgnum_sum_rto,
        als_id_m1_m3_org_typ_week_orgnum_sum_rto,
        als_id_m1_m6_org_typ_week_orgnum_sum_rto,
        als_id_m1_m12_org_typ_week_orgnum_sum_rto,
        als_id_m3_m6_org_typ_week_orgnum_sum_rto ,
        als_id_m3_m12_org_typ_week_orgnum_sum_rto,
        als_id_m6_m12_org_typ_week_orgnum_sum_rto,
        als_id_d7_d15_org_typ_week_allnum_sum_rto,
        als_id_d7_m1_org_typ_week_allnum_sum_rto,
        als_id_d7_m3_org_typ_week_allnum_sum_rto ,
        als_id_d7_m6_org_typ_week_allnum_sum_rto,
        als_id_d7_m12_org_typ_week_allnum_sum_rto,
        als_id_d15_m1_org_typ_week_allnum_sum_rto,
        als_id_d15_m3_org_typ_week_allnum_sum_rto,
        als_id_d15_m6_org_typ_week_allnum_sum_rto ,
        als_id_d15_m12_org_typ_week_allnum_sum_rto,
        als_id_m1_m3_org_typ_week_allnum_sum_rto,
        als_id_m1_m6_org_typ_week_allnum_sum_rto,
        als_id_m1_m12_org_typ_week_allnum_sum_rto,
        als_id_m3_m6_org_typ_week_allnum_sum_rto ,
        als_id_m3_m12_org_typ_week_allnum_sum_rto,
        als_id_m6_m12_org_typ_week_allnum_sum_rto,
        als_id_d7_d15_org_typ_night_orgnum_sum_rto,
        als_id_d7_m1_org_typ_night_orgnum_sum_rto,
        als_id_d7_m3_org_typ_night_orgnum_sum_rto ,
        als_id_d7_m6_org_typ_night_orgnum_sum_rto,
        als_id_d7_m12_org_typ_night_orgnum_sum_rto,
        als_id_d15_m1_org_typ_night_orgnum_sum_rto,
        als_id_d15_m3_org_typ_night_orgnum_sum_rto,
        als_id_d15_m6_org_typ_night_orgnum_sum_rto ,
        als_id_d15_m12_org_typ_night_orgnum_sum_rto,
        als_id_m1_m3_org_typ_night_orgnum_sum_rto,
        als_id_m1_m6_org_typ_night_orgnum_sum_rto,
        als_id_m1_m12_org_typ_night_orgnum_sum_rto,
        als_id_m3_m6_org_typ_night_orgnum_sum_rto ,
        als_id_m3_m12_org_typ_night_orgnum_sum_rto,
        als_id_m6_m12_org_typ_night_orgnum_sum_rto,
        als_id_d7_d15_org_typ_night_allnum_sum_rto,
        als_id_d7_m1_org_typ_night_allnum_sum_rto,
        als_id_d7_m3_org_typ_night_allnum_sum_rto ,
        als_id_d7_m6_org_typ_night_allnum_sum_rto,
        als_id_d7_m12_org_typ_night_allnum_sum_rto,
        als_id_d15_m1_org_typ_night_allnum_sum_rto,
        als_id_d15_m3_org_typ_night_allnum_sum_rto,
        als_id_d15_m6_org_typ_night_allnum_sum_rto ,
        als_id_d15_m12_org_typ_night_allnum_sum_rto,
        als_id_m1_m3_org_typ_night_allnum_sum_rto,
        als_id_m1_m6_org_typ_night_allnum_sum_rto,
        als_id_m1_m12_org_typ_night_allnum_sum_rto,
        als_id_m3_m6_org_typ_night_allnum_sum_rto ,
        als_id_m3_m12_org_typ_night_allnum_sum_rto,
        als_id_m6_m12_org_typ_night_allnum_sum_rto,
        als_id_d7_d15_ca_loan_typ_orgnum_sum_rto,
        als_id_d7_m1_ca_loan_typ_orgnum_sum_rto,
        als_id_d7_m3_ca_loan_typ_orgnum_sum_rto ,
        als_id_d7_m6_ca_loan_typ_orgnum_sum_rto,
        als_id_d7_m12_ca_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_ca_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_ca_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_ca_loan_typ_orgnum_sum_rto ,
        als_id_d15_m12_ca_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_ca_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_ca_loan_typ_orgnum_sum_rto,
        als_id_m1_m12_ca_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_ca_loan_typ_orgnum_sum_rto ,
        als_id_m3_m12_ca_loan_typ_orgnum_sum_rto,
        als_id_m6_m12_ca_loan_typ_orgnum_sum_rto,
        als_id_d7_d15_ca_loan_typ_allnum_sum_rto,
        als_id_d7_m1_ca_loan_typ_allnum_sum_rto,
        als_id_d7_m3_ca_loan_typ_allnum_sum_rto ,
        als_id_d7_m6_ca_loan_typ_allnum_sum_rto,
        als_id_d7_m12_ca_loan_typ_allnum_sum_rto,
        als_id_d15_m1_ca_loan_typ_allnum_sum_rto,
        als_id_d15_m3_ca_loan_typ_allnum_sum_rto,
        als_id_d15_m6_ca_loan_typ_allnum_sum_rto ,
        als_id_d15_m12_ca_loan_typ_allnum_sum_rto,
        als_id_m1_m3_ca_loan_typ_allnum_sum_rto,
        als_id_m1_m6_ca_loan_typ_allnum_sum_rto,
        als_id_m1_m12_ca_loan_typ_allnum_sum_rto,
        als_id_m3_m6_ca_loan_typ_allnum_sum_rto ,
        als_id_m3_m12_ca_loan_typ_allnum_sum_rto,
        als_id_m6_m12_ca_loan_typ_allnum_sum_rto,
        als_id_d7_d15_co_loan_typ_orgnum_sum_rto,
        als_id_d7_m1_co_loan_typ_orgnum_sum_rto,
        als_id_d7_m3_co_loan_typ_orgnum_sum_rto ,
        als_id_d7_m6_co_loan_typ_orgnum_sum_rto,
        als_id_d7_m12_co_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_co_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_co_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_co_loan_typ_orgnum_sum_rto ,
        als_id_d15_m12_co_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_co_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_co_loan_typ_orgnum_sum_rto,
        als_id_m1_m12_co_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_co_loan_typ_orgnum_sum_rto ,
        als_id_m3_m12_co_loan_typ_orgnum_sum_rto,
        als_id_m6_m12_co_loan_typ_orgnum_sum_rto,
        als_id_d7_d15_co_loan_typ_allnum_sum_rto,
        als_id_d7_m1_co_loan_typ_allnum_sum_rto,
        als_id_d7_m3_co_loan_typ_allnum_sum_rto ,
        als_id_d7_m6_co_loan_typ_allnum_sum_rto,
        als_id_d7_m12_co_loan_typ_allnum_sum_rto,
        als_id_d15_m1_co_loan_typ_allnum_sum_rto,
        als_id_d15_m3_co_loan_typ_allnum_sum_rto,
        als_id_d15_m6_co_loan_typ_allnum_sum_rto ,
        als_id_d15_m12_co_loan_typ_allnum_sum_rto,
        als_id_m1_m3_co_loan_typ_allnum_sum_rto,
        als_id_m1_m6_co_loan_typ_allnum_sum_rto,
        als_id_m1_m12_co_loan_typ_allnum_sum_rto,
        als_id_m3_m6_co_loan_typ_allnum_sum_rto ,
        als_id_m3_m12_co_loan_typ_allnum_sum_rto,
        als_id_m6_m12_co_loan_typ_allnum_sum_rto,
        als_id_d7_d15_on_loan_typ_orgnum_sum_rto,
        als_id_d7_m1_on_loan_typ_orgnum_sum_rto,
        als_id_d7_m3_on_loan_typ_orgnum_sum_rto ,
        als_id_d7_m6_on_loan_typ_orgnum_sum_rto,
        als_id_d7_m12_on_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_on_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_on_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_on_loan_typ_orgnum_sum_rto ,
        als_id_d15_m12_on_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_on_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_on_loan_typ_orgnum_sum_rto,
        als_id_m1_m12_on_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_on_loan_typ_orgnum_sum_rto ,
        als_id_m3_m12_on_loan_typ_orgnum_sum_rto,
        als_id_m6_m12_on_loan_typ_orgnum_sum_rto,
        als_id_d7_d15_on_loan_typ_allnum_sum_rto,
        als_id_d7_m1_on_loan_typ_allnum_sum_rto,
        als_id_d7_m3_on_loan_typ_allnum_sum_rto ,
        als_id_d7_m6_on_loan_typ_allnum_sum_rto,
        als_id_d7_m12_on_loan_typ_allnum_sum_rto,
        als_id_d15_m1_on_loan_typ_allnum_sum_rto,
        als_id_d15_m3_on_loan_typ_allnum_sum_rto,
        als_id_d15_m6_on_loan_typ_allnum_sum_rto ,
        als_id_d15_m12_on_loan_typ_allnum_sum_rto,
        als_id_m1_m3_on_loan_typ_allnum_sum_rto,
        als_id_m1_m6_on_loan_typ_allnum_sum_rto,
        als_id_m1_m12_on_loan_typ_allnum_sum_rto,
        als_id_m3_m6_on_loan_typ_allnum_sum_rto ,
        als_id_m3_m12_on_loan_typ_allnum_sum_rto,
        als_id_m6_m12_on_loan_typ_allnum_sum_rto,
        als_id_d7_d15_off_loan_typ_orgnum_sum_rto,
        als_id_d7_m1_off_loan_typ_orgnum_sum_rto,
        als_id_d7_m3_off_loan_typ_orgnum_sum_rto ,
        als_id_d7_m6_off_loan_typ_orgnum_sum_rto,
        als_id_d7_m12_off_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_off_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_off_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_off_loan_typ_orgnum_sum_rto ,
        als_id_d15_m12_off_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_off_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_off_loan_typ_orgnum_sum_rto,
        als_id_m1_m12_off_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_off_loan_typ_orgnum_sum_rto ,
        als_id_m3_m12_off_loan_typ_orgnum_sum_rto,
        als_id_m6_m12_off_loan_typ_orgnum_sum_rto,
        als_id_d7_d15_off_loan_typ_allnum_sum_rto,
        als_id_d7_m1_off_loan_typ_allnum_sum_rto,
        als_id_d7_m3_off_loan_typ_allnum_sum_rto ,
        als_id_d7_m6_off_loan_typ_allnum_sum_rto,
        als_id_d7_m12_off_loan_typ_allnum_sum_rto,
        als_id_d15_m1_off_loan_typ_allnum_sum_rto,
        als_id_d15_m3_off_loan_typ_allnum_sum_rto,
        als_id_d15_m6_off_loan_typ_allnum_sum_rto ,
        als_id_d15_m12_off_loan_typ_allnum_sum_rto,
        als_id_m1_m3_off_loan_typ_allnum_sum_rto,
        als_id_m1_m6_off_loan_typ_allnum_sum_rto,
        als_id_m1_m12_off_loan_typ_allnum_sum_rto,
        als_id_m3_m6_off_loan_typ_allnum_sum_rto ,
        als_id_m3_m12_off_loan_typ_allnum_sum_rto,
        als_id_m6_m12_off_loan_typ_allnum_sum_rto,
        als_id_d7_d15_lsd_org_typ_orgnum_sum_rto,
        als_id_d7_m1_lsd_org_typ_orgnum_sum_rto,
        als_id_d7_m3_lsd_org_typ_orgnum_sum_rto ,
        als_id_d7_m6_lsd_org_typ_orgnum_sum_rto,
        als_id_d7_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_d15_m1_lsd_org_typ_orgnum_sum_rto,
        als_id_d15_m3_lsd_org_typ_orgnum_sum_rto,
        als_id_d15_m6_lsd_org_typ_orgnum_sum_rto ,
        als_id_d15_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_m1_m3_lsd_org_typ_orgnum_sum_rto,
        als_id_m1_m6_lsd_org_typ_orgnum_sum_rto,
        als_id_m1_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_m3_m6_lsd_org_typ_orgnum_sum_rto ,
        als_id_m3_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_m6_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_d7_d15_lsd_org_typ_allnum_sum_rto,
        als_id_d7_m1_lsd_org_typ_allnum_sum_rto,
        als_id_d7_m3_lsd_org_typ_allnum_sum_rto ,
        als_id_d7_m6_lsd_org_typ_allnum_sum_rto,
        als_id_d7_m12_lsd_org_typ_allnum_sum_rto,
        als_id_d15_m1_lsd_org_typ_allnum_sum_rto,
        als_id_d15_m3_lsd_org_typ_allnum_sum_rto,
        als_id_d15_m6_lsd_org_typ_allnum_sum_rto ,
        als_id_d15_m12_lsd_org_typ_allnum_sum_rto,
        als_id_m1_m3_lsd_org_typ_allnum_sum_rto,
        als_id_m1_m6_lsd_org_typ_allnum_sum_rto,
        als_id_m1_m12_lsd_org_typ_allnum_sum_rto,
        als_id_m3_m6_lsd_org_typ_allnum_sum_rto ,
        als_id_m3_m12_lsd_org_typ_allnum_sum_rto,
        als_id_m6_m12_lsd_org_typ_allnum_sum_rto,
        als_id_d7_d15_sloan_org_typ_orgnum_sum_rto,
        als_id_d7_m1_sloan_org_typ_orgnum_sum_rto,
        als_id_d7_m3_sloan_org_typ_orgnum_sum_rto ,
        als_id_d7_m6_sloan_org_typ_orgnum_sum_rto,
        als_id_d7_m12_sloan_org_typ_orgnum_sum_rto,
        als_id_d15_m1_sloan_org_typ_orgnum_sum_rto,
        als_id_d15_m3_sloan_org_typ_orgnum_sum_rto,
        als_id_d15_m6_sloan_org_typ_orgnum_sum_rto ,
        als_id_d15_m12_sloan_org_typ_orgnum_sum_rto,
        als_id_m1_m3_sloan_org_typ_orgnum_sum_rto,
        als_id_m1_m6_sloan_org_typ_orgnum_sum_rto,
        als_id_m1_m12_sloan_org_typ_orgnum_sum_rto,
        als_id_m3_m6_sloan_org_typ_orgnum_sum_rto ,
        als_id_m3_m12_sloan_org_typ_orgnum_sum_rto,
        als_id_m6_m12_sloan_org_typ_orgnum_sum_rto,
        als_id_d7_d15_sloan_org_typ_allnum_sum_rto,
        als_id_d7_m1_sloan_org_typ_allnum_sum_rto,
        als_id_d7_m3_sloan_org_typ_allnum_sum_rto ,
        als_id_d7_m6_sloan_org_typ_allnum_sum_rto,
        als_id_d7_m12_sloan_org_typ_allnum_sum_rto,
        als_id_d15_m1_sloan_org_typ_allnum_sum_rto,
        als_id_d15_m3_sloan_org_typ_allnum_sum_rto,
        als_id_d15_m6_sloan_org_typ_allnum_sum_rto ,
        als_id_d15_m12_sloan_org_typ_allnum_sum_rto,
        als_id_m1_m3_sloan_org_typ_allnum_sum_rto,
        als_id_m1_m6_sloan_org_typ_allnum_sum_rto,
        als_id_m1_m12_sloan_org_typ_allnum_sum_rto,
        als_id_m3_m6_sloan_org_typ_allnum_sum_rto ,
        als_id_m3_m12_sloan_org_typ_allnum_sum_rto,
        als_id_m6_m12_sloan_org_typ_allnum_sum_rto,
        als_id_d7_d15_all_oth_org_typ_orgnum_sum_rto,
        als_id_d7_m1_all_oth_org_typ_orgnum_sum_rto,
        als_id_d7_m3_all_oth_org_typ_orgnum_sum_rto ,
        als_id_d7_m6_all_oth_org_typ_orgnum_sum_rto,
        als_id_d7_m12_all_oth_org_typ_orgnum_sum_rto,
        als_id_d15_m1_all_oth_org_typ_orgnum_sum_rto,
        als_id_d15_m3_all_oth_org_typ_orgnum_sum_rto,
        als_id_d15_m6_all_oth_org_typ_orgnum_sum_rto ,
        als_id_d15_m12_all_oth_org_typ_orgnum_sum_rto,
        als_id_m1_m3_all_oth_org_typ_orgnum_sum_rto,
        als_id_m1_m6_all_oth_org_typ_orgnum_sum_rto,
        als_id_m1_m12_all_oth_org_typ_orgnum_sum_rto,
        als_id_m3_m6_all_oth_org_typ_orgnum_sum_rto ,
        als_id_m3_m12_all_oth_org_typ_orgnum_sum_rto,
        als_id_m6_m12_all_oth_org_typ_orgnum_sum_rto,
        als_id_d7_d15_all_oth_org_typ_allnum_sum_rto,
        als_id_d7_m1_all_oth_org_typ_allnum_sum_rto,
        als_id_d7_m3_all_oth_org_typ_allnum_sum_rto ,
        als_id_d7_m6_all_oth_org_typ_allnum_sum_rto,
        als_id_d7_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_d15_m1_all_oth_org_typ_allnum_sum_rto,
        als_id_d15_m3_all_oth_org_typ_allnum_sum_rto,
        als_id_d15_m6_all_oth_org_typ_allnum_sum_rto ,
        als_id_d15_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_m1_m3_all_oth_org_typ_allnum_sum_rto,
        als_id_m1_m6_all_oth_org_typ_allnum_sum_rto,
        als_id_m1_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_m3_m6_all_oth_org_typ_allnum_sum_rto ,
        als_id_m3_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_m6_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_d7_d15_stg_org_typ_orgnum_sum_rto,
        als_id_d7_m1_stg_org_typ_orgnum_sum_rto,
        als_id_d7_m3_stg_org_typ_orgnum_sum_rto ,
        als_id_d7_m6_stg_org_typ_orgnum_sum_rto,
        als_id_d7_m12_stg_org_typ_orgnum_sum_rto,
        als_id_d15_m1_stg_org_typ_orgnum_sum_rto,
        als_id_d15_m3_stg_org_typ_orgnum_sum_rto,
        als_id_d15_m6_stg_org_typ_orgnum_sum_rto ,
        als_id_d15_m12_stg_org_typ_orgnum_sum_rto,
        als_id_m1_m3_stg_org_typ_orgnum_sum_rto,
        als_id_m1_m6_stg_org_typ_orgnum_sum_rto,
        als_id_m1_m12_stg_org_typ_orgnum_sum_rto,
        als_id_m3_m6_stg_org_typ_orgnum_sum_rto ,
        als_id_m3_m12_stg_org_typ_orgnum_sum_rto,
        als_id_m6_m12_stg_org_typ_orgnum_sum_rto,
        als_id_d7_d15_stg_org_typ_allnum_sum_rto,
        als_id_d7_m1_stg_org_typ_allnum_sum_rto,
        als_id_d7_m3_stg_org_typ_allnum_sum_rto ,
        als_id_d7_m6_stg_org_typ_allnum_sum_rto,
        als_id_d7_m12_stg_org_typ_allnum_sum_rto,
        als_id_d15_m1_stg_org_typ_allnum_sum_rto,
        als_id_d15_m3_stg_org_typ_allnum_sum_rto,
        als_id_d15_m6_stg_org_typ_allnum_sum_rto ,
        als_id_d15_m12_stg_org_typ_allnum_sum_rto,
        als_id_m1_m3_stg_org_typ_allnum_sum_rto,
        als_id_m1_m6_stg_org_typ_allnum_sum_rto,
        als_id_m1_m12_stg_org_typ_allnum_sum_rto,
        als_id_m3_m6_stg_org_typ_allnum_sum_rto ,
        als_id_m3_m12_stg_org_typ_allnum_sum_rto,
        als_id_m6_m12_stg_org_typ_allnum_sum_rto,

        als_id_d7_loan_typ_orgnum_sum,
        als_id_d15_loan_typ_orgnum_sum,
        als_id_m1_loan_typ_orgnum_sum,
        als_id_m3_loan_typ_orgnum_sum ,
        als_id_m6_loan_typ_orgnum_sum,
        als_id_m12_loan_typ_orgnum_sum,
        als_id_d7_loan_typ_allnum_sum,
        als_id_d15_loan_typ_allnum_sum,
        als_id_m1_loan_typ_allnum_sum ,
        als_id_m3_loan_typ_allnum_sum,
        als_id_m6_loan_typ_allnum_sum,
        als_id_m12_loan_typ_allnum_sum,
        als_id_d7_org_typ_orgnum_sum,
        als_id_d15_org_typ_orgnum_sum ,
        als_id_m1_org_typ_orgnum_sum,
        als_id_m3_org_typ_orgnum_sum,
        als_id_m6_org_typ_orgnum_sum,
        als_id_m12_org_typ_orgnum_sum,
        als_id_d7_org_typ_allnum_sum ,
        als_id_d15_org_typ_allnum_sum,
        als_id_m1_org_typ_allnum_sum,
        als_id_m3_org_typ_allnum_sum,
        als_id_m6_org_typ_allnum_sum,
        als_id_m12_org_typ_allnum_sum ,
        als_id_d7_nbank_org_typ_orgnum_sum,
        als_id_d15_nbank_org_typ_orgnum_sum,
        als_id_m1_nbank_org_typ_orgnum_sum,
        als_id_m3_nbank_org_typ_orgnum_sum,
        als_id_m6_nbank_org_typ_orgnum_sum ,
        als_id_m12_nbank_org_typ_orgnum_sum,
        als_id_d7_nbank_org_typ_allnum_sum,
        als_id_d15_nbank_org_typ_allnum_sum,
        als_id_m1_nbank_org_typ_allnum_sum,
        als_id_m3_nbank_org_typ_allnum_sum ,
        als_id_m6_nbank_org_typ_allnum_sum,
        als_id_m12_nbank_org_typ_allnum_sum,
        als_id_d7_bank_org_typ_orgnum_sum,
        als_id_d15_bank_org_typ_orgnum_sum,
        als_id_m1_bank_org_typ_orgnum_sum ,
        als_id_m3_bank_org_typ_orgnum_sum,
        als_id_m6_bank_org_typ_orgnum_sum,
        als_id_m12_bank_org_typ_orgnum_sum,
        als_id_d7_bank_org_typ_allnum_sum,
        als_id_d15_bank_org_typ_allnum_sum ,
        als_id_m1_bank_org_typ_allnum_sum,
        als_id_m3_bank_org_typ_allnum_sum,
        als_id_m6_bank_org_typ_allnum_sum,
        als_id_m12_bank_org_typ_allnum_sum,
        als_id_d7_org_typ_week_orgnum_sum ,
        als_id_d15_org_typ_week_orgnum_sum,
        als_id_m1_org_typ_week_orgnum_sum,
        als_id_m3_org_typ_week_orgnum_sum,
        als_id_m6_org_typ_week_orgnum_sum,
        als_id_m12_org_typ_week_orgnum_sum ,
        als_id_d7_org_typ_week_allnum_sum,
        als_id_d15_org_typ_week_allnum_sum,
        als_id_m1_org_typ_week_allnum_sum,
        als_id_m3_org_typ_week_allnum_sum,
        als_id_m6_org_typ_week_allnum_sum ,
        als_id_m12_org_typ_week_allnum_sum,
        als_id_d7_org_typ_night_orgnum_sum,
        als_id_d15_org_typ_night_orgnum_sum,
        als_id_m1_org_typ_night_orgnum_sum,
        als_id_m3_org_typ_night_orgnum_sum ,
        als_id_m6_org_typ_night_orgnum_sum,
        als_id_m12_org_typ_night_orgnum_sum,
        als_id_d7_org_typ_night_allnum_sum,
        als_id_d15_org_typ_night_allnum_sum,
        als_id_m1_org_typ_night_allnum_sum ,
        als_id_m3_org_typ_night_allnum_sum,
        als_id_m6_org_typ_night_allnum_sum,
        als_id_m12_org_typ_night_allnum_sum,
        als_id_d7_ca_loan_typ_orgnum_sum,
        als_id_d15_ca_loan_typ_orgnum_sum ,
        als_id_m1_ca_loan_typ_orgnum_sum,
        als_id_m3_ca_loan_typ_orgnum_sum,
        als_id_m6_ca_loan_typ_orgnum_sum,
        als_id_m12_ca_loan_typ_orgnum_sum,
        als_id_d7_ca_loan_typ_allnum_sum ,
        als_id_d15_ca_loan_typ_allnum_sum,
        als_id_m1_ca_loan_typ_allnum_sum,
        als_id_m3_ca_loan_typ_allnum_sum,
        als_id_m6_ca_loan_typ_allnum_sum,
        als_id_m12_ca_loan_typ_allnum_sum ,
        als_id_d7_co_loan_typ_orgnum_sum,
        als_id_d15_co_loan_typ_orgnum_sum,
        als_id_m1_co_loan_typ_orgnum_sum,
        als_id_m3_co_loan_typ_orgnum_sum,
        als_id_m6_co_loan_typ_orgnum_sum ,
        als_id_m12_co_loan_typ_orgnum_sum,
        als_id_d7_co_loan_typ_allnum_sum,
        als_id_d15_co_loan_typ_allnum_sum,
        als_id_m1_co_loan_typ_allnum_sum,
        als_id_m3_co_loan_typ_allnum_sum ,
        als_id_m6_co_loan_typ_allnum_sum,
        als_id_m12_co_loan_typ_allnum_sum,
        als_id_d7_on_loan_typ_orgnum_sum,
        als_id_d15_on_loan_typ_orgnum_sum,
        als_id_m1_on_loan_typ_orgnum_sum ,
        als_id_m3_on_loan_typ_orgnum_sum,
        als_id_m6_on_loan_typ_orgnum_sum,
        als_id_m12_on_loan_typ_orgnum_sum,
        als_id_d7_on_loan_typ_allnum_sum,
        als_id_d15_on_loan_typ_allnum_sum ,
        als_id_m1_on_loan_typ_allnum_sum,
        als_id_m3_on_loan_typ_allnum_sum,
        als_id_m6_on_loan_typ_allnum_sum,
        als_id_m12_on_loan_typ_allnum_sum,
        als_id_d7_off_loan_typ_orgnum_sum ,
        als_id_d15_off_loan_typ_orgnum_sum,
        als_id_m1_off_loan_typ_orgnum_sum,
        als_id_m3_off_loan_typ_orgnum_sum,
        als_id_m6_off_loan_typ_orgnum_sum,
        als_id_m12_off_loan_typ_orgnum_sum ,
        als_id_d7_off_loan_typ_allnum_sum,
        als_id_d15_off_loan_typ_allnum_sum,
        als_id_m1_off_loan_typ_allnum_sum,
        als_id_m3_off_loan_typ_allnum_sum,
        als_id_m6_off_loan_typ_allnum_sum ,
        als_id_m12_off_loan_typ_allnum_sum,
        als_id_d7_lsd_org_typ_orgnum_sum,
        als_id_d15_lsd_org_typ_orgnum_sum,
        als_id_m1_lsd_org_typ_orgnum_sum,
        als_id_m3_lsd_org_typ_orgnum_sum ,
        als_id_m6_lsd_org_typ_orgnum_sum,
        als_id_m12_lsd_org_typ_orgnum_sum,
        als_id_d7_lsd_org_typ_allnum_sum,
        als_id_d15_lsd_org_typ_allnum_sum,
        als_id_m1_lsd_org_typ_allnum_sum ,
        als_id_m3_lsd_org_typ_allnum_sum,
        als_id_m6_lsd_org_typ_allnum_sum,
        als_id_m12_lsd_org_typ_allnum_sum,
        als_id_d7_sloan_org_typ_orgnum_sum,
        als_id_d15_sloan_org_typ_orgnum_sum ,
        als_id_m1_sloan_org_typ_orgnum_sum,
        als_id_m3_sloan_org_typ_orgnum_sum,
        als_id_m6_sloan_org_typ_orgnum_sum,
        als_id_m12_sloan_org_typ_orgnum_sum,
        als_id_d7_sloan_org_typ_allnum_sum ,
        als_id_d15_sloan_org_typ_allnum_sum,
        als_id_m1_sloan_org_typ_allnum_sum,
        als_id_m3_sloan_org_typ_allnum_sum,
        als_id_m6_sloan_org_typ_allnum_sum,
        als_id_m12_sloan_org_typ_allnum_sum ,
        als_id_d7_all_oth_org_typ_orgnum_sum,
        als_id_d15_all_oth_org_typ_orgnum_sum,
        als_id_m1_all_oth_org_typ_orgnum_sum,
        als_id_m3_all_oth_org_typ_orgnum_sum,
        als_id_m6_all_oth_org_typ_orgnum_sum ,
        als_id_m12_all_oth_org_typ_orgnum_sum,
        als_id_d7_all_oth_org_typ_allnum_sum,
        als_id_d15_all_oth_org_typ_allnum_sum,
        als_id_m1_all_oth_org_typ_allnum_sum,
        als_id_m3_all_oth_org_typ_allnum_sum ,
        als_id_m6_all_oth_org_typ_allnum_sum,
        als_id_m12_all_oth_org_typ_allnum_sum,
        als_id_d7_stg_org_typ_orgnum_sum,
        als_id_d15_stg_org_typ_orgnum_sum,
        als_id_m1_stg_org_typ_orgnum_sum ,
        als_id_m3_stg_org_typ_orgnum_sum,
        als_id_m6_stg_org_typ_orgnum_sum,
        als_id_m12_stg_org_typ_orgnum_sum,
        als_id_d7_stg_org_typ_allnum_sum,
        als_id_d15_stg_org_typ_allnum_sum ,
        als_id_m1_stg_org_typ_allnum_sum,
        als_id_m3_stg_org_typ_allnum_sum,
        als_id_m6_stg_org_typ_allnum_sum,
        als_id_m12_stg_org_typ_allnum_sum,
        als_id_m1_m3_loan_typ_orgnum_sum ,
        als_id_m3_m6_loan_typ_orgnum_sum,
        als_id_m6_m12_loan_typ_orgnum_sum,
        als_id_m1_m3_loan_typ_allnum_sum,
        als_id_m3_m6_loan_typ_allnum_sum,
        als_id_m6_m12_loan_typ_allnum_sum ,
        als_id_m1_m3_org_typ_orgnum_sum,
        als_id_m3_m6_org_typ_orgnum_sum,
        als_id_m6_m12_org_typ_orgnum_sum,
        als_id_m1_m3_org_typ_allnum_sum,
        als_id_m3_m6_org_typ_allnum_sum ,
        als_id_m6_m12_org_typ_allnum_sum,
        als_id_m1_m3_org_typ_week_orgnum_sum,
        als_id_m3_m6_org_typ_week_orgnum_sum,
        als_id_m6_m12_org_typ_week_orgnum_sum,
        als_id_m1_m3_org_typ_week_allnum_sum ,
        als_id_m3_m6_org_typ_week_allnum_sum,
        als_id_m6_m12_org_typ_week_allnum_sum,
        als_id_m1_m3_org_typ_night_orgnum_sum,
        als_id_m3_m6_org_typ_night_orgnum_sum,
        als_id_m6_m12_org_typ_night_orgnum_sum ,
        als_id_m1_m3_org_typ_night_allnum_sum,
        als_id_m3_m6_org_typ_night_allnum_sum,
        als_id_m6_m12_org_typ_night_allnum_sum,
        als_id_m1_m3_ca_loan_typ_orgnum_sum,
        als_id_m3_m6_ca_loan_typ_orgnum_sum ,
        als_id_m6_m12_ca_loan_typ_orgnum_sum,
        als_id_m1_m3_ca_loan_typ_allnum_sum,
        als_id_m3_m6_ca_loan_typ_allnum_sum,
        als_id_m6_m12_ca_loan_typ_allnum_sum,
        als_id_m1_m3_co_loan_typ_orgnum_sum ,
        als_id_m3_m6_co_loan_typ_orgnum_sum,
        als_id_m6_m12_co_loan_typ_orgnum_sum,
        als_id_m1_m3_co_loan_typ_allnum_sum,
        als_id_m3_m6_co_loan_typ_allnum_sum,
        als_id_m6_m12_co_loan_typ_allnum_sum ,
        als_id_m1_m3_on_loan_typ_orgnum_sum,
        als_id_m3_m6_on_loan_typ_orgnum_sum,
        als_id_m6_m12_on_loan_typ_orgnum_sum,
        als_id_m1_m3_on_loan_typ_allnum_sum,
        als_id_m3_m6_on_loan_typ_allnum_sum ,
        als_id_m6_m12_on_loan_typ_allnum_sum,
        als_id_m1_m3_off_loan_typ_orgnum_sum,
        als_id_m3_m6_off_loan_typ_orgnum_sum,
        als_id_m6_m12_off_loan_typ_orgnum_sum,
        als_id_m1_m3_off_loan_typ_allnum_sum ,
        als_id_m3_m6_off_loan_typ_allnum_sum,
        als_id_m6_m12_off_loan_typ_allnum_sum,
        als_id_m1_m3_lsd_org_typ_orgnum_sum,
        als_id_m3_m6_lsd_org_typ_orgnum_sum,
        als_id_m6_m12_lsd_org_typ_orgnum_sum ,
        als_id_m1_m3_lsd_org_typ_allnum_sum,
        als_id_m3_m6_lsd_org_typ_allnum_sum,
        als_id_m6_m12_lsd_org_typ_allnum_sum,
        als_id_m1_m3_sloan_org_typ_orgnum_sum,
        als_id_m3_m6_sloan_org_typ_orgnum_sum ,
        als_id_m6_m12_sloan_org_typ_orgnum_sum,
        als_id_m1_m3_sloan_org_typ_allnum_sum,
        als_id_m3_m6_sloan_org_typ_allnum_sum,
        als_id_m6_m12_sloan_org_typ_allnum_sum,
        als_id_m1_m3_all_oth_org_typ_orgnum_sum ,
        als_id_m3_m6_all_oth_org_typ_orgnum_sum,
        als_id_m6_m12_all_oth_org_typ_orgnum_sum,
        als_id_m1_m3_all_oth_org_typ_allnum_sum,
        als_id_m3_m6_all_oth_org_typ_allnum_sum,
        als_id_m6_m12_all_oth_org_typ_allnum_sum ,
        als_id_m1_m3_stg_org_typ_orgnum_sum,
        als_id_m3_m6_stg_org_typ_orgnum_sum,
        als_id_m6_m12_stg_org_typ_orgnum_sum,
        als_id_m1_m3_stg_org_typ_allnum_sum,
        als_id_m3_m6_stg_org_typ_allnum_sum ,
        als_id_m6_m12_stg_org_typ_allnum_sum,

        als_id_d15_m1_m3_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_m6_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_loan_typ_orgnum_sum_rto ,
        als_id_m1_m3_m6_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_m3_loan_typ_allnum_sum_rto,
        als_id_d15_m3_m6_loan_typ_allnum_sum_rto ,
        als_id_d15_m6_m12_loan_typ_allnum_sum_rto,
        als_id_m1_m3_m6_loan_typ_allnum_sum_rto,
        als_id_m1_m6_m12_loan_typ_allnum_sum_rto,
        als_id_m3_m6_m12_loan_typ_allnum_sum_rto,
        als_id_d15_m1_m3_org_typ_orgnum_sum_rto ,
        als_id_d15_m3_m6_org_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_org_typ_orgnum_sum_rto,
        als_id_m1_m3_m6_org_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_org_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_org_typ_orgnum_sum_rto ,
        als_id_d15_m1_m3_org_typ_allnum_sum_rto,
        als_id_d15_m3_m6_org_typ_allnum_sum_rto,
        als_id_d15_m6_m12_org_typ_allnum_sum_rto,
        als_id_m1_m3_m6_org_typ_allnum_sum_rto,
        als_id_m1_m6_m12_org_typ_allnum_sum_rto ,
        als_id_m3_m6_m12_org_typ_allnum_sum_rto,
        als_id_d15_m1_m3_org_typ_week_orgnum_sum_rto,
        als_id_d15_m3_m6_org_typ_week_orgnum_sum_rto,
        als_id_d15_m6_m12_org_typ_week_orgnum_sum_rto,
        als_id_m1_m3_m6_org_typ_week_orgnum_sum_rto ,
        als_id_m1_m6_m12_org_typ_week_orgnum_sum_rto,
        als_id_m3_m6_m12_org_typ_week_orgnum_sum_rto,
        als_id_d15_m1_m3_org_typ_week_allnum_sum_rto,
        als_id_d15_m3_m6_org_typ_week_allnum_sum_rto,
        als_id_d15_m6_m12_org_typ_week_allnum_sum_rto ,
        als_id_m1_m3_m6_org_typ_week_allnum_sum_rto,
        als_id_m1_m6_m12_org_typ_week_allnum_sum_rto,
        als_id_m3_m6_m12_org_typ_week_allnum_sum_rto,
        als_id_d15_m1_m3_org_typ_night_orgnum_sum_rto,
        als_id_d15_m3_m6_org_typ_night_orgnum_sum_rto ,
        als_id_d15_m6_m12_org_typ_night_orgnum_sum_rto,
        als_id_m1_m3_m6_org_typ_night_orgnum_sum_rto,
        als_id_m1_m6_m12_org_typ_night_orgnum_sum_rto,
        als_id_m3_m6_m12_org_typ_night_orgnum_sum_rto,
        als_id_d15_m1_m3_org_typ_night_allnum_sum_rto ,
        als_id_d15_m3_m6_org_typ_night_allnum_sum_rto,
        als_id_d15_m6_m12_org_typ_night_allnum_sum_rto,
        als_id_m1_m3_m6_org_typ_night_allnum_sum_rto,
        als_id_m1_m6_m12_org_typ_night_allnum_sum_rto,
        als_id_m3_m6_m12_org_typ_night_allnum_sum_rto ,
        als_id_d15_m1_m3_ca_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_m6_ca_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_ca_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_m6_ca_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_ca_loan_typ_orgnum_sum_rto ,
        als_id_m3_m6_m12_ca_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_m3_ca_loan_typ_allnum_sum_rto,
        als_id_d15_m3_m6_ca_loan_typ_allnum_sum_rto,
        als_id_d15_m6_m12_ca_loan_typ_allnum_sum_rto,
        als_id_m1_m3_m6_ca_loan_typ_allnum_sum_rto ,
        als_id_m1_m6_m12_ca_loan_typ_allnum_sum_rto,
        als_id_m3_m6_m12_ca_loan_typ_allnum_sum_rto,
        als_id_d15_m1_m3_co_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_m6_co_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_co_loan_typ_orgnum_sum_rto ,
        als_id_m1_m3_m6_co_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_co_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_co_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_m3_co_loan_typ_allnum_sum_rto,
        als_id_d15_m3_m6_co_loan_typ_allnum_sum_rto ,
        als_id_d15_m6_m12_co_loan_typ_allnum_sum_rto,
        als_id_m1_m3_m6_co_loan_typ_allnum_sum_rto,
        als_id_m1_m6_m12_co_loan_typ_allnum_sum_rto,
        als_id_m3_m6_m12_co_loan_typ_allnum_sum_rto,
        als_id_d15_m1_m3_on_loan_typ_orgnum_sum_rto ,
        als_id_d15_m3_m6_on_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_on_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_m6_on_loan_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_on_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_on_loan_typ_orgnum_sum_rto ,
        als_id_d15_m1_m3_on_loan_typ_allnum_sum_rto,
        als_id_d15_m3_m6_on_loan_typ_allnum_sum_rto,
        als_id_d15_m6_m12_on_loan_typ_allnum_sum_rto,
        als_id_m1_m3_m6_on_loan_typ_allnum_sum_rto,
        als_id_m1_m6_m12_on_loan_typ_allnum_sum_rto ,
        als_id_m3_m6_m12_on_loan_typ_allnum_sum_rto,
        als_id_d15_m1_m3_off_loan_typ_orgnum_sum_rto,
        als_id_d15_m3_m6_off_loan_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_off_loan_typ_orgnum_sum_rto,
        als_id_m1_m3_m6_off_loan_typ_orgnum_sum_rto ,
        als_id_m1_m6_m12_off_loan_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_off_loan_typ_orgnum_sum_rto,
        als_id_d15_m1_m3_off_loan_typ_allnum_sum_rto,
        als_id_d15_m3_m6_off_loan_typ_allnum_sum_rto,
        als_id_d15_m6_m12_off_loan_typ_allnum_sum_rto ,
        als_id_m1_m3_m6_off_loan_typ_allnum_sum_rto,
        als_id_m1_m6_m12_off_loan_typ_allnum_sum_rto,
        als_id_m3_m6_m12_off_loan_typ_allnum_sum_rto,
        als_id_d15_m1_m3_lsd_org_typ_orgnum_sum_rto,
        als_id_d15_m3_m6_lsd_org_typ_orgnum_sum_rto ,
        als_id_d15_m6_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_m1_m3_m6_lsd_org_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_lsd_org_typ_orgnum_sum_rto,
        als_id_d15_m1_m3_lsd_org_typ_allnum_sum_rto ,
        als_id_d15_m3_m6_lsd_org_typ_allnum_sum_rto,
        als_id_d15_m6_m12_lsd_org_typ_allnum_sum_rto,
        als_id_m1_m3_m6_lsd_org_typ_allnum_sum_rto,
        als_id_m1_m6_m12_lsd_org_typ_allnum_sum_rto,
        als_id_m3_m6_m12_lsd_org_typ_allnum_sum_rto ,
        als_id_d15_m1_m3_sloan_org_typ_orgnum_sum_rto,
        als_id_d15_m3_m6_sloan_org_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_sloan_org_typ_orgnum_sum_rto,
        als_id_m1_m3_m6_sloan_org_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_sloan_org_typ_orgnum_sum_rto ,
        als_id_m3_m6_m12_sloan_org_typ_orgnum_sum_rto,
        als_id_d15_m1_m3_sloan_org_typ_allnum_sum_rto,
        als_id_d15_m3_m6_sloan_org_typ_allnum_sum_rto,
        als_id_d15_m6_m12_sloan_org_typ_allnum_sum_rto,
        als_id_m1_m3_m6_sloan_org_typ_allnum_sum_rto ,
        als_id_m1_m6_m12_sloan_org_typ_allnum_sum_rto,
        als_id_m3_m6_m12_sloan_org_typ_allnum_sum_rto,
        als_id_d15_m1_m3_all_oth_org_typ_orgnum_sum_rto,
        als_id_d15_m3_m6_all_oth_org_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_all_oth_org_typ_orgnum_sum_rto ,
        als_id_m1_m3_m6_all_oth_org_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_all_oth_org_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_all_oth_org_typ_orgnum_sum_rto,
        als_id_d15_m1_m3_all_oth_org_typ_allnum_sum_rto,
        als_id_d15_m3_m6_all_oth_org_typ_allnum_sum_rto ,
        als_id_d15_m6_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_m1_m3_m6_all_oth_org_typ_allnum_sum_rto,
        als_id_m1_m6_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_m3_m6_m12_all_oth_org_typ_allnum_sum_rto,
        als_id_d15_m1_m3_stg_org_typ_orgnum_sum_rto ,
        als_id_d15_m3_m6_stg_org_typ_orgnum_sum_rto,
        als_id_d15_m6_m12_stg_org_typ_orgnum_sum_rto,
        als_id_m1_m3_m6_stg_org_typ_orgnum_sum_rto,
        als_id_m1_m6_m12_stg_org_typ_orgnum_sum_rto,
        als_id_m3_m6_m12_stg_org_typ_orgnum_sum_rto ,
        als_id_d15_m1_m3_stg_org_typ_allnum_sum_rto,
        als_id_d15_m3_m6_stg_org_typ_allnum_sum_rto,
        als_id_d15_m6_m12_stg_org_typ_allnum_sum_rto,
        als_id_m1_m3_m6_stg_org_typ_allnum_sum_rto,
        als_id_m1_m6_m12_stg_org_typ_allnum_sum_rto ,
        als_id_m3_m6_m12_stg_org_typ_allnum_sum_rto,

        als_m3_id_avg_mons,
        als_m6_id_avg_mons,
        als_m12_id_avg_mons ,
        als_m3_id_bank_avg_mons,
        als_m6_id_bank_avg_mons,
        als_m12_id_bank_avg_mons,
        als_m3_id_nbank_avg_mons,
        als_m6_id_nbank_avg_mons ,
        als_m12_id_nbank_avg_mons,
        als_id_m3_m6_avg_mons,
        als_id_m6_m12_avg_mons,
        als_id_m3_m6_bank_avg_mons,
        als_id_m6_m12_bank_avg_mons ,
        als_id_m3_m6_nbank_avg_mons,
        als_id_m6_m12_nbank_avg_mons,
        als_m3_id_bank_tot_mons_rto,
        als_m3_id_nbank_tot_mons_rto,
        als_m6_id_bank_tot_mons_rto ,
        als_m6_id_nbank_tot_mons_rto,
        als_m12_id_bank_tot_mons_rto,
        als_m12_id_nbank_tot_mons_rto,
        als_id_m3_m6_avg_mons_rto,
        als_id_m3_m12_avg_mons_rto ,
        als_id_m6_m12_avg_mons_rto,
        als_id_m3_m6_bank_avg_mons_rto,
        als_id_m3_m12_bank_avg_mons_rto,
        als_id_m6_m12_bank_avg_mons_rto,
        als_id_m3_m6_nbank_avg_mons_rto ,
        als_id_m3_m12_nbank_avg_mons_rto,
        als_id_m6_m12_nbank_avg_mons_rto,
        als_id_m3_m3_m6_avg_mons_rto,
        als_id_m3_m6_m12_avg_mons_rto,
        als_id_m3_m3_m6_bank_avg_mons_rto ,
        als_id_m3_m6_m12_bank_avg_mons_rto,
        als_id_m6_m6_m12_bank_avg_mons_rto,
        als_id_m3_m3_m6_nbank_avg_mons_rto,
        als_id_m3_m6_m12_nbank_avg_mons_rto,
        als_id_m6_m6_m12_nbank_avg_mons_rto ,
        als_m3_m6_id_nbank_tot_mons_rto_trend,
        als_m6_m12_id_nbank_tot_mons_rto_trend,
        als_m3_m6_id_bank_tot_mons_rto_trend,
        als_m6_m12_id_bank_tot_mons_rto_trend,

        model_data.data_id,
        model_data.code,
        model_data.flag_applyloanstr,
        model_data.swift_number,
        model_data.created_at,
        model_data.updated_at,
        current_timestamp() as rcd_tim,
        model_data.ds
from 
(
    select uid,
        data_id,
        code,
        flag_applyloanstr,
        swift_number,
        created_at,
        updated_at,
        ds
    from dbus.dbus_dz_daily_br_trend_feature_v3_base_di
    where ds = '${bizdate}'
) as model_data
left join pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp1 as t1
on model_data.uid = t1.uid and model_data.swift_number = t1.swift_number
left join pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp2 as t2
on model_data.uid = t2.uid and model_data.swift_number = t2.swift_number
left join pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp3 as t3
on model_data.uid = t3.uid and model_data.swift_number = t3.swift_number
left join pdm_risk.pdm_risk_dz_daily_br_vertical_trend_feature_v3_di_tmp4 as t4
on model_data.uid = t4.uid and model_data.swift_number = t4.swift_number
;
-- feature-copilot:node-end ordinal=0
