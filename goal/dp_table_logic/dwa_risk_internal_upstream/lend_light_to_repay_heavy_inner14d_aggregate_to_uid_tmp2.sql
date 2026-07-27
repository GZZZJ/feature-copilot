-- feature-copilot:node-begin ordinal=0
-- table_name: lend_light_to_repay_heavy_inner14d_aggregate_to_uid_tmp2
-- node_id: n_6922256996381753344
-- task_name: dwa_risk_dz_model_30light_cross_heavy_inner_behaviour_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_internal_upstream/lend_light_to_repay_heavy_inner14d_aggregate_to_uid_tmp2.json
-- source_json_sha256: b55bf4d93ad03400c3bd9e2577054f9f31147a9b534396f8e21806ae04c58b03
-- upstream_table: dwa_risk.cross_inner_behaviour_trade_dimension_qingzichan
-- upstream_table: dwa_risk.dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp
-- upstream_table: dwa_risk.dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_tmp
-- upstream_table: dwa.dwa_f_user_first_loan_df
-- upstream_table: dwa_risk.heavy_trade_behaviour_aggregate_to_uid_tmp
-- upstream_table: dwa_risk.light_his_all_shouxin_info_tmp
-- upstream_table: dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df
-- upstream_table: dwa_risk.dwa_risk_f_customer_credit_limit_basic_df
-- upstream_table: dwa_risk.cross_inner_behaviour_repay_debt_dimension_qingzichan
-- upstream_table: dwa_risk.light_repay_behaviour_aggregate_to_uid_tmp
-- upstream_table: dwa_risk.heavy_repay_behaviour_aggregate_to_uid_tmp
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic
-- upstream_table: cdmx.cdmx_fct_light_loan_order_df
-- upstream_table: cdmx.etl_cdmx_fct_light_stage_plan_df
-- upstream_table: cdmx.cdmx_fct_light_diversion_record_di
-- upstream_table: dwa_risk.light_repay_heavy_repay_credit_trade_cross_tmp
-- upstream_table: dwa_risk.light_fuzhai_heavy_fuzhai_cross_tmp
-- upstream_table: dwa_risk.light_trade_heavy_credit_trade_cross_tmp
-- upstream_table: dwa_risk.lend_light_to_repay_heavy_inner14d_aggregate_to_uid_tmp2
-- upstream_table: dwa_risk.light_heavy_credit_time_cross_tmp
-- upstream_table: dwa_risk.lend_heavy_to_repay_light_inner14d_aggregate_to_uid_tmp2
-- upstream_table: dwa_risk.light_upaid_principal_aggregate_to_uid_tmp
-- upstream_table: dwa_risk.lend_light_to_repay_heavy_inner14d_tmp
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.lend_heavy_to_repay_light_inner14d_tmp
-- upstream_table: dwa_risk.light_trade_behaviour_aggregate_to_uid_tmp

--********************************************************************--
--重资产行为，该部分中间表已经有任务产出：dwa_risk_dz_model_final_25_cross_inner_behaviour_df，直接使用现成结果即可
--********************************************************************--
-- 重资产原子表1:用户还款维度，样本表评分日前所有重资产应还分期（包含：正常按时还、逾期未还、逾期已还、未到期未还、未到期提前还）
-- dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_tmp，这里要做聚合到人维度上处理;
drop table if exists dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_tmp;
create table if not exists dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_tmp as
select  
         main2.uid
        ,main2.mdl_dte
        ,main2.dtl_ord_no -- 还款记录表所在订单号
        ,main2.dtl_stg_pln_no -- 还款记录表的分期号码
        ,main2.dtl_rep_dte -- 应还款日
        ,main2.rep_tim -- 实际还款日
        ,main2.prc_amt -- 应还本金
        ,main2.stg_no -- 期号

        --应还日和实还日之间的间隔（天）：用于判断逾期、提前、按时还款
        ,main2.ddf_rep_tim_dte 
        --实还日和评分日的间隔（天）：用于限定实还行为变量的窗口期
        ,main2.ddf_mdl_rep_tim
        --应还日和评分日的间隔（天）：用于限定应还行为变量的窗口期
        ,main2.ddf_mdl_rep_dte 

        --还款状态--flag
        --是否提前还款flag
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte<0 then '提前还款' -- 这样写的好处是即使评分日后的应还分期，如果在评分日前提前还了，也能计入
         when ddf_rep_tim_dte>0 then '逾期还款'
         when ddf_mdl_rep_dte>0 and ddf_rep_tim_dte=0 then '按时还款'
         when ddf_mdl_rep_dte<=0 then '未来应还（评分日T日及往后）'
         else '其他分期状态'
         end repay_status_main -- 还款状态主字段

        --逾期天数flag，后面作为限制条件。只用：1～3、4～14、15+、30+、60+、90+
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 1 and 3 then 1 else 0 end as ovd_1d_3d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 4 and 14 then 1 else 0 end as ovd_4d_14d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=15 then 1 else 0 end as ovd_15d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=30 then 1 else 0 end as ovd_1m_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=60 then 1 else 0 end as ovd_2m_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=90 then 1 else 0 end as ovd_3m_pls_flg

        --提前天数flag，后面作为限制条件。只用：<=3、<=15、<=30、<=60、<=90
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -3 and -1 then 1 else 0 end as adv_3d_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -15 and -1 then 1 else 0 end as adv_15d_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -30 and -1 then 1 else 0 end as adv_1m_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -60 and -1 then 1 else 0 end as adv_2m_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -90 and -1 then 1 else 0 end as adv_3m_minus_flg
from
        (select 
                main1.uid
                ,main1.mdl_dte
                ,main1.dtl_ord_no
                ,main1.dtl_stg_pln_no
                ,main1.dtl_rep_dte
                ,main1.rep_tim
                ,main1.prc_amt
                ,main1.stg_stt
                ,main1.stg_no

                --应还日和实还日之间的间隔（天），for判断逾期、提前、按时还款
                ,case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte)
                        else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte
                --实还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim
                --应还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte 
        from
                (select model_data.uid
                        ,model_data.mdl_dte
                        ,plan.dtl_ord_no
                        ,plan.dtl_stg_pln_no
                        ,plan.dtl_rep_dte
                        ,case when date(plan.rep_tim)>=model_data.mdl_dte then null else date(plan.rep_tim) end as rep_tim
                        ,plan.prc_amt
                        ,plan.stg_stt
                        ,plan.stg_no
                from    (
                        select  uid
                                ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                        from    dwa_risk.dwa_risk_f_dz_model_data_base
                        ) model_data

                        left join
                        (select uid
                                ,ord_no as dtl_ord_no -- 分期所在订单编号
                                ,stg_pln_no as dtl_stg_pln_no -- 分期计划编号
                                ,rep_dte as dtl_rep_dte -- 分期应还款日
                                ,rep_tim -- 分期结清时间
                                ,prc_amt -- 分期应还本金
                                ,stg_stt
                                ,stg_no -- 分期所在期数
                                ,ctr_tim
                        from dwa_risk.dwa_risk_f_heavy_stage_plan_basic
                        where bsy_typ in ('BALANCE_TRANSFER', 'CASH')
                        and stg_stt <> 'R' --分期计划状态，放款成功取<>'R'
                        ) plan on model_data.uid=plan.uid and date(mdl_dte) > date(ctr_tim)
                ) main1
        )main2
;
drop table if exists heavy_repay_behaviour_aggregate_to_uid_tmp;
create table if not exists heavy_repay_behaviour_aggregate_to_uid_tmp as
select uid,mdl_dte,
max(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_max_ontim_repay_amt, -- 历史最大单笔按时还款本金
max(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_max_ontim_repay_amt, -- 近90天最大按时还款本金
max(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_max_ontim_repay_amt, -- 近360天最大按时还款本金
max(case when repay_status_main = '按时还款' and  ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_max_ontim_repay_amt, -- 近720天最大按时还款本金
sum(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_sum_ontim_repay_amt, -- 历史按时还款本金sum
sum(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_sum_ontim_repay_amt, -- 近90天按时还款本金sum
sum(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_sum_ontim_repay_amt, -- 近360天按时还款本金sum
sum(case when repay_status_main = '按时还款' and  ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_sum_ontim_repay_amt, -- 近720天按时还款本金sum

max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 then prc_amt else null end) as his_max_adv_repay_amt, -- 历史最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 90 then prc_amt else null end) as d90_max_adv_repay_amt, -- 近90天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 360 then prc_amt else null end) as d360_max_adv_repay_amt, -- 近360天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 720 then prc_amt else null end) as d720_max_adv_repay_amt, -- 近720天最大单笔提前还款本金
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 then prc_amt else null end) as his_sum_adv_repay_amt, -- 历史提前还款本金sum
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 90 then prc_amt else null end) as d90_sum_adv_repay_amt, -- 近90天提前还款本金sum
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 360 then prc_amt else null end) as d360_sum_adv_repay_amt, -- 近360天提前还款本金sum
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 720 then prc_amt else null end) as d720_sum_adv_repay_amt, -- 近720天提前还款本金sum

