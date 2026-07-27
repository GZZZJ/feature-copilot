-- feature-copilot:node-begin ordinal=0
-- table_name: dwa_risk_tnd_feature_di
-- node_id: n_5327116210050105344
-- task_name: dwa_risk_dz_tongdun_bbdt_feture_di
-- owner_name: 周志华
-- source_json: goal/dp_table_logic/dwa_risk_first_upstream/dwa_risk_tnd_feature_di.json
-- source_json_sha256: 3b6ed5feeb1eb1efb70373dd3131b706b780ce1a3948bc841fc313bcaca6052f
-- upstream_table: dp_ods_credit_sec_views.ods_loan_oss_lattebank_creditdata_incr_prod_platform_detail_platform_detail_di
-- upstream_table: dwa_risk.dwa_risk_tnd_risk_feature1
-- upstream_table: dwa_risk.dwa_risk_tnd_risk_ratio

--MaxCompute_SQL
--********************************************************************--
--所属主题: 数据属于哪个数据域或业务场景下---如交易域、运营数据报表
--功能描述: 数据记录的描述，如数据是什么、统计粒度等
--创建者: 裴阳
--创建日期: 2023-11-29 17:06:28
--修改日期	修改人	修改内容
--yyyymmdd	name	comment
--********************************************************************--
-- drop table if exists dwa_risk.dwa_risk_tnd_feature_di;
-- create table if not exists dwa_risk.dwa_risk_tnd_feature_di ( uid string, created_at string,  tnd_rsk_itm_max_ptf_cnt string, tnd_rsk_itm_one_yer_ptf_apl string, tnd_rsk_itm_one_mth_ptf_apl string, tnd_rsk_itm_thr_mth_ptf_apl string, tnd_rsk_itm_six_mth_ptf_apl string, tnd_rsk_itm_one_wek_ptf_apl string, tnd_rsk_itm_d7_gen_ist_ptf string, tnd_rsk_itm_d7_big_dat_fin string, tnd_rsk_itm_d7_ptt_lon_cmp string, tnd_rsk_itm_d7_p2p string, tnd_rsk_itm_d7_big_csm_fin_cmp string, tnd_rsk_itm_d7_crd_ctr string, tnd_rsk_itm_d7_fin_net string, tnd_rsk_itm_d7_com_ecm_ptf string, tnd_rsk_itm_d7_psn_bnk string, tnd_rsk_itm_d7_bnk_sml_lon string, tnd_rsk_itm_d7_o2o string, tnd_rsk_itm_d7_onl_bnk string, tnd_rsk_itm_d7_car_mnu_fin string, tnd_rsk_itm_d7_drt_sel_bnk string, tnd_rsk_itm_d7_rtl_bnk string, tnd_rsk_itm_d7_ppt_ins string, tnd_rsk_itm_d7_fin_les string, tnd_rsk_itm_d7_eqp_les string, tnd_rsk_itm_d7_thd_pty_svc_pvd string, tnd_rsk_itm_d7_hse_les string, tnd_rsk_itm_d7_grt string, tnd_rsk_itm_d7_fin_itt string, tnd_rsk_itm_d7_car_les string, tnd_rsk_itm_d7_inf_agt string, tnd_rsk_itm_d7_thd_pty_pay string, tnd_rsk_itm_d7_rel_est_fin string, tnd_rsk_itm_d7_vtc_ecm_ptf string, tnd_rsk_itm_d7_trp_les string, tnd_rsk_itm_m1_gen_ist_ptf string, tnd_rsk_itm_m1_big_dat_fin string, tnd_rsk_itm_m1_ptt_lon_cmp string, tnd_rsk_itm_m1_p2p string, tnd_rsk_itm_m1_big_csm_fin_cmp string, tnd_rsk_itm_m1_crd_ctr string, tnd_rsk_itm_m1_fin_net string, tnd_rsk_itm_m1_com_ecm_ptf string, tnd_rsk_itm_m1_psn_bnk string, tnd_rsk_itm_m1_bnk_sml_lon string, tnd_rsk_itm_m1_o2o string, tnd_rsk_itm_m1_onl_bnk string, tnd_rsk_itm_m1_car_mnu_fin string, tnd_rsk_itm_m1_drt_sel_bnk string, tnd_rsk_itm_m1_rtl_bnk string, tnd_rsk_itm_m1_ppt_ins string, tnd_rsk_itm_m1_fin_les string, tnd_rsk_itm_m1_eqp_les string, tnd_rsk_itm_m1_thd_pty_svc_pvd string, tnd_rsk_itm_m1_hse_les string, tnd_rsk_itm_m1_grt string, tnd_rsk_itm_m1_fin_itt string, tnd_rsk_itm_m1_car_les string, tnd_rsk_itm_m1_inf_agt string, tnd_rsk_itm_m1_thd_pty_pay string, tnd_rsk_itm_m1_rel_est_fin string, tnd_rsk_itm_m1_vtc_ecm_ptf string, tnd_rsk_itm_m1_trp_les string, tnd_rsk_itm_m3_gen_ist_ptf string, tnd_rsk_itm_m3_big_dat_fin string, tnd_rsk_itm_m3_ptt_lon_cmp string, tnd_rsk_itm_m3_p2p string, tnd_rsk_itm_m3_big_csm_fin_cmp string, tnd_rsk_itm_m3_crd_ctr string, tnd_rsk_itm_m3_fin_net string, tnd_rsk_itm_m3_com_ecm_ptf string, tnd_rsk_itm_m3_psn_bnk string, tnd_rsk_itm_m3_bnk_sml_lon string, tnd_rsk_itm_m3_o2o string, tnd_rsk_itm_m3_onl_bnk string, tnd_rsk_itm_m3_car_mnu_fin string, tnd_rsk_itm_m3_drt_sel_bnk string, tnd_rsk_itm_m3_rtl_bnk string, tnd_rsk_itm_m3_ppt_ins string, tnd_rsk_itm_m3_fin_les string, tnd_rsk_itm_m3_eqp_les string, tnd_rsk_itm_m3_thd_pty_svc_pvd string, tnd_rsk_itm_m3_hse_les string, tnd_rsk_itm_m3_grt string, tnd_rsk_itm_m3_fin_itt string, tnd_rsk_itm_m3_car_les string, tnd_rsk_itm_m3_inf_agt string, tnd_rsk_itm_m3_thd_pty_pay string, tnd_rsk_itm_m3_rel_est_fin string, tnd_rsk_itm_m3_vtc_ecm_ptf string, tnd_rsk_itm_m3_trp_les string, tnd_rsk_itm_m6_gen_ist_ptf string, tnd_rsk_itm_m6_big_dat_fin string, tnd_rsk_itm_m6_ptt_lon_cmp string, tnd_rsk_itm_m6_p2p string, tnd_rsk_itm_m6_big_csm_fin_cmp string, tnd_rsk_itm_m6_crd_ctr string, tnd_rsk_itm_m6_fin_net string, tnd_rsk_itm_m6_com_ecm_ptf string, tnd_rsk_itm_m6_psn_bnk string, tnd_rsk_itm_m6_bnk_sml_lon string, tnd_rsk_itm_m6_o2o string, tnd_rsk_itm_m6_onl_bnk string, tnd_rsk_itm_m6_car_mnu_fin string, tnd_rsk_itm_m6_drt_sel_bnk string, tnd_rsk_itm_m6_rtl_bnk string, tnd_rsk_itm_m6_ppt_ins string, tnd_rsk_itm_m6_fin_les string, tnd_rsk_itm_m6_eqp_les string, tnd_rsk_itm_m6_thd_pty_svc_pvd string, tnd_rsk_itm_m6_hse_les string, tnd_rsk_itm_m6_grt string, tnd_rsk_itm_m6_fin_itt string, tnd_rsk_itm_m6_car_les string, tnd_rsk_itm_m6_inf_agt string, tnd_rsk_itm_m6_thd_pty_pay string, tnd_rsk_itm_m6_rel_est_fin string, tnd_rsk_itm_m6_vtc_ecm_ptf string, tnd_rsk_itm_m6_trp_les string, tnd_rsk_itm_m12_gen_ist_ptf string, tnd_rsk_itm_m12_big_dat_fin string, tnd_rsk_itm_m12_ptt_lon_cmp string, tnd_rsk_itm_m12_p2p string, tnd_rsk_itm_m12_big_csm_fin_cmp string, tnd_rsk_itm_m12_crd_ctr string, tnd_rsk_itm_m12_fin_net string, tnd_rsk_itm_m12_com_ecm_ptf string, tnd_rsk_itm_m12_psn_bnk string, tnd_rsk_itm_m12_bnk_sml_lon string, tnd_rsk_itm_m12_o2o string, tnd_rsk_itm_m12_onl_bnk string, tnd_rsk_itm_m12_car_mnu_fin string, tnd_rsk_itm_m12_drt_sel_bnk string, tnd_rsk_itm_m12_rtl_bnk string, tnd_rsk_itm_m12_ppt_ins string, tnd_rsk_itm_m12_fin_les string, tnd_rsk_itm_m12_eqp_les string, tnd_rsk_itm_m12_thd_pty_svc_pvd string, tnd_rsk_itm_m12_hse_les string, tnd_rsk_itm_m12_grt string, tnd_rsk_itm_m12_fin_itt string, tnd_rsk_itm_m12_car_les string, tnd_rsk_itm_m12_inf_agt string, tnd_rsk_itm_m12_thd_pty_pay string, tnd_rsk_itm_m12_rel_est_fin string, tnd_rsk_itm_m12_vtc_ecm_ptf string, tnd_rsk_itm_m12_trp_les string, tnd_rsk_itm_d7_typ bigint, tnd_rsk_itm_m1_typ bigint, tnd_rsk_itm_m3_typ bigint, tnd_rsk_itm_m6_typ bigint, tnd_rsk_itm_m12_typ bigint, tnd_rsk_itm_7d_div_1m float, tnd_rsk_itm_7d_div_3m float, tnd_rsk_itm_7d_div_6m float, tnd_rsk_itm_7d_div_12m float, tnd_rsk_itm_1m_div_3m float, tnd_rsk_itm_1m_div_6m float, tnd_rsk_itm_1m_div_12m float, tnd_rsk_itm_3m_div_6m float, tnd_rsk_itm_3m_div_12m float, tnd_rsk_itm_6m_div_12m float, tnd_rsk_itm_1m_dif_7d float, tnd_rsk_itm_3m_dif_1m float, tnd_rsk_itm_6m_dif_3m float, tnd_rsk_itm_12m_dif_6m float, tnd_rsk_itm_d7_les float, tnd_rsk_itm_d7_bnk float, tnd_rsk_itm_d7_csm float, tnd_rsk_itm_d7_ecm_ptf float, tnd_rsk_itm_d7_ptt_lon float, tnd_rsk_itm_d7_oth float, tnd_rsk_itm_m1_les float, tnd_rsk_itm_m1_bnk float, tnd_rsk_itm_m1_csm float, tnd_rsk_itm_m1_ecm_ptf float, tnd_rsk_itm_m1_ptt_lon float, tnd_rsk_itm_m1_oth float, tnd_rsk_itm_m3_les float, tnd_rsk_itm_m3_bnk float, tnd_rsk_itm_m3_csm float, tnd_rsk_itm_m3_ecm_ptf float, tnd_rsk_itm_m3_ptt_lon float, tnd_rsk_itm_m3_oth float, tnd_rsk_itm_m6_les float, tnd_rsk_itm_m6_bnk float, tnd_rsk_itm_m6_csm float, tnd_rsk_itm_m6_ecm_ptf float, tnd_rsk_itm_m6_ptt_lon float, tnd_rsk_itm_m6_oth float, tnd_rsk_itm_m12_les float, tnd_rsk_itm_m12_bnk float, tnd_rsk_itm_m12_csm float, tnd_rsk_itm_m12_ecm_ptf float, tnd_rsk_itm_m12_ptt_lon float, tnd_rsk_itm_m12_oth float, tnd_rsk_itm_d7_les_rat float, tnd_rsk_itm_d7_bnk_rat float, tnd_rsk_itm_d7_csm_rat float, tnd_rsk_itm_d7_car_rat float, tnd_rsk_itm_d7_ecm_ptf_rat float, tnd_rsk_itm_d7_ptt_lon_rat float, tnd_rsk_itm_d7_oth_rat float, tnd_rsk_itm_m1_les_rat float, tnd_rsk_itm_m1_bnk_rat float, tnd_rsk_itm_m1_csm_rat float, tnd_rsk_itm_m1_car_rat float, tnd_rsk_itm_m1_ecm_ptf_rat float, tnd_rsk_itm_m1_ptt_lon_rat float, tnd_rsk_itm_m1_oth_rat float, tnd_rsk_itm_m3_les_rat float, tnd_rsk_itm_m3_bnk_rat float, tnd_rsk_itm_m3_csm_rat float, tnd_rsk_itm_m3_car_rat float, tnd_rsk_itm_m3_ecm_ptf_rat float, tnd_rsk_itm_m3_ptt_lon_rat float, tnd_rsk_itm_m3_oth_rat float, tnd_rsk_itm_m6_les_rat float, tnd_rsk_itm_m6_bnk_rat float, tnd_rsk_itm_m6_csm_rat float, tnd_rsk_itm_m6_car_rat float, tnd_rsk_itm_m6_ecm_ptf_rat float, tnd_rsk_itm_m6_ptt_lon_rat float, tnd_rsk_itm_m6_oth_rat float, tnd_rsk_itm_m12_les_rat float, tnd_rsk_itm_m12_bnk_rat float, tnd_rsk_itm_m12_csm_rat float, tnd_rsk_itm_m12_car_rat float, tnd_rsk_itm_m12_ecm_ptf_rat float, tnd_rsk_itm_m12_ptt_lon_rat float, tnd_rsk_itm_m12_oth_rat float, tnd_rsk_itm_typ_7d_div_m12 float, tnd_rsk_itm_typ_m1_div_m12 float, tnd_rsk_itm_typ_m3_div_m12 float, tnd_rsk_itm_typ_m6_div_m12 float, tnd_rsk_itm_typ_d7_div_m6 float, tnd_rsk_itm_typ_m1_div_m6 float, tnd_rsk_itm_typ_m3_div_m6 float, tnd_rsk_itm_typ_d7_div_m3 float, tnd_rsk_itm_typ_m1_div_m3 float, tnd_rsk_itm_typ_d7_div_m1 float )comment '贷中同盾保镖多头_特征表'
-- partitioned by (
--     ds string
-- );


