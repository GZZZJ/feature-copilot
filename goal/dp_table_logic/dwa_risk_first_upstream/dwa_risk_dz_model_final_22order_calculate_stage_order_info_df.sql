-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_22order_calculate_stage_order_info_df
-- node_id: n_3772012593447370752
-- task_name: dwa_risk_dz_model_final_22order_calculate_stage_order_info_df
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_22order_calculate_stage_order_info_df.json
-- source_json_sha256: 51e36d40d36df1f82bb6127e435e1bb82a2ad6b1909bdec4b13231f34b5661f2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp3
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp4
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_heavy_order_info_basic
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp1
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp2
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp5
-- upstream_table: dwa_risk.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp6
-- upstream_table: dwa_risk.dwa_risk_f_heavy_stage_plan_basic

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 对应emr上的dmining.dz_model_final_22order_calculate_stage_order_info
--创建者: 颜弘彪
--创建日期: 2022-06-23 18:18:52
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp1;
create table ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp1 as 
select 
    t.uid
    ,t.mdl_dte
    ,t.ord_no
    ,bsy_typ
    ,crt_tim      -- 成功借款或者还款时间点
    ,prc_amt as ord_amt
    --,fst_ord_tim
    --,lst_ord_tim
    ,ord_stt
    ,ord_crt_tim_dt
    ,order_stt
    ,diff_model_dt_ord
    -- ,row_number() over(partition by uid, uid order by mdl_dte desc) as rw
    -- ,row_number() over(partition by uid, uid,order_stt order by mdl_dte desc) as rw_stt
    ,rw
    ,rw_stt
    ,af_1_ord
    ,datediff(date(crt_tim), date(af_1_ord)) as diff_ord_adjoin -- 订单间隔，包括失败订单
    ,if_bt
    ,if_ct
    ,if_cash
    ,if_huge_loan
    ,if_enjoy_pay
    ,if_business_loan
    ,if_jxd

    ,if_bt + if_ct + if_cash + if_huge_loan + if_enjoy_pay + if_business_loan + if_jxd as ord_cnt_sum 
    , if_bt + if_cash as ord_cnt_typ_btch
from 
(
    select 
        model_data.uid
        ,model_data.mdl_dte
        ,rgt2.ord_no
        ,bsy_typ
        ,crt_tim 
        ,prc_amt    
        --,fst_ord_tim
        --,lst_ord_tim
        ,rgt2.ord_stt
        ,ord_crt_tim_dt
        ,rgt2.order_stt
        ,datediff(date(mdl_dte), date(crt_tim)) as diff_model_dt_ord
        ,row_number() over(partition by model_data.uid order by crt_tim desc) as rw
        ,row_number() over(partition by model_data.uid,order_stt order by mdl_dte desc) as rw_stt
        ,lead(crt_tim) over(partition by model_data.uid order by crt_tim desc) as af_1_ord

    from (select uid, mdl_dte from ${dwa_risk}.dwa_risk_f_dz_model_data_base) model_data -- 样本表关联订单表
    left join
        (
            select uid
                ,ord_no
                ,bsy_typ
                ,crt_tim
                ,prc_amt
                ,substring(cast(crt_tim as string),1,10) as ord_crt_tim_dt
                ,case when ord_stt_flg in ('success') then 'suc' else 'fal' end as order_stt -- PAY_OFF 仅仅代表到期结清，而非全部结清
                ,ord_stt
            from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic
            where bsy_typ in ('BALANCE_TRANSFER','CASH') 
            and ord_stt_flg in ('success','fail')  -- 成功借款的记录
        ) rgt2 on model_data.uid = rgt2.uid
        where rgt2.ord_crt_tim_dt < model_data.mdl_dte  -- 这里筛选掉了 订单时间大于 评分日的时间
) t

left join 
    (select -- 订单类型只能在客户层面统计
        uid,
        ord_no,
        case when bsy_typ = 'BALANCE_TRANSFER' then 1 else 0 end as if_bt,
        case when bsy_typ = 'CREDIT_TRANSACTION' then 1 else 0 end as if_ct,
        case when bsy_typ = 'CASH' then 1 else 0 end as if_cash,
        case when bsy_typ = 'HUGE_LOAN' then 1 else 0 end as if_huge_loan,
        case when bsy_typ = 'ENJOY_PAY' then 1 else 0 end as if_enjoy_pay,
        case when bsy_typ = 'BUSINESS_LOAN' then 1 else 0 end as if_business_loan,
        case when bsy_typ in ('JXD_API','JXD') then 1 else 0 end as if_jxd

    from ${dwa_risk}.dwa_risk_f_heavy_order_info_basic
    where bsy_typ in ('BALANCE_TRANSFER', 'CREDIT_TRANSACTION', 'CASH', 'HUGE_LOAN', 'ENJOY_PAY','BUSINESS_LOAN','JXD_API','JXD') 
        and ord_stt_flg in ('success','fail') -- 成功借款的记录
    ) ord_typ on t.uid = ord_typ.uid and t.ord_no = ord_typ.ord_no
;

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp2;
create table ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp2 as 

select 
    uid
    -- 近期与远期
    -- features range start --
    ,cnt_ord_cnt_sum_30d / cnt_ord_cnt_sum_60d as mdt_lst_30d_60d_ord_cnt_sum_rte