max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_max_ovd_repay_amt, -- 历史最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_max_ovd_repay_amt, -- 近90天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_max_ovd_repay_amt, -- 近360天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_max_ovd_repay_amt, -- 近720天最大单笔逾期还款本金
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_sum_ovd_repay_amt, -- 历史逾期还款本金sum
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_sum_ovd_repay_amt, -- 近90天逾期还款本金sum
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_sum_ovd_repay_amt, -- 近360天逾期还款本金sum
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_sum_ovd_repay_amt, -- 近720天逾期还款本金sum
COLLECT_LIST(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '按时还款') as his_ontime_repay_date_list, -- transfer datetime to bigint datatype
COLLECT_LIST(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_repay_date_list, -- due repay date
COLLECT_LIST(cast(to_char(rep_tim,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_real_repay_date_list, -- real repay date
COLLECT_LIST(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '逾期还款') as his_overdue_repay_date_list, -- transfer datetime to bigint datatype
COLLECT_LIST(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '按时还款') as his_ontime_repay_date_month_list, -- transfer datemonth to bigint datatype
COLLECT_LIST(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_repay_date_month_list, -- due repay date month
COLLECT_LIST(cast(to_char(datetrunc(rep_tim,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_real_repay_date_month_list, -- real repay date month
COLLECT_LIST(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '逾期还款') as his_overdue_repay_date_month_list, -- transfer datemonth to bigint datatype
collect_list(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) as his_all_repay_due_date_list,
collect_list(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) as his_all_repay_due_date_month_list
from (
    select * from dwa_risk_cross_inner_behaviour_repay_dimension_analysis_sample_tmp where repay_status_main in ('提前还款','逾期还款','按时还款')
) basic
group by uid,mdl_dte;
-- 重资产原子笔2:用户历史交易维度，样本表评分日前所有重资产交易行为，交易状态：交易成功、交易失败均有
-- dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp，这里要做聚合到人维度上处理;
drop table if exists dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp;
create table if not exists dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp as
select  main.uid
        ,main.mdl_dte
        ,main.dtl_ord_no
        --订单创建时间（日期格式）
        ,main.crt_dte
        --订单创建时间（时间戳格式）
        ,main.crt_tim
        ,main.prc_amt
        ,main.fst_its_dte
        ,main.stg_num
        ,main.ord_stt_flg
        --间隔天数：用来限制借款行为的时间窗口期
        ,main.ddf_mdl_ord_crt_dte
        --订单创建时间，取两个最不一样的段，作为发起本金小于1000元_发起本金大于1w元_发生在同一个月_的次数_总和计算的基本
        ,case
                when hour(crt_tim) between 1 and 4  then '1到4点借款'
                when hour(crt_tim) between 8 and 11 then '8到11点借款'
                else '其他时间段借款'
        end as crt_hor_flg
        -- 本金区间，取两个最不一样的段，作为1到4点发起_8到11点发起_发生在同一个月_的次数_总和计算的基本
        ,case
                when prc_amt <= 1000  then '发起本金小于等于1000元'
                when prc_amt >= 10000 then '发起本金大于等于10000元'
                else '其他借款本金段'
        end as prc_amt_range_flg

from    (
            select  model_data.uid
                   ,model_data.mdl_dte
                   ,order_info.ord_no                                       as dtl_ord_no
                   --订单创建时间（日期格式）
                   ,order_info.crt_dte
                   --订单创建时间（时间戳格式）
                   ,order_info.crt_tim
                   ,order_info.prc_amt
                   ,order_info.fst_its_dte
                   ,order_info.stg_num
                   ,order_info.ord_stt_flg
                   --间隔天数
                   ,datediff(model_data.mdl_dte , date(order_info.crt_dte)) as ddf_mdl_ord_crt_dte
            from    (
    select  uid
            ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from    dwa_risk.dwa_risk_f_dz_model_data_base
                    ) model_data
            left join (
                          select  uid
                                 ,ord_no
                                 ,crt_tim
                                 ,date(crt_tim) as crt_dte
                                 ,prc_amt
                                 ,stg_num
                                 ,fst_its_dte
                                 ,ord_stt_flg
                          from    dwa_risk.dwa_risk_f_heavy_order_info_basic
                          where   bsy_typ in ( 'BALANCE_TRANSFER' , 'CASH' )  --('BALANCE_TRANSFER', 'CREDIT_TRANSACTION', 'CASH', 'HUGE_LOAN', 'ENJOY_PAY')
                      ) order_info
            on      model_data.uid = order_info.uid
            where   order_info.crt_tim < date(model_data.mdl_dte)  --在评分日之前的order信息
        ) main;
drop table if exists heavy_trade_behaviour_aggregate_to_uid_tmp;
create table if not exists heavy_trade_behaviour_aggregate_to_uid_tmp as
select uid,mdl_dte,
        max(case when ddf_mdl_ord_crt_dte > 0 then prc_amt else null end) as his_max_faqi_prc_amt, -- 历史最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then prc_amt else null end) as d90_max_faqi_prc_amt, -- 近90天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then prc_amt else null end) as d360_max_faqi_prc_amt, -- 近360天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then prc_amt else null end) as d720_max_faqi_prc_amt, -- 近720天最大单次发起借款本金

        sum(case when ddf_mdl_ord_crt_dte > 0 then prc_amt else null end) as his_sum_faqi_prc_amt, -- 历史发起借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then prc_amt else null end) as d90_sum_faqi_prc_amt, -- 近90天发起借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then prc_amt else null end) as d360_sum_faqi_prc_amt, -- 近360天发起借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then prc_amt else null end) as d720_sum_faqi_prc_amt, -- 近720天发起借款本金总和

        sum(case when ddf_mdl_ord_crt_dte > 0 then stg_num else null end) as his_sum_faqi_stg_num, -- 历史发起借款期数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then stg_num else null end) as d90_sum_faqi_stg_num, -- 近90天发起借款期数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then stg_num else null end) as d360_sum_faqi_stg_num, -- 近360天发起借款期数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then stg_num else null end) as d720_sum_faqi_stg_num, -- 近720天发起借款期数总和

        sum(case when ddf_mdl_ord_crt_dte > 0 then 1 else 0 end) as his_sum_faqi_count, -- 历史发起借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then 1 else 0 end) as d90_sum_faqi_count, -- 近90天发起借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then 1 else 0 end) as d360_sum_faqi_count, -- 近360天发起借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then 1 else 0 end) as d720_sum_faqi_count, -- 近720天发起借款笔数总和

        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' then 1 else 0 end) as his_sum_larger_than_1w_faqi_count, -- 历史发起金额大于1万元的借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' and ddf_mdl_ord_crt_dte <= 90 then 1 else 0 end) as d90_sum_larger_than_1w_faqi_count, -- 近90天发起金额大于1万元的借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' and ddf_mdl_ord_crt_dte <= 360 then 1 else 0 end) as d360_sum_larger_than_1w_faqi_count, -- 近360天发起金额大于1万元的借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' and ddf_mdl_ord_crt_dte <= 720 then 1 else 0 end) as d720_sum_larger_than_1w_faqi_count, -- 近720天发起金额大于1万元的借款笔数总和

        max(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = 'success' then prc_amt else null end) as his_max_suc_prc_amt, -- 历史最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = 'success' then prc_amt else null end) as d90_max_suc_prc_amt, -- 近90天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = 'success' then prc_amt else null end) as d360_max_suc_prc_amt, -- 近360天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = 'success' then prc_amt else null end) as d720_max_suc_prc_amt, -- 近720天最大单次成功借款本金

        sum(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = 'success' then prc_amt else null end) as his_sum_suc_prc_amt, -- 历史成功借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = 'success' then prc_amt else null end) as d90_sum_suc_prc_amt, -- 近90天成功借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = 'success' then prc_amt else null end) as d360_sum_suc_prc_amt, -- 近360天成功借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = 'success' then prc_amt else null end) as d720_sum_suc_prc_amt, -- 近720天成功借款本金总和

        max(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = 'fail' then prc_amt else null end) as his_max_fail_prc_amt, -- 历史最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = 'fail' then prc_amt else null end) as d90_max_fail_prc_amt, -- 近90天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = 'fail' then prc_amt else null end) as d360_max_fail_prc_amt, -- 近360天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = 'fail' then prc_amt else null end) as d720_max_fail_prc_amt, -- 近720天最大单次失败借款本金

        sum(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = 'fail' then prc_amt else null end) as his_sum_fail_prc_amt, -- 历史失败借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = 'fail' then prc_amt else null end) as d90_sum_fail_prc_amt, -- 近90天失败借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = 'fail' then prc_amt else null end) as d360_sum_fail_prc_amt, -- 近360天失败借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = 'fail' then prc_amt else null end) as d720_sum_fail_prc_amt, -- 近720天失败借款本金总和
        COLLECT_LIST(cast(to_char(crt_dte,'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = 'success') as his_success_order_date, -- transfer datetime to bigint datatype
        COLLECT_LIST(cast(to_char(crt_dte,'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = 'fail') as his_fail_order_date, -- transfer datetime to bigint datatype
        COLLECT_LIST(cast(to_char(datetrunc(date(crt_dte),'MM'),'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = 'success') as his_success_order_date_mon, -- transfer datemonth to bigint datatype
        COLLECT_LIST(cast(to_char(datetrunc(date(crt_dte),'MM'),'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = 'fail') as his_fail_order_date_mon -- transfer datemonth to bigint datatype

from dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp basic
group by uid,mdl_dte;
-- 重资产原子笔3:重资产未来应还，负债，每个时间切片均有
-- dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df;

--********************************************************************--
--轻资产行为，同样需要把授信、额度、交易、还款、负债这5大特征域衍生出来
--********************************************************************--
-- 1 轻资产授信、额度
drop table if exists light_his_all_shouxin_info_tmp;
create table if not exists light_his_all_shouxin_info_tmp as
select  uid
       ,mdl_dte
       ,sum(light_credit_limit)                 as qzc_sx_limit
       ,max(light_credit_limit) as qzc_sx_limit_max -- 20250513特征评审会Todo，加上最大值算子
       -- 20250513特征评审会Todo，加上窗口期限制
       ,sum(case when if_d90_tag = 1 then light_credit_limit else 0 end) as d90_qzc_sx_limit
       ,max(case when if_d90_tag = 1 then light_credit_limit else 0 end) as d90_qzc_sx_limit_max 
       ,sum(case when if_d360_tag = 1 then light_credit_limit else 0 end) as d360_qzc_sx_limit
       ,max(case when if_d360_tag = 1 then light_credit_limit else 0 end) as d360_qzc_sx_limit_max 
       ,sum(case when if_d720_tag = 1 then light_credit_limit else 0 end) as d720_qzc_sx_limit
       ,max(case when if_d720_tag = 1 then light_credit_limit else 0 end) as d720_qzc_sx_limit_max 
       ,COLLECT_LIST(fund_credit_time) as qzc_fund_time_list
       ,collect_list(fund_credit_mon) as qzc_fund_mon_list
       ,COLLECT_LIST(fund_credit_time_int_type) as qzc_fund_time_bigint_list
       ,collect_list(fund_credit_mon_int_type) as qzc_fund_mon_bigint_list   
from    (
            select  a.*
                   ,b.light_credit_limit
                   ,b.fund_credit_time
                   ,case when datediff(to_date(a.mdl_dte,'yyyy-mm-dd'),to_date(fund_credit_time,'yyyy-mm-dd')) between 1 and 90 then 1 else 0 end as if_d90_tag
                   ,case when datediff(to_date(a.mdl_dte,'yyyy-mm-dd'),to_date(fund_credit_time,'yyyy-mm-dd')) between 1 and 360 then 1 else 0 end as if_d360_tag
                   ,case when datediff(to_date(a.mdl_dte,'yyyy-mm-dd'),to_date(fund_credit_time,'yyyy-mm-dd')) between 1 and 720 then 1 else 0 end as if_d720_tag

                   ,substr(fund_credit_time,1,7) as fund_credit_mon
                    ,cast(to_char(to_date(fund_credit_time,'yyyy-mm-dd'),'yyyymmdd') as bigint) as fund_credit_time_int_type
                    ,cast(to_char(datetrunc(to_date(fund_credit_time,'yyyy-mm-dd'),'MM'),'yyyymmdd') as bigint) as fund_credit_mon_int_type
            from    (
    select  uid
            ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from    dwa_risk.dwa_risk_f_dz_model_data_base
                    ) a
            left join (
                          select  *
                          from    (
                                      select  uid
                                             ,light_credit_limit
                                             ,create_time
                                             ,to_char(date(fund_credit_time),'yyyy-mm-dd') as fund_credit_time -- 资方授信时间，后续看轻重资产是否在同一个月授信
                                             ,row_number() over ( partition by uid , fund_code , substr(create_time , 1 , 10) order by create_time asc ) as rnk  -- 一家资方会落多次授信结果，需要去重
                                      --  ,fund_code
                                      --  ,light_diversion_scene
                                      from    cdmx.cdmx_fct_light_diversion_record_di
                                      where   ds <= '${bizdate}'
                                      -- and     fund_code <> 'MSXF' -- 排除马上消费金融
                                      and     light_credit_status = '成功'
                                      and     fund_credit_time is not null
                                      and     substr(create_time , 1 , 10) <= substr(fund_credit_time , 1 , 10)
                                      and     light_credit_limit <> 0
                                  )
                          where   rnk = 1
                      ) b
            on      a.uid = b.uid
            and     date(a.mdl_dte) > date(b.create_time)
        )
group by uid
        ,mdl_dte;

-- 2 轻资产交易
drop table if exists cross_inner_behaviour_trade_dimension_qingzichan;
create table if not exists cross_inner_behaviour_trade_dimension_qingzichan as
select  main.uid
        ,main.mdl_dte
        ,main.dtl_ord_no
        --订单创建时间（日期格式）
        ,main.crt_dte
        --订单创建时间（时间戳格式）
        ,main.crt_tim
        ,main.prc_amt
        ,main.stg_num
        ,main.ord_stt_flg
        --间隔天数：用来限制借款行为的时间窗口期
        ,main.ddf_mdl_ord_crt_dte
        --订单创建时间，取两个最不一样的段，作为发起本金小于1000元_发起本金大于1w元_发生在同一个月_的次数_总和计算的基本
        ,case
                when hour(crt_tim) between 1 and 4  then '1到4点借款'
                when hour(crt_tim) between 8 and 11 then '8到11点借款'
                else '其他时间段借款'
        end as crt_hor_flg
        -- 本金区间，取两个最不一样的段，作为1到4点发起_8到11点发起_发生在同一个月_的次数_总和计算的基本
        ,case
                when prc_amt <= 1000  then '发起本金小于等于1000元'
                when prc_amt >= 10000 then '发起本金大于等于10000元'
                else '其他借款本金段'
        end as prc_amt_range_flg

from    (
            select  model_data.uid
                   ,model_data.mdl_dte
                   ,order_info.ord_no                                       as dtl_ord_no
                   --订单创建时间（日期格式）
                   ,order_info.crt_dte
                   ,order_info.crt_tim
                   --订单创建时间（时间戳格式）
                   ,order_info.prc_amt
                   ,order_info.stg_num
                   ,order_info.ord_stt_flg
                   --间隔天数
                   ,datediff(model_data.mdl_dte , date(order_info.crt_dte)) as ddf_mdl_ord_crt_dte
            from    (
    select  uid
            ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from    dwa_risk.dwa_risk_f_dz_model_data_base
                    ) model_data
            left join (
                          select  uid
                                 ,order_no as ord_no
                                 ,date(create_time) as crt_dte
                                 ,create_time as crt_tim
                                 ,loan_principal as prc_amt
                                 ,light_loan_stage as stg_num
                                 ,loan_success_flag as ord_stt_flg
                          from    cdmx.cdmx_fct_light_loan_order_df
                          where  ds = '${bizdate}'
                      ) order_info
            on      model_data.uid = order_info.uid
            where   order_info.crt_tim < date(model_data.mdl_dte)  --在评分日之前的order信息
        ) main;
-- 2.1 将历史的轻资产交易信息聚合到uid维度上
-- 计算维度：本金最大值、本金总计、期数总计、笔数、大金额（1万+）借款次数
drop table if exists light_trade_behaviour_aggregate_to_uid_tmp;
create table if not exists light_trade_behaviour_aggregate_to_uid_tmp as
select uid,mdl_dte,
        max(case when ddf_mdl_ord_crt_dte > 0 then prc_amt else null end) as his_max_faqi_prc_amt, -- 历史最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then prc_amt else null end) as d90_max_faqi_prc_amt, -- 近90天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then prc_amt else null end) as d360_max_faqi_prc_amt, -- 近360天最大单次发起借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then prc_amt else null end) as d720_max_faqi_prc_amt, -- 近720天最大单次发起借款本金

        sum(case when ddf_mdl_ord_crt_dte > 0 then prc_amt else null end) as his_sum_faqi_prc_amt, -- 历史发起借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then prc_amt else null end) as d90_sum_faqi_prc_amt, -- 近90天发起借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then prc_amt else null end) as d360_sum_faqi_prc_amt, -- 近360天发起借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then prc_amt else null end) as d720_sum_faqi_prc_amt, -- 近720天发起借款本金总和

        sum(case when ddf_mdl_ord_crt_dte > 0 then stg_num else null end) as his_sum_faqi_stg_num, -- 历史发起借款期数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then stg_num else null end) as d90_sum_faqi_stg_num, -- 近90天发起借款期数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then stg_num else null end) as d360_sum_faqi_stg_num, -- 近360天发起借款期数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then stg_num else null end) as d720_sum_faqi_stg_num, -- 近720天发起借款期数总和

        sum(case when ddf_mdl_ord_crt_dte > 0 then 1 else 0 end) as his_sum_faqi_count, -- 历史发起借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 then 1 else 0 end) as d90_sum_faqi_count, -- 近90天发起借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 then 1 else 0 end) as d360_sum_faqi_count, -- 近360天发起借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 then 1 else 0 end) as d720_sum_faqi_count, -- 近720天发起借款笔数总和

        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' then 1 else 0 end) as his_sum_larger_than_1w_faqi_count, -- 历史发起金额大于1万元的借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' and ddf_mdl_ord_crt_dte <= 90 then 1 else 0 end) as d90_sum_larger_than_1w_faqi_count, -- 近90天发起金额大于1万元的借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' and ddf_mdl_ord_crt_dte <= 360 then 1 else 0 end) as d360_sum_larger_than_1w_faqi_count, -- 近360天发起金额大于1万元的借款笔数总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and prc_amt_range_flg = '发起本金大于等于10000元' and ddf_mdl_ord_crt_dte <= 720 then 1 else 0 end) as d720_sum_larger_than_1w_faqi_count, -- 近720天发起金额大于1万元的借款笔数总和

        max(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = '1' then prc_amt else null end) as his_max_suc_prc_amt, -- 历史最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = '1' then prc_amt else null end) as d90_max_suc_prc_amt, -- 近90天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = '1' then prc_amt else null end) as d360_max_suc_prc_amt, -- 近360天最大单次成功借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = '1' then prc_amt else null end) as d720_max_suc_prc_amt, -- 近720天最大单次成功借款本金

        sum(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = '1' then prc_amt else null end) as his_sum_suc_prc_amt, -- 历史成功借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = '1' then prc_amt else null end) as d90_sum_suc_prc_amt, -- 近90天成功借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = '1' then prc_amt else null end) as d360_sum_suc_prc_amt, -- 近360天成功借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = '1' then prc_amt else null end) as d720_sum_suc_prc_amt, -- 近720天成功借款本金总和

        max(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = '0' then prc_amt else null end) as his_max_fail_prc_amt, -- 历史最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = '0' then prc_amt else null end) as d90_max_fail_prc_amt, -- 近90天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = '0' then prc_amt else null end) as d360_max_fail_prc_amt, -- 近360天最大单次失败借款本金
        max(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = '0' then prc_amt else null end) as d720_max_fail_prc_amt, -- 近720天最大单次失败借款本金

        sum(case when ddf_mdl_ord_crt_dte > 0 and ord_stt_flg = '0' then prc_amt else null end) as his_sum_fail_prc_amt, -- 历史失败借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 90 and ord_stt_flg = '0' then prc_amt else null end) as d90_sum_fail_prc_amt, -- 近90天失败借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 360 and ord_stt_flg = '0' then prc_amt else null end) as d360_sum_fail_prc_amt, -- 近360天失败借款本金总和
        sum(case when ddf_mdl_ord_crt_dte > 0 and ddf_mdl_ord_crt_dte <= 720 and ord_stt_flg = '0' then prc_amt else null end) as d720_sum_fail_prc_amt, -- 近720天失败借款本金总和
        COLLECT_LIST(cast(to_char(crt_dte,'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = '1') as his_success_order_date, -- transfer datetime to bigint datatype
        COLLECT_LIST(cast(to_char(crt_dte,'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = '0') as his_fail_order_date, -- transfer datetime to bigint datatype
        COLLECT_LIST(cast(to_char(datetrunc(date(crt_dte),'MM'),'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = '1') as his_success_order_date_mon, -- transfer datemonth to bigint datatype
        COLLECT_LIST(cast(to_char(datetrunc(date(crt_dte),'MM'),'yyyymmdd') as bigint)) FILTER (WHERE ord_stt_flg = '0') as his_fail_order_date_mon -- transfer datemonth to bigint datatype

from cross_inner_behaviour_trade_dimension_qingzichan basic
group by uid,mdl_dte;


-- 3 轻资产还款
drop table if exists cross_inner_behaviour_repay_debt_dimension_qingzichan;
create table if not exists cross_inner_behaviour_repay_debt_dimension_qingzichan as
select  
        main2.uid
        ,main2.mdl_dte
        ,main2.dtl_ord_no -- 还款记录表所在订单号
        ,main2.dtl_stg_pln_no -- 还款记录表的分期号码
        ,main2.dtl_rep_dte -- 应还款日
        ,main2.rep_tim -- 实际还款日
        ,main2.prc_amt -- 应还本金
        ,main2.stg_no -- 期号

        --应还日和实还日之间的间隔（天）：用于判断逾期、提前、按时还款
        ,main2.ddf_rep_tim_dte 
        --实还日和评分日的间隔（天）：用于限定实还行为变量的窗口期
        ,main2.ddf_mdl_rep_tim
        --应还日和评分日的间隔（天）：用于限定应还行为变量的窗口期
        ,main2.ddf_mdl_rep_dte 

        --还款状态--flag
        --是否提前还款flag
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte<0 then '提前还款' -- 这样写的好处是即使评分日后的应还分期，如果在评分日前提前还了，也能计入
         when ddf_rep_tim_dte>0 then '逾期还款'
         when ddf_mdl_rep_dte>0 and ddf_rep_tim_dte=0 then '按时还款'
         when ddf_mdl_rep_dte<=0 then '未来应还（评分日T日及往后）'
         else '其他分期状态'
         end repay_status_main -- 还款状态主字段

        --逾期天数flag，后面作为限制条件。只用：1～3、4～14、15+、30+、60+、90+
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 1 and 3 then 1 else 0 end as ovd_1d_3d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 4 and 14 then 1 else 0 end as ovd_4d_14d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=15 then 1 else 0 end as ovd_15d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=30 then 1 else 0 end as ovd_1m_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=60 then 1 else 0 end as ovd_2m_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>=90 then 1 else 0 end as ovd_3m_pls_flg

        --提前天数flag，后面作为限制条件。只用：<=3、<=15、<=30、<=60、<=90
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -3 and -1 then 1 else 0 end as adv_3d_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -15 and -1 then 1 else 0 end as adv_15d_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -30 and -1 then 1 else 0 end as adv_1m_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -60 and -1 then 1 else 0 end as adv_2m_minus_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -90 and -1 then 1 else 0 end as adv_3m_minus_flg

from
        (select 
                main1.uid
                ,main1.mdl_dte
                ,main1.dtl_ord_no
                ,main1.dtl_stg_pln_no
                ,main1.dtl_rep_dte
                ,main1.rep_tim
                ,main1.prc_amt
                ,main1.stg_stt
                ,main1.stg_no
                --应还日和实还日之间的间隔（天），for判断逾期、提前、按时还款
                ,case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte)
                        else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte
                --实还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim
                --应还日和评分日的间隔，for变量窗口期判断
                ,datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte 
        from
                (
                     select model_data.uid
                        ,model_data.mdl_dte
                        ,plan.dtl_ord_no
                        ,plan.dtl_stg_pln_no
                        ,plan.dtl_rep_dte
                        ,case when date(plan.rep_tim)>=model_data.mdl_dte then null else date(plan.rep_tim) end as rep_tim
                        ,plan.prc_amt
                        ,plan.stg_stt
                        ,plan.stg_no
                from    (
    select  uid
            ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from    dwa_risk.dwa_risk_f_dz_model_data_base
                        ) model_data

                        left join
                        (
                            select uid
                                ,create_time -- 订单创建时间
                                ,order_no as dtl_ord_no -- 分期所在订单编号
                                ,stage_plan_no as dtl_stg_pln_no -- 分期计划编号
                                ,due_date as dtl_rep_dte -- 分期应还款日
                                ,settlement_time as rep_tim -- 分期结清时间
                                ,schedule_pay_principal as prc_amt -- 分期应还本金
                                ,stage_status as stg_stt
                                ,stage_no as stg_no -- 分期所在期数
                        from cdmx.etl_cdmx_fct_light_stage_plan_df
                        where ds = '${bizdate}' and fund_code <> 'MSXF' -- 排除马上消费金融
                        ) plan on model_data.uid=plan.uid and to_date(mdl_dte,'yyyy-mm-dd') > date(create_time)
                        -- 分期所在的订单创建时间要在评分日之前，避免穿越
                ) main1
       ) main2
;
-- 轻资产还款属性聚合到人头上
drop table if exists light_repay_behaviour_aggregate_to_uid_tmp;
create table if not exists light_repay_behaviour_aggregate_to_uid_tmp as
select uid,mdl_dte,
max(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_max_ontim_repay_amt, -- 历史最大单笔按时还款本金
max(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_max_ontim_repay_amt, -- 近90天最大按时还款本金
max(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_max_ontim_repay_amt, -- 近360天最大按时还款本金
max(case when repay_status_main = '按时还款' and  ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_max_ontim_repay_amt, -- 近720天最大按时还款本金
sum(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_sum_ontim_repay_amt, -- 历史按时还款本金sum
sum(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_sum_ontim_repay_amt, -- 近90天按时还款本金sum
sum(case when repay_status_main = '按时还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_sum_ontim_repay_amt, -- 近360天按时还款本金sum
sum(case when repay_status_main = '按时还款' and  ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_sum_ontim_repay_amt, -- 近720天按时还款本金sum

max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 then prc_amt else null end) as his_max_adv_repay_amt, -- 历史最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 90 then prc_amt else null end) as d90_max_adv_repay_amt, -- 近90天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 360 then prc_amt else null end) as d360_max_adv_repay_amt, -- 近360天最大单笔提前还款本金
max(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 720 then prc_amt else null end) as d720_max_adv_repay_amt, -- 近720天最大单笔提前还款本金
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 then prc_amt else null end) as his_sum_adv_repay_amt, -- 历史提前还款本金sum
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 90 then prc_amt else null end) as d90_sum_adv_repay_amt, -- 近90天提前还款本金sum
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 360 then prc_amt else null end) as d360_sum_adv_repay_amt, -- 近360天提前还款本金sum
sum(case when repay_status_main = '提前还款' and ddf_mdl_rep_tim > 0 and ddf_mdl_rep_tim <= 720 then prc_amt else null end) as d720_sum_adv_repay_amt, -- 近720天提前还款本金sum

max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_max_ovd_repay_amt, -- 历史最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_max_ovd_repay_amt, -- 近90天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_max_ovd_repay_amt, -- 近360天最大单笔逾期还款本金
max(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_max_ovd_repay_amt, -- 近720天最大单笔逾期还款本金
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 then prc_amt else null end) as his_sum_ovd_repay_amt, -- 历史逾期还款本金sum
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 90 then prc_amt else null end) as d90_sum_ovd_repay_amt, -- 近90天逾期还款本金sum
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 360 then prc_amt else null end) as d360_sum_ovd_repay_amt, -- 近360天逾期还款本金sum
sum(case when repay_status_main = '逾期还款' and ddf_mdl_rep_dte > 0 and ddf_mdl_rep_dte <= 720 then prc_amt else null end) as d720_sum_ovd_repay_amt, -- 近720天逾期还款本金sum
COLLECT_LIST(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '按时还款') as his_ontime_repay_date_list, -- transfer datetime to bigint datatype
COLLECT_LIST(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_repay_date_list, -- due repay date
COLLECT_LIST(cast(to_char(rep_tim,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_real_repay_date_list, -- real repay date
COLLECT_LIST(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '逾期还款') as his_overdue_repay_date_list, -- transfer datetime to bigint datatype
COLLECT_LIST(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '按时还款') as his_ontime_repay_date_month_list, -- transfer datemonth to bigint datatype
COLLECT_LIST(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_repay_date_month_list, -- due repay date month
COLLECT_LIST(cast(to_char(datetrunc(rep_tim,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '提前还款') as his_advance_real_repay_date_month_list, -- real repay date month
COLLECT_LIST(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) FILTER (WHERE repay_status_main = '逾期还款') as his_overdue_repay_date_month_list, -- transfer datemonth to bigint datatype
collect_list(cast(to_char(dtl_rep_dte,'yyyymmdd') as bigint)) as his_all_repay_due_date_list,
collect_list(cast(to_char(datetrunc(dtl_rep_dte,'MM'),'yyyymmdd') as bigint)) as his_all_repay_due_date_month_list
from (
    select * from cross_inner_behaviour_repay_debt_dimension_qingzichan where repay_status_main in ('提前还款','逾期还款','按时还款')
) basic
group by uid,mdl_dte;
-- 4 轻资产负债维度
-- warning！直接使用cdmx.etl_cdmx_fct_light_stage_plan_df最新分区的未来应还字段，是穿越行为
drop table if exists light_upaid_principal_aggregate_to_uid_tmp;
create table if not exists light_upaid_principal_aggregate_to_uid_tmp as
select uid,mdl_dte
       ,sum(case when if_topay_stg = 1 then his_loan_stg_prc_amt else 0 end) as unpaid_principal_tot -- 总未还本金
       ,sum(case when if_his_topay_stg = 1 then his_loan_stg_prc_amt else 0 end) as unpaid_principal_his -- 历史到期未还本金
       ,sum(case when if_future_topay_stg = 1 then his_loan_stg_prc_amt else 0 end) as unpaid_principal_future -- 未来到期未还本金
from
(select  *
        ,case when datediff(mdl_dte , his_loan_stg_due_date) <= 0 and his_real_rep_tim is null then 1 else 0 end as if_future_topay_stg -- 应还日在评分日及之后，且评分日时尚未结清的分期，视作未来应还分期
        ,case when datediff(mdl_dte , his_loan_stg_due_date) > 0 and his_real_rep_tim is null then 1 else 0 end as if_his_topay_stg -- 应还日在评分日之前，且评分日时尚未结清的分期，视作历史逾期尚未还款分期
        ,case when his_real_rep_tim is null then 1 else 0 end as if_topay_stg -- 只要是当前结清时间为null，均视作未还，计算为总负债
from    (
            select  t1.*
                   ,t3.his_loan_stg_prc_amt -- 注意这里含评分日往后的、及评分日往前的结清分期本金
                   ,t3.his_loan_stg_tot_amt -- 所有费用，含本息、手续费、罚息等等
                   ,t3.his_loan_stg_due_date -- 历史分期的应还日
                   ,case
                     when date(t3.rep_tim) >= t1.mdl_dte then null
                     else date(t3.rep_tim)
                     end as his_real_rep_tim -- 当前申请日期之后还款的信息即为穿越
            from    (
    select  uid
            ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
    from    dwa_risk.dwa_risk_f_dz_model_data_base
                    ) t1
            left join (
                        select  uid
                                ,create_time
                                ,TO_CHAR(due_date , 'yyyy-mm-dd') AS his_loan_stg_due_date -- 历史订单的第xx期应还日
                                ,cast(stage_no as bigint)                          as his_laon_xxth_stg -- 历史订单的第xx期
                                ,settlement_time as rep_tim -- 分期结清时间
                                ,schedule_pay_principal as his_loan_stg_prc_amt
                                ,schedule_pay_total_amount as his_loan_stg_tot_amt
                          from    cdmx.etl_cdmx_fct_light_stage_plan_df
                          where ds = '${bizdate}' and fund_code <> 'MSXF' -- 排除马上消费金融
                      ) t3
            on      t1.uid = t3.uid
            and     to_date(mdl_dte,'yyyy-mm-dd') > date(create_time)
        )
) group by  uid ,mdl_dte;

--********************************************************************--
--开始做轻重之间的交叉
--********************************************************************--
--******** 1 轻资产授信CROSS重资产授信、轻资产授信CROSS重资产未来应还、轻资产授信cross重资产交易 ********--
drop table if exists light_heavy_credit_time_cross_tmp;
create table light_heavy_credit_time_cross_tmp as
select main.uid,main.mdl_dte
        ,qzc_sx_limit/rsk_adt_lmt_cash as his_light_limit_divide_btch_adt_limit -- 历史至今轻资产授信额度/重资产授信额度
        ,qzc_sx_limit/rsk_avl_lmt_cash as his_light_limit_divide_btch_avl_limit -- 历史至今轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/qzc_sx_limit as heavy_unpaid_principal_tot_divide_his_light_limit -- 重资产总应还本金/历史至今轻资产授信额度
        ,unpaid_principal_his/qzc_sx_limit as heavy_unpaid_principal_his_divide_his_light_limit -- 重资产历史到期未还本金/历史至今轻资产授信额度
        ,unpaid_principal_future/qzc_sx_limit as heavy_unpaid_principal_future_divide_his_light_limit -- 重资产未来到期未还本金/历史至今轻资产授信额度
        ,unpaid_total_amount_tot/qzc_sx_limit as heavy_unpaid_total_amount_tot_divide_his_light_limit -- 重资产总未还金额/历史至今轻资产授信额度
        -- 20250513特征评审会要求，增加时间窗口字段
        ,d90_qzc_sx_limit/rsk_adt_lmt_cash as d90_light_limit_divide_btch_adt_limit -- 近90天轻资产授信额度/重资产授信额度
        ,d90_qzc_sx_limit/rsk_avl_lmt_cash as d90_light_limit_divide_btch_avl_limit -- 近90天轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/d90_qzc_sx_limit as heavy_unpaid_principal_tot_divide_d90_light_limit -- 重资产总应还本金/近90天轻资产授信额度
        ,unpaid_principal_his/d90_qzc_sx_limit as heavy_unpaid_principal_his_divide_d90_light_limit -- 重资产历史到期未还本金/近90天轻资产授信额度
        ,unpaid_principal_future/d90_qzc_sx_limit as heavy_unpaid_principal_future_divide_d90_light_limit -- 重资产未来到期未还本金/近90天轻资产授信额度
        ,unpaid_total_amount_tot/d90_qzc_sx_limit as heavy_unpaid_total_amount_tot_divide_d90_light_limit -- 重资产总未还金额/近90天轻资产授信额度
        
        ,d360_qzc_sx_limit/rsk_adt_lmt_cash as d360_light_limit_divide_btch_adt_limit -- 近360天轻资产授信额度/重资产授信额度
        ,d360_qzc_sx_limit/rsk_avl_lmt_cash as d360_light_limit_divide_btch_avl_limit -- 近360天轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/d360_qzc_sx_limit as heavy_unpaid_principal_tot_divide_d360_light_limit -- 重资产总应还本金/近360天轻资产授信额度
        ,unpaid_principal_his/d360_qzc_sx_limit as heavy_unpaid_principal_his_divide_d360_light_limit -- 重资产历史到期未还本金/近360天轻资产授信额度
        ,unpaid_principal_future/d360_qzc_sx_limit as heavy_unpaid_principal_future_divide_d360_light_limit -- 重资产未来到期未还本金/近360天轻资产授信额度
        ,unpaid_total_amount_tot/d360_qzc_sx_limit as heavy_unpaid_total_amount_tot_divide_d360_light_limit -- 重资产总未还金额/近360天轻资产授信额度
        
        ,d720_qzc_sx_limit/rsk_adt_lmt_cash as d720_light_limit_divide_btch_adt_limit -- 近720天轻资产授信额度/重资产授信额度
        ,d720_qzc_sx_limit/rsk_avl_lmt_cash as d720_light_limit_divide_btch_avl_limit -- 近720天轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/d720_qzc_sx_limit as heavy_unpaid_principal_tot_divide_d720_light_limit -- 重资产总应还本金/近720天轻资产授信额度
        ,unpaid_principal_his/d720_qzc_sx_limit as heavy_unpaid_principal_his_divide_d720_light_limit -- 重资产历史到期未还本金/近720天轻资产授信额度
        ,unpaid_principal_future/d720_qzc_sx_limit as heavy_unpaid_principal_future_divide_d720_light_limit -- 重资产未来到期未还本金/近720天轻资产授信额度
        ,unpaid_total_amount_tot/d720_qzc_sx_limit as heavy_unpaid_total_amount_tot_divide_d720_light_limit -- 重资产总未还金额/近720天轻资产授信额度

        -- 20250513增加max算子
        ,qzc_sx_limit_max/rsk_adt_lmt_cash as his_light_limit_max_divide_btch_adt_limit -- 历史至今轻资产授信额度/重资产授信额度
        ,qzc_sx_limit_max/rsk_avl_lmt_cash as his_light_limit_max_divide_btch_avl_limit -- 历史至今轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/qzc_sx_limit_max as heavy_unpaid_principal_tot_divide_his_light_limit_max -- 重资产总应还本金/历史至今轻资产授信额度
        ,unpaid_principal_his/qzc_sx_limit_max as heavy_unpaid_principal_his_divide_his_light_limit_max -- 重资产历史到期未还本金/历史至今轻资产授信额度
        ,unpaid_principal_future/qzc_sx_limit_max as heavy_unpaid_principal_future_divide_his_light_limit_max -- 重资产未来到期未还本金/历史至今轻资产授信额度
        ,unpaid_total_amount_tot/qzc_sx_limit_max as heavy_unpaid_total_amount_tot_divide_his_light_limit_max -- 重资产总未还金额/历史至今轻资产授信额度
        ,d90_qzc_sx_limit_max/rsk_adt_lmt_cash as d90_light_limit_max_divide_btch_adt_limit -- 近90天轻资产授信额度/重资产授信额度
        ,d90_qzc_sx_limit_max/rsk_avl_lmt_cash as d90_light_limit_max_divide_btch_avl_limit -- 近90天轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/d90_qzc_sx_limit_max as heavy_unpaid_principal_tot_divide_d90_light_limit_max -- 重资产总应还本金/近90天轻资产授信额度
        ,unpaid_principal_his/d90_qzc_sx_limit_max as heavy_unpaid_principal_his_divide_d90_light_limit_max -- 重资产历史到期未还本金/近90天轻资产授信额度
        ,unpaid_principal_future/d90_qzc_sx_limit_max as heavy_unpaid_principal_future_divide_d90_light_limit_max -- 重资产未来到期未还本金/近90天轻资产授信额度
        ,unpaid_total_amount_tot/d90_qzc_sx_limit_max as heavy_unpaid_total_amount_tot_divide_d90_light_limit_max -- 重资产总未还金额/近90天轻资产授信额度
        
        ,d360_qzc_sx_limit_max/rsk_adt_lmt_cash as d360_light_limit_max_divide_btch_adt_limit -- 近360天轻资产授信额度/重资产授信额度
        ,d360_qzc_sx_limit_max/rsk_avl_lmt_cash as d360_light_limit_max_divide_btch_avl_limit -- 近360天轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/d360_qzc_sx_limit_max as heavy_unpaid_principal_tot_divide_d360_light_limit_max -- 重资产总应还本金/近360天轻资产授信额度
        ,unpaid_principal_his/d360_qzc_sx_limit_max as heavy_unpaid_principal_his_divide_d360_light_limit_max -- 重资产历史到期未还本金/近360天轻资产授信额度
        ,unpaid_principal_future/d360_qzc_sx_limit_max as heavy_unpaid_principal_future_divide_d360_light_limit_max -- 重资产未来到期未还本金/近360天轻资产授信额度
        ,unpaid_total_amount_tot/d360_qzc_sx_limit_max as heavy_unpaid_total_amount_tot_divide_d360_light_limit_max -- 重资产总未还金额/近360天轻资产授信额度
        
        ,d720_qzc_sx_limit_max/rsk_adt_lmt_cash as d720_light_limit_max_divide_btch_adt_limit -- 近720天轻资产授信额度/重资产授信额度
        ,d720_qzc_sx_limit_max/rsk_avl_lmt_cash as d720_light_limit_max_divide_btch_avl_limit -- 近720天轻资产授信额度/重资产可用信额度
        ,unpaid_principal_tot/d720_qzc_sx_limit_max as heavy_unpaid_principal_tot_divide_d720_light_limit_max -- 重资产总应还本金/近720天轻资产授信额度
        ,unpaid_principal_his/d720_qzc_sx_limit_max as heavy_unpaid_principal_his_divide_d720_light_limit_max -- 重资产历史到期未还本金/近720天轻资产授信额度
        ,unpaid_principal_future/d720_qzc_sx_limit_max as heavy_unpaid_principal_future_divide_d720_light_limit_max -- 重资产未来到期未还本金/近720天轻资产授信额度
        ,unpaid_total_amount_tot/d720_qzc_sx_limit_max as heavy_unpaid_total_amount_tot_divide_d720_light_limit_max -- 重资产总未还金额/近720天轻资产授信额度


       ,size(FILTER(
             main.qzc_fund_time_list, 
             x -> ABS(DATEDIFF(date(first_credit_time_by_btch), date(x))) <= 30
           )) as his_heavy_shouxin_inner30d_light_shouxin_count -- 历史至今重资产授信前后30天内轻资产授信资方数
       ,size(FILTER(
             main.qzc_fund_time_list, 
             x -> DATEDIFF(datetrunc(date(x),'MM'),first_credit_mon) = 0
           )) as his_heavy_shouxin_samemonth_light_shouxin_count -- 历史至今与重资产授信发生在同一个月的轻资产授信资方数
       -- 这里的代码是有误的，需要修改实现
        ,size(ARRAY_INTERSECT(main.qzc_fund_time_bigint_list,d.his_success_order_date)) as his_light_shouxin_heavy_suc_trade_same_date_count -- 轻资产授信与重资产成功交易发生在同一个天的unique日期数，-1为其中任意一个数组的时间list均为null
        ,size(ARRAY_INTERSECT(main.qzc_fund_mon_bigint_list,d.his_success_order_date_mon)) as his_light_shouxin_heavy_suc_trade_same_month_count -- 轻资产授信与重资产成功交易发生在同一个月的月份数
        ,size(ARRAY_INTERSECT(main.qzc_fund_time_bigint_list,d.his_fail_order_date)) as his_light_shouxin_heavy_fail_trade_same_date_count -- 轻资产授信与重资产失败交易发生在同一个天的unique日期数，-1为其中任意一个数组的时间list均为null
        ,size(ARRAY_INTERSECT(main.qzc_fund_mon_bigint_list,d.his_fail_order_date_mon)) as his_light_shouxin_heavy_fail_trade_same_month_count -- 轻资产授信与重资产失败交易发生在同一个月的月份数


from    light_his_all_shouxin_info_tmp main
left join (
        select uid,case when first_credit_time_by_btch is null then first_credit_time_all_heavy else first_credit_time_by_btch end as first_credit_time_by_btch,case when first_credit_time_by_btch is null then datetrunc(first_credit_time_all_heavy, 'MM') else datetrunc(first_credit_time_by_btch, 'MM') end as first_credit_mon from dwa.dwa_f_user_first_loan_df where ds = '${bizdate}'
    ) b -- 全量授信记录表
on main.uid = b.uid
left join (
              select  uid
                     ,mdl_dte
                     ,rsk_adt_lmt_cash
                     ,rsk_avl_lmt_cash
              from    dwa_risk.dwa_risk_f_customer_credit_limit_basic_df
              where   ds = '${bizdate}'
          ) e
on      main.uid = e.uid
and     main.mdl_dte = e.mdl_dte
left join (
        select uid,mdl_dte,unpaid_principal_tot,unpaid_principal_his,unpaid_principal_future,unpaid_total_amount_tot from 
    dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df where ds = '${bizdate}'
    ) C
on main.uid = c.uid and main.mdl_dte = c.mdl_dte
left join heavy_trade_behaviour_aggregate_to_uid_tmp d
on main.uid = d.uid and main.mdl_dte = d.mdl_dte;

--******** 2 轻资产交易CROSS重资产授信、轻资产交易CROSS重资产交易、轻资产交易CROSS重资产还款 ********--
drop table if exists light_trade_heavy_credit_trade_cross_tmp;
create table light_trade_heavy_credit_trade_cross_tmp as
select  a.uid,a.mdl_dte
    --** 2.1轻资产交易日期在重资产授信cross **--
    ,size(FILTER(
            a.his_success_order_date, 
            x -> ABS(DATEDIFF(date(first_credit_time_by_btch), to_date(cast(x as string),'yyyymmdd'))) <= 30
            )) as his_heavy_shouxin_inner30d_light_trade_suc_count -- 轻资产成功交易日在重资产授信日前后30天内的笔数
    ,size(FILTER(
            a.his_fail_order_date, 
            x -> ABS(DATEDIFF(date(first_credit_time_by_btch), to_date(cast(x as string),'yyyymmdd'))) <= 30
            )) as his_heavy_shouxin_inner30d_light_trade_fail_count -- 轻资产失败交易日在重资产授信日前后30天内的笔数
    -- 轻资产交易日期与重资产同月的笔数
    ,size(FILTER(
            a.his_success_order_date_mon, 
            x -> DATEDIFF(to_date(cast(x as string),'yyyymmdd'),first_credit_mon) = 0
            )) as his_heavy_shouxin_samemonth_light_trade_suc_count -- 轻资产成功交易日与重资产授信日在同一个月的笔数
    ,size(FILTER(
            a.his_fail_order_date_mon, 
            x -> DATEDIFF(to_date(cast(x as string),'yyyymmdd'),first_credit_mon) = 0
            )) as his_heavy_shouxin_samemonth_light_trade_fail_count-- 轻资产失败交易日与重资产授信日在同一个月的笔数
    --** 2.2轻资产交易与重资产交易发生在同一个月或同一天 **--
    ,size(ARRAY_INTERSECT(a.his_success_order_date_mon,c.his_success_order_date_mon)) as his_heavy_light_suc_trade_same_month_count -- 轻资产成功交易与重资产成功交易发生在同一个月的月份数，-1为其中任意一个数组的时间list均为null
    ,size(ARRAY_INTERSECT(a.his_fail_order_date_mon,c.his_fail_order_date_mon)) as his_heavy_light_fail_trade_same_month_count -- 轻资产失败交易与重资产失败交易发生在同一个月的月份数

    ,size(ARRAY_INTERSECT(a.his_success_order_date,c.his_success_order_date)) as his_heavy_light_suc_trade_same_date_count -- 轻资产成功交易与重资产成功交易发生在同一天的unique日期数
    ,size(ARRAY_INTERSECT(a.his_fail_order_date,c.his_fail_order_date)) as his_heavy_light_fail_trade_same_date_count -- 轻资产失败交易与重资产失败交易发生在同一天的unique日期数

    --** 2.3轻资产交易与重资产还款发生在同一个月或者同一天 **--
    ,size(ARRAY_INTERSECT(a.his_success_order_date_mon,d.his_overdue_repay_date_month_list)) as his_light_suc_trade_heavy_ovd_repay_same_month_count -- 轻资产成功交易与重资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(a.his_success_order_date,d.his_overdue_repay_date_list)) as his_light_suc_trade_heavy_ovd_repay_same_date_count -- 轻资产成功交易与重资产逾期还款发生在同一个天的unique日期数
    ,size(ARRAY_INTERSECT(a.his_fail_order_date_mon,d.his_overdue_repay_date_month_list)) as his_light_fail_trade_heavy_ovd_repay_same_month_count -- 轻资产fail交易与重资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(a.his_fail_order_date,d.his_overdue_repay_date_list)) as his_light_fail_trade_heavy_ovd_repay_same_date_count -- 轻资产fail交易与重资产逾期还款发生在同一个天的unique日期数
   ,size(ARRAY_INTERSECT(a.his_success_order_date_mon,d.his_advance_real_repay_date_month_list)) as his_light_suc_trade_heavy_advance_repay_same_month_count -- 历史至今轻资产交易成功与重资产提前还款(实还日)发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(a.his_success_order_date,d.his_advance_real_repay_date_list)) as his_light_suc_trade_heavy_advance_repay_same_date_count -- 历史至今轻资产交易成功与重资产提前还款(实还日)发生在同天的unique日期数

    --** 常规的轻资产计算结果除以重资产计算结果 **--
    -- 轻资产借款与重资产借款之间的交叉
    ,a.his_max_faqi_prc_amt/c.his_max_faqi_prc_amt as light_his_max_faqi_prc_amt_divide_heavy_his_max_faqi_prc_amt
    ,a.d90_max_faqi_prc_amt/c.d90_max_faqi_prc_amt as light_d90_max_faqi_prc_amt_divide_heavy_d90_max_faqi_prc_amt
    ,a.d360_max_faqi_prc_amt/c.d360_max_faqi_prc_amt as light_d360_max_faqi_prc_amt_divide_heavy_d360_max_faqi_prc_amt
    ,a.d720_max_faqi_prc_amt/c.d720_max_faqi_prc_amt as light_d720_max_faqi_prc_amt_divide_heavy_d720_max_faqi_prc_amt
    ,a.his_sum_faqi_prc_amt/c.his_sum_faqi_prc_amt as light_his_sum_faqi_prc_amt_divide_heavy_his_sum_faqi_prc_amt
    ,a.d90_sum_faqi_prc_amt/c.d90_sum_faqi_prc_amt as light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_faqi_prc_amt
    ,a.d360_sum_faqi_prc_amt/c.d360_sum_faqi_prc_amt as light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_faqi_prc_amt
    ,a.d720_sum_faqi_prc_amt/c.d720_sum_faqi_prc_amt as light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_faqi_prc_amt
    ,a.his_sum_faqi_stg_num/c.his_sum_faqi_stg_num as light_his_sum_faqi_stg_num_divide_heavy_his_sum_faqi_stg_num
    ,a.d90_sum_faqi_stg_num/c.d90_sum_faqi_stg_num as light_d90_sum_faqi_stg_num_divide_heavy_d90_sum_faqi_stg_num
    ,a.d360_sum_faqi_stg_num/c.d360_sum_faqi_stg_num as light_d360_sum_faqi_stg_num_divide_heavy_d360_sum_faqi_stg_num
    ,a.d720_sum_faqi_stg_num/c.d720_sum_faqi_stg_num as light_d720_sum_faqi_stg_num_divide_heavy_d720_sum_faqi_stg_num
    ,a.his_sum_faqi_count/c.his_sum_faqi_count as light_his_sum_faqi_count_divide_heavy_his_sum_faqi_count
    ,a.d90_sum_faqi_count/c.d90_sum_faqi_count as light_d90_sum_faqi_count_divide_heavy_d90_sum_faqi_count
    ,a.d360_sum_faqi_count/c.d360_sum_faqi_count as light_d360_sum_faqi_count_divide_heavy_d360_sum_faqi_count
    ,a.d720_sum_faqi_count/c.d720_sum_faqi_count as light_d720_sum_faqi_count_divide_heavy_d720_sum_faqi_count
    ,a.his_sum_larger_than_1w_faqi_count/c.his_sum_larger_than_1w_faqi_count as light_his_sum_larger_than_1w_faqi_count_divide_heavy_his_sum_larger_than_1w_faqi_count
    ,a.d90_sum_larger_than_1w_faqi_count/c.d90_sum_larger_than_1w_faqi_count as light_d90_sum_larger_than_1w_faqi_count_divide_heavy_d90_sum_larger_than_1w_faqi_count
    ,a.d360_sum_larger_than_1w_faqi_count/c.d360_sum_larger_than_1w_faqi_count as light_d360_sum_larger_than_1w_faqi_count_divide_heavy_d360_sum_larger_than_1w_faqi_count
    ,a.d720_sum_larger_than_1w_faqi_count/c.d720_sum_larger_than_1w_faqi_count as light_d720_sum_larger_than_1w_faqi_count_divide_heavy_d720_sum_larger_than_1w_faqi_count
    ,a.his_max_suc_prc_amt/c.his_max_suc_prc_amt as light_his_max_suc_prc_amt_divide_heavy_his_max_suc_prc_amt
    ,a.d90_max_suc_prc_amt/c.d90_max_suc_prc_amt as light_d90_max_suc_prc_amt_divide_heavy_d90_max_suc_prc_amt
    ,a.d360_max_suc_prc_amt/c.d360_max_suc_prc_amt as light_d360_max_suc_prc_amt_divide_heavy_d360_max_suc_prc_amt
    ,a.d720_max_suc_prc_amt/c.d720_max_suc_prc_amt as light_d720_max_suc_prc_amt_divide_heavy_d720_max_suc_prc_amt
    ,a.his_sum_suc_prc_amt/c.his_sum_suc_prc_amt as light_his_sum_suc_prc_amt_divide_heavy_his_sum_suc_prc_amt
    ,a.d90_sum_suc_prc_amt/c.d90_sum_suc_prc_amt as light_d90_sum_suc_prc_amt_divide_heavy_d90_sum_suc_prc_amt
    ,a.d360_sum_suc_prc_amt/c.d360_sum_suc_prc_amt as light_d360_sum_suc_prc_amt_divide_heavy_d360_sum_suc_prc_amt
    ,a.d720_sum_suc_prc_amt/c.d720_sum_suc_prc_amt as light_d720_sum_suc_prc_amt_divide_heavy_d720_sum_suc_prc_amt
    ,a.his_max_fail_prc_amt/c.his_max_fail_prc_amt as light_his_max_fail_prc_amt_divide_heavy_his_max_fail_prc_amt
    ,a.d90_max_fail_prc_amt/c.d90_max_fail_prc_amt as light_d90_max_fail_prc_amt_divide_heavy_d90_max_fail_prc_amt
    ,a.d360_max_fail_prc_amt/c.d360_max_fail_prc_amt as light_d360_max_fail_prc_amt_divide_heavy_d360_max_fail_prc_amt
    ,a.d720_max_fail_prc_amt/c.d720_max_fail_prc_amt as light_d720_max_fail_prc_amt_divide_heavy_d720_max_fail_prc_amt
    ,a.his_sum_fail_prc_amt/c.his_sum_fail_prc_amt as light_his_sum_fail_prc_amt_divide_heavy_his_sum_fail_prc_amt
    ,a.d90_sum_fail_prc_amt/c.d90_sum_fail_prc_amt as light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_fail_prc_amt
    ,a.d360_sum_fail_prc_amt/c.d360_sum_fail_prc_amt as light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_fail_prc_amt
    ,a.d720_sum_fail_prc_amt/c.d720_sum_fail_prc_amt as light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_fail_prc_amt
    
    -- 轻资产借款与重资产还款之间的交叉
    ,a.his_max_faqi_prc_amt/d.his_max_ontim_repay_amt as light_his_max_faqi_prc_amt_divide_heavy_his_max_ontim_repay_amt
    ,a.d90_max_faqi_prc_amt/d.d90_max_ontim_repay_amt as light_d90_max_faqi_prc_amt_divide_heavy_d90_max_ontim_repay_amt
    ,a.d360_max_faqi_prc_amt/d.d360_max_ontim_repay_amt as light_d360_max_faqi_prc_amt_divide_heavy_d360_max_ontim_repay_amt
    ,a.d720_max_faqi_prc_amt/d.d720_max_ontim_repay_amt as light_d720_max_faqi_prc_amt_divide_heavy_d720_max_ontim_repay_amt
    ,a.his_sum_faqi_prc_amt/d.his_sum_ontim_repay_amt as light_his_sum_faqi_prc_amt_divide_heavy_his_sum_ontim_repay_amt
    ,a.d90_sum_faqi_prc_amt/d.d90_sum_ontim_repay_amt as light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_ontim_repay_amt
    ,a.d360_sum_faqi_prc_amt/d.d360_sum_ontim_repay_amt as light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_ontim_repay_amt
    ,a.d720_sum_faqi_prc_amt/d.d720_sum_ontim_repay_amt as light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_ontim_repay_amt
    ,a.his_max_faqi_prc_amt/d.his_max_adv_repay_amt as light_his_max_faqi_prc_amt_divide_heavy_his_max_adv_repay_amt
    ,a.d90_max_faqi_prc_amt/d.d90_max_adv_repay_amt as light_d90_max_faqi_prc_amt_divide_heavy_d90_max_adv_repay_amt
    ,a.d360_max_faqi_prc_amt/d.d360_max_adv_repay_amt as light_d360_max_faqi_prc_amt_divide_heavy_d360_max_adv_repay_amt
    ,a.d720_max_faqi_prc_amt/d.d720_max_adv_repay_amt as light_d720_max_faqi_prc_amt_divide_heavy_d720_max_adv_repay_amt
    ,a.his_sum_faqi_prc_amt/d.his_sum_adv_repay_amt as light_his_sum_faqi_prc_amt_divide_heavy_his_sum_adv_repay_amt
    ,a.d90_sum_faqi_prc_amt/d.d90_sum_adv_repay_amt as light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_adv_repay_amt
    ,a.d360_sum_faqi_prc_amt/d.d360_sum_adv_repay_amt as light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_adv_repay_amt
    ,a.d720_sum_faqi_prc_amt/d.d720_sum_adv_repay_amt as light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_adv_repay_amt
    ,a.his_max_faqi_prc_amt/d.his_max_ovd_repay_amt as light_his_max_faqi_prc_amt_divide_heavy_his_max_ovd_repay_amt
    ,a.d90_max_faqi_prc_amt/d.d90_max_ovd_repay_amt as light_d90_max_faqi_prc_amt_divide_heavy_d90_max_ovd_repay_amt
    ,a.d360_max_faqi_prc_amt/d.d360_max_ovd_repay_amt as light_d360_max_faqi_prc_amt_divide_heavy_d360_max_ovd_repay_amt
    ,a.d720_max_faqi_prc_amt/d.d720_max_ovd_repay_amt as light_d720_max_faqi_prc_amt_divide_heavy_d720_max_ovd_repay_amt
    ,a.his_sum_faqi_prc_amt/d.his_sum_ovd_repay_amt as light_his_sum_faqi_prc_amt_divide_heavy_his_sum_ovd_repay_amt
    ,a.d90_sum_faqi_prc_amt/d.d90_sum_ovd_repay_amt as light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_ovd_repay_amt
    ,a.d360_sum_faqi_prc_amt/d.d360_sum_ovd_repay_amt as light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_ovd_repay_amt
    ,a.d720_sum_faqi_prc_amt/d.d720_sum_ovd_repay_amt as light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_ovd_repay_amt

    ,a.his_max_fail_prc_amt/d.his_max_ontim_repay_amt as light_his_max_fail_prc_amt_divide_heavy_his_max_ontim_repay_amt
    ,a.d90_max_fail_prc_amt/d.d90_max_ontim_repay_amt as light_d90_max_fail_prc_amt_divide_heavy_d90_max_ontim_repay_amt
    ,a.d360_max_fail_prc_amt/d.d360_max_ontim_repay_amt as light_d360_max_fail_prc_amt_divide_heavy_d360_max_ontim_repay_amt
    ,a.d720_max_fail_prc_amt/d.d720_max_ontim_repay_amt as light_d720_max_fail_prc_amt_divide_heavy_d720_max_ontim_repay_amt
    ,a.his_sum_fail_prc_amt/d.his_sum_ontim_repay_amt as light_his_sum_fail_prc_amt_divide_heavy_his_sum_ontim_repay_amt
    ,a.d90_sum_fail_prc_amt/d.d90_sum_ontim_repay_amt as light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_ontim_repay_amt
    ,a.d360_sum_fail_prc_amt/d.d360_sum_ontim_repay_amt as light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_ontim_repay_amt
    ,a.d720_sum_fail_prc_amt/d.d720_sum_ontim_repay_amt as light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_ontim_repay_amt
    ,a.his_max_fail_prc_amt/d.his_max_adv_repay_amt as light_his_max_fail_prc_amt_divide_heavy_his_max_adv_repay_amt
    ,a.d90_max_fail_prc_amt/d.d90_max_adv_repay_amt as light_d90_max_fail_prc_amt_divide_heavy_d90_max_adv_repay_amt
    ,a.d360_max_fail_prc_amt/d.d360_max_adv_repay_amt as light_d360_max_fail_prc_amt_divide_heavy_d360_max_adv_repay_amt
    ,a.d720_max_fail_prc_amt/d.d720_max_adv_repay_amt as light_d720_max_fail_prc_amt_divide_heavy_d720_max_adv_repay_amt
    ,a.his_sum_fail_prc_amt/d.his_sum_adv_repay_amt as light_his_sum_fail_prc_amt_divide_heavy_his_sum_adv_repay_amt
    ,a.d90_sum_fail_prc_amt/d.d90_sum_adv_repay_amt as light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_adv_repay_amt
    ,a.d360_sum_fail_prc_amt/d.d360_sum_adv_repay_amt as light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_adv_repay_amt
    ,a.d720_sum_fail_prc_amt/d.d720_sum_adv_repay_amt as light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_adv_repay_amt
    ,a.his_max_fail_prc_amt/d.his_max_ovd_repay_amt as light_his_max_fail_prc_amt_divide_heavy_his_max_ovd_repay_amt
    ,a.d90_max_fail_prc_amt/d.d90_max_ovd_repay_amt as light_d90_max_fail_prc_amt_divide_heavy_d90_max_ovd_repay_amt
    ,a.d360_max_fail_prc_amt/d.d360_max_ovd_repay_amt as light_d360_max_fail_prc_amt_divide_heavy_d360_max_ovd_repay_amt
    ,a.d720_max_fail_prc_amt/d.d720_max_ovd_repay_amt as light_d720_max_fail_prc_amt_divide_heavy_d720_max_ovd_repay_amt
    ,a.his_sum_fail_prc_amt/d.his_sum_ovd_repay_amt as light_his_sum_fail_prc_amt_divide_heavy_his_sum_ovd_repay_amt
    ,a.d90_sum_fail_prc_amt/d.d90_sum_ovd_repay_amt as light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_ovd_repay_amt
    ,a.d360_sum_fail_prc_amt/d.d360_sum_ovd_repay_amt as light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_ovd_repay_amt
    ,a.d720_sum_fail_prc_amt/d.d720_sum_ovd_repay_amt as light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_ovd_repay_amt

from    light_trade_behaviour_aggregate_to_uid_tmp a
left join (
        select uid,case when first_credit_time_by_btch is null then first_credit_time_all_heavy else first_credit_time_by_btch end as first_credit_time_by_btch,case when first_credit_time_by_btch is null then datetrunc(first_credit_time_all_heavy, 'MM') else datetrunc(first_credit_time_by_btch, 'MM') end as first_credit_mon from dwa.dwa_f_user_first_loan_df where ds = '${bizdate}'
    ) b -- heavy全量授信记录表
on a.uid = b.uid
left join heavy_trade_behaviour_aggregate_to_uid_tmp c on a.uid = c.uid and a.mdl_dte = c.mdl_dte
left join heavy_repay_behaviour_aggregate_to_uid_tmp d on a.uid = d.uid and a.mdl_dte = d.mdl_dte
;

--******** 3 轻资产还款CROSS重资产还款、轻资产还款CROSS重资产交易、轻资产还款CROSS重资产授信 ********--
drop table if exists light_repay_heavy_repay_credit_trade_cross_tmp;
create table light_repay_heavy_repay_credit_trade_cross_tmp as
select  a.uid,a.mdl_dte
    --** 3.1轻资产还款与重资产交易发生在同一个月或同一天 **--
    ,size(ARRAY_INTERSECT(c.his_success_order_date_mon,a.his_overdue_repay_date_month_list)) as his_heavy_suc_trade_light_ovd_repay_same_month_count -- 重资产成功交易与轻资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(c.his_success_order_date,a.his_overdue_repay_date_list)) as his_heavy_suc_trade_light_ovd_repay_same_date_count -- 重资产成功交易与轻资产逾期还款发生在同一个天的unique日期数
    ,size(ARRAY_INTERSECT(c.his_fail_order_date_mon,a.his_overdue_repay_date_month_list)) as his_heavy_fail_trade_light_ovd_repay_same_month_count -- 重资产fail交易与轻资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(c.his_fail_order_date,a.his_overdue_repay_date_list)) as his_heavy_fail_trade_light_ovd_repay_same_date_count -- 重资产fail交易与轻资产逾期还款发生在同一个天的unique日期数
   ,size(ARRAY_INTERSECT(c.his_success_order_date_mon,a.his_advance_real_repay_date_month_list)) as his_heavy_suc_trade_light_advance_repay_same_month_count -- 历史至今重资产交易成功与轻资产提前还款(实还日)发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(c.his_success_order_date,a.his_advance_real_repay_date_list)) as his_heavy_suc_trade_light_advance_repay_same_date_count -- 历史至今重资产交易成功与轻资产提前还款(实还日)发生在同天的unique日期数

    --** 3.2轻资产还款与重资产还款发生在同一个月或者同一天 **--
    ,size(ARRAY_INTERSECT(d.his_overdue_repay_date_month_list,a.his_overdue_repay_date_month_list)) as his_heavy_ovd_repay_light_ovd_repay_same_month_count -- 重资产逾期还款与轻资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(d.his_overdue_repay_date_list,a.his_overdue_repay_date_list)) as his_heavy_ovd_repay_light_ovd_repay_same_date_count -- 重资产逾期还款与轻资产逾期还款发生在同一个天的unique日期数
    ,size(ARRAY_INTERSECT(d.his_advance_real_repay_date_month_list,a.his_advance_real_repay_date_month_list)) as his_heavy_advance_repay_light_advance_repay_same_month_count -- 重资产提前还款（实还款日）与轻资产提前还款（实还款日）发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(d.his_advance_real_repay_date_list,a.his_advance_real_repay_date_list)) as his_heavy_advance_repay_light_advance_repay_same_date_count -- 重资产提前还款（实还款日）与轻资产提前还款（实还款日）发生在同一个天的unique日期数
    ,size(ARRAY_INTERSECT(d.his_ontime_repay_date_month_list,a.his_ontime_repay_date_month_list)) as his_heavy_ontime_repay_light_ontime_repay_same_month_count -- 重资产按时还款与轻资产按时还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(d.his_ontime_repay_date_list,a.his_ontime_repay_date_list)) as his_heavy_ontime_repay_light_ontime_repay_same_date_count -- 重资产按时还款与轻资产按时还款发生在同一个天的unique日期数

    ,size(ARRAY_INTERSECT(d.his_advance_real_repay_date_month_list,a.his_overdue_repay_date_month_list)) as his_heavy_advance_repay_light_ovd_repay_same_month_count -- 重资产提前还款（实还日）与轻资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(d.his_advance_real_repay_date_list,a.his_overdue_repay_date_list)) as his_heavy_advance_repay_light_ovd_repay_same_date_count -- 重资产提前还款（实还日）与轻资产逾期还款发生在同一个天的unique日期数
    ,size(ARRAY_INTERSECT(d.his_ontime_repay_date_month_list,a.his_overdue_repay_date_month_list)) as his_heavy_ontime_repay_light_ovd_repay_same_month_count -- 重资产按时还款（实还日）与轻资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(d.his_ontime_repay_date_list,a.his_overdue_repay_date_list)) as his_heavy_ontime_repay_light_ovd_repay_same_date_count -- 重资产按时还款（实还日）与轻资产逾期还款发生在同一个天的unique日期数

    ,size(ARRAY_INTERSECT(a.his_advance_real_repay_date_month_list,d.his_overdue_repay_date_month_list)) as his_light_advance_repay_heavy_ovd_repay_same_month_count -- 轻资产提前还款（实还日）与重资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(a.his_advance_real_repay_date_list,d.his_overdue_repay_date_list)) as his_light_advance_repay_heavy_ovd_repay_same_date_count -- 轻资产提前还款（实还日）与重资产逾期还款发生在同一个天的unique日期数
    ,size(ARRAY_INTERSECT(a.his_ontime_repay_date_month_list,d.his_overdue_repay_date_month_list)) as his_light_ontime_repay_heavy_ovd_repay_same_month_count -- 轻资产按时还款（实还日）与重资产逾期还款发生在同一个月的月份数
    ,size(ARRAY_INTERSECT(a.his_ontime_repay_date_list,d.his_overdue_repay_date_list)) as his_light_ontime_repay_heavy_ovd_repay_same_date_count -- 轻资产按时还款（实还日）与重资产逾期还款发生在同一个天的unique日期数

    --** 3.3轻资产还款与重资产授信发生在同一个月或者同一天 **--
    ,size(FILTER(
            a.his_overdue_repay_date_list, 
            x -> ABS(DATEDIFF(date(first_credit_time_by_btch), to_date(cast(x as string),'yyyymmdd') )) <= 30
            )) as his_heavy_shouxin_inner30d_light_ovd_repay_count
    ,size(FILTER(
            a.his_overdue_repay_date_month_list, 
            x -> DATEDIFF(first_credit_mon, to_date(cast(x as string),'yyyymmdd') ) = 0
            )) as his_heavy_shouxin_samemonth_light_ovd_repay_count

    ,size(FILTER(
            a.his_advance_real_repay_date_list, 
            x -> ABS(DATEDIFF(date(first_credit_time_by_btch), to_date(cast(x as string),'yyyymmdd') )) <= 30
            )) as his_heavy_shouxin_inner30d_light_advance_repay_count
    ,size(FILTER(
            a.his_advance_real_repay_date_month_list, 
            x -> DATEDIFF(first_credit_mon, to_date(cast(x as string),'yyyymmdd') ) = 0
            )) as his_heavy_shouxin_samemonth_light_advance_repay_count
            
    --** 常规的轻资产计算结果除以重资产计算结果 **--
    -- 轻资产repay与重资产repay之间的交叉
    ,a.his_max_ontim_repay_amt / d.his_max_ontim_repay_amt as light_his_max_ontim_repay_amt_divide_heavy_his_max_ontim_repay_amt
    ,a.d90_max_ontim_repay_amt / d.d90_max_ontim_repay_amt as light_d90_max_ontim_repay_amt_divide_heavy_d90_max_ontim_repay_amt
    ,a.d360_max_ontim_repay_amt / d.d360_max_ontim_repay_amt as light_d360_max_ontim_repay_amt_divide_heavy_d360_max_ontim_repay_amt
    ,a.d720_max_ontim_repay_amt / d.d720_max_ontim_repay_amt as light_d720_max_ontim_repay_amt_divide_heavy_d720_max_ontim_repay_amt
    ,a.his_sum_ontim_repay_amt / d.his_sum_ontim_repay_amt as light_his_sum_ontim_repay_amt_divide_heavy_his_sum_ontim_repay_amt
    ,a.d90_sum_ontim_repay_amt / d.d90_sum_ontim_repay_amt as light_d90_sum_ontim_repay_amt_divide_heavy_d90_sum_ontim_repay_amt
    ,a.d360_sum_ontim_repay_amt / d.d360_sum_ontim_repay_amt as light_d360_sum_ontim_repay_amt_divide_heavy_d360_sum_ontim_repay_amt
    ,a.d720_sum_ontim_repay_amt / d.d720_sum_ontim_repay_amt as light_d720_sum_ontim_repay_amt_divide_heavy_d720_sum_ontim_repay_amt
    ,a.his_max_adv_repay_amt / d.his_max_adv_repay_amt as light_his_max_adv_repay_amt_divide_heavy_his_max_adv_repay_amt
    ,a.d90_max_adv_repay_amt / d.d90_max_adv_repay_amt as light_d90_max_adv_repay_amt_divide_heavy_d90_max_adv_repay_amt
    ,a.d360_max_adv_repay_amt / d.d360_max_adv_repay_amt as light_d360_max_adv_repay_amt_divide_heavy_d360_max_adv_repay_amt
    ,a.d720_max_adv_repay_amt / d.d720_max_adv_repay_amt as light_d720_max_adv_repay_amt_divide_heavy_d720_max_adv_repay_amt
    ,a.his_sum_adv_repay_amt / d.his_sum_adv_repay_amt as light_his_sum_adv_repay_amt_divide_heavy_his_sum_adv_repay_amt
    ,a.d90_sum_adv_repay_amt / d.d90_sum_adv_repay_amt as light_d90_sum_adv_repay_amt_divide_heavy_d90_sum_adv_repay_amt
    ,a.d360_sum_adv_repay_amt / d.d360_sum_adv_repay_amt as light_d360_sum_adv_repay_amt_divide_heavy_d360_sum_adv_repay_amt
    ,a.d720_sum_adv_repay_amt / d.d720_sum_adv_repay_amt as light_d720_sum_adv_repay_amt_divide_heavy_d720_sum_adv_repay_amt
    ,a.his_max_ovd_repay_amt / d.his_max_ovd_repay_amt as light_his_max_ovd_repay_amt_divide_heavy_his_max_ovd_repay_amt
    ,a.d90_max_ovd_repay_amt / d.d90_max_ovd_repay_amt as light_d90_max_ovd_repay_amt_divide_heavy_d90_max_ovd_repay_amt
    ,a.d360_max_ovd_repay_amt / d.d360_max_ovd_repay_amt as light_d360_max_ovd_repay_amt_divide_heavy_d360_max_ovd_repay_amt
    ,a.d720_max_ovd_repay_amt / d.d720_max_ovd_repay_amt as light_d720_max_ovd_repay_amt_divide_heavy_d720_max_ovd_repay_amt
    ,a.his_sum_ovd_repay_amt / d.his_sum_ovd_repay_amt as light_his_sum_ovd_repay_amt_divide_heavy_his_sum_ovd_repay_amt
    ,a.d90_sum_ovd_repay_amt / d.d90_sum_ovd_repay_amt as light_d90_sum_ovd_repay_amt_divide_heavy_d90_sum_ovd_repay_amt
    ,a.d360_sum_ovd_repay_amt / d.d360_sum_ovd_repay_amt as light_d360_sum_ovd_repay_amt_divide_heavy_d360_sum_ovd_repay_amt
    ,a.d720_sum_ovd_repay_amt / d.d720_sum_ovd_repay_amt as light_d720_sum_ovd_repay_amt_divide_heavy_d720_sum_ovd_repay_amt
    
    -- 轻资产还款与重资产借款之间的交叉
    ,c.his_max_faqi_prc_amt/a.his_max_ontim_repay_amt as heavy_his_max_faqi_prc_amt_divide_light_his_max_ontim_repay_amt
    ,c.d90_max_faqi_prc_amt/a.d90_max_ontim_repay_amt as heavy_d90_max_faqi_prc_amt_divide_light_d90_max_ontim_repay_amt
    ,c.d360_max_faqi_prc_amt/a.d360_max_ontim_repay_amt as heavy_d360_max_faqi_prc_amt_divide_light_d360_max_ontim_repay_amt
    ,c.d720_max_faqi_prc_amt/a.d720_max_ontim_repay_amt as heavy_d720_max_faqi_prc_amt_divide_light_d720_max_ontim_repay_amt
    ,c.his_sum_faqi_prc_amt/a.his_sum_ontim_repay_amt as heavy_his_sum_faqi_prc_amt_divide_light_his_sum_ontim_repay_amt
    ,c.d90_sum_faqi_prc_amt/a.d90_sum_ontim_repay_amt as heavy_d90_sum_faqi_prc_amt_divide_light_d90_sum_ontim_repay_amt
    ,c.d360_sum_faqi_prc_amt/a.d360_sum_ontim_repay_amt as heavy_d360_sum_faqi_prc_amt_divide_light_d360_sum_ontim_repay_amt
    ,c.d720_sum_faqi_prc_amt/a.d720_sum_ontim_repay_amt as heavy_d720_sum_faqi_prc_amt_divide_light_d720_sum_ontim_repay_amt
    ,c.his_max_faqi_prc_amt/a.his_max_adv_repay_amt as heavy_his_max_faqi_prc_amt_divide_light_his_max_adv_repay_amt
    ,c.d90_max_faqi_prc_amt/a.d90_max_adv_repay_amt as heavy_d90_max_faqi_prc_amt_divide_light_d90_max_adv_repay_amt
    ,c.d360_max_faqi_prc_amt/a.d360_max_adv_repay_amt as heavy_d360_max_faqi_prc_amt_divide_light_d360_max_adv_repay_amt
    ,c.d720_max_faqi_prc_amt/a.d720_max_adv_repay_amt as heavy_d720_max_faqi_prc_amt_divide_light_d720_max_adv_repay_amt
    ,c.his_sum_faqi_prc_amt/a.his_sum_adv_repay_amt as heavy_his_sum_faqi_prc_amt_divide_light_his_sum_adv_repay_amt
    ,c.d90_sum_faqi_prc_amt/a.d90_sum_adv_repay_amt as heavy_d90_sum_faqi_prc_amt_divide_light_d90_sum_adv_repay_amt
    ,c.d360_sum_faqi_prc_amt/a.d360_sum_adv_repay_amt as heavy_d360_sum_faqi_prc_amt_divide_light_d360_sum_adv_repay_amt
    ,c.d720_sum_faqi_prc_amt/a.d720_sum_adv_repay_amt as heavy_d720_sum_faqi_prc_amt_divide_light_d720_sum_adv_repay_amt
    ,c.his_max_faqi_prc_amt/a.his_max_ovd_repay_amt as heavy_his_max_faqi_prc_amt_divide_light_his_max_ovd_repay_amt
    ,c.d90_max_faqi_prc_amt/a.d90_max_ovd_repay_amt as heavy_d90_max_faqi_prc_amt_divide_light_d90_max_ovd_repay_amt
    ,c.d360_max_faqi_prc_amt/a.d360_max_ovd_repay_amt as heavy_d360_max_faqi_prc_amt_divide_light_d360_max_ovd_repay_amt
    ,c.d720_max_faqi_prc_amt/a.d720_max_ovd_repay_amt as heavy_d720_max_faqi_prc_amt_divide_light_d720_max_ovd_repay_amt
    ,c.his_sum_faqi_prc_amt/a.his_sum_ovd_repay_amt as heavy_his_sum_faqi_prc_amt_divide_light_his_sum_ovd_repay_amt
    ,c.d90_sum_faqi_prc_amt/a.d90_sum_ovd_repay_amt as heavy_d90_sum_faqi_prc_amt_divide_light_d90_sum_ovd_repay_amt
    ,c.d360_sum_faqi_prc_amt/a.d360_sum_ovd_repay_amt as heavy_d360_sum_faqi_prc_amt_divide_light_d360_sum_ovd_repay_amt
    ,c.d720_sum_faqi_prc_amt/a.d720_sum_ovd_repay_amt as heavy_d720_sum_faqi_prc_amt_divide_light_d720_sum_ovd_repay_amt
    
    ,c.his_max_fail_prc_amt/a.his_max_ontim_repay_amt as heavy_his_max_fail_prc_amt_divide_light_his_max_ontim_repay_amt
    ,c.d90_max_fail_prc_amt/a.d90_max_ontim_repay_amt as heavy_d90_max_fail_prc_amt_divide_light_d90_max_ontim_repay_amt
    ,c.d360_max_fail_prc_amt/a.d360_max_ontim_repay_amt as heavy_d360_max_fail_prc_amt_divide_light_d360_max_ontim_repay_amt
    ,c.d720_max_fail_prc_amt/a.d720_max_ontim_repay_amt as heavy_d720_max_fail_prc_amt_divide_light_d720_max_ontim_repay_amt
    ,c.his_sum_fail_prc_amt/a.his_sum_ontim_repay_amt as heavy_his_sum_fail_prc_amt_divide_light_his_sum_ontim_repay_amt
    ,c.d90_sum_fail_prc_amt/a.d90_sum_ontim_repay_amt as heavy_d90_sum_fail_prc_amt_divide_light_d90_sum_ontim_repay_amt
    ,c.d360_sum_fail_prc_amt/a.d360_sum_ontim_repay_amt as heavy_d360_sum_fail_prc_amt_divide_light_d360_sum_ontim_repay_amt
    ,c.d720_sum_fail_prc_amt/a.d720_sum_ontim_repay_amt as heavy_d720_sum_fail_prc_amt_divide_light_d720_sum_ontim_repay_amt
    ,c.his_max_fail_prc_amt/a.his_max_adv_repay_amt as heavy_his_max_fail_prc_amt_divide_light_his_max_adv_repay_amt
    ,c.d90_max_fail_prc_amt/a.d90_max_adv_repay_amt as heavy_d90_max_fail_prc_amt_divide_light_d90_max_adv_repay_amt
    ,c.d360_max_fail_prc_amt/a.d360_max_adv_repay_amt as heavy_d360_max_fail_prc_amt_divide_light_d360_max_adv_repay_amt
    ,c.d720_max_fail_prc_amt/a.d720_max_adv_repay_amt as heavy_d720_max_fail_prc_amt_divide_light_d720_max_adv_repay_amt
    ,c.his_sum_fail_prc_amt/a.his_sum_adv_repay_amt as heavy_his_sum_fail_prc_amt_divide_light_his_sum_adv_repay_amt
    ,c.d90_sum_fail_prc_amt/a.d90_sum_adv_repay_amt as heavy_d90_sum_fail_prc_amt_divide_light_d90_sum_adv_repay_amt
    ,c.d360_sum_fail_prc_amt/a.d360_sum_adv_repay_amt as heavy_d360_sum_fail_prc_amt_divide_light_d360_sum_adv_repay_amt
    ,c.d720_sum_fail_prc_amt/a.d720_sum_adv_repay_amt as heavy_d720_sum_fail_prc_amt_divide_light_d720_sum_adv_repay_amt
    ,c.his_max_fail_prc_amt/a.his_max_ovd_repay_amt as heavy_his_max_fail_prc_amt_divide_light_his_max_ovd_repay_amt
    ,c.d90_max_fail_prc_amt/a.d90_max_ovd_repay_amt as heavy_d90_max_fail_prc_amt_divide_light_d90_max_ovd_repay_amt
    ,c.d360_max_fail_prc_amt/a.d360_max_ovd_repay_amt as heavy_d360_max_fail_prc_amt_divide_light_d360_max_ovd_repay_amt
    ,c.d720_max_fail_prc_amt/a.d720_max_ovd_repay_amt as heavy_d720_max_fail_prc_amt_divide_light_d720_max_ovd_repay_amt
    ,c.his_sum_fail_prc_amt/a.his_sum_ovd_repay_amt as heavy_his_sum_fail_prc_amt_divide_light_his_sum_ovd_repay_amt
    ,c.d90_sum_fail_prc_amt/a.d90_sum_ovd_repay_amt as heavy_d90_sum_fail_prc_amt_divide_light_d90_sum_ovd_repay_amt
    ,c.d360_sum_fail_prc_amt/a.d360_sum_ovd_repay_amt as heavy_d360_sum_fail_prc_amt_divide_light_d360_sum_ovd_repay_amt
    ,c.d720_sum_fail_prc_amt/a.d720_sum_ovd_repay_amt as heavy_d720_sum_fail_prc_amt_divide_light_d720_sum_ovd_repay_amt
    
from    light_repay_behaviour_aggregate_to_uid_tmp a
left join heavy_trade_behaviour_aggregate_to_uid_tmp c on a.uid = c.uid and a.mdl_dte = c.mdl_dte
left join heavy_repay_behaviour_aggregate_to_uid_tmp d on a.uid = d.uid and a.mdl_dte = d.mdl_dte
left join (
        select uid,case when first_credit_time_by_btch is null then first_credit_time_all_heavy else first_credit_time_by_btch end as first_credit_time_by_btch,case when first_credit_time_by_btch is null then datetrunc(first_credit_time_all_heavy, 'MM') else datetrunc(first_credit_time_by_btch, 'MM') end as first_credit_mon from dwa.dwa_f_user_first_loan_df where ds = '${bizdate}'
    ) heavy_sx -- 全量授信记录表
on a.uid = heavy_sx.uid
;

--******** 4 轻重资产之间相互借新还旧主题 ********--
-- 借轻去还重，第一步主键还是历史订单，后续要聚合到人维度上
drop table if exists lend_light_to_repay_heavy_inner14d_tmp;
create table lend_light_to_repay_heavy_inner14d_tmp as
select  a.*
        ,size(FILTER(
                     his_all_repay_due_date_list, 
                     x -> ABS(DATEDIFF(date(his_loan_date), to_date(cast(x as string),'yyyymmdd'))) <= 3
                   )) as heavy_due_date_3d_before_and_after_count_light_loan_date
       ,size(FILTER(
             his_all_repay_due_date_list, 
             x -> ABS(DATEDIFF(date(his_loan_date), to_date(cast(x as string),'yyyymmdd'))) <= 7
           )) as heavy_due_date_7d_before_and_after_count_light_loan_date
       ,size(FILTER(
             his_all_repay_due_date_list, 
             x -> ABS(DATEDIFF(date(his_loan_date), to_date(cast(x as string),'yyyymmdd'))) <= 14
           )) as heavy_due_date_14d_before_and_after_count_light_loan_date
from    (
            select  uid,mdl_dte
                   ,dtl_ord_no,crt_dte as his_loan_date,prc_amt as his_loan_amt, stg_num as his_stg_num
                    ,case when datediff(to_date(mdl_dte,'yyyy-mm-dd'),crt_dte) between 1 and 90 then 1 else 0 end as if_d90_tag
                    ,case when datediff(to_date(mdl_dte,'yyyy-mm-dd'),crt_dte) between 1 and 360 then 1 else 0 end as if_d360_tag
                    ,case when datediff(to_date(mdl_dte,'yyyy-mm-dd'),crt_dte) between 1 and 720 then 1 else 0 end as if_d720_tag
            from    cross_inner_behaviour_trade_dimension_qingzichan -- 轻资产历史订单层级 
        ) a
left join (
              SELECT  uid,mdl_dte
                     ,his_all_repay_due_date_list
              FROM    heavy_repay_behaviour_aggregate_to_uid_tmp -- 重资产还款行为聚合到用户粒度
    ) b
on      a.uid = b.uid and a.mdl_dte = b.mdl_dte;
drop table if exists lend_light_to_repay_heavy_inner14d_aggregate_to_uid_tmp2;
create table lend_light_to_repay_heavy_inner14d_aggregate_to_uid_tmp2 as
select uid,mdl_dte
,sum(case when heavy_due_date_3d_before_and_after_count_light_loan_date > 0 then 1 else 0 end) / count(1) as his_lend_light_to_repay_heavy_inner3d_order_num_rate
,sum(case when heavy_due_date_3d_before_and_after_count_light_loan_date > 0 then his_loan_amt else 0 end) / sum(his_loan_amt) as his_lend_light_to_repay_heavy_inner3d_order_amt_rate
,sum(case when heavy_due_date_3d_before_and_after_count_light_loan_date > 0 then his_stg_num else 0 end) / sum(his_stg_num) as his_lend_light_to_repay_heavy_inner3d_order_stg_rate
,sum(case when heavy_due_date_3d_before_and_after_count_light_loan_date > 0 then 1 else 0 end) as his_lend_light_to_repay_heavy_inner3d_order_num_sum
,sum(case when heavy_due_date_3d_before_and_after_count_light_loan_date > 0 then his_loan_amt else 0 end) as his_lend_light_to_repay_heavy_inner3d_order_amt_sum
,sum(case when heavy_due_date_3d_before_and_after_count_light_loan_date > 0 then his_stg_num else 0 end) as his_lend_light_to_repay_heavy_inner3d_order_stg_sum

,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 then 1 else 0 end) / count(1) as his_lend_light_to_repay_heavy_inner7d_order_num_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 then his_loan_amt else 0 end) / sum(his_loan_amt) as his_lend_light_to_repay_heavy_inner7d_order_amt_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 then his_stg_num else 0 end) / sum(his_stg_num) as his_lend_light_to_repay_heavy_inner7d_order_stg_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 then 1 else 0 end) as his_lend_light_to_repay_heavy_inner7d_order_num_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 then his_loan_amt else 0 end) as his_lend_light_to_repay_heavy_inner7d_order_amt_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 then his_stg_num else 0 end) as his_lend_light_to_repay_heavy_inner7d_order_stg_sum

