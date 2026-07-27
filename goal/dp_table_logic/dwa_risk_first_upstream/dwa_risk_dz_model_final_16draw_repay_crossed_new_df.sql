-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_16draw_repay_crossed_new_df
-- node_id: n_6398812976782442496
-- task_name: dwa_risk_dz_model_final_16draw_repay_crossed_new_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_16draw_repay_crossed_new_df.json
-- source_json_sha256: 502dc3d61a7b74fbb2d8b3b3f51de8ffdd3df4f8dd879e03a339208c557987cd
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2024-11-25 10:22:38
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_new_df
(
	`uid` STRING COMMENT '用户ID',
	`mdl_dte` DATE,
	
	`ddf_24m_rep_dte_0_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且当日有动支的动支笔数',
	`ddf_24m_rep_dte_0_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且当日有动支的动支总金额',
	`ddf_24m_rep_dte_0_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且当日有动支的动支平均金额',
	`ddf_24m_rep_dte_0_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且当日有动支的动支最大金额',
	`ddf_24m_rep_dte_0_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且当日有动支的动支最小金额',
	`ddf_24m_rep_dte_0_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且当日有动支的应还金额',
	`ddf_24m_rep_dte_0_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且当日有动支的总动支金额与应还金额的占比',
	`ddf_24m_rep_dte_1_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且前1日有动支的动支笔数',
	`ddf_24m_rep_dte_1_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且前1日有动支的动支总金额',
	`ddf_24m_rep_dte_1_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且前1日有动支的动支平均金额',
	`ddf_24m_rep_dte_1_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前1日有动支的动支最大金额',
	`ddf_24m_rep_dte_1_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前1日有动支的动支最小金额',
	`ddf_24m_rep_dte_1_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且前1日有动支的应还金额',
	`ddf_24m_rep_dte_1_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且前1日有动支的总动支金额与应还金额的占比',
	`ddf_24m_rep_dte_3_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且前3日有动支的动支笔数',
	`ddf_24m_rep_dte_3_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且前3日有动支的动支总金额',
	`ddf_24m_rep_dte_3_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且前3日有动支的动支平均金额',
	`ddf_24m_rep_dte_3_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前3日有动支的动支最大金额',
	`ddf_24m_rep_dte_3_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前3日有动支的动支最小金额',
	`ddf_24m_rep_dte_3_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且前3日有动支的应还金额',
	`ddf_24m_rep_dte_3_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且前3日有动支的总动支金额与应还金额的占比',
	`ddf_24m_rep_dte_5_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且前5日有动支的动支笔数',
	`ddf_24m_rep_dte_5_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且前5日有动支的动支总金额',
	`ddf_24m_rep_dte_5_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且前5日有动支的动支平均金额',
	`ddf_24m_rep_dte_5_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前5日有动支的动支最大金额',
	`ddf_24m_rep_dte_5_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前5日有动支的动支最小金额',
	`ddf_24m_rep_dte_5_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且前5日有动支的应还金额',
	`ddf_24m_rep_dte_5_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且前5日有动支的总动支金额与应还金额的占比',
	`ddf_24m_rep_dte_7_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且前7日有动支的动支笔数',
	`ddf_24m_rep_dte_7_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且前7日有动支的动支总金额',
	`ddf_24m_rep_dte_7_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且前7日有动支的动支平均金额',
	`ddf_24m_rep_dte_7_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前7日有动支的动支最大金额',
	`ddf_24m_rep_dte_7_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且前7日有动支的动支最小金额',
	`ddf_24m_rep_dte_7_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且前7日有动支的应还金额',
	`ddf_24m_rep_dte_7_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且前7日有动支的总动支金额与应还金额的占比',

        `ddf_36m_rep_dte_0_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且当日有动支的动支笔数',
	`ddf_36m_rep_dte_0_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且当日有动支的动支总金额',
	`ddf_36m_rep_dte_0_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且当日有动支的动支平均金额',
	`ddf_36m_rep_dte_0_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且当日有动支的动支最大金额',
	`ddf_36m_rep_dte_0_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且当日有动支的动支最小金额',
	`ddf_36m_rep_dte_0_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且当日有动支的应还金额',
	`ddf_36m_rep_dte_0_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且当日有动支的总动支金额与应还金额的占比',
	`ddf_36m_rep_dte_1_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且前1日有动支的动支笔数',
	`ddf_36m_rep_dte_1_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且前1日有动支的动支总金额',
	`ddf_36m_rep_dte_1_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且前1日有动支的动支平均金额',
	`ddf_36m_rep_dte_1_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前1日有动支的动支最大金额',
	`ddf_36m_rep_dte_1_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前1日有动支的动支最小金额',
	`ddf_36m_rep_dte_1_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且前1日有动支的应还金额',
	`ddf_36m_rep_dte_1_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且前1日有动支的总动支金额与应还金额的占比',
	`ddf_36m_rep_dte_3_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且前3日有动支的动支笔数',
	`ddf_36m_rep_dte_3_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且前3日有动支的动支总金额',
	`ddf_36m_rep_dte_3_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且前3日有动支的动支平均金额',
	`ddf_36m_rep_dte_3_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前3日有动支的动支最大金额',
	`ddf_36m_rep_dte_3_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前3日有动支的动支最小金额',
	`ddf_36m_rep_dte_3_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且前3日有动支的应还金额',
	`ddf_36m_rep_dte_3_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且前3日有动支的总动支金额与应还金额的占比',
	`ddf_36m_rep_dte_5_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且前5日有动支的动支笔数',
	`ddf_36m_rep_dte_5_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且前5日有动支的动支总金额',
	`ddf_36m_rep_dte_5_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且前5日有动支的动支平均金额',
	`ddf_36m_rep_dte_5_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前5日有动支的动支最大金额',
	`ddf_36m_rep_dte_5_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前5日有动支的动支最小金额',
	`ddf_36m_rep_dte_5_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且前5日有动支的应还金额',
	`ddf_36m_rep_dte_5_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且前5日有动支的总动支金额与应还金额的占比',
	`ddf_36m_rep_dte_7_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且前7日有动支的动支笔数',
	`ddf_36m_rep_dte_7_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且前7日有动支的动支总金额',
	`ddf_36m_rep_dte_7_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且前7日有动支的动支平均金额',
	`ddf_36m_rep_dte_7_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前7日有动支的动支最大金额',
	`ddf_36m_rep_dte_7_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且前7日有动支的动支最小金额',
	`ddf_36m_rep_dte_7_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且前7日有动支的应还金额',
	`ddf_36m_rep_dte_7_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且前7日有动支的总动支金额与应还金额的占比',

        `ddf_rep_dte_0_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且当日有动支的动支笔数',
	`ddf_rep_dte_0_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且当日有动支的动支总金额',
	`ddf_rep_dte_0_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且当日有动支的动支平均金额',
	`ddf_rep_dte_0_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且当日有动支的动支最大金额',
	`ddf_rep_dte_0_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且当日有动支的动支最小金额',
	`ddf_rep_dte_0_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且当日有动支的应还金额',
	`ddf_rep_dte_0_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且当日有动支的总动支金额与应还金额的占比',
	`ddf_rep_dte_1_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且前1日有动支的动支笔数',
	`ddf_rep_dte_1_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且前1日有动支的动支总金额',
	`ddf_rep_dte_1_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且前1日有动支的动支平均金额',
	`ddf_rep_dte_1_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前1日有动支的动支最大金额',
	`ddf_rep_dte_1_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前1日有动支的动支最小金额',
	`ddf_rep_dte_1_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且前1日有动支的应还金额',
	`ddf_rep_dte_1_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且前1日有动支的总动支金额与应还金额的占比',
	`ddf_rep_dte_3_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且前3日有动支的动支笔数',
	`ddf_rep_dte_3_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且前3日有动支的动支总金额',
	`ddf_rep_dte_3_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且前3日有动支的动支平均金额',
	`ddf_rep_dte_3_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前3日有动支的动支最大金额',
	`ddf_rep_dte_3_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前3日有动支的动支最小金额',
	`ddf_rep_dte_3_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且前3日有动支的应还金额',
	`ddf_rep_dte_3_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且前3日有动支的总动支金额与应还金额的占比',
	`ddf_rep_dte_5_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且前5日有动支的动支笔数',
	`ddf_rep_dte_5_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且前5日有动支的动支总金额',
	`ddf_rep_dte_5_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且前5日有动支的动支平均金额',
	`ddf_rep_dte_5_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前5日有动支的动支最大金额',
	`ddf_rep_dte_5_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前5日有动支的动支最小金额',
	`ddf_rep_dte_5_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且前5日有动支的应还金额',
	`ddf_rep_dte_5_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且前5日有动支的总动支金额与应还金额的占比',
	`ddf_rep_dte_7_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且前7日有动支的动支笔数',
	`ddf_rep_dte_7_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且前7日有动支的动支总金额',
	`ddf_rep_dte_7_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且前7日有动支的动支平均金额',
	`ddf_rep_dte_7_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前7日有动支的动支最大金额',
	`ddf_rep_dte_7_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且前7日有动支的动支最小金额',
	`ddf_rep_dte_7_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且前7日有动支的应还金额',
	`ddf_rep_dte_7_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且前7日有动支的总动支金额与应还金额的占比',




------------------第二部分-------------------------
	`ddf_24m_rep_dte_neg_1_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且后1日有动支的动支笔数',
	`ddf_24m_rep_dte_neg_1_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且后1日有动支的动支总金额',
	`ddf_24m_rep_dte_neg_1_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且后1日有动支的动支平均金额',
	`ddf_24m_rep_dte_neg_1_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后1日有动支的动支最大金额',
	`ddf_24m_rep_dte_neg_1_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后1日有动支的动支最小金额',
	`ddf_24m_rep_dte_neg_1_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且后1日有动支的应还金额',
	`ddf_24m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且后1日有动支的总动支金额与应还金额的占比',
	`ddf_24m_rep_dte_neg_3_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且后3日有动支的动支笔数',
	`ddf_24m_rep_dte_neg_3_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且后3日有动支的动支总金额',
	`ddf_24m_rep_dte_neg_3_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且后3日有动支的动支平均金额',
	`ddf_24m_rep_dte_neg_3_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后3日有动支的动支最大金额',
	`ddf_24m_rep_dte_neg_3_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后3日有动支的动支最小金额',
	`ddf_24m_rep_dte_neg_3_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且后3日有动支的应还金额',
	`ddf_24m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且后3日有动支的总动支金额与应还金额的占比',
	`ddf_24m_rep_dte_neg_5_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且后5日有动支的动支笔数',
	`ddf_24m_rep_dte_neg_5_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且后5日有动支的动支总金额',
	`ddf_24m_rep_dte_neg_5_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且后5日有动支的动支平均金额',
	`ddf_24m_rep_dte_neg_5_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后5日有动支的动支最大金额',
	`ddf_24m_rep_dte_neg_5_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后5日有动支的动支最小金额',
	`ddf_24m_rep_dte_neg_5_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且后5日有动支的应还金额',
	`ddf_24m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且后5日有动支的总动支金额与应还金额的占比',
	`ddf_24m_rep_dte_neg_7_crt_dt_ord_cnt` BIGINT COMMENT '历史最近24m天内应还日且后7日有动支的动支笔数',
	`ddf_24m_rep_dte_neg_7_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近24m天内应还日且后7日有动支的动支总金额',
	`ddf_24m_rep_dte_neg_7_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近24m天内应还日且后7日有动支的动支平均金额',
	`ddf_24m_rep_dte_neg_7_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后7日有动支的动支最大金额',
	`ddf_24m_rep_dte_neg_7_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近24m天内应还日且后7日有动支的动支最小金额',
	`ddf_24m_rep_dte_neg_7_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近24m天内应还日且后7日有动支的应还金额',
	`ddf_24m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近24m天内应还日且后7日有动支的总动支金额与应还金额的占比',

        `ddf_36m_rep_dte_neg_1_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且后1日有动支的动支笔数',
	`ddf_36m_rep_dte_neg_1_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且后1日有动支的动支总金额',
	`ddf_36m_rep_dte_neg_1_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且后1日有动支的动支平均金额',
	`ddf_36m_rep_dte_neg_1_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后1日有动支的动支最大金额',
	`ddf_36m_rep_dte_neg_1_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后1日有动支的动支最小金额',
	`ddf_36m_rep_dte_neg_1_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且后1日有动支的应还金额',
	`ddf_36m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且后1日有动支的总动支金额与应还金额的占比',
	`ddf_36m_rep_dte_neg_3_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且后3日有动支的动支笔数',
	`ddf_36m_rep_dte_neg_3_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且后3日有动支的动支总金额',
	`ddf_36m_rep_dte_neg_3_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且后3日有动支的动支平均金额',
	`ddf_36m_rep_dte_neg_3_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后3日有动支的动支最大金额',
	`ddf_36m_rep_dte_neg_3_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后3日有动支的动支最小金额',
	`ddf_36m_rep_dte_neg_3_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且后3日有动支的应还金额',
	`ddf_36m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且后3日有动支的总动支金额与应还金额的占比',
	`ddf_36m_rep_dte_neg_5_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且后5日有动支的动支笔数',
	`ddf_36m_rep_dte_neg_5_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且后5日有动支的动支总金额',
	`ddf_36m_rep_dte_neg_5_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且后5日有动支的动支平均金额',
	`ddf_36m_rep_dte_neg_5_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后5日有动支的动支最大金额',
	`ddf_36m_rep_dte_neg_5_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后5日有动支的动支最小金额',
	`ddf_36m_rep_dte_neg_5_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且后5日有动支的应还金额',
	`ddf_36m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且后5日有动支的总动支金额与应还金额的占比',
	`ddf_36m_rep_dte_neg_7_crt_dt_ord_cnt` BIGINT COMMENT '历史最近36m天内应还日且后7日有动支的动支笔数',
	`ddf_36m_rep_dte_neg_7_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史最近36m天内应还日且后7日有动支的动支总金额',
	`ddf_36m_rep_dte_neg_7_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史最近36m天内应还日且后7日有动支的动支平均金额',
	`ddf_36m_rep_dte_neg_7_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后7日有动支的动支最大金额',
	`ddf_36m_rep_dte_neg_7_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史最近36m天内应还日且后7日有动支的动支最小金额',
	`ddf_36m_rep_dte_neg_7_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史最近36m天内应还日且后7日有动支的应还金额',
	`ddf_36m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史最近36m天内应还日且后7日有动支的总动支金额与应还金额的占比',

        `ddf_rep_dte_neg_1_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且后1日有动支的动支笔数',
	`ddf_rep_dte_neg_1_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且后1日有动支的动支总金额',
	`ddf_rep_dte_neg_1_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且后1日有动支的动支平均金额',
	`ddf_rep_dte_neg_1_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后1日有动支的动支最大金额',
	`ddf_rep_dte_neg_1_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后1日有动支的动支最小金额',
	`ddf_rep_dte_neg_1_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且后1日有动支的应还金额',
	`ddf_rep_dte_neg_1_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且后1日有动支的总动支金额与应还金额的占比',
	`ddf_rep_dte_neg_3_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且后3日有动支的动支笔数',
	`ddf_rep_dte_neg_3_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且后3日有动支的动支总金额',
	`ddf_rep_dte_neg_3_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且后3日有动支的动支平均金额',
	`ddf_rep_dte_neg_3_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后3日有动支的动支最大金额',
	`ddf_rep_dte_neg_3_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后3日有动支的动支最小金额',
	`ddf_rep_dte_neg_3_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且后3日有动支的应还金额',
	`ddf_rep_dte_neg_3_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且后3日有动支的总动支金额与应还金额的占比',
	`ddf_rep_dte_neg_5_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且后5日有动支的动支笔数',
	`ddf_rep_dte_neg_5_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且后5日有动支的动支总金额',
	`ddf_rep_dte_neg_5_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且后5日有动支的动支平均金额',
	`ddf_rep_dte_neg_5_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后5日有动支的动支最大金额',
	`ddf_rep_dte_neg_5_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后5日有动支的动支最小金额',
	`ddf_rep_dte_neg_5_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且后5日有动支的应还金额',
	`ddf_rep_dte_neg_5_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且后5日有动支的总动支金额与应还金额的占比',
	`ddf_rep_dte_neg_7_crt_dt_ord_cnt` BIGINT COMMENT '历史至今应还日且后7日有动支的动支笔数',
	`ddf_rep_dte_neg_7_crt_dt_sum_prc_amt` DECIMAL(28, 6) COMMENT '历史至今应还日且后7日有动支的动支总金额',
	`ddf_rep_dte_neg_7_crt_dt_avg_prc_amt` DECIMAL(38, 16) COMMENT '历史至今应还日且后7日有动支的动支平均金额',
	`ddf_rep_dte_neg_7_crt_dt_max_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后7日有动支的动支最大金额',
	`ddf_rep_dte_neg_7_crt_dt_min_prc_amt` DECIMAL(18, 6) COMMENT '历史至今应还日且后7日有动支的动支最小金额',
	`ddf_rep_dte_neg_7_crt_dt_rep_prc_amt` DECIMAL(38, 6) COMMENT '历史至今应还日且后7日有动支的应还金额',
	`ddf_rep_dte_neg_7_crt_dt_rep_prc_amt_rto` DECIMAL(38, 10) COMMENT '历史至今应还日且后7日有动支的总动支金额与应还金额的占比'


)
PARTITIONED BY (
	`ds` STRING COMMENT '分区字段格式yyyymmdd'
);




drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_new_${bizdate}; 
create table ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_new_${bizdate} as 
select 
         main.uid
        ,main.mdl_dte
        ,main.dtl_rep_dte
        ,main.ddf_mdl_rep_dte
        ,main.his_rep_stg_pln_1m_flg
        ,main.his_rep_stg_pln_3m_flg
        ,main.his_rep_stg_pln_6m_flg
        ,main.his_rep_stg_pln_12m_flg
        --我新加的
        ,main.his_rep_stg_pln_24m_flg
        ,main.his_rep_stg_pln_36m_flg
        ,main.his_rep_stg_pln_flg

        ,main.rep_prc_amt -- 到期应还金额
        ,main.rep_dte_rn
        ,main.ddf_rep_dte_ord_crt_tim  -- 借款时间和应还日差
        ,main.rct_dtl_ord_no -- 每笔分期计划近期（前后7天内）的order_no
        ,main.crt_tim
        ,main.prc_amt
        ,main.stg_num
        ,main.ord_stt_flg

        -- 到期应还日之前的时间切片（当天、过去1/3/5/7天）
        ,case when ddf_rep_dte_ord_crt_tim = 0 then 1 else 0 end as ddf_0_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 1 then 1 else 0 end as ddf_1_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 3 then 1 else 0 end as ddf_3_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 5 then 1 else 0 end as ddf_5_flg
        ,case when ddf_rep_dte_ord_crt_tim between 0 and 7 then 1 else 0 end as ddf_7_flg
        
        ,case when ddf_rep_dte_ord_crt_tim between -1 and 0 then 1 else 0 end as ddf_neg_1_flg
        ,case when ddf_rep_dte_ord_crt_tim between -3 and 0 then 1 else 0 end as ddf_neg_3_flg
        ,case when ddf_rep_dte_ord_crt_tim between -5 and 0 then 1 else 0 end as ddf_neg_5_flg
        ,case when ddf_rep_dte_ord_crt_tim between -7 and 0 then 1 else 0 end as ddf_neg_7_flg

from 
        (select 
                plan.uid
                ,plan.mdl_dte
                ,plan.dtl_rep_dte
                ,plan.ddf_mdl_rep_dte
                ,plan.his_rep_stg_pln_1m_flg
                ,plan.his_rep_stg_pln_3m_flg
                ,plan.his_rep_stg_pln_6m_flg
                ,plan.his_rep_stg_pln_12m_flg
                --我新加的
                ,plan.his_rep_stg_pln_24m_flg
                ,plan.his_rep_stg_pln_36m_flg
                ,plan.his_rep_stg_pln_flg

                ,plan.rep_prc_amt -- 到期应还金额
                ,plan.rep_dte_rn
                ,datediff(date(plan.dtl_rep_dte),date(order_info.crt_tim)) as ddf_rep_dte_ord_crt_tim  -- 借款时间和应还日差
                ,order_info.rct_dtl_ord_no -- 每笔分期计划近期（前后7天内）的order_no
                ,order_info.crt_tim
                ,order_info.prc_amt
                ,order_info.stg_num
                ,order_info.ord_stt_flg
        from    (select uid
                        ,mdl_dte
                        ,dtl_rep_dte
                        ,ddf_mdl_rep_dte
                        ,his_rep_stg_pln_1m_flg
                        ,his_rep_stg_pln_3m_flg
                        ,his_rep_stg_pln_6m_flg
                        ,his_rep_stg_pln_12m_flg
                        --我新加的
                        ,his_rep_stg_pln_24m_flg
                        ,his_rep_stg_pln_36m_flg
                        ,his_rep_stg_pln_flg

                        ,sum(prc_amt) as rep_prc_amt -- 到期应还金额
                        , dense_rank() over(partition by uid order by dtl_rep_dte desc) rep_dte_rn
                from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_detail_new
                where is_his_rep_stg_pln = 1 -- 历史应还分期计划
                and ovd_rep_flg = 0  -- 未逾期 **** 即应还日 == 实还日 -- todo：一般化
                and ddf_mdl_rep_dte >= 1
                and ds = '${bizdate}'
                group by uid
                        ,mdl_dte
                        ,dtl_rep_dte
                        ,ddf_mdl_rep_dte
                        ,his_rep_stg_pln_1m_flg
                        ,his_rep_stg_pln_3m_flg
                        ,his_rep_stg_pln_6m_flg
                        ,his_rep_stg_pln_12m_flg
                        --我新加的
                        ,his_rep_stg_pln_24m_flg
                        ,his_rep_stg_pln_36m_flg
                        ,his_rep_stg_pln_flg
                ) plan
                left join 
                (select uid
                        ,mdl_dte
                        ,dtl_ord_no as rct_dtl_ord_no
                        ,crt_tim
                        ,prc_amt
                        ,stg_num
                        ,ord_stt_flg
                from  ${dwa_risk}.dwa_risk_f_heavy_order_info_detail_new-- 历史交易订单（成功）
                where ord_stt_flg in ('success')
                and ds = '${bizdate}'
                ) order_info 
                on order_info.uid=plan.uid
        where datediff(date(order_info.crt_tim),date(plan.dtl_rep_dte)) between -7 and 7  -- 每笔分期计划近期（前后7天内）的order_no
        )main;



drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2_new_${bizdate};
create table ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2_new_${bizdate} as
select
  uid
  ,mdl_dte
-- features range start --
  -- 交易笔数、金额、件均、最大、最低，金额/当前应还比例；
  -- 还款日前及当天的动支
  
  -- his_rep_stg_pln_24m_flg = 1
  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_7_crt_dt_rep_prc_amt

  -- his_rep_stg_pln_36m_flg = 1
  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_7_crt_dt_rep_prc_amt

  -- his_rep_stg_pln_flg = 1
  ,count(case when his_rep_stg_pln_flg = 1 and ddf_0_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_0_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_0_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_0_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_0_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_0_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_0_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_0_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_flg = 1 and ddf_1_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_1_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_1_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_flg = 1 and ddf_3_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_3_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_3_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_flg = 1 and ddf_5_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_5_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_5_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_flg = 1 and ddf_7_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_7_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_7_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_7_crt_dt_rep_prc_amt
  
  
  -- 还款日后的动支
  
  -- his_rep_stg_pln_24m_flg = 1
  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as ddf_24m_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_24m_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_24m_flg = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as ddf_24m_rep_dte_neg_7_crt_dt_rep_prc_amt

  -- his_rep_stg_pln_36m_flg = 1
  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as ddf_36m_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_36m_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_36m_flg = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as ddf_36m_rep_dte_neg_7_crt_dt_rep_prc_amt

  -- his_rep_stg_pln_flg = 1
  ,count(case when his_rep_stg_pln_flg = 1 and ddf_neg_1_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_neg_1_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_1_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_1_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_neg_1_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_1_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_1_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_neg_1_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_flg = 1 and ddf_neg_3_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_neg_3_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_3_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_3_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_neg_3_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_3_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_3_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_neg_3_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_flg = 1 and ddf_neg_5_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_neg_5_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_5_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_5_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_neg_5_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_5_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_5_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_neg_5_crt_dt_rep_prc_amt

  ,count(case when his_rep_stg_pln_flg = 1 and ddf_neg_7_flg = 1 then rct_dtl_ord_no end) as ddf_rep_dte_neg_7_crt_dt_ord_cnt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_7_crt_dt_sum_prc_amt
  ,max(case when his_rep_stg_pln_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_7_crt_dt_max_prc_amt
  ,min(case when his_rep_stg_pln_flg = 1 and ddf_neg_7_flg = 1 then prc_amt else 0 end) as ddf_rep_dte_neg_7_crt_dt_min_prc_amt
  ,sum(case when his_rep_stg_pln_flg = 1 and ddf_neg_7_flg = 1 then rep_prc_amt else 0 end) as ddf_rep_dte_neg_7_crt_dt_rep_prc_amt

  
from ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_new_${bizdate}

group by uid, mdl_dte;








insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_new_df partition(ds='${bizdate}')  
select model_data.uid
        ,model_data.mdl_dte
-- features range start --
    ,coalesce( ddf_24m_rep_dte_0_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_0_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_0_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_0_crt_dt_sum_prc_amt / ddf_24m_rep_dte_0_crt_dt_ord_cnt as ddf_24m_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_0_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_0_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_0_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_0_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_0_crt_dt_sum_prc_amt / ddf_24m_rep_dte_0_crt_dt_rep_prc_amt as ddf_24m_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_24m_rep_dte_1_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_1_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_1_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_1_crt_dt_sum_prc_amt / ddf_24m_rep_dte_1_crt_dt_ord_cnt as ddf_24m_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_1_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_1_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_1_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_1_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_1_crt_dt_sum_prc_amt / ddf_24m_rep_dte_1_crt_dt_rep_prc_amt as ddf_24m_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_24m_rep_dte_3_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_3_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_3_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_3_crt_dt_sum_prc_amt / ddf_24m_rep_dte_3_crt_dt_ord_cnt as ddf_24m_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_3_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_3_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_3_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_3_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_3_crt_dt_sum_prc_amt / ddf_24m_rep_dte_3_crt_dt_rep_prc_amt as ddf_24m_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_24m_rep_dte_5_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_5_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_5_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_5_crt_dt_sum_prc_amt / ddf_24m_rep_dte_5_crt_dt_ord_cnt as ddf_24m_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_5_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_5_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_5_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_5_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_5_crt_dt_sum_prc_amt / ddf_24m_rep_dte_5_crt_dt_rep_prc_amt as ddf_24m_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_24m_rep_dte_7_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_7_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_7_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_7_crt_dt_sum_prc_amt / ddf_24m_rep_dte_7_crt_dt_ord_cnt as ddf_24m_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_7_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_7_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_7_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_7_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_7_crt_dt_sum_prc_amt / ddf_24m_rep_dte_7_crt_dt_rep_prc_amt as ddf_24m_rep_dte_7_crt_dt_rep_prc_amt_rto

---36m---
    ,coalesce( ddf_36m_rep_dte_0_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_0_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_0_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_0_crt_dt_sum_prc_amt / ddf_36m_rep_dte_0_crt_dt_ord_cnt as ddf_36m_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_0_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_0_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_0_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_0_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_0_crt_dt_sum_prc_amt / ddf_36m_rep_dte_0_crt_dt_rep_prc_amt as ddf_36m_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_36m_rep_dte_1_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_1_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_1_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_1_crt_dt_sum_prc_amt / ddf_36m_rep_dte_1_crt_dt_ord_cnt as ddf_36m_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_1_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_1_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_1_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_1_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_1_crt_dt_sum_prc_amt / ddf_36m_rep_dte_1_crt_dt_rep_prc_amt as ddf_36m_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_36m_rep_dte_3_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_3_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_3_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_3_crt_dt_sum_prc_amt / ddf_36m_rep_dte_3_crt_dt_ord_cnt as ddf_36m_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_3_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_3_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_3_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_3_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_3_crt_dt_sum_prc_amt / ddf_36m_rep_dte_3_crt_dt_rep_prc_amt as ddf_36m_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_36m_rep_dte_5_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_5_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_5_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_5_crt_dt_sum_prc_amt / ddf_36m_rep_dte_5_crt_dt_ord_cnt as ddf_36m_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_5_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_5_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_5_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_5_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_5_crt_dt_sum_prc_amt / ddf_36m_rep_dte_5_crt_dt_rep_prc_amt as ddf_36m_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_36m_rep_dte_7_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_7_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_7_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_7_crt_dt_sum_prc_amt / ddf_36m_rep_dte_7_crt_dt_ord_cnt as ddf_36m_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_7_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_7_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_7_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_7_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_7_crt_dt_sum_prc_amt / ddf_36m_rep_dte_7_crt_dt_rep_prc_amt as ddf_36m_rep_dte_7_crt_dt_rep_prc_amt_rto

---all---
    ,coalesce( ddf_rep_dte_0_crt_dt_ord_cnt,0) as ddf_rep_dte_0_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_0_crt_dt_sum_prc_amt,0) as ddf_rep_dte_0_crt_dt_sum_prc_amt
    ,ddf_rep_dte_0_crt_dt_sum_prc_amt / ddf_rep_dte_0_crt_dt_ord_cnt as ddf_rep_dte_0_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_0_crt_dt_max_prc_amt,0) as ddf_rep_dte_0_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_0_crt_dt_min_prc_amt,0) as ddf_rep_dte_0_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_0_crt_dt_rep_prc_amt,0) as ddf_rep_dte_0_crt_dt_rep_prc_amt
    ,ddf_rep_dte_0_crt_dt_sum_prc_amt / ddf_rep_dte_0_crt_dt_rep_prc_amt as ddf_rep_dte_0_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_rep_dte_1_crt_dt_ord_cnt,0) as ddf_rep_dte_1_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_1_crt_dt_sum_prc_amt,0) as ddf_rep_dte_1_crt_dt_sum_prc_amt
    ,ddf_rep_dte_1_crt_dt_sum_prc_amt / ddf_rep_dte_1_crt_dt_ord_cnt as ddf_rep_dte_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_1_crt_dt_max_prc_amt,0) as ddf_rep_dte_1_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_1_crt_dt_min_prc_amt,0) as ddf_rep_dte_1_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_1_crt_dt_rep_prc_amt,0) as ddf_rep_dte_1_crt_dt_rep_prc_amt
    ,ddf_rep_dte_1_crt_dt_sum_prc_amt / ddf_rep_dte_1_crt_dt_rep_prc_amt as ddf_rep_dte_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_rep_dte_3_crt_dt_ord_cnt,0) as ddf_rep_dte_3_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_3_crt_dt_sum_prc_amt,0) as ddf_rep_dte_3_crt_dt_sum_prc_amt
    ,ddf_rep_dte_3_crt_dt_sum_prc_amt / ddf_rep_dte_3_crt_dt_ord_cnt as ddf_rep_dte_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_3_crt_dt_max_prc_amt,0) as ddf_rep_dte_3_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_3_crt_dt_min_prc_amt,0) as ddf_rep_dte_3_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_3_crt_dt_rep_prc_amt,0) as ddf_rep_dte_3_crt_dt_rep_prc_amt
    ,ddf_rep_dte_3_crt_dt_sum_prc_amt / ddf_rep_dte_3_crt_dt_rep_prc_amt as ddf_rep_dte_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_rep_dte_5_crt_dt_ord_cnt,0) as ddf_rep_dte_5_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_5_crt_dt_sum_prc_amt,0) as ddf_rep_dte_5_crt_dt_sum_prc_amt
    ,ddf_rep_dte_5_crt_dt_sum_prc_amt / ddf_rep_dte_5_crt_dt_ord_cnt as ddf_rep_dte_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_5_crt_dt_max_prc_amt,0) as ddf_rep_dte_5_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_5_crt_dt_min_prc_amt,0) as ddf_rep_dte_5_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_5_crt_dt_rep_prc_amt,0) as ddf_rep_dte_5_crt_dt_rep_prc_amt
    ,ddf_rep_dte_5_crt_dt_sum_prc_amt / ddf_rep_dte_5_crt_dt_rep_prc_amt as ddf_rep_dte_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_rep_dte_7_crt_dt_ord_cnt,0) as ddf_rep_dte_7_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_7_crt_dt_sum_prc_amt,0) as ddf_rep_dte_7_crt_dt_sum_prc_amt
    ,ddf_rep_dte_7_crt_dt_sum_prc_amt / ddf_rep_dte_7_crt_dt_ord_cnt as ddf_rep_dte_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_7_crt_dt_max_prc_amt,0) as ddf_rep_dte_7_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_7_crt_dt_min_prc_amt,0) as ddf_rep_dte_7_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_7_crt_dt_rep_prc_amt,0) as ddf_rep_dte_7_crt_dt_rep_prc_amt
    ,ddf_rep_dte_7_crt_dt_sum_prc_amt / ddf_rep_dte_7_crt_dt_rep_prc_amt as ddf_rep_dte_7_crt_dt_rep_prc_amt_rto

-----第二部分
    ,coalesce( ddf_24m_rep_dte_neg_1_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_1_crt_dt_ord_cnt as ddf_24m_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_1_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_1_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_1_crt_dt_rep_prc_amt as ddf_24m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_24m_rep_dte_neg_3_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_3_crt_dt_ord_cnt as ddf_24m_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_3_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_3_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_3_crt_dt_rep_prc_amt as ddf_24m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_24m_rep_dte_neg_5_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_5_crt_dt_ord_cnt as ddf_24m_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_5_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_5_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_5_crt_dt_rep_prc_amt as ddf_24m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_24m_rep_dte_neg_7_crt_dt_ord_cnt,0) as ddf_24m_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( ddf_24m_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as ddf_24m_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,ddf_24m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_7_crt_dt_ord_cnt as ddf_24m_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_7_crt_dt_max_prc_amt,0) as ddf_24m_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_7_crt_dt_min_prc_amt,0) as ddf_24m_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( ddf_24m_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as ddf_24m_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,ddf_24m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_24m_rep_dte_neg_7_crt_dt_rep_prc_amt as ddf_24m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

---36m---
    ,coalesce( ddf_36m_rep_dte_neg_1_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_1_crt_dt_ord_cnt as ddf_36m_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_1_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_1_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_1_crt_dt_rep_prc_amt as ddf_36m_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_36m_rep_dte_neg_3_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_3_crt_dt_ord_cnt as ddf_36m_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_3_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_3_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_3_crt_dt_rep_prc_amt as ddf_36m_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_36m_rep_dte_neg_5_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_5_crt_dt_ord_cnt as ddf_36m_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_5_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_5_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_5_crt_dt_rep_prc_amt as ddf_36m_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_36m_rep_dte_neg_7_crt_dt_ord_cnt,0) as ddf_36m_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( ddf_36m_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as ddf_36m_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,ddf_36m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_7_crt_dt_ord_cnt as ddf_36m_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_7_crt_dt_max_prc_amt,0) as ddf_36m_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_7_crt_dt_min_prc_amt,0) as ddf_36m_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( ddf_36m_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as ddf_36m_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,ddf_36m_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_36m_rep_dte_neg_7_crt_dt_rep_prc_amt as ddf_36m_rep_dte_neg_7_crt_dt_rep_prc_amt_rto

---all---
    ,coalesce( ddf_rep_dte_neg_1_crt_dt_ord_cnt,0) as ddf_rep_dte_neg_1_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_neg_1_crt_dt_sum_prc_amt,0) as ddf_rep_dte_neg_1_crt_dt_sum_prc_amt
    ,ddf_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_rep_dte_neg_1_crt_dt_ord_cnt as ddf_rep_dte_neg_1_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_neg_1_crt_dt_max_prc_amt,0) as ddf_rep_dte_neg_1_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_neg_1_crt_dt_min_prc_amt,0) as ddf_rep_dte_neg_1_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_neg_1_crt_dt_rep_prc_amt,0) as ddf_rep_dte_neg_1_crt_dt_rep_prc_amt
    ,ddf_rep_dte_neg_1_crt_dt_sum_prc_amt / ddf_rep_dte_neg_1_crt_dt_rep_prc_amt as ddf_rep_dte_neg_1_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_rep_dte_neg_3_crt_dt_ord_cnt,0) as ddf_rep_dte_neg_3_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_neg_3_crt_dt_sum_prc_amt,0) as ddf_rep_dte_neg_3_crt_dt_sum_prc_amt
    ,ddf_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_rep_dte_neg_3_crt_dt_ord_cnt as ddf_rep_dte_neg_3_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_neg_3_crt_dt_max_prc_amt,0) as ddf_rep_dte_neg_3_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_neg_3_crt_dt_min_prc_amt,0) as ddf_rep_dte_neg_3_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_neg_3_crt_dt_rep_prc_amt,0) as ddf_rep_dte_neg_3_crt_dt_rep_prc_amt
    ,ddf_rep_dte_neg_3_crt_dt_sum_prc_amt / ddf_rep_dte_neg_3_crt_dt_rep_prc_amt as ddf_rep_dte_neg_3_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_rep_dte_neg_5_crt_dt_ord_cnt,0) as ddf_rep_dte_neg_5_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_neg_5_crt_dt_sum_prc_amt,0) as ddf_rep_dte_neg_5_crt_dt_sum_prc_amt
    ,ddf_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_rep_dte_neg_5_crt_dt_ord_cnt as ddf_rep_dte_neg_5_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_neg_5_crt_dt_max_prc_amt,0) as ddf_rep_dte_neg_5_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_neg_5_crt_dt_min_prc_amt,0) as ddf_rep_dte_neg_5_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_neg_5_crt_dt_rep_prc_amt,0) as ddf_rep_dte_neg_5_crt_dt_rep_prc_amt
    ,ddf_rep_dte_neg_5_crt_dt_sum_prc_amt / ddf_rep_dte_neg_5_crt_dt_rep_prc_amt as ddf_rep_dte_neg_5_crt_dt_rep_prc_amt_rto

    ,coalesce( ddf_rep_dte_neg_7_crt_dt_ord_cnt,0) as ddf_rep_dte_neg_7_crt_dt_ord_cnt
    ,coalesce( ddf_rep_dte_neg_7_crt_dt_sum_prc_amt,0) as ddf_rep_dte_neg_7_crt_dt_sum_prc_amt
    ,ddf_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_rep_dte_neg_7_crt_dt_ord_cnt as ddf_rep_dte_neg_7_crt_dt_avg_prc_amt
    ,coalesce( ddf_rep_dte_neg_7_crt_dt_max_prc_amt,0) as ddf_rep_dte_neg_7_crt_dt_max_prc_amt
    ,coalesce( ddf_rep_dte_neg_7_crt_dt_min_prc_amt,0) as ddf_rep_dte_neg_7_crt_dt_min_prc_amt
    ,coalesce( ddf_rep_dte_neg_7_crt_dt_rep_prc_amt,0) as ddf_rep_dte_neg_7_crt_dt_rep_prc_amt
    ,ddf_rep_dte_neg_7_crt_dt_sum_prc_amt / ddf_rep_dte_neg_7_crt_dt_rep_prc_amt as ddf_rep_dte_neg_7_crt_dt_rep_prc_amt_rto



-- features range end --
from (select * from ${dwa_risk}.dwa_risk_f_dz_model_data_base_df where ds = '${bizdate}') model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2_new_${bizdate} temp_grouped 
on model_data.uid=temp_grouped.uid




drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_tmp1_new_${bizdate}; 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_16draw_repay_crossed_grouped_tmp2_new_${bizdate};
-- feature-copilot:node-end ordinal=0