,cnt_ord_cnt_suc_30d / cnt_ord_cnt_suc_60d as mdt_lst_30d_60d_ord_cnt_suc_rte
,cnt_ord_cnt_fal_30d / cnt_ord_cnt_fal_60d as mdt_lst_30d_60d_ord_cnt_fal_rte
,cnt_avg_ord_span_30d / cnt_avg_ord_span_60d as mdt_lst_30d_60d_avg_ord_span_rte
,cnt_max_ord_span_30d / cnt_max_ord_span_60d as mdt_lst_30d_60d_max_ord_span_rte
,cnt_min_ord_span_30d / cnt_min_ord_span_60d as mdt_lst_30d_60d_min_ord_span_rte
,cnt_ord_cnt_typ_all_30d / cnt_ord_cnt_typ_all_60d as mdt_lst_30d_60d_ord_cnt_typ_all_rte
,cnt_ord_cnt_typ_btch_30d / cnt_ord_cnt_typ_btch_60d as mdt_lst_30d_60d_ord_cnt_typ_btch_rte
,cnt_ord_cnt_typ_hugl_30d / cnt_ord_cnt_typ_hugl_60d as mdt_lst_30d_60d_ord_cnt_typ_hugl_rte
,cnt_ord_cnt_typ_enj_30d / cnt_ord_cnt_typ_enj_60d as mdt_lst_30d_60d_ord_cnt_typ_enj_rte
,cnt_ord_cnt_typ_btch_rte_30d / cnt_ord_cnt_typ_btch_rte_60d as mdt_lst_30d_60d_ord_cnt_typ_btch_rte_rte
,cnt_ord_cnt_typ_hugl_rte_30d / cnt_ord_cnt_typ_hugl_rte_60d as mdt_lst_30d_60d_ord_cnt_typ_hugl_rte_rte
,cnt_ord_cnt_typ_enj_rte_30d / cnt_ord_cnt_typ_enj_rte_60d as mdt_lst_30d_60d_ord_cnt_typ_enj_rte_rte
,cnt_ord_cnt_sum_30d / cnt_ord_cnt_sum_90d as mdt_lst_30d_90d_ord_cnt_sum_rte
,cnt_ord_cnt_suc_30d / cnt_ord_cnt_suc_90d as mdt_lst_30d_90d_ord_cnt_suc_rte
,cnt_ord_cnt_fal_30d / cnt_ord_cnt_fal_90d as mdt_lst_30d_90d_ord_cnt_fal_rte
,cnt_avg_ord_span_30d / cnt_avg_ord_span_90d as mdt_lst_30d_90d_avg_ord_span_rte
,cnt_max_ord_span_30d / cnt_max_ord_span_90d as mdt_lst_30d_90d_max_ord_span_rte
,cnt_min_ord_span_30d / cnt_min_ord_span_90d as mdt_lst_30d_90d_min_ord_span_rte
,cnt_ord_cnt_typ_all_30d / cnt_ord_cnt_typ_all_90d as mdt_lst_30d_90d_ord_cnt_typ_all_rte
,cnt_ord_cnt_typ_btch_30d / cnt_ord_cnt_typ_btch_90d as mdt_lst_30d_90d_ord_cnt_typ_btch_rte
,cnt_ord_cnt_typ_hugl_30d / cnt_ord_cnt_typ_hugl_90d as mdt_lst_30d_90d_ord_cnt_typ_hugl_rte
,cnt_ord_cnt_typ_enj_30d / cnt_ord_cnt_typ_enj_90d as mdt_lst_30d_90d_ord_cnt_typ_enj_rte
,cnt_ord_cnt_typ_btch_rte_30d / cnt_ord_cnt_typ_btch_rte_90d as mdt_lst_30d_90d_ord_cnt_typ_btch_rte_rte
,cnt_ord_cnt_typ_hugl_rte_30d / cnt_ord_cnt_typ_hugl_rte_90d as mdt_lst_30d_90d_ord_cnt_typ_hugl_rte_rte
,cnt_ord_cnt_typ_enj_rte_30d / cnt_ord_cnt_typ_enj_rte_90d as mdt_lst_30d_90d_ord_cnt_typ_enj_rte_rte
,cnt_ord_cnt_sum_60d / cnt_ord_cnt_sum_90d as mdt_lst_60d_90d_ord_cnt_sum_rte
,cnt_ord_cnt_suc_60d / cnt_ord_cnt_suc_90d as mdt_lst_60d_90d_ord_cnt_suc_rte
,cnt_ord_cnt_fal_60d / cnt_ord_cnt_fal_90d as mdt_lst_60d_90d_ord_cnt_fal_rte
,cnt_avg_ord_span_60d / cnt_avg_ord_span_90d as mdt_lst_60d_90d_avg_ord_span_rte
,cnt_max_ord_span_60d / cnt_max_ord_span_90d as mdt_lst_60d_90d_max_ord_span_rte
,cnt_min_ord_span_60d / cnt_min_ord_span_90d as mdt_lst_60d_90d_min_ord_span_rte
,cnt_ord_cnt_typ_all_60d / cnt_ord_cnt_typ_all_90d as mdt_lst_60d_90d_ord_cnt_typ_all_rte
,cnt_ord_cnt_typ_btch_60d / cnt_ord_cnt_typ_btch_90d as mdt_lst_60d_90d_ord_cnt_typ_btch_rte
,cnt_ord_cnt_typ_hugl_60d / cnt_ord_cnt_typ_hugl_90d as mdt_lst_60d_90d_ord_cnt_typ_hugl_rte
,cnt_ord_cnt_typ_enj_60d / cnt_ord_cnt_typ_enj_90d as mdt_lst_60d_90d_ord_cnt_typ_enj_rte
,cnt_ord_cnt_typ_btch_rte_60d / cnt_ord_cnt_typ_btch_rte_90d as mdt_lst_60d_90d_ord_cnt_typ_btch_rte_rte
,cnt_ord_cnt_typ_hugl_rte_60d / cnt_ord_cnt_typ_hugl_rte_90d as mdt_lst_60d_90d_ord_cnt_typ_hugl_rte_rte
,cnt_ord_cnt_typ_enj_rte_60d / cnt_ord_cnt_typ_enj_rte_90d as mdt_lst_60d_90d_ord_cnt_typ_enj_rte_rte
,cnt_ord_cnt_sum_60d / cnt_ord_cnt_sum_180d as mdt_lst_60d_180d_ord_cnt_sum_rte
,cnt_ord_cnt_suc_60d / cnt_ord_cnt_suc_180d as mdt_lst_60d_180d_ord_cnt_suc_rte
,cnt_ord_cnt_fal_60d / cnt_ord_cnt_fal_180d as mdt_lst_60d_180d_ord_cnt_fal_rte
,cnt_avg_ord_span_60d / cnt_avg_ord_span_180d as mdt_lst_60d_180d_avg_ord_span_rte
,cnt_max_ord_span_60d / cnt_max_ord_span_180d as mdt_lst_60d_180d_max_ord_span_rte
,cnt_min_ord_span_60d / cnt_min_ord_span_180d as mdt_lst_60d_180d_min_ord_span_rte
,cnt_ord_cnt_typ_all_60d / cnt_ord_cnt_typ_all_180d as mdt_lst_60d_180d_ord_cnt_typ_all_rte
,cnt_ord_cnt_typ_btch_60d / cnt_ord_cnt_typ_btch_180d as mdt_lst_60d_180d_ord_cnt_typ_btch_rte
,cnt_ord_cnt_typ_hugl_60d / cnt_ord_cnt_typ_hugl_180d as mdt_lst_60d_180d_ord_cnt_typ_hugl_rte
,cnt_ord_cnt_typ_enj_60d / cnt_ord_cnt_typ_enj_180d as mdt_lst_60d_180d_ord_cnt_typ_enj_rte
,cnt_ord_cnt_typ_btch_rte_60d / cnt_ord_cnt_typ_btch_rte_180d as mdt_lst_60d_180d_ord_cnt_typ_btch_rte_rte
,cnt_ord_cnt_typ_hugl_rte_60d / cnt_ord_cnt_typ_hugl_rte_180d as mdt_lst_60d_180d_ord_cnt_typ_hugl_rte_rte
,cnt_ord_cnt_typ_enj_rte_60d / cnt_ord_cnt_typ_enj_rte_180d as mdt_lst_60d_180d_ord_cnt_typ_enj_rte_rte

    -- %%% 取部分中间变量

    ,cnt_ord_cnt_sum_30d
    ,cnt_ord_cnt_suc_30d
    ,cnt_ord_cnt_fal_30d
    ,cnt_avg_ord_span_30d
    ,cnt_max_ord_span_30d
    ,cnt_min_ord_span_30d
    ,cnt_ord_cnt_typ_all_30d
    ,cnt_ord_cnt_typ_btch_30d
    ,cnt_ord_cnt_typ_hugl_30d
    ,cnt_ord_cnt_typ_enj_30d
    ,cnt_ord_cnt_typ_btch_rte_30d
    ,cnt_ord_cnt_typ_hugl_rte_30d
    ,cnt_ord_cnt_typ_enj_rte_30d

    -- 近期和中期
    ,cnt_ord_cnt_sum_30d / cnt_ord_cnt_sum_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_sum_rte
    ,cnt_ord_cnt_suc_30d / cnt_ord_cnt_suc_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_suc_rte
    ,cnt_ord_cnt_fal_30d / cnt_ord_cnt_fal_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_fal_rte
    ,cnt_avg_ord_span_30d / cnt_avg_ord_span_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_avg_ord_span_rte
    ,cnt_max_ord_span_30d / cnt_max_ord_span_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_max_ord_span_rte
    ,cnt_min_ord_span_30d / cnt_min_ord_span_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_min_ord_span_rte
    ,cnt_ord_cnt_typ_all_30d / cnt_ord_cnt_typ_all_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_all_rte
    ,cnt_ord_cnt_typ_btch_30d / cnt_ord_cnt_typ_btch_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_btch_rte
    ,cnt_ord_cnt_typ_hugl_30d / cnt_ord_cnt_typ_hugl_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_hugl_rte
    ,cnt_ord_cnt_typ_enj_30d / cnt_ord_cnt_typ_enj_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_enj_rte
    ,cnt_ord_cnt_typ_btch_rte_30d / cnt_ord_cnt_typ_btch_rte_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_btch_rte_rte
    ,cnt_ord_cnt_typ_hugl_rte_30d / cnt_ord_cnt_typ_hugl_rte_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_hugl_rte_rte
    ,cnt_ord_cnt_typ_enj_rte_30d / cnt_ord_cnt_typ_enj_rte_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_enj_rte_rte
    ,cnt_ord_cnt_sum_60d / cnt_ord_cnt_sum_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_sum_rte
    ,cnt_ord_cnt_suc_60d / cnt_ord_cnt_suc_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_suc_rte
    ,cnt_ord_cnt_fal_60d / cnt_ord_cnt_fal_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_fal_rte
    ,cnt_avg_ord_span_60d / cnt_avg_ord_span_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_avg_ord_span_rte
    ,cnt_max_ord_span_60d / cnt_max_ord_span_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_max_ord_span_rte
    ,cnt_min_ord_span_60d / cnt_min_ord_span_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_min_ord_span_rte
    ,cnt_ord_cnt_typ_all_60d / cnt_ord_cnt_typ_all_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_all_rte
    ,cnt_ord_cnt_typ_btch_60d / cnt_ord_cnt_typ_btch_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_btch_rte
    ,cnt_ord_cnt_typ_hugl_60d / cnt_ord_cnt_typ_hugl_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_hugl_rte
    ,cnt_ord_cnt_typ_enj_60d / cnt_ord_cnt_typ_enj_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_enj_rte
    ,cnt_ord_cnt_typ_btch_rte_60d / cnt_ord_cnt_typ_btch_rte_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_btch_rte_rte
    ,cnt_ord_cnt_typ_hugl_rte_60d / cnt_ord_cnt_typ_hugl_rte_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_hugl_rte_rte
    ,cnt_ord_cnt_typ_enj_rte_60d / cnt_ord_cnt_typ_enj_rte_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_enj_rte_rte
    ,cnt_ord_cnt_sum_60d / cnt_ord_cnt_sum_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_sum_rte
    ,cnt_ord_cnt_suc_60d / cnt_ord_cnt_suc_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_suc_rte
    ,cnt_ord_cnt_fal_60d / cnt_ord_cnt_fal_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_fal_rte
    ,cnt_avg_ord_span_60d / cnt_avg_ord_span_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_avg_ord_span_rte
    ,cnt_max_ord_span_60d / cnt_max_ord_span_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_max_ord_span_rte
    ,cnt_min_ord_span_60d / cnt_min_ord_span_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_min_ord_span_rte
    ,cnt_ord_cnt_typ_all_60d / cnt_ord_cnt_typ_all_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_all_rte
    ,cnt_ord_cnt_typ_btch_60d / cnt_ord_cnt_typ_btch_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_btch_rte
    ,cnt_ord_cnt_typ_hugl_60d / cnt_ord_cnt_typ_hugl_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_hugl_rte
    ,cnt_ord_cnt_typ_enj_60d / cnt_ord_cnt_typ_enj_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_enj_rte
    ,cnt_ord_cnt_typ_btch_rte_60d / cnt_ord_cnt_typ_btch_rte_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_btch_rte_rte
    ,cnt_ord_cnt_typ_hugl_rte_60d / cnt_ord_cnt_typ_hugl_rte_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_hugl_rte_rte
    ,cnt_ord_cnt_typ_enj_rte_60d / cnt_ord_cnt_typ_enj_rte_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_enj_rte_rte
    ,cnt_ord_cnt_sum_90d / cnt_ord_cnt_sum_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_sum_rte
    ,cnt_ord_cnt_suc_90d / cnt_ord_cnt_suc_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_suc_rte
    ,cnt_ord_cnt_fal_90d / cnt_ord_cnt_fal_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_fal_rte
    ,cnt_avg_ord_span_90d / cnt_avg_ord_span_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_avg_ord_span_rte
    ,cnt_max_ord_span_90d / cnt_max_ord_span_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_max_ord_span_rte
    ,cnt_min_ord_span_90d / cnt_min_ord_span_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_min_ord_span_rte
    ,cnt_ord_cnt_typ_all_90d / cnt_ord_cnt_typ_all_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_all_rte
    ,cnt_ord_cnt_typ_btch_90d / cnt_ord_cnt_typ_btch_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_btch_rte
    ,cnt_ord_cnt_typ_hugl_90d / cnt_ord_cnt_typ_hugl_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_hugl_rte
    ,cnt_ord_cnt_typ_enj_90d / cnt_ord_cnt_typ_enj_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_enj_rte
    ,cnt_ord_cnt_typ_btch_rte_90d / cnt_ord_cnt_typ_btch_rte_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_btch_rte_rte
    ,cnt_ord_cnt_typ_hugl_rte_90d / cnt_ord_cnt_typ_hugl_rte_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_hugl_rte_rte
    ,cnt_ord_cnt_typ_enj_rte_90d / cnt_ord_cnt_typ_enj_rte_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_enj_rte_rte

    -- %%% 部分中间变量
    ,cnt_ord_cnt_sum_30d_60d
    ,cnt_ord_cnt_suc_30d_60d
    ,cnt_ord_cnt_fal_30d_60d
    ,cnt_avg_ord_span_30d_60d
    ,cnt_max_ord_span_30d_60d
    ,cnt_min_ord_span_30d_60d
    ,cnt_ord_cnt_typ_all_30d_60d
    ,cnt_ord_cnt_typ_btch_30d_60d
    ,cnt_ord_cnt_typ_hugl_30d_60d
    ,cnt_ord_cnt_typ_enj_30d_60d
    ,cnt_ord_cnt_typ_btch_rte_30d_60d
    ,cnt_ord_cnt_typ_hugl_rte_30d_60d
    ,cnt_ord_cnt_typ_enj_rte_30d_60d
    ,cnt_ord_cnt_sum_30d_90d
    ,cnt_ord_cnt_suc_30d_90d
    ,cnt_ord_cnt_fal_30d_90d
    ,cnt_avg_ord_span_30d_90d
    ,cnt_max_ord_span_30d_90d
    ,cnt_min_ord_span_30d_90d
    ,cnt_ord_cnt_typ_all_30d_90d
    ,cnt_ord_cnt_typ_btch_30d_90d
    ,cnt_ord_cnt_typ_hugl_30d_90d
    ,cnt_ord_cnt_typ_enj_30d_90d
    ,cnt_ord_cnt_typ_btch_rte_30d_90d
    ,cnt_ord_cnt_typ_hugl_rte_30d_90d
    ,cnt_ord_cnt_typ_enj_rte_30d_90d
    -- features range end --