,sum(case when heavy_due_date_14d_before_and_after_count_light_loan_date > 0 then 1 else 0 end) / count(1) as his_lend_light_to_repay_heavy_inner14d_order_num_rate
,sum(case when heavy_due_date_14d_before_and_after_count_light_loan_date > 0 then his_loan_amt else 0 end) / sum(his_loan_amt) as his_lend_light_to_repay_heavy_inner14d_order_amt_rate
,sum(case when heavy_due_date_14d_before_and_after_count_light_loan_date > 0 then his_stg_num else 0 end) / sum(his_stg_num) as his_lend_light_to_repay_heavy_inner14d_order_stg_rate
,sum(case when heavy_due_date_14d_before_and_after_count_light_loan_date > 0 then 1 else 0 end) as his_lend_light_to_repay_heavy_inner14d_order_num_sum
,sum(case when heavy_due_date_14d_before_and_after_count_light_loan_date > 0 then his_loan_amt else 0 end) as his_lend_light_to_repay_heavy_inner14d_order_amt_sum
,sum(case when heavy_due_date_14d_before_and_after_count_light_loan_date > 0 then his_stg_num else 0 end) as his_lend_light_to_repay_heavy_inner14d_order_stg_sum

-- 20250513 特征评审会要求加上时间窗口限制，防止冗余特征过多，取前后7天限制
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d90_tag = 1 then 1 else 0 end) / sum(case when if_d90_tag = 1 then 1 else 0 end) as d90_lend_light_to_repay_heavy_inner7d_order_num_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d90_tag = 1 then his_loan_amt else 0 end) / sum(case when if_d90_tag = 1 then his_loan_amt else 0 end) as d90_lend_light_to_repay_heavy_inner7d_order_amt_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d90_tag = 1 then his_stg_num else 0 end) / sum(case when if_d90_tag = 1 then his_stg_num else 0 end) as d90_lend_light_to_repay_heavy_inner7d_order_stg_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d90_tag = 1 then 1 else 0 end) as d90_lend_light_to_repay_heavy_inner7d_order_num_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d90_tag = 1 then his_loan_amt else 0 end) as d90_lend_light_to_repay_heavy_inner7d_order_amt_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d90_tag = 1 then his_stg_num else 0 end) as d90_lend_light_to_repay_heavy_inner7d_order_stg_sum

