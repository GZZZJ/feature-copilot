-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_dz_model_final_26_lending_costs_detail_df
-- node_id: n_6005052574108418048
-- task_name: dwa_risk_dz_model_final_26_lending_costs_detail_df
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_dz_model_final_26_lending_costs_detail_df.json
-- source_json_sha256: 268b85206fc62a8d96e3607f77f3998346a0415b4d8e49694c6583284c56856b
-- upstream_table: dwa_risk.dwa_risk_f_dz_model_data_base
-- upstream_table: dwa_risk.dwa_risk_f_schedule_pay_details_fee_df
-- upstream_table: dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_adv_ovd_fee_tmp
-- upstream_table: dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_interest_guarantee_totamt_tmp
-- upstream_table: dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_atoms_table01

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 陈枭2648
--创建日期: 2024-07-01 15:31:42
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- 构建还款行为原子表
drop table if exists dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_atoms_table01;


create table if not exists dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_atoms_table01 as
select  main2.uid
       ,main2.mdl_dte
       ,main2.dtl_stg_pln_no -- 还款记录表的分期号码
       ,main2.dtl_rep_dte -- 应还款日
       ,main2.rep_tim -- 实际还款日
       ,schedule_pay_principal
       ,schedule_pay_interest
       ,schedule_pay_gurantee_amount
       ,schedule_pay_penalty
       ,schedule_pay_prerepayment_fee
       ,schedule_total_amount
       -- 排除本金外的所有费用
       ,schedule_total_amount - schedule_pay_principal as schedule_pay_exclude_principal_fee
       --应还日和实还日之间的间隔（天）：用于判断逾期、提前、按时还款
       ,main2.ddf_rep_tim_dte
       --实还日和评分日的间隔（天）：用于限定实还行为变量的窗口期
       ,main2.ddf_mdl_rep_tim
       --应还日和评分日的间隔（天）：用于限定应还行为变量的窗口期
       ,main2.ddf_mdl_rep_dte
       --还款状态--flag
       --是否提前还款flag
       ,case
          when ddf_mdl_rep_tim > 0
and     ddf_rep_tim_dte < 0         then '提前还款' -- 这样写的好处是即使评分日后的应还分期，如果在评分日前提前还了，也能计入
          when ddf_rep_tim_dte > 0  then '逾期还款'
          when ddf_mdl_rep_dte > 0
and     ddf_rep_tim_dte = 0         then '按时还款'
          when ddf_mdl_rep_dte <= 0 then '未来应还（评分日T日及往后）'
          else '其他分期状态'
        end repay_status_01 -- 主要用来区分提前还是逾期还款，用于衍生罚息、提前结清手续费这些特征
       ,case
          when rep_tim is null
and     ddf_mdl_rep_dte > 0        then '历史未还' -- 实际还没有还款，且应还日在评分日前
          when rep_tim is null
and     ddf_mdl_rep_dte <= 0       then '未来未还' -- 实际还没有还款，应还日在评分日及以后
          when rep_tim is not null then '所有已还' -- 包含了提前结清、逾期还款、按时还款，只要是还了都算
          else '其他分期状态'
        end repay_status_02 -- 用来区分未还、已还，用来衍生利息、担保费、违约金这些特征
from    (
            select  main1.uid
                   ,main1.mdl_dte
                   ,main1.dtl_stg_pln_no
                   ,main1.dtl_rep_dte
                   ,main1.rep_tim
                   ,schedule_pay_principal
                   ,schedule_pay_interest
                   ,schedule_pay_gurantee_amount
                   ,schedule_pay_penalty
                   ,schedule_pay_prerepayment_fee
                   ,schedule_total_amount
                   --应还日和实还日之间的间隔（天），for判断逾期、提前、按时还款
                   ,case
                      when rep_tim is null then datediff(mdl_dte , dtl_rep_dte)
                      else datediff(rep_tim , dtl_rep_dte)
                    end                             as ddf_rep_tim_dte
                   --实还日和评分日的间隔，for变量窗口期判断
                   ,datediff(mdl_dte , rep_tim)     as ddf_mdl_rep_tim
                   --应还日和评分日的间隔，for变量窗口期判断
                   ,datediff(mdl_dte , dtl_rep_dte) as ddf_mdl_rep_dte
            from    (
                        select  model_data.uid
                               ,model_data.mdl_dte
                               ,plan.dtl_stg_pln_no
                               ,plan.dtl_rep_dte
                               ,case
                                  when date(plan.rep_tim) >= model_data.mdl_dte then null
                                  else date(plan.rep_tim)
                                end as rep_tim
                               ,plan.schedule_pay_principal
                               ,plan.schedule_pay_interest
                               ,plan.schedule_pay_gurantee_amount
                               ,plan.schedule_pay_penalty
                               ,plan.schedule_pay_prerepayment_fee
                               ,plan.schedule_total_amount
                        from    (
                                    select  uid
                                           ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
                                    from    dwa_risk.dwa_risk_f_dz_model_data_base
                                ) model_data
                        left join (
                                      select  *
                                      from    dwa_risk.dwa_risk_f_schedule_pay_details_fee_df
                                      where   ds = '${bizdate}'
                                  ) plan
                        on      model_data.uid = plan.uid
                        and     model_data.mdl_dte = plan.mdl_dte
                    ) main1
        ) main2;


--衍生逾期还款的罚息、提前还款的结清手续费信息
drop table if exists dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_adv_ovd_fee_tmp;


create table if not exists dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_adv_ovd_fee_tmp as
select  uid
       ,mdl_dte
       ,max(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0 then schedule_pay_prerepayment_fee
              else null
            end)            as his_adv_repay_fee_max  -- 历史至今最大单笔提前还款手续费
       ,max(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_prerepayment_fee
              else null
            end)            as d90_adv_repay_fee_max  -- 近90天最大单笔提前还款手续费
       ,max(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_prerepayment_fee
              else null
            end)            as d180_adv_repay_fee_max  -- 近180天最大单笔提前还款手续费
       ,max(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_prerepayment_fee
              else null
            end)            as d360_adv_repay_fee_max  -- 近360天最大单笔提前还款手续费
       ,max(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_prerepayment_fee
              else null
            end)            as d720_adv_repay_fee_max  -- 近720天最大单笔提前还款手续费
       ,max(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_prerepayment_fee
              else null
            end)            as d1080_adv_repay_fee_max  -- 近1080天最大单笔提前还款手续费
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0 then schedule_pay_prerepayment_fee
              else null
            end)            as his_adv_repay_fee_sum  -- 历史至今累计提前还款手续费
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_prerepayment_fee
              else null
            end)            as d90_adv_repay_fee_sum  -- 近90天累计提前还款手续费
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_prerepayment_fee
              else null
            end)            as d180_adv_repay_fee_sum  -- 近180天累计提前还款手续费
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_prerepayment_fee
              else null
            end)            as d360_adv_repay_fee_sum  -- 近360天累计提前还款手续费
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_prerepayment_fee
              else null
            end)            as d720_adv_repay_fee_sum  -- 近720天累计提前还款手续费
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_prerepayment_fee
              else null
            end)            as d1080_adv_repay_fee_sum  -- 近1080天累计提前还款手续费
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0 then schedule_pay_prerepayment_fee
              else null
            end) / sum(case
                         when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0 then schedule_pay_principal
                         else null
                       end) as his_adv_repay_fee_sum_divide_his_principal_sum  -- 历史至今累计提前还款手续费总和/历史提前还款分期的本金总和
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_prerepayment_fee
              else null
            end) / sum(case
                         when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_principal
                         else null
                       end) as d90_adv_repay_fee_sum_divide_d90_principal_sum  -- 近90天累计提前还款手续费总和/近90天提前还款分期的本金总和
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_prerepayment_fee
              else null
            end) / sum(case
                         when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_principal
                         else null
                       end) as d180_adv_repay_fee_sum_divide_d180_principal_sum  -- 近180天累计提前还款手续费总和/近180天提前还款分期的本金总和
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_prerepayment_fee
              else null
            end) / sum(case
                         when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_principal
                         else null
                       end) as d360_adv_repay_fee_sum_divide_d360_principal_sum  -- 近360天累计提前还款手续费总和/近360天提前还款分期的本金总和
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_prerepayment_fee
              else null
            end) / sum(case
                         when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_principal
                         else null
                       end) as d720_adv_repay_fee_sum_divide_d720_principal_sum  -- 近720天累计提前还款手续费总和/近720天提前还款分期的本金总和
       ,sum(case
              when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_prerepayment_fee
              else null
            end) / sum(case
                         when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_principal
                         else null
                       end) as d1080_sum_adv_repay_fee_sum_divide_d1080_principal_sum  -- 近1080天累计提前还款手续费总和/近1080天提前还款分期的本金总和
       ,stddev_samp(case
                      when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0 then schedule_pay_prerepayment_fee
                      else null
                    end)    as his_stddev_adv_repay_fee  -- 历史至今每笔提前还款手续费_标准差
       ,stddev_samp(case
                      when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_prerepayment_fee
                      else null
                    end)    as d90_stddev_adv_repay_fee  -- 近90天每笔提前还款手续费_标准差
       ,stddev_samp(case
                      when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_prerepayment_fee
                      else null
                    end)    as d180_stddev_adv_repay_fee  -- 近180天每笔提前还款手续费_标准差
       ,stddev_samp(case
                      when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_prerepayment_fee
                      else null
                    end)    as d360_stddev_adv_repay_fee  -- 近360天每笔提前还款手续费_标准差
       ,stddev_samp(case
                      when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_prerepayment_fee
                      else null
                    end)    as d720_stddev_adv_repay_fee  -- 近720天每笔提前还款手续费_标准差
       ,stddev_samp(case
                      when repay_status_01 = '提前还款'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_prerepayment_fee
                      else null
                    end)    as d1080_stddev_adv_repay_fee  -- 近1080天每笔提前还款手续费_标准差
       ,max(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0 then schedule_pay_penalty
              else null
            end)            as his_schedule_pay_penalty_max  -- 历史至今最大单笔逾期还款罚息
       ,max(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_penalty
              else null
            end)            as d90_schedule_pay_penalty_max  -- 近90天最大单笔逾期还款罚息
       ,max(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_penalty
              else null
            end)            as d180_schedule_pay_penalty_max  -- 近180天最大单笔逾期还款罚息
       ,max(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_penalty
              else null
            end)            as d360_schedule_pay_penalty_max  -- 近360天最大单笔逾期还款罚息
       ,max(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_penalty
              else null
            end)            as d720_schedule_pay_penalty_max  -- 近720天最大单笔逾期还款罚息
       ,max(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_penalty
              else null
            end)            as d1080_schedule_pay_penalty_max  -- 近1080天最大单笔逾期还款罚息
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0 then schedule_pay_penalty
              else null
            end)            as his_schedule_pay_penalty_sum  -- 历史至今累计逾期还款罚息
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_penalty
              else null
            end)            as d90_schedule_pay_penalty_sum  -- 近90天累计逾期还款罚息
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_penalty
              else null
            end)            as d180_schedule_pay_penalty_sum  -- 近180天累计逾期还款罚息
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_penalty
              else null
            end)            as d360_schedule_pay_penalty_sum  -- 近360天累计逾期还款罚息
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_penalty
              else null
            end)            as d720_schedule_pay_penalty_sum  -- 近720天累计逾期还款罚息
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_penalty
              else null
            end)            as d1080_schedule_pay_penalty_sum  -- 近1080天累计逾期还款罚息
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0 then schedule_pay_penalty
              else null
            end) / sum(case
                         when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0 then schedule_pay_principal
                         else null
                       end) as his_schedule_pay_penalty_sum_divide_his_principal_sum  -- 历史至今累计逾期还款罚息总和/历史逾期还款分期的本金总和
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_penalty
              else null
            end) / sum(case
                         when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_principal
                         else null
                       end) as d90_schedule_pay_penalty_sum_divide_d90_principal_sum  -- 近90天累计逾期还款罚息总和/近90天逾期还款分期的本金总和
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_penalty
              else null
            end) / sum(case
                         when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_principal
                         else null
                       end) as d180_schedule_pay_penalty_sum_divide_d180_principal_sum  -- 近180天累计逾期还款罚息总和/近180天逾期还款分期的本金总和
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_penalty
              else null
            end) / sum(case
                         when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_principal
                         else null
                       end) as d360_schedule_pay_penalty_sum_divide_d360_principal_sum  -- 近360天累计逾期还款罚息总和/近360天逾期还款分期的本金总和
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_penalty
              else null
            end) / sum(case
                         when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_principal
                         else null
                       end) as d720_schedule_pay_penalty_sum_divide_d720_principal_sum  -- 近720天累计逾期还款罚息总和/近720天逾期还款分期的本金总和
       ,sum(case
              when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_penalty
              else null
            end) / sum(case
                         when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_principal
                         else null
                       end) as d1080_sum_schedule_pay_penalty_sum_divide_d1080_principal_sum  -- 近1080天累计逾期还款罚息总和/近1080天逾期还款分期的本金总和
       ,stddev_samp(case
                      when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0 then schedule_pay_penalty
                      else null
                    end)    as his_stddev_schedule_pay_penalty  -- 历史至今每笔逾期还款罚息_标准差
       ,stddev_samp(case
                      when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_penalty
                      else null
                    end)    as d90_stddev_schedule_pay_penalty  -- 近90天每笔逾期还款罚息_标准差
       ,stddev_samp(case
                      when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_penalty
                      else null
                    end)    as d180_stddev_schedule_pay_penalty  -- 近180天每笔逾期还款罚息_标准差
       ,stddev_samp(case
                      when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_penalty
                      else null
                    end)    as d360_stddev_schedule_pay_penalty  -- 近360天每笔逾期还款罚息_标准差
       ,stddev_samp(case
                      when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_penalty
                      else null
                    end)    as d720_stddev_schedule_pay_penalty  -- 近720天每笔逾期还款罚息_标准差
       ,stddev_samp(case
                      when repay_status_01 = '逾期还款'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_penalty
                      else null
                    end)    as d1080_stddev_schedule_pay_penalty -- 近1080天每笔逾期还款罚息_标准差
