-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_12payment_info_df
-- node_id: n_3787607757138624512
-- task_name: dwa_risk_dz_model_final_12payment_info_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_12payment_info_df.json
-- source_json_sha256: 793ca22c1bc9fc52bd61d00a34b0c75a845a2d1b47755fe9cf7c43c5ea9c0912
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_12payment_info
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_12payment_cardamount
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_12payment_hands_days
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_12payment_hands
-- upstream_table: dwa_risk.dwa_risk_dz_model_temp_12payment_hands_distinct_rsl
-- upstream_table: dwa_risk.dwa_risk_dz_model_12payment_info_tmp1
-- upstream_table: cdmx.cdmx_fct_heavy_loancore_offline_repayment_df
-- upstream_table: cdmx.cdmx_fct_heavy_payment_deduct_df

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的 ${pdm_risk}.pdm_risk_dz_model_final_12payment_info
--创建者: 颜弘彪
--创建日期: 2022-06-29 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

set odps.stage.num = 20;
set odps.sql.groupby.skewindata	= true;
drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_12payment_info;
create table if not exists ${dwa_risk}.dwa_risk_dz_model_temp_12payment_info as
select model_data.uid,date(model_data.mdl_dte) as mdl_dte,b.biz_srl,b.bnk_nam,b.crd_no,b.int_flg,b.trs_msg,b.trs_rsl,b.trs_amt,b.crt_tim as payment_tim
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join (
select uid as uid,deduct_bill_no as biz_srl,deduct_bank as bnk_nam,deduct_card_no_sha256 as crd_no,initiative_flag as int_flg,trans_message as trs_msg,trans_result as trs_rsl,amount - refund_amount as trs_amt,crt_time as crt_tim
from ${cdmx}.cdmx_fct_heavy_payment_deduct_df a where ds = '${bizdate}' and to_date(crt_time) between add_months(date_add(to_date('${bizdate}','yyyymmdd'),0),-7) and date_add(to_date('${bizdate}','yyyymmdd'),0) and nvl(third_party_channel,'') <> 'NowPay'
union all
select uid,null as biz_srl,null as bnk_nam,null as crd_no,'1' as int_flg,reject_reason as trs_msg,work_order_status as trs_rsl,repay_amount as trs_amt,create_time as crt_tim
from ${cdmx}.cdmx_fct_heavy_loancore_offline_repayment_df where ds = '${bizdate}' and to_date(create_time) between add_months(date_add(to_date('${bizdate}','yyyymmdd'),0),-7) and date_add(to_date('${bizdate}','yyyymmdd'),0)
) as b on model_data.uid = b.uid where to_date(b.crt_tim) < to_date(model_data.mdl_dte);

drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands;
create table ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands as
select uid,mdl_dte,
round(count(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_rsl = 'SUCCESS' and int_flg = 1 then 1 else NULL end) / count(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_rsl = 'SUCCESS' then 1 else NULL end),6) as pmt_hnd_cnt_rat_1m,
round(count(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_rsl = 'SUCCESS' and int_flg = 1 then 1 else NULL end) / count(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_rsl = 'SUCCESS' then 1 else NULL end),6) as pmt_hnd_cnt_rat_3m,
round(sum(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_rsl = 'SUCCESS' and int_flg = 1 then trs_amt else NULL end) / sum(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_rsl = 'SUCCESS' then trs_amt else NULL end),6) as pmt_hnd_amt_rat_1m,
round(sum(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_rsl = 'SUCCESS' and int_flg = 1 then trs_amt else NULL end) / sum(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_rsl = 'SUCCESS' then trs_amt else NULL end),6) as pmt_hnd_amt_rat_3m,
count(distinct case when date(payment_tim) >= add_months(mdl_dte,-1) and crd_no != '无' then crd_no else NULL end) as pmt_crd_nmb_1m,
count(distinct case when date(payment_tim) >= add_months(mdl_dte,-3) and crd_no != '无' then crd_no else NULL end) as pmt_crd_nmb_3m,
count(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_msg like '%余额不足%' then 1 else NULL end) as pmt_blc_not_eng_1m,
count(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_msg like '%余额不足%' then 1 else NULL end) as pmt_blc_not_eng_3m,
count(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_msg like '%余额不足%' then 1 else NULL end) as mid_1_pmt_blc_not_eng_rat_1m,
count(case when date(payment_tim) >= add_months(mdl_dte,-1) then 1 else NULL end) as mid_2_pmt_blc_not_eng_rat_1m,
round(count(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_msg like '%余额不足%' then 1 else NULL end) / count(case when date(payment_tim) >= add_months(mdl_dte,-1) then 1 else NULL end),6) as pmt_blc_not_eng_rat_1m,
count(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_msg like '%余额不足%' then 1 else NULL end) as mid_1_pmt_blc_not_eng_rat_3m,
count(case when date(payment_tim) >= add_months(mdl_dte,-3) then 1 else NULL end) as mid_2_pmt_blc_not_eng_rat_3m,
round(count(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_msg like '%余额不足%' then 1 else NULL end) / count(case when date(payment_tim) >= add_months(mdl_dte,-3) then 1 else NULL end),6) as pmt_blc_not_eng_rat_3m
from ${dwa_risk}.dwa_risk_dz_model_temp_12payment_info where date(payment_tim) between add_months(mdl_dte,-6) and mdl_dte group by uid,mdl_dte;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_12payment_info_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_12payment_info_tmp1 as 
select uid,mdl_dte,to_date(payment_tim) as payment_day,biz_srl,
case when trs_msg like '%余额不足%' then 1 when (trs_msg not like '%余额不足%') and (trs_rsl in ('FAILED','UNKNOWN')) then 2 when trs_rsl = 'SUCCESS' then 3 else 4 end as payment_flg
from ${dwa_risk}.dwa_risk_dz_model_temp_12payment_info where to_date(payment_tim) between add_months(mdl_dte,-6) and mdl_dte group by uid,mdl_dte,to_date(payment_tim),biz_srl,
case when trs_msg like '%余额不足%' then 1 when (trs_msg not like '%余额不足%') and (trs_rsl in ('FAILED','UNKNOWN')) then 2 when trs_rsl = 'SUCCESS' then 3 else 4 end;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_12payment_cardamount;
create table ${dwa_risk}.dwa_risk_dz_model_temp_12payment_cardamount as
select uid,mdl_dte,max(pmt_crd_amt_1m) as pmt_crd_amt_1m,max(pmt_crd_amt_3m) as pmt_crd_amt_3m,max(payment_cardamount_max_his) as pmt_crd_amt_pmonth_his,max(pmt_crd_amt_his) as pmt_crd_amt_his
from (select uid,mdl_dte,crd_no,sum(mid_pmt_crd_amt_1m) as pmt_crd_amt_1m,sum(mid_pmt_crd_amt_3m) as pmt_crd_amt_3m,sum(mid_pmt_crd_amt_his) as pmt_crd_amt_his,max(mid_pmt_crd_amt_his) as payment_cardamount_max_his
from (select uid,mdl_dte,crd_no,substr(payment_tim,1,7) as payment_month,
sum(case when date(payment_tim) >= add_months(mdl_dte,-1) and trs_rsl = 'SUCCESS' then trs_amt else 0 end) as mid_pmt_crd_amt_1m,
sum(case when date(payment_tim) >= add_months(mdl_dte,-3) and trs_rsl = 'SUCCESS' then trs_amt else 0 end) as mid_pmt_crd_amt_3m,
sum(case when trs_rsl = 'SUCCESS' then trs_amt else 0 end) as mid_pmt_crd_amt_his
from ${dwa_risk}.dwa_risk_dz_model_temp_12payment_info group by uid,mdl_dte,substr(payment_tim,1,7),crd_no) as a group by uid,mdl_dte,crd_no) as aa group by uid,mdl_dte;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands_days;
create table ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands_days as 
select uid,mdl_dte,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 1 then 1 else 0 end) as payment_balancenotenough_day_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 1 then 1 else 0 end) as payment_balancenotenough_day_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 1 then 1 else 0 end) as payment_balancenotenough_day_6m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 2 then 1 else 0 end) as payment_not_balancenotenough_day_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 2 then 1 else 0 end) as payment_not_balancenotenough_day_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 2 then 1 else 0 end) as payment_not_balancenotenough_day_6m,
count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-1)) then payment_day else NUll end) as payment_day_1m,
count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-3)) then payment_day else NUll end) as payment_day_3m,
count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-6)) then payment_day else NUll end) as payment_day_6m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 1 then 1 else 0 end) / count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-1)) then payment_day else NUll end) as payment_balancenotenough_day_rate_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 1 then 1 else 0 end) / count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-3)) then payment_day else NUll end) as payment_balancenotenough_day_rate_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 1 then 1 else 0 end) / count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-6)) then payment_day else NUll end) as payment_balancenotenough_day_rate_6m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 2 then 1 else 0 end) / count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-1)) then payment_day else NUll end) as payment_not_balancenotenough_day_rate_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 2 then 1 else 0 end) / count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-3)) then payment_day else NUll end) as payment_not_balancenotenough_day_rate_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 2 then 1 else 0 end) / count(distinct case when date(payment_day) >= date(add_months(mdl_dte,-6)) then payment_day else NUll end) as payment_not_balancenotenough_day_rate_6m
from (select uid,mdl_dte,payment_day,payment_flg from ${dwa_risk}.dwa_risk_dz_model_12payment_info_tmp1 group by uid,mdl_dte,payment_day,payment_flg) as a group by uid,mdl_dte;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands_distinct_rsl;
create table ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands_distinct_rsl as 
select uid,mdl_dte,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 1 then 1 else 0 end) as payment_balancenotenough_cnt_dis_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 1 then 1 else 0 end) as payment_balancenotenough_cnt_dis_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 1 then 1 else 0 end) as payment_balancenotenough_cnt_dis_6m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 2 then 1 else 0 end) as payment_not_balancenotenough_cnt_dis_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 2 then 1 else 0 end) as payment_not_balancenotenough_cnt_dis_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 2 then 1 else 0 end) as payment_not_balancenotenough_cnt_dis_6m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) then 1 else 0 end) as payment_cnt_dis_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) then 1 else 0 end) as payment_cnt_dis_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) then 1 else 0 end) as payment_cnt_dis_6m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 1 then 1 else 0 end) / sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) then 1 else 0 end) as payment_balancenotenough_dis_rate_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 1 then 1 else 0 end) / sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) then 1 else 0 end) as payment_balancenotenough_dis_rate_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 1 then 1 else 0 end) / sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) then 1 else 0 end) as payment_balancenotenough_dis_rate_6m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) and payment_flg = 2 then 1 else 0 end) / sum(case when date(payment_day) >= date(add_months(mdl_dte,-1)) then 1 else 0 end) as payment_not_balancenotenough_dis_rate_1m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) and payment_flg = 2 then 1 else 0 end) / sum(case when date(payment_day) >= date(add_months(mdl_dte,-3)) then 1 else 0 end) as payment_not_balancenotenough_dis_rate_3m,
sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) and payment_flg = 2 then 1 else 0 end) / sum(case when date(payment_day) >= date(add_months(mdl_dte,-6)) then 1 else 0 end) as payment_not_balancenotenough_dis_rate_6m
from (select uid,mdl_dte,payment_day,payment_flg,biz_srl from ${dwa_risk}.dwa_risk_dz_model_12payment_info_tmp1) as a group by uid,mdl_dte;

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_12payment_info_df partition(ds='${bizdate}') 
select model_data.uid,model_data.mdl_dte,
hands.pmt_hnd_cnt_rat_1m,hands.pmt_hnd_cnt_rat_3m,hands.pmt_hnd_amt_rat_1m,hands.pmt_hnd_amt_rat_3m,
coalesce(hands.pmt_crd_nmb_1m,0),coalesce(hands.pmt_crd_nmb_3m,0),coalesce(hands.pmt_blc_not_eng_1m,0),coalesce(hands.pmt_blc_not_eng_3m,0),
hands.mid_1_pmt_blc_not_eng_rat_1m,hands.mid_2_pmt_blc_not_eng_rat_1m,hands.pmt_blc_not_eng_rat_1m,hands.mid_1_pmt_blc_not_eng_rat_3m,hands.mid_2_pmt_blc_not_eng_rat_3m,hands.pmt_blc_not_eng_rat_3m,
coalesce(card.pmt_crd_amt_1m,0),coalesce(card.pmt_crd_amt_3m,0),coalesce(card.pmt_crd_amt_pmonth_his,0),coalesce(card.pmt_crd_amt_his,0),
coalesce(hands_days.payment_balancenotenough_day_1m,0),coalesce(hands_days.payment_balancenotenough_day_3m,0),coalesce(hands_days.payment_balancenotenough_day_6m,0),
coalesce(hands_days.payment_not_balancenotenough_day_1m,0),coalesce(hands_days.payment_not_balancenotenough_day_3m,0),coalesce(hands_days.payment_not_balancenotenough_day_6m,0),
coalesce(hands_days.payment_day_1m,0),coalesce(hands_days.payment_day_3m,0),coalesce(hands_days.payment_day_6m,0),
round(hands_days.payment_balancenotenough_day_rate_1m,6),round(hands_days.payment_balancenotenough_day_rate_3m,6),round(hands_days.payment_balancenotenough_day_rate_6m,6),
round(hands_days.payment_not_balancenotenough_day_rate_1m,6),round(hands_days.payment_not_balancenotenough_day_rate_3m,6),round(hands_days.payment_not_balancenotenough_day_rate_6m,6),
coalesce(rsl.payment_balancenotenough_cnt_dis_1m,0),coalesce(rsl.payment_balancenotenough_cnt_dis_3m,0),coalesce(rsl.payment_balancenotenough_cnt_dis_6m,0),
coalesce(rsl.payment_not_balancenotenough_cnt_dis_1m,0),coalesce(rsl.payment_not_balancenotenough_cnt_dis_3m,0),coalesce(rsl.payment_not_balancenotenough_cnt_dis_6m,0),
coalesce(rsl.payment_cnt_dis_1m,0),coalesce(rsl.payment_cnt_dis_3m,0),coalesce(rsl.payment_cnt_dis_6m,0),
round(rsl.payment_balancenotenough_dis_rate_1m,6),round(rsl.payment_balancenotenough_dis_rate_3m,6),round(rsl.payment_balancenotenough_dis_rate_6m,6),
round(rsl.payment_not_balancenotenough_dis_rate_1m,6),round(rsl.payment_not_balancenotenough_dis_rate_3m,6),round(rsl.payment_not_balancenotenough_dis_rate_6m,6)
from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands hands on model_data.uid=hands.uid
left join ${dwa_risk}.dwa_risk_dz_model_temp_12payment_cardamount card on model_data.uid=card.uid
left join ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands_days hands_days on model_data.uid=hands_days.uid
left join ${dwa_risk}.dwa_risk_dz_model_temp_12payment_hands_distinct_rsl rsl on model_data.uid=rsl.uid;
-- feature-copilot:node-end ordinal=0