,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d360_tag = 1 then 1 else 0 end) / sum(case when if_d360_tag = 1 then 1 else 0 end) as d360_lend_light_to_repay_heavy_inner7d_order_num_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d360_tag = 1 then his_loan_amt else 0 end) / sum(case when if_d360_tag = 1 then his_loan_amt else 0 end) as d360_lend_light_to_repay_heavy_inner7d_order_amt_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d360_tag = 1 then his_stg_num else 0 end) / sum(case when if_d360_tag = 1 then his_stg_num else 0 end) as d360_lend_light_to_repay_heavy_inner7d_order_stg_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d360_tag = 1 then 1 else 0 end) as d360_lend_light_to_repay_heavy_inner7d_order_num_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d360_tag = 1 then his_loan_amt else 0 end) as d360_lend_light_to_repay_heavy_inner7d_order_amt_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d360_tag = 1 then his_stg_num else 0 end) as d360_lend_light_to_repay_heavy_inner7d_order_stg_sum

,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d720_tag = 1 then 1 else 0 end) / sum(case when if_d720_tag = 1 then 1 else 0 end) as d720_lend_light_to_repay_heavy_inner7d_order_num_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d720_tag = 1 then his_loan_amt else 0 end) / sum(case when if_d720_tag = 1 then his_loan_amt else 0 end) as d720_lend_light_to_repay_heavy_inner7d_order_amt_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d720_tag = 1 then his_stg_num else 0 end) / sum(case when if_d720_tag = 1 then his_stg_num else 0 end) as d720_lend_light_to_repay_heavy_inner7d_order_stg_rate
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d720_tag = 1 then 1 else 0 end) as d720_lend_light_to_repay_heavy_inner7d_order_num_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d720_tag = 1 then his_loan_amt else 0 end) as d720_lend_light_to_repay_heavy_inner7d_order_amt_sum
,sum(case when heavy_due_date_7d_before_and_after_count_light_loan_date > 0 and if_d720_tag = 1 then his_stg_num else 0 end) as d720_lend_light_to_repay_heavy_inner7d_order_stg_sum

 from lend_light_to_repay_heavy_inner14d_tmp