from    (
            select  *
            from    dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_atoms_table01
            where   repay_status_01 in ( '提前还款' , '逾期还款' )
        ) basic
group by uid
        ,mdl_dte;


-- 衍生利息、担保费、总应还金额信息
drop table if exists dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_interest_guarantee_totamt_tmp;


create table if not exists dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_interest_guarantee_totamt_tmp as
select  uid
       ,mdl_dte
       -- ************************************************************************************* --
       -- *************************************** 利息费 *************************************** --
       -- ************************************************************************************* --
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_interest
              else null
            end)            as his_repaid_interest_fee_max  -- 历史至今最大（所有已还分期）单笔利息费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_interest
              else null
            end)            as d90_repaid_interest_fee_max  -- 近90天最大（所有已还分期）单笔利息费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_interest
              else null
            end)            as d180_repaid_interest_fee_max  -- 近180天最大（所有已还分期）单笔利息费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_interest
              else null
            end)            as d360_repaid_interest_fee_max  -- 近360天最大（所有已还分期）单笔利息费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_interest
              else null
            end)            as d720_repaid_interest_fee_max  -- 近720天最大（所有已还分期）单笔利息费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_interest
              else null
            end)            as d1080_repaid_interest_fee_max  -- 近1080天最大（所有已还分期）单笔利息费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_interest
              else null
            end)            as his_repaid_interest_fee_sum  -- 历史至今累计（所有已还分期）利息费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_interest
              else null
            end)            as d90_repaid_interest_fee_sum  -- 近90天累计（所有已还分期）利息费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_interest
              else null
            end)            as d180_repaid_interest_fee_sum  -- 近180天累计（所有已还分期）利息费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_interest
              else null
            end)            as d360_repaid_interest_fee_sum  -- 近360天累计（所有已还分期）利息费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_interest
              else null
            end)            as d720_repaid_interest_fee_sum  -- 近720天累计（所有已还分期）利息费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_interest
              else null
            end)            as d1080_repaid_interest_fee_sum  -- 近1080天累计（所有已还分期）利息费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_principal
                         else null
                       end) as his_repaid_interest_fee_sum_divide_his_principal_sum  -- 历史至今累计（所有已还分期）利息费总和/历史（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_principal
                         else null
                       end) as d90_repaid_interest_fee_sum_divide_d90_principal_sum  -- 近90天累计（所有已还分期）利息费总和/近90天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_principal
                         else null
                       end) as d180_repaid_interest_fee_sum_divide_d180_principal_sum  -- 近180天累计（所有已还分期）利息费总和/近180天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_principal
                         else null
                       end) as d360_repaid_interest_fee_sum_divide_d360_principal_sum  -- 近360天累计（所有已还分期）利息费总和/近360天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_principal
                         else null
                       end) as d720_repaid_interest_fee_sum_divide_d720_principal_sum  -- 近720天累计（所有已还分期）利息费总和/近720天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_principal
                         else null
                       end) as d1080_sum_repaid_interest_fee_sum_divide_d1080_principal_sum  -- 近1080天累计（所有已还分期）利息费总和/近1080天（所有已还分期）的本金总和
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_interest
                      else null
                    end)    as his_repaid_interest_fee_stddev  -- 历史至今每笔（所有已还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_interest
                      else null
                    end)    as d90_repaid_interest_fee_stddev  -- 近90天每笔（所有已还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_interest
                      else null
                    end)    as d180_repaid_interest_fee_stddev  -- 近180天每笔（所有已还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_interest
                      else null
                    end)    as d360_repaid_interest_fee_stddev  -- 近360天每笔（所有已还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_interest
                      else null
                    end)    as d720_repaid_interest_fee_stddev  -- 近720天每笔（所有已还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_interest
                      else null
                    end)    as d1080_repaid_interest_fee_stddev  -- 近1080天每笔（所有已还分期）利息费_标准差
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_interest
              else null
            end)            as his_pending_repay_interest_fee_max  -- 历史至今最大（历史未还分期）单笔利息费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_interest
              else null
            end)            as d90_pending_repay_interest_fee_max  -- 近90天最大（历史未还分期）单笔利息费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_interest
              else null
            end)            as d180_pending_repay_interest_fee_max  -- 近180天最大（历史未还分期）单笔利息费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_interest
              else null
            end)            as d360_pending_repay_interest_fee_max  -- 近360天最大（历史未还分期）单笔利息费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_interest
              else null
            end)            as d720_pending_repay_interest_fee_max  -- 近720天最大（历史未还分期）单笔利息费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_interest
              else null
            end)            as d1080_pending_repay_interest_fee_max  -- 近1080天最大（历史未还分期）单笔利息费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_interest
              else null
            end)            as his_pending_repay_interest_fee_sum  -- 历史至今累计（历史未还分期）利息费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_interest
              else null
            end)            as d90_pending_repay_interest_fee_sum  -- 近90天累计（历史未还分期）利息费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_interest
              else null
            end)            as d180_pending_repay_interest_fee_sum  -- 近180天累计（历史未还分期）利息费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_interest
              else null
            end)            as d360_pending_repay_interest_fee_sum  -- 近360天累计（历史未还分期）利息费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_interest
              else null
            end)            as d720_pending_repay_interest_fee_sum  -- 近720天累计（历史未还分期）利息费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_interest
              else null
            end)            as d1080_pending_repay_interest_fee_sum  -- 近1080天累计（历史未还分期）利息费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_principal
                         else null
                       end) as his_pending_repay_interest_fee_sum_divide_his_principal_sum  -- 历史至今累计（历史未还分期）利息费总和/历史（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_principal
                         else null
                       end) as d90_pending_repay_interest_fee_sum_divide_d90_principal_sum  -- 近90天累计（历史未还分期）利息费总和/近90天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_principal
                         else null
                       end) as d180_pending_repay_interest_fee_sum_divide_d180_principal_sum  -- 近180天累计（历史未还分期）利息费总和/近180天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_principal
                         else null
                       end) as d360_pending_repay_interest_fee_sum_divide_d360_principal_sum  -- 近360天累计（历史未还分期）利息费总和/近360天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_principal
                         else null
                       end) as d720_pending_repay_interest_fee_sum_divide_d720_principal_sum  -- 近720天累计（历史未还分期）利息费总和/近720天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_principal
                         else null
                       end) as d1080_sum_pending_repay_interest_fee_sum_divide_d1080_principal_sum  -- 近1080天累计（历史未还分期）利息费总和/近1080天（历史未还分期）的本金总和
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_interest
                      else null
                    end)    as his_pending_repay_interest_fee_stddev  -- 历史至今每笔（历史未还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_interest
                      else null
                    end)    as d90_pending_repay_interest_fee_stddev  -- 近90天每笔（历史未还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_interest
                      else null
                    end)    as d180_pending_repay_interest_fee_stddev  -- 近180天每笔（历史未还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_interest
                      else null
                    end)    as d360_pending_repay_interest_fee_stddev  -- 近360天每笔（历史未还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_interest
                      else null
                    end)    as d720_pending_repay_interest_fee_stddev  -- 近720天每笔（历史未还分期）利息费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_interest
                      else null
                    end)    as d1080_pending_repay_interest_fee_stddev  -- 近1080天每笔（历史未还分期）利息费_标准差
       ,max(case
              when repay_status_02 = '未来未还' then schedule_pay_interest
              else null
            end)            as ftr_pending_repay_interest_fee_max  -- 未来最大（未来未还分期）单笔利息费
       ,sum(case
              when repay_status_02 = '未来未还' then schedule_pay_interest
              else null
            end)            as ftr_pending_repay_interest_fee_sum  -- 未来累计（未来未还分期）利息费
       ,sum(case
              when repay_status_02 = '未来未还' then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 = '未来未还' then schedule_pay_principal
                         else null
                       end) as ftr_pending_repay_interest_fee_sum_divide_ftr_principal_sum  -- 未来累计（未来未还分期）利息费总和/未来未还分期本金总和
       ,stddev_samp(case
                      when repay_status_02 = '未来未还' then schedule_pay_interest
                      else null
                    end)    as ftr_pending_repay_interest_fee_stddev  -- 未来每笔（未来未还分期）利息费_标准差
       ,max(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_interest
              else null
            end)            as tot_pending_repay_interest_fee_max  -- 历史+未来未还分期单笔利息费_最大值
       ,sum(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_interest
              else null
            end)            as tot_pending_repay_interest_fee_sum  -- 历史+未来未还分期利息费_累计值
       ,sum(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_interest
              else null
            end) / sum(case
                         when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_principal
                         else null
                       end) as tot_pending_repay_interest_fee_sum_divide_ftr_principal_sum  -- 历史+未来未还分期利息费总和/历史+未来未还分期本金总和
       ,stddev_samp(case
                      when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_interest
                      else null
                    end)    as tot_pending_repay_interest_fee_stddev  -- 历史+未来未还分期利息费_标准差
       -- ************************************************************************************* --
       -- *************************************** 担保费 *************************************** --
       -- ************************************************************************************* --
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_gurantee_amount
              else null
            end)            as his_repaid_gurantee_fee_max  -- 历史至今最大（所有已还分期）单笔担保费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_gurantee_amount
              else null
            end)            as d90_repaid_gurantee_fee_max  -- 近90天最大（所有已还分期）单笔担保费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_gurantee_amount
              else null
            end)            as d180_repaid_gurantee_fee_max  -- 近180天最大（所有已还分期）单笔担保费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_gurantee_amount
              else null
            end)            as d360_repaid_gurantee_fee_max  -- 近360天最大（所有已还分期）单笔担保费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_gurantee_amount
              else null
            end)            as d720_repaid_gurantee_fee_max  -- 近720天最大（所有已还分期）单笔担保费
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_gurantee_amount
              else null
            end)            as d1080_repaid_gurantee_fee_max  -- 近1080天最大（所有已还分期）单笔担保费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_gurantee_amount
              else null
            end)            as his_repaid_gurantee_fee_sum  -- 历史至今累计（所有已还分期）担保费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_gurantee_amount
              else null
            end)            as d90_repaid_gurantee_fee_sum  -- 近90天累计（所有已还分期）担保费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_gurantee_amount
              else null
            end)            as d180_repaid_gurantee_fee_sum  -- 近180天累计（所有已还分期）担保费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_gurantee_amount
              else null
            end)            as d360_repaid_gurantee_fee_sum  -- 近360天累计（所有已还分期）担保费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_gurantee_amount
              else null
            end)            as d720_repaid_gurantee_fee_sum  -- 近720天累计（所有已还分期）担保费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_gurantee_amount
              else null
            end)            as d1080_repaid_gurantee_fee_sum  -- 近1080天累计（所有已还分期）担保费
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_principal
                         else null
                       end) as his_repaid_gurantee_fee_sum_divide_his_principal_sum  -- 历史至今累计（所有已还分期）担保费总和/历史（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_principal
                         else null
                       end) as d90_repaid_gurantee_fee_sum_divide_d90_principal_sum  -- 近90天累计（所有已还分期）担保费总和/近90天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_principal
                         else null
                       end) as d180_repaid_gurantee_fee_sum_divide_d180_principal_sum  -- 近180天累计（所有已还分期）担保费总和/近180天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_principal
                         else null
                       end) as d360_repaid_gurantee_fee_sum_divide_d360_principal_sum  -- 近360天累计（所有已还分期）担保费总和/近360天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_principal
                         else null
                       end) as d720_repaid_gurantee_fee_sum_divide_d720_principal_sum  -- 近720天累计（所有已还分期）担保费总和/近720天（所有已还分期）的本金总和
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_principal
                         else null
                       end) as d1080_sum_repaid_gurantee_fee_sum_divide_d1080_principal_sum  -- 近1080天累计（所有已还分期）担保费总和/近1080天（所有已还分期）的本金总和
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_gurantee_amount
                      else null
                    end)    as his_repaid_gurantee_fee_stddev  -- 历史至今每笔（所有已还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_gurantee_amount
                      else null
                    end)    as d90_repaid_gurantee_fee_stddev  -- 近90天每笔（所有已还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_gurantee_amount
                      else null
                    end)    as d180_repaid_gurantee_fee_stddev  -- 近180天每笔（所有已还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_gurantee_amount
                      else null
                    end)    as d360_repaid_gurantee_fee_stddev  -- 近360天每笔（所有已还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_gurantee_amount
                      else null
                    end)    as d720_repaid_gurantee_fee_stddev  -- 近720天每笔（所有已还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_gurantee_amount
                      else null
                    end)    as d1080_repaid_gurantee_fee_stddev  -- 近1080天每笔（所有已还分期）担保费_标准差
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_gurantee_amount
              else null
            end)            as his_pending_repay_gurantee_fee_max  -- 历史至今最大（历史未还分期）单笔担保费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_gurantee_amount
              else null
            end)            as d90_pending_repay_gurantee_fee_max  -- 近90天最大（历史未还分期）单笔担保费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_gurantee_amount
              else null
            end)            as d180_pending_repay_gurantee_fee_max  -- 近180天最大（历史未还分期）单笔担保费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_gurantee_amount
              else null
            end)            as d360_pending_repay_gurantee_fee_max  -- 近360天最大（历史未还分期）单笔担保费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_gurantee_amount
              else null
            end)            as d720_pending_repay_gurantee_fee_max  -- 近720天最大（历史未还分期）单笔担保费
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_gurantee_amount
              else null
            end)            as d1080_pending_repay_gurantee_fee_max  -- 近1080天最大（历史未还分期）单笔担保费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_gurantee_amount
              else null
            end)            as his_pending_repay_gurantee_fee_sum  -- 历史至今累计（历史未还分期）担保费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_gurantee_amount
              else null
            end)            as d90_pending_repay_gurantee_fee_sum  -- 近90天累计（历史未还分期）担保费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_gurantee_amount
              else null
            end)            as d180_pending_repay_gurantee_fee_sum  -- 近180天累计（历史未还分期）担保费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_gurantee_amount
              else null
            end)            as d360_pending_repay_gurantee_fee_sum  -- 近360天累计（历史未还分期）担保费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_gurantee_amount
              else null
            end)            as d720_pending_repay_gurantee_fee_sum  -- 近720天累计（历史未还分期）担保费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_gurantee_amount
              else null
            end)            as d1080_pending_repay_gurantee_fee_sum  -- 近1080天累计（历史未还分期）担保费
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_principal
                         else null
                       end) as his_pending_repay_gurantee_fee_sum_divide_his_principal_sum  -- 历史至今累计（历史未还分期）担保费总和/历史（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_principal
                         else null
                       end) as d90_pending_repay_gurantee_fee_sum_divide_d90_principal_sum  -- 近90天累计（历史未还分期）担保费总和/近90天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_principal
                         else null
                       end) as d180_pending_repay_gurantee_fee_sum_divide_d180_principal_sum  -- 近180天累计（历史未还分期）担保费总和/近180天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_principal
                         else null
                       end) as d360_pending_repay_gurantee_fee_sum_divide_d360_principal_sum  -- 近360天累计（历史未还分期）担保费总和/近360天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_principal
                         else null
                       end) as d720_pending_repay_gurantee_fee_sum_divide_d720_principal_sum  -- 近720天累计（历史未还分期）担保费总和/近720天（历史未还分期）的本金总和
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_principal
                         else null
                       end) as d1080_sum_pending_repay_gurantee_fee_sum_divide_d1080_principal_sum  -- 近1080天累计（历史未还分期）担保费总和/近1080天（历史未还分期）的本金总和
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_gurantee_amount
                      else null
                    end)    as his_pending_repay_gurantee_fee_stddev  -- 历史至今每笔（历史未还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_gurantee_amount
                      else null
                    end)    as d90_pending_repay_gurantee_fee_stddev  -- 近90天每笔（历史未还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_gurantee_amount
                      else null
                    end)    as d180_pending_repay_gurantee_fee_stddev  -- 近180天每笔（历史未还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_gurantee_amount
                      else null
                    end)    as d360_pending_repay_gurantee_fee_stddev  -- 近360天每笔（历史未还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_gurantee_amount
                      else null
                    end)    as d720_pending_repay_gurantee_fee_stddev  -- 近720天每笔（历史未还分期）担保费_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_gurantee_amount
                      else null
                    end)    as d1080_pending_repay_gurantee_fee_stddev  -- 近1080天每笔（历史未还分期）担保费_标准差
       ,max(case
              when repay_status_02 = '未来未还' then schedule_pay_gurantee_amount
              else null
            end)            as ftr_pending_repay_gurantee_fee_max  -- 未来最大（未来未还分期）单笔担保费
       ,sum(case
              when repay_status_02 = '未来未还' then schedule_pay_gurantee_amount
              else null
            end)            as ftr_pending_repay_gurantee_fee_sum  -- 未来累计（未来未还分期）担保费
       ,sum(case
              when repay_status_02 = '未来未还' then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 = '未来未还' then schedule_pay_principal
                         else null
                       end) as ftr_pending_repay_gurantee_fee_sum_divide_ftr_principal_sum  -- 未来累计（未来未还分期）担保费总和/未来未还分期本金总和
       ,stddev_samp(case
                      when repay_status_02 = '未来未还' then schedule_pay_gurantee_amount
                      else null
                    end)    as ftr_pending_repay_gurantee_fee_stddev  -- 未来每笔（未来未还分期）担保费_标准差
       ,max(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_gurantee_amount
              else null
            end)            as tot_pending_repay_gurantee_fee_max  -- 历史+未来未还分期单笔担保费_最大值
       ,sum(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_gurantee_amount
              else null
            end)            as tot_pending_repay_gurantee_fee_sum  -- 历史+未来未还分期担保费_累计值
       ,sum(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_gurantee_amount
              else null
            end) / sum(case
                         when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_principal
                         else null
                       end) as tot_pending_repay_gurantee_fee_sum_divide_ftr_principal_sum  -- 历史+未来未还分期担保费总和/历史+未来未还分期本金总和
       ,stddev_samp(case
                      when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_gurantee_amount
                      else null
                    end)    as tot_pending_repay_gurantee_fee_stddev  -- 历史+未来未还分期担保费_标准差
       -- ************************************************************************************* --
       -- *************************************** 总费用 *************************************** --
       -- ************************************************************************************* --
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_total_amount
              else null
            end)            as his_repaid_tot_fee_max  -- 历史至今最大（所有已还分期）单笔总费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_total_amount
              else null
            end)            as d90_repaid_tot_fee_max  -- 近90天最大（所有已还分期）单笔总费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_total_amount
              else null
            end)            as d180_repaid_tot_fee_max  -- 近180天最大（所有已还分期）单笔总费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_total_amount
              else null
            end)            as d360_repaid_tot_fee_max  -- 近360天最大（所有已还分期）单笔总费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_total_amount
              else null
            end)            as d720_repaid_tot_fee_max  -- 近720天最大（所有已还分期）单笔总费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_total_amount
              else null
            end)            as d1080_repaid_tot_fee_max  -- 近1080天最大（所有已还分期）单笔总费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_total_amount
              else null
            end)            as his_repaid_tot_fee_sum  -- 历史至今累计（所有已还分期）总费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_total_amount
              else null
            end)            as d90_repaid_tot_fee_sum  -- 近90天累计（所有已还分期）总费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_total_amount
              else null
            end)            as d180_repaid_tot_fee_sum  -- 近180天累计（所有已还分期）总费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_total_amount
              else null
            end)            as d360_repaid_tot_fee_sum  -- 近360天累计（所有已还分期）总费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_total_amount
              else null
            end)            as d720_repaid_tot_fee_sum  -- 近720天累计（所有已还分期）总费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_total_amount
              else null
            end)            as d1080_repaid_tot_fee_sum  -- 近1080天累计（所有已还分期）总费用
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_total_amount
                      else null
                    end)    as his_repaid_tot_fee_stddev  -- 历史至今每笔（所有已还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_total_amount
                      else null
                    end)    as d90_repaid_tot_fee_stddev  -- 近90天每笔（所有已还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_total_amount
                      else null
                    end)    as d180_repaid_tot_fee_stddev  -- 近180天每笔（所有已还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_total_amount
                      else null
                    end)    as d360_repaid_tot_fee_stddev  -- 近360天每笔（所有已还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_total_amount
                      else null
                    end)    as d720_repaid_tot_fee_stddev  -- 近720天每笔（所有已还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_total_amount
                      else null
                    end)    as d1080_repaid_tot_fee_stddev  -- 近1080天每笔（所有已还分期）总费用_标准差
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_total_amount
              else null
            end)            as his_pending_repay_tot_fee_max  -- 历史至今最大（历史未还分期）单笔总费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_total_amount
              else null
            end)            as d90_pending_repay_tot_fee_max  -- 近90天最大（历史未还分期）单笔总费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_total_amount
              else null
            end)            as d180_pending_repay_tot_fee_max  -- 近180天最大（历史未还分期）单笔总费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_total_amount
              else null
            end)            as d360_pending_repay_tot_fee_max  -- 近360天最大（历史未还分期）单笔总费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_total_amount
              else null
            end)            as d720_pending_repay_tot_fee_max  -- 近720天最大（历史未还分期）单笔总费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_total_amount
              else null
            end)            as d1080_pending_repay_tot_fee_max  -- 近1080天最大（历史未还分期）单笔总费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_total_amount
              else null
            end)            as his_pending_repay_tot_fee_sum  -- 历史至今累计（历史未还分期）总费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_total_amount
              else null
            end)            as d90_pending_repay_tot_fee_sum  -- 近90天累计（历史未还分期）总费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_total_amount
              else null
            end)            as d180_pending_repay_tot_fee_sum  -- 近180天累计（历史未还分期）总费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_total_amount
              else null
            end)            as d360_pending_repay_tot_fee_sum  -- 近360天累计（历史未还分期）总费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_total_amount
              else null
            end)            as d720_pending_repay_tot_fee_sum  -- 近720天累计（历史未还分期）总费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_total_amount
              else null
            end)            as d1080_pending_repay_tot_fee_sum  -- 近1080天累计（历史未还分期）总费用
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_total_amount
                      else null
                    end)    as his_pending_repay_tot_fee_stddev  -- 历史至今每笔（历史未还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_total_amount
                      else null
                    end)    as d90_pending_repay_tot_fee_stddev  -- 近90天每笔（历史未还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_total_amount
                      else null
                    end)    as d180_pending_repay_tot_fee_stddev  -- 近180天每笔（历史未还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_total_amount
                      else null
                    end)    as d360_pending_repay_tot_fee_stddev  -- 近360天每笔（历史未还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_total_amount
                      else null
                    end)    as d720_pending_repay_tot_fee_stddev  -- 近720天每笔（历史未还分期）总费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_total_amount
                      else null
                    end)    as d1080_pending_repay_tot_fee_stddev  -- 近1080天每笔（历史未还分期）总费用_标准差
       ,max(case
              when repay_status_02 = '未来未还' then schedule_total_amount
              else null
            end)            as ftr_pending_repay_tot_fee_max  -- 未来最大（未来未还分期）单笔总费用
       ,sum(case
              when repay_status_02 = '未来未还' then schedule_total_amount
              else null
            end)            as ftr_pending_repay_tot_fee_sum  -- 未来累计（未来未还分期）总费用
       ,stddev_samp(case
                      when repay_status_02 = '未来未还' then schedule_total_amount
                      else null
                    end)    as ftr_pending_repay_tot_fee_stddev  -- 未来每笔（未来未还分期）总费用_标准差
       ,max(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_total_amount
              else null
            end)            as tot_pending_repay_tot_fee_max  -- 历史+未来未还分期单笔总费用_最大值
       ,sum(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_total_amount
              else null
            end)            as tot_pending_repay_tot_fee_sum  -- 历史+未来未还分期总费用_累计值
       ,stddev_samp(case
                      when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_total_amount
                      else null
                    end)    as tot_pending_repay_tot_fee_stddev  -- 历史+未来未还分期总费用_标准差
       -- ************************************************************************************************* --
       -- *************************************** 排除本金外的所有费用 *************************************** --
       -- ************************************************************************************************* --
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_exclude_principal_fee
              else null
            end)            as his_repaid_exclude_principal_fee_max  -- 历史至今最大（所有已还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_exclude_principal_fee
              else null
            end)            as d90_repaid_exclude_principal_fee_max  -- 近90天最大（所有已还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_exclude_principal_fee
              else null
            end)            as d180_repaid_exclude_principal_fee_max  -- 近180天最大（所有已还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_exclude_principal_fee
              else null
            end)            as d360_repaid_exclude_principal_fee_max  -- 近360天最大（所有已还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_exclude_principal_fee
              else null
            end)            as d720_repaid_exclude_principal_fee_max  -- 近720天最大（所有已还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_exclude_principal_fee
              else null
            end)            as d1080_repaid_exclude_principal_fee_max  -- 近1080天最大（所有已还分期）单笔排除本金外的费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_exclude_principal_fee
              else null
            end)            as his_repaid_exclude_principal_fee_sum  -- 历史至今累计（所有已还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_exclude_principal_fee
              else null
            end)            as d90_repaid_exclude_principal_fee_sum  -- 近90天累计（所有已还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_exclude_principal_fee
              else null
            end)            as d180_repaid_exclude_principal_fee_sum  -- 近180天累计（所有已还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_exclude_principal_fee
              else null
            end)            as d360_repaid_exclude_principal_fee_sum  -- 近360天累计（所有已还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_exclude_principal_fee
              else null
            end)            as d720_repaid_exclude_principal_fee_sum  -- 近720天累计（所有已还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_exclude_principal_fee
              else null
            end)            as d1080_repaid_exclude_principal_fee_sum  -- 近1080天累计（所有已还分期）排除本金外的费用
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as his_repaid_exclude_principal_fee_stddev  -- 历史至今每笔（所有已还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 90 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d90_repaid_exclude_principal_fee_stddev  -- 近90天每笔（所有已还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 180 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d180_repaid_exclude_principal_fee_stddev  -- 近180天每笔（所有已还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 360 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d360_repaid_exclude_principal_fee_stddev  -- 近360天每笔（所有已还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 720 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d720_repaid_exclude_principal_fee_stddev  -- 近720天每笔（所有已还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '所有已还'
and     ddf_mdl_rep_tim > 0
and     ddf_mdl_rep_tim <= 1080 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d1080_repaid_exclude_principal_fee_stddev  -- 近1080天每笔（所有已还分期）排除本金外的费用_标准差
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_exclude_principal_fee
              else null
            end)            as his_pending_repay_exclude_principal_fee_max  -- 历史至今最大（历史未还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_exclude_principal_fee
              else null
            end)            as d90_pending_repay_exclude_principal_fee_max  -- 近90天最大（历史未还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_exclude_principal_fee
              else null
            end)            as d180_pending_repay_exclude_principal_fee_max  -- 近180天最大（历史未还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_exclude_principal_fee
              else null
            end)            as d360_pending_repay_exclude_principal_fee_max  -- 近360天最大（历史未还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_exclude_principal_fee
              else null
            end)            as d720_pending_repay_exclude_principal_fee_max  -- 近720天最大（历史未还分期）单笔排除本金外的费用
       ,max(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_exclude_principal_fee
              else null
            end)            as d1080_pending_repay_exclude_principal_fee_max  -- 近1080天最大（历史未还分期）单笔排除本金外的费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_exclude_principal_fee
              else null
            end)            as his_pending_repay_exclude_principal_fee_sum  -- 历史至今累计（历史未还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_exclude_principal_fee
              else null
            end)            as d90_pending_repay_exclude_principal_fee_sum  -- 近90天累计（历史未还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_exclude_principal_fee
              else null
            end)            as d180_pending_repay_exclude_principal_fee_sum  -- 近180天累计（历史未还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_exclude_principal_fee
              else null
            end)            as d360_pending_repay_exclude_principal_fee_sum  -- 近360天累计（历史未还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_exclude_principal_fee
              else null
            end)            as d720_pending_repay_exclude_principal_fee_sum  -- 近720天累计（历史未还分期）排除本金外的费用
       ,sum(case
              when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_exclude_principal_fee
              else null
            end)            as d1080_pending_repay_exclude_principal_fee_sum  -- 近1080天累计（历史未还分期）排除本金外的费用
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as his_pending_repay_exclude_principal_fee_stddev  -- 历史至今每笔（历史未还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 90 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d90_pending_repay_exclude_principal_fee_stddev  -- 近90天每笔（历史未还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 180 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d180_pending_repay_exclude_principal_fee_stddev  -- 近180天每笔（历史未还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 360 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d360_pending_repay_exclude_principal_fee_stddev  -- 近360天每笔（历史未还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 720 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d720_pending_repay_exclude_principal_fee_stddev  -- 近720天每笔（历史未还分期）排除本金外的费用_标准差
       ,stddev_samp(case
                      when repay_status_02 = '历史未还'
and     ddf_mdl_rep_dte > 0
and     ddf_mdl_rep_dte <= 1080 then schedule_pay_exclude_principal_fee
                      else null
                    end)    as d1080_pending_repay_exclude_principal_fee_stddev  -- 近1080天每笔（历史未还分期）排除本金外的费用_标准差
       ,max(case
              when repay_status_02 = '未来未还' then schedule_pay_exclude_principal_fee
              else null
            end)            as ftr_pending_repay_exclude_principal_fee_max  -- 未来最大（未来未还分期）单笔排除本金外的费用
       ,sum(case
              when repay_status_02 = '未来未还' then schedule_pay_exclude_principal_fee
              else null
            end)            as ftr_pending_repay_exclude_principal_fee_sum  -- 未来累计（未来未还分期）排除本金外的费用
       ,stddev_samp(case
                      when repay_status_02 = '未来未还' then schedule_pay_exclude_principal_fee
                      else null
                    end)    as ftr_pending_repay_exclude_principal_fee_stddev  -- 未来每笔（未来未还分期）排除本金外的费用_标准差
       ,max(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_exclude_principal_fee
              else null
            end)            as tot_pending_repay_exclude_principal_fee_max  -- 历史+未来未还分期单笔排除本金外的费用_最大值
       ,sum(case
              when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_exclude_principal_fee
              else null
            end)            as tot_pending_repay_exclude_principal_fee_sum  -- 历史+未来未还分期排除本金外的费用_累计值
       ,stddev_samp(case
                      when repay_status_02 in ( '未来未还' , '历史未还' ) then schedule_pay_exclude_principal_fee
                      else null
                    end)    as tot_pending_repay_exclude_principal_fee_stddev -- 历史+未来未还分期排除本金外的费用_标准差