-- 同盾多头
drop table if exists ${dwa_risk}.dwa_risk_tnd_risk_feature1;
create table if not exists ${dwa_risk}.dwa_risk_tnd_risk_feature1 as
select uid,substr(created_at,1,10) as created_at,ds
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' then platform_count else 0 end) as tnd_rsk_itm_one_yer_ptf_apl
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' then platform_count else 0 end) as tnd_rsk_itm_one_mth_ptf_apl
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' then platform_count else 0 end) as tnd_rsk_itm_thr_mth_ptf_apl
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' then platform_count else 0 end) as tnd_rsk_itm_six_mth_ptf_apl
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' then platform_count else 0 end) as tnd_rsk_itm_one_wek_ptf_apl
      ,max(platform_count) as tnd_rsk_itm_max_ptf_cnt
      ,count(case when risk_name = '7天内申请人在多个平台申请借款' then industry_display_name else null end) as tnd_rsk_itm_d7_typ
      ,count(case when risk_name = '1个月内申请人在多个平台申请借款' then industry_display_name else null end) as tnd_rsk_itm_m1_typ
      ,count(case when risk_name = '3个月内申请人在多个平台申请借款' then industry_display_name else null end) as tnd_rsk_itm_m3_typ
      ,count(case when risk_name = '6个月内申请人在多个平台申请借款' then industry_display_name else null end) as tnd_rsk_itm_m6_typ
      ,count(case when risk_name = '12个月内申请人在多个平台申请借款' then industry_display_name else null end) as tnd_rsk_itm_m12_typ
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='一般消费分期平台'  then count else 0 end) as    tnd_rsk_itm_d7_gen_ist_ptf
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='大数据金融'  then count else 0 end)  as tnd_rsk_itm_d7_big_dat_fin
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='小额贷款公司'  then count else 0 end)    as  tnd_rsk_itm_d7_ptt_lon_cmp
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='P2P网贷'  then count else 0 end)    as   tnd_rsk_itm_d7_p2p
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='大型消费金融公司'  then count else 0 end) as    tnd_rsk_itm_d7_big_csm_fin_cmp
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='信用卡中心'  then count else 0 end)  as tnd_rsk_itm_d7_crd_ctr
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='互联网金融门户'  then count else 0 end)  as   tnd_rsk_itm_d7_fin_net
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='综合类电商平台'  then count else 0 end)  as   tnd_rsk_itm_d7_com_ecm_ptf
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='银行个人业务'  then count else 0 end)    as  tnd_rsk_itm_d7_psn_bnk
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='银行小微贷款'  then count else 0 end)    as  tnd_rsk_itm_d7_bnk_sml_lon
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='O2O'  then count else 0 end)      as   tnd_rsk_itm_d7_o2o
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='网上银行'  then count else 0 end)   as tnd_rsk_itm_d7_onl_bnk
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='厂商汽车金融'  then count else 0 end)    as  tnd_rsk_itm_d7_car_mnu_fin
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='直销银行'  then count else 0 end)   as tnd_rsk_itm_d7_drt_sel_bnk
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='银行消费金融公司'  then count else 0 end) as    tnd_rsk_itm_d7_rtl_bnk
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='财产保险'  then count else 0 end)   as tnd_rsk_itm_d7_ppt_ins
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='融资租赁'  then count else 0 end)   as tnd_rsk_itm_d7_fin_les
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='设备租赁'  then count else 0 end)   as tnd_rsk_itm_d7_eqp_les
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='第三方服务商'  then count else 0 end)    as  tnd_rsk_itm_d7_thd_pty_svc_pvd
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='房屋租赁'  then count else 0 end)   as tnd_rsk_itm_d7_hse_les
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='担保'  then count else 0 end)     as tnd_rsk_itm_d7_grt
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='理财机构'  then count else 0 end)   as tnd_rsk_itm_d7_fin_itt
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='汽车租赁'  then count else 0 end)   as tnd_rsk_itm_d7_car_les
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='信息中介'  then count else 0 end)   as tnd_rsk_itm_d7_inf_agt
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='第三方支付'  then count else 0 end)  as tnd_rsk_itm_d7_thd_pty_pay
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='房地产金融'  then count else 0 end)  as tnd_rsk_itm_d7_rel_est_fin
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='垂直类电商平台'  then count else 0 end)  as   tnd_rsk_itm_d7_vtc_ecm_ptf
      ,max(case when risk_name = '7天内申请人在多个平台申请借款' and industry_display_name='交通工具租赁'  then count else 0 end)    as  tnd_rsk_itm_d7_trp_les
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='一般消费分期平台'  then count else 0 end) as    tnd_rsk_itm_m1_gen_ist_ptf
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='大数据金融'  then count else 0 end)  as tnd_rsk_itm_m1_big_dat_fin
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='小额贷款公司'  then count else 0 end)    as  tnd_rsk_itm_m1_ptt_lon_cmp
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='P2P网贷'  then count else 0 end)    as   tnd_rsk_itm_m1_p2p
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='大型消费金融公司'  then count else 0 end) as    tnd_rsk_itm_m1_big_csm_fin_cmp
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='信用卡中心'  then count else 0 end)  as tnd_rsk_itm_m1_crd_ctr
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='互联网金融门户'  then count else 0 end)  as   tnd_rsk_itm_m1_fin_net
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='综合类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m1_com_ecm_ptf
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='银行个人业务'  then count else 0 end)    as  tnd_rsk_itm_m1_psn_bnk
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='银行小微贷款'  then count else 0 end)    as  tnd_rsk_itm_m1_bnk_sml_lon
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='O2O'  then count else 0 end)      as   tnd_rsk_itm_m1_o2o
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='网上银行'  then count else 0 end)   as tnd_rsk_itm_m1_onl_bnk
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='厂商汽车金融'  then count else 0 end)    as  tnd_rsk_itm_m1_car_mnu_fin
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='直销银行'  then count else 0 end)   as tnd_rsk_itm_m1_drt_sel_bnk
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='银行消费金融公司'  then count else 0 end) as    tnd_rsk_itm_m1_rtl_bnk
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='财产保险'  then count else 0 end)   as tnd_rsk_itm_m1_ppt_ins
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='融资租赁'  then count else 0 end)   as tnd_rsk_itm_m1_fin_les
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='设备租赁'  then count else 0 end)   as tnd_rsk_itm_m1_eqp_les
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='第三方服务商'  then count else 0 end)    as  tnd_rsk_itm_m1_thd_pty_svc_pvd
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='房屋租赁'  then count else 0 end)   as tnd_rsk_itm_m1_hse_les
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='担保'  then count else 0 end)     as tnd_rsk_itm_m1_grt
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='理财机构'  then count else 0 end)   as tnd_rsk_itm_m1_fin_itt
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='汽车租赁'  then count else 0 end)   as tnd_rsk_itm_m1_car_les
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='信息中介'  then count else 0 end)   as tnd_rsk_itm_m1_inf_agt
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='第三方支付'  then count else 0 end)  as tnd_rsk_itm_m1_thd_pty_pay
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='房地产金融'  then count else 0 end)  as tnd_rsk_itm_m1_rel_est_fin
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='垂直类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m1_vtc_ecm_ptf
      ,max(case when risk_name = '1个月内申请人在多个平台申请借款' and industry_display_name='交通工具租赁'  then count else 0 end)    as  tnd_rsk_itm_m1_trp_les
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='一般消费分期平台'  then count else 0 end) as    tnd_rsk_itm_m3_gen_ist_ptf
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='大数据金融'  then count else 0 end)  as tnd_rsk_itm_m3_big_dat_fin
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='小额贷款公司'  then count else 0 end)    as  tnd_rsk_itm_m3_ptt_lon_cmp
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='P2P网贷'  then count else 0 end)    as   tnd_rsk_itm_m3_p2p
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='大型消费金融公司'  then count else 0 end) as    tnd_rsk_itm_m3_big_csm_fin_cmp
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='信用卡中心'  then count else 0 end)  as tnd_rsk_itm_m3_crd_ctr
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='互联网金融门户'  then count else 0 end)  as   tnd_rsk_itm_m3_fin_net
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='综合类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m3_com_ecm_ptf
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='银行个人业务'  then count else 0 end)    as  tnd_rsk_itm_m3_psn_bnk
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='银行小微贷款'  then count else 0 end)    as  tnd_rsk_itm_m3_bnk_sml_lon
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='O2O'  then count else 0 end)      as   tnd_rsk_itm_m3_o2o
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='网上银行'  then count else 0 end)   as tnd_rsk_itm_m3_onl_bnk
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='厂商汽车金融'  then count else 0 end)    as  tnd_rsk_itm_m3_car_mnu_fin
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='直销银行'  then count else 0 end)   as tnd_rsk_itm_m3_drt_sel_bnk
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='银行消费金融公司'  then count else 0 end) as    tnd_rsk_itm_m3_rtl_bnk
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='财产保险'  then count else 0 end)   as tnd_rsk_itm_m3_ppt_ins
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='融资租赁'  then count else 0 end)   as tnd_rsk_itm_m3_fin_les
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='设备租赁'  then count else 0 end)   as tnd_rsk_itm_m3_eqp_les
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='第三方服务商'  then count else 0 end)    as  tnd_rsk_itm_m3_thd_pty_svc_pvd
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='房屋租赁'  then count else 0 end)   as tnd_rsk_itm_m3_hse_les
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='担保'  then count else 0 end)     as tnd_rsk_itm_m3_grt
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='理财机构'  then count else 0 end)   as tnd_rsk_itm_m3_fin_itt
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='汽车租赁'  then count else 0 end)   as tnd_rsk_itm_m3_car_les
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='信息中介'  then count else 0 end)   as tnd_rsk_itm_m3_inf_agt
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='第三方支付'  then count else 0 end)  as tnd_rsk_itm_m3_thd_pty_pay
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='房地产金融'  then count else 0 end)  as tnd_rsk_itm_m3_rel_est_fin
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='垂直类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m3_vtc_ecm_ptf
      ,max(case when risk_name = '3个月内申请人在多个平台申请借款' and industry_display_name='交通工具租赁'  then count else 0 end)    as  tnd_rsk_itm_m3_trp_les
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='一般消费分期平台'  then count else 0 end) as    tnd_rsk_itm_m6_gen_ist_ptf
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='大数据金融'  then count else 0 end)  as tnd_rsk_itm_m6_big_dat_fin
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='小额贷款公司'  then count else 0 end)    as  tnd_rsk_itm_m6_ptt_lon_cmp
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='P2P网贷'  then count else 0 end)    as   tnd_rsk_itm_m6_p2p
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='大型消费金融公司'  then count else 0 end) as    tnd_rsk_itm_m6_big_csm_fin_cmp
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='信用卡中心'  then count else 0 end)  as tnd_rsk_itm_m6_crd_ctr
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='互联网金融门户'  then count else 0 end)  as   tnd_rsk_itm_m6_fin_net
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='综合类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m6_com_ecm_ptf
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='银行个人业务'  then count else 0 end)    as  tnd_rsk_itm_m6_psn_bnk
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='银行小微贷款'  then count else 0 end)    as  tnd_rsk_itm_m6_bnk_sml_lon
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='O2O'  then count else 0 end)      as   tnd_rsk_itm_m6_o2o
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='网上银行'  then count else 0 end)   as tnd_rsk_itm_m6_onl_bnk
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='厂商汽车金融'  then count else 0 end)    as  tnd_rsk_itm_m6_car_mnu_fin
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='直销银行'  then count else 0 end)   as tnd_rsk_itm_m6_drt_sel_bnk
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='银行消费金融公司'  then count else 0 end) as    tnd_rsk_itm_m6_rtl_bnk
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='财产保险'  then count else 0 end)   as tnd_rsk_itm_m6_ppt_ins
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='融资租赁'  then count else 0 end)   as tnd_rsk_itm_m6_fin_les
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='设备租赁'  then count else 0 end)   as tnd_rsk_itm_m6_eqp_les
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='第三方服务商'  then count else 0 end)    as  tnd_rsk_itm_m6_thd_pty_svc_pvd
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='房屋租赁'  then count else 0 end)   as tnd_rsk_itm_m6_hse_les
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='担保'  then count else 0 end)     as tnd_rsk_itm_m6_grt
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='理财机构'  then count else 0 end)   as tnd_rsk_itm_m6_fin_itt
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='汽车租赁'  then count else 0 end)   as tnd_rsk_itm_m6_car_les
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='信息中介'  then count else 0 end)   as tnd_rsk_itm_m6_inf_agt
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='第三方支付'  then count else 0 end)  as tnd_rsk_itm_m6_thd_pty_pay
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='房地产金融'  then count else 0 end)  as tnd_rsk_itm_m6_rel_est_fin
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='垂直类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m6_vtc_ecm_ptf
      ,max(case when risk_name = '6个月内申请人在多个平台申请借款' and industry_display_name='交通工具租赁'  then count else 0 end)    as  tnd_rsk_itm_m6_trp_les
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='一般消费分期平台'  then count else 0 end) as    tnd_rsk_itm_m12_gen_ist_ptf
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='大数据金融'  then count else 0 end)  as tnd_rsk_itm_m12_big_dat_fin
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='小额贷款公司'  then count else 0 end)    as  tnd_rsk_itm_m12_ptt_lon_cmp
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='P2P网贷'  then count else 0 end)    as   tnd_rsk_itm_m12_p2p
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='大型消费金融公司'  then count else 0 end) as  tnd_rsk_itm_m12_big_csm_fin_cmp
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='信用卡中心'  then count else 0 end)  as tnd_rsk_itm_m12_crd_ctr
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='互联网金融门户'  then count else 0 end)  as   tnd_rsk_itm_m12_fin_net
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='综合类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m12_com_ecm_ptf
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='银行个人业务'  then count else 0 end)    as  tnd_rsk_itm_m12_psn_bnk
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='银行小微贷款'  then count else 0 end)    as  tnd_rsk_itm_m12_bnk_sml_lon
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='O2O'  then count else 0 end)      as   tnd_rsk_itm_m12_o2o
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='网上银行'  then count else 0 end)   as tnd_rsk_itm_m12_onl_bnk
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='厂商汽车金融'  then count else 0 end)    as  tnd_rsk_itm_m12_car_mnu_fin
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='直销银行'  then count else 0 end)   as tnd_rsk_itm_m12_drt_sel_bnk
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='银行消费金融公司'  then count else 0 end) as    tnd_rsk_itm_m12_rtl_bnk
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='财产保险'  then count else 0 end)   as tnd_rsk_itm_m12_ppt_ins
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='融资租赁'  then count else 0 end)   as tnd_rsk_itm_m12_fin_les
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='设备租赁'  then count else 0 end)   as tnd_rsk_itm_m12_eqp_les
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='第三方服务商'  then count else 0 end)    as  tnd_rsk_itm_m12_thd_pty_svc_pvd
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='房屋租赁'  then count else 0 end)   as tnd_rsk_itm_m12_hse_les
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='担保'  then count else 0 end)     as tnd_rsk_itm_m12_grt
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='理财机构'  then count else 0 end)   as tnd_rsk_itm_m12_fin_itt
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='汽车租赁'  then count else 0 end)   as tnd_rsk_itm_m12_car_les
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='信息中介'  then count else 0 end)   as tnd_rsk_itm_m12_inf_agt
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='第三方支付'  then count else 0 end)  as tnd_rsk_itm_m12_thd_pty_pay
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='房地产金融'  then count else 0 end)  as tnd_rsk_itm_m12_rel_est_fin
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='垂直类电商平台'  then count else 0 end)  as   tnd_rsk_itm_m12_vtc_ecm_ptf
      ,max(case when risk_name = '12个月内申请人在多个平台申请借款' and industry_display_name='交通工具租赁'  then count else 0 end)    as  tnd_rsk_itm_m12_trp_les
 from  dp_ods_credit_sec_views.ods_loan_oss_lattebank_creditdata_incr_prod_platform_detail_platform_detail_di
 --${dp_ods_credit_sec_views}.ods_loan_oss_lattebank_creditcore_incr_prod_ptbgi_platform_detail_platform_detail_s1_di