group by uid,mdl_dte;

-- 借重去还轻
drop table if exists lend_heavy_to_repay_light_inner14d_tmp;
create table lend_heavy_to_repay_light_inner14d_tmp as
select  a.*
       ,size(FILTER(
             his_all_repay_due_date_list, 
             x -> ABS(DATEDIFF(date(his_loan_date), to_date(cast(x as string),'yyyymmdd'))) <= 3
           )) as light_due_date_3d_before_and_after_count_heavy_loan_date
       ,size(FILTER(
             his_all_repay_due_date_list, 
             x -> ABS(DATEDIFF(date(his_loan_date), to_date(cast(x as string),'yyyymmdd'))) <= 7
           )) as light_due_date_7d_before_and_after_count_heavy_loan_date
       ,size(FILTER(
             his_all_repay_due_date_list, 
             x -> ABS(DATEDIFF(date(his_loan_date), to_date(cast(x as string),'yyyymmdd'))) <= 14
           )) as light_due_date_14d_before_and_after_count_heavy_loan_date
from    (
            select  uid,mdl_dte
                   ,dtl_ord_no,crt_dte as his_loan_date,prc_amt as his_loan_amt, stg_num as his_stg_num
                    ,case when datediff(to_date(mdl_dte,'yyyy-mm-dd'),crt_dte) between 1 and 90 then 1 else 0 end as if_d90_tag
                    ,case when datediff(to_date(mdl_dte,'yyyy-mm-dd'),crt_dte) between 1 and 360 then 1 else 0 end as if_d360_tag
                    ,case when datediff(to_date(mdl_dte,'yyyy-mm-dd'),crt_dte) between 1 and 720 then 1 else 0 end as if_d720_tag
            from    dwa_risk_cross_inner_behaviour_trade_dimension_analysis_sample_tmp -- 重资产历史订单层级 
        ) a
left join (
              SELECT  uid,mdl_dte
                     ,his_all_repay_due_date_list
              FROM    light_repay_behaviour_aggregate_to_uid_tmp -- 轻资产还款行为聚合到用户粒度
    ) b
on      a.uid = b.uid and a.mdl_dte = b.mdl_dte;

drop table if exists lend_heavy_to_repay_light_inner14d_aggregate_to_uid_tmp2;
create table lend_heavy_to_repay_light_inner14d_aggregate_to_uid_tmp2 as
select uid,mdl_dte
,sum(case when light_due_date_3d_before_and_after_count_heavy_loan_date > 0 then 1 else 0 end) / count(1) as his_lend_heavy_to_repay_light_inner3d_order_num_rate
,sum(case when light_due_date_3d_before_and_after_count_heavy_loan_date > 0 then his_loan_amt else 0 end) / sum(his_loan_amt) as his_lend_heavy_to_repay_light_inner3d_order_amt_rate
,sum(case when light_due_date_3d_before_and_after_count_heavy_loan_date > 0 then his_stg_num else 0 end) / sum(his_stg_num) as his_lend_heavy_to_repay_light_inner3d_order_stg_rate
,sum(case when light_due_date_3d_before_and_after_count_heavy_loan_date > 0 then 1 else 0 end) as his_lend_heavy_to_repay_light_inner3d_order_num_sum
,sum(case when light_due_date_3d_before_and_after_count_heavy_loan_date > 0 then his_loan_amt else 0 end) as his_lend_heavy_to_repay_light_inner3d_order_amt_sum
,sum(case when light_due_date_3d_before_and_after_count_heavy_loan_date > 0 then his_stg_num else 0 end) as his_lend_heavy_to_repay_light_inner3d_order_stg_sum

,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 then 1 else 0 end) / count(1) as his_lend_heavy_to_repay_light_inner7d_order_num_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 then his_loan_amt else 0 end) / sum(his_loan_amt) as his_lend_heavy_to_repay_light_inner7d_order_amt_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 then his_stg_num else 0 end) / sum(his_stg_num) as his_lend_heavy_to_repay_light_inner7d_order_stg_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 then 1 else 0 end) as his_lend_heavy_to_repay_light_inner7d_order_num_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 then his_loan_amt else 0 end) as his_lend_heavy_to_repay_light_inner7d_order_amt_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 then his_stg_num else 0 end) as his_lend_heavy_to_repay_light_inner7d_order_stg_sum