from    (
            select  *
            from    dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_atoms_table01
            where   repay_status_02 in ( '历史未还' , '未来未还' , '所有已还' )
        ) basic
group by uid
        ,mdl_dte;


create table if not exists ${dwa_risk}.dwa_risk_dz_model_final_26_lending_costs_detail_df
(
uid string comment 'uid',
mdl_dte string comment '评分日T日，yyyy-mm-dd',
his_adv_repay_fee_max decimal(38,18) comment '历史至今_各期提前还款手续费_最大值',
d90_adv_repay_fee_max decimal(38,18) comment '近90天_各期提前还款手续费_最大值',
d180_adv_repay_fee_max decimal(38,18) comment '近180天_各期提前还款手续费_最大值',
d360_adv_repay_fee_max decimal(38,18) comment '近360天_各期提前还款手续费_最大值',
d720_adv_repay_fee_max decimal(38,18) comment '近720天_各期提前还款手续费_最大值',
d1080_adv_repay_fee_max decimal(38,18) comment '近1080天_各期提前还款手续费_最大值',
his_adv_repay_fee_sum decimal(38,18) comment '历史至今_各期提前还款手续费_总和',
d90_adv_repay_fee_sum decimal(38,18) comment '近90天_各期提前还款手续费_总和',
d180_adv_repay_fee_sum decimal(38,18) comment '近180天_各期提前还款手续费_总和',
d360_adv_repay_fee_sum decimal(38,18) comment '近360天_各期提前还款手续费_总和',
d720_adv_repay_fee_sum decimal(38,18) comment '近720天_各期提前还款手续费_总和',
d1080_adv_repay_fee_sum decimal(38,18) comment '近1080天_各期提前还款手续费_总和',
his_adv_repay_fee_sum_divide_his_principal_sum decimal(38,18) comment '历史至今_各期提前还款手续费_总和/历史至今_各期提前还款分期的本金_总和',
d90_adv_repay_fee_sum_divide_d90_principal_sum decimal(38,18) comment '近90天_各期提前还款手续费_总和/近90天_各期提前还款分期的本金_总和',
d180_adv_repay_fee_sum_divide_d180_principal_sum decimal(38,18) comment '近180天_各期提前还款手续费_总和/近180天_各期提前还款分期的本金_总和',
d360_adv_repay_fee_sum_divide_d360_principal_sum decimal(38,18) comment '近360天_各期提前还款手续费_总和/近360天_各期提前还款分期的本金_总和',
d720_adv_repay_fee_sum_divide_d720_principal_sum decimal(38,18) comment '近720天_各期提前还款手续费_总和/近720天_各期提前还款分期的本金_总和',
d1080_sum_adv_repay_fee_sum_divide_d1080_principal_sum decimal(38,18) comment '近1080天_各期提前还款手续费_总和/近1080天_各期提前还款分期的本金_总和',
his_stddev_adv_repay_fee double comment '历史至今_各期提前还款手续费_标准差',
d90_stddev_adv_repay_fee double comment '近90天_各期提前还款手续费_标准差',
d180_stddev_adv_repay_fee double comment '近180天_各期提前还款手续费_标准差',
d360_stddev_adv_repay_fee double comment '近360天_各期提前还款手续费_标准差',
d720_stddev_adv_repay_fee double comment '近720天_各期提前还款手续费_标准差',
d1080_stddev_adv_repay_fee double comment '近1080天_各期提前还款手续费_标准差',
his_schedule_pay_penalty_max decimal(38,18) comment '历史至今_各期逾期还款罚息_最大值',
d90_schedule_pay_penalty_max decimal(38,18) comment '近90天_各期逾期还款罚息_最大值',
d180_schedule_pay_penalty_max decimal(38,18) comment '近180天_各期逾期还款罚息_最大值',
d360_schedule_pay_penalty_max decimal(38,18) comment '近360天_各期逾期还款罚息_最大值',
d720_schedule_pay_penalty_max decimal(38,18) comment '近720天_各期逾期还款罚息_最大值',
d1080_schedule_pay_penalty_max decimal(38,18) comment '近1080天_各期逾期还款罚息_最大值',
his_schedule_pay_penalty_sum decimal(38,18) comment '历史至今_各期逾期还款罚息_总和',
d90_schedule_pay_penalty_sum decimal(38,18) comment '近90天_各期逾期还款罚息_总和',
d180_schedule_pay_penalty_sum decimal(38,18) comment '近180天_各期逾期还款罚息_总和',
d360_schedule_pay_penalty_sum decimal(38,18) comment '近360天_各期逾期还款罚息_总和',
d720_schedule_pay_penalty_sum decimal(38,18) comment '近720天_各期逾期还款罚息_总和',
d1080_schedule_pay_penalty_sum decimal(38,18) comment '近1080天_各期逾期还款罚息_总和',
his_schedule_pay_penalty_sum_divide_his_principal_sum decimal(38,18) comment '历史至今_各期逾期还款罚息_总和/历史至今_各期逾期还款分期的本金_总和',
d90_schedule_pay_penalty_sum_divide_d90_principal_sum decimal(38,18) comment '近90天_各期逾期还款罚息_总和/近90天_各期逾期还款分期的本金_总和',
d180_schedule_pay_penalty_sum_divide_d180_principal_sum decimal(38,18) comment '近180天_各期逾期还款罚息_总和/近180天_各期逾期还款分期的本金_总和',
d360_schedule_pay_penalty_sum_divide_d360_principal_sum decimal(38,18) comment '近360天_各期逾期还款罚息_总和/近360天_各期逾期还款分期的本金_总和',
d720_schedule_pay_penalty_sum_divide_d720_principal_sum decimal(38,18) comment '近720天_各期逾期还款罚息_总和/近720天_各期逾期还款分期的本金_总和',
d1080_sum_schedule_pay_penalty_sum_divide_d1080_principal_sum decimal(38,18) comment '近1080天_各期逾期还款罚息_总和/近1080天_各期逾期还款分期的本金_总和',
his_stddev_schedule_pay_penalty double comment '历史至今_各期逾期还款罚息_标准差',
d90_stddev_schedule_pay_penalty double comment '近90天_各期逾期还款罚息_标准差',
d180_stddev_schedule_pay_penalty double comment '近180天_各期逾期还款罚息_标准差',
d360_stddev_schedule_pay_penalty double comment '近360天_各期逾期还款罚息_标准差',
d720_stddev_schedule_pay_penalty double comment '近720天_各期逾期还款罚息_标准差',
d1080_stddev_schedule_pay_penalty double comment '近1080天_各期逾期还款罚息_标准差',
his_repaid_interest_fee_max decimal(38,18) comment '历史至今_（所有已还分期）各期利息费_最大值',
d90_repaid_interest_fee_max decimal(38,18) comment '近90天_（所有已还分期）各期利息费_最大值',
d180_repaid_interest_fee_max decimal(38,18) comment '近180天_（所有已还分期）各期利息费_最大值',
d360_repaid_interest_fee_max decimal(38,18) comment '近360天_（所有已还分期）各期利息费_最大值',
d720_repaid_interest_fee_max decimal(38,18) comment '近720天_（所有已还分期）各期利息费_最大值',
d1080_repaid_interest_fee_max decimal(38,18) comment '近1080天_（所有已还分期）各期利息费_最大值',
his_repaid_interest_fee_sum decimal(38,18) comment '历史至今_（所有已还分期）各期利息费_总和',
d90_repaid_interest_fee_sum decimal(38,18) comment '近90天_（所有已还分期）各期利息费_总和',
d180_repaid_interest_fee_sum decimal(38,18) comment '近180天_（所有已还分期）各期利息费_总和',
d360_repaid_interest_fee_sum decimal(38,18) comment '近360天_（所有已还分期）各期利息费_总和',
d720_repaid_interest_fee_sum decimal(38,18) comment '近720天_（所有已还分期）各期利息费_总和',
d1080_repaid_interest_fee_sum decimal(38,18) comment '近1080天_（所有已还分期）各期利息费_总和',
his_repaid_interest_fee_sum_divide_his_principal_sum decimal(38,18) comment '历史至今_（所有已还分期）各期利息费总和/历史至今_（所有已还分期）各期本金总和',
d90_repaid_interest_fee_sum_divide_d90_principal_sum decimal(38,18) comment '近90天_（所有已还分期）各期利息费总和/近90天_（所有已还分期）各期本金总和',
d180_repaid_interest_fee_sum_divide_d180_principal_sum decimal(38,18) comment '近180天_（所有已还分期）各期利息费总和/近180天_（所有已还分期）各期本金总和',
d360_repaid_interest_fee_sum_divide_d360_principal_sum decimal(38,18) comment '近360天_（所有已还分期）各期利息费总和/近360天_（所有已还分期）各期本金总和',
d720_repaid_interest_fee_sum_divide_d720_principal_sum decimal(38,18) comment '近720天_（所有已还分期）各期利息费总和/近720天_（所有已还分期）各期本金总和',
d1080_sum_repaid_interest_fee_sum_divide_d1080_principal_sum decimal(38,18) comment '近1080天_（所有已还分期）各期利息费总和/近1080天_（所有已还分期）各期本金总和',
his_repaid_interest_fee_stddev double comment '历史至今_（所有已还分期）各期利息费_标准差',
d90_repaid_interest_fee_stddev double comment '近90天_（所有已还分期）各期利息费_标准差',
d180_repaid_interest_fee_stddev double comment '近180天_（所有已还分期）各期利息费_标准差',
d360_repaid_interest_fee_stddev double comment '近360天_（所有已还分期）各期利息费_标准差',
d720_repaid_interest_fee_stddev double comment '近720天_（所有已还分期）各期利息费_标准差',
d1080_repaid_interest_fee_stddev double comment '近1080天_（所有已还分期）各期利息费_标准差',
his_pending_repay_interest_fee_max decimal(38,18) comment '历史至今_（历史未还分期）各期利息费_最大值',
d90_pending_repay_interest_fee_max decimal(38,18) comment '近90天_（历史未还分期）各期利息费_最大值',
d180_pending_repay_interest_fee_max decimal(38,18) comment '近180天_（历史未还分期）各期利息费_最大值',
d360_pending_repay_interest_fee_max decimal(38,18) comment '近360天_（历史未还分期）各期利息费_最大值',
d720_pending_repay_interest_fee_max decimal(38,18) comment '近720天_（历史未还分期）各期利息费_最大值',
d1080_pending_repay_interest_fee_max decimal(38,18) comment '近1080天_（历史未还分期）各期利息费_最大值',
his_pending_repay_interest_fee_sum decimal(38,18) comment '历史至今_（历史未还分期）各期利息费_总和',
d90_pending_repay_interest_fee_sum decimal(38,18) comment '近90天_（历史未还分期）各期利息费_总和',
d180_pending_repay_interest_fee_sum decimal(38,18) comment '近180天_（历史未还分期）各期利息费_总和',
d360_pending_repay_interest_fee_sum decimal(38,18) comment '近360天_（历史未还分期）各期利息费_总和',
d720_pending_repay_interest_fee_sum decimal(38,18) comment '近720天_（历史未还分期）各期利息费_总和',
d1080_pending_repay_interest_fee_sum decimal(38,18) comment '近1080天_（历史未还分期）各期利息费_总和',
his_pending_repay_interest_fee_sum_divide_his_principal_sum decimal(38,18) comment '历史至今_（历史未还分期）各期利息费总和/历史至今_（历史未还分期）各期本金总和',
d90_pending_repay_interest_fee_sum_divide_d90_principal_sum decimal(38,18) comment '近90天_（历史未还分期）各期利息费总和/近90天_（历史未还分期）各期本金总和',
d180_pending_repay_interest_fee_sum_divide_d180_principal_sum decimal(38,18) comment '近180天_（历史未还分期）各期利息费总和/近180天_（历史未还分期）各期本金总和',
d360_pending_repay_interest_fee_sum_divide_d360_principal_sum decimal(38,18) comment '近360天_（历史未还分期）各期利息费总和/近360天_（历史未还分期）各期本金总和',
d720_pending_repay_interest_fee_sum_divide_d720_principal_sum decimal(38,18) comment '近720天_（历史未还分期）各期利息费总和/近720天_（历史未还分期）各期本金总和',
d1080_sum_pending_repay_interest_fee_sum_divide_d1080_principal_sum decimal(38,18) comment '近1080天_（历史未还分期）各期利息费总和/近1080天_（历史未还分期）各期本金总和',
his_pending_repay_interest_fee_stddev double comment '历史至今_（历史未还分期）各期利息费_标准差',
d90_pending_repay_interest_fee_stddev double comment '近90天_（历史未还分期）各期利息费_标准差',
d180_pending_repay_interest_fee_stddev double comment '近180天_（历史未还分期）各期利息费_标准差',
d360_pending_repay_interest_fee_stddev double comment '近360天_（历史未还分期）各期利息费_标准差',
d720_pending_repay_interest_fee_stddev double comment '近720天_（历史未还分期）各期利息费_标准差',
d1080_pending_repay_interest_fee_stddev double comment '近1080天_（历史未还分期）各期利息费_标准差',
ftr_pending_repay_interest_fee_max decimal(38,18) comment '所有未来未还分期_各期利息费_最大值',
ftr_pending_repay_interest_fee_sum decimal(38,18) comment '所有未来未还分期_各期利息费_总和',
ftr_pending_repay_interest_fee_sum_divide_ftr_principal_sum decimal(38,18) comment '所有未来未还分期_各期利息费总和/所有未来未还分期_各期本金总和',
ftr_pending_repay_interest_fee_stddev double comment '所有未来未还分期_各期利息费_标准差',
tot_pending_repay_interest_fee_max decimal(38,18) comment '所有历史+未来未还分期_各期利息费_最大值',
tot_pending_repay_interest_fee_sum decimal(38,18) comment '所有历史+未来未还分期_各期利息费_总和',
tot_pending_repay_interest_fee_sum_divide_ftr_principal_sum decimal(38,18) comment '所有历史+未来未还分期_各期利息费总和/所有历史+未来未还分期_各期本金总和',
tot_pending_repay_interest_fee_stddev double comment '所有历史+未来未还分期_各期利息费_标准差',
his_repaid_gurantee_fee_max decimal(38,18) comment '历史至今_（所有已还分期）各期担保费_最大值',
d90_repaid_gurantee_fee_max decimal(38,18) comment '近90天_（所有已还分期）各期担保费_最大值',
d180_repaid_gurantee_fee_max decimal(38,18) comment '近180天_（所有已还分期）各期担保费_最大值',
d360_repaid_gurantee_fee_max decimal(38,18) comment '近360天_（所有已还分期）各期担保费_最大值',
d720_repaid_gurantee_fee_max decimal(38,18) comment '近720天_（所有已还分期）各期担保费_最大值',
d1080_repaid_gurantee_fee_max decimal(38,18) comment '近1080天_（所有已还分期）各期担保费_最大值',
his_repaid_gurantee_fee_sum decimal(38,18) comment '历史至今_（所有已还分期）各期担保费_总和',
d90_repaid_gurantee_fee_sum decimal(38,18) comment '近90天_（所有已还分期）各期担保费_总和',
d180_repaid_gurantee_fee_sum decimal(38,18) comment '近180天_（所有已还分期）各期担保费_总和',
d360_repaid_gurantee_fee_sum decimal(38,18) comment '近360天_（所有已还分期）各期担保费_总和',
d720_repaid_gurantee_fee_sum decimal(38,18) comment '近720天_（所有已还分期）各期担保费_总和',
d1080_repaid_gurantee_fee_sum decimal(38,18) comment '近1080天_（所有已还分期）各期担保费_总和',
his_repaid_gurantee_fee_sum_divide_his_principal_sum decimal(38,18) comment '历史至今_（所有已还分期）各期担保费总和/历史至今_（所有已还分期）各期本金总和',
d90_repaid_gurantee_fee_sum_divide_d90_principal_sum decimal(38,18) comment '近90天_（所有已还分期）各期担保费总和/近90天_（所有已还分期）各期本金总和',
d180_repaid_gurantee_fee_sum_divide_d180_principal_sum decimal(38,18) comment '近180天_（所有已还分期）各期担保费总和/近180天_（所有已还分期）各期本金总和',
d360_repaid_gurantee_fee_sum_divide_d360_principal_sum decimal(38,18) comment '近360天_（所有已还分期）各期担保费总和/近360天_（所有已还分期）各期本金总和',
d720_repaid_gurantee_fee_sum_divide_d720_principal_sum decimal(38,18) comment '近720天_（所有已还分期）各期担保费总和/近720天_（所有已还分期）各期本金总和',
d1080_sum_repaid_gurantee_fee_sum_divide_d1080_principal_sum decimal(38,18) comment '近1080天_（所有已还分期）各期担保费总和/近1080天_（所有已还分期）各期本金总和',
his_repaid_gurantee_fee_stddev double comment '历史至今_（所有已还分期）各期担保费_标准差',
d90_repaid_gurantee_fee_stddev double comment '近90天_（所有已还分期）各期担保费_标准差',
d180_repaid_gurantee_fee_stddev double comment '近180天_（所有已还分期）各期担保费_标准差',
d360_repaid_gurantee_fee_stddev double comment '近360天_（所有已还分期）各期担保费_标准差',
d720_repaid_gurantee_fee_stddev double comment '近720天_（所有已还分期）各期担保费_标准差',
d1080_repaid_gurantee_fee_stddev double comment '近1080天_（所有已还分期）各期担保费_标准差',
his_pending_repay_gurantee_fee_max decimal(38,18) comment '历史至今_（历史未还分期）各期担保费_最大值',
d90_pending_repay_gurantee_fee_max decimal(38,18) comment '近90天_（历史未还分期）各期担保费_最大值',
d180_pending_repay_gurantee_fee_max decimal(38,18) comment '近180天_（历史未还分期）各期担保费_最大值',
d360_pending_repay_gurantee_fee_max decimal(38,18) comment '近360天_（历史未还分期）各期担保费_最大值',
d720_pending_repay_gurantee_fee_max decimal(38,18) comment '近720天_（历史未还分期）各期担保费_最大值',
d1080_pending_repay_gurantee_fee_max decimal(38,18) comment '近1080天_（历史未还分期）各期担保费_最大值',
his_pending_repay_gurantee_fee_sum decimal(38,18) comment '历史至今_（历史未还分期）各期担保费_总和',
d90_pending_repay_gurantee_fee_sum decimal(38,18) comment '近90天_（历史未还分期）各期担保费_总和',
d180_pending_repay_gurantee_fee_sum decimal(38,18) comment '近180天_（历史未还分期）各期担保费_总和',
d360_pending_repay_gurantee_fee_sum decimal(38,18) comment '近360天_（历史未还分期）各期担保费_总和',
d720_pending_repay_gurantee_fee_sum decimal(38,18) comment '近720天_（历史未还分期）各期担保费_总和',
d1080_pending_repay_gurantee_fee_sum decimal(38,18) comment '近1080天_（历史未还分期）各期担保费_总和',
his_pending_repay_gurantee_fee_sum_divide_his_principal_sum decimal(38,18) comment '历史至今_（历史未还分期）各期担保费总和/历史至今_（历史未还分期）各期本金总和',
d90_pending_repay_gurantee_fee_sum_divide_d90_principal_sum decimal(38,18) comment '近90天_（历史未还分期）各期担保费总和/近90天_（历史未还分期）各期本金总和',
d180_pending_repay_gurantee_fee_sum_divide_d180_principal_sum decimal(38,18) comment '近180天_（历史未还分期）各期担保费总和/近180天_（历史未还分期）各期本金总和',
d360_pending_repay_gurantee_fee_sum_divide_d360_principal_sum decimal(38,18) comment '近360天_（历史未还分期）各期担保费总和/近360天_（历史未还分期）各期本金总和',
d720_pending_repay_gurantee_fee_sum_divide_d720_principal_sum decimal(38,18) comment '近720天_（历史未还分期）各期担保费总和/近720天_（历史未还分期）各期本金总和',
d1080_sum_pending_repay_gurantee_fee_sum_divide_d1080_principal_sum decimal(38,18) comment '近1080天_（历史未还分期）各期担保费总和/近1080天_（历史未还分期）各期本金总和',
his_pending_repay_gurantee_fee_stddev double comment '历史至今_（历史未还分期）各期担保费_标准差',
d90_pending_repay_gurantee_fee_stddev double comment '近90天_（历史未还分期）各期担保费_标准差',
d180_pending_repay_gurantee_fee_stddev double comment '近180天_（历史未还分期）各期担保费_标准差',
d360_pending_repay_gurantee_fee_stddev double comment '近360天_（历史未还分期）各期担保费_标准差',
d720_pending_repay_gurantee_fee_stddev double comment '近720天_（历史未还分期）各期担保费_标准差',
d1080_pending_repay_gurantee_fee_stddev double comment '近1080天_（历史未还分期）各期担保费_标准差',
ftr_pending_repay_gurantee_fee_max decimal(38,18) comment '所有未来未还分期_各期担保费_最大值',
ftr_pending_repay_gurantee_fee_sum decimal(38,18) comment '所有未来未还分期_各期担保费_总和',
ftr_pending_repay_gurantee_fee_sum_divide_ftr_principal_sum decimal(38,18) comment '所有未来未还分期_各期担保费总和/所有未来未还分期_各期本金总和',
ftr_pending_repay_gurantee_fee_stddev double comment '所有未来未还分期_各期担保费_标准差',
tot_pending_repay_gurantee_fee_max decimal(38,18) comment '所有历史+未来未还分期_各期担保费_最大值',
tot_pending_repay_gurantee_fee_sum decimal(38,18) comment '所有历史+未来未还分期_各期担保费_总和',
tot_pending_repay_gurantee_fee_sum_divide_ftr_principal_sum decimal(38,18) comment '所有历史+未来未还分期_各期担保费总和/所有历史+未来未还分期_各期本金总和',
tot_pending_repay_gurantee_fee_stddev double comment '所有历史+未来未还分期_各期担保费_标准差',
his_repaid_tot_fee_max decimal(38,18) comment '历史至今_（所有已还分期）各期总应还费用_最大值',
d90_repaid_tot_fee_max decimal(38,18) comment '近90天_（所有已还分期）各期总应还费用_最大值',
d180_repaid_tot_fee_max decimal(38,18) comment '近180天_（所有已还分期）各期总应还费用_最大值',
d360_repaid_tot_fee_max decimal(38,18) comment '近360天_（所有已还分期）各期总应还费用_最大值',
d720_repaid_tot_fee_max decimal(38,18) comment '近720天_（所有已还分期）各期总应还费用_最大值',
d1080_repaid_tot_fee_max decimal(38,18) comment '近1080天_（所有已还分期）各期总应还费用_最大值',
his_repaid_tot_fee_sum decimal(38,18) comment '历史至今_（所有已还分期）各期总应还费用_总和',
d90_repaid_tot_fee_sum decimal(38,18) comment '近90天_（所有已还分期）各期总应还费用_总和',
d180_repaid_tot_fee_sum decimal(38,18) comment '近180天_（所有已还分期）各期总应还费用_总和',
d360_repaid_tot_fee_sum decimal(38,18) comment '近360天_（所有已还分期）各期总应还费用_总和',
d720_repaid_tot_fee_sum decimal(38,18) comment '近720天_（所有已还分期）各期总应还费用_总和',
d1080_repaid_tot_fee_sum decimal(38,18) comment '近1080天_（所有已还分期）各期总应还费用_总和',
his_repaid_tot_fee_stddev double comment '历史至今_（所有已还分期）各期总应还费用_标准差',
d90_repaid_tot_fee_stddev double comment '近90天_（所有已还分期）各期总应还费用_标准差',
d180_repaid_tot_fee_stddev double comment '近180天_（所有已还分期）各期总应还费用_标准差',
d360_repaid_tot_fee_stddev double comment '近360天_（所有已还分期）各期总应还费用_标准差',
d720_repaid_tot_fee_stddev double comment '近720天_（所有已还分期）各期总应还费用_标准差',
d1080_repaid_tot_fee_stddev double comment '近1080天_（所有已还分期）各期总应还费用_标准差',
his_pending_repay_tot_fee_max decimal(38,18) comment '历史至今_（历史未还分期）各期总应还费用_最大值',
d90_pending_repay_tot_fee_max decimal(38,18) comment '近90天_（历史未还分期）各期总应还费用_最大值',
d180_pending_repay_tot_fee_max decimal(38,18) comment '近180天_（历史未还分期）各期总应还费用_最大值',
d360_pending_repay_tot_fee_max decimal(38,18) comment '近360天_（历史未还分期）各期总应还费用_最大值',
d720_pending_repay_tot_fee_max decimal(38,18) comment '近720天_（历史未还分期）各期总应还费用_最大值',
d1080_pending_repay_tot_fee_max decimal(38,18) comment '近1080天_（历史未还分期）各期总应还费用_最大值',
his_pending_repay_tot_fee_sum decimal(38,18) comment '历史至今_（历史未还分期）各期总应还费用_总和',
d90_pending_repay_tot_fee_sum decimal(38,18) comment '近90天_（历史未还分期）各期总应还费用_总和',
d180_pending_repay_tot_fee_sum decimal(38,18) comment '近180天_（历史未还分期）各期总应还费用_总和',
d360_pending_repay_tot_fee_sum decimal(38,18) comment '近360天_（历史未还分期）各期总应还费用_总和',
d720_pending_repay_tot_fee_sum decimal(38,18) comment '近720天_（历史未还分期）各期总应还费用_总和',
d1080_pending_repay_tot_fee_sum decimal(38,18) comment '近1080天_（历史未还分期）各期总应还费用_总和',
his_pending_repay_tot_fee_stddev double comment '历史至今_（历史未还分期）各期总应还费用_标准差',
d90_pending_repay_tot_fee_stddev double comment '近90天_（历史未还分期）各期总应还费用_标准差',
d180_pending_repay_tot_fee_stddev double comment '近180天_（历史未还分期）各期总应还费用_标准差',
d360_pending_repay_tot_fee_stddev double comment '近360天_（历史未还分期）各期总应还费用_标准差',
d720_pending_repay_tot_fee_stddev double comment '近720天_（历史未还分期）各期总应还费用_标准差',
d1080_pending_repay_tot_fee_stddev double comment '近1080天_（历史未还分期）各期总应还费用_标准差',
ftr_pending_repay_tot_fee_max decimal(38,18) comment '所有未来未还分期_各期总应还费用_最大值',
ftr_pending_repay_tot_fee_sum decimal(38,18) comment '所有未来未还分期_各期总应还费用_总和',
ftr_pending_repay_tot_fee_stddev double comment '所有未来未还分期_各期总应还费用_标准差',
tot_pending_repay_tot_fee_max decimal(38,18) comment '所有历史+未来未还分期_各期总应还费用_最大值',
tot_pending_repay_tot_fee_sum decimal(38,18) comment '所有历史+未来未还分期_各期总应还费用_总和',
tot_pending_repay_tot_fee_stddev double comment '所有历史+未来未还分期_各期总应还费用_标准差',
his_repaid_exclude_principal_fee_max decimal(38,18) comment '历史至今_（所有已还分期）各期排除本金外费用_最大值',
d90_repaid_exclude_principal_fee_max decimal(38,18) comment '近90天_（所有已还分期）各期排除本金外费用_最大值',
d180_repaid_exclude_principal_fee_max decimal(38,18) comment '近180天_（所有已还分期）各期排除本金外费用_最大值',
d360_repaid_exclude_principal_fee_max decimal(38,18) comment '近360天_（所有已还分期）各期排除本金外费用_最大值',
d720_repaid_exclude_principal_fee_max decimal(38,18) comment '近720天_（所有已还分期）各期排除本金外费用_最大值',
d1080_repaid_exclude_principal_fee_max decimal(38,18) comment '近1080天_（所有已还分期）各期排除本金外费用_最大值',
his_repaid_exclude_principal_fee_sum decimal(38,18) comment '历史至今_（所有已还分期）各期排除本金外费用_总和',
d90_repaid_exclude_principal_fee_sum decimal(38,18) comment '近90天_（所有已还分期）各期排除本金外费用_总和',
d180_repaid_exclude_principal_fee_sum decimal(38,18) comment '近180天_（所有已还分期）各期排除本金外费用_总和',
d360_repaid_exclude_principal_fee_sum decimal(38,18) comment '近360天_（所有已还分期）各期排除本金外费用_总和',
d720_repaid_exclude_principal_fee_sum decimal(38,18) comment '近720天_（所有已还分期）各期排除本金外费用_总和',
d1080_repaid_exclude_principal_fee_sum decimal(38,18) comment '近1080天_（所有已还分期）各期排除本金外费用_总和',
his_repaid_exclude_principal_fee_stddev double comment '历史至今_（所有已还分期）各期排除本金外费用_标准差',
d90_repaid_exclude_principal_fee_stddev double comment '近90天_（所有已还分期）各期排除本金外费用_标准差',
d180_repaid_exclude_principal_fee_stddev double comment '近180天_（所有已还分期）各期排除本金外费用_标准差',
d360_repaid_exclude_principal_fee_stddev double comment '近360天_（所有已还分期）各期排除本金外费用_标准差',
d720_repaid_exclude_principal_fee_stddev double comment '近720天_（所有已还分期）各期排除本金外费用_标准差',
d1080_repaid_exclude_principal_fee_stddev double comment '近1080天_（所有已还分期）各期排除本金外费用_标准差',
his_pending_repay_exclude_principal_fee_max decimal(38,18) comment '历史至今_（历史未还分期）各期排除本金外费用_最大值',
d90_pending_repay_exclude_principal_fee_max decimal(38,18) comment '近90天_（历史未还分期）各期排除本金外费用_最大值',
d180_pending_repay_exclude_principal_fee_max decimal(38,18) comment '近180天_（历史未还分期）各期排除本金外费用_最大值',
d360_pending_repay_exclude_principal_fee_max decimal(38,18) comment '近360天_（历史未还分期）各期排除本金外费用_最大值',
d720_pending_repay_exclude_principal_fee_max decimal(38,18) comment '近720天_（历史未还分期）各期排除本金外费用_最大值',
d1080_pending_repay_exclude_principal_fee_max decimal(38,18) comment '近1080天_（历史未还分期）各期排除本金外费用_最大值',
his_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '历史至今_（历史未还分期）各期排除本金外费用_总和',
d90_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '近90天_（历史未还分期）各期排除本金外费用_总和',
d180_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '近180天_（历史未还分期）各期排除本金外费用_总和',
d360_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '近360天_（历史未还分期）各期排除本金外费用_总和',
d720_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '近720天_（历史未还分期）各期排除本金外费用_总和',
d1080_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '近1080天_（历史未还分期）各期排除本金外费用_总和',
his_pending_repay_exclude_principal_fee_stddev double comment '历史至今_（历史未还分期）各期排除本金外费用_标准差',
d90_pending_repay_exclude_principal_fee_stddev double comment '近90天_（历史未还分期）各期排除本金外费用_标准差',
d180_pending_repay_exclude_principal_fee_stddev double comment '近180天_（历史未还分期）各期排除本金外费用_标准差',
d360_pending_repay_exclude_principal_fee_stddev double comment '近360天_（历史未还分期）各期排除本金外费用_标准差',
d720_pending_repay_exclude_principal_fee_stddev double comment '近720天_（历史未还分期）各期排除本金外费用_标准差',
d1080_pending_repay_exclude_principal_fee_stddev double comment '近1080天_（历史未还分期）各期排除本金外费用_标准差',
ftr_pending_repay_exclude_principal_fee_max decimal(38,18) comment '所有未来未还分期_各期排除本金外费用_最大值',
ftr_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '所有未来未还分期_各期排除本金外费用_总和',
ftr_pending_repay_exclude_principal_fee_stddev double comment '所有未来未还分期_各期排除本金外费用_标准差',
tot_pending_repay_exclude_principal_fee_max decimal(38,18) comment '所有历史+未来未还分期_各期排除本金外费用_最大值',
tot_pending_repay_exclude_principal_fee_sum decimal(38,18) comment '所有历史+未来未还分期_各期排除本金外费用_总和',
tot_pending_repay_exclude_principal_fee_stddev double comment '所有历史+未来未还分期_各期排除本金外费用_标准差'
)
PARTITIONED BY (ds STRING comment '分区字段，yyyymmdd');

