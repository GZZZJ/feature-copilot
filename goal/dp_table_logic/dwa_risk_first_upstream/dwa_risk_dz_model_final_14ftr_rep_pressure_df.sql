-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_14ftr_rep_pressure_df
-- node_id: n_3772090968010784768
-- task_name: dwa_risk_dz_model_final_14ftr_rep_pressure_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_14ftr_rep_pressure_df.json
-- source_json_sha256: 917d9430ee8eb3ea09261314c3a7c8307544f09dad43295d9181699b471296fe
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_detail
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_tmp2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_14ftr_rep_pressure_12stage_plan_tmp1

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_final_14ftr_rep_pressure
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_12stage_plan_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_12stage_plan_tmp1 as 
select  
         main2.uid
        ,main2.mdl_dte
        ,main2.dtl_ord_no
        ,main2.dtl_stg_pln_no
        ,main2.dtl_rep_dte
        ,main2.rep_tim
        ,main2.prc_amt
        ,main2.stg_stt
        ,main2.stg_no

        --应还日和实还日之间的间隔（天）
        ,main2.ddf_rep_tim_dte --应还日和实还日的间隔--for逾期使用
        --实还日和评分日的间隔
        ,main2.ddf_mdl_rep_tim
        --应还日和评分日的间隔
        ,main2.ddf_mdl_rep_dte 

        -- 数据模块flag，对宽表模块对应的数据各自打标
        --/*12、历史还款信息*/12.1.1 历史应还分期计划或历史已还分期计划
        ,case when ddf_mdl_rep_dte>0 or ddf_mdl_rep_tim>0 then 1 else 0 end as is_his_rep_rpm_stg_pln
        --/*12、历史还款信息*/12.1.3 历史应还分期计划
        ,case when ddf_mdl_rep_dte>0 then 1 else 0 end as is_his_rep_stg_pln
        --/*14、未来压力信息*/14.1.1 评分日当天和之后未到期分期计划 
        ,case when ddf_mdl_rep_dte<=0 then 1 else 0 end as is_ftr_rep_stg_pln
        --/*14、未来压力信息*/14.2.1 截止到评分日之前已到期未还分期计划
        ,case when ddf_mdl_rep_dte>0 and ddf_mdl_rep_tim is null then 1 end as is_ovd_future_repay_stg_pln

        --还款状态--flag
        --是否提前还款flag
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte<0 then 1 else 0 end adv_rep_flg
        --历史是否逾期flag
        ,case when ddf_rep_tim_dte>0 then 1 else 0 end as ovd_rep_flg
        --是否还款日当天按时还款
        ,case when ddf_mdl_rep_dte>0 and ddf_rep_tim_dte=0 then 1 else 0 end as d0_rep_flg

        --历史应还日和评分日的间隔（月）时间切片flag
        ,case when ddf_mdl_rep_dte between 1 and 3 then 1 else 0 end as his_rep_stg_pln_3d_flg
        ,case when ddf_mdl_rep_dte between 1 and 7 then 1 else 0 end as his_rep_stg_pln_7d_flg
        ,case when ddf_mdl_rep_dte between 1 and 31 then 1 else 0 end as his_rep_stg_pln_1m_flg
        ,case when ddf_mdl_rep_dte between 1 and 62 then 1 else 0 end as his_rep_stg_pln_2m_flg
        ,case when ddf_mdl_rep_dte between 1 and 92 then 1 else 0 end as his_rep_stg_pln_3m_flg
        ,case when ddf_mdl_rep_dte between 1 and 183 then 1 else 0 end as his_rep_stg_pln_6m_flg
        ,case when ddf_mdl_rep_dte between 1 and 366 then 1 else 0 end as his_rep_stg_pln_12m_flg

        --未来应还日和评分日的间隔（月）时间切片flag
        ,case when ddf_mdl_rep_dte between -3 and 0 then 1 else 0 end as ftr_rep_stg_pln_3d_flg
        ,case when ddf_mdl_rep_dte between -7 and 0 then 1 else 0 end as ftr_rep_stg_pln_7d_flg
        ,case when ddf_mdl_rep_dte between -31 and 0 then 1 else 0 end as ftr_rep_stg_pln_1m_flg
        ,case when ddf_mdl_rep_dte between -62 and 0 then 1 else 0 end as ftr_rep_stg_pln_2m_flg
        ,case when ddf_mdl_rep_dte between -92 and 0 then 1 else 0 end as ftr_rep_stg_pln_3m_flg
        ,case when ddf_mdl_rep_dte between -183 and 0 then 1 else 0 end as ftr_rep_stg_pln_6m_flg
        ,case when ddf_mdl_rep_dte between -366 and 0 then 1 else 0 end as ftr_rep_stg_pln_12m_flg
        
        --应还日和实还日的间隔（月）时间切片的flag--for计算逾期使用
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte) between 1 and 3 then 1 else 0 end as ovd_1d_3d_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>3 then 1 else 0 end as ovd_3d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>7 then 1 else 0 end as ovd_7d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>14 then 1 else 0 end as ovd_14d_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>30 then 1 else 0 end as ovd_m2_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>60 then 1 else 0 end as ovd_m3_pls_flg
        ,case when ddf_mdl_rep_dte>0 and coalesce(ddf_rep_tim_dte,ddf_mdl_rep_dte)>90 then 1 else 0 end as ovd_m4_pls_flg

        --应还日和实还日的间隔（月）时间切片的flag--for计算提前还款使用
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -3 and -1 then 1 else 0 end as adv_3d_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -7 and -1 then 1 else 0 end as adv_7d_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -14 and -1 then 1 else 0 end as adv_14d_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -31 and -1 then 1 else 0 end as adv_1m_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -62 and -1 then 1 else 0 end as adv_2m_flg
        ,case when ddf_mdl_rep_tim>0 and ddf_rep_tim_dte between -92 and -1 then 1 else 0 end as adv_3m_flg
        
        --实还日和评分日的间隔（月）时间切片flag--for还清口径
        ,case when ddf_mdl_rep_tim>0 then 1 else 0 end as rep_flg
        ,case when ddf_mdl_rep_tim between 1 and 7 then 1 else 0 end as rep_7d_flg
        ,case when ddf_mdl_rep_tim between 1 and 14 then 1 else 0 end as rep_14d_flg
        ,case when ddf_mdl_rep_tim between 1 and 31 then 1 else 0 end as rep_1m_flg
        ,case when ddf_mdl_rep_tim between 1 and 92 then 1 else 0 end as rep_3m_flg
        ,case when ddf_mdl_rep_tim between 1 and 183 then 1 else 0 end as rep_6m_flg
        ,case when ddf_mdl_rep_tim between 1 and 366 then 1 else 0 end as rep_12m_flg

        --单日还请金额
        ,sum(case when ddf_mdl_rep_tim>0 then prc_amt else 0 end) over(partition by main2.uid,rep_tim) as prc_amt_pday
        --还清日-单月flag
        ,case when ddf_mdl_rep_tim between 1 and 31 then 1
             when ddf_mdl_rep_tim between 1 and 62 then 2
             when ddf_mdl_rep_tim between 1 and 92 then 3 end as per_rep_mth_flg

        ,order_info_tmp.fst_ord_flg --首借订单
        ,order_info_tmp.cur_ord_flg --当前订单
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

                --应还日和实还日之间的间隔（天）
                ,case when rep_tim is null then datediff(mdl_dte,dtl_rep_dte)
                        else datediff(rep_tim,dtl_rep_dte) end as ddf_rep_tim_dte --应还日和实还日的间隔--for逾期使用
                --实还日和评分日的间隔
                ,datediff(mdl_dte,rep_tim) as ddf_mdl_rep_tim
                --应还日和评分日的间隔
                ,datediff(mdl_dte,dtl_rep_dte) as ddf_mdl_rep_dte 
        from
                (select 
                        model_data.uid
                        ,model_data.mdl_dte

                        ,plan.dtl_ord_no
                        ,plan.dtl_stg_pln_no
                        ,plan.dtl_rep_dte
                        ,case when date(plan.rep_tim)>=model_data.mdl_dte then null else date(plan.rep_tim) end as rep_tim
                        ,plan.prc_amt
                        ,plan.stg_stt
                        ,plan.stg_no
                from    (select uid
                                ,mdl_dte
                        from ${dwa_risk}.dwa_risk_f_dz_model_data_base
                        ) model_data

                        left join
                        (select uid
                                ,ord_no as dtl_ord_no
                                ,stg_pln_no as dtl_stg_pln_no
                                ,rep_dte as dtl_rep_dte
                                ,rep_tim
                                ,prc_amt
                                ,stg_stt
                                ,stg_no
                        from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic
                        where bsy_typ in ('BALANCE_TRANSFER', 'CASH')
                        and stg_stt <> 'R' --分期计划状态
                        )plan on model_data.uid=plan.uid
                )main1
        )main2
        left join
        (select uid
                ,mdl_dte
                ,crt_tim
                ,dtl_ord_no
                ,case when fst_ord_flg=1 then 1 else 0 end as fst_ord_flg --首借订单
                ,cur_ord_flg --当前订单
        from ${dwa_risk}.dwa_risk_f_heavy_order_info_detail
        where ord_stt_flg='success'
        )order_info_tmp on main2.uid=order_info_tmp.uid and main2.dtl_ord_no=order_info_tmp.dtl_ord_no