,sum(case when light_due_date_14d_before_and_after_count_heavy_loan_date > 0 then 1 else 0 end) / count(1) as his_lend_heavy_to_repay_light_inner14d_order_num_rate
,sum(case when light_due_date_14d_before_and_after_count_heavy_loan_date > 0 then his_loan_amt else 0 end) / sum(his_loan_amt) as his_lend_heavy_to_repay_light_inner14d_order_amt_rate
,sum(case when light_due_date_14d_before_and_after_count_heavy_loan_date > 0 then his_stg_num else 0 end) / sum(his_stg_num) as his_lend_heavy_to_repay_light_inner14d_order_stg_rate
,sum(case when light_due_date_14d_before_and_after_count_heavy_loan_date > 0 then 1 else 0 end) as his_lend_heavy_to_repay_light_inner14d_order_num_sum
,sum(case when light_due_date_14d_before_and_after_count_heavy_loan_date > 0 then his_loan_amt else 0 end) as his_lend_heavy_to_repay_light_inner14d_order_amt_sum
,sum(case when light_due_date_14d_before_and_after_count_heavy_loan_date > 0 then his_stg_num else 0 end) as his_lend_heavy_to_repay_light_inner14d_order_stg_sum


-- 20250513 特征评审会要求加上时间窗口限制，防止特征过于冗余，取前后7天限制
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d90_tag = 1 then 1 else 0 end) / sum(case when if_d90_tag = 1 then 1 else 0 end) as d90_lend_heavy_to_repay_light_inner7d_order_num_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d90_tag = 1 then his_loan_amt else 0 end) / sum(case when if_d90_tag = 1 then his_loan_amt else 0 end) as d90_lend_heavy_to_repay_light_inner7d_order_amt_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d90_tag = 1 then his_stg_num else 0 end) / sum(case when if_d90_tag = 1 then his_stg_num else 0 end) as d90_lend_heavy_to_repay_light_inner7d_order_stg_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d90_tag = 1 then 1 else 0 end) as d90_lend_heavy_to_repay_light_inner7d_order_num_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d90_tag = 1 then his_loan_amt else 0 end) as d90_lend_heavy_to_repay_light_inner7d_order_amt_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d90_tag = 1 then his_stg_num else 0 end) as d90_lend_heavy_to_repay_light_inner7d_order_stg_sum

,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d360_tag = 1 then 1 else 0 end) / sum(case when if_d360_tag = 1 then 1 else 0 end) as d360_lend_heavy_to_repay_light_inner7d_order_num_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d360_tag = 1 then his_loan_amt else 0 end) / sum(case when if_d360_tag = 1 then his_loan_amt else 0 end) as d360_lend_heavy_to_repay_light_inner7d_order_amt_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d360_tag = 1 then his_stg_num else 0 end) / sum(case when if_d360_tag = 1 then his_stg_num else 0 end) as d360_lend_heavy_to_repay_light_inner7d_order_stg_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d360_tag = 1 then 1 else 0 end) as d360_lend_heavy_to_repay_light_inner7d_order_num_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d360_tag = 1 then his_loan_amt else 0 end) as d360_lend_heavy_to_repay_light_inner7d_order_amt_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d360_tag = 1 then his_stg_num else 0 end) as d360_lend_heavy_to_repay_light_inner7d_order_stg_sum

,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d720_tag = 1 then 1 else 0 end) / sum(case when if_d720_tag = 1 then 1 else 0 end) as d720_lend_heavy_to_repay_light_inner7d_order_num_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d720_tag = 1 then his_loan_amt else 0 end) / sum(case when if_d720_tag = 1 then his_loan_amt else 0 end) as d720_lend_heavy_to_repay_light_inner7d_order_amt_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d720_tag = 1 then his_stg_num else 0 end) / sum(case when if_d720_tag = 1 then his_stg_num else 0 end) as d720_lend_heavy_to_repay_light_inner7d_order_stg_rate
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d720_tag = 1 then 1 else 0 end) as d720_lend_heavy_to_repay_light_inner7d_order_num_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d720_tag = 1 then his_loan_amt else 0 end) as d720_lend_heavy_to_repay_light_inner7d_order_amt_sum
,sum(case when light_due_date_7d_before_and_after_count_heavy_loan_date > 0 and if_d720_tag = 1 then his_stg_num else 0 end) as d720_lend_heavy_to_repay_light_inner7d_order_stg_sum

 from lend_heavy_to_repay_light_inner14d_tmp
group by uid,mdl_dte;


--******** 5 轻重资产负债CROSS ********--
drop table if exists light_fuzhai_heavy_fuzhai_cross_tmp;
create table if not exists light_fuzhai_heavy_fuzhai_cross_tmp as
select main.uid,main.mdl_dte
,main.unpaid_principal_tot / c.unpaid_principal_tot as unpaid_principal_tot_light_divide_heavy
,main.unpaid_principal_his / c.unpaid_principal_his as unpaid_principal_his_light_divide_heavy
,main.unpaid_principal_future / c.unpaid_principal_future as unpaid_principal_future_light_divide_heavy
,main.unpaid_principal_tot + c.unpaid_principal_tot as unpaid_principal_tot_light_add_heavy
,main.unpaid_principal_his + c.unpaid_principal_his as unpaid_principal_his_light_add_heavy
,main.unpaid_principal_future + c.unpaid_principal_future as unpaid_principal_future_light_add_heavy
from light_upaid_principal_aggregate_to_uid_tmp main
left join (
        select uid,mdl_dte,unpaid_principal_tot,unpaid_principal_his,unpaid_principal_future from 
    dwa_risk.dwa_risk_f_unpaid_order_amount_basic_df where ds = '${bizdate}'
    ) C
on main.uid = c.uid and main.mdl_dte = c.mdl_dte;