where ds = '${bizdate}'
      and uid is not null 
      and uid <> 'NULL' 
      and uid <> ''
      and table_from='PD'
group by uid,substr(created_at,1,10) ,ds;



-- 计算比率合并中间表(第一部分)
drop table if exists ${dwa_risk}.dwa_risk_tnd_risk_ratio;
create table ${dwa_risk}.dwa_risk_tnd_risk_ratio as
select  uid
       ,created_at
       ,ds
       ,tnd_rsk_itm_max_ptf_cnt
       ,tnd_rsk_itm_one_yer_ptf_apl
       ,tnd_rsk_itm_one_mth_ptf_apl
       ,tnd_rsk_itm_thr_mth_ptf_apl
      ,tnd_rsk_itm_six_mth_ptf_apl
      ,tnd_rsk_itm_one_wek_ptf_apl
      ,tnd_rsk_itm_d7_gen_ist_ptf
      ,tnd_rsk_itm_d7_big_dat_fin
      ,tnd_rsk_itm_d7_ptt_lon_cmp
      ,tnd_rsk_itm_d7_p2p
      ,tnd_rsk_itm_d7_big_csm_fin_cmp
      ,tnd_rsk_itm_d7_crd_ctr
      ,tnd_rsk_itm_d7_fin_net
      ,tnd_rsk_itm_d7_com_ecm_ptf
      ,tnd_rsk_itm_d7_psn_bnk
      ,tnd_rsk_itm_d7_bnk_sml_lon
      ,tnd_rsk_itm_d7_o2o
      ,tnd_rsk_itm_d7_onl_bnk
      ,tnd_rsk_itm_d7_car_mnu_fin
      ,tnd_rsk_itm_d7_drt_sel_bnk
      ,tnd_rsk_itm_d7_rtl_bnk
      ,tnd_rsk_itm_d7_ppt_ins
      ,tnd_rsk_itm_d7_fin_les
      ,tnd_rsk_itm_d7_eqp_les
      ,tnd_rsk_itm_d7_thd_pty_svc_pvd
      ,tnd_rsk_itm_d7_hse_les
      ,tnd_rsk_itm_d7_grt
      ,tnd_rsk_itm_d7_fin_itt
      ,tnd_rsk_itm_d7_car_les
      ,tnd_rsk_itm_d7_inf_agt
      ,tnd_rsk_itm_d7_thd_pty_pay
      ,tnd_rsk_itm_d7_rel_est_fin
      ,tnd_rsk_itm_d7_vtc_ecm_ptf
      ,tnd_rsk_itm_d7_trp_les
      ,tnd_rsk_itm_m1_gen_ist_ptf
      ,tnd_rsk_itm_m1_big_dat_fin
      ,tnd_rsk_itm_m1_ptt_lon_cmp
      ,tnd_rsk_itm_m1_p2p
      ,tnd_rsk_itm_m1_big_csm_fin_cmp
      ,tnd_rsk_itm_m1_crd_ctr
      ,tnd_rsk_itm_m1_fin_net
      ,tnd_rsk_itm_m1_com_ecm_ptf
      ,tnd_rsk_itm_m1_psn_bnk
      ,tnd_rsk_itm_m1_bnk_sml_lon
      ,tnd_rsk_itm_m1_o2o
      ,tnd_rsk_itm_m1_onl_bnk
      ,tnd_rsk_itm_m1_car_mnu_fin
      ,tnd_rsk_itm_m1_drt_sel_bnk
      ,tnd_rsk_itm_m1_rtl_bnk
      ,tnd_rsk_itm_m1_ppt_ins
      ,tnd_rsk_itm_m1_fin_les
      ,tnd_rsk_itm_m1_eqp_les
      ,tnd_rsk_itm_m1_thd_pty_svc_pvd
      ,tnd_rsk_itm_m1_hse_les
      ,tnd_rsk_itm_m1_grt
      ,tnd_rsk_itm_m1_fin_itt
      ,tnd_rsk_itm_m1_car_les
      ,tnd_rsk_itm_m1_inf_agt
      ,tnd_rsk_itm_m1_thd_pty_pay
      ,tnd_rsk_itm_m1_rel_est_fin
      ,tnd_rsk_itm_m1_vtc_ecm_ptf
      ,tnd_rsk_itm_m1_trp_les
      ,tnd_rsk_itm_m3_gen_ist_ptf
      ,tnd_rsk_itm_m3_big_dat_fin
      ,tnd_rsk_itm_m3_ptt_lon_cmp
      ,tnd_rsk_itm_m3_p2p
      ,tnd_rsk_itm_m3_big_csm_fin_cmp
      ,tnd_rsk_itm_m3_crd_ctr
      ,tnd_rsk_itm_m3_fin_net
      ,tnd_rsk_itm_m3_com_ecm_ptf
      ,tnd_rsk_itm_m3_psn_bnk
      ,tnd_rsk_itm_m3_bnk_sml_lon
      ,tnd_rsk_itm_m3_o2o
      ,tnd_rsk_itm_m3_onl_bnk
      ,tnd_rsk_itm_m3_car_mnu_fin
      ,tnd_rsk_itm_m3_drt_sel_bnk
      ,tnd_rsk_itm_m3_rtl_bnk
      ,tnd_rsk_itm_m3_ppt_ins
      ,tnd_rsk_itm_m3_fin_les
      ,tnd_rsk_itm_m3_eqp_les
      ,tnd_rsk_itm_m3_thd_pty_svc_pvd
      ,tnd_rsk_itm_m3_hse_les
      ,tnd_rsk_itm_m3_grt
      ,tnd_rsk_itm_m3_fin_itt
      ,tnd_rsk_itm_m3_car_les
      ,tnd_rsk_itm_m3_inf_agt
      ,tnd_rsk_itm_m3_thd_pty_pay
      ,tnd_rsk_itm_m3_rel_est_fin
      ,tnd_rsk_itm_m3_vtc_ecm_ptf
      ,tnd_rsk_itm_m3_trp_les
      ,tnd_rsk_itm_m6_gen_ist_ptf
      ,tnd_rsk_itm_m6_big_dat_fin
      ,tnd_rsk_itm_m6_ptt_lon_cmp
      ,tnd_rsk_itm_m6_p2p
      ,tnd_rsk_itm_m6_big_csm_fin_cmp
      ,tnd_rsk_itm_m6_crd_ctr
      ,tnd_rsk_itm_m6_fin_net
      ,tnd_rsk_itm_m6_com_ecm_ptf
      ,tnd_rsk_itm_m6_psn_bnk
      ,tnd_rsk_itm_m6_bnk_sml_lon
      ,tnd_rsk_itm_m6_o2o
      ,tnd_rsk_itm_m6_onl_bnk
      ,tnd_rsk_itm_m6_car_mnu_fin
      ,tnd_rsk_itm_m6_drt_sel_bnk
      ,tnd_rsk_itm_m6_rtl_bnk
      ,tnd_rsk_itm_m6_ppt_ins
      ,tnd_rsk_itm_m6_fin_les
      ,tnd_rsk_itm_m6_eqp_les
      ,tnd_rsk_itm_m6_thd_pty_svc_pvd
      ,tnd_rsk_itm_m6_hse_les
      ,tnd_rsk_itm_m6_grt
      ,tnd_rsk_itm_m6_fin_itt
      ,tnd_rsk_itm_m6_car_les
      ,tnd_rsk_itm_m6_inf_agt
      ,tnd_rsk_itm_m6_thd_pty_pay
      ,tnd_rsk_itm_m6_rel_est_fin
      ,tnd_rsk_itm_m6_vtc_ecm_ptf
      ,tnd_rsk_itm_m6_trp_les
      ,tnd_rsk_itm_m12_gen_ist_ptf
      ,tnd_rsk_itm_m12_big_dat_fin
      ,tnd_rsk_itm_m12_ptt_lon_cmp
      ,tnd_rsk_itm_m12_p2p
      ,tnd_rsk_itm_m12_big_csm_fin_cmp
      ,tnd_rsk_itm_m12_crd_ctr
      ,tnd_rsk_itm_m12_fin_net
      ,tnd_rsk_itm_m12_com_ecm_ptf
      ,tnd_rsk_itm_m12_psn_bnk
      ,tnd_rsk_itm_m12_bnk_sml_lon
      ,tnd_rsk_itm_m12_o2o
      ,tnd_rsk_itm_m12_onl_bnk
      ,tnd_rsk_itm_m12_car_mnu_fin
      ,tnd_rsk_itm_m12_drt_sel_bnk
      ,tnd_rsk_itm_m12_rtl_bnk
      ,tnd_rsk_itm_m12_ppt_ins
      ,tnd_rsk_itm_m12_fin_les
      ,tnd_rsk_itm_m12_eqp_les
      ,tnd_rsk_itm_m12_thd_pty_svc_pvd
      ,tnd_rsk_itm_m12_hse_les
      ,tnd_rsk_itm_m12_grt
      ,tnd_rsk_itm_m12_fin_itt
      ,tnd_rsk_itm_m12_car_les
      ,tnd_rsk_itm_m12_inf_agt
      ,tnd_rsk_itm_m12_thd_pty_pay
      ,tnd_rsk_itm_m12_rel_est_fin
      ,tnd_rsk_itm_m12_vtc_ecm_ptf
      ,tnd_rsk_itm_m12_trp_les
      ,tnd_rsk_itm_d7_typ
      ,tnd_rsk_itm_m1_typ
      ,tnd_rsk_itm_m3_typ
      ,tnd_rsk_itm_m6_typ
      ,tnd_rsk_itm_m12_typ
      ,case when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_one_mth_ptf_apl is null then -998
            when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_one_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_one_wek_ptf_apl is not null and tnd_rsk_itm_one_mth_ptf_apl is not null then tnd_rsk_itm_one_wek_ptf_apl / tnd_rsk_itm_one_mth_ptf_apl
            else -999 end as tnd_rsk_itm_7d_div_1m
      ,case when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_thr_mth_ptf_apl is null then -998
            when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_thr_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_one_wek_ptf_apl is not null and tnd_rsk_itm_thr_mth_ptf_apl is not null then tnd_rsk_itm_one_wek_ptf_apl / tnd_rsk_itm_thr_mth_ptf_apl
            else -999 end as tnd_rsk_itm_7d_div_3m
      ,case when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is null then -998
            when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_one_wek_ptf_apl is not null and tnd_rsk_itm_six_mth_ptf_apl is not null then tnd_rsk_itm_one_wek_ptf_apl / tnd_rsk_itm_six_mth_ptf_apl
            else -999 end as tnd_rsk_itm_7d_div_6m
      ,case when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is null then -998
            when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is not null then -997
            when tnd_rsk_itm_one_wek_ptf_apl is not null and tnd_rsk_itm_one_yer_ptf_apl is not null then tnd_rsk_itm_one_wek_ptf_apl / tnd_rsk_itm_one_yer_ptf_apl
            else -999 end as tnd_rsk_itm_7d_div_12m
      ,case when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_thr_mth_ptf_apl is null then -998
            when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_thr_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_one_mth_ptf_apl is not null and tnd_rsk_itm_thr_mth_ptf_apl is not null then tnd_rsk_itm_one_mth_ptf_apl / tnd_rsk_itm_thr_mth_ptf_apl
            else -999 end as tnd_rsk_itm_1m_div_3m
      ,case when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is null then -998
            when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_one_mth_ptf_apl is not null and tnd_rsk_itm_six_mth_ptf_apl is not null then tnd_rsk_itm_one_mth_ptf_apl / tnd_rsk_itm_six_mth_ptf_apl
            else -999 end as tnd_rsk_itm_1m_div_6m
      ,case when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is null then -998
            when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is not null then -997
            when tnd_rsk_itm_one_mth_ptf_apl is not null and tnd_rsk_itm_one_yer_ptf_apl is not null then tnd_rsk_itm_one_mth_ptf_apl / tnd_rsk_itm_one_yer_ptf_apl
            else -999 end as tnd_rsk_itm_1m_div_12m
      ,case when tnd_rsk_itm_thr_mth_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is null then -998
            when tnd_rsk_itm_thr_mth_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_thr_mth_ptf_apl is not null and tnd_rsk_itm_six_mth_ptf_apl is not null then tnd_rsk_itm_thr_mth_ptf_apl / tnd_rsk_itm_six_mth_ptf_apl
            else -999 end as tnd_rsk_itm_3m_div_6m
      ,case when tnd_rsk_itm_thr_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is null then -998
            when tnd_rsk_itm_thr_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is not null then -997
            when tnd_rsk_itm_thr_mth_ptf_apl is not null and tnd_rsk_itm_one_yer_ptf_apl is not null then tnd_rsk_itm_thr_mth_ptf_apl / tnd_rsk_itm_one_yer_ptf_apl
            else -999 end as tnd_rsk_itm_3m_div_12m
      ,case when tnd_rsk_itm_six_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is null then -998
            when tnd_rsk_itm_six_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is not null then -997
            when tnd_rsk_itm_six_mth_ptf_apl is not null and tnd_rsk_itm_one_yer_ptf_apl is not null then tnd_rsk_itm_six_mth_ptf_apl / tnd_rsk_itm_one_yer_ptf_apl
            else -999 end as tnd_rsk_itm_6m_div_12m
      ,case when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_one_mth_ptf_apl is null then -998
            when tnd_rsk_itm_one_wek_ptf_apl is null and tnd_rsk_itm_one_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_one_mth_ptf_apl is not null and tnd_rsk_itm_one_wek_ptf_apl is not null then tnd_rsk_itm_one_mth_ptf_apl - tnd_rsk_itm_one_wek_ptf_apl
            else -999 end as tnd_rsk_itm_1m_dif_7d
      ,case when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_thr_mth_ptf_apl is null then -998
            when tnd_rsk_itm_one_mth_ptf_apl is null and tnd_rsk_itm_thr_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_thr_mth_ptf_apl is not null and tnd_rsk_itm_one_mth_ptf_apl is not null then tnd_rsk_itm_thr_mth_ptf_apl - tnd_rsk_itm_one_mth_ptf_apl
            else -999 end as tnd_rsk_itm_3m_dif_1m
      ,case when tnd_rsk_itm_thr_mth_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is null then -998
            when tnd_rsk_itm_thr_mth_ptf_apl is null and tnd_rsk_itm_six_mth_ptf_apl is not null then -997
            when tnd_rsk_itm_six_mth_ptf_apl is not null and tnd_rsk_itm_thr_mth_ptf_apl is not null then tnd_rsk_itm_six_mth_ptf_apl - tnd_rsk_itm_thr_mth_ptf_apl
            else -999 end as tnd_rsk_itm_6m_dif_3m
      ,case when tnd_rsk_itm_six_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is null then -998
            when tnd_rsk_itm_six_mth_ptf_apl is null and tnd_rsk_itm_one_yer_ptf_apl is not null then -997
            when tnd_rsk_itm_one_yer_ptf_apl is not null and tnd_rsk_itm_six_mth_ptf_apl is not null then tnd_rsk_itm_one_yer_ptf_apl - tnd_rsk_itm_six_mth_ptf_apl
            else -999 end as tnd_rsk_itm_12m_dif_6m
      ,(nvl(tnd_rsk_itm_d7_car_les,0) + nvl(tnd_rsk_itm_d7_trp_les,0) + nvl(tnd_rsk_itm_d7_eqp_les,0) + nvl(tnd_rsk_itm_d7_fin_les,0) + nvl(tnd_rsk_itm_d7_hse_les,0)) as tnd_rsk_itm_d7_les
      ,(nvl(tnd_rsk_itm_d7_drt_sel_bnk,0) + nvl(tnd_rsk_itm_d7_psn_bnk,0) + nvl(tnd_rsk_itm_d7_bnk_sml_lon,0) + nvl(tnd_rsk_itm_d7_onl_bnk,0) + nvl(tnd_rsk_itm_d7_crd_ctr,0)) as tnd_rsk_itm_d7_bnk
      ,(nvl(tnd_rsk_itm_d7_big_csm_fin_cmp,0) + nvl(tnd_rsk_itm_d7_rtl_bnk,0)) as tnd_rsk_itm_d7_csm
      ,(nvl(tnd_rsk_itm_d7_com_ecm_ptf,0) + nvl(tnd_rsk_itm_d7_vtc_ecm_ptf,0)) as tnd_rsk_itm_d7_ecm_ptf
      ,(nvl(tnd_rsk_itm_d7_ptt_lon_cmp,0) + nvl(tnd_rsk_itm_d7_p2p,0)) as tnd_rsk_itm_d7_ptt_lon
      ,(nvl(tnd_rsk_itm_d7_gen_ist_ptf,0) + nvl(tnd_rsk_itm_d7_o2o,0) + nvl(tnd_rsk_itm_d7_rel_est_fin,0) + nvl(tnd_rsk_itm_d7_thd_pty_svc_pvd,0) + nvl(tnd_rsk_itm_d7_inf_agt,0) + nvl(tnd_rsk_itm_d7_fin_net,0) + nvl(tnd_rsk_itm_d7_big_dat_fin,0)) as tnd_rsk_itm_d7_oth
      ,(nvl(tnd_rsk_itm_m1_car_les,0) + nvl(tnd_rsk_itm_m1_trp_les,0) + nvl(tnd_rsk_itm_m1_eqp_les,0) + nvl(tnd_rsk_itm_m1_fin_les,0) + nvl(tnd_rsk_itm_m1_hse_les,0)) as tnd_rsk_itm_m1_les
      ,(nvl(tnd_rsk_itm_m1_drt_sel_bnk,0) + nvl(tnd_rsk_itm_m1_psn_bnk,0) + nvl(tnd_rsk_itm_m1_bnk_sml_lon,0) + nvl(tnd_rsk_itm_m1_onl_bnk,0) + nvl(tnd_rsk_itm_m1_crd_ctr,0)) as tnd_rsk_itm_m1_bnk
      ,(nvl(tnd_rsk_itm_m1_big_csm_fin_cmp,0) + nvl(tnd_rsk_itm_m1_rtl_bnk,0)) as tnd_rsk_itm_m1_csm
      ,(nvl(tnd_rsk_itm_m1_com_ecm_ptf,0) + nvl(tnd_rsk_itm_m1_vtc_ecm_ptf,0)) as tnd_rsk_itm_m1_ecm_ptf
      ,(nvl(tnd_rsk_itm_m1_ptt_lon_cmp,0) + nvl(tnd_rsk_itm_m1_p2p,0)) as tnd_rsk_itm_m1_ptt_lon
      ,(nvl(tnd_rsk_itm_m1_gen_ist_ptf,0) + nvl(tnd_rsk_itm_m1_o2o,0) + nvl(tnd_rsk_itm_m1_rel_est_fin,0) + nvl(tnd_rsk_itm_m1_thd_pty_svc_pvd,0) + nvl(tnd_rsk_itm_m1_inf_agt,0) + nvl(tnd_rsk_itm_m1_fin_net,0) + nvl(tnd_rsk_itm_m1_big_dat_fin,0)) as tnd_rsk_itm_m1_oth
      ,(nvl(tnd_rsk_itm_m3_car_les,0) + nvl(tnd_rsk_itm_m3_trp_les,0) + nvl(tnd_rsk_itm_m3_eqp_les,0) + nvl(tnd_rsk_itm_m3_fin_les,0) + nvl(tnd_rsk_itm_m3_hse_les,0)) as tnd_rsk_itm_m3_les
      ,(nvl(tnd_rsk_itm_m3_drt_sel_bnk,0) + nvl(tnd_rsk_itm_m3_psn_bnk,0) + nvl(tnd_rsk_itm_m3_bnk_sml_lon,0) + nvl(tnd_rsk_itm_m3_onl_bnk,0) + nvl(tnd_rsk_itm_m3_crd_ctr,0)) as tnd_rsk_itm_m3_bnk
      ,(nvl(tnd_rsk_itm_m3_big_csm_fin_cmp,0) + nvl(tnd_rsk_itm_m3_rtl_bnk,0)) as tnd_rsk_itm_m3_csm
      ,(nvl(tnd_rsk_itm_m3_com_ecm_ptf,0) + nvl(tnd_rsk_itm_m3_vtc_ecm_ptf,0)) as tnd_rsk_itm_m3_ecm_ptf
      ,(nvl(tnd_rsk_itm_m3_ptt_lon_cmp,0) + nvl(tnd_rsk_itm_m3_p2p,0)) as tnd_rsk_itm_m3_ptt_lon
      ,(nvl(tnd_rsk_itm_m3_gen_ist_ptf,0) + nvl(tnd_rsk_itm_m3_o2o,0) + nvl(tnd_rsk_itm_m3_rel_est_fin,0) + nvl(tnd_rsk_itm_m3_thd_pty_svc_pvd,0) + nvl(tnd_rsk_itm_m3_inf_agt,0) + nvl(tnd_rsk_itm_m3_fin_net,0) + nvl(tnd_rsk_itm_m3_big_dat_fin,0)) as tnd_rsk_itm_m3_oth
      ,(nvl(tnd_rsk_itm_m6_car_les,0) + nvl(tnd_rsk_itm_m6_trp_les,0) + nvl(tnd_rsk_itm_m6_eqp_les,0) + nvl(tnd_rsk_itm_m6_fin_les,0) + nvl(tnd_rsk_itm_m6_hse_les,0)) as tnd_rsk_itm_m6_les
      ,(nvl(tnd_rsk_itm_m6_drt_sel_bnk,0) + nvl(tnd_rsk_itm_m6_psn_bnk,0) + nvl(tnd_rsk_itm_m6_bnk_sml_lon,0) + nvl(tnd_rsk_itm_m6_onl_bnk,0) + nvl(tnd_rsk_itm_m6_crd_ctr,0)) as tnd_rsk_itm_m6_bnk
      ,(nvl(tnd_rsk_itm_m6_big_csm_fin_cmp,0) + nvl(tnd_rsk_itm_m6_rtl_bnk,0)) as tnd_rsk_itm_m6_csm
      ,(nvl(tnd_rsk_itm_m6_com_ecm_ptf,0) + nvl(tnd_rsk_itm_m6_vtc_ecm_ptf,0)) as tnd_rsk_itm_m6_ecm_ptf
      ,(nvl(tnd_rsk_itm_m6_ptt_lon_cmp,0) + nvl(tnd_rsk_itm_m6_p2p,0)) as tnd_rsk_itm_m6_ptt_lon
      ,(nvl(tnd_rsk_itm_m6_gen_ist_ptf,0) + nvl(tnd_rsk_itm_m6_o2o,0) + nvl(tnd_rsk_itm_m6_rel_est_fin,0) + nvl(tnd_rsk_itm_m6_thd_pty_svc_pvd,0) + nvl(tnd_rsk_itm_m6_inf_agt,0) + nvl(tnd_rsk_itm_m6_fin_net,0) + nvl(tnd_rsk_itm_m6_big_dat_fin,0)) as tnd_rsk_itm_m6_oth
      ,(nvl(tnd_rsk_itm_m12_car_les,0) + nvl(tnd_rsk_itm_m12_trp_les,0) + nvl(tnd_rsk_itm_m12_eqp_les,0) + nvl(tnd_rsk_itm_m12_fin_les,0) + nvl(tnd_rsk_itm_m12_hse_les,0)) as tnd_rsk_itm_m12_les
      ,(nvl(tnd_rsk_itm_m12_drt_sel_bnk,0) + nvl(tnd_rsk_itm_m12_psn_bnk,0) + nvl(tnd_rsk_itm_m12_bnk_sml_lon,0) + nvl(tnd_rsk_itm_m12_onl_bnk,0) + nvl(tnd_rsk_itm_m12_crd_ctr,0)) as tnd_rsk_itm_m12_bnk
      ,(nvl(tnd_rsk_itm_m12_big_csm_fin_cmp,0) + nvl(tnd_rsk_itm_m12_rtl_bnk,0)) as tnd_rsk_itm_m12_csm
      ,(nvl(tnd_rsk_itm_m12_com_ecm_ptf,0) + nvl(tnd_rsk_itm_m12_vtc_ecm_ptf,0)) as tnd_rsk_itm_m12_ecm_ptf
      ,(nvl(tnd_rsk_itm_m12_ptt_lon_cmp,0) + nvl(tnd_rsk_itm_m12_p2p,0)) as tnd_rsk_itm_m12_ptt_lon
      ,(nvl(tnd_rsk_itm_m12_gen_ist_ptf,0) + nvl(tnd_rsk_itm_m12_o2o,0) + nvl(tnd_rsk_itm_m12_rel_est_fin,0) + nvl(tnd_rsk_itm_m12_thd_pty_svc_pvd,0) + nvl(tnd_rsk_itm_m12_inf_agt,0) + nvl(tnd_rsk_itm_m12_fin_net,0) + nvl(tnd_rsk_itm_m12_big_dat_fin,0)) as tnd_rsk_itm_m12_oth