from
(
    select 
     uid
    -- 近期 构造中间变量
    -- features range start --
    ,count(case when diff_model_dt_ord between 1 and 30 then 1 else null end) as cnt_ord_cnt_sum_30d
    ,count(case when diff_model_dt_ord between 1 and 30 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_30d
    ,count(case when diff_model_dt_ord between 1 and 30 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_30d
    ,avg(case when diff_model_dt_ord between 1 and 30 then diff_ord_adjoin else null end) as cnt_avg_ord_span_30d
    ,max(case when diff_model_dt_ord between 1 and 30 then diff_ord_adjoin else null end) as cnt_max_ord_span_30d
    ,min(case when diff_model_dt_ord between 1 and 30 then diff_ord_adjoin else null end) as cnt_min_ord_span_30d
    ,sum(case when diff_model_dt_ord between 1 and 30 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_30d
    ,sum(case when diff_model_dt_ord between 1 and 30 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_30d
    ,sum(case when diff_model_dt_ord between 1 and 30 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_30d
    ,sum(case when diff_model_dt_ord between 1 and 30 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_30d
    ,sum(case when diff_model_dt_ord between 1 and 30 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 1 and 30 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_30d
    ,sum(case when diff_model_dt_ord between 1 and 30 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 1 and 30 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_30d
    ,sum(case when diff_model_dt_ord between 1 and 30 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 1 and 30 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_30d
    ,count(case when diff_model_dt_ord between 1 and 60 then 1 else null end) as cnt_ord_cnt_sum_60d
    ,count(case when diff_model_dt_ord between 1 and 60 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_60d
    ,count(case when diff_model_dt_ord between 1 and 60 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_60d
    ,avg(case when diff_model_dt_ord between 1 and 60 then diff_ord_adjoin else null end) as cnt_avg_ord_span_60d
    ,max(case when diff_model_dt_ord between 1 and 60 then diff_ord_adjoin else null end) as cnt_max_ord_span_60d
    ,min(case when diff_model_dt_ord between 1 and 60 then diff_ord_adjoin else null end) as cnt_min_ord_span_60d
    ,sum(case when diff_model_dt_ord between 1 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_60d
    ,sum(case when diff_model_dt_ord between 1 and 60 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_60d
    ,sum(case when diff_model_dt_ord between 1 and 60 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_60d
    ,sum(case when diff_model_dt_ord between 1 and 60 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_60d
    ,sum(case when diff_model_dt_ord between 1 and 60 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 1 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_60d
    ,sum(case when diff_model_dt_ord between 1 and 60 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 1 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_60d
    ,sum(case when diff_model_dt_ord between 1 and 60 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 1 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_60d
    ,count(case when diff_model_dt_ord between 1 and 90 then 1 else null end) as cnt_ord_cnt_sum_90d
    ,count(case when diff_model_dt_ord between 1 and 90 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_90d
    ,count(case when diff_model_dt_ord between 1 and 90 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_90d
    ,avg(case when diff_model_dt_ord between 1 and 90 then diff_ord_adjoin else null end) as cnt_avg_ord_span_90d
    ,max(case when diff_model_dt_ord between 1 and 90 then diff_ord_adjoin else null end) as cnt_max_ord_span_90d
    ,min(case when diff_model_dt_ord between 1 and 90 then diff_ord_adjoin else null end) as cnt_min_ord_span_90d
    ,sum(case when diff_model_dt_ord between 1 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_90d
    ,sum(case when diff_model_dt_ord between 1 and 90 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_90d
    ,sum(case when diff_model_dt_ord between 1 and 90 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_90d
    ,sum(case when diff_model_dt_ord between 1 and 90 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_90d
    ,sum(case when diff_model_dt_ord between 1 and 90 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 1 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_90d
    ,sum(case when diff_model_dt_ord between 1 and 90 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 1 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_90d
    ,sum(case when diff_model_dt_ord between 1 and 90 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 1 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_90d
    ,count(case when diff_model_dt_ord between 1 and 180 then 1 else null end) as cnt_ord_cnt_sum_180d
    ,count(case when diff_model_dt_ord between 1 and 180 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_180d
    ,count(case when diff_model_dt_ord between 1 and 180 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_180d
    ,avg(case when diff_model_dt_ord between 1 and 180 then diff_ord_adjoin else null end) as cnt_avg_ord_span_180d
    ,max(case when diff_model_dt_ord between 1 and 180 then diff_ord_adjoin else null end) as cnt_max_ord_span_180d
    ,min(case when diff_model_dt_ord between 1 and 180 then diff_ord_adjoin else null end) as cnt_min_ord_span_180d
    ,sum(case when diff_model_dt_ord between 1 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_180d
    ,sum(case when diff_model_dt_ord between 1 and 180 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_180d
    ,sum(case when diff_model_dt_ord between 1 and 180 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_180d
    ,sum(case when diff_model_dt_ord between 1 and 180 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_180d
    ,sum(case when diff_model_dt_ord between 1 and 180 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 1 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_180d
    ,sum(case when diff_model_dt_ord between 1 and 180 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 1 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_180d
    ,sum(case when diff_model_dt_ord between 1 and 180 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 1 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_180d

    ,count(case when diff_model_dt_ord between 30 and 60 then 1 else null end) as cnt_ord_cnt_sum_30d_60d
    ,count(case when diff_model_dt_ord between 30 and 60 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_30d_60d
    ,count(case when diff_model_dt_ord between 30 and 60 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_30d_60d
    ,avg(case when diff_model_dt_ord between 30 and 60 then diff_ord_adjoin else null end) as cnt_avg_ord_span_30d_60d
    ,max(case when diff_model_dt_ord between 30 and 60 then diff_ord_adjoin else null end) as cnt_max_ord_span_30d_60d
    ,min(case when diff_model_dt_ord between 30 and 60 then diff_ord_adjoin else null end) as cnt_min_ord_span_30d_60d
    ,sum(case when diff_model_dt_ord between 30 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_30d_60d
    ,sum(case when diff_model_dt_ord between 30 and 60 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_30d_60d
    ,sum(case when diff_model_dt_ord between 30 and 60 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_30d_60d
    ,sum(case when diff_model_dt_ord between 30 and 60 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_30d_60d
    ,sum(case when diff_model_dt_ord between 30 and 60 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 30 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_30d_60d
    ,sum(case when diff_model_dt_ord between 30 and 60 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 30 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_30d_60d
    ,sum(case when diff_model_dt_ord between 30 and 60 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 30 and 60 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_30d_60d
    ,count(case when diff_model_dt_ord between 30 and 90 then 1 else null end) as cnt_ord_cnt_sum_30d_90d
    ,count(case when diff_model_dt_ord between 30 and 90 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_30d_90d
    ,count(case when diff_model_dt_ord between 30 and 90 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_30d_90d
    ,avg(case when diff_model_dt_ord between 30 and 90 then diff_ord_adjoin else null end) as cnt_avg_ord_span_30d_90d
    ,max(case when diff_model_dt_ord between 30 and 90 then diff_ord_adjoin else null end) as cnt_max_ord_span_30d_90d
    ,min(case when diff_model_dt_ord between 30 and 90 then diff_ord_adjoin else null end) as cnt_min_ord_span_30d_90d
    ,sum(case when diff_model_dt_ord between 30 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_30d_90d
    ,sum(case when diff_model_dt_ord between 30 and 90 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_30d_90d
    ,sum(case when diff_model_dt_ord between 30 and 90 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_30d_90d
    ,sum(case when diff_model_dt_ord between 30 and 90 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_30d_90d
    ,sum(case when diff_model_dt_ord between 30 and 90 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 30 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_30d_90d
    ,sum(case when diff_model_dt_ord between 30 and 90 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 30 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_30d_90d
    ,sum(case when diff_model_dt_ord between 30 and 90 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 30 and 90 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_30d_90d
    ,count(case when diff_model_dt_ord between 60 and 120 then 1 else null end) as cnt_ord_cnt_sum_60d_120d
    ,count(case when diff_model_dt_ord between 60 and 120 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_60d_120d
    ,count(case when diff_model_dt_ord between 60 and 120 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_60d_120d
    ,avg(case when diff_model_dt_ord between 60 and 120 then diff_ord_adjoin else null end) as cnt_avg_ord_span_60d_120d
    ,max(case when diff_model_dt_ord between 60 and 120 then diff_ord_adjoin else null end) as cnt_max_ord_span_60d_120d
    ,min(case when diff_model_dt_ord between 60 and 120 then diff_ord_adjoin else null end) as cnt_min_ord_span_60d_120d
    ,sum(case when diff_model_dt_ord between 60 and 120 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_60d_120d
    ,sum(case when diff_model_dt_ord between 60 and 120 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_60d_120d
    ,sum(case when diff_model_dt_ord between 60 and 120 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_60d_120d
    ,sum(case when diff_model_dt_ord between 60 and 120 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_60d_120d
    ,sum(case when diff_model_dt_ord between 60 and 120 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 60 and 120 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_60d_120d
    ,sum(case when diff_model_dt_ord between 60 and 120 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 60 and 120 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_60d_120d
    ,sum(case when diff_model_dt_ord between 60 and 120 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 60 and 120 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_60d_120d
    ,count(case when diff_model_dt_ord between 60 and 180 then 1 else null end) as cnt_ord_cnt_sum_60d_180d
    ,count(case when diff_model_dt_ord between 60 and 180 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_60d_180d
    ,count(case when diff_model_dt_ord between 60 and 180 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_60d_180d
    ,avg(case when diff_model_dt_ord between 60 and 180 then diff_ord_adjoin else null end) as cnt_avg_ord_span_60d_180d
    ,max(case when diff_model_dt_ord between 60 and 180 then diff_ord_adjoin else null end) as cnt_max_ord_span_60d_180d
    ,min(case when diff_model_dt_ord between 60 and 180 then diff_ord_adjoin else null end) as cnt_min_ord_span_60d_180d
    ,sum(case when diff_model_dt_ord between 60 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_60d_180d
    ,sum(case when diff_model_dt_ord between 60 and 180 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_60d_180d
    ,sum(case when diff_model_dt_ord between 60 and 180 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_60d_180d
    ,sum(case when diff_model_dt_ord between 60 and 180 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_60d_180d
    ,sum(case when diff_model_dt_ord between 60 and 180 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 60 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_60d_180d
    ,sum(case when diff_model_dt_ord between 60 and 180 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 60 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_60d_180d
    ,sum(case when diff_model_dt_ord between 60 and 180 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 60 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_60d_180d
    ,count(case when diff_model_dt_ord between 90 and 180 then 1 else null end) as cnt_ord_cnt_sum_90d_180d
    ,count(case when diff_model_dt_ord between 90 and 180 and order_stt = 'suc' then 1 else null end) as cnt_ord_cnt_suc_90d_180d
    ,count(case when diff_model_dt_ord between 90 and 180 and order_stt in ('fal') then 1 else null end) as cnt_ord_cnt_fal_90d_180d
    ,avg(case when diff_model_dt_ord between 90 and 180 then diff_ord_adjoin else null end) as cnt_avg_ord_span_90d_180d
    ,max(case when diff_model_dt_ord between 90 and 180 then diff_ord_adjoin else null end) as cnt_max_ord_span_90d_180d
    ,min(case when diff_model_dt_ord between 90 and 180 then diff_ord_adjoin else null end) as cnt_min_ord_span_90d_180d
    ,sum(case when diff_model_dt_ord between 90 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_all_90d_180d
    ,sum(case when diff_model_dt_ord between 90 and 180 then ord_cnt_typ_btch else null end) as cnt_ord_cnt_typ_btch_90d_180d
    ,sum(case when diff_model_dt_ord between 90 and 180 then if_huge_loan else null end) as cnt_ord_cnt_typ_hugl_90d_180d
    ,sum(case when diff_model_dt_ord between 90 and 180 then if_enjoy_pay else null end) as cnt_ord_cnt_typ_enj_90d_180d
    ,sum(case when diff_model_dt_ord between 90 and 180 then ord_cnt_typ_btch else null end) / sum(case when diff_model_dt_ord between 90 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_btch_rte_90d_180d
    ,sum(case when diff_model_dt_ord between 90 and 180 then if_huge_loan else null end) / sum(case when diff_model_dt_ord between 90 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_hugl_rte_90d_180d
    ,sum(case when diff_model_dt_ord between 90 and 180 then if_enjoy_pay else null end) / sum(case when diff_model_dt_ord between 90 and 180 then ord_cnt_sum else null end) as cnt_ord_cnt_typ_enj_rte_90d_180d

    -- features range end --
    from  ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp1 group by uid
) t;



-- ************  ***********  ***********  ***********  ***********  ***********  ***********
-- ************  ***********  ***********  ***********  ***********  ***********  ***********
-- ************  ***********  ***********  ***********  ***********  ***********  ***********


-- 关联还款计划表
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp3;
create table ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp3 as 

select 
    base3.uid
    ,base3.ord_no
        ,mdl_dte
    ,base3.bsy_typ
    ,crt_tim   -- 订单时间
    --,fst_ord_tim
    --,lst_ord_tim
    ,ord_stt
    ,stage_stt
    ,ord_crt_tim_dt
    ,diff_ord_adjoin
    ,order_stt
    ,diff_model_dt_ord
    -- ,datediff(date(mdl_dte), date(crt_tim)) as diff_model_dt_ord -- 订单距离评分日的时间
    ,datediff(date(mdl_dte), date(rep_dte)) as diff_model_dt_stg_dte -- 应还日距离评分日的时间
    ,case when rep_tim is not null then datediff(date(mdl_dte), date(rep_tim)) else null end as diff_model_dt_stg_tim -- shi还日距离评分日的时间
    ,rw
    ,rw_stt 
    -- 以上是订单表携带字段
    ,rep_tim    -- 实际还款时间  
    ,rep_dte
    ,principle
        ,stg_stt -- 拒绝的订单为空
    ,stg_typ -- 期数类型
    ,stg_no -- 分期计划号码
    ,ovd_stt -- 逾期状态
    ,case when rep_tim is not null then datediff(date(rep_tim), date(rep_dte)) 
          when rep_tim is null then datediff(date(mdl_dte), date(rep_dte)) 
          else null end as stg_ovd_days
    , case when rep_tim is not null and date(rep_tim) < date(rep_dte) then '提前还款'
        when rep_tim is not null and date(rep_tim) = date(rep_dte) then "当天还款"
        when rep_tim is not null and date(rep_tim) > date(rep_dte) then "逾期还款"
        when rep_tim is null and date(mdl_dte) > date(rep_dte) then "逾期未还"
        when rep_tim is null and date(mdl_dte) <= date(rep_dte) then "未到还款时间"
        else null end as stg_stt_slf -- 自己定义逾期订单状态

    -- 可以继续添加 已还额度 / 
    ,prc_amt 
    , case when rep_tim is null and date(mdl_dte) > date(rep_dte) then prc_amt else 0 end as amt_overdue
from ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp1 base3 -- 每个样本都关联了所有 右表
left join
    (

    select uid
        ,ord_no
        ,bsy_typ
        ,rep_tim
        ,rep_dte -- 到期日
        --,substring(cast(rep_tim as string),1,10) as crt_tim_dt
        ,case when prc_amt is null then 0 else  prc_amt end as principle
        ,-1 as drt
        ,case when stg_stt in ('PAY_OFF') then '结清' else '未结清' end as stage_stt
        ,stg_stt
        ,stg_typ -- 期数类型
        ,stg_no -- 分期计划号码
        ,ovd_stt -- 逾期状态
        ,prc_amt -- 金额, 应还金额

    from ${dwa_risk}.dwa_risk_f_heavy_stage_plan_basic
    where bsy_typ in ('BALANCE_TRANSFER','CASH')  
    and stg_stt <> 'R' -- 还清的记录
    ) rgt2 on base3.uid = rgt2.uid and base3.ord_no = rgt2.ord_no
    -- where date(mdl_dte) > date(crt_tim) and date(mdl_dte) > date(rep_dte)
        where  date(base3.crt_tim) <  date(base3.mdl_dte) and date(rgt2.rep_dte) <  date(base3.mdl_dte)   -- 这里筛选掉了 订单时间大于 计算点的订单 / 还款时间不做限定
;



-- 计算分期维度信息 / 归到订单 / key_id 纬度

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp5;
create table ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp5 as 
select 
    uid
    -- 近期与远期
    -- features range start --
    ,cnt_stg_cnt_30d / cnt_stg_cnt_60d as mdt_lst_30d_60d_stg_cnt_rte
,cnt_stg_cnt_advance_30d / cnt_stg_cnt_advance_60d as mdt_lst_30d_60d_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_30d / cnt_stg_cnt_ever_overdue_60d as mdt_lst_30d_60d_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_30d / cnt_stg_cnt_cur_overdue_60d as mdt_lst_30d_60d_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_30d / cnt_stg_cnt_ever_overdue_rte_60d as mdt_lst_30d_60d_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_30d / cnt_stg_cnt_undue_60d as mdt_lst_30d_60d_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_30d / cnt_stg_ever_max_overdue_days_60d as mdt_lst_30d_60d_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_30d / cnt_stg_ever_avg_overdue_days_60d as mdt_lst_30d_60d_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_30d / cnt_ever_overdue_days_3_cnt_60d as mdt_lst_30d_60d_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_30d / cnt_ever_overdue_days_30_cnt_60d as mdt_lst_30d_60d_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_30d / cnt_ever_overdue_days_15_cnt_60d as mdt_lst_30d_60d_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_30d / cnt_stg_amt_advance_60d as mdt_lst_30d_60d_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_30d / cnt_stg_amt_ever_overdue_60d as mdt_lst_30d_60d_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_30d / cnt_stg_amt_cur_overdue_60d as mdt_lst_30d_60d_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_30d / cnt_stg_amt_fur_repay_60d as mdt_lst_30d_60d_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_30d / cnt_stg_amt_ever_overdue_rte_60d as mdt_lst_30d_60d_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_30d / cnt_stg_max_tim_rep_mdt_60d as mdt_lst_30d_60d_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_30d / cnt_amt_overdue_500_cnt_60d as mdt_lst_30d_60d_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_30d / cnt_amt_overdue_2000_cnt_60d as mdt_lst_30d_60d_amt_overdue_2000_cnt_rte
,cnt_stg_cnt_30d / cnt_stg_cnt_90d as mdt_lst_30d_90d_stg_cnt_rte
,cnt_stg_cnt_advance_30d / cnt_stg_cnt_advance_90d as mdt_lst_30d_90d_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_30d / cnt_stg_cnt_ever_overdue_90d as mdt_lst_30d_90d_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_30d / cnt_stg_cnt_cur_overdue_90d as mdt_lst_30d_90d_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_30d / cnt_stg_cnt_ever_overdue_rte_90d as mdt_lst_30d_90d_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_30d / cnt_stg_cnt_undue_90d as mdt_lst_30d_90d_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_30d / cnt_stg_ever_max_overdue_days_90d as mdt_lst_30d_90d_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_30d / cnt_stg_ever_avg_overdue_days_90d as mdt_lst_30d_90d_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_30d / cnt_ever_overdue_days_3_cnt_90d as mdt_lst_30d_90d_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_30d / cnt_ever_overdue_days_30_cnt_90d as mdt_lst_30d_90d_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_30d / cnt_ever_overdue_days_15_cnt_90d as mdt_lst_30d_90d_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_30d / cnt_stg_amt_advance_90d as mdt_lst_30d_90d_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_30d / cnt_stg_amt_ever_overdue_90d as mdt_lst_30d_90d_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_30d / cnt_stg_amt_cur_overdue_90d as mdt_lst_30d_90d_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_30d / cnt_stg_amt_fur_repay_90d as mdt_lst_30d_90d_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_30d / cnt_stg_amt_ever_overdue_rte_90d as mdt_lst_30d_90d_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_30d / cnt_stg_max_tim_rep_mdt_90d as mdt_lst_30d_90d_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_30d / cnt_amt_overdue_500_cnt_90d as mdt_lst_30d_90d_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_30d / cnt_amt_overdue_2000_cnt_90d as mdt_lst_30d_90d_amt_overdue_2000_cnt_rte
,cnt_stg_cnt_60d / cnt_stg_cnt_90d as mdt_lst_60d_90d_stg_cnt_rte
,cnt_stg_cnt_advance_60d / cnt_stg_cnt_advance_90d as mdt_lst_60d_90d_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_60d / cnt_stg_cnt_ever_overdue_90d as mdt_lst_60d_90d_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_60d / cnt_stg_cnt_cur_overdue_90d as mdt_lst_60d_90d_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_60d / cnt_stg_cnt_ever_overdue_rte_90d as mdt_lst_60d_90d_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_60d / cnt_stg_cnt_undue_90d as mdt_lst_60d_90d_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_60d / cnt_stg_ever_max_overdue_days_90d as mdt_lst_60d_90d_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_60d / cnt_stg_ever_avg_overdue_days_90d as mdt_lst_60d_90d_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_60d / cnt_ever_overdue_days_3_cnt_90d as mdt_lst_60d_90d_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_60d / cnt_ever_overdue_days_30_cnt_90d as mdt_lst_60d_90d_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_60d / cnt_ever_overdue_days_15_cnt_90d as mdt_lst_60d_90d_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_60d / cnt_stg_amt_advance_90d as mdt_lst_60d_90d_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_60d / cnt_stg_amt_ever_overdue_90d as mdt_lst_60d_90d_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_60d / cnt_stg_amt_cur_overdue_90d as mdt_lst_60d_90d_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_60d / cnt_stg_amt_fur_repay_90d as mdt_lst_60d_90d_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_60d / cnt_stg_amt_ever_overdue_rte_90d as mdt_lst_60d_90d_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_60d / cnt_stg_max_tim_rep_mdt_90d as mdt_lst_60d_90d_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_60d / cnt_amt_overdue_500_cnt_90d as mdt_lst_60d_90d_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_60d / cnt_amt_overdue_2000_cnt_90d as mdt_lst_60d_90d_amt_overdue_2000_cnt_rte
,cnt_stg_cnt_60d / cnt_stg_cnt_180d as mdt_lst_60d_180d_stg_cnt_rte
,cnt_stg_cnt_advance_60d / cnt_stg_cnt_advance_180d as mdt_lst_60d_180d_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_60d / cnt_stg_cnt_ever_overdue_180d as mdt_lst_60d_180d_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_60d / cnt_stg_cnt_cur_overdue_180d as mdt_lst_60d_180d_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_60d / cnt_stg_cnt_ever_overdue_rte_180d as mdt_lst_60d_180d_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_60d / cnt_stg_cnt_undue_180d as mdt_lst_60d_180d_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_60d / cnt_stg_ever_max_overdue_days_180d as mdt_lst_60d_180d_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_60d / cnt_stg_ever_avg_overdue_days_180d as mdt_lst_60d_180d_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_60d / cnt_ever_overdue_days_3_cnt_180d as mdt_lst_60d_180d_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_60d / cnt_ever_overdue_days_30_cnt_180d as mdt_lst_60d_180d_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_60d / cnt_ever_overdue_days_15_cnt_180d as mdt_lst_60d_180d_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_60d / cnt_stg_amt_advance_180d as mdt_lst_60d_180d_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_60d / cnt_stg_amt_ever_overdue_180d as mdt_lst_60d_180d_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_60d / cnt_stg_amt_cur_overdue_180d as mdt_lst_60d_180d_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_60d / cnt_stg_amt_fur_repay_180d as mdt_lst_60d_180d_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_60d / cnt_stg_amt_ever_overdue_rte_180d as mdt_lst_60d_180d_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_60d / cnt_stg_max_tim_rep_mdt_180d as mdt_lst_60d_180d_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_60d / cnt_amt_overdue_500_cnt_180d as mdt_lst_60d_180d_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_60d / cnt_amt_overdue_2000_cnt_180d as mdt_lst_60d_180d_amt_overdue_2000_cnt_rte
    -- %%% 取部分中间变量
    ,cnt_stg_cnt_30d
    ,cnt_stg_cnt_advance_30d
    ,cnt_stg_cnt_ever_overdue_30d
    ,cnt_stg_cnt_cur_overdue_30d
    ,cnt_stg_cnt_ever_overdue_rte_30d
    ,cnt_stg_cnt_undue_30d
    ,cnt_stg_ever_max_overdue_days_30d
    ,cnt_stg_ever_avg_overdue_days_30d
    ,cnt_ever_overdue_days_3_cnt_30d
    ,cnt_ever_overdue_days_30_cnt_30d
    ,cnt_ever_overdue_days_15_cnt_30d
    ,cnt_stg_amt_advance_30d
    ,cnt_stg_amt_ever_overdue_30d
    ,cnt_stg_amt_cur_overdue_30d
    ,cnt_stg_amt_fur_repay_30d
    ,cnt_stg_amt_ever_overdue_rte_30d
    ,cnt_stg_max_tim_rep_mdt_30d
    ,cnt_amt_overdue_500_cnt_30d
    ,cnt_amt_overdue_2000_cnt_30d

    -- 近期与固定时间
    ,cnt_stg_cnt_30d / cnt_stg_cnt_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_rte
,cnt_stg_cnt_advance_30d / cnt_stg_cnt_advance_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_30d / cnt_stg_cnt_ever_overdue_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_30d / cnt_stg_cnt_cur_overdue_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_30d / cnt_stg_cnt_ever_overdue_rte_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_30d / cnt_stg_cnt_undue_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_30d / cnt_stg_ever_max_overdue_days_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_30d / cnt_stg_ever_avg_overdue_days_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_30d / cnt_ever_overdue_days_3_cnt_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_30d / cnt_ever_overdue_days_30_cnt_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_30d / cnt_ever_overdue_days_15_cnt_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_30d / cnt_stg_amt_advance_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_30d / cnt_stg_amt_ever_overdue_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_30d / cnt_stg_amt_cur_overdue_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_30d / cnt_stg_amt_fur_repay_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_30d / cnt_stg_amt_ever_overdue_rte_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_30d / cnt_stg_max_tim_rep_mdt_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_30d / cnt_amt_overdue_500_cnt_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_30d / cnt_amt_overdue_2000_cnt_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_amt_overdue_2000_cnt_rte
,cnt_stg_cnt_60d / cnt_stg_cnt_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_rte
,cnt_stg_cnt_advance_60d / cnt_stg_cnt_advance_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_60d / cnt_stg_cnt_ever_overdue_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_60d / cnt_stg_cnt_cur_overdue_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_60d / cnt_stg_cnt_ever_overdue_rte_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_60d / cnt_stg_cnt_undue_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_60d / cnt_stg_ever_max_overdue_days_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_60d / cnt_stg_ever_avg_overdue_days_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_60d / cnt_ever_overdue_days_3_cnt_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_60d / cnt_ever_overdue_days_30_cnt_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_60d / cnt_ever_overdue_days_15_cnt_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_60d / cnt_stg_amt_advance_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_60d / cnt_stg_amt_ever_overdue_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_60d / cnt_stg_amt_cur_overdue_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_60d / cnt_stg_amt_fur_repay_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_60d / cnt_stg_amt_ever_overdue_rte_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_60d / cnt_stg_max_tim_rep_mdt_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_60d / cnt_amt_overdue_500_cnt_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_60d / cnt_amt_overdue_2000_cnt_60d_120d as mdt_last_60d_mdt_lst_60d_120d_settim_amt_overdue_2000_cnt_rte
,cnt_stg_cnt_60d / cnt_stg_cnt_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_rte
,cnt_stg_cnt_advance_60d / cnt_stg_cnt_advance_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_60d / cnt_stg_cnt_ever_overdue_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_60d / cnt_stg_cnt_cur_overdue_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_60d / cnt_stg_cnt_ever_overdue_rte_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_60d / cnt_stg_cnt_undue_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_60d / cnt_stg_ever_max_overdue_days_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_60d / cnt_stg_ever_avg_overdue_days_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_60d / cnt_ever_overdue_days_3_cnt_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_60d / cnt_ever_overdue_days_30_cnt_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_60d / cnt_ever_overdue_days_15_cnt_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_60d / cnt_stg_amt_advance_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_60d / cnt_stg_amt_ever_overdue_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_60d / cnt_stg_amt_cur_overdue_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_60d / cnt_stg_amt_fur_repay_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_60d / cnt_stg_amt_ever_overdue_rte_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_60d / cnt_stg_max_tim_rep_mdt_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_60d / cnt_amt_overdue_500_cnt_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_60d / cnt_amt_overdue_2000_cnt_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_amt_overdue_2000_cnt_rte
,cnt_stg_cnt_90d / cnt_stg_cnt_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_rte
,cnt_stg_cnt_advance_90d / cnt_stg_cnt_advance_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_advance_rte
,cnt_stg_cnt_ever_overdue_90d / cnt_stg_cnt_ever_overdue_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_ever_overdue_rte
,cnt_stg_cnt_cur_overdue_90d / cnt_stg_cnt_cur_overdue_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_cur_overdue_rte
,cnt_stg_cnt_ever_overdue_rte_90d / cnt_stg_cnt_ever_overdue_rte_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_ever_overdue_rte_rte
,cnt_stg_cnt_undue_90d / cnt_stg_cnt_undue_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_undue_rte
,cnt_stg_ever_max_overdue_days_90d / cnt_stg_ever_max_overdue_days_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_ever_max_overdue_days_rte
,cnt_stg_ever_avg_overdue_days_90d / cnt_stg_ever_avg_overdue_days_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_ever_avg_overdue_days_rte
,cnt_ever_overdue_days_3_cnt_90d / cnt_ever_overdue_days_3_cnt_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ever_overdue_days_3_cnt_rte
,cnt_ever_overdue_days_30_cnt_90d / cnt_ever_overdue_days_30_cnt_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ever_overdue_days_30_cnt_rte
,cnt_ever_overdue_days_15_cnt_90d / cnt_ever_overdue_days_15_cnt_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_ever_overdue_days_15_cnt_rte
,cnt_stg_amt_advance_90d / cnt_stg_amt_advance_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_advance_rte
,cnt_stg_amt_ever_overdue_90d / cnt_stg_amt_ever_overdue_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_ever_overdue_rte
,cnt_stg_amt_cur_overdue_90d / cnt_stg_amt_cur_overdue_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_cur_overdue_rte
,cnt_stg_amt_fur_repay_90d / cnt_stg_amt_fur_repay_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_fur_repay_rte
,cnt_stg_amt_ever_overdue_rte_90d / cnt_stg_amt_ever_overdue_rte_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_ever_overdue_rte_rte
,cnt_stg_max_tim_rep_mdt_90d / cnt_stg_max_tim_rep_mdt_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_stg_max_tim_rep_mdt_rte
,cnt_amt_overdue_500_cnt_90d / cnt_amt_overdue_500_cnt_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_amt_overdue_500_cnt_rte
,cnt_amt_overdue_2000_cnt_90d / cnt_amt_overdue_2000_cnt_90d_180d as mdt_last_90d_mdt_lst_90d_180d_settim_amt_overdue_2000_cnt_rte

    -- %%% 取部分直取字段

    ,cnt_stg_cnt_30d_60d
    ,cnt_stg_cnt_advance_30d_60d
    ,cnt_stg_cnt_ever_overdue_30d_60d
    ,cnt_stg_cnt_cur_overdue_30d_60d
    ,cnt_stg_cnt_ever_overdue_rte_30d_60d
    ,cnt_stg_cnt_undue_30d_60d
    ,cnt_stg_ever_max_overdue_days_30d_60d
    ,cnt_stg_ever_avg_overdue_days_30d_60d
    ,cnt_ever_overdue_days_3_cnt_30d_60d
    ,cnt_ever_overdue_days_30_cnt_30d_60d
    ,cnt_ever_overdue_days_15_cnt_30d_60d
    ,cnt_stg_amt_advance_30d_60d
    ,cnt_stg_amt_ever_overdue_30d_60d
    ,cnt_stg_amt_cur_overdue_30d_60d
    ,cnt_stg_amt_fur_repay_30d_60d
    ,cnt_stg_amt_ever_overdue_rte_30d_60d
    ,cnt_stg_max_tim_rep_mdt_30d_60d
    ,cnt_amt_overdue_500_cnt_30d_60d
    ,cnt_amt_overdue_2000_cnt_30d_60d
    ,cnt_stg_cnt_30d_90d
    ,cnt_stg_cnt_advance_30d_90d
    ,cnt_stg_cnt_ever_overdue_30d_90d
    ,cnt_stg_amt_cur_overdue_30d_90d
    ,cnt_stg_cnt_ever_overdue_rte_30d_90d
    ,cnt_stg_cnt_undue_30d_90d
    ,cnt_stg_ever_max_overdue_days_30d_90d
    ,cnt_stg_ever_avg_overdue_days_30d_90d
    ,cnt_ever_overdue_days_3_cnt_30d_90d
    ,cnt_ever_overdue_days_30_cnt_30d_90d
    ,cnt_ever_overdue_days_15_cnt_30d_90d
    ,cnt_stg_amt_advance_30d_90d
    ,cnt_stg_amt_ever_overdue_30d_90d
    ,cnt_stg_amt_fur_repay_30d_90d
    ,cnt_stg_amt_ever_overdue_rte_30d_90d
    ,cnt_stg_max_tim_rep_mdt_30d_90d
    ,cnt_amt_overdue_500_cnt_30d_90d
    ,cnt_amt_overdue_2000_cnt_30d_90d
    -- features range end --
from 
    (select 
         uid
        -- 前n天
        -- features range start --
        ,count(case when diff_model_dt_stg_dte between 1 and 30 then 1 else null end) as cnt_stg_cnt_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_30d -- count(null) 结果是 0
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 1 and 30 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_30d
,max(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_30d
,avg(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_30d
,sum(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 1 and 30 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_30d
,count(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_30d
,max(case when diff_model_dt_stg_dte between 1 and 30 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_30d
,count(case when diff_model_dt_stg_dte between 1 and 60 then 1 else null end) as cnt_stg_cnt_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 1 and 60 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_60d
,max(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_60d
,avg(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_60d
,sum(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 1 and 60 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_60d
,count(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_60d
,max(case when diff_model_dt_stg_dte between 1 and 60 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_60d
,count(case when diff_model_dt_stg_dte between 1 and 90 then 1 else null end) as cnt_stg_cnt_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 1 and 90 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_90d
,max(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_90d
,avg(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_90d
,sum(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 1 and 90 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_90d
,count(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_90d
,max(case when diff_model_dt_stg_dte between 1 and 90 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_90d
,count(case when diff_model_dt_stg_dte between 1 and 180 then 1 else null end) as cnt_stg_cnt_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 1 and 180 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_180d
,max(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_180d
,avg(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_180d
,sum(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 1 and 180 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_180d
,count(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_180d
,max(case when diff_model_dt_stg_dte between 1 and 180 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_180d



        ,count(case when diff_model_dt_stg_dte between 30 and 60 then 1 else null end) as cnt_stg_cnt_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 30 and 60 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_30d_60d
,max(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_30d_60d
,avg(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_30d_60d
,sum(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 30 and 60 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_30d_60d
,max(case when diff_model_dt_stg_dte between 30 and 60 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_30d_60d
,count(case when diff_model_dt_stg_dte between 30 and 90 then 1 else null end) as cnt_stg_cnt_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 30 and 90 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_30d_90d
,max(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_30d_90d
,avg(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_30d_90d
,sum(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 30 and 90 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_30d_90d
,count(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_30d_90d
,max(case when diff_model_dt_stg_dte between 30 and 90 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_30d_90d
,count(case when diff_model_dt_stg_dte between 60 and 120 then 1 else null end) as cnt_stg_cnt_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 60 and 120 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_60d_120d
,max(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_60d_120d
,avg(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_60d_120d
,sum(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 60 and 120 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_60d_120d
,max(case when diff_model_dt_stg_dte between 60 and 120 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_60d_120d
,count(case when diff_model_dt_stg_dte between 60 and 180 then 1 else null end) as cnt_stg_cnt_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 60 and 180 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_60d_180d
,max(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_60d_180d
,avg(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_60d_180d
,sum(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 60 and 180 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_60d_180d
,count(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_60d_180d
,max(case when diff_model_dt_stg_dte between 60 and 180 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_60d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 then 1 else null end) as cnt_stg_cnt_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf = '提前还款' then 1 else null end) as cnt_stg_cnt_advance_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) as cnt_stg_cnt_ever_overdue_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期未还') then 1 else null end) as cnt_stg_cnt_cur_overdue_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('未到还款时间') then 1 else null end) as cnt_stg_cnt_undue_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then 1 else null end) / count(case when diff_model_dt_stg_dte between 90 and 180 then 1 else null end) as cnt_stg_cnt_ever_overdue_rte_90d_180d
,max(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_max_overdue_days_90d_180d
,avg(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then stg_ovd_days else null end) as cnt_stg_ever_avg_overdue_days_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 3 then stg_ovd_days else null end) as cnt_ever_overdue_days_3_cnt_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 30 then stg_ovd_days else null end) as cnt_ever_overdue_days_30_cnt_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and stg_ovd_days > 15 then stg_ovd_days else null end) as cnt_ever_overdue_days_15_cnt_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf = '提前还款' then prc_amt else null end) as cnt_stg_amt_advance_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) as cnt_stg_amt_ever_overdue_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期未还') then prc_amt else null end) as cnt_stg_amt_cur_overdue_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('未到还款时间') then prc_amt else null end) as cnt_stg_amt_fur_repay_90d_180d
,sum(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') then prc_amt else null end) / sum(case when diff_model_dt_stg_dte between 90 and 180 then prc_amt else null end) as cnt_stg_amt_ever_overdue_rte_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 500 then 1 else null end) as cnt_amt_overdue_500_cnt_90d_180d
,count(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('逾期还款','逾期未还') and prc_amt > 2000 then 1 else null end) as cnt_amt_overdue_2000_cnt_90d_180d
,max(case when diff_model_dt_stg_dte between 90 and 180 and stg_stt_slf in ('未到还款时间') then diff_model_dt_stg_dte else null end) as cnt_stg_max_tim_rep_mdt_90d_180d
-- features range end --


        -- %%% 计算订单纬度和逾期交叉 

    from ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp3 group by uid
    ) t ;

-- %%% 归到订单纬度 

drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp4;
create table ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp4 as 

select uid, 
    ord_no,
    max(mdl_dte) as mdl_dte,
    max(crt_tim) as crt_tim,   -- 订单时间
    max(diff_model_dt_ord) as diff_model_dt_ord,
    max(case when stg_stt_slf in ('提前还款') then 1 else 0 end ) as ord_if_advance,
    max(case when stg_stt_slf in ('当天还款') then 1 else 0 end ) as ord_if_cur_pay,
    max(case when stg_stt_slf in ('逾期还款') then 1 else 0 end ) as ord_if_ovedue_pay,
    max(case when stg_stt_slf in ('逾期还款','逾期未还') then 1 else 0 end ) as ord_if_ever_ovedue_pay,
    max(case when stg_stt_slf in ('逾期未还') then 1 else 0 end ) as ord_if_ovedue_nopay,
    max(case when stg_stt_slf in ('未到还款时间') then 1 else 0 end ) as ord_if_undue

from ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp3 where date(mdl_dte) > date(crt_tim) and date(mdl_dte) > date(rep_dte)
group by uid,ord_no -- 归到订单纬度  %%% key_id 和 ord_no 双 订单号，只用key_id 即可
;

-- %%% 
drop table if exists ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp6;
create table ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp6 as 
select 
    uid
    -- 近期与远期
    -- features range start --
    ,cnt_ord_cnt_ever_overdue_rte_30d
    ,cnt_ord_cnt_advance_30d
    ,cnt_ord_cnt_ever_overdue_30d
    ,cnt_ord_cnt_cur_overdeu_30d
    ,cnt_ord_cnt_ever_overdue_rte_30d_60d
    ,cnt_ord_cnt_ever_overdue_rte_30d_90d


    ,cnt_ord_cnt_advance_30d / cnt_ord_cnt_advance_60d as mdt_lst_30d_60d_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_30d / cnt_ord_cnt_ever_overdue_60d as mdt_lst_30d_60d_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_30d / cnt_ord_cnt_cur_overdeu_60d as mdt_lst_30d_60d_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_30d / cnt_ord_cnt_ever_overdue_rte_60d as mdt_lst_30d_60d_ord_cnt_ever_overdue_rte_rte
    ,cnt_ord_cnt_advance_30d / cnt_ord_cnt_advance_90d as mdt_lst_30d_90d_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_30d / cnt_ord_cnt_ever_overdue_90d as mdt_lst_30d_90d_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_30d / cnt_ord_cnt_cur_overdeu_90d as mdt_lst_30d_90d_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_30d / cnt_ord_cnt_ever_overdue_rte_90d as mdt_lst_30d_90d_ord_cnt_ever_overdue_rte_rte
    ,cnt_ord_cnt_advance_60d / cnt_ord_cnt_advance_90d as mdt_lst_60d_90d_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_60d / cnt_ord_cnt_ever_overdue_90d as mdt_lst_60d_90d_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_60d / cnt_ord_cnt_cur_overdeu_90d as mdt_lst_60d_90d_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_60d / cnt_ord_cnt_ever_overdue_rte_90d as mdt_lst_60d_90d_ord_cnt_ever_overdue_rte_rte
    ,cnt_ord_cnt_advance_60d / cnt_ord_cnt_advance_180d as mdt_lst_60d_180d_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_60d / cnt_ord_cnt_ever_overdue_180d as mdt_lst_60d_180d_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_60d / cnt_ord_cnt_cur_overdeu_180d as mdt_lst_60d_180d_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_60d / cnt_ord_cnt_ever_overdue_rte_180d as mdt_lst_60d_180d_ord_cnt_ever_overdue_rte_rte
    ,cnt_ord_cnt_advance_30d / cnt_ord_cnt_advance_30d_60d as mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_30d / cnt_ord_cnt_ever_overdue_30d_60d as mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_30d / cnt_ord_cnt_cur_overdeu_30d_60d as mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_30d / cnt_ord_cnt_ever_overdue_rte_30d_60d as mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_ever_overdue_rte_rte
    ,cnt_ord_cnt_advance_30d / cnt_ord_cnt_advance_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_30d / cnt_ord_cnt_ever_overdue_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_30d / cnt_ord_cnt_cur_overdeu_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_30d / cnt_ord_cnt_ever_overdue_rte_30d_90d as mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_ever_overdue_rte_rte
    ,cnt_ord_cnt_advance_60d / cnt_ord_cnt_advance_60d_90d as mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_60d / cnt_ord_cnt_ever_overdue_60d_90d as mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_60d / cnt_ord_cnt_cur_overdeu_60d_90d as mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_60d / cnt_ord_cnt_ever_overdue_rte_60d_90d as mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_ever_overdue_rte_rte
    ,cnt_ord_cnt_advance_60d / cnt_ord_cnt_advance_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_advance_rte
    ,cnt_ord_cnt_ever_overdue_60d / cnt_ord_cnt_ever_overdue_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_ever_overdue_rte
    ,cnt_ord_cnt_cur_overdeu_60d / cnt_ord_cnt_cur_overdeu_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_cur_overdeu_rte
    ,cnt_ord_cnt_ever_overdue_rte_60d / cnt_ord_cnt_ever_overdue_rte_60d_180d as mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_ever_overdue_rte_rte
    -- features range end --
from 
(
    select 
    uid
    -- features range start --
    ,sum(case when  diff_model_dt_ord between 1 and 30 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 1 and 30 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_30d
    ,sum(case when  diff_model_dt_ord between 1 and 30 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_30d
    ,sum(case when  diff_model_dt_ord between 1 and 30 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_30d
    ,sum(case when  diff_model_dt_ord between 1 and 30 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_30d
    ,sum(case when  diff_model_dt_ord between 1 and 60 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 1 and 60 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_60d
    ,sum(case when  diff_model_dt_ord between 1 and 60 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_60d
    ,sum(case when  diff_model_dt_ord between 1 and 60 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_60d
    ,sum(case when  diff_model_dt_ord between 1 and 60 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_60d
    ,sum(case when  diff_model_dt_ord between 1 and 90 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 1 and 90 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_90d
    ,sum(case when  diff_model_dt_ord between 1 and 90 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_90d
    ,sum(case when  diff_model_dt_ord between 1 and 90 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_90d
    ,sum(case when  diff_model_dt_ord between 1 and 90 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_90d
    ,sum(case when  diff_model_dt_ord between 1 and 180 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 1 and 180 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_180d
    ,sum(case when  diff_model_dt_ord between 1 and 180 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_180d
    ,sum(case when  diff_model_dt_ord between 1 and 180 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_180d
    ,sum(case when  diff_model_dt_ord between 1 and 180 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_180d
    ,sum(case when  diff_model_dt_ord between 30 and 60 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 30 and 60 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_30d_60d
    ,sum(case when  diff_model_dt_ord between 30 and 60 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_30d_60d
    ,sum(case when  diff_model_dt_ord between 30 and 60 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_30d_60d
    ,sum(case when  diff_model_dt_ord between 30 and 60 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_30d_60d
    ,sum(case when  diff_model_dt_ord between 30 and 90 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 30 and 90 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_30d_90d
    ,sum(case when  diff_model_dt_ord between 30 and 90 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_30d_90d
    ,sum(case when  diff_model_dt_ord between 30 and 90 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_30d_90d
    ,sum(case when  diff_model_dt_ord between 30 and 90 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_30d_90d
    ,sum(case when  diff_model_dt_ord between 60 and 90 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 60 and 90 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_60d_90d
    ,sum(case when  diff_model_dt_ord between 60 and 90 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_60d_90d
    ,sum(case when  diff_model_dt_ord between 60 and 90 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_60d_90d
    ,sum(case when  diff_model_dt_ord between 60 and 90 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_60d_90d
    ,sum(case when  diff_model_dt_ord between 60 and 180 then ord_if_ever_ovedue_pay else 0 end) / sum(case when  diff_model_dt_ord between 60 and 180 then 1 else 0 end) as cnt_ord_cnt_ever_overdue_rte_60d_180d
    ,sum(case when  diff_model_dt_ord between 60 and 180 then ord_if_advance else 0 end) as cnt_ord_cnt_advance_60d_180d
    ,sum(case when  diff_model_dt_ord between 60 and 180 then ord_if_ever_ovedue_pay else 0 end) as cnt_ord_cnt_ever_overdue_60d_180d
    ,sum(case when  diff_model_dt_ord between 60 and 180 then ord_if_ovedue_nopay else 0 end) as cnt_ord_cnt_cur_overdeu_60d_180d
    -- features range end --
from ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp4 group by uid
) t ;



-- 合并 订单纬度和分期纬度变量 


insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_df partition (ds = '${bizdate}') 
select 
    model_data.uid
    ,model_data.mdl_dte
    -- features range start --
    ,mdt_lst_30d_60d_stg_cnt_rte
    ,mdt_lst_30d_60d_stg_cnt_advance_rte
    ,mdt_lst_30d_60d_stg_cnt_ever_overdue_rte
    ,mdt_lst_30d_60d_stg_cnt_cur_overdue_rte
    ,mdt_lst_30d_60d_stg_cnt_ever_overdue_rte_rte
    ,mdt_lst_30d_60d_stg_cnt_undue_rte
    ,mdt_lst_30d_60d_stg_ever_max_overdue_days_rte
    ,mdt_lst_30d_60d_stg_ever_avg_overdue_days_rte
    ,mdt_lst_30d_60d_ever_overdue_days_3_cnt_rte
    ,mdt_lst_30d_60d_ever_overdue_days_30_cnt_rte
    ,mdt_lst_30d_60d_ever_overdue_days_15_cnt_rte
    ,mdt_lst_30d_60d_stg_amt_advance_rte
    ,mdt_lst_30d_60d_stg_amt_ever_overdue_rte
    ,mdt_lst_30d_60d_stg_amt_cur_overdue_rte
    ,mdt_lst_30d_60d_stg_amt_fur_repay_rte
    ,mdt_lst_30d_60d_stg_amt_ever_overdue_rte_rte
    ,mdt_lst_30d_60d_stg_max_tim_rep_mdt_rte
    ,mdt_lst_30d_60d_amt_overdue_500_cnt_rte
    ,mdt_lst_30d_60d_amt_overdue_2000_cnt_rte
    ,mdt_lst_30d_90d_stg_cnt_rte
    ,mdt_lst_30d_90d_stg_cnt_advance_rte
    ,mdt_lst_30d_90d_stg_cnt_ever_overdue_rte
    ,mdt_lst_30d_90d_stg_cnt_cur_overdue_rte
    ,mdt_lst_30d_90d_stg_cnt_ever_overdue_rte_rte
    ,mdt_lst_30d_90d_stg_cnt_undue_rte
    ,mdt_lst_30d_90d_stg_ever_max_overdue_days_rte
    ,mdt_lst_30d_90d_stg_ever_avg_overdue_days_rte
    ,mdt_lst_30d_90d_ever_overdue_days_3_cnt_rte
    ,mdt_lst_30d_90d_ever_overdue_days_30_cnt_rte
    ,mdt_lst_30d_90d_ever_overdue_days_15_cnt_rte
    ,mdt_lst_30d_90d_stg_amt_advance_rte
    ,mdt_lst_30d_90d_stg_amt_ever_overdue_rte
    ,mdt_lst_30d_90d_stg_amt_cur_overdue_rte
    ,mdt_lst_30d_90d_stg_amt_fur_repay_rte
    ,mdt_lst_30d_90d_stg_amt_ever_overdue_rte_rte
    ,mdt_lst_30d_90d_stg_max_tim_rep_mdt_rte
    ,mdt_lst_30d_90d_amt_overdue_500_cnt_rte
    ,mdt_lst_30d_90d_amt_overdue_2000_cnt_rte
    ,mdt_lst_60d_90d_stg_cnt_rte
    ,mdt_lst_60d_90d_stg_cnt_advance_rte
    ,mdt_lst_60d_90d_stg_cnt_ever_overdue_rte
    ,mdt_lst_60d_90d_stg_cnt_cur_overdue_rte
    ,mdt_lst_60d_90d_stg_cnt_ever_overdue_rte_rte
    ,mdt_lst_60d_90d_stg_cnt_undue_rte
    ,mdt_lst_60d_90d_stg_ever_max_overdue_days_rte
    ,mdt_lst_60d_90d_stg_ever_avg_overdue_days_rte
    ,mdt_lst_60d_90d_ever_overdue_days_3_cnt_rte
    ,mdt_lst_60d_90d_ever_overdue_days_30_cnt_rte
    ,mdt_lst_60d_90d_ever_overdue_days_15_cnt_rte
    ,mdt_lst_60d_90d_stg_amt_advance_rte
    ,mdt_lst_60d_90d_stg_amt_ever_overdue_rte
    ,mdt_lst_60d_90d_stg_amt_cur_overdue_rte
    ,mdt_lst_60d_90d_stg_amt_fur_repay_rte
    ,mdt_lst_60d_90d_stg_amt_ever_overdue_rte_rte
    ,mdt_lst_60d_90d_stg_max_tim_rep_mdt_rte
    ,mdt_lst_60d_90d_amt_overdue_500_cnt_rte
    ,mdt_lst_60d_90d_amt_overdue_2000_cnt_rte
    ,mdt_lst_60d_180d_stg_cnt_rte
    ,mdt_lst_60d_180d_stg_cnt_advance_rte
    ,mdt_lst_60d_180d_stg_cnt_ever_overdue_rte
    ,mdt_lst_60d_180d_stg_cnt_cur_overdue_rte
    ,mdt_lst_60d_180d_stg_cnt_ever_overdue_rte_rte
    ,mdt_lst_60d_180d_stg_cnt_undue_rte
    ,mdt_lst_60d_180d_stg_ever_max_overdue_days_rte
    ,mdt_lst_60d_180d_stg_ever_avg_overdue_days_rte
    ,mdt_lst_60d_180d_ever_overdue_days_3_cnt_rte
    ,mdt_lst_60d_180d_ever_overdue_days_30_cnt_rte
    ,mdt_lst_60d_180d_ever_overdue_days_15_cnt_rte
    ,mdt_lst_60d_180d_stg_amt_advance_rte
    ,mdt_lst_60d_180d_stg_amt_ever_overdue_rte
    ,mdt_lst_60d_180d_stg_amt_cur_overdue_rte
    ,mdt_lst_60d_180d_stg_amt_fur_repay_rte
    ,mdt_lst_60d_180d_stg_amt_ever_overdue_rte_rte
    ,mdt_lst_60d_180d_stg_max_tim_rep_mdt_rte
    ,mdt_lst_60d_180d_amt_overdue_500_cnt_rte
    ,mdt_lst_60d_180d_amt_overdue_2000_cnt_rte
    -- %%% 取部分中间变量
    ,cnt_stg_cnt_30d
    ,cnt_stg_cnt_advance_30d
    ,cnt_stg_cnt_ever_overdue_30d
    ,cnt_stg_cnt_cur_overdue_30d
    ,cnt_stg_cnt_ever_overdue_rte_30d
    ,cnt_stg_cnt_undue_30d
    ,cnt_stg_ever_max_overdue_days_30d
    ,cnt_stg_ever_avg_overdue_days_30d
    ,cnt_ever_overdue_days_3_cnt_30d
    ,cnt_ever_overdue_days_30_cnt_30d
    ,cnt_ever_overdue_days_15_cnt_30d
    ,cnt_stg_amt_advance_30d
    ,cnt_stg_amt_ever_overdue_30d
    ,cnt_stg_amt_cur_overdue_30d
    ,cnt_stg_amt_fur_repay_30d
    ,cnt_stg_amt_ever_overdue_rte_30d
    ,cnt_stg_max_tim_rep_mdt_30d
    ,cnt_amt_overdue_500_cnt_30d
    ,cnt_amt_overdue_2000_cnt_30d

    -- 近期与固定时间
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_advance_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_ever_overdue_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_cur_overdue_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_ever_overdue_rte_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_cnt_undue_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_ever_max_overdue_days_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_ever_avg_overdue_days_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_ever_overdue_days_3_cnt_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_ever_overdue_days_30_cnt_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_ever_overdue_days_15_cnt_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_advance_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_ever_overdue_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_cur_overdue_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_fur_repay_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_amt_ever_overdue_rte_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_stg_max_tim_rep_mdt_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_amt_overdue_500_cnt_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_amt_overdue_2000_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_advance_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_ever_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_cur_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_ever_overdue_rte_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_cnt_undue_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_ever_max_overdue_days_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_ever_avg_overdue_days_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_ever_overdue_days_3_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_ever_overdue_days_30_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_ever_overdue_days_15_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_advance_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_ever_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_cur_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_fur_repay_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_amt_ever_overdue_rte_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_stg_max_tim_rep_mdt_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_amt_overdue_500_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_120d_settim_amt_overdue_2000_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_advance_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_ever_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_cur_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_ever_overdue_rte_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_cnt_undue_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_ever_max_overdue_days_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_ever_avg_overdue_days_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_ever_overdue_days_3_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_ever_overdue_days_30_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_ever_overdue_days_15_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_advance_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_ever_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_cur_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_fur_repay_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_amt_ever_overdue_rte_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_stg_max_tim_rep_mdt_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_amt_overdue_500_cnt_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_amt_overdue_2000_cnt_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_advance_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_ever_overdue_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_cur_overdue_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_ever_overdue_rte_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_cnt_undue_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_ever_max_overdue_days_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_ever_avg_overdue_days_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_ever_overdue_days_3_cnt_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_ever_overdue_days_30_cnt_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_ever_overdue_days_15_cnt_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_advance_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_ever_overdue_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_cur_overdue_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_fur_repay_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_amt_ever_overdue_rte_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_stg_max_tim_rep_mdt_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_amt_overdue_500_cnt_rte
    ,mdt_last_90d_mdt_lst_90d_180d_settim_amt_overdue_2000_cnt_rte

    -- %%% 取部分直取字段

    ,cnt_stg_cnt_30d_60d
    ,cnt_stg_cnt_advance_30d_60d
    ,cnt_stg_cnt_ever_overdue_30d_60d
    ,cnt_stg_cnt_cur_overdue_30d_60d
    ,cnt_stg_cnt_ever_overdue_rte_30d_60d
    ,cnt_stg_cnt_undue_30d_60d
    ,cnt_stg_ever_max_overdue_days_30d_60d
    ,cnt_stg_ever_avg_overdue_days_30d_60d
    ,cnt_ever_overdue_days_3_cnt_30d_60d
    ,cnt_ever_overdue_days_30_cnt_30d_60d
    ,cnt_ever_overdue_days_15_cnt_30d_60d
    ,cnt_stg_amt_advance_30d_60d
    ,cnt_stg_amt_ever_overdue_30d_60d
    ,cnt_stg_amt_cur_overdue_30d_60d
    ,cnt_stg_amt_fur_repay_30d_60d
    ,cnt_stg_amt_ever_overdue_rte_30d_60d
    ,cnt_stg_max_tim_rep_mdt_30d_60d
    ,cnt_amt_overdue_500_cnt_30d_60d
    ,cnt_amt_overdue_2000_cnt_30d_60d
    ,cnt_stg_cnt_30d_90d
    ,cnt_stg_cnt_advance_30d_90d
    ,cnt_stg_cnt_ever_overdue_30d_90d
    ,cnt_stg_amt_cur_overdue_30d_90d
    ,cnt_stg_cnt_ever_overdue_rte_30d_90d
    ,cnt_stg_cnt_undue_30d_90d
    ,cnt_stg_ever_max_overdue_days_30d_90d
    ,cnt_stg_ever_avg_overdue_days_30d_90d
    ,cnt_ever_overdue_days_3_cnt_30d_90d
    ,cnt_ever_overdue_days_30_cnt_30d_90d
    ,cnt_ever_overdue_days_15_cnt_30d_90d
    ,cnt_stg_amt_advance_30d_90d
    ,cnt_stg_amt_ever_overdue_30d_90d

    ,cnt_stg_amt_fur_repay_30d_90d
    ,cnt_stg_amt_ever_overdue_rte_30d_90d
    ,cnt_stg_max_tim_rep_mdt_30d_90d
    ,cnt_amt_overdue_500_cnt_30d_90d
    ,cnt_amt_overdue_2000_cnt_30d_90d



    ,mdt_lst_30d_60d_ord_cnt_sum_rte
    ,mdt_lst_30d_60d_ord_cnt_suc_rte
    ,mdt_lst_30d_60d_ord_cnt_fal_rte
    ,mdt_lst_30d_60d_avg_ord_span_rte
    ,mdt_lst_30d_60d_max_ord_span_rte
    ,mdt_lst_30d_60d_min_ord_span_rte
    ,mdt_lst_30d_60d_ord_cnt_typ_all_rte
    ,mdt_lst_30d_60d_ord_cnt_typ_btch_rte
    ,mdt_lst_30d_60d_ord_cnt_typ_hugl_rte
    ,mdt_lst_30d_60d_ord_cnt_typ_enj_rte
    ,mdt_lst_30d_60d_ord_cnt_typ_btch_rte_rte
    ,mdt_lst_30d_60d_ord_cnt_typ_hugl_rte_rte
    ,mdt_lst_30d_90d_ord_cnt_sum_rte
    ,mdt_lst_30d_90d_ord_cnt_suc_rte
    ,mdt_lst_30d_90d_ord_cnt_fal_rte
    ,mdt_lst_30d_90d_avg_ord_span_rte
    ,mdt_lst_30d_90d_max_ord_span_rte
    ,mdt_lst_30d_90d_min_ord_span_rte
    ,mdt_lst_30d_90d_ord_cnt_typ_all_rte
    ,mdt_lst_30d_90d_ord_cnt_typ_btch_rte
    ,mdt_lst_30d_90d_ord_cnt_typ_hugl_rte
    ,mdt_lst_30d_90d_ord_cnt_typ_enj_rte
    ,mdt_lst_30d_90d_ord_cnt_typ_btch_rte_rte
    ,mdt_lst_30d_90d_ord_cnt_typ_hugl_rte_rte
    ,mdt_lst_60d_90d_ord_cnt_sum_rte
    ,mdt_lst_60d_90d_ord_cnt_suc_rte
    ,mdt_lst_60d_90d_ord_cnt_fal_rte
    ,mdt_lst_60d_90d_avg_ord_span_rte
    ,mdt_lst_60d_90d_max_ord_span_rte
    ,mdt_lst_60d_90d_min_ord_span_rte
    ,mdt_lst_60d_90d_ord_cnt_typ_all_rte
    ,mdt_lst_60d_90d_ord_cnt_typ_btch_rte
    ,mdt_lst_60d_90d_ord_cnt_typ_hugl_rte
    ,mdt_lst_60d_90d_ord_cnt_typ_enj_rte
    ,mdt_lst_60d_90d_ord_cnt_typ_btch_rte_rte
    ,mdt_lst_60d_90d_ord_cnt_typ_hugl_rte_rte
    ,mdt_lst_60d_180d_ord_cnt_sum_rte
    ,mdt_lst_60d_180d_ord_cnt_suc_rte
    ,mdt_lst_60d_180d_ord_cnt_fal_rte
    ,mdt_lst_60d_180d_avg_ord_span_rte
    ,mdt_lst_60d_180d_max_ord_span_rte
    ,mdt_lst_60d_180d_min_ord_span_rte
    ,mdt_lst_60d_180d_ord_cnt_typ_all_rte
    ,mdt_lst_60d_180d_ord_cnt_typ_btch_rte
    ,mdt_lst_60d_180d_ord_cnt_typ_hugl_rte
    ,mdt_lst_60d_180d_ord_cnt_typ_enj_rte
    ,mdt_lst_60d_180d_ord_cnt_typ_btch_rte_rte
    ,mdt_lst_60d_180d_ord_cnt_typ_hugl_rte_rte

    ,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_sum_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_suc_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_fal_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_avg_ord_span_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_max_ord_span_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_min_ord_span_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_all_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_btch_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_hugl_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_enj_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_btch_rte_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_hugl_rte_rte
,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_typ_enj_rte_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_sum_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_suc_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_fal_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_avg_ord_span_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_max_ord_span_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_min_ord_span_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_all_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_btch_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_hugl_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_enj_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_btch_rte_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_hugl_rte_rte
,mdt_last_60d_mdt_lst_60d_120d_settim_ord_cnt_typ_enj_rte_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_sum_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_suc_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_fal_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_avg_ord_span_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_max_ord_span_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_min_ord_span_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_all_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_btch_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_hugl_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_enj_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_btch_rte_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_hugl_rte_rte
,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_typ_enj_rte_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_sum_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_suc_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_fal_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_avg_ord_span_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_max_ord_span_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_min_ord_span_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_all_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_btch_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_hugl_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_enj_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_btch_rte_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_hugl_rte_rte
,mdt_last_90d_mdt_lst_90d_180d_settim_ord_cnt_typ_enj_rte_rte

    ,cnt_ord_cnt_sum_30d
    ,cnt_ord_cnt_suc_30d
    ,cnt_ord_cnt_fal_30d
    ,cnt_avg_ord_span_30d
    ,cnt_max_ord_span_30d
    ,cnt_min_ord_span_30d
    ,cnt_ord_cnt_typ_btch_30d
    ,cnt_ord_cnt_typ_hugl_30d
    ,cnt_ord_cnt_typ_enj_30d
    ,cnt_ord_cnt_typ_btch_rte_30d
    ,cnt_ord_cnt_typ_hugl_rte_30d
    
    ,cnt_ord_cnt_sum_30d_60d
    ,cnt_ord_cnt_suc_30d_60d
    ,cnt_ord_cnt_fal_30d_60d
    ,cnt_avg_ord_span_30d_60d
    ,cnt_max_ord_span_30d_60d
    ,cnt_min_ord_span_30d_60d
    ,cnt_ord_cnt_typ_all_30d_60d
    ,cnt_ord_cnt_typ_btch_30d_60d
    ,cnt_ord_cnt_typ_hugl_30d_60d
    ,cnt_ord_cnt_typ_enj_30d_60d
    ,cnt_ord_cnt_typ_btch_rte_30d_60d
    ,cnt_ord_cnt_typ_hugl_rte_30d_60d
    ,cnt_ord_cnt_sum_30d_90d
    ,cnt_ord_cnt_suc_30d_90d
    ,cnt_ord_cnt_fal_30d_90d
    ,cnt_avg_ord_span_30d_90d
    ,cnt_max_ord_span_30d_90d
    ,cnt_min_ord_span_30d_90d
    ,cnt_ord_cnt_typ_all_30d_90d
    ,cnt_ord_cnt_typ_btch_30d_90d
    ,cnt_ord_cnt_typ_hugl_30d_90d
    ,cnt_ord_cnt_typ_enj_30d_90d
    ,cnt_ord_cnt_typ_btch_rte_30d_90d
    ,cnt_ord_cnt_typ_hugl_rte_30d_90d


    -- %%% stage - order
    ,cnt_ord_cnt_ever_overdue_rte_30d
    ,cnt_ord_cnt_advance_30d
    ,cnt_ord_cnt_ever_overdue_30d
    ,cnt_ord_cnt_cur_overdeu_30d
    ,cnt_ord_cnt_ever_overdue_rte_30d_60d
    ,cnt_ord_cnt_ever_overdue_rte_30d_90d

    ,mdt_lst_30d_60d_ord_cnt_advance_rte
    ,mdt_lst_30d_60d_ord_cnt_ever_overdue_rte
    ,mdt_lst_30d_60d_ord_cnt_cur_overdeu_rte
    ,mdt_lst_30d_60d_ord_cnt_ever_overdue_rte_rte
    ,mdt_lst_30d_90d_ord_cnt_advance_rte
    ,mdt_lst_30d_90d_ord_cnt_ever_overdue_rte
    ,mdt_lst_30d_90d_ord_cnt_cur_overdeu_rte
    ,mdt_lst_30d_90d_ord_cnt_ever_overdue_rte_rte
    ,mdt_lst_60d_90d_ord_cnt_advance_rte
    ,mdt_lst_60d_90d_ord_cnt_ever_overdue_rte
    ,mdt_lst_60d_90d_ord_cnt_cur_overdeu_rte
    ,mdt_lst_60d_90d_ord_cnt_ever_overdue_rte_rte
    ,mdt_lst_60d_180d_ord_cnt_advance_rte
    ,mdt_lst_60d_180d_ord_cnt_ever_overdue_rte
    ,mdt_lst_60d_180d_ord_cnt_cur_overdeu_rte
    ,mdt_lst_60d_180d_ord_cnt_ever_overdue_rte_rte
    ,mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_advance_rte
    ,mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_ever_overdue_rte
    ,mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_cur_overdeu_rte
    ,mdt_last_30d_mdt_lst_30d_60d_settim_ord_cnt_ever_overdue_rte_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_advance_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_ever_overdue_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_cur_overdeu_rte
    ,mdt_last_30d_mdt_lst_30d_90d_settim_ord_cnt_ever_overdue_rte_rte
    ,mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_advance_rte
    ,mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_ever_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_cur_overdeu_rte
    ,mdt_last_60d_mdt_lst_60d_90d_settim_ord_cnt_ever_overdue_rte_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_advance_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_ever_overdue_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_cur_overdeu_rte
    ,mdt_last_60d_mdt_lst_60d_180d_settim_ord_cnt_ever_overdue_rte_rte
    -- features range end --

from ${dwa_risk}.dwa_risk_f_dz_model_data_base model_data
left join ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp5 stage 
on model_data.uid=stage.uid
left join ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_tmp2 order_info
on model_data.uid = order_info.uid
left join ${dwa_risk}.dwa_risk_dz_model_final_22order_calculate_stage_order_info_stage_tmp6 s_order
on model_data.uid = s_order.uid;
-- feature-copilot:node-end ordinal=0