--********************************************************************--
--最终将所有的子特征表combine在一起
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_dz_model_30light_cross_heavy_inner_behaviour_df (
uid STRING comment 'uid',
mdl_dte STRING comment '评分日T日，yyyy-mm-dd',
his_light_limit_divide_btch_adt_limit double comment '历史至今轻资产总授信额度/重资产授信额度',
his_light_limit_divide_btch_avl_limit double comment '历史至今轻资产总授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_his_light_limit decimal(38,18) comment '重资产总应还本金/历史至今轻资产总授信额度',
heavy_unpaid_principal_his_divide_his_light_limit decimal(38,18) comment '重资产历史到期未还本金/历史至今轻资产总授信额度',
heavy_unpaid_principal_future_divide_his_light_limit decimal(38,18) comment '重资产未来到期未还本金/历史至今轻资产总授信额度',
heavy_unpaid_total_amount_tot_divide_his_light_limit decimal(38,18) comment '重资产总未还金额/历史至今轻资产总授信额度',
d90_light_limit_divide_btch_adt_limit double comment '近90天轻资产总授信额度/重资产授信额度',
d90_light_limit_divide_btch_avl_limit double comment '近90天轻资产总授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_d90_light_limit decimal(38,18) comment '重资产总应还本金/近90天轻资产总授信额度',
heavy_unpaid_principal_his_divide_d90_light_limit decimal(38,18) comment '重资产历史到期未还本金/近90天轻资产总授信额度',
heavy_unpaid_principal_future_divide_d90_light_limit decimal(38,18) comment '重资产未来到期未还本金/近90天轻资产总授信额度',
heavy_unpaid_total_amount_tot_divide_d90_light_limit decimal(38,18) comment '重资产总未还金额/近90天轻资产总授信额度',
d360_light_limit_divide_btch_adt_limit double comment '近360天轻资产总授信额度/重资产授信额度',
d360_light_limit_divide_btch_avl_limit double comment '近360天轻资产总授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_d360_light_limit decimal(38,18) comment '重资产总应还本金/近360天轻资产总授信额度',
heavy_unpaid_principal_his_divide_d360_light_limit decimal(38,18) comment '重资产历史到期未还本金/近360天轻资产总授信额度',
heavy_unpaid_principal_future_divide_d360_light_limit decimal(38,18) comment '重资产未来到期未还本金/近360天轻资产总授信额度',
heavy_unpaid_total_amount_tot_divide_d360_light_limit decimal(38,18) comment '重资产总未还金额/近360天轻资产总授信额度',
d720_light_limit_divide_btch_adt_limit double comment '近720天轻资产总授信额度/重资产授信额度',
d720_light_limit_divide_btch_avl_limit double comment '近720天轻资产总授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_d720_light_limit decimal(38,18) comment '重资产总应还本金/近720天轻资产总授信额度',
heavy_unpaid_principal_his_divide_d720_light_limit decimal(38,18) comment '重资产历史到期未还本金/近720天轻资产总授信额度',
heavy_unpaid_principal_future_divide_d720_light_limit decimal(38,18) comment '重资产未来到期未还本金/近720天轻资产总授信额度',
heavy_unpaid_total_amount_tot_divide_d720_light_limit decimal(38,18) comment '重资产总未还金额/近720天轻资产总授信额度',
his_light_limit_max_divide_btch_adt_limit double comment '历史至今轻资产最大授信额度/重资产授信额度',
his_light_limit_max_divide_btch_avl_limit double comment '历史至今轻资产最大授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_his_light_limit_max decimal(38,18) comment '重资产总应还本金/历史至今轻资产最大授信额度',
heavy_unpaid_principal_his_divide_his_light_limit_max decimal(38,18) comment '重资产历史到期未还本金/历史至今轻资产最大授信额度',
heavy_unpaid_principal_future_divide_his_light_limit_max decimal(38,18) comment '重资产未来到期未还本金/历史至今轻资产最大授信额度',
heavy_unpaid_total_amount_tot_divide_his_light_limit_max decimal(38,18) comment '重资产总未还金额/历史至今轻资产最大授信额度',
d90_light_limit_max_divide_btch_adt_limit double comment '近90天轻资产最大授信额度/重资产授信额度',
d90_light_limit_max_divide_btch_avl_limit double comment '近90天轻资产最大授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_d90_light_limit_max decimal(38,18) comment '重资产总应还本金/近90天轻资产最大授信额度',
heavy_unpaid_principal_his_divide_d90_light_limit_max decimal(38,18) comment '重资产历史到期未还本金/近90天轻资产最大授信额度',
heavy_unpaid_principal_future_divide_d90_light_limit_max decimal(38,18) comment '重资产未来到期未还本金/近90天轻资产最大授信额度',
heavy_unpaid_total_amount_tot_divide_d90_light_limit_max decimal(38,18) comment '重资产总未还金额/近90天轻资产最大授信额度',
d360_light_limit_max_divide_btch_adt_limit double comment '近360天轻资产最大授信额度/重资产授信额度',
d360_light_limit_max_divide_btch_avl_limit double comment '近360天轻资产最大授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_d360_light_limit_max decimal(38,18) comment '重资产总应还本金/近360天轻资产最大授信额度',
heavy_unpaid_principal_his_divide_d360_light_limit_max decimal(38,18) comment '重资产历史到期未还本金/近360天轻资产最大授信额度',
heavy_unpaid_principal_future_divide_d360_light_limit_max decimal(38,18) comment '重资产未来到期未还本金/近360天轻资产最大授信额度',
heavy_unpaid_total_amount_tot_divide_d360_light_limit_max decimal(38,18) comment '重资产总未还金额/近360天轻资产最大授信额度',
d720_light_limit_max_divide_btch_adt_limit double comment '近720天轻资产最大授信额度/重资产授信额度',
d720_light_limit_max_divide_btch_avl_limit double comment '近720天轻资产最大授信额度/重资产可用额度',
heavy_unpaid_principal_tot_divide_d720_light_limit_max decimal(38,18) comment '重资产总应还本金/近720天轻资产最大授信额度',
heavy_unpaid_principal_his_divide_d720_light_limit_max decimal(38,18) comment '重资产历史到期未还本金/近720天轻资产最大授信额度',
heavy_unpaid_principal_future_divide_d720_light_limit_max decimal(38,18) comment '重资产未来到期未还本金/近720天轻资产最大授信额度',
heavy_unpaid_total_amount_tot_divide_d720_light_limit_max decimal(38,18) comment '重资产总未还金额/近720天轻资产最大授信额度',
his_heavy_shouxin_inner30d_light_shouxin_count int comment '历史至今重资产授信前后30天内轻资产授信资方数',
his_heavy_shouxin_samemonth_light_shouxin_count int comment '历史至今与重资产授信发生在同一个月的轻资产授信资方数',
his_light_shouxin_heavy_suc_trade_same_date_count int comment '轻资产授信与重资产成功交易发生在同一个天的unique日期数',
his_light_shouxin_heavy_suc_trade_same_month_count int comment '轻资产授信与重资产成功交易发生在同一个月的月份数',
his_light_shouxin_heavy_fail_trade_same_date_count int comment '轻资产授信与重资产失败交易发生在同一个天的unique日期数',
his_light_shouxin_heavy_fail_trade_same_month_count int comment '轻资产授信与重资产失败交易发生在同一个月的月份数',
his_heavy_shouxin_inner30d_light_trade_suc_count int comment '轻资产成功交易日在重资产授信日前后30天内的笔数',
his_heavy_shouxin_inner30d_light_trade_fail_count int comment '轻资产失败交易日在重资产授信日前后30天内的笔数',
his_heavy_shouxin_samemonth_light_trade_suc_count int comment '轻资产成功交易日与重资产授信日在同一个月的笔数',
his_heavy_shouxin_samemonth_light_trade_fail_count int comment '轻资产失败交易日与重资产授信日在同一个月的笔数',
his_heavy_light_suc_trade_same_month_count int comment '轻资产成功交易与重资产成功交易发生在同一个月的月份数',
his_heavy_light_fail_trade_same_month_count int comment '轻资产失败交易与重资产失败交易发生在同一个月的月份数',
his_heavy_light_suc_trade_same_date_count int comment '轻资产成功交易与重资产成功交易发生在同一天的unique日期数',
his_heavy_light_fail_trade_same_date_count int comment '轻资产失败交易与重资产失败交易发生在同一天的unique日期数',
his_light_suc_trade_heavy_ovd_repay_same_month_count int comment '轻资产成功交易与重资产逾期还款发生在同一个月的月份数',
his_light_suc_trade_heavy_ovd_repay_same_date_count int comment '轻资产成功交易与重资产逾期还款发生在同一个天的unique日期数',
his_light_fail_trade_heavy_ovd_repay_same_month_count int comment '轻资产fail交易与重资产逾期还款发生在同一个月的月份数',
his_light_fail_trade_heavy_ovd_repay_same_date_count int comment '轻资产fail交易与重资产逾期还款发生在同一个天的unique日期数',
his_light_suc_trade_heavy_advance_repay_same_month_count int comment '历史至今轻资产交易成功与重资产提前还款(实还日)发生在同一个月的月份数',
his_light_suc_trade_heavy_advance_repay_same_date_count int comment '历史至今轻资产交易成功与重资产提前还款(实还日)发生在同天的unique日期数',
light_his_max_faqi_prc_amt_divide_heavy_his_max_faqi_prc_amt decimal(38,18) comment '历史至今轻资产最大借款发起本金/历史至今重资产最大借款发起本金',
light_d90_max_faqi_prc_amt_divide_heavy_d90_max_faqi_prc_amt decimal(38,18) comment '近90天轻资产最大借款发起本金/近90天重资产最大借款发起本金',
light_d360_max_faqi_prc_amt_divide_heavy_d360_max_faqi_prc_amt decimal(38,18) comment '近360天轻资产最大借款发起本金/近360天重资产最大借款发起本金',
light_d720_max_faqi_prc_amt_divide_heavy_d720_max_faqi_prc_amt decimal(38,18) comment '近720天轻资产最大借款发起本金/近720天重资产最大借款发起本金',
light_his_sum_faqi_prc_amt_divide_heavy_his_sum_faqi_prc_amt decimal(38,18) comment '历史至今轻资产借款发起本金总和/历史至今重资产借款发起本金总和',
light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_faqi_prc_amt decimal(38,18) comment '近90天轻资产借款发起本金总和/近90天重资产借款发起本金总和',
light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_faqi_prc_amt decimal(38,18) comment '近360天轻资产借款发起本金总和/近360天重资产借款发起本金总和',
light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_faqi_prc_amt decimal(38,18) comment '近720天轻资产借款发起本金总和/近720天重资产借款发起本金总和',
light_his_sum_faqi_stg_num_divide_heavy_his_sum_faqi_stg_num double comment '历史至今轻资产借款发起期限总和/历史至今重资产借款发起期限总和',
light_d90_sum_faqi_stg_num_divide_heavy_d90_sum_faqi_stg_num double comment '近90天轻资产借款发起期限总和/近90天重资产借款发起期限总和',
light_d360_sum_faqi_stg_num_divide_heavy_d360_sum_faqi_stg_num double comment '近360天轻资产借款发起期限总和/近360天重资产借款发起期限总和',
light_d720_sum_faqi_stg_num_divide_heavy_d720_sum_faqi_stg_num double comment '近720天轻资产借款发起期限总和/近720天重资产借款发起期限总和',
light_his_sum_faqi_count_divide_heavy_his_sum_faqi_count double comment '历史至今轻资产借款发起笔数总和/历史至今重资产借款发起笔数总和',
light_d90_sum_faqi_count_divide_heavy_d90_sum_faqi_count double comment '近90天轻资产借款发起笔数总和/近90天重资产借款发起笔数总和',
light_d360_sum_faqi_count_divide_heavy_d360_sum_faqi_count double comment '近360天轻资产借款发起笔数总和/近360天重资产借款发起笔数总和',
light_d720_sum_faqi_count_divide_heavy_d720_sum_faqi_count double comment '近720天轻资产借款发起笔数总和/近720天重资产借款发起笔数总和',
light_his_sum_larger_than_1w_faqi_count_divide_heavy_his_sum_larger_than_1w_faqi_count double comment '历史至今轻资产借款发起本金超过1万元笔数总和/历史至今重资产借款发起本金超过1万元笔数总和',
light_d90_sum_larger_than_1w_faqi_count_divide_heavy_d90_sum_larger_than_1w_faqi_count double comment '近90天轻资产借款发起本金超过1万元笔数总和/近90天重资产借款发起本金超过1万元笔数总和',
light_d360_sum_larger_than_1w_faqi_count_divide_heavy_d360_sum_larger_than_1w_faqi_count double comment '近360天轻资产借款发起本金超过1万元笔数总和/近360天重资产借款发起本金超过1万元笔数总和',
light_d720_sum_larger_than_1w_faqi_count_divide_heavy_d720_sum_larger_than_1w_faqi_count double comment '近720天轻资产借款发起本金超过1万元笔数总和/近720天重资产借款发起本金超过1万元笔数总和',
light_his_max_suc_prc_amt_divide_heavy_his_max_suc_prc_amt decimal(38,18) comment '历史至今轻资产最大借款成功本金/历史至今重资产最大借款成功本金',
light_d90_max_suc_prc_amt_divide_heavy_d90_max_suc_prc_amt decimal(38,18) comment '近90天轻资产最大借款成功本金/近90天重资产最大借款成功本金',
light_d360_max_suc_prc_amt_divide_heavy_d360_max_suc_prc_amt decimal(38,18) comment '近360天轻资产最大借款成功本金/近360天重资产最大借款成功本金',
light_d720_max_suc_prc_amt_divide_heavy_d720_max_suc_prc_amt decimal(38,18) comment '近720天轻资产最大借款成功本金/近720天重资产最大借款成功本金',
light_his_sum_suc_prc_amt_divide_heavy_his_sum_suc_prc_amt decimal(38,18) comment '历史至今轻资产借款成功本金总和/历史至今重资产借款成功本金总和',
light_d90_sum_suc_prc_amt_divide_heavy_d90_sum_suc_prc_amt decimal(38,18) comment '近90天轻资产借款成功本金总和/近90天重资产借款成功本金总和',
light_d360_sum_suc_prc_amt_divide_heavy_d360_sum_suc_prc_amt decimal(38,18) comment '近360天轻资产借款成功本金总和/近360天重资产借款成功本金总和',
light_d720_sum_suc_prc_amt_divide_heavy_d720_sum_suc_prc_amt decimal(38,18) comment '近720天轻资产借款成功本金总和/近720天重资产借款成功本金总和',
light_his_max_fail_prc_amt_divide_heavy_his_max_fail_prc_amt decimal(38,18) comment '历史至今轻资产最大借款失败本金/历史至今重资产最大借款失败本金',
light_d90_max_fail_prc_amt_divide_heavy_d90_max_fail_prc_amt decimal(38,18) comment '近90天轻资产最大借款失败本金/近90天重资产最大借款失败本金',
light_d360_max_fail_prc_amt_divide_heavy_d360_max_fail_prc_amt decimal(38,18) comment '近360天轻资产最大借款失败本金/近360天重资产最大借款失败本金',
light_d720_max_fail_prc_amt_divide_heavy_d720_max_fail_prc_amt decimal(38,18) comment '近720天轻资产最大借款失败本金/近720天重资产最大借款失败本金',
light_his_sum_fail_prc_amt_divide_heavy_his_sum_fail_prc_amt decimal(38,18) comment '历史至今轻资产借款失败本金总和/历史至今重资产借款失败本金总和',
light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_fail_prc_amt decimal(38,18) comment '近90天轻资产借款失败本金总和/近90天重资产借款失败本金总和',
light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_fail_prc_amt decimal(38,18) comment '近360天轻资产借款失败本金总和/近360天重资产借款失败本金总和',
light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_fail_prc_amt decimal(38,18) comment '近720天轻资产借款失败本金总和/近720天重资产借款失败本金总和',
light_his_max_faqi_prc_amt_divide_heavy_his_max_ontim_repay_amt decimal(38,18) comment '历史至今轻资产最大借款发起本金/历史至今重资产最大按时还款本金',
light_d90_max_faqi_prc_amt_divide_heavy_d90_max_ontim_repay_amt decimal(38,18) comment '近90天轻资产最大借款发起本金/近90天重资产最大按时还款本金',
light_d360_max_faqi_prc_amt_divide_heavy_d360_max_ontim_repay_amt decimal(38,18) comment '近360天轻资产最大借款发起本金/近360天重资产最大按时还款本金',
light_d720_max_faqi_prc_amt_divide_heavy_d720_max_ontim_repay_amt decimal(38,18) comment '近720天轻资产最大借款发起本金/近720天重资产最大按时还款本金',
light_his_sum_faqi_prc_amt_divide_heavy_his_sum_ontim_repay_amt decimal(38,18) comment '历史至今轻资产借款发起本金总和/历史至今重资产按时还款本金总和',
light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_ontim_repay_amt decimal(38,18) comment '近90天轻资产借款发起本金总和/近90天重资产按时还款本金总和',
light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_ontim_repay_amt decimal(38,18) comment '近360天轻资产借款发起本金总和/近360天重资产按时还款本金总和',
light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_ontim_repay_amt decimal(38,18) comment '近720天轻资产借款发起本金总和/近720天重资产按时还款本金总和',
light_his_max_faqi_prc_amt_divide_heavy_his_max_adv_repay_amt decimal(38,18) comment '历史至今轻资产最大借款发起本金/历史至今重资产最大提前还款本金',
light_d90_max_faqi_prc_amt_divide_heavy_d90_max_adv_repay_amt decimal(38,18) comment '近90天轻资产最大借款发起本金/近90天重资产最大提前还款本金',
light_d360_max_faqi_prc_amt_divide_heavy_d360_max_adv_repay_amt decimal(38,18) comment '近360天轻资产最大借款发起本金/近360天重资产最大提前还款本金',
light_d720_max_faqi_prc_amt_divide_heavy_d720_max_adv_repay_amt decimal(38,18) comment '近720天轻资产最大借款发起本金/近720天重资产最大提前还款本金',
light_his_sum_faqi_prc_amt_divide_heavy_his_sum_adv_repay_amt decimal(38,18) comment '历史至今轻资产借款发起本金总和/历史至今重资产提前还款本金总和',
light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_adv_repay_amt decimal(38,18) comment '近90天轻资产借款发起本金总和/近90天重资产提前还款本金总和',
light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_adv_repay_amt decimal(38,18) comment '近360天轻资产借款发起本金总和/近360天重资产提前还款本金总和',
light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_adv_repay_amt decimal(38,18) comment '近720天轻资产借款发起本金总和/近720天重资产提前还款本金总和',
light_his_max_faqi_prc_amt_divide_heavy_his_max_ovd_repay_amt decimal(38,18) comment '历史至今轻资产最大借款发起本金/历史至今重资产最大逾期还款本金',
light_d90_max_faqi_prc_amt_divide_heavy_d90_max_ovd_repay_amt decimal(38,18) comment '近90天轻资产最大借款发起本金/近90天重资产最大逾期还款本金',
light_d360_max_faqi_prc_amt_divide_heavy_d360_max_ovd_repay_amt decimal(38,18) comment '近360天轻资产最大借款发起本金/近360天重资产最大逾期还款本金',
light_d720_max_faqi_prc_amt_divide_heavy_d720_max_ovd_repay_amt decimal(38,18) comment '近720天轻资产最大借款发起本金/近720天重资产最大逾期还款本金',
light_his_sum_faqi_prc_amt_divide_heavy_his_sum_ovd_repay_amt decimal(38,18) comment '历史至今轻资产借款发起本金总和/历史至今重资产逾期还款本金总和',
light_d90_sum_faqi_prc_amt_divide_heavy_d90_sum_ovd_repay_amt decimal(38,18) comment '近90天轻资产借款发起本金总和/近90天重资产逾期还款本金总和',
light_d360_sum_faqi_prc_amt_divide_heavy_d360_sum_ovd_repay_amt decimal(38,18) comment '近360天轻资产借款发起本金总和/近360天重资产逾期还款本金总和',
light_d720_sum_faqi_prc_amt_divide_heavy_d720_sum_ovd_repay_amt decimal(38,18) comment '近720天轻资产借款发起本金总和/近720天重资产逾期还款本金总和',
light_his_max_fail_prc_amt_divide_heavy_his_max_ontim_repay_amt decimal(38,18) comment '历史至今轻资产最大借款失败本金/历史至今重资产最大按时还款本金',
light_d90_max_fail_prc_amt_divide_heavy_d90_max_ontim_repay_amt decimal(38,18) comment '近90天轻资产最大借款失败本金/近90天重资产最大按时还款本金',
light_d360_max_fail_prc_amt_divide_heavy_d360_max_ontim_repay_amt decimal(38,18) comment '近360天轻资产最大借款失败本金/近360天重资产最大按时还款本金',
light_d720_max_fail_prc_amt_divide_heavy_d720_max_ontim_repay_amt decimal(38,18) comment '近720天轻资产最大借款失败本金/近720天重资产最大按时还款本金',
light_his_sum_fail_prc_amt_divide_heavy_his_sum_ontim_repay_amt decimal(38,18) comment '历史至今轻资产借款失败本金总和/历史至今重资产按时还款本金总和',
light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_ontim_repay_amt decimal(38,18) comment '近90天轻资产借款失败本金总和/近90天重资产按时还款本金总和',
light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_ontim_repay_amt decimal(38,18) comment '近360天轻资产借款失败本金总和/近360天重资产按时还款本金总和',
light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_ontim_repay_amt decimal(38,18) comment '近720天轻资产借款失败本金总和/近720天重资产按时还款本金总和',
light_his_max_fail_prc_amt_divide_heavy_his_max_adv_repay_amt decimal(38,18) comment '历史至今轻资产最大借款失败本金/历史至今重资产最大提前还款本金',
light_d90_max_fail_prc_amt_divide_heavy_d90_max_adv_repay_amt decimal(38,18) comment '近90天轻资产最大借款失败本金/近90天重资产最大提前还款本金',
light_d360_max_fail_prc_amt_divide_heavy_d360_max_adv_repay_amt decimal(38,18) comment '近360天轻资产最大借款失败本金/近360天重资产最大提前还款本金',
light_d720_max_fail_prc_amt_divide_heavy_d720_max_adv_repay_amt decimal(38,18) comment '近720天轻资产最大借款失败本金/近720天重资产最大提前还款本金',
light_his_sum_fail_prc_amt_divide_heavy_his_sum_adv_repay_amt decimal(38,18) comment '历史至今轻资产借款失败本金总和/历史至今重资产提前还款本金总和',
light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_adv_repay_amt decimal(38,18) comment '近90天轻资产借款失败本金总和/近90天重资产提前还款本金总和',
light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_adv_repay_amt decimal(38,18) comment '近360天轻资产借款失败本金总和/近360天重资产提前还款本金总和',
light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_adv_repay_amt decimal(38,18) comment '近720天轻资产借款失败本金总和/近720天重资产提前还款本金总和',
light_his_max_fail_prc_amt_divide_heavy_his_max_ovd_repay_amt decimal(38,18) comment '历史至今轻资产最大借款失败本金/历史至今重资产最大逾期还款本金',
light_d90_max_fail_prc_amt_divide_heavy_d90_max_ovd_repay_amt decimal(38,18) comment '近90天轻资产最大借款失败本金/近90天重资产最大逾期还款本金',
light_d360_max_fail_prc_amt_divide_heavy_d360_max_ovd_repay_amt decimal(38,18) comment '近360天轻资产最大借款失败本金/近360天重资产最大逾期还款本金',
light_d720_max_fail_prc_amt_divide_heavy_d720_max_ovd_repay_amt decimal(38,18) comment '近720天轻资产最大借款失败本金/近720天重资产最大逾期还款本金',
light_his_sum_fail_prc_amt_divide_heavy_his_sum_ovd_repay_amt decimal(38,18) comment '历史至今轻资产借款失败本金总和/历史至今重资产逾期还款本金总和',
light_d90_sum_fail_prc_amt_divide_heavy_d90_sum_ovd_repay_amt decimal(38,18) comment '近90天轻资产借款失败本金总和/近90天重资产逾期还款本金总和',
light_d360_sum_fail_prc_amt_divide_heavy_d360_sum_ovd_repay_amt decimal(38,18) comment '近360天轻资产借款失败本金总和/近360天重资产逾期还款本金总和',
light_d720_sum_fail_prc_amt_divide_heavy_d720_sum_ovd_repay_amt decimal(38,18) comment '近720天轻资产借款失败本金总和/近720天重资产逾期还款本金总和',
his_heavy_suc_trade_light_ovd_repay_same_month_count int comment '重资产成功交易与轻资产逾期还款发生在同一个月的月份数',
his_heavy_suc_trade_light_ovd_repay_same_date_count int comment '重资产成功交易与轻资产逾期还款发生在同一个天的unique日期数',
his_heavy_fail_trade_light_ovd_repay_same_month_count int comment '重资产fail交易与轻资产逾期还款发生在同一个月的月份数',
his_heavy_fail_trade_light_ovd_repay_same_date_count int comment '重资产fail交易与轻资产逾期还款发生在同一个天的unique日期数',
his_heavy_suc_trade_light_advance_repay_same_month_count int comment '历史至今重资产交易成功与轻资产提前还款(实还日)发生在同一个月的月份数',
his_heavy_suc_trade_light_advance_repay_same_date_count int comment '历史至今重资产交易成功与轻资产提前还款(实还日)发生在同天的unique日期数',
his_heavy_ovd_repay_light_ovd_repay_same_month_count int comment '重资产逾期还款与轻资产逾期还款发生在同一个月的月份数',
his_heavy_ovd_repay_light_ovd_repay_same_date_count int comment '重资产逾期还款与轻资产逾期还款发生在同一个天的unique日期数',
his_heavy_advance_repay_light_advance_repay_same_month_count int comment '重资产提前还款（实还款日）与轻资产提前还款（实还款日）发生在同一个月的月份数',
his_heavy_advance_repay_light_advance_repay_same_date_count int comment '重资产提前还款（实还款日）与轻资产提前还款（实还款日）发生在同一个天的unique日期数',
his_heavy_ontime_repay_light_ontime_repay_same_month_count int comment '重资产按时还款与轻资产按时还款发生在同一个月的月份数',
his_heavy_ontime_repay_light_ontime_repay_same_date_count int comment '重资产按时还款与轻资产按时还款发生在同一个天的unique日期数',
his_heavy_advance_repay_light_ovd_repay_same_month_count int comment '重资产提前还款（实还日）与轻资产逾期还款发生在同一个月的月份数',
his_heavy_advance_repay_light_ovd_repay_same_date_count int comment '重资产提前还款（实还日）与轻资产逾期还款发生在同一个天的unique日期数',
his_heavy_ontime_repay_light_ovd_repay_same_month_count int comment '重资产按时还款（实还日）与轻资产逾期还款发生在同一个月的月份数',
his_heavy_ontime_repay_light_ovd_repay_same_date_count int comment '重资产按时还款（实还日）与轻资产逾期还款发生在同一个天的unique日期数',
his_light_advance_repay_heavy_ovd_repay_same_month_count int comment '轻资产提前还款（实还日）与重资产逾期还款发生在同一个月的月份数',
his_light_advance_repay_heavy_ovd_repay_same_date_count int comment '轻资产提前还款（实还日）与重资产逾期还款发生在同一个天的unique日期数',
his_light_ontime_repay_heavy_ovd_repay_same_month_count int comment '轻资产按时还款（实还日）与重资产逾期还款发生在同一个月的月份数',
his_light_ontime_repay_heavy_ovd_repay_same_date_count int comment '轻资产按时还款（实还日）与重资产逾期还款发生在同一个天的unique日期数',
his_heavy_shouxin_inner30d_light_ovd_repay_count int comment '轻资产逾期还款发生在重资产授信日前后30天内的笔数',
his_heavy_shouxin_samemonth_light_ovd_repay_count int comment '轻资产逾期还款与重资产授信发生在同一个月的笔数',
his_heavy_shouxin_inner30d_light_advance_repay_count int comment '轻资产提前还款发生在重资产授信日前后30天内的笔数',
his_heavy_shouxin_samemonth_light_advance_repay_count int comment '轻资产提前还款与重资产授信发生在同一个月的笔数',
light_his_max_ontim_repay_amt_divide_heavy_his_max_ontim_repay_amt decimal(38,18) comment '历史至今轻资产最大按时还款本金/历史至今重资产最大按时还款本金',
light_d90_max_ontim_repay_amt_divide_heavy_d90_max_ontim_repay_amt decimal(38,18) comment '近90天轻资产最大按时还款本金/近90天重资产最大按时还款本金',
light_d360_max_ontim_repay_amt_divide_heavy_d360_max_ontim_repay_amt decimal(38,18) comment '近360天轻资产最大按时还款本金/近360天重资产最大按时还款本金',
light_d720_max_ontim_repay_amt_divide_heavy_d720_max_ontim_repay_amt decimal(38,18) comment '近720天轻资产最大按时还款本金/近720天重资产最大按时还款本金',
light_his_sum_ontim_repay_amt_divide_heavy_his_sum_ontim_repay_amt decimal(38,18) comment '历史至今轻资产按时还款本金总和/历史至今重资产按时还款本金总和',
light_d90_sum_ontim_repay_amt_divide_heavy_d90_sum_ontim_repay_amt decimal(38,18) comment '近90天轻资产按时还款本金总和/近90天重资产按时还款本金总和',
light_d360_sum_ontim_repay_amt_divide_heavy_d360_sum_ontim_repay_amt decimal(38,18) comment '近360天轻资产按时还款本金总和/近360天重资产按时还款本金总和',
light_d720_sum_ontim_repay_amt_divide_heavy_d720_sum_ontim_repay_amt decimal(38,18) comment '近720天轻资产按时还款本金总和/近720天重资产按时还款本金总和',
light_his_max_adv_repay_amt_divide_heavy_his_max_adv_repay_amt decimal(38,18) comment '历史至今轻资产最大提前还款本金/历史至今重资产最大提前还款本金',
light_d90_max_adv_repay_amt_divide_heavy_d90_max_adv_repay_amt decimal(38,18) comment '近90天轻资产最大提前还款本金/近90天重资产最大提前还款本金',
light_d360_max_adv_repay_amt_divide_heavy_d360_max_adv_repay_amt decimal(38,18) comment '近360天轻资产最大提前还款本金/近360天重资产最大提前还款本金',
light_d720_max_adv_repay_amt_divide_heavy_d720_max_adv_repay_amt decimal(38,18) comment '近720天轻资产最大提前还款本金/近720天重资产最大提前还款本金',
light_his_sum_adv_repay_amt_divide_heavy_his_sum_adv_repay_amt decimal(38,18) comment '历史至今轻资产提前还款本金总和/历史至今重资产提前还款本金总和',
light_d90_sum_adv_repay_amt_divide_heavy_d90_sum_adv_repay_amt decimal(38,18) comment '近90天轻资产提前还款本金总和/近90天重资产提前还款本金总和',
light_d360_sum_adv_repay_amt_divide_heavy_d360_sum_adv_repay_amt decimal(38,18) comment '近360天轻资产提前还款本金总和/近360天重资产提前还款本金总和',
light_d720_sum_adv_repay_amt_divide_heavy_d720_sum_adv_repay_amt decimal(38,18) comment '近720天轻资产提前还款本金总和/近720天重资产提前还款本金总和',
light_his_max_ovd_repay_amt_divide_heavy_his_max_ovd_repay_amt decimal(38,18) comment '历史至今轻资产最大逾期还款本金/历史至今重资产最大逾期还款本金',
light_d90_max_ovd_repay_amt_divide_heavy_d90_max_ovd_repay_amt decimal(38,18) comment '近90天轻资产最大逾期还款本金/近90天重资产最大逾期还款本金',
light_d360_max_ovd_repay_amt_divide_heavy_d360_max_ovd_repay_amt decimal(38,18) comment '近360天轻资产最大逾期还款本金/近360天重资产最大逾期还款本金',
light_d720_max_ovd_repay_amt_divide_heavy_d720_max_ovd_repay_amt decimal(38,18) comment '近720天轻资产最大逾期还款本金/近720天重资产最大逾期还款本金',
light_his_sum_ovd_repay_amt_divide_heavy_his_sum_ovd_repay_amt decimal(38,18) comment '历史至今轻资产逾期还款本金总和/历史至今重资产逾期还款本金总和',
light_d90_sum_ovd_repay_amt_divide_heavy_d90_sum_ovd_repay_amt decimal(38,18) comment '近90天轻资产逾期还款本金总和/近90天重资产逾期还款本金总和',
light_d360_sum_ovd_repay_amt_divide_heavy_d360_sum_ovd_repay_amt decimal(38,18) comment '近360天轻资产逾期还款本金总和/近360天重资产逾期还款本金总和',
light_d720_sum_ovd_repay_amt_divide_heavy_d720_sum_ovd_repay_amt decimal(38,18) comment '近720天轻资产逾期还款本金总和/近720天重资产逾期还款本金总和',
heavy_his_max_faqi_prc_amt_divide_light_his_max_ontim_repay_amt decimal(38,18) comment '历史至今重资产最大借款发起本金/历史至今轻资产最大按时还款本金',
heavy_d90_max_faqi_prc_amt_divide_light_d90_max_ontim_repay_amt decimal(38,18) comment '近90天重轻资产最大借款发起本金/近90天轻资产最大按时还款本金',
heavy_d360_max_faqi_prc_amt_divide_light_d360_max_ontim_repay_amt decimal(38,18) comment '近360天重资产最大借款发起本金/近360天轻资产最大按时还款本金',
heavy_d720_max_faqi_prc_amt_divide_light_d720_max_ontim_repay_amt decimal(38,18) comment '近720天重资产最大借款发起本金/近720天轻资产最大按时还款本金',
heavy_his_sum_faqi_prc_amt_divide_light_his_sum_ontim_repay_amt decimal(38,18) comment '历史至今重资产借款发起本金总和/历史至今轻资产按时还款本金总和',
heavy_d90_sum_faqi_prc_amt_divide_light_d90_sum_ontim_repay_amt decimal(38,18) comment '近90天重资产借款发起本金总和/近90天轻资产按时还款本金总和',
heavy_d360_sum_faqi_prc_amt_divide_light_d360_sum_ontim_repay_amt decimal(38,18) comment '近360天重资产借款发起本金总和/近360天轻资产按时还款本金总和',
heavy_d720_sum_faqi_prc_amt_divide_light_d720_sum_ontim_repay_amt decimal(38,18) comment '近720天重资产借款发起本金总和/近720天轻资产按时还款本金总和',
heavy_his_max_faqi_prc_amt_divide_light_his_max_adv_repay_amt decimal(38,18) comment '历史至今重资产最大借款发起本金/历史至今轻资产最大提前还款本金',
heavy_d90_max_faqi_prc_amt_divide_light_d90_max_adv_repay_amt decimal(38,18) comment '近90天重轻资产最大借款发起本金/近90天轻资产最大提前还款本金',
heavy_d360_max_faqi_prc_amt_divide_light_d360_max_adv_repay_amt decimal(38,18) comment '近360天重资产最大借款发起本金/近360天轻资产最大提前还款本金',
heavy_d720_max_faqi_prc_amt_divide_light_d720_max_adv_repay_amt decimal(38,18) comment '近720天重资产最大借款发起本金/近720天轻资产最大提前还款本金',
heavy_his_sum_faqi_prc_amt_divide_light_his_sum_adv_repay_amt decimal(38,18) comment '历史至今重资产借款发起本金总和/历史至今轻资产提前还款本金总和',
heavy_d90_sum_faqi_prc_amt_divide_light_d90_sum_adv_repay_amt decimal(38,18) comment '近90天重资产借款发起本金总和/近90天轻资产提前还款本金总和',
heavy_d360_sum_faqi_prc_amt_divide_light_d360_sum_adv_repay_amt decimal(38,18) comment '近360天重资产借款发起本金总和/近360天轻资产提前还款本金总和',
heavy_d720_sum_faqi_prc_amt_divide_light_d720_sum_adv_repay_amt decimal(38,18) comment '近720天重资产借款发起本金总和/近720天轻资产提前还款本金总和',
heavy_his_max_faqi_prc_amt_divide_light_his_max_ovd_repay_amt decimal(38,18) comment '历史至今重资产最大借款发起本金/历史至今轻资产最大逾期还款本金',
heavy_d90_max_faqi_prc_amt_divide_light_d90_max_ovd_repay_amt decimal(38,18) comment '近90天重轻资产最大借款发起本金/近90天轻资产最大逾期还款本金',
heavy_d360_max_faqi_prc_amt_divide_light_d360_max_ovd_repay_amt decimal(38,18) comment '近360天重资产最大借款发起本金/近360天轻资产最大逾期还款本金',
heavy_d720_max_faqi_prc_amt_divide_light_d720_max_ovd_repay_amt decimal(38,18) comment '近720天重资产最大借款发起本金/近720天轻资产最大逾期还款本金',
heavy_his_sum_faqi_prc_amt_divide_light_his_sum_ovd_repay_amt decimal(38,18) comment '历史至今重资产借款发起本金总和/历史至今轻资产逾期还款本金总和',
heavy_d90_sum_faqi_prc_amt_divide_light_d90_sum_ovd_repay_amt decimal(38,18) comment '近90天重资产借款发起本金总和/近90天轻资产逾期还款本金总和',
heavy_d360_sum_faqi_prc_amt_divide_light_d360_sum_ovd_repay_amt decimal(38,18) comment '近360天重资产借款发起本金总和/近360天轻资产逾期还款本金总和',
heavy_d720_sum_faqi_prc_amt_divide_light_d720_sum_ovd_repay_amt decimal(38,18) comment '近720天重资产借款发起本金总和/近720天轻资产逾期还款本金总和',
heavy_his_max_fail_prc_amt_divide_light_his_max_ontim_repay_amt decimal(38,18) comment '历史至今重资产最大借款失败本金/历史至今轻资产最大按时还款本金',
heavy_d90_max_fail_prc_amt_divide_light_d90_max_ontim_repay_amt decimal(38,18) comment '近90天重轻资产最大借款失败本金/近90天轻资产最大按时还款本金',
heavy_d360_max_fail_prc_amt_divide_light_d360_max_ontim_repay_amt decimal(38,18) comment '近360天重资产最大借款失败本金/近360天轻资产最大按时还款本金',
heavy_d720_max_fail_prc_amt_divide_light_d720_max_ontim_repay_amt decimal(38,18) comment '近720天重资产最大借款失败本金/近720天轻资产最大按时还款本金',
heavy_his_sum_fail_prc_amt_divide_light_his_sum_ontim_repay_amt decimal(38,18) comment '历史至今重资产借款失败本金总和/历史至今轻资产按时还款本金总和',
heavy_d90_sum_fail_prc_amt_divide_light_d90_sum_ontim_repay_amt decimal(38,18) comment '近90天重资产借款失败本金总和/近90天轻资产按时还款本金总和',
heavy_d360_sum_fail_prc_amt_divide_light_d360_sum_ontim_repay_amt decimal(38,18) comment '近360天重资产借款失败本金总和/近360天轻资产按时还款本金总和',
heavy_d720_sum_fail_prc_amt_divide_light_d720_sum_ontim_repay_amt decimal(38,18) comment '近720天重资产借款失败本金总和/近720天轻资产按时还款本金总和',
heavy_his_max_fail_prc_amt_divide_light_his_max_adv_repay_amt decimal(38,18) comment '历史至今重资产最大借款失败本金/历史至今轻资产最大提前还款本金',
heavy_d90_max_fail_prc_amt_divide_light_d90_max_adv_repay_amt decimal(38,18) comment '近90天重轻资产最大借款失败本金/近90天轻资产最大提前还款本金',
heavy_d360_max_fail_prc_amt_divide_light_d360_max_adv_repay_amt decimal(38,18) comment '近360天重资产最大借款失败本金/近360天轻资产最大提前还款本金',
heavy_d720_max_fail_prc_amt_divide_light_d720_max_adv_repay_amt decimal(38,18) comment '近720天重资产最大借款失败本金/近720天轻资产最大提前还款本金',
heavy_his_sum_fail_prc_amt_divide_light_his_sum_adv_repay_amt decimal(38,18) comment '历史至今重资产借款失败本金总和/历史至今轻资产提前还款本金总和',
heavy_d90_sum_fail_prc_amt_divide_light_d90_sum_adv_repay_amt decimal(38,18) comment '近90天重资产借款失败本金总和/近90天轻资产提前还款本金总和',
heavy_d360_sum_fail_prc_amt_divide_light_d360_sum_adv_repay_amt decimal(38,18) comment '近360天重资产借款失败本金总和/近360天轻资产提前还款本金总和',
heavy_d720_sum_fail_prc_amt_divide_light_d720_sum_adv_repay_amt decimal(38,18) comment '近720天重资产借款失败本金总和/近720天轻资产提前还款本金总和',
heavy_his_max_fail_prc_amt_divide_light_his_max_ovd_repay_amt decimal(38,18) comment '历史至今重资产最大借款失败本金/历史至今轻资产最大逾期还款本金',
heavy_d90_max_fail_prc_amt_divide_light_d90_max_ovd_repay_amt decimal(38,18) comment '近90天重轻资产最大借款失败本金/近90天轻资产最大逾期还款本金',
heavy_d360_max_fail_prc_amt_divide_light_d360_max_ovd_repay_amt decimal(38,18) comment '近360天重资产最大借款失败本金/近360天轻资产最大逾期还款本金',
heavy_d720_max_fail_prc_amt_divide_light_d720_max_ovd_repay_amt decimal(38,18) comment '近720天重资产最大借款失败本金/近720天轻资产最大逾期还款本金',
heavy_his_sum_fail_prc_amt_divide_light_his_sum_ovd_repay_amt decimal(38,18) comment '历史至今重资产借款失败本金总和/历史至今轻资产逾期还款本金总和',
heavy_d90_sum_fail_prc_amt_divide_light_d90_sum_ovd_repay_amt decimal(38,18) comment '近90天重资产借款失败本金总和/近90天轻资产逾期还款本金总和',
heavy_d360_sum_fail_prc_amt_divide_light_d360_sum_ovd_repay_amt decimal(38,18) comment '近360天重资产借款失败本金总和/近360天轻资产逾期还款本金总和',
heavy_d720_sum_fail_prc_amt_divide_light_d720_sum_ovd_repay_amt decimal(38,18) comment '近720天重资产借款失败本金总和/近720天轻资产逾期还款本金总和',
his_lend_light_to_repay_heavy_inner3d_order_num_rate double comment '轻资产发起借款发生在重资产还款日前后3天内的笔数占总发起笔数比例(借轻还重)',
his_lend_light_to_repay_heavy_inner3d_order_amt_rate decimal(38,18) comment '轻资产发起借款发生在重资产还款日前后3天内的金额占总发起金额比例(借轻还重)',
his_lend_light_to_repay_heavy_inner3d_order_stg_rate double comment '轻资产发起借款发生在重资产还款日前后3天内的期数占总发起期数比例(借轻还重)',
his_lend_light_to_repay_heavy_inner3d_order_num_sum bigint comment '轻资产发起借款发生在重资产还款日前后3天内的订单笔数(借轻还重)',
his_lend_light_to_repay_heavy_inner3d_order_amt_sum decimal(36,10) comment '轻资产发起借款发生在重资产还款日前后3天内的金额总和(借轻还重)',
his_lend_light_to_repay_heavy_inner3d_order_stg_sum double comment '轻资产发起借款发生在重资产还款日前后3天内的期数总和(借轻还重)',
his_lend_light_to_repay_heavy_inner7d_order_num_rate double comment '轻资产发起借款发生在重资产还款日前后7天内的笔数占总发起笔数比例(借轻还重)',
his_lend_light_to_repay_heavy_inner7d_order_amt_rate decimal(38,18) comment '轻资产发起借款发生在重资产还款日前后7天内的金额占总发起金额比例(借轻还重)',
his_lend_light_to_repay_heavy_inner7d_order_stg_rate double comment '轻资产发起借款发生在重资产还款日前后7天内的期数占总发起期数比例(借轻还重)',
his_lend_light_to_repay_heavy_inner7d_order_num_sum bigint comment '轻资产发起借款发生在重资产还款日前后7天内的订单笔数(借轻还重)',
his_lend_light_to_repay_heavy_inner7d_order_amt_sum decimal(36,10) comment '轻资产发起借款发生在重资产还款日前后7天内的金额总和(借轻还重)',
his_lend_light_to_repay_heavy_inner7d_order_stg_sum double comment '轻资产发起借款发生在重资产还款日前后7天内的期数总和(借轻还重)',
his_lend_light_to_repay_heavy_inner14d_order_num_rate double comment '轻资产发起借款发生在重资产还款日前后14天内的笔数占总发起笔数比例(借轻还重)',
his_lend_light_to_repay_heavy_inner14d_order_amt_rate decimal(38,18) comment '轻资产发起借款发生在重资产还款日前后14天内的金额占总发起金额比例(借轻还重)',
his_lend_light_to_repay_heavy_inner14d_order_stg_rate double comment '轻资产发起借款发生在重资产还款日前后14天内的期数占总发起期数比例(借轻还重)',
his_lend_light_to_repay_heavy_inner14d_order_num_sum bigint comment '轻资产发起借款发生在重资产还款日前后14天内的订单笔数(借轻还重)',
his_lend_light_to_repay_heavy_inner14d_order_amt_sum decimal(36,10) comment '轻资产发起借款发生在重资产还款日前后14天内的金额总和(借轻还重)',
his_lend_light_to_repay_heavy_inner14d_order_stg_sum double comment '轻资产发起借款发生在重资产还款日前后14天内的期数总和(借轻还重)',
d90_lend_light_to_repay_heavy_inner7d_order_num_rate double comment '近90天轻资产发起借款发生在重资产还款日前后7天内的笔数占总发起笔数比例(借轻还重)',
d90_lend_light_to_repay_heavy_inner7d_order_amt_rate decimal(38,18) comment '近90天轻资产发起借款发生在重资产还款日前后7天内的金额占总发起金额比例(借轻还重)',
d90_lend_light_to_repay_heavy_inner7d_order_stg_rate double comment '近90天轻资产发起借款发生在重资产还款日前后7天内的期数占总发起期数比例(借轻还重)',
d90_lend_light_to_repay_heavy_inner7d_order_num_sum bigint comment '近90天轻资产发起借款发生在重资产还款日前后7天内的订单笔数(借轻还重)',
d90_lend_light_to_repay_heavy_inner7d_order_amt_sum decimal(36,10) comment '近90天轻资产发起借款发生在重资产还款日前后7天内的金额总和(借轻还重)',
d90_lend_light_to_repay_heavy_inner7d_order_stg_sum double comment '近90天轻资产发起借款发生在重资产还款日前后7天内的期数总和(借轻还重)',
d360_lend_light_to_repay_heavy_inner7d_order_num_rate double comment '近360天轻资产发起借款发生在重资产还款日前后7天内的笔数占总发起笔数比例(借轻还重)',
d360_lend_light_to_repay_heavy_inner7d_order_amt_rate decimal(38,18) comment '近360天轻资产发起借款发生在重资产还款日前后7天内的金额占总发起金额比例(借轻还重)',
d360_lend_light_to_repay_heavy_inner7d_order_stg_rate double comment '近360天轻资产发起借款发生在重资产还款日前后7天内的期数占总发起期数比例(借轻还重)',
d360_lend_light_to_repay_heavy_inner7d_order_num_sum bigint comment '近360天轻资产发起借款发生在重资产还款日前后7天内的订单笔数(借轻还重)',
d360_lend_light_to_repay_heavy_inner7d_order_amt_sum decimal(36,10) comment '近360天轻资产发起借款发生在重资产还款日前后7天内的金额总和(借轻还重)',
d360_lend_light_to_repay_heavy_inner7d_order_stg_sum double comment '近360天轻资产发起借款发生在重资产还款日前后7天内的期数总和(借轻还重)',
d720_lend_light_to_repay_heavy_inner7d_order_num_rate double comment '近720天轻资产发起借款发生在重资产还款日前后7天内的笔数占总发起笔数比例(借轻还重)',
d720_lend_light_to_repay_heavy_inner7d_order_amt_rate decimal(38,18) comment '近720天轻资产发起借款发生在重资产还款日前后7天内的金额占总发起金额比例(借轻还重)',
d720_lend_light_to_repay_heavy_inner7d_order_stg_rate double comment '近720天轻资产发起借款发生在重资产还款日前后7天内的期数占总发起期数比例(借轻还重)',
d720_lend_light_to_repay_heavy_inner7d_order_num_sum bigint comment '近720天轻资产发起借款发生在重资产还款日前后7天内的订单笔数(借轻还重)',
d720_lend_light_to_repay_heavy_inner7d_order_amt_sum decimal(36,10) comment '近720天轻资产发起借款发生在重资产还款日前后7天内的金额总和(借轻还重)',
d720_lend_light_to_repay_heavy_inner7d_order_stg_sum double comment '近720天轻资产发起借款发生在重资产还款日前后7天内的期数总和(借轻还重)',
his_lend_heavy_to_repay_light_inner3d_order_num_rate double comment '重资产发起借款发生在轻资产还款日前后3天内的笔数占总发起笔数比例(借重还轻)',
his_lend_heavy_to_repay_light_inner3d_order_amt_rate decimal(38,18) comment '重资产发起借款发生在轻资产还款日前后3天内的金额占总发起金额比例(借重还轻)',
his_lend_heavy_to_repay_light_inner3d_order_stg_rate double comment '重资产发起借款发生在轻资产还款日前后3天内的期数占总发起期数比例(借重还轻)',
his_lend_heavy_to_repay_light_inner3d_order_num_sum bigint comment '重资产发起借款发生在轻资产还款日前后3天内的订单笔数(借重还轻)',
his_lend_heavy_to_repay_light_inner3d_order_amt_sum decimal(28,6) comment '重资产发起借款发生在轻资产还款日前后3天内的金额总和(借重还轻)',
his_lend_heavy_to_repay_light_inner3d_order_stg_sum bigint comment '重资产发起借款发生在轻资产还款日前后3天内的期数总和(借重还轻)',
his_lend_heavy_to_repay_light_inner7d_order_num_rate double comment '重资产发起借款发生在轻资产还款日前后7天内的笔数占总发起笔数比例(借重还轻)',
his_lend_heavy_to_repay_light_inner7d_order_amt_rate decimal(38,18) comment '重资产发起借款发生在轻资产还款日前后7天内的金额占总发起金额比例(借重还轻)',
his_lend_heavy_to_repay_light_inner7d_order_stg_rate double comment '重资产发起借款发生在轻资产还款日前后7天内的期数占总发起期数比例(借重还轻)',
his_lend_heavy_to_repay_light_inner7d_order_num_sum bigint comment '重资产发起借款发生在轻资产还款日前后7天内的订单笔数(借重还轻)',
his_lend_heavy_to_repay_light_inner7d_order_amt_sum decimal(28,6) comment '重资产发起借款发生在轻资产还款日前后7天内的金额总和(借重还轻)',
his_lend_heavy_to_repay_light_inner7d_order_stg_sum bigint comment '重资产发起借款发生在轻资产还款日前后7天内的期数总和(借重还轻)',
his_lend_heavy_to_repay_light_inner14d_order_num_rate double comment '重资产发起借款发生在轻资产还款日前后14天内的笔数占总发起笔数比例(借重还轻)',
his_lend_heavy_to_repay_light_inner14d_order_amt_rate decimal(38,18) comment '重资产发起借款发生在轻资产还款日前后14天内的金额占总发起金额比例(借重还轻)',
his_lend_heavy_to_repay_light_inner14d_order_stg_rate double comment '重资产发起借款发生在轻资产还款日前后14天内的期数占总发起期数比例(借重还轻)',
his_lend_heavy_to_repay_light_inner14d_order_num_sum bigint comment '重资产发起借款发生在轻资产还款日前后14天内的订单笔数(借重还轻)',
his_lend_heavy_to_repay_light_inner14d_order_amt_sum decimal(28,6) comment '重资产发起借款发生在轻资产还款日前后14天内的金额总和(借重还轻)',
his_lend_heavy_to_repay_light_inner14d_order_stg_sum bigint comment '重资产发起借款发生在轻资产还款日前后14天内的期数总和(借重还轻)',
d90_lend_heavy_to_repay_light_inner7d_order_num_rate double comment '近90天重资产发起借款发生在轻资产还款日前后7天内的笔数占总发起笔数比例(借重还轻)',
d90_lend_heavy_to_repay_light_inner7d_order_amt_rate decimal(38,18) comment '近90天重资产发起借款发生在轻资产还款日前后7天内的金额占总发起金额比例(借重还轻)',
d90_lend_heavy_to_repay_light_inner7d_order_stg_rate double comment '近90天重资产发起借款发生在轻资产还款日前后7天内的期数占总发起期数比例(借重还轻)',
d90_lend_heavy_to_repay_light_inner7d_order_num_sum bigint comment '近90天重资产发起借款发生在轻资产还款日前后7天内的订单笔数(借重还轻)',
d90_lend_heavy_to_repay_light_inner7d_order_amt_sum decimal(28,6) comment '近90天重资产发起借款发生在轻资产还款日前后7天内的金额总和(借重还轻)',
d90_lend_heavy_to_repay_light_inner7d_order_stg_sum bigint comment '近90天重资产发起借款发生在轻资产还款日前后7天内的期数总和(借重还轻)',
d360_lend_heavy_to_repay_light_inner7d_order_num_rate double comment '近360天重资产发起借款发生在轻资产还款日前后7天内的笔数占总发起笔数比例(借重还轻)',
d360_lend_heavy_to_repay_light_inner7d_order_amt_rate decimal(38,18) comment '近360天重资产发起借款发生在轻资产还款日前后7天内的金额占总发起金额比例(借重还轻)',
d360_lend_heavy_to_repay_light_inner7d_order_stg_rate double comment '近360天重资产发起借款发生在轻资产还款日前后7天内的期数占总发起期数比例(借重还轻)',
d360_lend_heavy_to_repay_light_inner7d_order_num_sum bigint comment '近360天重资产发起借款发生在轻资产还款日前后7天内的订单笔数(借重还轻)',
d360_lend_heavy_to_repay_light_inner7d_order_amt_sum decimal(28,6) comment '近360天重资产发起借款发生在轻资产还款日前后7天内的金额总和(借重还轻)',
d360_lend_heavy_to_repay_light_inner7d_order_stg_sum bigint comment '近360天重资产发起借款发生在轻资产还款日前后7天内的期数总和(借重还轻)',
d720_lend_heavy_to_repay_light_inner7d_order_num_rate double comment '近720天重资产发起借款发生在轻资产还款日前后7天内的笔数占总发起笔数比例(借重还轻)',
d720_lend_heavy_to_repay_light_inner7d_order_amt_rate decimal(38,18) comment '近720天重资产发起借款发生在轻资产还款日前后7天内的金额占总发起金额比例(借重还轻)',
d720_lend_heavy_to_repay_light_inner7d_order_stg_rate double comment '近720天重资产发起借款发生在轻资产还款日前后7天内的期数占总发起期数比例(借重还轻)',
d720_lend_heavy_to_repay_light_inner7d_order_num_sum bigint comment '近720天重资产发起借款发生在轻资产还款日前后7天内的订单笔数(借重还轻)',
d720_lend_heavy_to_repay_light_inner7d_order_amt_sum decimal(28,6) comment '近720天重资产发起借款发生在轻资产还款日前后7天内的金额总和(借重还轻)',
d720_lend_heavy_to_repay_light_inner7d_order_stg_sum bigint comment '近720天重资产发起借款发生在轻资产还款日前后7天内的期数总和(借重还轻)',
unpaid_principal_tot_light_divide_heavy decimal(38,18) comment '重资产总应还本金/轻资产总应还本金',
unpaid_principal_his_light_divide_heavy decimal(38,18) comment '重资产历史到期未还本金/轻资产历史到期未还本金',
unpaid_principal_future_light_divide_heavy decimal(38,18) comment '重资产未来到期未还本金/轻资产未来到期未还本金',
unpaid_principal_tot_light_add_heavy decimal(37,10) comment '重加轻资产总应还本金',
unpaid_principal_his_light_add_heavy decimal(37,10) comment '重加轻资产历史到期未还本金',
unpaid_principal_future_light_add_heavy decimal(37,10) comment '重加轻资产未来到期未还本金'
) PARTITIONED BY (ds STRING comment '分区字段，yyyymmdd');


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_30light_cross_heavy_inner_behaviour_df partition(ds='${bizdate}')
select t1.*
, t2.`(uid|mdl_dte)?+.+`
, t3.`(uid|mdl_dte)?+.+`
, t4.`(uid|mdl_dte)?+.+`
, t5.`(uid|mdl_dte)?+.+`
, t6.`(uid|mdl_dte)?+.+`

from light_heavy_credit_time_cross_tmp t1
left join light_trade_heavy_credit_trade_cross_tmp t2
on t1.uid = t2.uid and t1.mdl_dte = t2.mdl_dte
left join light_repay_heavy_repay_credit_trade_cross_tmp t3
on t1.uid = t3.uid and t1.mdl_dte = t3.mdl_dte
left join lend_light_to_repay_heavy_inner14d_aggregate_to_uid_tmp2 t4
on t1.uid = t4.uid and t1.mdl_dte = t4.mdl_dte
left join lend_heavy_to_repay_light_inner14d_aggregate_to_uid_tmp2 t5
on t1.uid = t5.uid and t1.mdl_dte = t5.mdl_dte
left join light_fuzhai_heavy_fuzhai_cross_tmp t6
on t1.uid = t6.uid and t1.mdl_dte = t6.mdl_dte;
-- feature-copilot:node-end ordinal=0
