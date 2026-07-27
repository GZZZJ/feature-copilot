-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_lmt_list_lft_rep_tmp_new_di
-- node_id: n_6390760943894921217
-- task_name: dwa_risk_dz_model_lmt_list_lft_rep_tmp_new_di
-- owner_name: 王博韬
-- upstream_tables: dwa_risk.dwa_risk_f_heavy_stage_plan_basic, dwa_risk.dwa_risk_tmp_order_stage_account_union_ins_3y

CREATE TABLE if not EXISTS ${dwa_risk}.dwa_risk_dz_model_lmt_list_lft_rep_tmp_new_di
(
	`uid` STRING COMMENT '用户id',
	`biz_no` STRING COMMENT '业务流水号',
    `lft_rep_prc_1m_cash` STRING COMMENT '现金贷未来1个月剩余应还金额',
    `lft_rep_prc_1m_dcp` STRING COMMENT 'DCP未来1个月剩余应还金额',
    `lft_rep_prc_1m_hug` STRING COMMENT '大额贷未来1个月剩余应还金额',
    `lft_rep_prc_2m_cash` STRING COMMENT '现金贷未来2个月剩余应还金额',
    `lft_rep_prc_2m_dcp` STRING COMMENT 'DCP未来2个月剩余应还金额',
    `lft_rep_prc_2m_hug` STRING COMMENT '大额贷未来2个月剩余应还金额',
    `lft_rep_prc_3m_cash` STRING COMMENT '现金贷未来3个月剩余应还金额',
    `lft_rep_prc_3m_dcp` STRING COMMENT 'DCP未来3个月剩余应还金额',
    `lft_rep_prc_3m_hug` STRING COMMENT '大额贷未来3个月剩余应还金额',
    `lft_rep_prc_6m_cash` STRING COMMENT '现金贷未来6个月剩余应还金额',
    `lft_rep_prc_6m_dcp` STRING COMMENT 'DCP未来6个月剩余应还金额',
    `lft_rep_prc_6m_hug` STRING COMMENT '大额贷未来6个月剩余应还金额',
    `lft_rep_prc_all_cash` STRING COMMENT '现金贷未来剩余应还金额',
    `lft_rep_prc_all_dcp` STRING COMMENT 'DCP未来剩余应还金额',
    `lft_rep_prc_all_hug` STRING COMMENT '大额贷未来剩余应还金额'
)
COMMENT '额度使用率未来应还中间表'
PARTITIONED BY (`ds` STRING COMMENT '分区字段格式yyyymmdd');

INSERT OVERWRITE TABLE ${dwa_risk}.dwa_risk_dz_model_lmt_list_lft_rep_tmp_new_di partition(ds='${bizdate}')
select a.uid,biz_no,
  sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,1)) then b.prc_amt else 0 end) as lft_rep_prc_1m_cash,
  sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,1)) then b.prc_amt else 0 end) as lft_rep_prc_1m_dcp,
  sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,1)) then b.prc_amt else 0 end) as lft_rep_prc_1m_hug,
  sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_cash,
  sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_dcp,
  sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,2)) then b.prc_amt else 0 end) as lft_rep_prc_2m_hug,
  sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_cash,
  sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_dcp,
  sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,3)) then b.prc_amt else 0 end) as lft_rep_prc_3m_hug,
  sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_cash,
  sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_dcp,
  sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new and (rep_dte<=add_months(a.ds_new,6)) then b.prc_amt else 0 end) as lft_rep_prc_6m_hug,
  sum(case when b.bsy_typ in ('CASH','BALANCE_TRANSFER') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new then b.prc_amt else 0 end) as lft_rep_prc_all_cash,
  sum(case when b.bsy_typ in ('ENJOY_PAY') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new then b.prc_amt else 0 end) as lft_rep_prc_all_dcp,
  sum(case when b.bsy_typ in ('HUGE_LOAN') and (rep_tim is null or to_date(rep_tim)>a.ds_new) and to_date(b.ctr_tim)<a.ds_new then b.prc_amt else 0 end) as lft_rep_prc_all_hug
from (select *, TO_CHAR(TO_DATE(ds,'YYYYMMDD'),'YYYY-MM-DD') as ds_new from ${dwa_risk}.dwa_risk_tmp_order_stage_account_union_ins_3y where ds='${bizdate}') a
left join ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic b on a.uid=b.uid
group by a.uid,biz_no;