insert overwrite table ${dwa_risk}.dwa_risk_dz_model_final_26_lending_costs_detail_df partition (ds='${bizdate}')
select  model_data.*
       ,his_adv_repay_fee_max
       ,d90_adv_repay_fee_max
       ,d180_adv_repay_fee_max
       ,d360_adv_repay_fee_max
       ,d720_adv_repay_fee_max
       ,d1080_adv_repay_fee_max
       ,his_adv_repay_fee_sum
       ,d90_adv_repay_fee_sum
       ,d180_adv_repay_fee_sum
       ,d360_adv_repay_fee_sum
       ,d720_adv_repay_fee_sum
       ,d1080_adv_repay_fee_sum
       ,his_adv_repay_fee_sum_divide_his_principal_sum
       ,d90_adv_repay_fee_sum_divide_d90_principal_sum
       ,d180_adv_repay_fee_sum_divide_d180_principal_sum
       ,d360_adv_repay_fee_sum_divide_d360_principal_sum
       ,d720_adv_repay_fee_sum_divide_d720_principal_sum
       ,d1080_sum_adv_repay_fee_sum_divide_d1080_principal_sum
       ,his_stddev_adv_repay_fee
       ,d90_stddev_adv_repay_fee
       ,d180_stddev_adv_repay_fee
       ,d360_stddev_adv_repay_fee
       ,d720_stddev_adv_repay_fee
       ,d1080_stddev_adv_repay_fee
       ,his_schedule_pay_penalty_max
       ,d90_schedule_pay_penalty_max
       ,d180_schedule_pay_penalty_max
       ,d360_schedule_pay_penalty_max
       ,d720_schedule_pay_penalty_max
       ,d1080_schedule_pay_penalty_max
       ,his_schedule_pay_penalty_sum
       ,d90_schedule_pay_penalty_sum
       ,d180_schedule_pay_penalty_sum
       ,d360_schedule_pay_penalty_sum
       ,d720_schedule_pay_penalty_sum
       ,d1080_schedule_pay_penalty_sum
       ,his_schedule_pay_penalty_sum_divide_his_principal_sum
       ,d90_schedule_pay_penalty_sum_divide_d90_principal_sum
       ,d180_schedule_pay_penalty_sum_divide_d180_principal_sum
       ,d360_schedule_pay_penalty_sum_divide_d360_principal_sum
       ,d720_schedule_pay_penalty_sum_divide_d720_principal_sum
       ,d1080_sum_schedule_pay_penalty_sum_divide_d1080_principal_sum
       ,his_stddev_schedule_pay_penalty
       ,d90_stddev_schedule_pay_penalty
       ,d180_stddev_schedule_pay_penalty
       ,d360_stddev_schedule_pay_penalty
       ,d720_stddev_schedule_pay_penalty
       ,d1080_stddev_schedule_pay_penalty
       ,his_repaid_interest_fee_max
       ,d90_repaid_interest_fee_max
       ,d180_repaid_interest_fee_max
       ,d360_repaid_interest_fee_max
       ,d720_repaid_interest_fee_max
       ,d1080_repaid_interest_fee_max
       ,his_repaid_interest_fee_sum
       ,d90_repaid_interest_fee_sum
       ,d180_repaid_interest_fee_sum
       ,d360_repaid_interest_fee_sum
       ,d720_repaid_interest_fee_sum
       ,d1080_repaid_interest_fee_sum
       ,his_repaid_interest_fee_sum_divide_his_principal_sum
       ,d90_repaid_interest_fee_sum_divide_d90_principal_sum
       ,d180_repaid_interest_fee_sum_divide_d180_principal_sum
       ,d360_repaid_interest_fee_sum_divide_d360_principal_sum
       ,d720_repaid_interest_fee_sum_divide_d720_principal_sum
       ,d1080_sum_repaid_interest_fee_sum_divide_d1080_principal_sum
       ,his_repaid_interest_fee_stddev
       ,d90_repaid_interest_fee_stddev
       ,d180_repaid_interest_fee_stddev
       ,d360_repaid_interest_fee_stddev
       ,d720_repaid_interest_fee_stddev
       ,d1080_repaid_interest_fee_stddev
       ,his_pending_repay_interest_fee_max
       ,d90_pending_repay_interest_fee_max
       ,d180_pending_repay_interest_fee_max
       ,d360_pending_repay_interest_fee_max
       ,d720_pending_repay_interest_fee_max
       ,d1080_pending_repay_interest_fee_max
       ,his_pending_repay_interest_fee_sum
       ,d90_pending_repay_interest_fee_sum
       ,d180_pending_repay_interest_fee_sum
       ,d360_pending_repay_interest_fee_sum
       ,d720_pending_repay_interest_fee_sum
       ,d1080_pending_repay_interest_fee_sum
       ,his_pending_repay_interest_fee_sum_divide_his_principal_sum
       ,d90_pending_repay_interest_fee_sum_divide_d90_principal_sum
       ,d180_pending_repay_interest_fee_sum_divide_d180_principal_sum
       ,d360_pending_repay_interest_fee_sum_divide_d360_principal_sum
       ,d720_pending_repay_interest_fee_sum_divide_d720_principal_sum
       ,d1080_sum_pending_repay_interest_fee_sum_divide_d1080_principal_sum
       ,his_pending_repay_interest_fee_stddev
       ,d90_pending_repay_interest_fee_stddev
       ,d180_pending_repay_interest_fee_stddev
       ,d360_pending_repay_interest_fee_stddev
       ,d720_pending_repay_interest_fee_stddev
       ,d1080_pending_repay_interest_fee_stddev
       ,ftr_pending_repay_interest_fee_max
       ,ftr_pending_repay_interest_fee_sum
       ,ftr_pending_repay_interest_fee_sum_divide_ftr_principal_sum
       ,ftr_pending_repay_interest_fee_stddev
       ,tot_pending_repay_interest_fee_max
       ,tot_pending_repay_interest_fee_sum
       ,tot_pending_repay_interest_fee_sum_divide_ftr_principal_sum
       ,tot_pending_repay_interest_fee_stddev
       ,his_repaid_gurantee_fee_max
       ,d90_repaid_gurantee_fee_max
       ,d180_repaid_gurantee_fee_max
       ,d360_repaid_gurantee_fee_max
       ,d720_repaid_gurantee_fee_max
       ,d1080_repaid_gurantee_fee_max
       ,his_repaid_gurantee_fee_sum
       ,d90_repaid_gurantee_fee_sum
       ,d180_repaid_gurantee_fee_sum
       ,d360_repaid_gurantee_fee_sum
       ,d720_repaid_gurantee_fee_sum
       ,d1080_repaid_gurantee_fee_sum
       ,his_repaid_gurantee_fee_sum_divide_his_principal_sum
       ,d90_repaid_gurantee_fee_sum_divide_d90_principal_sum
       ,d180_repaid_gurantee_fee_sum_divide_d180_principal_sum
       ,d360_repaid_gurantee_fee_sum_divide_d360_principal_sum
       ,d720_repaid_gurantee_fee_sum_divide_d720_principal_sum
       ,d1080_sum_repaid_gurantee_fee_sum_divide_d1080_principal_sum
       ,his_repaid_gurantee_fee_stddev
       ,d90_repaid_gurantee_fee_stddev
       ,d180_repaid_gurantee_fee_stddev
       ,d360_repaid_gurantee_fee_stddev
       ,d720_repaid_gurantee_fee_stddev
       ,d1080_repaid_gurantee_fee_stddev
       ,his_pending_repay_gurantee_fee_max
       ,d90_pending_repay_gurantee_fee_max
       ,d180_pending_repay_gurantee_fee_max
       ,d360_pending_repay_gurantee_fee_max
       ,d720_pending_repay_gurantee_fee_max
       ,d1080_pending_repay_gurantee_fee_max
       ,his_pending_repay_gurantee_fee_sum
       ,d90_pending_repay_gurantee_fee_sum
       ,d180_pending_repay_gurantee_fee_sum
       ,d360_pending_repay_gurantee_fee_sum
       ,d720_pending_repay_gurantee_fee_sum
       ,d1080_pending_repay_gurantee_fee_sum
       ,his_pending_repay_gurantee_fee_sum_divide_his_principal_sum
       ,d90_pending_repay_gurantee_fee_sum_divide_d90_principal_sum
       ,d180_pending_repay_gurantee_fee_sum_divide_d180_principal_sum
       ,d360_pending_repay_gurantee_fee_sum_divide_d360_principal_sum
       ,d720_pending_repay_gurantee_fee_sum_divide_d720_principal_sum
       ,d1080_sum_pending_repay_gurantee_fee_sum_divide_d1080_principal_sum
       ,his_pending_repay_gurantee_fee_stddev
       ,d90_pending_repay_gurantee_fee_stddev
       ,d180_pending_repay_gurantee_fee_stddev
       ,d360_pending_repay_gurantee_fee_stddev
       ,d720_pending_repay_gurantee_fee_stddev
       ,d1080_pending_repay_gurantee_fee_stddev
       ,ftr_pending_repay_gurantee_fee_max
       ,ftr_pending_repay_gurantee_fee_sum
       ,ftr_pending_repay_gurantee_fee_sum_divide_ftr_principal_sum
       ,ftr_pending_repay_gurantee_fee_stddev
       ,tot_pending_repay_gurantee_fee_max
       ,tot_pending_repay_gurantee_fee_sum
       ,tot_pending_repay_gurantee_fee_sum_divide_ftr_principal_sum
       ,tot_pending_repay_gurantee_fee_stddev
       ,his_repaid_tot_fee_max
       ,d90_repaid_tot_fee_max
       ,d180_repaid_tot_fee_max
       ,d360_repaid_tot_fee_max
       ,d720_repaid_tot_fee_max
       ,d1080_repaid_tot_fee_max
       ,his_repaid_tot_fee_sum
       ,d90_repaid_tot_fee_sum
       ,d180_repaid_tot_fee_sum
       ,d360_repaid_tot_fee_sum
       ,d720_repaid_tot_fee_sum
       ,d1080_repaid_tot_fee_sum
       ,his_repaid_tot_fee_stddev
       ,d90_repaid_tot_fee_stddev
       ,d180_repaid_tot_fee_stddev
       ,d360_repaid_tot_fee_stddev
       ,d720_repaid_tot_fee_stddev
       ,d1080_repaid_tot_fee_stddev
       ,his_pending_repay_tot_fee_max
       ,d90_pending_repay_tot_fee_max
       ,d180_pending_repay_tot_fee_max
       ,d360_pending_repay_tot_fee_max
       ,d720_pending_repay_tot_fee_max
       ,d1080_pending_repay_tot_fee_max
       ,his_pending_repay_tot_fee_sum
       ,d90_pending_repay_tot_fee_sum
       ,d180_pending_repay_tot_fee_sum
       ,d360_pending_repay_tot_fee_sum
       ,d720_pending_repay_tot_fee_sum
       ,d1080_pending_repay_tot_fee_sum
       ,his_pending_repay_tot_fee_stddev
       ,d90_pending_repay_tot_fee_stddev
       ,d180_pending_repay_tot_fee_stddev
       ,d360_pending_repay_tot_fee_stddev
       ,d720_pending_repay_tot_fee_stddev
       ,d1080_pending_repay_tot_fee_stddev
       ,ftr_pending_repay_tot_fee_max
       ,ftr_pending_repay_tot_fee_sum
       ,ftr_pending_repay_tot_fee_stddev
       ,tot_pending_repay_tot_fee_max
       ,tot_pending_repay_tot_fee_sum
       ,tot_pending_repay_tot_fee_stddev
       ,his_repaid_exclude_principal_fee_max
       ,d90_repaid_exclude_principal_fee_max
       ,d180_repaid_exclude_principal_fee_max
       ,d360_repaid_exclude_principal_fee_max
       ,d720_repaid_exclude_principal_fee_max
       ,d1080_repaid_exclude_principal_fee_max
       ,his_repaid_exclude_principal_fee_sum
       ,d90_repaid_exclude_principal_fee_sum
       ,d180_repaid_exclude_principal_fee_sum
       ,d360_repaid_exclude_principal_fee_sum
       ,d720_repaid_exclude_principal_fee_sum
       ,d1080_repaid_exclude_principal_fee_sum
       ,his_repaid_exclude_principal_fee_stddev
       ,d90_repaid_exclude_principal_fee_stddev
       ,d180_repaid_exclude_principal_fee_stddev
       ,d360_repaid_exclude_principal_fee_stddev
       ,d720_repaid_exclude_principal_fee_stddev
       ,d1080_repaid_exclude_principal_fee_stddev
       ,his_pending_repay_exclude_principal_fee_max
       ,d90_pending_repay_exclude_principal_fee_max
       ,d180_pending_repay_exclude_principal_fee_max
       ,d360_pending_repay_exclude_principal_fee_max
       ,d720_pending_repay_exclude_principal_fee_max
       ,d1080_pending_repay_exclude_principal_fee_max
       ,his_pending_repay_exclude_principal_fee_sum
       ,d90_pending_repay_exclude_principal_fee_sum
       ,d180_pending_repay_exclude_principal_fee_sum
       ,d360_pending_repay_exclude_principal_fee_sum
       ,d720_pending_repay_exclude_principal_fee_sum
       ,d1080_pending_repay_exclude_principal_fee_sum
       ,his_pending_repay_exclude_principal_fee_stddev
       ,d90_pending_repay_exclude_principal_fee_stddev
       ,d180_pending_repay_exclude_principal_fee_stddev
       ,d360_pending_repay_exclude_principal_fee_stddev
       ,d720_pending_repay_exclude_principal_fee_stddev
       ,d1080_pending_repay_exclude_principal_fee_stddev
       ,ftr_pending_repay_exclude_principal_fee_max
       ,ftr_pending_repay_exclude_principal_fee_sum
       ,ftr_pending_repay_exclude_principal_fee_stddev
       ,tot_pending_repay_exclude_principal_fee_max
       ,tot_pending_repay_exclude_principal_fee_sum
       ,tot_pending_repay_exclude_principal_fee_stddev
from    (
            select  uid
                   ,date_add(to_date('${bizdate}' , 'yyyymmdd') , 1) as mdl_dte
            from    dwa_risk.dwa_risk_f_dz_model_data_base
        ) model_data
left join dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_adv_ovd_fee_tmp a
on      model_data.uid = a.uid
and     model_data.mdl_dte = a.mdl_dte
left join dwa_risk_dev.dwa_risk_dz_model_lending_costs_detail_interest_guarantee_totamt_tmp b
on      model_data.uid = b.uid
and     model_data.mdl_dte = b.mdl_dte;
-- feature-copilot:node-end ordinal=0
