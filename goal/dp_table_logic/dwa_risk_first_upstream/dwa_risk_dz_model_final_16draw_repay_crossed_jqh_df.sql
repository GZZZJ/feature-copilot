-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_16draw_repay_crossed_jqh_df
-- node_id: n_6398968351519342592
-- task_name: dwa_risk_dz_model_final_16draw_repay_crossed_jqh_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_16draw_repay_crossed_jqh_df.json
-- source_json_sha256: 795418a895f43755c08cd6525b730f3070d409ca392d4b4fd0aba4557238f54d
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_detail_jqh
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_detail_jqh
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base_jqh_df
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2_jqh_${bizdate}
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_jqh_${bizdate}

--MaxCompute_SQL
--所属主题: 交易域
--功能描述: 结清前12个月借新还旧交叉特征（聚合版）
--创建者: 王博韬
--创建日期: 2024-11-13

CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_jqh_df
(
	`uid` STRING COMMENT '用户ID',
	`mdl_dte` DATE,
	`ddf_bjq_12m_rep_dte_0_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_0_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_0_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_0_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_0_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_0_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_0_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_1_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_1_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_1_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_1_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_1_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_1_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_1_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_3_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_3_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_3_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_3_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_3_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_3_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_3_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_5_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_5_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_5_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_5_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_5_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_5_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_5_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_7_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_7_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_7_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_7_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_7_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_7_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_7_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_neg_1_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_neg_1_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_neg_1_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_neg_1_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_1_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_1_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_neg_3_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_neg_3_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_neg_3_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_neg_3_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_3_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_3_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_neg_5_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_neg_5_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_neg_5_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_neg_5_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_5_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_5_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`ddf_bjq_12m_rep_dte_neg_7_crt_dt_ord_cnt` BIGINT,
	`ddf_bjq_12m_rep_dte_neg_7_crt_dt_sum_prc_amt` DECIMAL(28,6),
	`ddf_bjq_12m_rep_dte_neg_7_crt_dt_avg_prc_amt` DECIMAL(38,16),
	`ddf_bjq_12m_rep_dte_neg_7_crt_dt_max_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_7_crt_dt_min_prc_amt` DECIMAL(18,6),
	`ddf_bjq_12m_rep_dte_neg_7_crt_dt_rep_prc_amt` DECIMAL(38,6),
	`ddf_bjq_12m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto` DECIMAL(38,10),
	`min_ddf_rep_dte_ord_crt_tim_1_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_1_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_1_bjq_12m` DOUBLE,
	`min_ddf_rep_dte_ord_crt_tim_3_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_3_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_3_bjq_12m` DOUBLE,
	`min_ddf_rep_dte_ord_crt_tim_5_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_5_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_5_bjq_12m` DOUBLE,
	`min_ddf_rep_dte_ord_crt_tim_7_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_7_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_7_bjq_12m` DOUBLE,
	`min_ddf_rep_dte_ord_crt_tim_neg_1_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_neg_1_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_neg_1_bjq_12m` DOUBLE,
	`min_ddf_rep_dte_ord_crt_tim_neg_3_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_neg_3_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_neg_3_bjq_12m` DOUBLE,
	`min_ddf_rep_dte_ord_crt_tim_neg_5_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_neg_5_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_neg_5_bjq_12m` DOUBLE,
	`min_ddf_rep_dte_ord_crt_tim_neg_7_bjq_12m` INT,
	`max_ddf_rep_dte_ord_crt_tim_neg_7_bjq_12m` INT,
	`avg_ddf_rep_dte_ord_crt_tim_neg_7_bjq_12m` DOUBLE
)
PARTITIONED BY (
	`ds` STRING COMMENT '分区字段格式yyyymmdd'
);

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_jqh_df partition(ds='${bizdate}')
select model_data.uid
        ,model_data.mdl_dte
    ,coalesce(ddf_12m_rep_dte_0_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_0_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_0_crt_dt_sum_prc_amt / ddf_12m_rep_dte_0_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_0_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_0_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_0_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_0_crt_dt_sum_prc_amt / ddf_12m_rep_dte_0_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_1_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_1_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_1_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_1_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_1_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_1_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_1_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_3_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_3_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_3_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_3_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_3_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_3_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_3_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_5_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_5_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_5_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_5_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_5_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_5_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_5_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_7_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_7_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_7_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_7_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_7_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_7_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_7_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_neg_1_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_neg_1_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_1_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_1_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_neg_3_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_neg_3_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_3_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_3_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_neg_5_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_neg_5_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_5_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_5_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,coalesce(ddf_12m_rep_dte_neg_7_crt_dt_ord_cnt,0)
    ,coalesce(ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt,0)
    ,ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce(ddf_12m_rep_dte_neg_7_crt_dt_max_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_7_crt_dt_min_prc_amt,0)
    ,coalesce(ddf_12m_rep_dte_neg_7_crt_dt_rep_prc_amt,0)
    ,ddf_12m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_12m_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,min_ddf_rep_dte_ord_crt_tim_1
    ,max_ddf_rep_dte_ord_crt_tim_1
    ,avg_ddf_rep_dte_ord_crt_tim_1
    ,min_ddf_rep_dte_ord_crt_tim_3
    ,max_ddf_rep_dte_ord_crt_tim_3
    ,avg_ddf_rep_dte_ord_crt_tim_3
    ,min_ddf_rep_dte_ord_crt_tim_5
    ,max_ddf_rep_dte_ord_crt_tim_5
    ,avg_ddf_rep_dte_ord_crt_tim_5
    ,min_ddf_rep_dte_ord_crt_tim_7
    ,max_ddf_rep_dte_ord_crt_tim_7
    ,avg_ddf_rep_dte_ord_crt_tim_7
    ,min_ddf_rep_dte_ord_crt_tim_neg_1
    ,max_ddf_rep_dte_ord_crt_tim_neg_1
    ,avg_ddf_rep_dte_ord_crt_tim_neg_1
    ,min_ddf_rep_dte_ord_crt_tim_neg_3
    ,max_ddf_rep_dte_ord_crt_tim_neg_3
    ,avg_ddf_rep_dte_ord_crt_tim_neg_3
    ,min_ddf_rep_dte_ord_crt_tim_neg_5
    ,max_ddf_rep_dte_ord_crt_tim_neg_5
    ,avg_ddf_rep_dte_ord_crt_tim_neg_5
    ,min_ddf_rep_dte_ord_crt_tim_neg_7
    ,max_ddf_rep_dte_ord_crt_tim_neg_7
    ,avg_ddf_rep_dte_ord_crt_tim_neg_7
from (select * from ${dwa_risk}.dwa_risk_f_dz_model_data_base_jqh_df where ds = '${bizdate}') model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2_jqh_${bizdate} temp_grouped
on model_data.uid=temp_grouped.uid
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_jqh_${bizdate};
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2_jqh_${bizdate};
-- feature-copilot:node-end ordinal=0
