-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_light_order_repay_crossed_new_df
-- node_id: n_6927280012174032896
-- task_name: dwa_risk_light_order_repay_crossed_new_df
-- owner_name: 王博韬
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_light_order_repay_crossed_new_df.json
-- source_json_sha256: 8f8065b06182a550fbc15d935814a174b5bb92cc9b7224f6f88b78133b3cfef0
-- upstream_table: cdmx.cdmx_fct_light_loan_order_df
-- upstream_table: cdmx.etl_cdmx_fct_light_stage_plan_df
-- upstream_table: dwa_risk.dwa_risk_f_light_sample_all_base_df
-- upstream_table: dwa_risk.dwa_risk_light_order_repay_crossed_tmp1
-- upstream_table: dwa_risk.dwa_risk_light_order_repay_crossed_tmp2
-- upstream_table: dwa_risk.dwa_risk_light_order_repay_crossed_tmp3

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 王博韬
--创建日期: 2025-05-19 09:47:16
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
CREATE TABLE if not exists ${dwa_risk}.dwa_risk_light_order_repay_crossed_new_df
(
    uid STRING comment 'uid',
    mdl_dte STRING comment '打分日',
    5d_range_sum_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后5天内有应还日的成功订单金额之和', 
    5d_range_min_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后5天内有应还日的最小成功订单金额', 
    5d_range_max_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后5天内有应还日的最大成功订单金额', 
    5d_range_avg_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后5天内有应还日的平均成功订单金额', 
    5d_range_ord_cnt_1m STRING COMMENT '近1个月轻资产借款前后5天内有应还日的成功订单数', 
    5d_range_sum_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后5天内有应还日的成功订单金额之和', 
    5d_range_min_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后5天内有应还日的最小成功订单金额', 
    5d_range_max_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后5天内有应还日的最大成功订单金额', 
    5d_range_avg_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后5天内有应还日的平均成功订单金额', 
    5d_range_ord_cnt_6m STRING COMMENT '近6个月轻资产借款前后5天内有应还日的成功订单数', 
    5d_range_sum_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后5天内有应还日的成功订单金额之和', 
    5d_range_min_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后5天内有应还日的最小成功订单金额', 
    5d_range_max_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后5天内有应还日的最大成功订单金额', 
    5d_range_avg_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后5天内有应还日的平均成功订单金额', 
    5d_range_ord_cnt_12m STRING COMMENT '近12个月轻资产借款前后5天内有应还日的成功订单数', 
    5d_range_sum_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后5天内有应还日的成功订单金额之和', 
    5d_range_min_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后5天内有应还日的最小成功订单金额', 
    5d_range_max_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后5天内有应还日的最大成功订单金额', 
    5d_range_avg_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后5天内有应还日的平均成功订单金额', 
    5d_range_ord_cnt_24m STRING COMMENT '近24个月轻资产借款前后5天内有应还日的成功订单数', 
    5d_range_sum_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后5天内有应还日的成功订单金额之和', 
    5d_range_min_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后5天内有应还日的最小成功订单金额', 
    5d_range_max_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后5天内有应还日的最大成功订单金额', 
    5d_range_avg_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后5天内有应还日的平均成功订单金额', 
    5d_range_ord_cnt_36m STRING COMMENT '近36个月轻资产借款前后5天内有应还日的成功订单数', 
    5d_range_sum_prc_amt_his STRING COMMENT '历史至今轻资产借款前后5天内有应还日的成功订单金额之和', 
    5d_range_min_prc_amt_his STRING COMMENT '历史至今轻资产借款前后5天内有应还日的最小成功订单金额', 
    5d_range_max_prc_amt_his STRING COMMENT '历史至今轻资产借款前后5天内有应还日的最大成功订单金额', 
    5d_range_avg_prc_amt_his STRING COMMENT '历史至今轻资产借款前后5天内有应还日的平均成功订单金额', 
    5d_range_ord_cnt_his STRING COMMENT '历史至今轻资产借款前后5天内有应还日的成功订单数', 
    10d_range_sum_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后10天内有应还日的成功订单金额之和', 
    10d_range_min_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后10天内有应还日的最小成功订单金额', 
    10d_range_max_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后10天内有应还日的最大成功订单金额', 
    10d_range_avg_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后10天内有应还日的平均成功订单金额', 
    10d_range_ord_cnt_1m STRING COMMENT '近1个月轻资产借款前后10天内有应还日的成功订单数', 
    10d_range_sum_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后10天内有应还日的成功订单金额之和', 
    10d_range_min_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后10天内有应还日的最小成功订单金额', 
    10d_range_max_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后10天内有应还日的最大成功订单金额', 
    10d_range_avg_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后10天内有应还日的平均成功订单金额', 
    10d_range_ord_cnt_6m STRING COMMENT '近6个月轻资产借款前后10天内有应还日的成功订单数', 
    10d_range_sum_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后10天内有应还日的成功订单金额之和', 
    10d_range_min_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后10天内有应还日的最小成功订单金额', 
    10d_range_max_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后10天内有应还日的最大成功订单金额', 
    10d_range_avg_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后10天内有应还日的平均成功订单金额', 
    10d_range_ord_cnt_12m STRING COMMENT '近12个月轻资产借款前后10天内有应还日的成功订单数', 
    10d_range_sum_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后10天内有应还日的成功订单金额之和', 
    10d_range_min_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后10天内有应还日的最小成功订单金额', 
    10d_range_max_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后10天内有应还日的最大成功订单金额', 
    10d_range_avg_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后10天内有应还日的平均成功订单金额', 
    10d_range_ord_cnt_24m STRING COMMENT '近24个月轻资产借款前后10天内有应还日的成功订单数', 
    10d_range_sum_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后10天内有应还日的成功订单金额之和', 
    10d_range_min_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后10天内有应还日的最小成功订单金额', 
    10d_range_max_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后10天内有应还日的最大成功订单金额', 
    10d_range_avg_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后10天内有应还日的平均成功订单金额', 
    10d_range_ord_cnt_36m STRING COMMENT '近36个月轻资产借款前后10天内有应还日的成功订单数', 
    10d_range_sum_prc_amt_his STRING COMMENT '历史至今轻资产借款前后10天内有应还日的成功订单金额之和', 
    10d_range_min_prc_amt_his STRING COMMENT '历史至今轻资产借款前后10天内有应还日的最小成功订单金额', 
    10d_range_max_prc_amt_his STRING COMMENT '历史至今轻资产借款前后10天内有应还日的最大成功订单金额', 
    10d_range_avg_prc_amt_his STRING COMMENT '历史至今轻资产借款前后10天内有应还日的平均成功订单金额', 
    10d_range_ord_cnt_his STRING COMMENT '历史至今轻资产借款前后10天内有应还日的成功订单数', 
    15d_range_sum_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后15天内有应还日的成功订单金额之和', 
    15d_range_min_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后15天内有应还日的最小成功订单金额', 
    15d_range_max_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后15天内有应还日的最大成功订单金额', 
    15d_range_avg_prc_amt_1m STRING COMMENT '近1个月轻资产借款前后15天内有应还日的平均成功订单金额', 
    15d_range_ord_cnt_1m STRING COMMENT '近1个月轻资产借款前后15天内有应还日的成功订单数', 
    15d_range_sum_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后15天内有应还日的成功订单金额之和', 
    15d_range_min_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后15天内有应还日的最小成功订单金额', 
    15d_range_max_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后15天内有应还日的最大成功订单金额', 
    15d_range_avg_prc_amt_6m STRING COMMENT '近6个月轻资产借款前后15天内有应还日的平均成功订单金额', 
    15d_range_ord_cnt_6m STRING COMMENT '近6个月轻资产借款前后15天内有应还日的成功订单数', 
    15d_range_sum_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后15天内有应还日的成功订单金额之和', 
    15d_range_min_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后15天内有应还日的最小成功订单金额', 
    15d_range_max_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后15天内有应还日的最大成功订单金额', 
    15d_range_avg_prc_amt_12m STRING COMMENT '近12个月轻资产借款前后15天内有应还日的平均成功订单金额', 
    15d_range_ord_cnt_12m STRING COMMENT '近12个月轻资产借款前后15天内有应还日的成功订单数', 
    15d_range_sum_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后15天内有应还日的成功订单金额之和', 
    15d_range_min_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后15天内有应还日的最小成功订单金额', 
    15d_range_max_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后15天内有应还日的最大成功订单金额', 
    15d_range_avg_prc_amt_24m STRING COMMENT '近24个月轻资产借款前后15天内有应还日的平均成功订单金额', 
    15d_range_ord_cnt_24m STRING COMMENT '近24个月轻资产借款前后15天内有应还日的成功订单数', 
    15d_range_sum_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后15天内有应还日的成功订单金额之和', 
    15d_range_min_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后15天内有应还日的最小成功订单金额', 
    15d_range_max_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后15天内有应还日的最大成功订单金额', 
    15d_range_avg_prc_amt_36m STRING COMMENT '近36个月轻资产借款前后15天内有应还日的平均成功订单金额', 
    15d_range_ord_cnt_36m STRING COMMENT '近36个月轻资产借款前后15天内有应还日的成功订单数', 
    15d_range_sum_prc_amt_his STRING COMMENT '历史至今轻资产借款前后15天内有应还日的成功订单金额之和', 
    15d_range_min_prc_amt_his STRING COMMENT '历史至今轻资产借款前后15天内有应还日的最小成功订单金额', 
    15d_range_max_prc_amt_his STRING COMMENT '历史至今轻资产借款前后15天内有应还日的最大成功订单金额', 
    15d_range_avg_prc_amt_his STRING COMMENT '历史至今轻资产借款前后15天内有应还日的平均成功订单金额', 
    15d_range_ord_cnt_his STRING COMMENT '历史至今轻资产借款前后15天内有应还日的成功订单数'
    

)
PARTITIONED BY (
	ds STRING COMMENT '分区字段格式yyyymmdd'
);