where order_info_tmp.crt_tim<date(main2.mdl_dte)
;


drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_tmp2 as 
select uid
        ,mdl_dte
-- features range start --

        -- --------------------------------------------------------
        -- /*14.1.1 未到期应还日与评分日的间隔相关变量*/
        -- --不包括model_data(左表)里面传入的当前交易订单信息
        -- --------------------------------------------------------
        -- /*未来应还金额*/
        ,sum(case when is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr
        ,sum(case when ftr_rep_stg_pln_3d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3d_ftr
        ,sum(case when ftr_rep_stg_pln_7d_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_7d_ftr
        ,sum(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr
        ,sum(case when ftr_rep_stg_pln_2m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_2m_ftr
        ,sum(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr
        ,sum(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr
        ,sum(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr
        -- /*未来应还金额/*首借订单和当前订单*/
        ,sum(case when fst_ord_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_fst_ord
        ,sum(case when cur_ord_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_cur_ord

        -- /*未来应还金额--单笔最大*/
        ,max(case when is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ftr
        ,max(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_ftr
        ,max(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_3m_ftr
        ,max(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_ftr
        ,max(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_ftr
        
        -- /*未来应还金额--单笔最小*/
        ,min(case when is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ftr
        ,min(case when ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_ftr
        ,min(case when ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_3m_ftr
        ,min(case when ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_ftr
        ,min(case when ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_ftr
        
        -- /*未来应还分期数*/
        ,count(case when is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr
        ,count(case when ftr_rep_stg_pln_3d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3d_ftr
        ,count(case when ftr_rep_stg_pln_7d_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_7d_ftr
        ,count(case when ftr_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr
        ,count(case when ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr
        ,count(case when ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr
        ,count(case when ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr
        -- /*未来应还分期数/*首借订单和当前订单*/
        ,count(case when fst_ord_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_fst_ord
        ,count(case when cur_ord_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_cur_ord
        
        -- /*未来应还日距评分日天数*/--历史最大、最小
        ,max(case when is_ftr_rep_stg_pln=1 then abs(ddf_mdl_rep_dte) else null end) as max_ddf_mdl_rep_dte_ftr
        ,min(case when is_ftr_rep_stg_pln=1 then abs(ddf_mdl_rep_dte) else null end) as min_ddf_mdl_rep_dte_ftr


        -- ----------------/*未来应还已还订单*/------------------
        -- /*未来应还_已提前还款金额*/
        ,sum(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_adv
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_adv
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_adv
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_adv
        ,sum(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_adv
        -- /*未来应还_已提前还款金额/*首借订单和当前订单*/
        ,sum(case when adv_rep_flg=1 and fst_ord_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_adv_fst_ord
        ,sum(case when adv_rep_flg=1 and cur_ord_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_adv_cur_ord

        -- /*未来应还_已提前还款金额--单笔最大*/
        ,max(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ftr_adv
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_ftr_adv
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_3m_ftr_adv
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_ftr_adv
        ,max(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_ftr_adv
        
        -- /*未来应还_已提前还款金额--单笔最小*/
        ,min(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ftr_adv
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_ftr_adv
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_3m_ftr_adv
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_ftr_adv
        ,min(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_ftr_adv
        
        -- /*未来应还_已提前还款分期数*/
        ,count(case when adv_rep_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_adv
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_adv
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_adv
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_adv
        ,count(case when adv_rep_flg=1 and ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_adv
        -- /*未来应还_已提前还款分期数/*首借订单和当前订单*/
        ,count(case when adv_rep_flg=1 and fst_ord_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_adv_fst_ord
        ,count(case when adv_rep_flg=1 and cur_ord_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_adv_cur_ord
        

        -- ----------------/*未来应还未还订单*/------------------
        -- /*未来应还未还金额*/
        ,sum(case when adv_rep_flg=0 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_rep
        ,sum(case when adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_1m_ftr_rep
        ,sum(case when adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_3m_ftr_rep
        ,sum(case when adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_6m_ftr_rep
        ,sum(case when adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_12m_ftr_rep
        -- /*未来应还未还金额/*首借订单和当前订单*/
        ,sum(case when adv_rep_flg=0 and fst_ord_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_rep_fst_ord
        ,sum(case when adv_rep_flg=0 and cur_ord_flg=1 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ftr_rep_cur_ord

        -- /*未来应还未还金额--单笔最大*/
        ,max(case when adv_rep_flg=0 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ftr_rep
        ,max(case when adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_1m_ftr_rep
        ,max(case when adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_3m_ftr_rep
        ,max(case when adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_6m_ftr_rep
        ,max(case when adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_12m_ftr_rep
        
        -- /*未来应还未还金额--单笔最小*/
        ,min(case when adv_rep_flg=0 and is_ftr_rep_stg_pln=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ftr_rep
        ,min(case when adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_1m_ftr_rep
        ,min(case when adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_3m_ftr_rep
        ,min(case when adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_6m_ftr_rep
        ,min(case when adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_12m_ftr_rep
        
        -- /*未来应还未还分期数*/
        ,count(case when adv_rep_flg=0 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_rep
        ,count(case when adv_rep_flg=0 and ftr_rep_stg_pln_1m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_1m_ftr_rep
        ,count(case when adv_rep_flg=0 and ftr_rep_stg_pln_3m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_3m_ftr_rep
        ,count(case when adv_rep_flg=0 and ftr_rep_stg_pln_6m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_6m_ftr_rep
        ,count(case when adv_rep_flg=0 and ftr_rep_stg_pln_12m_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_12m_ftr_rep
        -- /*未来应还未还分期数/*首借订单和当前订单*/
        ,count(case when adv_rep_flg=0 and fst_ord_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_rep_fst_ord
        ,count(case when adv_rep_flg=0 and cur_ord_flg=1 and is_ftr_rep_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ftr_rep_cur_ord
        

        -- --------------------------------------------------------
        -- /*14.2.1 当前已到期未还_应还日与评分日的间隔*/
        -- --------------------------------------------------------
        -- /*未来应还_当前已逾期应还本金金额*/
        ,sum(case when is_ovd_future_repay_stg_pln=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_ftr_rep
        -- /*未来应还_当前已逾期应还本金金额/*首借订单和当前订单*/
        ,sum(case when is_ovd_future_repay_stg_pln=1 and fst_ord_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_ftr_rep_fst_ord
        ,sum(case when is_ovd_future_repay_stg_pln=1 and cur_ord_flg=1 then prc_amt else 0 end) as stg_pln_sum_prc_amt_ovd_ftr_rep_cur_ord

        -- /*未来应还_当前已逾期应还本金金额--单笔最大*/
        ,max(case when is_ovd_future_repay_stg_pln=1 then prc_amt else 0 end) as stg_pln_max_prc_amt_ovd_ftr_rep
        -- /*未来应还_已逾期应还本金金额--单笔最小*/
        ,min(case when is_ovd_future_repay_stg_pln=1 then prc_amt else 0 end) as stg_pln_min_prc_amt_ovd_ftr_rep
        -- /*未来应还_当前逾期应还分期数*/
        ,count(case when is_ovd_future_repay_stg_pln=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_ftr_rep
        -- /*未来应还_当前逾期应还分期数/*首借订单和当前订单*/
        ,count(case when is_ovd_future_repay_stg_pln=1 and fst_ord_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_ftr_rep_fst_ord
        ,count(case when is_ovd_future_repay_stg_pln=1 and cur_ord_flg=1 then dtl_stg_pln_no else null end) as stg_pln_cnt_ovd_ftr_rep_cur_ord

        -- /*当前逾期计划距评分日天数*/--历史最大、最小
        ,max(case when is_ovd_future_repay_stg_pln=1 then abs(ddf_mdl_rep_dte) else null end) as max_ddf_mdl_rep_dte_ovd_ftr_rep
        ,min(case when is_ovd_future_repay_stg_pln=1 then abs(ddf_mdl_rep_dte) else null end) as min_ddf_mdl_rep_dte_ovd_ftr_rep

        -- --------------------------------------------------------
        -- /*14.3.1 当前已到期未还_应还未还_应还日与评分日的间隔*/
        -- --------------------------------------------------------

-- features range end --

from ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_12stage_plan_tmp1
where is_ftr_rep_stg_pln=1 or is_ovd_future_repay_stg_pln=1 --未来应还的订单or当前逾期未还的订单
group by uid
        ,mdl_dte
;


------------------【特征计算结果表】--------------------

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_df partition(ds='${bizdate}') 
select 
         main.uid
        ,main.mdl_dte
        ,main.stg_pln_sum_prc_amt_ftr
        ,main.stg_pln_sum_prc_amt_1m_ftr
        ,main.stg_pln_sum_prc_amt_2m_ftr
        ,main.stg_pln_sum_prc_amt_3m_ftr
        ,main.stg_pln_sum_prc_amt_6m_ftr
        ,main.stg_pln_sum_prc_amt_12m_ftr
        ,main.stg_pln_sum_prc_amt_ftr_fst_ord
        ,main.stg_pln_sum_prc_amt_ftr_cur_ord
        ,main.stg_pln_max_prc_amt_ftr
        ,main.stg_pln_max_prc_amt_1m_ftr
        ,main.stg_pln_max_prc_amt_3m_ftr
        ,main.stg_pln_max_prc_amt_6m_ftr
        ,main.stg_pln_max_prc_amt_12m_ftr
        ,main.stg_pln_min_prc_amt_ftr
        ,main.stg_pln_min_prc_amt_1m_ftr
        ,main.stg_pln_min_prc_amt_3m_ftr
        ,main.stg_pln_min_prc_amt_6m_ftr
        ,main.stg_pln_min_prc_amt_12m_ftr
        ,main.stg_pln_cnt_ftr
        ,main.stg_pln_cnt_1m_ftr
        ,main.stg_pln_cnt_3m_ftr
        ,main.stg_pln_cnt_6m_ftr
        ,main.stg_pln_cnt_12m_ftr
        ,main.stg_pln_cnt_ftr_fst_ord
        ,main.stg_pln_cnt_ftr_cur_ord
        ,main.max_ddf_mdl_rep_dte_ftr
        ,main.min_ddf_mdl_rep_dte_ftr
        ,main.stg_pln_sum_prc_amt_ftr_adv
        ,main.stg_pln_sum_prc_amt_1m_ftr_adv
        ,main.stg_pln_sum_prc_amt_3m_ftr_adv
        ,main.stg_pln_sum_prc_amt_6m_ftr_adv
        ,main.stg_pln_sum_prc_amt_12m_ftr_adv
        ,main.stg_pln_sum_prc_amt_ftr_adv_fst_ord
        ,main.stg_pln_sum_prc_amt_ftr_adv_cur_ord
        ,main.stg_pln_max_prc_amt_ftr_adv
        ,main.stg_pln_max_prc_amt_1m_ftr_adv
        ,main.stg_pln_max_prc_amt_3m_ftr_adv
        ,main.stg_pln_max_prc_amt_6m_ftr_adv
        ,main.stg_pln_max_prc_amt_12m_ftr_adv
        ,main.stg_pln_min_prc_amt_ftr_adv
        ,main.stg_pln_min_prc_amt_1m_ftr_adv
        ,main.stg_pln_min_prc_amt_3m_ftr_adv
        ,main.stg_pln_min_prc_amt_6m_ftr_adv
        ,main.stg_pln_min_prc_amt_12m_ftr_adv
        ,main.stg_pln_cnt_ftr_adv
        ,main.stg_pln_cnt_1m_ftr_adv
        ,main.stg_pln_cnt_3m_ftr_adv
        ,main.stg_pln_cnt_6m_ftr_adv
        ,main.stg_pln_cnt_12m_ftr_adv
        ,main.stg_pln_cnt_ftr_adv_fst_ord
        ,main.stg_pln_cnt_ftr_adv_cur_ord
        ,main.stg_pln_sum_prc_amt_ftr_rep
        ,main.stg_pln_sum_prc_amt_1m_ftr_rep
        ,main.stg_pln_sum_prc_amt_3m_ftr_rep
        ,main.stg_pln_sum_prc_amt_6m_ftr_rep
        ,main.stg_pln_sum_prc_amt_12m_ftr_rep
        ,main.stg_pln_sum_prc_amt_ftr_rep_fst_ord
        ,main.stg_pln_sum_prc_amt_ftr_rep_cur_ord
        ,main.stg_pln_max_prc_amt_ftr_rep
        ,main.stg_pln_max_prc_amt_1m_ftr_rep
        ,main.stg_pln_max_prc_amt_3m_ftr_rep
        ,main.stg_pln_max_prc_amt_6m_ftr_rep
        ,main.stg_pln_max_prc_amt_12m_ftr_rep
        ,main.stg_pln_min_prc_amt_ftr_rep
        ,main.stg_pln_min_prc_amt_1m_ftr_rep
        ,main.stg_pln_min_prc_amt_3m_ftr_rep
        ,main.stg_pln_min_prc_amt_6m_ftr_rep
        ,main.stg_pln_min_prc_amt_12m_ftr_rep
        ,main.stg_pln_cnt_ftr_rep
        ,main.stg_pln_cnt_1m_ftr_rep
        ,main.stg_pln_cnt_3m_ftr_rep
        ,main.stg_pln_cnt_6m_ftr_rep
        ,main.stg_pln_cnt_12m_ftr_rep
        ,main.stg_pln_cnt_ftr_rep_fst_ord
        ,main.stg_pln_cnt_ftr_rep_cur_ord
        ,main.stg_pln_sum_prc_amt_ovd_ftr_rep
        ,main.stg_pln_sum_prc_amt_ovd_ftr_rep_fst_ord
        ,main.stg_pln_sum_prc_amt_ovd_ftr_rep_cur_ord
        ,main.stg_pln_max_prc_amt_ovd_ftr_rep
        ,main.stg_pln_min_prc_amt_ovd_ftr_rep
        ,main.stg_pln_cnt_ovd_ftr_rep
        ,main.stg_pln_cnt_ovd_ftr_rep_fst_ord
        ,main.stg_pln_cnt_ovd_ftr_rep_cur_ord
        ,main.max_ddf_mdl_rep_dte_ovd_ftr_rep
        ,main.min_ddf_mdl_rep_dte_ovd_ftr_rep


 -- features range start --

        -- --------------------------------------------------------
        -- /*14.1.1 未到期应还日与评分日的间隔相关变量*/
        -- --【不包括】model_data(左表)里面传入的当前交易订单信息
        -- --------------------------------------------------------
        -- 单笔平均应还金额
        ,case when stg_pln_cnt_3m_ftr=0 then null else stg_pln_sum_prc_amt_3m_ftr/stg_pln_cnt_3m_ftr end as stg_pln_avg_prc_amt_3m_ftr
        ,case when stg_pln_cnt_6m_ftr=0 then null else stg_pln_sum_prc_amt_6m_ftr/stg_pln_cnt_6m_ftr end as stg_pln_avg_prc_amt_6m_ftr
        ,case when stg_pln_cnt_12m_ftr=0 then null else stg_pln_sum_prc_amt_12m_ftr/stg_pln_cnt_12m_ftr end as stg_pln_avg_prc_amt_12m_ftr

        -- 单月应还金额
        ,stg_pln_sum_prc_amt_3m_ftr/3 as stg_pln_avg_prc_amt_3m_ftr_per_mth
        ,stg_pln_sum_prc_amt_6m_ftr/6 as stg_pln_avg_prc_amt_6m_ftr_per_mth
        ,stg_pln_sum_prc_amt_12m_ftr/12 as stg_pln_avg_prc_amt_12m_ftr_per_mth

        -- 每月还款金额的变化
        ,stg_pln_sum_prc_amt_1m_ftr/(stg_pln_sum_prc_amt_2m_ftr-stg_pln_sum_prc_amt_1m_ftr) as stg_pln_sum_prc_amt_1m_2m_rto_ftr
        ,stg_pln_sum_prc_amt_3m_ftr/(stg_pln_sum_prc_amt_6m_ftr-stg_pln_sum_prc_amt_3m_ftr) as stg_pln_sum_prc_amt_3m_6m_rto_ftr
        ,stg_pln_sum_prc_amt_6m_ftr/(stg_pln_sum_prc_amt_12m_ftr-stg_pln_sum_prc_amt_6m_ftr) as stg_pln_sum_prc_amt_6m_12m_rto_ftr

        -- 未来应还已还金额占比
        ,case when stg_pln_sum_prc_amt_ftr=0 then null else stg_pln_sum_prc_amt_ftr_adv/stg_pln_sum_prc_amt_ftr end as stg_pln_sum_prc_amt_ftr_adv_rto
        ,case when stg_pln_sum_prc_amt_1m_ftr=0 then null else stg_pln_sum_prc_amt_1m_ftr_adv/stg_pln_sum_prc_amt_1m_ftr end as stg_pln_sum_prc_amt_1m_ftr_adv_rto
        ,case when stg_pln_sum_prc_amt_3m_ftr=0 then null else stg_pln_sum_prc_amt_3m_ftr_adv/stg_pln_sum_prc_amt_3m_ftr end as stg_pln_sum_prc_amt_3m_ftr_adv_rto
        ,case when stg_pln_sum_prc_amt_6m_ftr=0 then null else stg_pln_sum_prc_amt_6m_ftr_adv/stg_pln_sum_prc_amt_6m_ftr end as stg_pln_sum_prc_amt_6m_ftr_adv_rto
        ,case when stg_pln_sum_prc_amt_12m_ftr=0 then null else stg_pln_sum_prc_amt_12m_ftr_adv/stg_pln_sum_prc_amt_12m_ftr end as stg_pln_sum_prc_amt_12m_ftr_adv_rto
        -- 未来应还已还金额占比/*首借订单和当前订单*/
        ,case when stg_pln_sum_prc_amt_ftr_fst_ord=0 then null else stg_pln_sum_prc_amt_ftr_adv_fst_ord/stg_pln_sum_prc_amt_ftr_fst_ord end as stg_pln_sum_prc_amt_ftr_adv_fst_ord_rto
        ,case when stg_pln_sum_prc_amt_ftr_cur_ord=0 then null else stg_pln_sum_prc_amt_ftr_adv_cur_ord/stg_pln_sum_prc_amt_ftr_cur_ord end as stg_pln_sum_prc_amt_ftr_adv_cur_ord_rto

        -- 未来应还已还分期数占比
        ,case when stg_pln_cnt_ftr=0 then null else stg_pln_cnt_ftr_adv/stg_pln_cnt_ftr end as stg_pln_cnt_ftr_adv_rto
        ,case when stg_pln_cnt_1m_ftr=0 then null else stg_pln_cnt_1m_ftr_adv/stg_pln_cnt_1m_ftr end as stg_pln_cnt_1m_ftr_adv_rto
        ,case when stg_pln_cnt_3m_ftr=0 then null else stg_pln_cnt_3m_ftr_adv/stg_pln_cnt_3m_ftr end as stg_pln_cnt_3m_ftr_adv_rto
        ,case when stg_pln_cnt_6m_ftr=0 then null else stg_pln_cnt_6m_ftr_adv/stg_pln_cnt_6m_ftr end as stg_pln_cnt_6m_ftr_adv_rto
        ,case when stg_pln_cnt_12m_ftr=0 then null else stg_pln_cnt_12m_ftr_adv/stg_pln_cnt_12m_ftr end as stg_pln_cnt_12m_ftr_adv_rto
        -- 未来应还已还金额占比/*首借订单和当前订单*/
        ,case when stg_pln_cnt_ftr_fst_ord=0 then null else stg_pln_cnt_ftr_adv_fst_ord/stg_pln_cnt_ftr_fst_ord end as stg_pln_cnt_ftr_adv_fst_ord_rto
        ,case when stg_pln_cnt_ftr_cur_ord=0 then null else stg_pln_cnt_ftr_adv_cur_ord/stg_pln_cnt_ftr_cur_ord end as stg_pln_cnt_ftr_adv_cur_ord_rto
-- features range end --
from
        (select model_data.uid
                ,model_data.mdl_dte
-- features range start --
                -- --------------------------------------------------------
                -- /*14.1.1 未到期应还日与评分日的间隔相关变量*/
                -- --------------------------------------------------------
                -- /*未来应还金额*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr,0) as stg_pln_sum_prc_amt_ftr
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_1m_ftr,0) as stg_pln_sum_prc_amt_1m_ftr
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_2m_ftr,0) as stg_pln_sum_prc_amt_2m_ftr
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_3m_ftr,0) as stg_pln_sum_prc_amt_3m_ftr
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_6m_ftr,0) as stg_pln_sum_prc_amt_6m_ftr
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_12m_ftr,0) as stg_pln_sum_prc_amt_12m_ftr
                -- /*未来应还金额/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_fst_ord,0) as stg_pln_sum_prc_amt_ftr_fst_ord
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_cur_ord,0) as stg_pln_sum_prc_amt_ftr_cur_ord

                -- /*未来应还金额--单笔最大*/
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_ftr,0) as stg_pln_max_prc_amt_ftr
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_1m_ftr,0) as stg_pln_max_prc_amt_1m_ftr
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_3m_ftr,0) as stg_pln_max_prc_amt_3m_ftr
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_6m_ftr,0) as stg_pln_max_prc_amt_6m_ftr
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_12m_ftr,0) as stg_pln_max_prc_amt_12m_ftr

                -- /*未来应还金额--单笔最小*/
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_ftr,0) as stg_pln_min_prc_amt_ftr
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_1m_ftr,0) as stg_pln_min_prc_amt_1m_ftr
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_3m_ftr,0) as stg_pln_min_prc_amt_3m_ftr
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_6m_ftr,0) as stg_pln_min_prc_amt_6m_ftr
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_12m_ftr,0) as stg_pln_min_prc_amt_12m_ftr

                -- /*未来应还分期数*/
                ,coalesce(ftr_rep.stg_pln_cnt_ftr,0) as stg_pln_cnt_ftr
                ,coalesce(ftr_rep.stg_pln_cnt_1m_ftr,0) as stg_pln_cnt_1m_ftr
                ,coalesce(ftr_rep.stg_pln_cnt_3m_ftr,0) as stg_pln_cnt_3m_ftr
                ,coalesce(ftr_rep.stg_pln_cnt_6m_ftr,0) as stg_pln_cnt_6m_ftr
                ,coalesce(ftr_rep.stg_pln_cnt_12m_ftr,0) as stg_pln_cnt_12m_ftr
                -- /*未来应还分期数/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_fst_ord,0) as stg_pln_cnt_ftr_fst_ord
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_cur_ord,0) as stg_pln_cnt_ftr_cur_ord

                -- /*未来应还日距评分日天数*/--历史最大、最小
                ,ftr_rep.max_ddf_mdl_rep_dte_ftr
                ,ftr_rep.min_ddf_mdl_rep_dte_ftr


                -- ----------------/*未来应还已还订单*/------------------
                -- /*未来应还_已提前还款金额*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_adv,0) as stg_pln_sum_prc_amt_ftr_adv
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_1m_ftr_adv,0) as stg_pln_sum_prc_amt_1m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_3m_ftr_adv,0) as stg_pln_sum_prc_amt_3m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_6m_ftr_adv,0) as stg_pln_sum_prc_amt_6m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_12m_ftr_adv,0) as stg_pln_sum_prc_amt_12m_ftr_adv
                -- /*未来应还_已提前还款金额/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_adv_fst_ord,0) as stg_pln_sum_prc_amt_ftr_adv_fst_ord
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_adv_cur_ord,0) as stg_pln_sum_prc_amt_ftr_adv_cur_ord

                -- /*未来应还_已提前还款金额--单笔最大*/
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_ftr_adv,0) as stg_pln_max_prc_amt_ftr_adv
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_1m_ftr_adv,0) as stg_pln_max_prc_amt_1m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_3m_ftr_adv,0) as stg_pln_max_prc_amt_3m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_6m_ftr_adv,0) as stg_pln_max_prc_amt_6m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_12m_ftr_adv,0) as stg_pln_max_prc_amt_12m_ftr_adv

                -- /*未来应还_已提前还款金额--单笔最小*/
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_ftr_adv,0) as stg_pln_min_prc_amt_ftr_adv
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_1m_ftr_adv,0) as stg_pln_min_prc_amt_1m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_3m_ftr_adv,0) as stg_pln_min_prc_amt_3m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_6m_ftr_adv,0) as stg_pln_min_prc_amt_6m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_12m_ftr_adv,0) as stg_pln_min_prc_amt_12m_ftr_adv

                -- /*未来应还_已提前还款分期数*/
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_adv,0) as stg_pln_cnt_ftr_adv
                ,coalesce(ftr_rep.stg_pln_cnt_1m_ftr_adv,0) as stg_pln_cnt_1m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_cnt_3m_ftr_adv,0) as stg_pln_cnt_3m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_cnt_6m_ftr_adv,0) as stg_pln_cnt_6m_ftr_adv
                ,coalesce(ftr_rep.stg_pln_cnt_12m_ftr_adv,0) as stg_pln_cnt_12m_ftr_adv
                -- /*未来应还_已提前还款分期数/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_adv_fst_ord,0) as stg_pln_cnt_ftr_adv_fst_ord
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_adv_cur_ord,0) as stg_pln_cnt_ftr_adv_cur_ord


                -- ----------------/*未来应还未还订单*/------------------
                -- /*未来应还未还金额*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_rep,0) as stg_pln_sum_prc_amt_ftr_rep
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_1m_ftr_rep,0) as stg_pln_sum_prc_amt_1m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_3m_ftr_rep,0) as stg_pln_sum_prc_amt_3m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_6m_ftr_rep,0) as stg_pln_sum_prc_amt_6m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_12m_ftr_rep,0) as stg_pln_sum_prc_amt_12m_ftr_rep
                -- /*未来应还未还金额/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_rep_fst_ord,0) as stg_pln_sum_prc_amt_ftr_rep_fst_ord
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ftr_rep_cur_ord,0) as stg_pln_sum_prc_amt_ftr_rep_cur_ord

                -- /*未来应还未还金额--单笔最大*/
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_ftr_rep,0) as stg_pln_max_prc_amt_ftr_rep
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_1m_ftr_rep,0) as stg_pln_max_prc_amt_1m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_3m_ftr_rep,0) as stg_pln_max_prc_amt_3m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_6m_ftr_rep,0) as stg_pln_max_prc_amt_6m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_12m_ftr_rep,0) as stg_pln_max_prc_amt_12m_ftr_rep

                -- /*未来应还未还金额--单笔最小*/
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_ftr_rep,0) as stg_pln_min_prc_amt_ftr_rep
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_1m_ftr_rep,0) as stg_pln_min_prc_amt_1m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_3m_ftr_rep,0) as stg_pln_min_prc_amt_3m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_6m_ftr_rep,0) as stg_pln_min_prc_amt_6m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_12m_ftr_rep,0) as stg_pln_min_prc_amt_12m_ftr_rep

                -- /*未来应还未还分期数*/
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_rep,0) as stg_pln_cnt_ftr_rep
                ,coalesce(ftr_rep.stg_pln_cnt_1m_ftr_rep,0) as stg_pln_cnt_1m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_cnt_3m_ftr_rep,0) as stg_pln_cnt_3m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_cnt_6m_ftr_rep,0) as stg_pln_cnt_6m_ftr_rep
                ,coalesce(ftr_rep.stg_pln_cnt_12m_ftr_rep,0) as stg_pln_cnt_12m_ftr_rep
                -- /*未来应还未还分期数/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_rep_fst_ord,0) as stg_pln_cnt_ftr_rep_fst_ord
                ,coalesce(ftr_rep.stg_pln_cnt_ftr_rep_cur_ord,0) as stg_pln_cnt_ftr_rep_cur_ord



                -- --------------------------------------------------------
                -- /*14.2.1 当前已到期未还_应还日与评分日的间隔*/
                -- --------------------------------------------------------
                -- /*未来应还_当前已逾期应还本金金额*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ovd_ftr_rep,0) as stg_pln_sum_prc_amt_ovd_ftr_rep
                -- /*未来应还_当前已逾期应还本金金额/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ovd_ftr_rep_fst_ord,0) as stg_pln_sum_prc_amt_ovd_ftr_rep_fst_ord
                ,coalesce(ftr_rep.stg_pln_sum_prc_amt_ovd_ftr_rep_cur_ord,0) as stg_pln_sum_prc_amt_ovd_ftr_rep_cur_ord

                -- /*未来应还_当前已逾期应还本金金额--单笔最大*/
                ,coalesce(ftr_rep.stg_pln_max_prc_amt_ovd_ftr_rep,0) as stg_pln_max_prc_amt_ovd_ftr_rep
                -- /*未来应还_已逾期应还本金金额--单笔最小*/
                ,coalesce(ftr_rep.stg_pln_min_prc_amt_ovd_ftr_rep,0) as stg_pln_min_prc_amt_ovd_ftr_rep
                -- /*未来应还_当前逾期应还分期数*/
                ,coalesce(ftr_rep.stg_pln_cnt_ovd_ftr_rep,0) as stg_pln_cnt_ovd_ftr_rep
                -- /*未来应还_当前逾期应还分期数/*首借订单和当前订单*/
                ,coalesce(ftr_rep.stg_pln_cnt_ovd_ftr_rep_fst_ord,0) as stg_pln_cnt_ovd_ftr_rep_fst_ord
                ,coalesce(ftr_rep.stg_pln_cnt_ovd_ftr_rep_cur_ord,0) as stg_pln_cnt_ovd_ftr_rep_cur_ord

                -- /*当前逾期计划距评分日天数*/--历史最大、最小
                ,ftr_rep.max_ddf_mdl_rep_dte_ovd_ftr_rep
                ,ftr_rep.min_ddf_mdl_rep_dte_ovd_ftr_rep
-- features range end --
        from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data  -- 建模样本
        left join ${dwa_risk}.dwa_risk_dz_model_final_14ftr_rep_pressure_tmp2 ftr_rep on model_data.uid=ftr_rep.uid
        )main;
-- feature-copilot:node-end ordinal=0