from  ${dwa_risk}.dwa_risk_tnd_risk_feature1 
;


-- 计算比率合并第一部分（第一部分+第二部分）

insert overwrite table ${dwa_risk}.dwa_risk_tnd_feature_di partition (ds = '${bizdate}')
select uid, created_at, tnd_rsk_itm_max_ptf_cnt, tnd_rsk_itm_one_yer_ptf_apl , tnd_rsk_itm_one_mth_ptf_apl, tnd_rsk_itm_thr_mth_ptf_apl, tnd_rsk_itm_six_mth_ptf_apl, tnd_rsk_itm_one_wek_ptf_apl, tnd_rsk_itm_d7_gen_ist_ptf , tnd_rsk_itm_d7_big_dat_fin, tnd_rsk_itm_d7_ptt_lon_cmp, tnd_rsk_itm_d7_p2p, tnd_rsk_itm_d7_big_csm_fin_cmp, tnd_rsk_itm_d7_crd_ctr , tnd_rsk_itm_d7_fin_net, tnd_rsk_itm_d7_com_ecm_ptf, tnd_rsk_itm_d7_psn_bnk, tnd_rsk_itm_d7_bnk_sml_lon, tnd_rsk_itm_d7_o2o , tnd_rsk_itm_d7_onl_bnk, tnd_rsk_itm_d7_car_mnu_fin, tnd_rsk_itm_d7_drt_sel_bnk, tnd_rsk_itm_d7_rtl_bnk, tnd_rsk_itm_d7_ppt_ins , tnd_rsk_itm_d7_fin_les, tnd_rsk_itm_d7_eqp_les, tnd_rsk_itm_d7_thd_pty_svc_pvd, tnd_rsk_itm_d7_hse_les, tnd_rsk_itm_d7_grt , tnd_rsk_itm_d7_fin_itt, tnd_rsk_itm_d7_car_les, tnd_rsk_itm_d7_inf_agt, tnd_rsk_itm_d7_thd_pty_pay, tnd_rsk_itm_d7_rel_est_fin , tnd_rsk_itm_d7_vtc_ecm_ptf, tnd_rsk_itm_d7_trp_les, tnd_rsk_itm_m1_gen_ist_ptf, tnd_rsk_itm_m1_big_dat_fin, tnd_rsk_itm_m1_ptt_lon_cmp , tnd_rsk_itm_m1_p2p, tnd_rsk_itm_m1_big_csm_fin_cmp, tnd_rsk_itm_m1_crd_ctr, tnd_rsk_itm_m1_fin_net, tnd_rsk_itm_m1_com_ecm_ptf , tnd_rsk_itm_m1_psn_bnk, tnd_rsk_itm_m1_bnk_sml_lon, tnd_rsk_itm_m1_o2o, tnd_rsk_itm_m1_onl_bnk, tnd_rsk_itm_m1_car_mnu_fin , tnd_rsk_itm_m1_drt_sel_bnk, tnd_rsk_itm_m1_rtl_bnk, tnd_rsk_itm_m1_ppt_ins, tnd_rsk_itm_m1_fin_les, tnd_rsk_itm_m1_eqp_les , tnd_rsk_itm_m1_thd_pty_svc_pvd, tnd_rsk_itm_m1_hse_les, tnd_rsk_itm_m1_grt, tnd_rsk_itm_m1_fin_itt, tnd_rsk_itm_m1_car_les , tnd_rsk_itm_m1_inf_agt, tnd_rsk_itm_m1_thd_pty_pay, tnd_rsk_itm_m1_rel_est_fin, tnd_rsk_itm_m1_vtc_ecm_ptf, tnd_rsk_itm_m1_trp_les , tnd_rsk_itm_m3_gen_ist_ptf, tnd_rsk_itm_m3_big_dat_fin, tnd_rsk_itm_m3_ptt_lon_cmp, tnd_rsk_itm_m3_p2p, tnd_rsk_itm_m3_big_csm_fin_cmp , tnd_rsk_itm_m3_crd_ctr, tnd_rsk_itm_m3_fin_net, tnd_rsk_itm_m3_com_ecm_ptf, tnd_rsk_itm_m3_psn_bnk, tnd_rsk_itm_m3_bnk_sml_lon , tnd_rsk_itm_m3_o2o, tnd_rsk_itm_m3_onl_bnk, tnd_rsk_itm_m3_car_mnu_fin, tnd_rsk_itm_m3_drt_sel_bnk, tnd_rsk_itm_m3_rtl_bnk , tnd_rsk_itm_m3_ppt_ins, tnd_rsk_itm_m3_fin_les, tnd_rsk_itm_m3_eqp_les, tnd_rsk_itm_m3_thd_pty_svc_pvd, tnd_rsk_itm_m3_hse_les , tnd_rsk_itm_m3_grt, tnd_rsk_itm_m3_fin_itt, tnd_rsk_itm_m3_car_les, tnd_rsk_itm_m3_inf_agt, tnd_rsk_itm_m3_thd_pty_pay , tnd_rsk_itm_m3_rel_est_fin, tnd_rsk_itm_m3_vtc_ecm_ptf, tnd_rsk_itm_m3_trp_les, tnd_rsk_itm_m6_gen_ist_ptf, tnd_rsk_itm_m6_big_dat_fin , tnd_rsk_itm_m6_ptt_lon_cmp, tnd_rsk_itm_m6_p2p, tnd_rsk_itm_m6_big_csm_fin_cmp, tnd_rsk_itm_m6_crd_ctr, tnd_rsk_itm_m6_fin_net , tnd_rsk_itm_m6_com_ecm_ptf, tnd_rsk_itm_m6_psn_bnk, tnd_rsk_itm_m6_bnk_sml_lon, tnd_rsk_itm_m6_o2o, tnd_rsk_itm_m6_onl_bnk , tnd_rsk_itm_m6_car_mnu_fin, tnd_rsk_itm_m6_drt_sel_bnk, tnd_rsk_itm_m6_rtl_bnk, tnd_rsk_itm_m6_ppt_ins, tnd_rsk_itm_m6_fin_les , tnd_rsk_itm_m6_eqp_les, tnd_rsk_itm_m6_thd_pty_svc_pvd, tnd_rsk_itm_m6_hse_les, tnd_rsk_itm_m6_grt, tnd_rsk_itm_m6_fin_itt , tnd_rsk_itm_m6_car_les, tnd_rsk_itm_m6_inf_agt, tnd_rsk_itm_m6_thd_pty_pay, tnd_rsk_itm_m6_rel_est_fin, tnd_rsk_itm_m6_vtc_ecm_ptf , tnd_rsk_itm_m6_trp_les, tnd_rsk_itm_m12_gen_ist_ptf, tnd_rsk_itm_m12_big_dat_fin, tnd_rsk_itm_m12_ptt_lon_cmp, tnd_rsk_itm_m12_p2p , tnd_rsk_itm_m12_big_csm_fin_cmp, tnd_rsk_itm_m12_crd_ctr, tnd_rsk_itm_m12_fin_net, tnd_rsk_itm_m12_com_ecm_ptf, tnd_rsk_itm_m12_psn_bnk , tnd_rsk_itm_m12_bnk_sml_lon, tnd_rsk_itm_m12_o2o, tnd_rsk_itm_m12_onl_bnk, tnd_rsk_itm_m12_car_mnu_fin, tnd_rsk_itm_m12_drt_sel_bnk , tnd_rsk_itm_m12_rtl_bnk, tnd_rsk_itm_m12_ppt_ins, tnd_rsk_itm_m12_fin_les, tnd_rsk_itm_m12_eqp_les, tnd_rsk_itm_m12_thd_pty_svc_pvd , tnd_rsk_itm_m12_hse_les, tnd_rsk_itm_m12_grt, tnd_rsk_itm_m12_fin_itt, tnd_rsk_itm_m12_car_les, tnd_rsk_itm_m12_inf_agt , tnd_rsk_itm_m12_thd_pty_pay, tnd_rsk_itm_m12_rel_est_fin, tnd_rsk_itm_m12_vtc_ecm_ptf, tnd_rsk_itm_m12_trp_les, tnd_rsk_itm_d7_typ , tnd_rsk_itm_m1_typ, tnd_rsk_itm_m3_typ, tnd_rsk_itm_m6_typ, tnd_rsk_itm_m12_typ, tnd_rsk_itm_7d_div_1m , tnd_rsk_itm_7d_div_3m, tnd_rsk_itm_7d_div_6m, tnd_rsk_itm_7d_div_12m, tnd_rsk_itm_1m_div_3m, tnd_rsk_itm_1m_div_6m , tnd_rsk_itm_1m_div_12m, tnd_rsk_itm_3m_div_6m, tnd_rsk_itm_3m_div_12m, tnd_rsk_itm_6m_div_12m, tnd_rsk_itm_1m_dif_7d , tnd_rsk_itm_3m_dif_1m, tnd_rsk_itm_6m_dif_3m, tnd_rsk_itm_12m_dif_6m, tnd_rsk_itm_d7_les, tnd_rsk_itm_d7_bnk , tnd_rsk_itm_d7_csm, tnd_rsk_itm_d7_ecm_ptf, tnd_rsk_itm_d7_ptt_lon, tnd_rsk_itm_d7_oth, tnd_rsk_itm_m1_les , tnd_rsk_itm_m1_bnk, tnd_rsk_itm_m1_csm, tnd_rsk_itm_m1_ecm_ptf, tnd_rsk_itm_m1_ptt_lon, tnd_rsk_itm_m1_oth , tnd_rsk_itm_m3_les, tnd_rsk_itm_m3_bnk, tnd_rsk_itm_m3_csm, tnd_rsk_itm_m3_ecm_ptf, tnd_rsk_itm_m3_ptt_lon , tnd_rsk_itm_m3_oth, tnd_rsk_itm_m6_les, tnd_rsk_itm_m6_bnk, tnd_rsk_itm_m6_csm, tnd_rsk_itm_m6_ecm_ptf , tnd_rsk_itm_m6_ptt_lon, tnd_rsk_itm_m6_oth, tnd_rsk_itm_m12_les, tnd_rsk_itm_m12_bnk, tnd_rsk_itm_m12_csm , tnd_rsk_itm_m12_ecm_ptf, tnd_rsk_itm_m12_ptt_lon, tnd_rsk_itm_m12_oth
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_d7_les / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_d7_les_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_d7_bnk / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_d7_bnk_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_d7_csm / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_d7_csm_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then nvl(aa.tnd_rsk_itm_d7_car_mnu_fin,0) / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_d7_car_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_d7_ecm_ptf / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_d7_ecm_ptf_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_d7_ptt_lon / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_d7_ptt_lon_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_d7_oth / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_d7_oth_rat

      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m1_les / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m1_les_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m1_bnk / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m1_bnk_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m1_csm / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m1_csm_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then nvl(aa.tnd_rsk_itm_m1_car_mnu_fin,0) / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m1_car_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m1_ecm_ptf / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m1_ecm_ptf_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m1_ptt_lon / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m1_ptt_lon_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m1_oth / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m1_oth_rat

      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m3_les / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m3_les_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m3_bnk / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m3_bnk_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m3_csm / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m3_csm_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then nvl(aa.tnd_rsk_itm_m3_car_mnu_fin,0) / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m3_car_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m3_ecm_ptf / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m3_ecm_ptf_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m3_ptt_lon / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m3_ptt_lon_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m3_oth / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m3_oth_rat

      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m6_les / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m6_les_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m6_bnk / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m6_bnk_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m6_csm / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m6_csm_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then nvl(aa.tnd_rsk_itm_m6_car_mnu_fin,0) / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m6_car_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m6_ecm_ptf / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m6_ecm_ptf_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m6_ptt_lon / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m6_ptt_lon_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m6_oth / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m6_oth_rat

      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m12_les / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m12_les_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m12_bnk / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m12_bnk_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m12_csm / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m12_csm_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then nvl(aa.tnd_rsk_itm_m12_car_mnu_fin,0) / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m12_car_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m12_ecm_ptf / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m12_ecm_ptf_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m12_ptt_lon / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m12_ptt_lon_rat
      ,case when aa.tnd_rsk_itm_max_ptf_cnt is not null then aa.tnd_rsk_itm_m12_oth / aa.tnd_rsk_itm_max_ptf_cnt else null end as tnd_rsk_itm_m12_oth_rat
      ,case when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m12_typ is null then -998
            when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m12_typ is not null then -997
            when tnd_rsk_itm_d7_typ is not null and tnd_rsk_itm_m12_typ is not null then tnd_rsk_itm_d7_typ / tnd_rsk_itm_m12_typ
            else -999 end as tnd_rsk_itm_typ_7d_div_m12
      ,case when tnd_rsk_itm_m1_typ is null and tnd_rsk_itm_m12_typ is null then -998
            when tnd_rsk_itm_m1_typ is null and tnd_rsk_itm_m12_typ is not null then -997
            when tnd_rsk_itm_m1_typ is not null and tnd_rsk_itm_m12_typ is not null then tnd_rsk_itm_m1_typ / tnd_rsk_itm_m12_typ
            else -999 end as tnd_rsk_itm_typ_m1_div_m12
      ,case when tnd_rsk_itm_m3_typ is null and tnd_rsk_itm_m12_typ is null then -998
            when tnd_rsk_itm_m3_typ is null and tnd_rsk_itm_m12_typ is not null then -997
            when tnd_rsk_itm_m3_typ is not null and tnd_rsk_itm_m12_typ is not null then tnd_rsk_itm_m3_typ / tnd_rsk_itm_m12_typ
            else -999 end as tnd_rsk_itm_typ_m3_div_m12
      ,case when tnd_rsk_itm_m6_typ is null and tnd_rsk_itm_m12_typ is null then -998
            when tnd_rsk_itm_m6_typ is null and tnd_rsk_itm_m12_typ is not null then -997
            when tnd_rsk_itm_m6_typ is not null and tnd_rsk_itm_m12_typ is not null then tnd_rsk_itm_m6_typ / tnd_rsk_itm_m12_typ
            else -999 end as tnd_rsk_itm_typ_m6_div_m12
      ,case when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m6_typ is null then -998
            when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m6_typ is not null then -997
            when tnd_rsk_itm_d7_typ is not null and tnd_rsk_itm_m6_typ is not null then tnd_rsk_itm_d7_typ / tnd_rsk_itm_m6_typ
            else -999 end as tnd_rsk_itm_typ_d7_div_m6
      ,case when tnd_rsk_itm_m1_typ is null and tnd_rsk_itm_m6_typ is null then -998
            when tnd_rsk_itm_m1_typ is null and tnd_rsk_itm_m6_typ is not null then -997
            when tnd_rsk_itm_m1_typ is not null and tnd_rsk_itm_m6_typ is not null then tnd_rsk_itm_m1_typ / tnd_rsk_itm_m6_typ
            else -999 end as tnd_rsk_itm_typ_m1_div_m6
      ,case when tnd_rsk_itm_m3_typ is null and tnd_rsk_itm_m6_typ is null then -998
            when tnd_rsk_itm_m3_typ is null and tnd_rsk_itm_m6_typ is not null then -997
            when tnd_rsk_itm_m3_typ is not null and tnd_rsk_itm_m6_typ is not null then tnd_rsk_itm_m3_typ / tnd_rsk_itm_m6_typ
            else -999 end as tnd_rsk_itm_typ_m3_div_m6
      ,case when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m3_typ is null then -998
            when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m3_typ is not null then -997
            when tnd_rsk_itm_d7_typ is not null and tnd_rsk_itm_m3_typ is not null then tnd_rsk_itm_d7_typ / tnd_rsk_itm_m3_typ
            else -999 end as tnd_rsk_itm_typ_d7_div_m3
      ,case when tnd_rsk_itm_m1_typ is null and tnd_rsk_itm_m3_typ is null then -998
            when tnd_rsk_itm_m1_typ is null and tnd_rsk_itm_m3_typ is not null then -997
            when tnd_rsk_itm_m1_typ is not null and tnd_rsk_itm_m3_typ is not null then tnd_rsk_itm_m1_typ / tnd_rsk_itm_m3_typ
            else -999 end as tnd_rsk_itm_typ_m1_div_m3
      ,case when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m1_typ is null then -998
            when tnd_rsk_itm_d7_typ is null and tnd_rsk_itm_m1_typ is not null then -997
            when tnd_rsk_itm_d7_typ is not null and tnd_rsk_itm_m1_typ is not null then tnd_rsk_itm_d7_typ / tnd_rsk_itm_m1_typ
            else -999 end as tnd_rsk_itm_typ_d7_div_m1
from ${dwa_risk}.dwa_risk_tnd_risk_ratio as aa
;





-- -- select *
-- -- from  dp_ods_credit_sec_views.ods_loan_oss_lattebank_creditcore_incr_prod_ptbgi_platform_detail_platform_detail_s1_di
-- -- where ds ='20231214' and uid='86f9f584-1b98-4938-a14c-757c1102a246'
-- -- limit 10


-- select ds,count(1) from 
-- ${dwa_risk}.dwa_risk_tnd_feature_di
-- where ds >='20231213' group by ds
-- feature-copilot:node-end ordinal=0