drop table if exists ${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp1;
create table ${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp1 as 
select 
         main1.uid
        ,main1.mdl_dte
        ,create_time
        ,crt_dte
        
        ,case when ddf_mdl_crt_dte between 1 and 30 then 1 else 0 end as rep_1m_flg
        ,case when ddf_mdl_crt_dte between 1 and 180 then 1 else 0 end as rep_6m_flg
        ,case when ddf_mdl_crt_dte between 1 and 360 then 1 else 0 end as rep_12m_flg
        ,case when ddf_mdl_crt_dte between 1 and 720 then 1 else 0 end as rep_24m_flg
        ,case when ddf_mdl_crt_dte between 1 and 1080 then 1 else 0 end as rep_36m_flg
        ,case when ddf_mdl_crt_dte > 1 then 1 else 0 end as rep_flg


from 
       
        (
        select 
                model_data.uid
                ,model_data.mdl_dte
                ,create_time
                ,crt_dte
                
                ,datediff(model_data.mdl_dte, order1.crt_dte) as ddf_mdl_crt_dte
                

        from    
                (
                    select
                        uid,
                        mdl_dte
                        
                    from  
                    (
                        select   *
                        from    ${dwa_risk}.dwa_risk_f_light_sample_all_base_df
                        where    ds = '${bizdate}' 
                        
                    ) t
                ) model_data

                left join
                ( 
                    select 
                    
                        uid,
                        create_time,
                        Date(create_time) as crt_dte
                
                    from cdmx.cdmx_fct_light_loan_order_df
                    where ds = '${bizdate}' 
                    and is_loan_success_flag = '成功'
                ) order1

                on model_data.uid = order1.uid
                and order1.crt_dte < model_data.mdl_dte

        )main1
       
;






drop table if exists ${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp2;
create table ${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp2 as

SELECT *
FROM
(
    SELECT 
        model_data.uid,
        model_data.mdl_dte,
       
        c.order_no_l,
        c.create_time,
        c.fund_loan_date,
        c.due_date,
        c.loan_principal,
        c.due_dte_in_loan_dte_5d_range_cnt,
        c.due_dte_in_loan_dte_10d_range_cnt,
        c.due_dte_in_loan_dte_15d_range_cnt
       
    from
    
        (
            select
                uid,
                mdl_dte
               
            from  
            (
                select   *
                from    ${dwa_risk}.dwa_risk_f_light_sample_all_base_df
                where    ds = '${bizdate}' 
                
            ) t
        ) model_data
        
        left join 
        
        (
            select  
                a.order_no_l,
                a.uid,
                a.create_time,
                a.fund_loan_date,
                a.loan_principal,
                b.due_date,
                ---借款日期前后5天内的还款到期日数量。
                size(FILTER(
                        due_date, 
                        x -> ABS(DATEDIFF(date(fund_loan_date), date(x))) <= 5
                )) as due_dte_in_loan_dte_5d_range_cnt,
                size(FILTER(
                        due_date, 
                        x -> ABS(DATEDIFF(date(fund_loan_date), date(x))) <= 10
                )) as due_dte_in_loan_dte_10d_range_cnt,
                size(FILTER(
                        due_date, 
                        x -> ABS(DATEDIFF(date(fund_loan_date), date(x))) <= 15
                )) as due_dte_in_loan_dte_15d_range_cnt

            from    
            (
                select  order_no as order_no_l,
                        uid,
                        create_time,
                        fund_loan_date, loan_principal
                from    cdmx.cdmx_fct_light_loan_order_df
                where   ds = '${bizdate}'
                and is_loan_success_flag = '成功'
                        
            ) a
            left join 
            
            (
                SELECT  uid, COLLECT_LIST(distinct due_date) as due_date
                FROM    (
                            select uid,due_date
                            from  cdmx.etl_cdmx_fct_light_stage_plan_df
                            where ds = '${bizdate}' 
                        )
                group by uid
            ) b
            on a.uid = b.uid
            
        ) c
        on model_data.uid = c.uid
        and TO_CHAR(TO_DATE(c.create_time), 'yyyy-MM-dd') < model_data.mdl_dte

) main
;





drop table if exists ${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp3;
create table ${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp3 as
select
  a.uid
  ,a.mdl_dte
  
,sum(case when rep_1m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_sum_prc_amt_1m
,min(case when rep_1m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_min_prc_amt_1m
,max(case when rep_1m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_max_prc_amt_1m
,avg(case when rep_1m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_avg_prc_amt_1m
,count(case when rep_1m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then b.order_no_l else null end) as 5d_range_ord_cnt_1m

,sum(case when rep_6m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_sum_prc_amt_6m
,min(case when rep_6m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_min_prc_amt_6m
,max(case when rep_6m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_max_prc_amt_6m
,avg(case when rep_6m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_avg_prc_amt_6m
,count(case when rep_6m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then b.order_no_l else null end) as 5d_range_ord_cnt_6m

,sum(case when rep_12m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_sum_prc_amt_12m
,min(case when rep_12m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_min_prc_amt_12m
,max(case when rep_12m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_max_prc_amt_12m
,avg(case when rep_12m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_avg_prc_amt_12m
,count(case when rep_12m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then b.order_no_l else null end) as 5d_range_ord_cnt_12m

,sum(case when rep_24m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_sum_prc_amt_24m
,min(case when rep_24m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_min_prc_amt_24m
,max(case when rep_24m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_max_prc_amt_24m
,avg(case when rep_24m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_avg_prc_amt_24m
,count(case when rep_24m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then b.order_no_l else null end) as 5d_range_ord_cnt_24m

,sum(case when rep_36m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_sum_prc_amt_36m
,min(case when rep_36m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_min_prc_amt_36m
,max(case when rep_36m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_max_prc_amt_36m
,avg(case when rep_36m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_avg_prc_amt_36m
,count(case when rep_36m_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then b.order_no_l else null end) as 5d_range_ord_cnt_36m

,sum(case when rep_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_sum_prc_amt_his
,min(case when rep_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_min_prc_amt_his
,max(case when rep_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_max_prc_amt_his
,avg(case when rep_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then loan_principal else 0 end) as 5d_range_avg_prc_amt_his
,count(case when rep_flg = 1 and due_dte_in_loan_dte_5d_range_cnt > 0 then b.order_no_l else null end) as 5d_range_ord_cnt_his


,sum(case when rep_1m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_sum_prc_amt_1m
,min(case when rep_1m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_min_prc_amt_1m
,max(case when rep_1m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_max_prc_amt_1m
,avg(case when rep_1m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_avg_prc_amt_1m
,count(case when rep_1m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then b.order_no_l else null end) as 10d_range_ord_cnt_1m

,sum(case when rep_6m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_sum_prc_amt_6m
,min(case when rep_6m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_min_prc_amt_6m
,max(case when rep_6m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_max_prc_amt_6m
,avg(case when rep_6m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_avg_prc_amt_6m
,count(case when rep_6m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then b.order_no_l else null end) as 10d_range_ord_cnt_6m

,sum(case when rep_12m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_sum_prc_amt_12m
,min(case when rep_12m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_min_prc_amt_12m
,max(case when rep_12m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_max_prc_amt_12m
,avg(case when rep_12m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_avg_prc_amt_12m
,count(case when rep_12m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then b.order_no_l else null end) as 10d_range_ord_cnt_12m

,sum(case when rep_24m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_sum_prc_amt_24m
,min(case when rep_24m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_min_prc_amt_24m
,max(case when rep_24m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_max_prc_amt_24m
,avg(case when rep_24m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_avg_prc_amt_24m
,count(case when rep_24m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then b.order_no_l else null end) as 10d_range_ord_cnt_24m

,sum(case when rep_36m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_sum_prc_amt_36m
,min(case when rep_36m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_min_prc_amt_36m
,max(case when rep_36m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_max_prc_amt_36m
,avg(case when rep_36m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_avg_prc_amt_36m
,count(case when rep_36m_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then b.order_no_l else null end) as 10d_range_ord_cnt_36m

,sum(case when rep_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_sum_prc_amt_his
,min(case when rep_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_min_prc_amt_his
,max(case when rep_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_max_prc_amt_his
,avg(case when rep_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then loan_principal else 0 end) as 10d_range_avg_prc_amt_his
,count(case when rep_flg = 1 and due_dte_in_loan_dte_10d_range_cnt > 0 then b.order_no_l else null end) as 10d_range_ord_cnt_his


,sum(case when rep_1m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_sum_prc_amt_1m
,min(case when rep_1m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_min_prc_amt_1m
,max(case when rep_1m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_max_prc_amt_1m
,avg(case when rep_1m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_avg_prc_amt_1m
,count(case when rep_1m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then b.order_no_l else null end) as 15d_range_ord_cnt_1m

,sum(case when rep_6m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_sum_prc_amt_6m
,min(case when rep_6m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_min_prc_amt_6m
,max(case when rep_6m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_max_prc_amt_6m
,avg(case when rep_6m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_avg_prc_amt_6m
,count(case when rep_6m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then b.order_no_l else null end) as 15d_range_ord_cnt_6m

,sum(case when rep_12m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_sum_prc_amt_12m
,min(case when rep_12m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_min_prc_amt_12m
,max(case when rep_12m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_max_prc_amt_12m
,avg(case when rep_12m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_avg_prc_amt_12m
,count(case when rep_12m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then b.order_no_l else null end) as 15d_range_ord_cnt_12m

,sum(case when rep_24m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_sum_prc_amt_24m
,min(case when rep_24m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_min_prc_amt_24m
,max(case when rep_24m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_max_prc_amt_24m
,avg(case when rep_24m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_avg_prc_amt_24m
,count(case when rep_24m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then b.order_no_l else null end) as 15d_range_ord_cnt_24m

,sum(case when rep_36m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_sum_prc_amt_36m
,min(case when rep_36m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_min_prc_amt_36m
,max(case when rep_36m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_max_prc_amt_36m
,avg(case when rep_36m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_avg_prc_amt_36m
,count(case when rep_36m_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then b.order_no_l else null end) as 15d_range_ord_cnt_36m

,sum(case when rep_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_sum_prc_amt_his
,min(case when rep_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_min_prc_amt_his
,max(case when rep_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_max_prc_amt_his
,avg(case when rep_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then loan_principal else 0 end) as 15d_range_avg_prc_amt_his
,count(case when rep_flg = 1 and due_dte_in_loan_dte_15d_range_cnt > 0 then b.order_no_l else null end) as 15d_range_ord_cnt_his




from 
${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp1 a
left join
${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp2 b
on a.uid = b.uid
and a.mdl_dte = b.mdl_dte
and a.create_time = b.create_time
group by   
  a.uid
  ,a.mdl_dte
;



insert overwrite table ${dwa_risk}.dwa_risk_light_order_repay_crossed_new_df partition(ds='${bizdate}')

select 
    model_data.uid,
    model_data.mdl_dte,
    5d_range_sum_prc_amt_1m,
    5d_range_min_prc_amt_1m,
    5d_range_max_prc_amt_1m,
    5d_range_avg_prc_amt_1m,
    5d_range_ord_cnt_1m,
    5d_range_sum_prc_amt_6m,
    5d_range_min_prc_amt_6m,
    5d_range_max_prc_amt_6m,
    5d_range_avg_prc_amt_6m,
    5d_range_ord_cnt_6m,
    5d_range_sum_prc_amt_12m,
    5d_range_min_prc_amt_12m,
    5d_range_max_prc_amt_12m,
    5d_range_avg_prc_amt_12m,
    5d_range_ord_cnt_12m,
    5d_range_sum_prc_amt_24m,
    5d_range_min_prc_amt_24m,
    5d_range_max_prc_amt_24m,
    5d_range_avg_prc_amt_24m,
    5d_range_ord_cnt_24m,
    5d_range_sum_prc_amt_36m,
    5d_range_min_prc_amt_36m,
    5d_range_max_prc_amt_36m,
    5d_range_avg_prc_amt_36m,
    5d_range_ord_cnt_36m,
    5d_range_sum_prc_amt_his,
    5d_range_min_prc_amt_his,
    5d_range_max_prc_amt_his,
    5d_range_avg_prc_amt_his,
    5d_range_ord_cnt_his,
    10d_range_sum_prc_amt_1m,
    10d_range_min_prc_amt_1m,
    10d_range_max_prc_amt_1m,
    10d_range_avg_prc_amt_1m,
    10d_range_ord_cnt_1m,
    10d_range_sum_prc_amt_6m,
    10d_range_min_prc_amt_6m,
    10d_range_max_prc_amt_6m,
    10d_range_avg_prc_amt_6m,
    10d_range_ord_cnt_6m,
    10d_range_sum_prc_amt_12m,
    10d_range_min_prc_amt_12m,
    10d_range_max_prc_amt_12m,
    10d_range_avg_prc_amt_12m,
    10d_range_ord_cnt_12m,
    10d_range_sum_prc_amt_24m,
    10d_range_min_prc_amt_24m,
    10d_range_max_prc_amt_24m,
    10d_range_avg_prc_amt_24m,
    10d_range_ord_cnt_24m,
    10d_range_sum_prc_amt_36m,
    10d_range_min_prc_amt_36m,
    10d_range_max_prc_amt_36m,
    10d_range_avg_prc_amt_36m,
    10d_range_ord_cnt_36m,
    10d_range_sum_prc_amt_his,
    10d_range_min_prc_amt_his,
    10d_range_max_prc_amt_his,
    10d_range_avg_prc_amt_his,
    10d_range_ord_cnt_his,
    15d_range_sum_prc_amt_1m,
    15d_range_min_prc_amt_1m,
    15d_range_max_prc_amt_1m,
    15d_range_avg_prc_amt_1m,
    15d_range_ord_cnt_1m,
    15d_range_sum_prc_amt_6m,
    15d_range_min_prc_amt_6m,
    15d_range_max_prc_amt_6m,
    15d_range_avg_prc_amt_6m,
    15d_range_ord_cnt_6m,
    15d_range_sum_prc_amt_12m,
    15d_range_min_prc_amt_12m,
    15d_range_max_prc_amt_12m,
    15d_range_avg_prc_amt_12m,
    15d_range_ord_cnt_12m,
    15d_range_sum_prc_amt_24m,
    15d_range_min_prc_amt_24m,
    15d_range_max_prc_amt_24m,
    15d_range_avg_prc_amt_24m,
    15d_range_ord_cnt_24m,
    15d_range_sum_prc_amt_36m,
    15d_range_min_prc_amt_36m,
    15d_range_max_prc_amt_36m,
    15d_range_avg_prc_amt_36m,
    15d_range_ord_cnt_36m,
    15d_range_sum_prc_amt_his,
    15d_range_min_prc_amt_his,
    15d_range_max_prc_amt_his,
    15d_range_avg_prc_amt_his,
    15d_range_ord_cnt_his

from 
(
    select
        uid,
        mdl_dte
       
    from  
    (
        select   *
        from    ${dwa_risk}.dwa_risk_f_light_sample_all_base_df
        where    ds = '${bizdate}' 
        
    ) t

) model_data

left join 

(select * from ${dwa_risk}.dwa_risk_light_order_repay_crossed_tmp3) a

on model_data.uid = a.uid
and model_data.mdl_dte = a.mdl_dte
-- feature-copilot:node-end ordinal=0
