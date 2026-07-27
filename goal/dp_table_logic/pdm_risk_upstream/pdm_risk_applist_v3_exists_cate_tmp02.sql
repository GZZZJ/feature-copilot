-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_applist_v3_exists_cate_tmp02
-- node_id: n_4644411813815058432
-- task_name: pdm_risk_applist_exists_category_di_v3
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_applist_v3_exists_cate_tmp02.json
-- source_json_sha256: 64dd38102e876d1b347a86ab3117975c9f4f8c945e0ea509ee96ee37cf9c34a7
-- upstream_table: pdm_risk.pdm_risk_applist_v3_exists_cate_tmp02
-- upstream_table: pdm_risk.pdm_risk_applist_v3_exists_cate_tmp03
-- upstream_table: pdm_risk.pdm_risk_applist_v3_exists_cate_tmp05
-- upstream_table: pdm_risk.pdm_risk_applist_v3_exists_cate_tmp0501
-- upstream_table: pdm_risk.pdm_risk_applist_v3_exists_cate_tmp06
-- upstream_table: pdm_risk.pdm_risk_applist_v3_exists_cate_tmp04
-- upstream_table: pdw_manual.pdw_manual_applist_category_202303_v3
-- upstream_table: ods_pdw_loan.ods_pdw_loan_oss_lattebank_client_collect_applist_di
-- upstream_table: pdm_risk.pdm_risk_applist_v3_exists_cate_tmp01

drop table if exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp01;
create table if not exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp01 as
select uid,
    app_nam_rg,
    cet_tim,
    ds,
    cat1,
    cat2,
    cat3,
    portrait_5features,
    dte_dif_cet_ins
from (
        select cat1,
            cat2,
            cat3,
            portrait_5features,
            app_nam as app_nam_rg
        from pdw_manual.pdw_manual_applist_category_202303_v3
        where app_nam is not null
    ) as t1
    inner join (
        select b.uid,
            b.app_nam,
            b.cet_tim,
            b.ds,
            datediff(to_date(b.cet_tim), date(substr(ins_tim,1,10))) as dte_dif_cet_ins
        from (
                select a.uid,
                    a.app_nam,
                    a.cet_tim,
                    a.ds,
                    a.ins_tim
                from (
                        select uid,
                            app_name as app_nam,
                            created_at as cet_tim,
                            ds,
                            app_install_time as ins_tim,
                            row_number() over(
                                partition by uid,
                                app_name
                                order by app_package_name desc
                            ) as rm
                        from ods_pdw_loan.ods_pdw_loan_oss_lattebank_client_collect_applist_di
                        where ds = '${bizdate}' and substr(app_install_time,1,10)!='2021-09-31' and substr(app_install_time,1,10) !='2021-0007-'
                            and substr(app_install_time,1,10) !='2020-04-31'  and  uid is not null 
                            and uid <>''
                    ) as a
                where a.rm = 1
            ) as b
        where b.ds = '${bizdate}'
            and b.app_nam in (
                select distinct(app_nam)
                from pdw_manual.pdw_manual_applist_category_202303_v3 where app_nam is not null
            )
    ) as t2 on t1.app_nam_rg = t2.app_nam;

drop table if exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp02;
create table ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp02 as
with tmp01 as (select * from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp01)
select a.uid,
    a.ds,
    a.cet_tim,
    a.cat1,
    a.cat2,
    a.cat3,
    a.portrait_5features,
    b.cat_cnt_7d_ago_one,
    c.cat_cnt_1m_ago_one,
    d.cat_cnt_3m_ago_one,
    e.cat_cnt_6m_ago_one,
    f.cat_cnt_one,
    i.cat_cnt_7d_ago_two,
    j.cat_cnt_1m_ago_two,
    k.cat_cnt_3m_ago_two,
    l.cat_cnt_6m_ago_two,
    m.cat_cnt_two,
    p.cat_cnt_7d_ago_three,
    q.cat_cnt_1m_ago_three,
    r.cat_cnt_3m_ago_three,
    s.cat_cnt_6m_ago_three,
    t.cat_cnt_three,
    w.app_total_num,
    x.cat_cnt_portrait
from (select * from tmp01 where app_nam_rg is not null and uid is not null) as a
    left join (
        select uid,
            ds,
            cat1,
            count(1) as cat_cnt_7d_ago_one
        from (
                select uid,
                    ds,
                    cat1
                from tmp01
                where dte_dif_cet_ins between 0 and 7
                    and app_nam_rg is not null and uid is not null
            ) bb
        group by bb.uid,
            bb.ds,
            bb.cat1
    ) as b on a.uid = b.uid
    and a.ds = b.ds
    and a.cat1 = b.cat1
    left join (
        select uid,
            ds,
            cat1,
            count(1) as cat_cnt_1m_ago_one
        from (
                select uid,
                    ds,
                    cat1
                from tmp01
                where dte_dif_cet_ins between 0 and 30
                    and app_nam_rg is not null and uid is not null
            ) cc
        group by cc.uid,
            cc.ds,
            cc.cat1
    ) as c on a.uid = c.uid
    and a.ds = c.ds
    and a.cat1 = c.cat1
    left join (
        select uid,
            ds,
            cat1,
            count(1) as cat_cnt_3m_ago_one
        from (
                select uid,
                    ds,
                    cat1
                from tmp01
                where dte_dif_cet_ins between 0 and 90
                    and app_nam_rg is not null and uid is not null
            ) dd
        group by dd.uid,
            dd.ds,
            dd.cat1
    ) as d on a.uid = d.uid
    and a.ds = d.ds
    and a.cat1 = d.cat1
    left join (
        select uid,
            ds,
            cat1,
            count(1) as cat_cnt_6m_ago_one
        from (
                select uid,
                    ds,
                    cat1
                from tmp01
                where dte_dif_cet_ins between 0 and 180
                    and app_nam_rg is not null and uid is not null
            ) ee
        group by ee.uid,
            ee.ds,
            ee.cat1
    ) as e on a.uid = e.uid
    and a.ds = e.ds
    and a.cat1 = e.cat1
    left join (
        select uid,
            ds,
            cat1,
            count(1) as cat_cnt_one
        from (
                select uid,
                    ds,
                    cat1
                from tmp01
                where app_nam_rg is not null and uid is not null
            ) ff
        group by ff.uid,
            ff.ds,
            ff.cat1
    ) as f on a.uid = f.uid
    and a.ds = f.ds
    and a.cat1 = f.cat1
    left join (
        select uid,
            ds,
            cat2,
            count(1) as cat_cnt_7d_ago_two
        from (
                select uid,
                    ds,
                    cat2
                from tmp01
                where dte_dif_cet_ins between 0 and 7
                    and app_nam_rg is not null and uid is not null
            ) ii
        group by ii.uid,
            ii.ds,
            ii.cat2
    ) as i on a.uid = i.uid
    and a.ds = i.ds
    and a.cat2 = i.cat2
    left join (
        select uid,
            ds,
            cat2,
            count(1) as cat_cnt_1m_ago_two
        from (
                select uid,
                    ds,
                    cat2
                from tmp01
                where dte_dif_cet_ins between 0 and 30
                    and app_nam_rg is not null and uid is not null
            ) jj
        group by jj.uid,
            jj.ds,
            jj.cat2
    ) as j on a.uid = j.uid
    and a.ds = j.ds
    and a.cat2 = j.cat2
    left join (
        select uid,
            ds,
            cat2,
            count(1) as cat_cnt_3m_ago_two
        from (
                select uid,
                    ds,
                    cat2
                from tmp01
                where dte_dif_cet_ins between 0 and 90
                    and app_nam_rg is not null and uid is not null
            ) kk
        group by kk.uid,
            kk.ds,
            kk.cat2
    ) as k on a.uid = k.uid
    and a.ds = k.ds
    and a.cat2 = k.cat2
    left join (
        select uid,
            ds,
            cat2,
            count(1) as cat_cnt_6m_ago_two
        from (
                select uid,
                    ds,
                    cat2
                from tmp01
                where dte_dif_cet_ins between 0 and 180
                    and app_nam_rg is not null and uid is not null
            ) ll
        group by ll.uid,
            ll.ds,
            ll.cat2
    ) as l on a.uid = l.uid
    and a.ds = l.ds
    and a.cat2 = l.cat2
    left join (
        select uid,
            ds,
            cat2,
            count(1) as cat_cnt_two
        from (
                select uid,
                    ds,
                    cat2
                from tmp01
                where app_nam_rg is not null and uid is not null
            ) mm
        group by mm.uid,
            mm.ds,
            mm.cat2
    ) as m on a.uid = m.uid
    and a.ds = m.ds
    and a.cat2 = m.cat2
    left join (
        select uid,
            ds,
            cat3,
            count(1) as cat_cnt_7d_ago_three
        from (
                select uid,
                    ds,
                    cat3
                from tmp01
                where dte_dif_cet_ins between 0 and 7
                    and app_nam_rg is not null and uid is not null
            ) pp
        group by pp.uid,
            pp.ds,
            pp.cat3
    ) as p on a.uid = p.uid
    and a.ds = p.ds
    and a.cat3 = p.cat3
    left join (
        select uid,
            ds,
            cat3,
            count(1) as cat_cnt_1m_ago_three
        from (
                select uid,
                    ds,
                    cat3
                from tmp01
                where dte_dif_cet_ins between 0 and 30
                    and app_nam_rg is not null and uid is not null
            ) qq
        group by qq.uid,
            qq.ds,
            qq.cat3
    ) as q on a.uid = q.uid
    and a.ds = q.ds
    and a.cat3 = q.cat3
    left join (
        select uid,
            ds,
            cat3,
            count(1) as cat_cnt_3m_ago_three
        from (
                select uid,
                    ds,
                    cat3
                from tmp01
                where dte_dif_cet_ins between 0 and 90
                    and app_nam_rg is not null and uid is not null
            ) rr
        group by rr.uid,
            rr.ds,
            rr.cat3
    ) as r on a.uid = r.uid
    and a.ds = r.ds
    and a.cat3 = r.cat3
    left join (
        select uid,
            ds,
            cat3,
            count(1) as cat_cnt_6m_ago_three
        from (
                select uid,
                    ds,
                    cat3
                from tmp01
                where dte_dif_cet_ins between 0 and 180
                    and app_nam_rg is not null and uid is not null
            ) ss
        group by ss.uid,
            ss.ds,
            ss.cat3
    ) as s on a.uid = s.uid
    and a.ds = s.ds
    and a.cat3 = s.cat3
    left join (
        select uid,
            ds,
            cat3,
            count(1) as cat_cnt_three
        from (
                select uid,
                    ds,
                    cat3
                from tmp01
                where app_nam_rg is not null and uid is not null
            ) tt
        group by tt.uid,
            tt.ds,
            tt.cat3
    ) as t on a.uid = t.uid
    and a.ds = t.ds
    and a.cat3 = t.cat3
    left join (
        select uid,
            ds,
            count(app_nam_rg) as app_total_num
        from (
                select uid,
                    ds,
                    app_nam_rg
                from tmp01
                where app_nam_rg is not null and uid is not null
            ) ww
        group by ww.uid,
            ww.ds
    ) as w on a.uid = w.uid
    and a.ds = w.ds
    left join (
        select uid,
            ds,
            portrait_5features,
            count(1) as cat_cnt_portrait
        from (
                select uid,
                    ds,
                    portrait_5features
                from tmp01
                where app_nam_rg is not null and uid is not null
            ) xx
        group by xx.uid,
            xx.ds,
            xx.portrait_5features
    ) as x on a.uid = x.uid
    and a.ds = x.ds
    and a.portrait_5features = x.portrait_5features;

drop table if exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp03;
create table ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp03 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,cat1 order by cat_cnt_one desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp04;
create table ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp04 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,cat2 order by cat_cnt_two desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp05;
create table ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp05 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,cat3 order by cat_cnt_three desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp0501;
create table ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp0501 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,portrait_5features order by cat_cnt_portrait desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp06;
create table ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp06 as
select a.uid, a.ds, a.cet_tim, a.app_total_num from 
(select uid, ds, cet_tim, app_total_num, row_number() over(partition by uid, ds order by app_total_num desc) as rm 
from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp02
) as a 
where a.rm = 1 and uid is not null;


insert OVERWRITE table pdm_risk.pdm_risk_applist_exists_category_di_v3 partition (ds = '${bizdate}')
select a.uid,
a.cet_tim,a.app_total_num,one_WIFI_cat1_cat_cnt,one_WIFI_cat1_cat_cnt_7d_ago,one_WIFI_cat1_cat_cnt_1m_ago,one_WIFI_cat1_cat_cnt_3m_ago,one_WIFI_cat1_cat_cnt_6m_ago,one_gerenzichan_cat_cnt,one_gerenzichan_cat_cnt_7d_ago,one_gerenzichan_cat_cnt_1m_ago,one_gerenzichan_cat_cnt_3m_ago,one_gerenzichan_cat_cnt_6m_ago,one_zhongjieluntanAPP_cat_cnt,one_zhongjieluntanAPP_cat_cnt_7d_ago,one_zhongjieluntanAPP_cat_cnt_1m_ago,one_zhongjieluntanAPP_cat_cnt_3m_ago,one_zhongjieluntanAPP_cat_cnt_6m_ago,one_maifangzufang_cat1_cat_cnt,one_maifangzufang_cat1_cat_cnt_7d_ago,one_maifangzufang_cat1_cat_cnt_1m_ago,one_maifangzufang_cat1_cat_cnt_3m_ago,one_maifangzufang_cat1_cat_cnt_6m_ago,one_qiyebangong_cat_cnt,one_qiyebangong_cat_cnt_7d_ago,one_qiyebangong_cat_cnt_1m_ago,one_qiyebangong_cat_cnt_3m_ago,one_qiyebangong_cat_cnt_6m_ago,one_xiuxian_cat_cnt,one_xiuxian_cat_cnt_7d_ago,one_xiuxian_cat_cnt_1m_ago,one_xiuxian_cat_cnt_3m_ago,one_xiuxian_cat_cnt_6m_ago,one_zuobilei_cat1_cat_cnt,one_zuobilei_cat1_cat_cnt_7d_ago,one_zuobilei_cat1_cat_cnt_1m_ago,one_zuobilei_cat1_cat_cnt_3m_ago,one_zuobilei_cat1_cat_cnt_6m_ago,one_jiedailei_cat_cnt,one_jiedailei_cat_cnt_7d_ago,one_jiedailei_cat_cnt_1m_ago,one_jiedailei_cat_cnt_3m_ago,one_jiedailei_cat_cnt_6m_ago,one_jiankangyiliaoqita_cat_cnt,one_jiankangyiliaoqita_cat_cnt_7d_ago,one_jiankangyiliaoqita_cat_cnt_1m_ago,one_jiankangyiliaoqita_cat_cnt_3m_ago,one_jiankangyiliaoqita_cat_cnt_6m_ago,one_yiliaojiankang_cat_cnt,one_yiliaojiankang_cat_cnt_7d_ago,one_yiliaojiankang_cat_cnt_1m_ago,one_yiliaojiankang_cat_cnt_3m_ago,one_yiliaojiankang_cat_cnt_6m_ago,one_shangcheng_cat_cnt,one_shangcheng_cat_cnt_7d_ago,one_shangcheng_cat_cnt_1m_ago,one_shangcheng_cat_cnt_3m_ago,one_shangcheng_cat_cnt_6m_ago,one_waimai_cat1_cat_cnt,one_waimai_cat1_cat_cnt_7d_ago,one_waimai_cat1_cat_cnt_1m_ago,one_waimai_cat1_cat_cnt_3m_ago,one_waimai_cat1_cat_cnt_6m_ago,one_taoqian_cat_cnt,one_taoqian_cat_cnt_7d_ago,one_taoqian_cat_cnt_1m_ago,one_taoqian_cat_cnt_3m_ago,one_taoqian_cat_cnt_6m_ago,one_shechipin_cat1_cat_cnt,one_shechipin_cat1_cat_cnt_7d_ago,one_shechipin_cat1_cat_cnt_1m_ago,one_shechipin_cat1_cat_cnt_3m_ago,one_shechipin_cat1_cat_cnt_6m_ago,one_xuexigongzuo_cat_cnt,one_xuexigongzuo_cat_cnt_7d_ago,one_xuexigongzuo_cat_cnt_1m_ago,one_xuexigongzuo_cat_cnt_3m_ago,one_xuexigongzuo_cat_cnt_6m_ago,one_shiyonggongju_cat_cnt,one_shiyonggongju_cat_cnt_7d_ago,one_shiyonggongju_cat_cnt_1m_ago,one_shiyonggongju_cat_cnt_3m_ago,one_shiyonggongju_cat_cnt_6m_ago,one_xiaoweiqiyelei_cat1_cat_cnt,one_xiaoweiqiyelei_cat1_cat_cnt_7d_ago,one_xiaoweiqiyelei_cat1_cat_cnt_1m_ago,one_xiaoweiqiyelei_cat1_cat_cnt_3m_ago,one_xiaoweiqiyelei_cat1_cat_cnt_6m_ago,one_gongjulei_cat_cnt,one_gongjulei_cat_cnt_7d_ago,one_gongjulei_cat_cnt_1m_ago,one_gongjulei_cat_cnt_3m_ago,one_gongjulei_cat_cnt_6m_ago,one_yingyinyule_cat_cnt,one_yingyinyule_cat_cnt_7d_ago,one_yingyinyule_cat_cnt_1m_ago,one_yingyinyule_cat_cnt_3m_ago,one_yingyinyule_cat_cnt_6m_ago,one_fangchan_cat_cnt,one_fangchan_cat_cnt_7d_ago,one_fangchan_cat_cnt_1m_ago,one_fangchan_cat_cnt_3m_ago,one_fangchan_cat_cnt_6m_ago,one_luyouchuxing_cat_cnt,one_luyouchuxing_cat_cnt_7d_ago,one_luyouchuxing_cat_cnt_1m_ago,one_luyouchuxing_cat_cnt_3m_ago,one_luyouchuxing_cat_cnt_6m_ago,one_muyingjiaoyu_cat_cnt,one_muyingjiaoyu_cat_cnt_7d_ago,one_muyingjiaoyu_cat_cnt_1m_ago,one_muyingjiaoyu_cat_cnt_3m_ago,one_muyingjiaoyu_cat_cnt_6m_ago,one_qiuzhizhaopin_cat1_cat_cnt,one_qiuzhizhaopin_cat1_cat_cnt_7d_ago,one_qiuzhizhaopin_cat1_cat_cnt_1m_ago,one_qiuzhizhaopin_cat1_cat_cnt_3m_ago,one_qiuzhizhaopin_cat1_cat_cnt_6m_ago,one_qichexiangguan_cat_cnt,one_qichexiangguan_cat_cnt_7d_ago,one_qichexiangguan_cat_cnt_1m_ago,one_qichexiangguan_cat_cnt_3m_ago,one_qichexiangguan_cat_cnt_6m_ago,one_shehuang_cat1_cat_cnt,one_shehuang_cat1_cat_cnt_7d_ago,one_shehuang_cat1_cat_cnt_1m_ago,one_shehuang_cat1_cat_cnt_3m_ago,one_shehuang_cat1_cat_cnt_6m_ago,one_youxi_cat1_cat_cnt,one_youxi_cat1_cat_cnt_7d_ago,one_youxi_cat1_cat_cnt_1m_ago,one_youxi_cat1_cat_cnt_3m_ago,one_youxi_cat1_cat_cnt_6m_ago,one_shenghuo_cat_cnt,one_shenghuo_cat_cnt_7d_ago,one_shenghuo_cat_cnt_1m_ago,one_shenghuo_cat_cnt_3m_ago,one_shenghuo_cat_cnt_6m_ago,one_shenghuopinzhi_cat_cnt,one_shenghuopinzhi_cat_cnt_7d_ago,one_shenghuopinzhi_cat_cnt_1m_ago,one_shenghuopinzhi_cat_cnt_3m_ago,one_shenghuopinzhi_cat_cnt_6m_ago,one_dianshangpingtai_cat1_cat_cnt,one_dianshangpingtai_cat1_cat_cnt_7d_ago,one_dianshangpingtai_cat1_cat_cnt_1m_ago,one_dianshangpingtai_cat1_cat_cnt_3m_ago,one_dianshangpingtai_cat1_cat_cnt_6m_ago,one_dianzizhengwuyuzhihuichengshi_cat_cnt,one_dianzizhengwuyuzhihuichengshi_cat_cnt_7d_ago,one_dianzizhengwuyuzhihuichengshi_cat_cnt_1m_ago,one_dianzizhengwuyuzhihuichengshi_cat_cnt_3m_ago,one_dianzizhengwuyuzhihuichengshi_cat_cnt_6m_ago,one_shehuigongyi_cat_cnt,one_shehuigongyi_cat_cnt_7d_ago,one_shehuigongyi_cat_cnt_1m_ago,one_shehuigongyi_cat_cnt_3m_ago,one_shehuigongyi_cat_cnt_6m_ago,one_shebaogongjijin_cat_cnt,one_shebaogongjijin_cat_cnt_7d_ago,one_shebaogongjijin_cat_cnt_1m_ago,one_shebaogongjijin_cat_cnt_3m_ago,one_shebaogongjijin_cat_cnt_6m_ago,one_xunihuobi_cat1_cat_cnt,one_xunihuobi_cat1_cat_cnt_7d_ago,one_xunihuobi_cat1_cat_cnt_1m_ago,one_xunihuobi_cat1_cat_cnt_3m_ago,one_xunihuobi_cat1_cat_cnt_6m_ago,one_zixunyuedu_cat_cnt,one_zixunyuedu_cat_cnt_7d_ago,one_zixunyuedu_cat_cnt_1m_ago,one_zixunyuedu_cat_cnt_3m_ago,one_zixunyuedu_cat_cnt_6m_ago,one_dubo_cat_cnt,one_dubo_cat_cnt_7d_ago,one_dubo_cat_cnt_1m_ago,one_dubo_cat_cnt_3m_ago,one_dubo_cat_cnt_6m_ago,one_yundongyangsheng_cat_cnt,one_yundongyangsheng_cat_cnt_7d_ago,one_yundongyangsheng_cat_cnt_1m_ago,one_yundongyangsheng_cat_cnt_3m_ago,one_yundongyangsheng_cat_cnt_6m_ago,one_tongxunshejiao_cat_cnt,one_tongxunshejiao_cat_cnt_7d_ago,one_tongxunshejiao_cat_cnt_1m_ago,one_tongxunshejiao_cat_cnt_3m_ago,one_tongxunshejiao_cat_cnt_6m_ago,one_jinrongtuiguanglei_cat1_cat_cnt,one_jinrongtuiguanglei_cat1_cat_cnt_7d_ago,one_jinrongtuiguanglei_cat1_cat_cnt_1m_ago,one_jinrongtuiguanglei_cat1_cat_cnt_3m_ago,one_jinrongtuiguanglei_cat1_cat_cnt_6m_ago,one_jinrongfuwu_cat_cnt,one_jinrongfuwu_cat_cnt_7d_ago,one_jinrongfuwu_cat_cnt_1m_ago,one_jinrongfuwu_cat_cnt_3m_ago,one_jinrongfuwu_cat_cnt_6m_ago,one_yinhanglei_cat_cnt,one_yinhanglei_cat_cnt_7d_ago,one_yinhanglei_cat_cnt_1m_ago,one_yinhanglei_cat_cnt_3m_ago,one_yinhanglei_cat_cnt_6m_ago,one_heizhongjieluntanAPP_cat_cnt,one_heizhongjieluntanAPP_cat_cnt_7d_ago,one_heizhongjieluntanAPP_cat_cnt_1m_ago,one_heizhongjieluntanAPP_cat_cnt_3m_ago,one_heizhongjieluntanAPP_cat_cnt_6m_ago,two_CRM_cat_cnt,two_CRM_cat_cnt_7d_ago,two_CRM_cat_cnt_1m_ago,two_CRM_cat_cnt_3m_ago,two_CRM_cat_cnt_6m_ago,two_P2P_cat_cnt,two_P2P_cat_cnt_7d_ago,two_P2P_cat_cnt_1m_ago,two_P2P_cat_cnt_3m_ago,two_P2P_cat_cnt_6m_ago,two_WIFI_cat2_cat_cnt,two_WIFI_cat2_cat_cnt_7d_ago,two_WIFI_cat2_cat_cnt_1m_ago,two_WIFI_cat2_cat_cnt_3m_ago,two_WIFI_cat2_cat_cnt_6m_ago,two_budongchan_cat_cnt,two_budongchan_cat_cnt_7d_ago,two_budongchan_cat_cnt_1m_ago,two_budongchan_cat_cnt_3m_ago,two_budongchan_cat_cnt_6m_ago,two_yeneizhimingdaikuanAPP_cat_cnt,two_yeneizhimingdaikuanAPP_cat_cnt_7d_ago,two_yeneizhimingdaikuanAPP_cat_cnt_1m_ago,two_yeneizhimingdaikuanAPP_cat_cnt_3m_ago,two_yeneizhimingdaikuanAPP_cat_cnt_6m_ago,two_geshuidai_cat_cnt,two_geshuidai_cat_cnt_7d_ago,two_geshuidai_cat_cnt_1m_ago,two_geshuidai_cat_cnt_3m_ago,two_geshuidai_cat_cnt_6m_ago,two_maifangzufang_cat2_cat_cnt,two_maifangzufang_cat2_cat_cnt_7d_ago,two_maifangzufang_cat2_cat_cnt_1m_ago,two_maifangzufang_cat2_cat_cnt_3m_ago,two_maifangzufang_cat2_cat_cnt_6m_ago,two_ershouchejiaoyi_cat_cnt,two_ershouchejiaoyi_cat_cnt_7d_ago,two_ershouchejiaoyi_cat_cnt_1m_ago,two_ershouchejiaoyi_cat_cnt_3m_ago,two_ershouchejiaoyi_cat_cnt_6m_ago,two_erciyuan_cat_cnt,two_erciyuan_cat_cnt_7d_ago,two_erciyuan_cat_cnt_1m_ago,two_erciyuan_cat_cnt_3m_ago,two_erciyuan_cat_cnt_6m_ago,two_qiyexietong_cat_cnt,two_qiyexietong_cat_cnt_7d_ago,two_qiyexietong_cat_cnt_1m_ago,two_qiyexietong_cat_cnt_3m_ago,two_qiyexietong_cat_cnt_6m_ago,two_zhongchouhuankuan_cat_cnt,two_zhongchouhuankuan_cat_cnt_7d_ago,two_zhongchouhuankuan_cat_cnt_1m_ago,two_zhongchouhuankuan_cat_cnt_3m_ago,two_zhongchouhuankuan_cat_cnt_6m_ago,two_youzhijinrongkeji_cat_cnt,two_youzhijinrongkeji_cat_cnt_7d_ago,two_youzhijinrongkeji_cat_cnt_1m_ago,two_youzhijinrongkeji_cat_cnt_3m_ago,two_youzhijinrongkeji_cat_cnt_6m_ago,two_chuanshubeifen_cat_cnt,two_chuanshubeifen_cat_cnt_7d_ago,two_chuanshubeifen_cat_cnt_1m_ago,two_chuanshubeifen_cat_cnt_3m_ago,two_chuanshubeifen_cat_cnt_6m_ago,two_chuanxiao_cat_cnt,two_chuanxiao_cat_cnt_7d_ago,two_chuanxiao_cat_cnt_1m_ago,two_chuanxiao_cat_cnt_3m_ago,two_chuanxiao_cat_cnt_6m_ago,two_diduanqiuzhiAPP_cat_cnt,two_diduanqiuzhiAPP_cat_cnt_7d_ago,two_diduanqiuzhiAPP_cat_cnt_1m_ago,two_diduanqiuzhiAPP_cat_cnt_3m_ago,two_diduanqiuzhiAPP_cat_cnt_6m_ago,two_zhusufuwu_cat_cnt,two_zhusufuwu_cat_cnt_7d_ago,two_zhusufuwu_cat_cnt_1m_ago,two_zhusufuwu_cat_cnt_3m_ago,two_zhusufuwu_cat_cnt_6m_ago,two_tiyuzhibo_cat_cnt,two_tiyuzhibo_cat_cnt_7d_ago,two_tiyuzhibo_cat_cnt_1m_ago,two_tiyuzhibo_cat_cnt_3m_ago,two_tiyuzhibo_cat_cnt_6m_ago,two_zuobilei_cat2_cat_cnt,two_zuobilei_cat2_cat_cnt_7d_ago,two_zuobilei_cat2_cat_cnt_1m_ago,two_zuobilei_cat2_cat_cnt_3m_ago,two_zuobilei_cat2_cat_cnt_6m_ago,two_baoxianlicai_cat_cnt,two_baoxianlicai_cat_cnt_7d_ago,two_baoxianlicai_cat_cnt_1m_ago,two_baoxianlicai_cat_cnt_3m_ago,two_baoxianlicai_cat_cnt_6m_ago,two_jiankangyundong_cat_cnt,two_jiankangyundong_cat_cnt_7d_ago,two_jiankangyundong_cat_cnt_1m_ago,two_jiankangyundong_cat_cnt_3m_ago,two_jiankangyundong_cat_cnt_6m_ago,two_ertongjiaoyu_cat_cnt,two_ertongjiaoyu_cat_cnt_7d_ago,two_ertongjiaoyu_cat_cnt_1m_ago,two_ertongjiaoyu_cat_cnt_3m_ago,two_ertongjiaoyu_cat_cnt_6m_ago,two_chongzhijiayou_cat_cnt,two_chongzhijiayou_cat_cnt_7d_ago,two_chongzhijiayou_cat_cnt_1m_ago,two_chongzhijiayou_cat_cnt_3m_ago,two_chongzhijiayou_cat_cnt_6m_ago,two_mianshuidianziyingapp_cat_cnt,two_mianshuidianziyingapp_cat_cnt_7d_ago,two_mianshuidianziyingapp_cat_cnt_1m_ago,two_mianshuidianziyingapp_cat_cnt_3m_ago,two_mianshuidianziyingapp_cat_cnt_6m_ago,two_dangguojiaoyu_cat_cnt,two_dangguojiaoyu_cat_cnt_7d_ago,two_dangguojiaoyu_cat_cnt_1m_ago,two_dangguojiaoyu_cat_cnt_3m_ago,two_dangguojiaoyu_cat_cnt_6m_ago,two_gongwuyuankechengjiaoyu_cat_cnt,two_gongwuyuankechengjiaoyu_cat_cnt_7d_ago,two_gongwuyuankechengjiaoyu_cat_cnt_1m_ago,two_gongwuyuankechengjiaoyu_cat_cnt_3m_ago,two_gongwuyuankechengjiaoyu_cat_cnt_6m_ago,two_gongyi_cat_cnt,two_gongyi_cat_cnt_7d_ago,two_gongyi_cat_cnt_1m_ago,two_gongyi_cat_cnt_3m_ago,two_gongyi_cat_cnt_6m_ago,two_gongjijin_cat_cnt,two_gongjijin_cat_cnt_7d_ago,two_gongjijin_cat_cnt_1m_ago,two_gongjijin_cat_cnt_3m_ago,two_gongjijin_cat_cnt_6m_ago,two_gongxiangbangong_cat_cnt,two_gongxiangbangong_cat_cnt_7d_ago,two_gongxiangbangong_cat_cnt_1m_ago,two_gongxiangbangong_cat_cnt_3m_ago,two_gongxiangbangong_cat_cnt_6m_ago,two_qita_cat_cnt,two_qita_cat_cnt_7d_ago,two_qita_cat_cnt_1m_ago,two_qita_cat_cnt_3m_ago,two_qita_cat_cnt_6m_ago,two_qitadaikuan_cat_cnt,two_qitadaikuan_cat_cnt_7d_ago,two_qitadaikuan_cat_cnt_1m_ago,two_qitadaikuan_cat_cnt_3m_ago,two_qitadaikuan_cat_cnt_6m_ago,two_nongcundianshang_cat_cnt,two_nongcundianshang_cat_cnt_7d_ago,two_nongcundianshang_cat_cnt_1m_ago,two_nongcundianshang_cat_cnt_3m_ago,two_nongcundianshang_cat_cnt_6m_ago,two_fenshenlei_cat_cnt,two_fenshenlei_cat_cnt_7d_ago,two_fenshenlei_cat_cnt_1m_ago,two_fenshenlei_cat_cnt_3m_ago,two_fenshenlei_cat_cnt_6m_ago,two_shuadanlei_cat_cnt,two_shuadanlei_cat_cnt_7d_ago,two_shuadanlei_cat_cnt_1m_ago,two_shuadanlei_cat_cnt_3m_ago,two_shuadanlei_cat_cnt_6m_ago,two_bangongchangsuozulin_cat_cnt,two_bangongchangsuozulin_cat_cnt_7d_ago,two_bangongchangsuozulin_cat_cnt_1m_ago,two_bangongchangsuozulin_cat_cnt_3m_ago,two_bangongchangsuozulin_cat_cnt_6m_ago,two_zhunong_cat_cnt,two_zhunong_cat_cnt_7d_ago,two_zhunong_cat_cnt_1m_ago,two_zhunong_cat_cnt_3m_ago,two_zhunong_cat_cnt_6m_ago,two_zhudai_cat_cnt,two_zhudai_cat_cnt_7d_ago,two_zhudai_cat_cnt_1m_ago,two_zhudai_cat_cnt_3m_ago,two_zhudai_cat_cnt_6m_ago,two_baomingdailoandeapp_cat_cnt,two_baomingdailoandeapp_cat_cnt_7d_ago,two_baomingdailoandeapp_cat_cnt_1m_ago,two_baomingdailoandeapp_cat_cnt_3m_ago,two_baomingdailoandeapp_cat_cnt_6m_ago,two_yiliao_cat_cnt,two_yiliao_cat_cnt_7d_ago,two_yiliao_cat_cnt_1m_ago,two_yiliao_cat_cnt_3m_ago,two_yiliao_cat_cnt_6m_ago,two_yiliaozixun_cat_cnt,two_yiliaozixun_cat_cnt_7d_ago,two_yiliaozixun_cat_cnt_1m_ago,two_yiliaozixun_cat_cnt_3m_ago,two_yiliaozixun_cat_cnt_6m_ago,two_yiyao_cat_cnt,two_yiyao_cat_cnt_7d_ago,two_yiyao_cat_cnt_1m_ago,two_yiyao_cat_cnt_3m_ago,two_yiyao_cat_cnt_6m_ago,two_bocailei_cat_cnt,two_bocailei_cat_cnt_7d_ago,two_bocailei_cat_cnt_1m_ago,two_bocailei_cat_cnt_3m_ago,two_bocailei_cat_cnt_6m_ago,two_faxindai_cat_cnt,two_faxindai_cat_cnt_7d_ago,two_faxindai_cat_cnt_1m_ago,two_faxindai_cat_cnt_3m_ago,two_faxindai_cat_cnt_6m_ago,two_sijijiedanlei_cat_cnt,two_sijijiedanlei_cat_cnt_7d_ago,two_sijijiedanlei_cat_cnt_1m_ago,two_sijijiedanlei_cat_cnt_3m_ago,two_sijijiedanlei_cat_cnt_6m_ago,two_tongchengkuaidi_cat_cnt,two_tongchengkuaidi_cat_cnt_7d_ago,two_tongchengkuaidi_cat_cnt_1m_ago,two_tongchengkuaidi_cat_cnt_3m_ago,two_tongchengkuaidi_cat_cnt_6m_ago,two_shangwujiudian_cat_cnt,two_shangwujiudian_cat_cnt_7d_ago,two_shangwujiudian_cat_cnt_1m_ago,two_shangwujiudian_cat_cnt_3m_ago,two_shangwujiudian_cat_cnt_6m_ago,two_zaixianshipin_cat_cnt,two_zaixianshipin_cat_cnt_7d_ago,two_zaixianshipin_cat_cnt_1m_ago,two_zaixianshipin_cat_cnt_3m_ago,two_zaixianshipin_cat_cnt_6m_ago,two_zaixianyinyue_cat_cnt,two_zaixianyinyue_cat_cnt_7d_ago,two_zaixianyinyue_cat_cnt_1m_ago,two_zaixianyinyue_cat_cnt_3m_ago,two_zaixianyinyue_cat_cnt_6m_ago,two_changjingxiaofeifenqi_cat_cnt,two_changjingxiaofeifenqi_cat_cnt_7d_ago,two_changjingxiaofeifenqi_cat_cnt_1m_ago,two_changjingxiaofeifenqi_cat_cnt_3m_ago,two_changjingxiaofeifenqi_cat_cnt_6m_ago,two_chengshichuxing_cat_cnt,two_chengshichuxing_cat_cnt_7d_ago,two_chengshichuxing_cat_cnt_1m_ago,two_chengshichuxing_cat_cnt_3m_ago,two_chengshichuxing_cat_cnt_6m_ago,two_waimai_cat2_cat_cnt,two_waimai_cat2_cat_cnt_7d_ago,two_waimai_cat2_cat_cnt_1m_ago,two_waimai_cat2_cat_cnt_3m_ago,two_waimai_cat2_cat_cnt_6m_ago,two_daxuejiaoyu_cat_cnt,two_daxuejiaoyu_cat_cnt_7d_ago,two_daxuejiaoyu_cat_cnt_1m_ago,two_daxuejiaoyu_cat_cnt_3m_ago,two_daxuejiaoyu_cat_cnt_6m_ago,two_shechipin_cat2_cat_cnt,two_shechipin_cat2_cat_cnt_7d_ago,two_shechipin_cat2_cat_cnt_1m_ago,two_shechipin_cat2_cat_cnt_3m_ago,two_shechipin_cat2_cat_cnt_6m_ago,two_yulezhibo_cat_cnt,two_yulezhibo_cat_cnt_7d_ago,two_yulezhibo_cat_cnt_1m_ago,two_yulezhibo_cat_cnt_3m_ago,two_yulezhibo_cat_cnt_6m_ago,two_hunlianshejiao_cat_cnt,two_hunlianshejiao_cat_cnt_7d_ago,two_hunlianshejiao_cat_cnt_1m_ago,two_hunlianshejiao_cat_cnt_3m_ago,two_hunlianshejiao_cat_cnt_6m_ago,two_anquanyouhua_cat_cnt,two_anquanyouhua_cat_cnt_7d_ago,two_anquanyouhua_cat_cnt_1m_ago,two_anquanyouhua_cat_cnt_3m_ago,two_anquanyouhua_cat_cnt_6m_ago,two_jiajujiazhuang_cat_cnt,two_jiajujiazhuang_cat_cnt_7d_ago,two_jiajujiazhuang_cat_cnt_1m_ago,two_jiajujiazhuang_cat_cnt_3m_ago,two_jiajujiazhuang_cat_cnt_6m_ago,two_xiaoweiqiyelei_cat2_cat_cnt,two_xiaoweiqiyelei_cat2_cat_cnt_7d_ago,two_xiaoweiqiyelei_cat2_cat_cnt_1m_ago,two_xiaoweiqiyelei_cat2_cat_cnt_3m_ago,two_xiaoweiqiyelei_cat2_cat_cnt_6m_ago,two_jujiafuwu_cat_cnt,two_jujiafuwu_cat_cnt_7d_ago,two_jujiafuwu_cat_cnt_1m_ago,two_jujiafuwu_cat_cnt_3m_ago,two_jujiafuwu_cat_cnt_6m_ago,two_gongzuochangjingshejiao_cat_cnt,two_gongzuochangjingshejiao_cat_cnt_7d_ago,two_gongzuochangjingshejiao_cat_cnt_1m_ago,two_gongzuochangjingshejiao_cat_cnt_3m_ago,two_gongzuochangjingshejiao_cat_cnt_6m_ago,two_yingyongshichang_cat_cnt,two_yingyongshichang_cat_cnt_7d_ago,two_yingyongshichang_cat_cnt_1m_ago,two_yingyongshichang_cat_cnt_3m_ago,two_yingyongshichang_cat_cnt_6m_ago,two_chengrenjiaoyu_cat_cnt,two_chengrenjiaoyu_cat_cnt_7d_ago,two_chengrenjiaoyu_cat_cnt_1m_ago,two_chengrenjiaoyu_cat_cnt_3m_ago,two_chengrenjiaoyu_cat_cnt_6m_ago,two_fangchanzhuangxiumaimai_cat_cnt,two_fangchanzhuangxiumaimai_cat_cnt_7d_ago,two_fangchanzhuangxiumaimai_cat_cnt_1m_ago,two_fangchanzhuangxiumaimai_cat_cnt_3m_ago,two_fangchanzhuangxiumaimai_cat_cnt_6m_ago,two_fangwuxinxiAPP_cat_cnt,two_fangwuxinxiAPP_cat_cnt_7d_ago,two_fangwuxinxiAPP_cat_cnt_1m_ago,two_fangwuxinxiAPP_cat_cnt_3m_ago,two_fangwuxinxiAPP_cat_cnt_6m_ago,two_fangdaijisuanqi_cat_cnt,two_fangdaijisuanqi_cat_cnt_7d_ago,two_fangdaijisuanqi_cat_cnt_1m_ago,two_fangdaijisuanqi_cat_cnt_3m_ago,two_fangdaijisuanqi_cat_cnt_6m_ago,two_shouyou_cat_cnt,two_shouyou_cat_cnt_7d_ago,two_shouyou_cat_cnt_1m_ago,two_shouyou_cat_cnt_3m_ago,two_shouyou_cat_cnt_6m_ago,two_paizhaomeitu_cat_cnt,two_paizhaomeitu_cat_cnt_7d_ago,two_paizhaomeitu_cat_cnt_1m_ago,two_paizhaomeitu_cat_cnt_3m_ago,two_paizhaomeitu_cat_cnt_6m_ago,two_zhaopinqiuzhi_cat_cnt,two_zhaopinqiuzhi_cat_cnt_7d_ago,two_zhaopinqiuzhi_cat_cnt_1m_ago,two_zhaopinqiuzhi_cat_cnt_3m_ago,two_zhaopinqiuzhi_cat_cnt_6m_ago,two_chipaixiaojin_cat_cnt,two_chipaixiaojin_cat_cnt_7d_ago,two_chipaixiaojin_cat_cnt_1m_ago,two_chipaixiaojin_cat_cnt_3m_ago,two_chipaixiaojin_cat_cnt_6m_ago,two_wakuang_cat_cnt,two_wakuang_cat_cnt_7d_ago,two_wakuang_cat_cnt_1m_ago,two_wakuang_cat_cnt_3m_ago,two_wakuang_cat_cnt_6m_ago,two_zhengwu_cat_cnt,two_zhengwu_cat_cnt_7d_ago,two_zhengwu_cat_cnt_1m_ago,two_zhengwu_cat_cnt_3m_ago,two_zhengwu_cat_cnt_6m_ago,two_xinnengyuanqichefuwu_cat_cnt,two_xinnengyuanqichefuwu_cat_cnt_7d_ago,two_xinnengyuanqichefuwu_cat_cnt_1m_ago,two_xinnengyuanqichefuwu_cat_cnt_3m_ago,two_xinnengyuanqichefuwu_cat_cnt_6m_ago,two_luyouAPP_cat_cnt,two_luyouAPP_cat_cnt_7d_ago,two_luyouAPP_cat_cnt_1m_ago,two_luyouAPP_cat_cnt_3m_ago,two_luyouAPP_cat_cnt_6m_ago,two_luyouxiangguan_cat_cnt,two_luyouxiangguan_cat_cnt_7d_ago,two_luyouxiangguan_cat_cnt_1m_ago,two_luyouxiangguan_cat_cnt_3m_ago,two_luyouxiangguan_cat_cnt_6m_ago,two_riliAPP_cat_cnt,two_riliAPP_cat_cnt_7d_ago,two_riliAPP_cat_cnt_1m_ago,two_riliAPP_cat_cnt_3m_ago,two_riliAPP_cat_cnt_6m_ago,two_shijianguanli_guihua_cat_cnt,two_shijianguanli_guihua_cat_cnt_7d_ago,two_shijianguanli_guihua_cat_cnt_1m_ago,two_shijianguanli_guihua_cat_cnt_3m_ago,two_shijianguanli_guihua_cat_cnt_6m_ago,two_zhihuichengshi_cat_cnt,two_zhihuichengshi_cat_cnt_7d_ago,two_zhihuichengshi_cat_cnt_1m_ago,two_zhihuichengshi_cat_cnt_3m_ago,two_zhihuichengshi_cat_cnt_6m_ago,two_zhinengjiaju_cat_cnt,two_zhinengjiaju_cat_cnt_7d_ago,two_zhinengjiaju_cat_cnt_1m_ago,two_zhinengjiaju_cat_cnt_3m_ago,two_zhinengjiaju_cat_cnt_6m_ago,two_bendishenghuo_cat_cnt,two_bendishenghuo_cat_cnt_7d_ago,two_bendishenghuo_cat_cnt_1m_ago,two_bendishenghuo_cat_cnt_3m_ago,two_bendishenghuo_cat_cnt_6m_ago,two_jipiaoxiangguan_cat_cnt,two_jipiaoxiangguan_cat_cnt_7d_ago,two_jipiaoxiangguan_cat_cnt_1m_ago,two_jipiaoxiangguan_cat_cnt_3m_ago,two_jipiaoxiangguan_cat_cnt_6m_ago,two_muying_cat_cnt,two_muying_cat_cnt_7d_ago,two_muying_cat_cnt_1m_ago,two_muying_cat_cnt_3m_ago,two_muying_cat_cnt_6m_ago,two_muyingshenghuo_cat_cnt,two_muyingshenghuo_cat_cnt_7d_ago,two_muyingshenghuo_cat_cnt_1m_ago,two_muyingshenghuo_cat_cnt_3m_ago,two_muyingshenghuo_cat_cnt_6m_ago,two_muyingdianshang_cat_cnt,two_muyingdianshang_cat_cnt_7d_ago,two_muyingdianshang_cat_cnt_1m_ago,two_muyingdianshang_cat_cnt_3m_ago,two_muyingdianshang_cat_cnt_6m_ago,two_qiuzhizhaopin_cat2_cat_cnt,two_qiuzhizhaopin_cat2_cat_cnt_7d_ago,two_qiuzhizhaopin_cat2_cat_cnt_1m_ago,two_qiuzhizhaopin_cat2_cat_cnt_3m_ago,two_qiuzhizhaopin_cat2_cat_cnt_6m_ago,two_qichejiayoulei_cat_cnt,two_qichejiayoulei_cat_cnt_7d_ago,two_qichejiayoulei_cat_cnt_1m_ago,two_qichejiayoulei_cat_cnt_3m_ago,two_qichejiayoulei_cat_cnt_6m_ago,two_qichepinpailei_cat_cnt,two_qichepinpailei_cat_cnt_7d_ago,two_qichepinpailei_cat_cnt_1m_ago,two_qichepinpailei_cat_cnt_3m_ago,two_qichepinpailei_cat_cnt_6m_ago,two_qicheguanfangpinpai_cat_cnt,two_qicheguanfangpinpai_cat_cnt_7d_ago,two_qicheguanfangpinpai_cat_cnt_1m_ago,two_qicheguanfangpinpai_cat_cnt_3m_ago,two_qicheguanfangpinpai_cat_cnt_6m_ago,two_qichezulin_cat_cnt,two_qichezulin_cat_cnt_7d_ago,two_qichezulin_cat_cnt_1m_ago,two_qichezulin_cat_cnt_3m_ago,two_qichezulin_cat_cnt_6m_ago,two_qichezonghezixun_cat_cnt,two_qichezonghezixun_cat_cnt_7d_ago,two_qichezonghezixun_cat_cnt_1m_ago,two_qichezonghezixun_cat_cnt_3m_ago,two_qichezonghezixun_cat_cnt_6m_ago,two_falu_cat_cnt,two_falu_cat_cnt_7d_ago,two_falu_cat_cnt_1m_ago,two_falu_cat_cnt_3m_ago,two_falu_cat_cnt_6m_ago,two_liulanqiAPP_cat_cnt,two_liulanqiAPP_cat_cnt_7d_ago,two_liulanqiAPP_cat_cnt_1m_ago,two_liulanqiAPP_cat_cnt_3m_ago,two_liulanqiAPP_cat_cnt_6m_ago,two_haiwaidaigouapp_cat_cnt,two_haiwaidaigouapp_cat_cnt_7d_ago,two_haiwaidaigouapp_cat_cnt_1m_ago,two_haiwaidaigouapp_cat_cnt_3m_ago,two_haiwaidaigouapp_cat_cnt_6m_ago,two_xiaofeijinrong_cat_cnt,two_xiaofeijinrong_cat_cnt_7d_ago,two_xiaofeijinrong_cat_cnt_1m_ago,two_xiaofeijinrong_cat_cnt_3m_ago,two_xiaofeijinrong_cat_cnt_6m_ago,two_shehuang_cat2_cat_cnt,two_shehuang_cat2_cat_cnt_7d_ago,two_shehuang_cat2_cat_cnt_1m_ago,two_shehuang_cat2_cat_cnt_3m_ago,two_shehuang_cat2_cat_cnt_6m_ago,two_youxi_cat2_cat_cnt,two_youxi_cat2_cat_cnt_7d_ago,two_youxi_cat2_cat_cnt_1m_ago,two_youxi_cat2_cat_cnt_3m_ago,two_youxi_cat2_cat_cnt_6m_ago,two_youxiyule_cat_cnt,two_youxiyule_cat_cnt_7d_ago,two_youxiyule_cat_cnt_1m_ago,two_youxiyule_cat_cnt_3m_ago,two_youxiyule_cat_cnt_6m_ago,two_youxishejiao_cat_cnt,two_youxishejiao_cat_cnt_7d_ago,two_youxishejiao_cat_cnt_1m_ago,two_youxishejiao_cat_cnt_3m_ago,two_youxishejiao_cat_cnt_6m_ago,two_youxilei_cat_cnt,two_youxilei_cat_cnt_7d_ago,two_youxilei_cat_cnt_1m_ago,two_youxilei_cat_cnt_3m_ago,two_youxilei_cat_cnt_6m_ago,two_yanchupiaowu_cat_cnt,two_yanchupiaowu_cat_cnt_7d_ago,two_yanchupiaowu_cat_cnt_1m_ago,two_yanchupiaowu_cat_cnt_3m_ago,two_yanchupiaowu_cat_cnt_6m_ago,two_shurenshejiao_cat_cnt,two_shurenshejiao_cat_cnt_7d_ago,two_shurenshejiao_cat_cnt_1m_ago,two_shurenshejiao_cat_cnt_3m_ago,two_shurenshejiao_cat_cnt_6m_ago,two_shengxiandianshang_cat_cnt,two_shengxiandianshang_cat_cnt_7d_ago,two_shengxiandianshang_cat_cnt_1m_ago,two_shengxiandianshang_cat_cnt_3m_ago,two_shengxiandianshang_cat_cnt_6m_ago,two_dianshangpingtai_cat2_cat_cnt,two_dianshangpingtai_cat2_cat_cnt_7d_ago,two_dianshangpingtai_cat2_cat_cnt_1m_ago,two_dianshangpingtai_cat2_cat_cnt_3m_ago,two_dianshangpingtai_cat2_cat_cnt_6m_ago,two_yisichuanxiao_cat_cnt,two_yisichuanxiao_cat_cnt_7d_ago,two_yisichuanxiao_cat_cnt_1m_ago,two_yisichuanxiao_cat_cnt_3m_ago,two_yisichuanxiao_cat_cnt_6m_ago,two_zhiboshejiao_cat_cnt,two_zhiboshejiao_cat_cnt_7d_ago,two_zhiboshejiao_cat_cnt_1m_ago,two_zhiboshejiao_cat_cnt_3m_ago,two_zhiboshejiao_cat_cnt_6m_ago,two_duanshipin_cat_cnt,two_duanshipin_cat_cnt_7d_ago,two_duanshipin_cat_cnt_1m_ago,two_duanshipin_cat_cnt_3m_ago,two_duanshipin_cat_cnt_6m_ago,two_shebaoshuiwu_cat_cnt,two_shebaoshuiwu_cat_cnt_7d_ago,two_shebaoshuiwu_cat_cnt_1m_ago,two_shebaoshuiwu_cat_cnt_3m_ago,two_shebaoshuiwu_cat_cnt_6m_ago,two_shequjiaoyou_cat_cnt,two_shequjiaoyou_cat_cnt_7d_ago,two_shequjiaoyou_cat_cnt_1m_ago,two_shequjiaoyou_cat_cnt_3m_ago,two_shequjiaoyou_cat_cnt_6m_ago,two_shequfuwu_cat_cnt,two_shequfuwu_cat_cnt_7d_ago,two_shequfuwu_cat_cnt_1m_ago,two_shequfuwu_cat_cnt_3m_ago,two_shequfuwu_cat_cnt_6m_ago,two_cuangaidingwei_cat_cnt,two_cuangaidingwei_cat_cnt_7d_ago,two_cuangaidingwei_cat_cnt_1m_ago,two_cuangaidingwei_cat_cnt_3m_ago,two_cuangaidingwei_cat_cnt_6m_ago,two_suzhijiaoyu_cat_cnt,two_suzhijiaoyu_cat_cnt_7d_ago,two_suzhijiaoyu_cat_cnt_1m_ago,two_suzhijiaoyu_cat_cnt_3m_ago,two_suzhijiaoyu_cat_cnt_6m_ago,two_xianshangwangke_cat_cnt,two_xianshangwangke_cat_cnt_7d_ago,two_xianshangwangke_cat_cnt_1m_ago,two_xianshangwangke_cat_cnt_3m_ago,two_xianshangwangke_cat_cnt_6m_ago,two_zongheluyoufuwu_cat_cnt,two_zongheluyoufuwu_cat_cnt_7d_ago,two_zongheluyoufuwu_cat_cnt_1m_ago,two_zongheluyoufuwu_cat_cnt_3m_ago,two_zongheluyoufuwu_cat_cnt_6m_ago,two_zonghedianshang_cat_cnt,two_zonghedianshang_cat_cnt_7d_ago,two_zonghedianshang_cat_cnt_1m_ago,two_zonghedianshang_cat_cnt_3m_ago,two_zonghedianshang_cat_cnt_6m_ago,two_zongheleishejiao_cat_cnt,two_zongheleishejiao_cat_cnt_7d_ago,two_zongheleishejiao_cat_cnt_1m_ago,two_zongheleishejiao_cat_cnt_3m_ago,two_zongheleishejiao_cat_cnt_6m_ago,two_zonghezixun_cat_cnt,two_zonghezixun_cat_cnt_7d_ago,two_zonghezixun_cat_cnt_1m_ago,two_zonghezixun_cat_cnt_3m_ago,two_zonghezixun_cat_cnt_6m_ago,two_zonghejinrong_cat_cnt,two_zonghejinrong_cat_cnt_7d_ago,two_zonghejinrong_cat_cnt_1m_ago,two_zonghejinrong_cat_cnt_3m_ago,two_zonghejinrong_cat_cnt_6m_ago,two_wangluoKge_cat_cnt,two_wangluoKge_cat_cnt_7d_ago,two_wangluoKge_cat_cnt_1m_ago,two_wangluoKge_cat_cnt_3m_ago,two_wangluoKge_cat_cnt_6m_ago,two_meizhuang_cat_cnt,two_meizhuang_cat_cnt_7d_ago,two_meizhuang_cat_cnt_1m_ago,two_meizhuang_cat_cnt_3m_ago,two_meizhuang_cat_cnt_6m_ago,two_meishi_cat_cnt,two_meishi_cat_cnt_7d_ago,two_meishi_cat_cnt_1m_ago,two_meishi_cat_cnt_3m_ago,two_meishi_cat_cnt_6m_ago,two_fanyifuwu_cat_cnt,two_fanyifuwu_cat_cnt_7d_ago,two_fanyifuwu_cat_cnt_1m_ago,two_fanyifuwu_cat_cnt_3m_ago,two_fanyifuwu_cat_cnt_6m_ago,two_zhinengjishulei_cat_cnt,two_zhinengjishulei_cat_cnt_7d_ago,two_zhinengjishulei_cat_cnt_1m_ago,two_zhinengjishulei_cat_cnt_3m_ago,two_zhinengjishulei_cat_cnt_6m_ago,two_hangkonggongsiguanfangAPP_cat_cnt,two_hangkonggongsiguanfangAPP_cat_cnt_7d_ago,two_hangkonggongsiguanfangAPP_cat_cnt_1m_ago,two_hangkonggongsiguanfangAPP_cat_cnt_3m_ago,two_hangkonggongsiguanfangAPP_cat_cnt_6m_ago,two_xunijiaoyi_cat_cnt,two_xunijiaoyi_cat_cnt_7d_ago,two_xunijiaoyi_cat_cnt_1m_ago,two_xunijiaoyi_cat_cnt_3m_ago,two_xunijiaoyi_cat_cnt_6m_ago,two_xunihuobi_cat2_cat_cnt,two_xunihuobi_cat2_cat_cnt_7d_ago,two_xunihuobi_cat2_cat_cnt_1m_ago,two_xunihuobi_cat2_cat_cnt_3m_ago,two_xunihuobi_cat2_cat_cnt_6m_ago,two_shipinhuiyi_cat_cnt,two_shipinhuiyi_cat_cnt_7d_ago,two_shipinhuiyi_cat_cnt_1m_ago,two_shipinhuiyi_cat_cnt_3m_ago,two_shipinhuiyi_cat_cnt_6m_ago,two_shipinjianji_cat_cnt,two_shipinjianji_cat_cnt_7d_ago,two_shipinjianji_cat_cnt_1m_ago,two_shipinjianji_cat_cnt_3m_ago,two_shipinjianji_cat_cnt_6m_ago,two_zhengquanfuwu_cat_cnt,two_zhengquanfuwu_cat_cnt_7d_ago,two_zhengquanfuwu_cat_cnt_1m_ago,two_zhengquanfuwu_cat_cnt_3m_ago,two_zhengquanfuwu_cat_cnt_6m_ago,two_yuyanfanyi_xuexi_cat_cnt,two_yuyanfanyi_xuexi_cat_cnt_7d_ago,two_yuyanfanyi_xuexi_cat_cnt_1m_ago,two_yuyanfanyi_xuexi_cat_cnt_3m_ago,two_yuyanfanyi_xuexi_cat_cnt_6m_ago,two_huobimaimaijiaoyi_cat_cnt,two_huobimaimaijiaoyi_cat_cnt_7d_ago,two_huobimaimaijiaoyi_cat_cnt_1m_ago,two_huobimaimaijiaoyi_cat_cnt_3m_ago,two_huobimaimaijiaoyi_cat_cnt_6m_ago,two_huobixinxizixun_cat1_cat_cnt,two_huobixinxizixun_cat1_cat_cnt_7d_ago,two_huobixinxizixun_cat1_cat_cnt_1m_ago,two_huobixinxizixun_cat1_cat_cnt_3m_ago,two_huobixinxizixun_cat1_cat_cnt_6m_ago,two_huobixinxizixun_cat2_cat_cnt,two_huobixinxizixun_cat2_cat_cnt_7d_ago,two_huobixinxizixun_cat2_cat_cnt_1m_ago,two_huobixinxizixun_cat2_cat_cnt_3m_ago,two_huobixinxizixun_cat2_cat_cnt_6m_ago,two_huobiwakuanglei_cat_cnt,two_huobiwakuanglei_cat_cnt_7d_ago,two_huobiwakuanglei_cat_cnt_1m_ago,two_huobiwakuanglei_cat_cnt_3m_ago,two_huobiwakuanglei_cat_cnt_6m_ago,two_huobiqianbao_cat_cnt,two_huobiqianbao_cat_cnt_7d_ago,two_huobiqianbao_cat_cnt_1m_ago,two_huobiqianbao_cat_cnt_3m_ago,two_huobiqianbao_cat_cnt_6m_ago,two_daikuanlei_cat_cnt,two_daikuanlei_cat_cnt_7d_ago,two_daikuanlei_cat_cnt_1m_ago,two_daikuanlei_cat_cnt_3m_ago,two_daikuanlei_cat_cnt_6m_ago,two_daichao_cat_cnt,two_daichao_cat_cnt_7d_ago,two_daichao_cat_cnt_1m_ago,two_daichao_cat_cnt_3m_ago,two_daichao_cat_cnt_6m_ago,two_zixunsousuo_cat_cnt,two_zixunsousuo_cat_cnt_7d_ago,two_zixunsousuo_cat_cnt_1m_ago,two_zixunsousuo_cat_cnt_3m_ago,two_zixunsousuo_cat_cnt_6m_ago,two_zixunlei_cat_cnt,two_zixunlei_cat_cnt_7d_ago,two_zixunlei_cat_cnt_1m_ago,two_zixunlei_cat_cnt_3m_ago,two_zixunlei_cat_cnt_6m_ago,two_chehoufuwu_cat_cnt,two_chehoufuwu_cat_cnt_7d_ago,two_chehoufuwu_cat_cnt_1m_ago,two_chehoufuwu_cat_cnt_3m_ago,two_chehoufuwu_cat_cnt_6m_ago,two_chepiaofuwu_cat_cnt,two_chepiaofuwu_cat_cnt_7d_ago,two_chepiaofuwu_cat_cnt_1m_ago,two_chepiaofuwu_cat_cnt_3m_ago,two_chepiaofuwu_cat_cnt_6m_ago,two_cheliangfuwulei_cat_cnt,two_cheliangfuwulei_cat_cnt_7d_ago,two_cheliangfuwulei_cat_cnt_1m_ago,two_cheliangfuwulei_cat_cnt_3m_ago,two_cheliangfuwulei_cat_cnt_6m_ago,two_shurufa_cat_cnt,two_shurufa_cat_cnt_7d_ago,two_shurufa_cat_cnt_1m_ago,two_shurufa_cat_cnt_3m_ago,two_shurufa_cat_cnt_6m_ago,two_yundongshoushen_cat_cnt,two_yundongshoushen_cat_cnt_7d_ago,two_yundongshoushen_cat_cnt_1m_ago,two_yundongshoushen_cat_cnt_3m_ago,two_yundongshoushen_cat_cnt_6m_ago,two_youxiangAPP_cat_cnt,two_youxiangAPP_cat_cnt_7d_ago,two_youxiangAPP_cat_cnt_1m_ago,two_youxiangAPP_cat_cnt_3m_ago,two_youxiangAPP_cat_cnt_6m_ago,two_jinrongtuiguanglei_cat2_cat_cnt,two_jinrongtuiguanglei_cat2_cat_cnt_7d_ago,two_jinrongtuiguanglei_cat2_cat_cnt_1m_ago,two_jinrongtuiguanglei_cat2_cat_cnt_3m_ago,two_jinrongtuiguanglei_cat2_cat_cnt_6m_ago,two_yinhangxinyongka_cat2_cat_cnt,two_yinhangxinyongka_cat2_cat_cnt_7d_ago,two_yinhangxinyongka_cat2_cat_cnt_1m_ago,two_yinhangxinyongka_cat2_cat_cnt_3m_ago,two_yinhangxinyongka_cat2_cat_cnt_6m_ago,two_yinhangxidaikuan_cat_cnt,two_yinhangxidaikuan_cat_cnt_7d_ago,two_yinhangxidaikuan_cat_cnt_1m_ago,two_yinhangxidaikuan_cat_cnt_3m_ago,two_yinhangxidaikuan_cat_cnt_6m_ago,two_wendashejiao_cat_cnt,two_wendashejiao_cat_cnt_7d_ago,two_wendashejiao_cat_cnt_1m_ago,two_wendashejiao_cat_cnt_3m_ago,two_wendashejiao_cat_cnt_6m_ago,two_xianzhiwupinzhuanrang_cat_cnt,two_xianzhiwupinzhuanrang_cat_cnt_7d_ago,two_xianzhiwupinzhuanrang_cat_cnt_1m_ago,two_xianzhiwupinzhuanrang_cat_cnt_3m_ago,two_xianzhiwupinzhuanrang_cat_cnt_6m_ago,two_yuedulei_cat_cnt,two_yuedulei_cat_cnt_7d_ago,two_yuedulei_cat_cnt_1m_ago,two_yuedulei_cat_cnt_3m_ago,two_yuedulei_cat_cnt_6m_ago,two_moshengrenshejiao_cat_cnt,two_moshengrenshejiao_cat_cnt_7d_ago,two_moshengrenshejiao_cat_cnt_1m_ago,two_moshengrenshejiao_cat_cnt_3m_ago,two_moshengrenshejiao_cat_cnt_6m_ago,two_jiakaofuwu_cat_cnt,two_jiakaofuwu_cat_cnt_7d_ago,two_jiakaofuwu_cat_cnt_1m_ago,two_jiakaofuwu_cat_cnt_3m_ago,two_jiakaofuwu_cat_cnt_6m_ago,two_gaoxiaobangong_cat_cnt,two_gaoxiaobangong_cat_cnt_7d_ago,two_gaoxiaobangong_cat_cnt_1m_ago,two_gaoxiaobangong_cat_cnt_3m_ago,two_gaoxiaobangong_cat_cnt_6m_ago,two_gaoduanqiuzhiAPP_cat_cnt,two_gaoduanqiuzhiAPP_cat_cnt_7d_ago,two_gaoduanqiuzhiAPP_cat_cnt_1m_ago,two_gaoduanqiuzhiAPP_cat_cnt_3m_ago,two_gaoduanqiuzhiAPP_cat_cnt_6m_ago,two_heichanzhongjie_cat_cnt,two_heichanzhongjie_cat_cnt_7d_ago,two_heichanzhongjie_cat_cnt_1m_ago,two_heichanzhongjie_cat_cnt_3m_ago,two_heichanzhongjie_cat_cnt_6m_ago,three_fuxianglei_cat_cnt,three_fuxianglei_cat_cnt_7d_ago,three_fuxianglei_cat_cnt_1m_ago,three_fuxianglei_cat_cnt_3m_ago,three_fuxianglei_cat_cnt_6m_ago,three_chaojizhengxianglei_cat_cnt,three_chaojizhengxianglei_cat_cnt_7d_ago,three_chaojizhengxianglei_cat_cnt_1m_ago,three_chaojizhengxianglei_cat_cnt_3m_ago,three_chaojizhengxianglei_cat_cnt_6m_ago,three_zhengxianglei_cat_cnt,three_zhengxianglei_cat_cnt_7d_ago,three_zhengxianglei_cat_cnt_1m_ago,three_zhengxianglei_cat_cnt_3m_ago,three_zhengxianglei_cat_cnt_6m_ago,portrait_shenfentezhi_cat_cnt,portrait_xiaofeizhifu_cat_cnt,portrait_duotoupinxing_cat_cnt,portrait_zicanzhuangkuang_cat_cnt,portrait_guanxiwangluo_cat_cnt,portrait_qita_cat_cnt,
one_WIFI_cat1_cat_cnt/app_total_num as one_WIFI_cat1_cat_rate,one_gerenzichan_cat_cnt/app_total_num as one_gerenzichan_cat_rate,one_zhongjieluntanAPP_cat_cnt/app_total_num as one_zhongjieluntanAPP_cat_rate,one_maifangzufang_cat1_cat_cnt/app_total_num as one_maifangzufang_cat1_cat_rate,one_qiyebangong_cat_cnt/app_total_num as one_qiyebangong_cat_rate,one_xiuxian_cat_cnt/app_total_num as one_xiuxian_cat_rate,one_zuobilei_cat1_cat_cnt/app_total_num as one_zuobilei_cat1_cat_rate,one_jiedailei_cat_cnt/app_total_num as one_jiedailei_cat_rate,one_jiankangyiliaoqita_cat_cnt/app_total_num as one_jiankangyiliaoqita_cat_rate,one_yiliaojiankang_cat_cnt/app_total_num as one_yiliaojiankang_cat_rate,one_shangcheng_cat_cnt/app_total_num as one_shangcheng_cat_rate,one_waimai_cat1_cat_cnt/app_total_num as one_waimai_cat1_cat_rate,one_taoqian_cat_cnt/app_total_num as one_taoqian_cat_rate,one_shechipin_cat1_cat_cnt/app_total_num as one_shechipin_cat1_cat_rate,one_xuexigongzuo_cat_cnt/app_total_num as one_xuexigongzuo_cat_rate,one_shiyonggongju_cat_cnt/app_total_num as one_shiyonggongju_cat_rate,one_xiaoweiqiyelei_cat1_cat_cnt/app_total_num as one_xiaoweiqiyelei_cat1_cat_rate,one_gongjulei_cat_cnt/app_total_num as one_gongjulei_cat_rate,one_yingyinyule_cat_cnt/app_total_num as one_yingyinyule_cat_rate,one_fangchan_cat_cnt/app_total_num as one_fangchan_cat_rate,one_luyouchuxing_cat_cnt/app_total_num as one_luyouchuxing_cat_rate,one_muyingjiaoyu_cat_cnt/app_total_num as one_muyingjiaoyu_cat_rate,one_qiuzhizhaopin_cat1_cat_cnt/app_total_num as one_qiuzhizhaopin_cat1_cat_rate,one_qichexiangguan_cat_cnt/app_total_num as one_qichexiangguan_cat_rate,one_shehuang_cat1_cat_cnt/app_total_num as one_shehuang_cat1_cat_rate,one_youxi_cat1_cat_cnt/app_total_num as one_youxi_cat1_cat_rate,one_shenghuo_cat_cnt/app_total_num as one_shenghuo_cat_rate,one_shenghuopinzhi_cat_cnt/app_total_num as one_shenghuopinzhi_cat_rate,one_dianshangpingtai_cat1_cat_cnt/app_total_num as one_dianshangpingtai_cat1_cat_rate,one_dianzizhengwuyuzhihuichengshi_cat_cnt/app_total_num as one_dianzizhengwuyuzhihuichengshi_cat_rate,one_shehuigongyi_cat_cnt/app_total_num as one_shehuigongyi_cat_rate,one_shebaogongjijin_cat_cnt/app_total_num as one_shebaogongjijin_cat_rate,one_xunihuobi_cat1_cat_cnt/app_total_num as one_xunihuobi_cat1_cat_rate,one_zixunyuedu_cat_cnt/app_total_num as one_zixunyuedu_cat_rate,one_dubo_cat_cnt/app_total_num as one_dubo_cat_rate,one_yundongyangsheng_cat_cnt/app_total_num as one_yundongyangsheng_cat_rate,one_tongxunshejiao_cat_cnt/app_total_num as one_tongxunshejiao_cat_rate,one_jinrongtuiguanglei_cat1_cat_cnt/app_total_num as one_jinrongtuiguanglei_cat1_cat_rate,one_jinrongfuwu_cat_cnt/app_total_num as one_jinrongfuwu_cat_rate,one_yinhanglei_cat_cnt/app_total_num as one_yinhanglei_cat_rate,one_heizhongjieluntanAPP_cat_cnt/app_total_num as one_heizhongjieluntanAPP_cat_rate,two_CRM_cat_cnt/app_total_num as two_CRM_cat_rate,two_P2P_cat_cnt/app_total_num as two_P2P_cat_rate,
two_WIFI_cat2_cat_cnt/app_total_num as two_WIFI_cat2_cat_rate,two_budongchan_cat_cnt/app_total_num as two_budongchan_cat_rate,two_yeneizhimingdaikuanAPP_cat_cnt/app_total_num as two_yeneizhimingdaikuanAPP_cat_rate,two_geshuidai_cat_cnt/app_total_num as two_geshuidai_cat_rate,two_maifangzufang_cat2_cat_cnt/app_total_num as two_maifangzufang_cat2_cat_rate,two_ershouchejiaoyi_cat_cnt/app_total_num as two_ershouchejiaoyi_cat_rate,two_erciyuan_cat_cnt/app_total_num as two_erciyuan_cat_rate,two_qiyexietong_cat_cnt/app_total_num as two_qiyexietong_cat_rate,two_zhongchouhuankuan_cat_cnt/app_total_num as two_zhongchouhuankuan_cat_rate,two_youzhijinrongkeji_cat_cnt/app_total_num as two_youzhijinrongkeji_cat_rate,two_chuanshubeifen_cat_cnt/app_total_num as two_chuanshubeifen_cat_rate,two_chuanxiao_cat_cnt/app_total_num as two_chuanxiao_cat_rate,two_diduanqiuzhiAPP_cat_cnt/app_total_num as two_diduanqiuzhiAPP_cat_rate,two_zhusufuwu_cat_cnt/app_total_num as two_zhusufuwu_cat_rate,two_tiyuzhibo_cat_cnt/app_total_num as two_tiyuzhibo_cat_rate,two_zuobilei_cat2_cat_cnt/app_total_num as two_zuobilei_cat2_cat_rate,two_baoxianlicai_cat_cnt/app_total_num as two_baoxianlicai_cat_rate,two_jiankangyundong_cat_cnt/app_total_num as two_jiankangyundong_cat_rate,two_ertongjiaoyu_cat_cnt/app_total_num as two_ertongjiaoyu_cat_rate,two_chongzhijiayou_cat_cnt/app_total_num as two_chongzhijiayou_cat_rate,two_mianshuidianziyingapp_cat_cnt/app_total_num as two_mianshuidianziyingapp_cat_rate,two_dangguojiaoyu_cat_cnt/app_total_num as two_dangguojiaoyu_cat_rate,two_gongwuyuankechengjiaoyu_cat_cnt/app_total_num as two_gongwuyuankechengjiaoyu_cat_rate,two_gongyi_cat_cnt/app_total_num as two_gongyi_cat_rate,two_gongjijin_cat_cnt/app_total_num as two_gongjijin_cat_rate,two_gongxiangbangong_cat_cnt/app_total_num as two_gongxiangbangong_cat_rate,two_qita_cat_cnt/app_total_num as two_qita_cat_rate,two_qitadaikuan_cat_cnt/app_total_num as two_qitadaikuan_cat_rate,two_nongcundianshang_cat_cnt/app_total_num as two_nongcundianshang_cat_rate,two_fenshenlei_cat_cnt/app_total_num as two_fenshenlei_cat_rate,two_shuadanlei_cat_cnt/app_total_num as two_shuadanlei_cat_rate,two_bangongchangsuozulin_cat_cnt/app_total_num as two_bangongchangsuozulin_cat_rate,two_zhunong_cat_cnt/app_total_num as two_zhunong_cat_rate,two_zhudai_cat_cnt/app_total_num as two_zhudai_cat_rate,two_baomingdailoandeapp_cat_cnt/app_total_num as two_baomingdailoandeapp_cat_rate,two_yiliao_cat_cnt/app_total_num as two_yiliao_cat_rate,two_yiliaozixun_cat_cnt/app_total_num as two_yiliaozixun_cat_rate,two_yiyao_cat_cnt/app_total_num as two_yiyao_cat_rate,two_bocailei_cat_cnt/app_total_num as two_bocailei_cat_rate,two_faxindai_cat_cnt/app_total_num as two_faxindai_cat_rate,two_sijijiedanlei_cat_cnt/app_total_num as two_sijijiedanlei_cat_rate,two_tongchengkuaidi_cat_cnt/app_total_num as two_tongchengkuaidi_cat_rate,two_shangwujiudian_cat_cnt/app_total_num as two_shangwujiudian_cat_rate,two_zaixianshipin_cat_cnt/app_total_num as two_zaixianshipin_cat_rate,two_zaixianyinyue_cat_cnt/app_total_num as two_zaixianyinyue_cat_rate,two_changjingxiaofeifenqi_cat_cnt/app_total_num as two_changjingxiaofeifenqi_cat_rate,two_chengshichuxing_cat_cnt/app_total_num as two_chengshichuxing_cat_rate,two_waimai_cat2_cat_cnt/app_total_num as two_waimai_cat2_cat_rate,two_daxuejiaoyu_cat_cnt/app_total_num as two_daxuejiaoyu_cat_rate,two_shechipin_cat2_cat_cnt/app_total_num as two_shechipin_cat2_cat_rate,two_yulezhibo_cat_cnt/app_total_num as two_yulezhibo_cat_rate,two_hunlianshejiao_cat_cnt/app_total_num as two_hunlianshejiao_cat_rate,two_anquanyouhua_cat_cnt/app_total_num as two_anquanyouhua_cat_rate,two_jiajujiazhuang_cat_cnt/app_total_num as two_jiajujiazhuang_cat_rate,two_xiaoweiqiyelei_cat2_cat_cnt/app_total_num as two_xiaoweiqiyelei_cat2_cat_rate,two_jujiafuwu_cat_cnt/app_total_num as two_jujiafuwu_cat_rate,two_gongzuochangjingshejiao_cat_cnt/app_total_num as two_gongzuochangjingshejiao_cat_rate,two_yingyongshichang_cat_cnt/app_total_num as two_yingyongshichang_cat_rate,two_chengrenjiaoyu_cat_cnt/app_total_num as two_chengrenjiaoyu_cat_rate,two_fangchanzhuangxiumaimai_cat_cnt/app_total_num as two_fangchanzhuangxiumaimai_cat_rate,two_fangwuxinxiAPP_cat_cnt/app_total_num as two_fangwuxinxiAPP_cat_rate,two_fangdaijisuanqi_cat_cnt/app_total_num as two_fangdaijisuanqi_cat_rate,two_shouyou_cat_cnt/app_total_num as two_shouyou_cat_rate,two_paizhaomeitu_cat_cnt/app_total_num as two_paizhaomeitu_cat_rate,two_zhaopinqiuzhi_cat_cnt/app_total_num as two_zhaopinqiuzhi_cat_rate,two_chipaixiaojin_cat_cnt/app_total_num as two_chipaixiaojin_cat_rate,two_wakuang_cat_cnt/app_total_num as two_wakuang_cat_rate,two_zhengwu_cat_cnt/app_total_num as two_zhengwu_cat_rate,two_xinnengyuanqichefuwu_cat_cnt/app_total_num as two_xinnengyuanqichefuwu_cat_rate,two_luyouAPP_cat_cnt/app_total_num as two_luyouAPP_cat_rate,two_luyouxiangguan_cat_cnt/app_total_num as two_luyouxiangguan_cat_rate,two_riliAPP_cat_cnt/app_total_num as two_riliAPP_cat_rate,two_shijianguanli_guihua_cat_cnt/app_total_num as two_shijianguanli_guihua_cat_rate,two_zhihuichengshi_cat_cnt/app_total_num as two_zhihuichengshi_cat_rate,two_zhinengjiaju_cat_cnt/app_total_num as two_zhinengjiaju_cat_rate,two_bendishenghuo_cat_cnt/app_total_num as two_bendishenghuo_cat_rate,two_jipiaoxiangguan_cat_cnt/app_total_num as two_jipiaoxiangguan_cat_rate,two_muying_cat_cnt/app_total_num as two_muying_cat_rate,two_muyingshenghuo_cat_cnt/app_total_num as two_muyingshenghuo_cat_rate,two_muyingdianshang_cat_cnt/app_total_num as two_muyingdianshang_cat_rate,two_qiuzhizhaopin_cat2_cat_cnt/app_total_num as two_qiuzhizhaopin_cat2_cat_rate,two_qichejiayoulei_cat_cnt/app_total_num as two_qichejiayoulei_cat_rate,two_qichepinpailei_cat_cnt/app_total_num as two_qichepinpailei_cat_rate,two_qicheguanfangpinpai_cat_cnt/app_total_num as two_qicheguanfangpinpai_cat_rate,two_qichezulin_cat_cnt/app_total_num as two_qichezulin_cat_rate,two_qichezonghezixun_cat_cnt/app_total_num as two_qichezonghezixun_cat_rate,two_falu_cat_cnt/app_total_num as two_falu_cat_rate,two_liulanqiAPP_cat_cnt/app_total_num as two_liulanqiAPP_cat_rate,two_haiwaidaigouapp_cat_cnt/app_total_num as two_haiwaidaigouapp_cat_rate,two_xiaofeijinrong_cat_cnt/app_total_num as two_xiaofeijinrong_cat_rate,two_shehuang_cat2_cat_cnt/app_total_num as two_shehuang_cat2_cat_rate,two_youxi_cat2_cat_cnt/app_total_num as two_youxi_cat2_cat_rate,two_youxiyule_cat_cnt/app_total_num as two_youxiyule_cat_rate,two_youxishejiao_cat_cnt/app_total_num as two_youxishejiao_cat_rate,two_youxilei_cat_cnt/app_total_num as two_youxilei_cat_rate,two_yanchupiaowu_cat_cnt/app_total_num as two_yanchupiaowu_cat_rate,two_shurenshejiao_cat_cnt/app_total_num as two_shurenshejiao_cat_rate,two_shengxiandianshang_cat_cnt/app_total_num as two_shengxiandianshang_cat_rate,two_dianshangpingtai_cat2_cat_cnt/app_total_num as two_dianshangpingtai_cat2_cat_rate,two_yisichuanxiao_cat_cnt/app_total_num as two_yisichuanxiao_cat_rate,two_zhiboshejiao_cat_cnt/app_total_num as two_zhiboshejiao_cat_rate,two_duanshipin_cat_cnt/app_total_num as two_duanshipin_cat_rate,two_shebaoshuiwu_cat_cnt/app_total_num as two_shebaoshuiwu_cat_rate,two_shequjiaoyou_cat_cnt/app_total_num as two_shequjiaoyou_cat_rate,two_shequfuwu_cat_cnt/app_total_num as two_shequfuwu_cat_rate,two_cuangaidingwei_cat_cnt/app_total_num as two_cuangaidingwei_cat_rate,two_suzhijiaoyu_cat_cnt/app_total_num as two_suzhijiaoyu_cat_rate,two_xianshangwangke_cat_cnt/app_total_num as two_xianshangwangke_cat_rate,two_zongheluyoufuwu_cat_cnt/app_total_num as two_zongheluyoufuwu_cat_rate,two_zonghedianshang_cat_cnt/app_total_num as two_zonghedianshang_cat_rate,two_zongheleishejiao_cat_cnt/app_total_num as two_zongheleishejiao_cat_rate,two_zonghezixun_cat_cnt/app_total_num as two_zonghezixun_cat_rate,two_zonghejinrong_cat_cnt/app_total_num as two_zonghejinrong_cat_rate,two_wangluoKge_cat_cnt/app_total_num as two_wangluoKge_cat_rate,two_meizhuang_cat_cnt/app_total_num as two_meizhuang_cat_rate,two_meishi_cat_cnt/app_total_num as two_meishi_cat_rate,two_fanyifuwu_cat_cnt/app_total_num as two_fanyifuwu_cat_rate,two_zhinengjishulei_cat_cnt/app_total_num as two_zhinengjishulei_cat_rate,two_hangkonggongsiguanfangAPP_cat_cnt/app_total_num as two_hangkonggongsiguanfangAPP_cat_rate,two_xunijiaoyi_cat_cnt/app_total_num as two_xunijiaoyi_cat_rate,two_xunihuobi_cat2_cat_cnt/app_total_num as two_xunihuobi_cat2_cat_rate,two_shipinhuiyi_cat_cnt/app_total_num as two_shipinhuiyi_cat_rate,two_shipinjianji_cat_cnt/app_total_num as two_shipinjianji_cat_rate,two_zhengquanfuwu_cat_cnt/app_total_num as two_zhengquanfuwu_cat_rate,two_yuyanfanyi_xuexi_cat_cnt/app_total_num as two_yuyanfanyi_xuexi_cat_rate,two_huobimaimaijiaoyi_cat_cnt/app_total_num as two_huobimaimaijiaoyi_cat_rate,two_huobixinxizixun_cat1_cat_cnt/app_total_num as two_huobixinxizixun_cat1_cat_rate,two_huobixinxizixun_cat2_cat_cnt/app_total_num as two_huobixinxizixun_cat2_cat_rate,two_huobiwakuanglei_cat_cnt/app_total_num as two_huobiwakuanglei_cat_rate,two_huobiqianbao_cat_cnt/app_total_num as two_huobiqianbao_cat_rate,two_daikuanlei_cat_cnt/app_total_num as two_daikuanlei_cat_rate,two_daichao_cat_cnt/app_total_num as two_daichao_cat_rate,two_zixunsousuo_cat_cnt/app_total_num as two_zixunsousuo_cat_rate,two_zixunlei_cat_cnt/app_total_num as two_zixunlei_cat_rate,two_chehoufuwu_cat_cnt/app_total_num as two_chehoufuwu_cat_rate,two_chepiaofuwu_cat_cnt/app_total_num as two_chepiaofuwu_cat_rate,two_cheliangfuwulei_cat_cnt/app_total_num as two_cheliangfuwulei_cat_rate,two_shurufa_cat_cnt/app_total_num as two_shurufa_cat_rate,two_yundongshoushen_cat_cnt/app_total_num as two_yundongshoushen_cat_rate,two_youxiangAPP_cat_cnt/app_total_num as two_youxiangAPP_cat_rate,two_jinrongtuiguanglei_cat2_cat_cnt/app_total_num as two_jinrongtuiguanglei_cat2_cat_rate,two_yinhangxinyongka_cat2_cat_cnt/app_total_num as two_yinhangxinyongka_cat2_cat_rate,two_yinhangxidaikuan_cat_cnt/app_total_num as two_yinhangxidaikuan_cat_rate,two_wendashejiao_cat_cnt/app_total_num as two_wendashejiao_cat_rate,two_xianzhiwupinzhuanrang_cat_cnt/app_total_num as two_xianzhiwupinzhuanrang_cat_rate,two_yuedulei_cat_cnt/app_total_num as two_yuedulei_cat_rate,two_moshengrenshejiao_cat_cnt/app_total_num as two_moshengrenshejiao_cat_rate,two_jiakaofuwu_cat_cnt/app_total_num as two_jiakaofuwu_cat_rate,two_gaoxiaobangong_cat_cnt/app_total_num as two_gaoxiaobangong_cat_rate,two_gaoduanqiuzhiAPP_cat_cnt/app_total_num as two_gaoduanqiuzhiAPP_cat_rate,two_heichanzhongjie_cat_cnt/app_total_num as two_heichanzhongjie_cat_rate,three_fuxianglei_cat_cnt/app_total_num as three_fuxianglei_cat_rate,three_chaojizhengxianglei_cat_cnt/app_total_num as three_chaojizhengxianglei_cat_rate,three_zhengxianglei_cat_cnt/app_total_num as three_zhengxianglei_cat_rate,

portrait_shenfentezhi_cat_cnt/app_total_num as portrait_shenfentezhi_cat_rate,portrait_xiaofeizhifu_cat_cnt/app_total_num as portrait_xiaofeizhifu_cat_rate,portrait_duotoupinxing_cat_cnt/app_total_num as portrait_duotoupinxing_cat_rate,portrait_zicanzhuangkuang_cat_cnt/app_total_num as portrait_zicanzhuangkuang_cat_rate,portrait_guanxiwangluo_cat_cnt/app_total_num as portrait_guanxiwangluo_cat_rate,portrait_qita_cat_cnt/app_total_num as portrait_qita_cat_rate
from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp06 as a
left join 
    (
    select 
        uid,
        ds,
        max(case when cat1= 'WIFI' then A1.cat_cnt_one end) as one_WIFI_cat1_cat_cnt,
        max(case when cat1= 'WIFI' then A1.cat_cnt_7d_ago_one end) as one_WIFI_cat1_cat_cnt_7d_ago,
        max(case when cat1= 'WIFI' then A1.cat_cnt_1m_ago_one end) as one_WIFI_cat1_cat_cnt_1m_ago,
        max(case when cat1= 'WIFI' then A1.cat_cnt_3m_ago_one end) as one_WIFI_cat1_cat_cnt_3m_ago,
        max(case when cat1= 'WIFI' then A1.cat_cnt_6m_ago_one end) as one_WIFI_cat1_cat_cnt_6m_ago,
        max(case when cat1= '个人资产' then A1.cat_cnt_one end) as one_gerenzichan_cat_cnt,
        max(case when cat1= '个人资产' then A1.cat_cnt_7d_ago_one end) as one_gerenzichan_cat_cnt_7d_ago,
        max(case when cat1= '个人资产' then A1.cat_cnt_1m_ago_one end) as one_gerenzichan_cat_cnt_1m_ago,
        max(case when cat1= '个人资产' then A1.cat_cnt_3m_ago_one end) as one_gerenzichan_cat_cnt_3m_ago,
        max(case when cat1= '个人资产' then A1.cat_cnt_6m_ago_one end) as one_gerenzichan_cat_cnt_6m_ago,
        max(case when cat1= '中介论坛APP' then A1.cat_cnt_one end) as one_zhongjieluntanAPP_cat_cnt,
        max(case when cat1= '中介论坛APP' then A1.cat_cnt_7d_ago_one end) as one_zhongjieluntanAPP_cat_cnt_7d_ago,
        max(case when cat1= '中介论坛APP' then A1.cat_cnt_1m_ago_one end) as one_zhongjieluntanAPP_cat_cnt_1m_ago,
        max(case when cat1= '中介论坛APP' then A1.cat_cnt_3m_ago_one end) as one_zhongjieluntanAPP_cat_cnt_3m_ago,
        max(case when cat1= '中介论坛APP' then A1.cat_cnt_6m_ago_one end) as one_zhongjieluntanAPP_cat_cnt_6m_ago,
        max(case when cat1= '买房租房' then A1.cat_cnt_one end) as one_maifangzufang_cat1_cat_cnt,
        max(case when cat1= '买房租房' then A1.cat_cnt_7d_ago_one end) as one_maifangzufang_cat1_cat_cnt_7d_ago,
        max(case when cat1= '买房租房' then A1.cat_cnt_1m_ago_one end) as one_maifangzufang_cat1_cat_cnt_1m_ago,
        max(case when cat1= '买房租房' then A1.cat_cnt_3m_ago_one end) as one_maifangzufang_cat1_cat_cnt_3m_ago,
        max(case when cat1= '买房租房' then A1.cat_cnt_6m_ago_one end) as one_maifangzufang_cat1_cat_cnt_6m_ago,
        max(case when cat1= '企业办公' then A1.cat_cnt_one end) as one_qiyebangong_cat_cnt,
        max(case when cat1= '企业办公' then A1.cat_cnt_7d_ago_one end) as one_qiyebangong_cat_cnt_7d_ago,
        max(case when cat1= '企业办公' then A1.cat_cnt_1m_ago_one end) as one_qiyebangong_cat_cnt_1m_ago,
        max(case when cat1= '企业办公' then A1.cat_cnt_3m_ago_one end) as one_qiyebangong_cat_cnt_3m_ago,
        max(case when cat1= '企业办公' then A1.cat_cnt_6m_ago_one end) as one_qiyebangong_cat_cnt_6m_ago,
        max(case when cat1= '休闲' then A1.cat_cnt_one end) as one_xiuxian_cat_cnt,
        max(case when cat1= '休闲' then A1.cat_cnt_7d_ago_one end) as one_xiuxian_cat_cnt_7d_ago,
        max(case when cat1= '休闲' then A1.cat_cnt_1m_ago_one end) as one_xiuxian_cat_cnt_1m_ago,
        max(case when cat1= '休闲' then A1.cat_cnt_3m_ago_one end) as one_xiuxian_cat_cnt_3m_ago,
        max(case when cat1= '休闲' then A1.cat_cnt_6m_ago_one end) as one_xiuxian_cat_cnt_6m_ago,
        max(case when cat1= '作弊类' then A1.cat_cnt_one end) as one_zuobilei_cat1_cat_cnt,
        max(case when cat1= '作弊类' then A1.cat_cnt_7d_ago_one end) as one_zuobilei_cat1_cat_cnt_7d_ago,
        max(case when cat1= '作弊类' then A1.cat_cnt_1m_ago_one end) as one_zuobilei_cat1_cat_cnt_1m_ago,
        max(case when cat1= '作弊类' then A1.cat_cnt_3m_ago_one end) as one_zuobilei_cat1_cat_cnt_3m_ago,
        max(case when cat1= '作弊类' then A1.cat_cnt_6m_ago_one end) as one_zuobilei_cat1_cat_cnt_6m_ago,
        max(case when cat1= '借贷类' then A1.cat_cnt_one end) as one_jiedailei_cat_cnt,
        max(case when cat1= '借贷类' then A1.cat_cnt_7d_ago_one end) as one_jiedailei_cat_cnt_7d_ago,
        max(case when cat1= '借贷类' then A1.cat_cnt_1m_ago_one end) as one_jiedailei_cat_cnt_1m_ago,
        max(case when cat1= '借贷类' then A1.cat_cnt_3m_ago_one end) as one_jiedailei_cat_cnt_3m_ago,
        max(case when cat1= '借贷类' then A1.cat_cnt_6m_ago_one end) as one_jiedailei_cat_cnt_6m_ago,
        max(case when cat1= '健康医疗其他' then A1.cat_cnt_one end) as one_jiankangyiliaoqita_cat_cnt,
        max(case when cat1= '健康医疗其他' then A1.cat_cnt_7d_ago_one end) as one_jiankangyiliaoqita_cat_cnt_7d_ago,
        max(case when cat1= '健康医疗其他' then A1.cat_cnt_1m_ago_one end) as one_jiankangyiliaoqita_cat_cnt_1m_ago,
        max(case when cat1= '健康医疗其他' then A1.cat_cnt_3m_ago_one end) as one_jiankangyiliaoqita_cat_cnt_3m_ago,
        max(case when cat1= '健康医疗其他' then A1.cat_cnt_6m_ago_one end) as one_jiankangyiliaoqita_cat_cnt_6m_ago,
        max(case when cat1= '医疗健康' then A1.cat_cnt_one end) as one_yiliaojiankang_cat_cnt,
        max(case when cat1= '医疗健康' then A1.cat_cnt_7d_ago_one end) as one_yiliaojiankang_cat_cnt_7d_ago,
        max(case when cat1= '医疗健康' then A1.cat_cnt_1m_ago_one end) as one_yiliaojiankang_cat_cnt_1m_ago,
        max(case when cat1= '医疗健康' then A1.cat_cnt_3m_ago_one end) as one_yiliaojiankang_cat_cnt_3m_ago,
        max(case when cat1= '医疗健康' then A1.cat_cnt_6m_ago_one end) as one_yiliaojiankang_cat_cnt_6m_ago,
        max(case when cat1= '商城' then A1.cat_cnt_one end) as one_shangcheng_cat_cnt,
        max(case when cat1= '商城' then A1.cat_cnt_7d_ago_one end) as one_shangcheng_cat_cnt_7d_ago,
        max(case when cat1= '商城' then A1.cat_cnt_1m_ago_one end) as one_shangcheng_cat_cnt_1m_ago,
        max(case when cat1= '商城' then A1.cat_cnt_3m_ago_one end) as one_shangcheng_cat_cnt_3m_ago,
        max(case when cat1= '商城' then A1.cat_cnt_6m_ago_one end) as one_shangcheng_cat_cnt_6m_ago,
        max(case when cat1= '外卖' then A1.cat_cnt_one end) as one_waimai_cat1_cat_cnt,
        max(case when cat1= '外卖' then A1.cat_cnt_7d_ago_one end) as one_waimai_cat1_cat_cnt_7d_ago,
        max(case when cat1= '外卖' then A1.cat_cnt_1m_ago_one end) as one_waimai_cat1_cat_cnt_1m_ago,
        max(case when cat1= '外卖' then A1.cat_cnt_3m_ago_one end) as one_waimai_cat1_cat_cnt_3m_ago,
        max(case when cat1= '外卖' then A1.cat_cnt_6m_ago_one end) as one_waimai_cat1_cat_cnt_6m_ago,
        max(case when cat1= '套钱' then A1.cat_cnt_one end) as one_taoqian_cat_cnt,
        max(case when cat1= '套钱' then A1.cat_cnt_7d_ago_one end) as one_taoqian_cat_cnt_7d_ago,
        max(case when cat1= '套钱' then A1.cat_cnt_1m_ago_one end) as one_taoqian_cat_cnt_1m_ago,
        max(case when cat1= '套钱' then A1.cat_cnt_3m_ago_one end) as one_taoqian_cat_cnt_3m_ago,
        max(case when cat1= '套钱' then A1.cat_cnt_6m_ago_one end) as one_taoqian_cat_cnt_6m_ago,
        max(case when cat1= '奢侈品' then A1.cat_cnt_one end) as one_shechipin_cat1_cat_cnt,
        max(case when cat1= '奢侈品' then A1.cat_cnt_7d_ago_one end) as one_shechipin_cat1_cat_cnt_7d_ago,
        max(case when cat1= '奢侈品' then A1.cat_cnt_1m_ago_one end) as one_shechipin_cat1_cat_cnt_1m_ago,
        max(case when cat1= '奢侈品' then A1.cat_cnt_3m_ago_one end) as one_shechipin_cat1_cat_cnt_3m_ago,
        max(case when cat1= '奢侈品' then A1.cat_cnt_6m_ago_one end) as one_shechipin_cat1_cat_cnt_6m_ago,
        max(case when cat1= '学习工作' then A1.cat_cnt_one end) as one_xuexigongzuo_cat_cnt,
        max(case when cat1= '学习工作' then A1.cat_cnt_7d_ago_one end) as one_xuexigongzuo_cat_cnt_7d_ago,
        max(case when cat1= '学习工作' then A1.cat_cnt_1m_ago_one end) as one_xuexigongzuo_cat_cnt_1m_ago,
        max(case when cat1= '学习工作' then A1.cat_cnt_3m_ago_one end) as one_xuexigongzuo_cat_cnt_3m_ago,
        max(case when cat1= '学习工作' then A1.cat_cnt_6m_ago_one end) as one_xuexigongzuo_cat_cnt_6m_ago,
        max(case when cat1= '实用工具' then A1.cat_cnt_one end) as one_shiyonggongju_cat_cnt,
        max(case when cat1= '实用工具' then A1.cat_cnt_7d_ago_one end) as one_shiyonggongju_cat_cnt_7d_ago,
        max(case when cat1= '实用工具' then A1.cat_cnt_1m_ago_one end) as one_shiyonggongju_cat_cnt_1m_ago,
        max(case when cat1= '实用工具' then A1.cat_cnt_3m_ago_one end) as one_shiyonggongju_cat_cnt_3m_ago,
        max(case when cat1= '实用工具' then A1.cat_cnt_6m_ago_one end) as one_shiyonggongju_cat_cnt_6m_ago,
        max(case when cat1= '小微企业类' then A1.cat_cnt_one end) as one_xiaoweiqiyelei_cat1_cat_cnt,
        max(case when cat1= '小微企业类' then A1.cat_cnt_7d_ago_one end) as one_xiaoweiqiyelei_cat1_cat_cnt_7d_ago,
        max(case when cat1= '小微企业类' then A1.cat_cnt_1m_ago_one end) as one_xiaoweiqiyelei_cat1_cat_cnt_1m_ago,
        max(case when cat1= '小微企业类' then A1.cat_cnt_3m_ago_one end) as one_xiaoweiqiyelei_cat1_cat_cnt_3m_ago,
        max(case when cat1= '小微企业类' then A1.cat_cnt_6m_ago_one end) as one_xiaoweiqiyelei_cat1_cat_cnt_6m_ago,
        max(case when cat1= '工具类' then A1.cat_cnt_one end) as one_gongjulei_cat_cnt,
        max(case when cat1= '工具类' then A1.cat_cnt_7d_ago_one end) as one_gongjulei_cat_cnt_7d_ago,
        max(case when cat1= '工具类' then A1.cat_cnt_1m_ago_one end) as one_gongjulei_cat_cnt_1m_ago,
        max(case when cat1= '工具类' then A1.cat_cnt_3m_ago_one end) as one_gongjulei_cat_cnt_3m_ago,
        max(case when cat1= '工具类' then A1.cat_cnt_6m_ago_one end) as one_gongjulei_cat_cnt_6m_ago,
        max(case when cat1= '影音娱乐' then A1.cat_cnt_one end) as one_yingyinyule_cat_cnt,
        max(case when cat1= '影音娱乐' then A1.cat_cnt_7d_ago_one end) as one_yingyinyule_cat_cnt_7d_ago,
        max(case when cat1= '影音娱乐' then A1.cat_cnt_1m_ago_one end) as one_yingyinyule_cat_cnt_1m_ago,
        max(case when cat1= '影音娱乐' then A1.cat_cnt_3m_ago_one end) as one_yingyinyule_cat_cnt_3m_ago,
        max(case when cat1= '影音娱乐' then A1.cat_cnt_6m_ago_one end) as one_yingyinyule_cat_cnt_6m_ago,
        max(case when cat1= '房产' then A1.cat_cnt_one end) as one_fangchan_cat_cnt,
        max(case when cat1= '房产' then A1.cat_cnt_7d_ago_one end) as one_fangchan_cat_cnt_7d_ago,
        max(case when cat1= '房产' then A1.cat_cnt_1m_ago_one end) as one_fangchan_cat_cnt_1m_ago,
        max(case when cat1= '房产' then A1.cat_cnt_3m_ago_one end) as one_fangchan_cat_cnt_3m_ago,
        max(case when cat1= '房产' then A1.cat_cnt_6m_ago_one end) as one_fangchan_cat_cnt_6m_ago,
        max(case when cat1= '旅游出行' then A1.cat_cnt_one end) as one_luyouchuxing_cat_cnt,
        max(case when cat1= '旅游出行' then A1.cat_cnt_7d_ago_one end) as one_luyouchuxing_cat_cnt_7d_ago,
        max(case when cat1= '旅游出行' then A1.cat_cnt_1m_ago_one end) as one_luyouchuxing_cat_cnt_1m_ago,
        max(case when cat1= '旅游出行' then A1.cat_cnt_3m_ago_one end) as one_luyouchuxing_cat_cnt_3m_ago,
        max(case when cat1= '旅游出行' then A1.cat_cnt_6m_ago_one end) as one_luyouchuxing_cat_cnt_6m_ago,
        max(case when cat1= '母婴教育' then A1.cat_cnt_one end) as one_muyingjiaoyu_cat_cnt,
        max(case when cat1= '母婴教育' then A1.cat_cnt_7d_ago_one end) as one_muyingjiaoyu_cat_cnt_7d_ago,
        max(case when cat1= '母婴教育' then A1.cat_cnt_1m_ago_one end) as one_muyingjiaoyu_cat_cnt_1m_ago,
        max(case when cat1= '母婴教育' then A1.cat_cnt_3m_ago_one end) as one_muyingjiaoyu_cat_cnt_3m_ago,
        max(case when cat1= '母婴教育' then A1.cat_cnt_6m_ago_one end) as one_muyingjiaoyu_cat_cnt_6m_ago,
        max(case when cat1= '求职招聘' then A1.cat_cnt_one end) as one_qiuzhizhaopin_cat1_cat_cnt,
        max(case when cat1= '求职招聘' then A1.cat_cnt_7d_ago_one end) as one_qiuzhizhaopin_cat1_cat_cnt_7d_ago,
        max(case when cat1= '求职招聘' then A1.cat_cnt_1m_ago_one end) as one_qiuzhizhaopin_cat1_cat_cnt_1m_ago,
        max(case when cat1= '求职招聘' then A1.cat_cnt_3m_ago_one end) as one_qiuzhizhaopin_cat1_cat_cnt_3m_ago,
        max(case when cat1= '求职招聘' then A1.cat_cnt_6m_ago_one end) as one_qiuzhizhaopin_cat1_cat_cnt_6m_ago,
        max(case when cat1= '汽车相关' then A1.cat_cnt_one end) as one_qichexiangguan_cat_cnt,
        max(case when cat1= '汽车相关' then A1.cat_cnt_7d_ago_one end) as one_qichexiangguan_cat_cnt_7d_ago,
        max(case when cat1= '汽车相关' then A1.cat_cnt_1m_ago_one end) as one_qichexiangguan_cat_cnt_1m_ago,
        max(case when cat1= '汽车相关' then A1.cat_cnt_3m_ago_one end) as one_qichexiangguan_cat_cnt_3m_ago,
        max(case when cat1= '汽车相关' then A1.cat_cnt_6m_ago_one end) as one_qichexiangguan_cat_cnt_6m_ago,
        max(case when cat1= '涉黄' then A1.cat_cnt_one end) as one_shehuang_cat1_cat_cnt,
        max(case when cat1= '涉黄' then A1.cat_cnt_7d_ago_one end) as one_shehuang_cat1_cat_cnt_7d_ago,
        max(case when cat1= '涉黄' then A1.cat_cnt_1m_ago_one end) as one_shehuang_cat1_cat_cnt_1m_ago,
        max(case when cat1= '涉黄' then A1.cat_cnt_3m_ago_one end) as one_shehuang_cat1_cat_cnt_3m_ago,
        max(case when cat1= '涉黄' then A1.cat_cnt_6m_ago_one end) as one_shehuang_cat1_cat_cnt_6m_ago,
        max(case when cat1= '游戏' then A1.cat_cnt_one end) as one_youxi_cat1_cat_cnt,
        max(case when cat1= '游戏' then A1.cat_cnt_7d_ago_one end) as one_youxi_cat1_cat_cnt_7d_ago,
        max(case when cat1= '游戏' then A1.cat_cnt_1m_ago_one end) as one_youxi_cat1_cat_cnt_1m_ago,
        max(case when cat1= '游戏' then A1.cat_cnt_3m_ago_one end) as one_youxi_cat1_cat_cnt_3m_ago,
        max(case when cat1= '游戏' then A1.cat_cnt_6m_ago_one end) as one_youxi_cat1_cat_cnt_6m_ago,
        max(case when cat1= '生活' then A1.cat_cnt_one end) as one_shenghuo_cat_cnt,
        max(case when cat1= '生活' then A1.cat_cnt_7d_ago_one end) as one_shenghuo_cat_cnt_7d_ago,
        max(case when cat1= '生活' then A1.cat_cnt_1m_ago_one end) as one_shenghuo_cat_cnt_1m_ago,
        max(case when cat1= '生活' then A1.cat_cnt_3m_ago_one end) as one_shenghuo_cat_cnt_3m_ago,
        max(case when cat1= '生活' then A1.cat_cnt_6m_ago_one end) as one_shenghuo_cat_cnt_6m_ago,
        max(case when cat1= '生活品质' then A1.cat_cnt_one end) as one_shenghuopinzhi_cat_cnt,
        max(case when cat1= '生活品质' then A1.cat_cnt_7d_ago_one end) as one_shenghuopinzhi_cat_cnt_7d_ago,
        max(case when cat1= '生活品质' then A1.cat_cnt_1m_ago_one end) as one_shenghuopinzhi_cat_cnt_1m_ago,
        max(case when cat1= '生活品质' then A1.cat_cnt_3m_ago_one end) as one_shenghuopinzhi_cat_cnt_3m_ago,
        max(case when cat1= '生活品质' then A1.cat_cnt_6m_ago_one end) as one_shenghuopinzhi_cat_cnt_6m_ago,
        max(case when cat1= '电商平台' then A1.cat_cnt_one end) as one_dianshangpingtai_cat1_cat_cnt,
        max(case when cat1= '电商平台' then A1.cat_cnt_7d_ago_one end) as one_dianshangpingtai_cat1_cat_cnt_7d_ago,
        max(case when cat1= '电商平台' then A1.cat_cnt_1m_ago_one end) as one_dianshangpingtai_cat1_cat_cnt_1m_ago,
        max(case when cat1= '电商平台' then A1.cat_cnt_3m_ago_one end) as one_dianshangpingtai_cat1_cat_cnt_3m_ago,
        max(case when cat1= '电商平台' then A1.cat_cnt_6m_ago_one end) as one_dianshangpingtai_cat1_cat_cnt_6m_ago,
        max(case when cat1= '电子政务与智慧城市' then A1.cat_cnt_one end) as one_dianzizhengwuyuzhihuichengshi_cat_cnt,
        max(case when cat1= '电子政务与智慧城市' then A1.cat_cnt_7d_ago_one end) as one_dianzizhengwuyuzhihuichengshi_cat_cnt_7d_ago,
        max(case when cat1= '电子政务与智慧城市' then A1.cat_cnt_1m_ago_one end) as one_dianzizhengwuyuzhihuichengshi_cat_cnt_1m_ago,
        max(case when cat1= '电子政务与智慧城市' then A1.cat_cnt_3m_ago_one end) as one_dianzizhengwuyuzhihuichengshi_cat_cnt_3m_ago,
        max(case when cat1= '电子政务与智慧城市' then A1.cat_cnt_6m_ago_one end) as one_dianzizhengwuyuzhihuichengshi_cat_cnt_6m_ago,
        max(case when cat1= '社会公益' then A1.cat_cnt_one end) as one_shehuigongyi_cat_cnt,
        max(case when cat1= '社会公益' then A1.cat_cnt_7d_ago_one end) as one_shehuigongyi_cat_cnt_7d_ago,
        max(case when cat1= '社会公益' then A1.cat_cnt_1m_ago_one end) as one_shehuigongyi_cat_cnt_1m_ago,
        max(case when cat1= '社会公益' then A1.cat_cnt_3m_ago_one end) as one_shehuigongyi_cat_cnt_3m_ago,
        max(case when cat1= '社会公益' then A1.cat_cnt_6m_ago_one end) as one_shehuigongyi_cat_cnt_6m_ago,
        max(case when cat1= '社保公积金' then A1.cat_cnt_one end) as one_shebaogongjijin_cat_cnt,
        max(case when cat1= '社保公积金' then A1.cat_cnt_7d_ago_one end) as one_shebaogongjijin_cat_cnt_7d_ago,
        max(case when cat1= '社保公积金' then A1.cat_cnt_1m_ago_one end) as one_shebaogongjijin_cat_cnt_1m_ago,
        max(case when cat1= '社保公积金' then A1.cat_cnt_3m_ago_one end) as one_shebaogongjijin_cat_cnt_3m_ago,
        max(case when cat1= '社保公积金' then A1.cat_cnt_6m_ago_one end) as one_shebaogongjijin_cat_cnt_6m_ago,
        max(case when cat1= '虚拟货币' then A1.cat_cnt_one end) as one_xunihuobi_cat1_cat_cnt,
        max(case when cat1= '虚拟货币' then A1.cat_cnt_7d_ago_one end) as one_xunihuobi_cat1_cat_cnt_7d_ago,
        max(case when cat1= '虚拟货币' then A1.cat_cnt_1m_ago_one end) as one_xunihuobi_cat1_cat_cnt_1m_ago,
        max(case when cat1= '虚拟货币' then A1.cat_cnt_3m_ago_one end) as one_xunihuobi_cat1_cat_cnt_3m_ago,
        max(case when cat1= '虚拟货币' then A1.cat_cnt_6m_ago_one end) as one_xunihuobi_cat1_cat_cnt_6m_ago,
        max(case when cat1= '资讯阅读' then A1.cat_cnt_one end) as one_zixunyuedu_cat_cnt,
        max(case when cat1= '资讯阅读' then A1.cat_cnt_7d_ago_one end) as one_zixunyuedu_cat_cnt_7d_ago,
        max(case when cat1= '资讯阅读' then A1.cat_cnt_1m_ago_one end) as one_zixunyuedu_cat_cnt_1m_ago,
        max(case when cat1= '资讯阅读' then A1.cat_cnt_3m_ago_one end) as one_zixunyuedu_cat_cnt_3m_ago,
        max(case when cat1= '资讯阅读' then A1.cat_cnt_6m_ago_one end) as one_zixunyuedu_cat_cnt_6m_ago,
        max(case when cat1= '赌博' then A1.cat_cnt_one end) as one_dubo_cat_cnt,
        max(case when cat1= '赌博' then A1.cat_cnt_7d_ago_one end) as one_dubo_cat_cnt_7d_ago,
        max(case when cat1= '赌博' then A1.cat_cnt_1m_ago_one end) as one_dubo_cat_cnt_1m_ago,
        max(case when cat1= '赌博' then A1.cat_cnt_3m_ago_one end) as one_dubo_cat_cnt_3m_ago,
        max(case when cat1= '赌博' then A1.cat_cnt_6m_ago_one end) as one_dubo_cat_cnt_6m_ago,
        max(case when cat1= '运动养生' then A1.cat_cnt_one end) as one_yundongyangsheng_cat_cnt,
        max(case when cat1= '运动养生' then A1.cat_cnt_7d_ago_one end) as one_yundongyangsheng_cat_cnt_7d_ago,
        max(case when cat1= '运动养生' then A1.cat_cnt_1m_ago_one end) as one_yundongyangsheng_cat_cnt_1m_ago,
        max(case when cat1= '运动养生' then A1.cat_cnt_3m_ago_one end) as one_yundongyangsheng_cat_cnt_3m_ago,
        max(case when cat1= '运动养生' then A1.cat_cnt_6m_ago_one end) as one_yundongyangsheng_cat_cnt_6m_ago,
        max(case when cat1= '通讯社交' then A1.cat_cnt_one end) as one_tongxunshejiao_cat_cnt,
        max(case when cat1= '通讯社交' then A1.cat_cnt_7d_ago_one end) as one_tongxunshejiao_cat_cnt_7d_ago,
        max(case when cat1= '通讯社交' then A1.cat_cnt_1m_ago_one end) as one_tongxunshejiao_cat_cnt_1m_ago,
        max(case when cat1= '通讯社交' then A1.cat_cnt_3m_ago_one end) as one_tongxunshejiao_cat_cnt_3m_ago,
        max(case when cat1= '通讯社交' then A1.cat_cnt_6m_ago_one end) as one_tongxunshejiao_cat_cnt_6m_ago,
        max(case when cat1= '金融推广类' then A1.cat_cnt_one end) as one_jinrongtuiguanglei_cat1_cat_cnt,
        max(case when cat1= '金融推广类' then A1.cat_cnt_7d_ago_one end) as one_jinrongtuiguanglei_cat1_cat_cnt_7d_ago,
        max(case when cat1= '金融推广类' then A1.cat_cnt_1m_ago_one end) as one_jinrongtuiguanglei_cat1_cat_cnt_1m_ago,
        max(case when cat1= '金融推广类' then A1.cat_cnt_3m_ago_one end) as one_jinrongtuiguanglei_cat1_cat_cnt_3m_ago,
        max(case when cat1= '金融推广类' then A1.cat_cnt_6m_ago_one end) as one_jinrongtuiguanglei_cat1_cat_cnt_6m_ago,
        max(case when cat1= '金融服务' then A1.cat_cnt_one end) as one_jinrongfuwu_cat_cnt,
        max(case when cat1= '金融服务' then A1.cat_cnt_7d_ago_one end) as one_jinrongfuwu_cat_cnt_7d_ago,
        max(case when cat1= '金融服务' then A1.cat_cnt_1m_ago_one end) as one_jinrongfuwu_cat_cnt_1m_ago,
        max(case when cat1= '金融服务' then A1.cat_cnt_3m_ago_one end) as one_jinrongfuwu_cat_cnt_3m_ago,
        max(case when cat1= '金融服务' then A1.cat_cnt_6m_ago_one end) as one_jinrongfuwu_cat_cnt_6m_ago,
        max(case when cat1= '银行类' then A1.cat_cnt_one end) as one_yinhanglei_cat_cnt,
        max(case when cat1= '银行类' then A1.cat_cnt_7d_ago_one end) as one_yinhanglei_cat_cnt_7d_ago,
        max(case when cat1= '银行类' then A1.cat_cnt_1m_ago_one end) as one_yinhanglei_cat_cnt_1m_ago,
        max(case when cat1= '银行类' then A1.cat_cnt_3m_ago_one end) as one_yinhanglei_cat_cnt_3m_ago,
        max(case when cat1= '银行类' then A1.cat_cnt_6m_ago_one end) as one_yinhanglei_cat_cnt_6m_ago,
        max(case when cat1= '黑中介论坛APP' then A1.cat_cnt_one end) as one_heizhongjieluntanAPP_cat_cnt,
        max(case when cat1= '黑中介论坛APP' then A1.cat_cnt_7d_ago_one end) as one_heizhongjieluntanAPP_cat_cnt_7d_ago,
        max(case when cat1= '黑中介论坛APP' then A1.cat_cnt_1m_ago_one end) as one_heizhongjieluntanAPP_cat_cnt_1m_ago,
        max(case when cat1= '黑中介论坛APP' then A1.cat_cnt_3m_ago_one end) as one_heizhongjieluntanAPP_cat_cnt_3m_ago,
        max(case when cat1= '黑中介论坛APP' then A1.cat_cnt_6m_ago_one end) as one_heizhongjieluntanAPP_cat_cnt_6m_ago
    from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp03 A1
    group by uid , ds
    ) B1 on a.uid = B1.uid and a.ds = B1.ds

left join 
    (
    select 
        uid,
        ds,
        max(case when cat2= 'CRM' then A2.cat_cnt_two end) as two_CRM_cat_cnt,
        max(case when cat2= 'CRM' then A2.cat_cnt_7d_ago_two end) as two_CRM_cat_cnt_7d_ago,
        max(case when cat2= 'CRM' then A2.cat_cnt_1m_ago_two end) as two_CRM_cat_cnt_1m_ago,
        max(case when cat2= 'CRM' then A2.cat_cnt_3m_ago_two end) as two_CRM_cat_cnt_3m_ago,
        max(case when cat2= 'CRM' then A2.cat_cnt_6m_ago_two end) as two_CRM_cat_cnt_6m_ago,
        max(case when cat2= 'P2P' then A2.cat_cnt_two end) as two_P2P_cat_cnt,
        max(case when cat2= 'P2P' then A2.cat_cnt_7d_ago_two end) as two_P2P_cat_cnt_7d_ago,
        max(case when cat2= 'P2P' then A2.cat_cnt_1m_ago_two end) as two_P2P_cat_cnt_1m_ago,
        max(case when cat2= 'P2P' then A2.cat_cnt_3m_ago_two end) as two_P2P_cat_cnt_3m_ago,
        max(case when cat2= 'P2P' then A2.cat_cnt_6m_ago_two end) as two_P2P_cat_cnt_6m_ago,
        max(case when cat2= 'WIFI' then A2.cat_cnt_two end) as two_WIFI_cat2_cat_cnt,
        max(case when cat2= 'WIFI' then A2.cat_cnt_7d_ago_two end) as two_WIFI_cat2_cat_cnt_7d_ago,
        max(case when cat2= 'WIFI' then A2.cat_cnt_1m_ago_two end) as two_WIFI_cat2_cat_cnt_1m_ago,
        max(case when cat2= 'WIFI' then A2.cat_cnt_3m_ago_two end) as two_WIFI_cat2_cat_cnt_3m_ago,
        max(case when cat2= 'WIFI' then A2.cat_cnt_6m_ago_two end) as two_WIFI_cat2_cat_cnt_6m_ago,
        max(case when cat2= '不动产' then A2.cat_cnt_two end) as two_budongchan_cat_cnt,
        max(case when cat2= '不动产' then A2.cat_cnt_7d_ago_two end) as two_budongchan_cat_cnt_7d_ago,
        max(case when cat2= '不动产' then A2.cat_cnt_1m_ago_two end) as two_budongchan_cat_cnt_1m_ago,
        max(case when cat2= '不动产' then A2.cat_cnt_3m_ago_two end) as two_budongchan_cat_cnt_3m_ago,
        max(case when cat2= '不动产' then A2.cat_cnt_6m_ago_two end) as two_budongchan_cat_cnt_6m_ago,
        max(case when cat2= '业内知名贷款APP' then A2.cat_cnt_two end) as two_yeneizhimingdaikuanAPP_cat_cnt,
        max(case when cat2= '业内知名贷款APP' then A2.cat_cnt_7d_ago_two end) as two_yeneizhimingdaikuanAPP_cat_cnt_7d_ago,
        max(case when cat2= '业内知名贷款APP' then A2.cat_cnt_1m_ago_two end) as two_yeneizhimingdaikuanAPP_cat_cnt_1m_ago,
        max(case when cat2= '业内知名贷款APP' then A2.cat_cnt_3m_ago_two end) as two_yeneizhimingdaikuanAPP_cat_cnt_3m_ago,
        max(case when cat2= '业内知名贷款APP' then A2.cat_cnt_6m_ago_two end) as two_yeneizhimingdaikuanAPP_cat_cnt_6m_ago,
        max(case when cat2= '个税贷' then A2.cat_cnt_two end) as two_geshuidai_cat_cnt,
        max(case when cat2= '个税贷' then A2.cat_cnt_7d_ago_two end) as two_geshuidai_cat_cnt_7d_ago,
        max(case when cat2= '个税贷' then A2.cat_cnt_1m_ago_two end) as two_geshuidai_cat_cnt_1m_ago,
        max(case when cat2= '个税贷' then A2.cat_cnt_3m_ago_two end) as two_geshuidai_cat_cnt_3m_ago,
        max(case when cat2= '个税贷' then A2.cat_cnt_6m_ago_two end) as two_geshuidai_cat_cnt_6m_ago,
        max(case when cat2= '买房租房' then A2.cat_cnt_two end) as two_maifangzufang_cat2_cat_cnt,
        max(case when cat2= '买房租房' then A2.cat_cnt_7d_ago_two end) as two_maifangzufang_cat2_cat_cnt_7d_ago,
        max(case when cat2= '买房租房' then A2.cat_cnt_1m_ago_two end) as two_maifangzufang_cat2_cat_cnt_1m_ago,
        max(case when cat2= '买房租房' then A2.cat_cnt_3m_ago_two end) as two_maifangzufang_cat2_cat_cnt_3m_ago,
        max(case when cat2= '买房租房' then A2.cat_cnt_6m_ago_two end) as two_maifangzufang_cat2_cat_cnt_6m_ago,
        max(case when cat2= '二手车交易' then A2.cat_cnt_two end) as two_ershouchejiaoyi_cat_cnt,
        max(case when cat2= '二手车交易' then A2.cat_cnt_7d_ago_two end) as two_ershouchejiaoyi_cat_cnt_7d_ago,
        max(case when cat2= '二手车交易' then A2.cat_cnt_1m_ago_two end) as two_ershouchejiaoyi_cat_cnt_1m_ago,
        max(case when cat2= '二手车交易' then A2.cat_cnt_3m_ago_two end) as two_ershouchejiaoyi_cat_cnt_3m_ago,
        max(case when cat2= '二手车交易' then A2.cat_cnt_6m_ago_two end) as two_ershouchejiaoyi_cat_cnt_6m_ago,
        max(case when cat2= '二次元' then A2.cat_cnt_two end) as two_erciyuan_cat_cnt,
        max(case when cat2= '二次元' then A2.cat_cnt_7d_ago_two end) as two_erciyuan_cat_cnt_7d_ago,
        max(case when cat2= '二次元' then A2.cat_cnt_1m_ago_two end) as two_erciyuan_cat_cnt_1m_ago,
        max(case when cat2= '二次元' then A2.cat_cnt_3m_ago_two end) as two_erciyuan_cat_cnt_3m_ago,
        max(case when cat2= '二次元' then A2.cat_cnt_6m_ago_two end) as two_erciyuan_cat_cnt_6m_ago,
        max(case when cat2= '企业协同' then A2.cat_cnt_two end) as two_qiyexietong_cat_cnt,
        max(case when cat2= '企业协同' then A2.cat_cnt_7d_ago_two end) as two_qiyexietong_cat_cnt_7d_ago,
        max(case when cat2= '企业协同' then A2.cat_cnt_1m_ago_two end) as two_qiyexietong_cat_cnt_1m_ago,
        max(case when cat2= '企业协同' then A2.cat_cnt_3m_ago_two end) as two_qiyexietong_cat_cnt_3m_ago,
        max(case when cat2= '企业协同' then A2.cat_cnt_6m_ago_two end) as two_qiyexietong_cat_cnt_6m_ago,
        max(case when cat2= '众筹还款' then A2.cat_cnt_two end) as two_zhongchouhuankuan_cat_cnt,
        max(case when cat2= '众筹还款' then A2.cat_cnt_7d_ago_two end) as two_zhongchouhuankuan_cat_cnt_7d_ago,
        max(case when cat2= '众筹还款' then A2.cat_cnt_1m_ago_two end) as two_zhongchouhuankuan_cat_cnt_1m_ago,
        max(case when cat2= '众筹还款' then A2.cat_cnt_3m_ago_two end) as two_zhongchouhuankuan_cat_cnt_3m_ago,
        max(case when cat2= '众筹还款' then A2.cat_cnt_6m_ago_two end) as two_zhongchouhuankuan_cat_cnt_6m_ago,
        max(case when cat2= '优质金融科技' then A2.cat_cnt_two end) as two_youzhijinrongkeji_cat_cnt,
        max(case when cat2= '优质金融科技' then A2.cat_cnt_7d_ago_two end) as two_youzhijinrongkeji_cat_cnt_7d_ago,
        max(case when cat2= '优质金融科技' then A2.cat_cnt_1m_ago_two end) as two_youzhijinrongkeji_cat_cnt_1m_ago,
        max(case when cat2= '优质金融科技' then A2.cat_cnt_3m_ago_two end) as two_youzhijinrongkeji_cat_cnt_3m_ago,
        max(case when cat2= '优质金融科技' then A2.cat_cnt_6m_ago_two end) as two_youzhijinrongkeji_cat_cnt_6m_ago,
        max(case when cat2= '传输备份' then A2.cat_cnt_two end) as two_chuanshubeifen_cat_cnt,
        max(case when cat2= '传输备份' then A2.cat_cnt_7d_ago_two end) as two_chuanshubeifen_cat_cnt_7d_ago,
        max(case when cat2= '传输备份' then A2.cat_cnt_1m_ago_two end) as two_chuanshubeifen_cat_cnt_1m_ago,
        max(case when cat2= '传输备份' then A2.cat_cnt_3m_ago_two end) as two_chuanshubeifen_cat_cnt_3m_ago,
        max(case when cat2= '传输备份' then A2.cat_cnt_6m_ago_two end) as two_chuanshubeifen_cat_cnt_6m_ago,
        max(case when cat2= '传销' then A2.cat_cnt_two end) as two_chuanxiao_cat_cnt,
        max(case when cat2= '传销' then A2.cat_cnt_7d_ago_two end) as two_chuanxiao_cat_cnt_7d_ago,
        max(case when cat2= '传销' then A2.cat_cnt_1m_ago_two end) as two_chuanxiao_cat_cnt_1m_ago,
        max(case when cat2= '传销' then A2.cat_cnt_3m_ago_two end) as two_chuanxiao_cat_cnt_3m_ago,
        max(case when cat2= '传销' then A2.cat_cnt_6m_ago_two end) as two_chuanxiao_cat_cnt_6m_ago,
        max(case when cat2= '低端求职APP' then A2.cat_cnt_two end) as two_diduanqiuzhiAPP_cat_cnt,
        max(case when cat2= '低端求职APP' then A2.cat_cnt_7d_ago_two end) as two_diduanqiuzhiAPP_cat_cnt_7d_ago,
        max(case when cat2= '低端求职APP' then A2.cat_cnt_1m_ago_two end) as two_diduanqiuzhiAPP_cat_cnt_1m_ago,
        max(case when cat2= '低端求职APP' then A2.cat_cnt_3m_ago_two end) as two_diduanqiuzhiAPP_cat_cnt_3m_ago,
        max(case when cat2= '低端求职APP' then A2.cat_cnt_6m_ago_two end) as two_diduanqiuzhiAPP_cat_cnt_6m_ago,
        max(case when cat2= '住宿服务' then A2.cat_cnt_two end) as two_zhusufuwu_cat_cnt,
        max(case when cat2= '住宿服务' then A2.cat_cnt_7d_ago_two end) as two_zhusufuwu_cat_cnt_7d_ago,
        max(case when cat2= '住宿服务' then A2.cat_cnt_1m_ago_two end) as two_zhusufuwu_cat_cnt_1m_ago,
        max(case when cat2= '住宿服务' then A2.cat_cnt_3m_ago_two end) as two_zhusufuwu_cat_cnt_3m_ago,
        max(case when cat2= '住宿服务' then A2.cat_cnt_6m_ago_two end) as two_zhusufuwu_cat_cnt_6m_ago,
        max(case when cat2= '体育直播' then A2.cat_cnt_two end) as two_tiyuzhibo_cat_cnt,
        max(case when cat2= '体育直播' then A2.cat_cnt_7d_ago_two end) as two_tiyuzhibo_cat_cnt_7d_ago,
        max(case when cat2= '体育直播' then A2.cat_cnt_1m_ago_two end) as two_tiyuzhibo_cat_cnt_1m_ago,
        max(case when cat2= '体育直播' then A2.cat_cnt_3m_ago_two end) as two_tiyuzhibo_cat_cnt_3m_ago,
        max(case when cat2= '体育直播' then A2.cat_cnt_6m_ago_two end) as two_tiyuzhibo_cat_cnt_6m_ago,
        max(case when cat2= '作弊类' then A2.cat_cnt_two end) as two_zuobilei_cat2_cat_cnt,
        max(case when cat2= '作弊类' then A2.cat_cnt_7d_ago_two end) as two_zuobilei_cat2_cat_cnt_7d_ago,
        max(case when cat2= '作弊类' then A2.cat_cnt_1m_ago_two end) as two_zuobilei_cat2_cat_cnt_1m_ago,
        max(case when cat2= '作弊类' then A2.cat_cnt_3m_ago_two end) as two_zuobilei_cat2_cat_cnt_3m_ago,
        max(case when cat2= '作弊类' then A2.cat_cnt_6m_ago_two end) as two_zuobilei_cat2_cat_cnt_6m_ago,
        max(case when cat2= '保险理财' then A2.cat_cnt_two end) as two_baoxianlicai_cat_cnt,
        max(case when cat2= '保险理财' then A2.cat_cnt_7d_ago_two end) as two_baoxianlicai_cat_cnt_7d_ago,
        max(case when cat2= '保险理财' then A2.cat_cnt_1m_ago_two end) as two_baoxianlicai_cat_cnt_1m_ago,
        max(case when cat2= '保险理财' then A2.cat_cnt_3m_ago_two end) as two_baoxianlicai_cat_cnt_3m_ago,
        max(case when cat2= '保险理财' then A2.cat_cnt_6m_ago_two end) as two_baoxianlicai_cat_cnt_6m_ago,
        max(case when cat2= '健康运动' then A2.cat_cnt_two end) as two_jiankangyundong_cat_cnt,
        max(case when cat2= '健康运动' then A2.cat_cnt_7d_ago_two end) as two_jiankangyundong_cat_cnt_7d_ago,
        max(case when cat2= '健康运动' then A2.cat_cnt_1m_ago_two end) as two_jiankangyundong_cat_cnt_1m_ago,
        max(case when cat2= '健康运动' then A2.cat_cnt_3m_ago_two end) as two_jiankangyundong_cat_cnt_3m_ago,
        max(case when cat2= '健康运动' then A2.cat_cnt_6m_ago_two end) as two_jiankangyundong_cat_cnt_6m_ago,
        max(case when cat2= '儿童教育' then A2.cat_cnt_two end) as two_ertongjiaoyu_cat_cnt,
        max(case when cat2= '儿童教育' then A2.cat_cnt_7d_ago_two end) as two_ertongjiaoyu_cat_cnt_7d_ago,
        max(case when cat2= '儿童教育' then A2.cat_cnt_1m_ago_two end) as two_ertongjiaoyu_cat_cnt_1m_ago,
        max(case when cat2= '儿童教育' then A2.cat_cnt_3m_ago_two end) as two_ertongjiaoyu_cat_cnt_3m_ago,
        max(case when cat2= '儿童教育' then A2.cat_cnt_6m_ago_two end) as two_ertongjiaoyu_cat_cnt_6m_ago,
        max(case when cat2= '充值加油' then A2.cat_cnt_two end) as two_chongzhijiayou_cat_cnt,
        max(case when cat2= '充值加油' then A2.cat_cnt_7d_ago_two end) as two_chongzhijiayou_cat_cnt_7d_ago,
        max(case when cat2= '充值加油' then A2.cat_cnt_1m_ago_two end) as two_chongzhijiayou_cat_cnt_1m_ago,
        max(case when cat2= '充值加油' then A2.cat_cnt_3m_ago_two end) as two_chongzhijiayou_cat_cnt_3m_ago,
        max(case when cat2= '充值加油' then A2.cat_cnt_6m_ago_two end) as two_chongzhijiayou_cat_cnt_6m_ago,
        max(case when cat2= '免税店自营app' then A2.cat_cnt_two end) as two_mianshuidianziyingapp_cat_cnt,
        max(case when cat2= '免税店自营app' then A2.cat_cnt_7d_ago_two end) as two_mianshuidianziyingapp_cat_cnt_7d_ago,
        max(case when cat2= '免税店自营app' then A2.cat_cnt_1m_ago_two end) as two_mianshuidianziyingapp_cat_cnt_1m_ago,
        max(case when cat2= '免税店自营app' then A2.cat_cnt_3m_ago_two end) as two_mianshuidianziyingapp_cat_cnt_3m_ago,
        max(case when cat2= '免税店自营app' then A2.cat_cnt_6m_ago_two end) as two_mianshuidianziyingapp_cat_cnt_6m_ago,
        max(case when cat2= '党国教育' then A2.cat_cnt_two end) as two_dangguojiaoyu_cat_cnt,
        max(case when cat2= '党国教育' then A2.cat_cnt_7d_ago_two end) as two_dangguojiaoyu_cat_cnt_7d_ago,
        max(case when cat2= '党国教育' then A2.cat_cnt_1m_ago_two end) as two_dangguojiaoyu_cat_cnt_1m_ago,
        max(case when cat2= '党国教育' then A2.cat_cnt_3m_ago_two end) as two_dangguojiaoyu_cat_cnt_3m_ago,
        max(case when cat2= '党国教育' then A2.cat_cnt_6m_ago_two end) as two_dangguojiaoyu_cat_cnt_6m_ago,
        max(case when cat2= '公务员课程教育' then A2.cat_cnt_two end) as two_gongwuyuankechengjiaoyu_cat_cnt,
        max(case when cat2= '公务员课程教育' then A2.cat_cnt_7d_ago_two end) as two_gongwuyuankechengjiaoyu_cat_cnt_7d_ago,
        max(case when cat2= '公务员课程教育' then A2.cat_cnt_1m_ago_two end) as two_gongwuyuankechengjiaoyu_cat_cnt_1m_ago,
        max(case when cat2= '公务员课程教育' then A2.cat_cnt_3m_ago_two end) as two_gongwuyuankechengjiaoyu_cat_cnt_3m_ago,
        max(case when cat2= '公务员课程教育' then A2.cat_cnt_6m_ago_two end) as two_gongwuyuankechengjiaoyu_cat_cnt_6m_ago,
        max(case when cat2= '公益' then A2.cat_cnt_two end) as two_gongyi_cat_cnt,
        max(case when cat2= '公益' then A2.cat_cnt_7d_ago_two end) as two_gongyi_cat_cnt_7d_ago,
        max(case when cat2= '公益' then A2.cat_cnt_1m_ago_two end) as two_gongyi_cat_cnt_1m_ago,
        max(case when cat2= '公益' then A2.cat_cnt_3m_ago_two end) as two_gongyi_cat_cnt_3m_ago,
        max(case when cat2= '公益' then A2.cat_cnt_6m_ago_two end) as two_gongyi_cat_cnt_6m_ago,
        max(case when cat2= '公积金' then A2.cat_cnt_two end) as two_gongjijin_cat_cnt,
        max(case when cat2= '公积金' then A2.cat_cnt_7d_ago_two end) as two_gongjijin_cat_cnt_7d_ago,
        max(case when cat2= '公积金' then A2.cat_cnt_1m_ago_two end) as two_gongjijin_cat_cnt_1m_ago,
        max(case when cat2= '公积金' then A2.cat_cnt_3m_ago_two end) as two_gongjijin_cat_cnt_3m_ago,
        max(case when cat2= '公积金' then A2.cat_cnt_6m_ago_two end) as two_gongjijin_cat_cnt_6m_ago,
        max(case when cat2= '共享办公' then A2.cat_cnt_two end) as two_gongxiangbangong_cat_cnt,
        max(case when cat2= '共享办公' then A2.cat_cnt_7d_ago_two end) as two_gongxiangbangong_cat_cnt_7d_ago,
        max(case when cat2= '共享办公' then A2.cat_cnt_1m_ago_two end) as two_gongxiangbangong_cat_cnt_1m_ago,
        max(case when cat2= '共享办公' then A2.cat_cnt_3m_ago_two end) as two_gongxiangbangong_cat_cnt_3m_ago,
        max(case when cat2= '共享办公' then A2.cat_cnt_6m_ago_two end) as two_gongxiangbangong_cat_cnt_6m_ago,
        max(case when cat2= '其他' then A2.cat_cnt_two end) as two_qita_cat_cnt,
        max(case when cat2= '其他' then A2.cat_cnt_7d_ago_two end) as two_qita_cat_cnt_7d_ago,
        max(case when cat2= '其他' then A2.cat_cnt_1m_ago_two end) as two_qita_cat_cnt_1m_ago,
        max(case when cat2= '其他' then A2.cat_cnt_3m_ago_two end) as two_qita_cat_cnt_3m_ago,
        max(case when cat2= '其他' then A2.cat_cnt_6m_ago_two end) as two_qita_cat_cnt_6m_ago,
        max(case when cat2= '其他贷款' then A2.cat_cnt_two end) as two_qitadaikuan_cat_cnt,
        max(case when cat2= '其他贷款' then A2.cat_cnt_7d_ago_two end) as two_qitadaikuan_cat_cnt_7d_ago,
        max(case when cat2= '其他贷款' then A2.cat_cnt_1m_ago_two end) as two_qitadaikuan_cat_cnt_1m_ago,
        max(case when cat2= '其他贷款' then A2.cat_cnt_3m_ago_two end) as two_qitadaikuan_cat_cnt_3m_ago,
        max(case when cat2= '其他贷款' then A2.cat_cnt_6m_ago_two end) as two_qitadaikuan_cat_cnt_6m_ago,
        max(case when cat2= '农村电商' then A2.cat_cnt_two end) as two_nongcundianshang_cat_cnt,
        max(case when cat2= '农村电商' then A2.cat_cnt_7d_ago_two end) as two_nongcundianshang_cat_cnt_7d_ago,
        max(case when cat2= '农村电商' then A2.cat_cnt_1m_ago_two end) as two_nongcundianshang_cat_cnt_1m_ago,
        max(case when cat2= '农村电商' then A2.cat_cnt_3m_ago_two end) as two_nongcundianshang_cat_cnt_3m_ago,
        max(case when cat2= '农村电商' then A2.cat_cnt_6m_ago_two end) as two_nongcundianshang_cat_cnt_6m_ago,
        max(case when cat2= '分身类' then A2.cat_cnt_two end) as two_fenshenlei_cat_cnt,
        max(case when cat2= '分身类' then A2.cat_cnt_7d_ago_two end) as two_fenshenlei_cat_cnt_7d_ago,
        max(case when cat2= '分身类' then A2.cat_cnt_1m_ago_two end) as two_fenshenlei_cat_cnt_1m_ago,
        max(case when cat2= '分身类' then A2.cat_cnt_3m_ago_two end) as two_fenshenlei_cat_cnt_3m_ago,
        max(case when cat2= '分身类' then A2.cat_cnt_6m_ago_two end) as two_fenshenlei_cat_cnt_6m_ago,
        max(case when cat2= '刷单类' then A2.cat_cnt_two end) as two_shuadanlei_cat_cnt,
        max(case when cat2= '刷单类' then A2.cat_cnt_7d_ago_two end) as two_shuadanlei_cat_cnt_7d_ago,
        max(case when cat2= '刷单类' then A2.cat_cnt_1m_ago_two end) as two_shuadanlei_cat_cnt_1m_ago,
        max(case when cat2= '刷单类' then A2.cat_cnt_3m_ago_two end) as two_shuadanlei_cat_cnt_3m_ago,
        max(case when cat2= '刷单类' then A2.cat_cnt_6m_ago_two end) as two_shuadanlei_cat_cnt_6m_ago,
        max(case when cat2= '办公场所租赁' then A2.cat_cnt_two end) as two_bangongchangsuozulin_cat_cnt,
        max(case when cat2= '办公场所租赁' then A2.cat_cnt_7d_ago_two end) as two_bangongchangsuozulin_cat_cnt_7d_ago,
        max(case when cat2= '办公场所租赁' then A2.cat_cnt_1m_ago_two end) as two_bangongchangsuozulin_cat_cnt_1m_ago,
        max(case when cat2= '办公场所租赁' then A2.cat_cnt_3m_ago_two end) as two_bangongchangsuozulin_cat_cnt_3m_ago,
        max(case when cat2= '办公场所租赁' then A2.cat_cnt_6m_ago_two end) as two_bangongchangsuozulin_cat_cnt_6m_ago,
        max(case when cat2= '助农' then A2.cat_cnt_two end) as two_zhunong_cat_cnt,
        max(case when cat2= '助农' then A2.cat_cnt_7d_ago_two end) as two_zhunong_cat_cnt_7d_ago,
        max(case when cat2= '助农' then A2.cat_cnt_1m_ago_two end) as two_zhunong_cat_cnt_1m_ago,
        max(case when cat2= '助农' then A2.cat_cnt_3m_ago_two end) as two_zhunong_cat_cnt_3m_ago,
        max(case when cat2= '助农' then A2.cat_cnt_6m_ago_two end) as two_zhunong_cat_cnt_6m_ago,
        max(case when cat2= '助贷' then A2.cat_cnt_two end) as two_zhudai_cat_cnt,
        max(case when cat2= '助贷' then A2.cat_cnt_7d_ago_two end) as two_zhudai_cat_cnt_7d_ago,
        max(case when cat2= '助贷' then A2.cat_cnt_1m_ago_two end) as two_zhudai_cat_cnt_1m_ago,
        max(case when cat2= '助贷' then A2.cat_cnt_3m_ago_two end) as two_zhudai_cat_cnt_3m_ago,
        max(case when cat2= '助贷' then A2.cat_cnt_6m_ago_two end) as two_zhudai_cat_cnt_6m_ago,
        max(case when cat2= '包名带loan的app' then A2.cat_cnt_two end) as two_baomingdailoandeapp_cat_cnt,
        max(case when cat2= '包名带loan的app' then A2.cat_cnt_7d_ago_two end) as two_baomingdailoandeapp_cat_cnt_7d_ago,
        max(case when cat2= '包名带loan的app' then A2.cat_cnt_1m_ago_two end) as two_baomingdailoandeapp_cat_cnt_1m_ago,
        max(case when cat2= '包名带loan的app' then A2.cat_cnt_3m_ago_two end) as two_baomingdailoandeapp_cat_cnt_3m_ago,
        max(case when cat2= '包名带loan的app' then A2.cat_cnt_6m_ago_two end) as two_baomingdailoandeapp_cat_cnt_6m_ago,
        max(case when cat2= '医疗' then A2.cat_cnt_two end) as two_yiliao_cat_cnt,
        max(case when cat2= '医疗' then A2.cat_cnt_7d_ago_two end) as two_yiliao_cat_cnt_7d_ago,
        max(case when cat2= '医疗' then A2.cat_cnt_1m_ago_two end) as two_yiliao_cat_cnt_1m_ago,
        max(case when cat2= '医疗' then A2.cat_cnt_3m_ago_two end) as two_yiliao_cat_cnt_3m_ago,
        max(case when cat2= '医疗' then A2.cat_cnt_6m_ago_two end) as two_yiliao_cat_cnt_6m_ago,
        max(case when cat2= '医疗咨询' then A2.cat_cnt_two end) as two_yiliaozixun_cat_cnt,
        max(case when cat2= '医疗咨询' then A2.cat_cnt_7d_ago_two end) as two_yiliaozixun_cat_cnt_7d_ago,
        max(case when cat2= '医疗咨询' then A2.cat_cnt_1m_ago_two end) as two_yiliaozixun_cat_cnt_1m_ago,
        max(case when cat2= '医疗咨询' then A2.cat_cnt_3m_ago_two end) as two_yiliaozixun_cat_cnt_3m_ago,
        max(case when cat2= '医疗咨询' then A2.cat_cnt_6m_ago_two end) as two_yiliaozixun_cat_cnt_6m_ago,
        max(case when cat2= '医药' then A2.cat_cnt_two end) as two_yiyao_cat_cnt,
        max(case when cat2= '医药' then A2.cat_cnt_7d_ago_two end) as two_yiyao_cat_cnt_7d_ago,
        max(case when cat2= '医药' then A2.cat_cnt_1m_ago_two end) as two_yiyao_cat_cnt_1m_ago,
        max(case when cat2= '医药' then A2.cat_cnt_3m_ago_two end) as two_yiyao_cat_cnt_3m_ago,
        max(case when cat2= '医药' then A2.cat_cnt_6m_ago_two end) as two_yiyao_cat_cnt_6m_ago,
        max(case when cat2= '博彩类' then A2.cat_cnt_two end) as two_bocailei_cat_cnt,
        max(case when cat2= '博彩类' then A2.cat_cnt_7d_ago_two end) as two_bocailei_cat_cnt_7d_ago,
        max(case when cat2= '博彩类' then A2.cat_cnt_1m_ago_two end) as two_bocailei_cat_cnt_1m_ago,
        max(case when cat2= '博彩类' then A2.cat_cnt_3m_ago_two end) as two_bocailei_cat_cnt_3m_ago,
        max(case when cat2= '博彩类' then A2.cat_cnt_6m_ago_two end) as two_bocailei_cat_cnt_6m_ago,
        max(case when cat2= '发薪贷' then A2.cat_cnt_two end) as two_faxindai_cat_cnt,
        max(case when cat2= '发薪贷' then A2.cat_cnt_7d_ago_two end) as two_faxindai_cat_cnt_7d_ago,
        max(case when cat2= '发薪贷' then A2.cat_cnt_1m_ago_two end) as two_faxindai_cat_cnt_1m_ago,
        max(case when cat2= '发薪贷' then A2.cat_cnt_3m_ago_two end) as two_faxindai_cat_cnt_3m_ago,
        max(case when cat2= '发薪贷' then A2.cat_cnt_6m_ago_two end) as two_faxindai_cat_cnt_6m_ago,
        max(case when cat2= '司机接单类' then A2.cat_cnt_two end) as two_sijijiedanlei_cat_cnt,
        max(case when cat2= '司机接单类' then A2.cat_cnt_7d_ago_two end) as two_sijijiedanlei_cat_cnt_7d_ago,
        max(case when cat2= '司机接单类' then A2.cat_cnt_1m_ago_two end) as two_sijijiedanlei_cat_cnt_1m_ago,
        max(case when cat2= '司机接单类' then A2.cat_cnt_3m_ago_two end) as two_sijijiedanlei_cat_cnt_3m_ago,
        max(case when cat2= '司机接单类' then A2.cat_cnt_6m_ago_two end) as two_sijijiedanlei_cat_cnt_6m_ago,
        max(case when cat2= '同城快递' then A2.cat_cnt_two end) as two_tongchengkuaidi_cat_cnt,
        max(case when cat2= '同城快递' then A2.cat_cnt_7d_ago_two end) as two_tongchengkuaidi_cat_cnt_7d_ago,
        max(case when cat2= '同城快递' then A2.cat_cnt_1m_ago_two end) as two_tongchengkuaidi_cat_cnt_1m_ago,
        max(case when cat2= '同城快递' then A2.cat_cnt_3m_ago_two end) as two_tongchengkuaidi_cat_cnt_3m_ago,
        max(case when cat2= '同城快递' then A2.cat_cnt_6m_ago_two end) as two_tongchengkuaidi_cat_cnt_6m_ago,
        max(case when cat2= '商务酒店' then A2.cat_cnt_two end) as two_shangwujiudian_cat_cnt,
        max(case when cat2= '商务酒店' then A2.cat_cnt_7d_ago_two end) as two_shangwujiudian_cat_cnt_7d_ago,
        max(case when cat2= '商务酒店' then A2.cat_cnt_1m_ago_two end) as two_shangwujiudian_cat_cnt_1m_ago,
        max(case when cat2= '商务酒店' then A2.cat_cnt_3m_ago_two end) as two_shangwujiudian_cat_cnt_3m_ago,
        max(case when cat2= '商务酒店' then A2.cat_cnt_6m_ago_two end) as two_shangwujiudian_cat_cnt_6m_ago,
        max(case when cat2= '在线视频' then A2.cat_cnt_two end) as two_zaixianshipin_cat_cnt,
        max(case when cat2= '在线视频' then A2.cat_cnt_7d_ago_two end) as two_zaixianshipin_cat_cnt_7d_ago,
        max(case when cat2= '在线视频' then A2.cat_cnt_1m_ago_two end) as two_zaixianshipin_cat_cnt_1m_ago,
        max(case when cat2= '在线视频' then A2.cat_cnt_3m_ago_two end) as two_zaixianshipin_cat_cnt_3m_ago,
        max(case when cat2= '在线视频' then A2.cat_cnt_6m_ago_two end) as two_zaixianshipin_cat_cnt_6m_ago,
        max(case when cat2= '在线音乐' then A2.cat_cnt_two end) as two_zaixianyinyue_cat_cnt,
        max(case when cat2= '在线音乐' then A2.cat_cnt_7d_ago_two end) as two_zaixianyinyue_cat_cnt_7d_ago,
        max(case when cat2= '在线音乐' then A2.cat_cnt_1m_ago_two end) as two_zaixianyinyue_cat_cnt_1m_ago,
        max(case when cat2= '在线音乐' then A2.cat_cnt_3m_ago_two end) as two_zaixianyinyue_cat_cnt_3m_ago,
        max(case when cat2= '在线音乐' then A2.cat_cnt_6m_ago_two end) as two_zaixianyinyue_cat_cnt_6m_ago,
        max(case when cat2= '场景消费分期' then A2.cat_cnt_two end) as two_changjingxiaofeifenqi_cat_cnt,
        max(case when cat2= '场景消费分期' then A2.cat_cnt_7d_ago_two end) as two_changjingxiaofeifenqi_cat_cnt_7d_ago,
        max(case when cat2= '场景消费分期' then A2.cat_cnt_1m_ago_two end) as two_changjingxiaofeifenqi_cat_cnt_1m_ago,
        max(case when cat2= '场景消费分期' then A2.cat_cnt_3m_ago_two end) as two_changjingxiaofeifenqi_cat_cnt_3m_ago,
        max(case when cat2= '场景消费分期' then A2.cat_cnt_6m_ago_two end) as two_changjingxiaofeifenqi_cat_cnt_6m_ago,
        max(case when cat2= '城市出行' then A2.cat_cnt_two end) as two_chengshichuxing_cat_cnt,
        max(case when cat2= '城市出行' then A2.cat_cnt_7d_ago_two end) as two_chengshichuxing_cat_cnt_7d_ago,
        max(case when cat2= '城市出行' then A2.cat_cnt_1m_ago_two end) as two_chengshichuxing_cat_cnt_1m_ago,
        max(case when cat2= '城市出行' then A2.cat_cnt_3m_ago_two end) as two_chengshichuxing_cat_cnt_3m_ago,
        max(case when cat2= '城市出行' then A2.cat_cnt_6m_ago_two end) as two_chengshichuxing_cat_cnt_6m_ago,
        max(case when cat2= '外卖' then A2.cat_cnt_two end) as two_waimai_cat2_cat_cnt,
        max(case when cat2= '外卖' then A2.cat_cnt_7d_ago_two end) as two_waimai_cat2_cat_cnt_7d_ago,
        max(case when cat2= '外卖' then A2.cat_cnt_1m_ago_two end) as two_waimai_cat2_cat_cnt_1m_ago,
        max(case when cat2= '外卖' then A2.cat_cnt_3m_ago_two end) as two_waimai_cat2_cat_cnt_3m_ago,
        max(case when cat2= '外卖' then A2.cat_cnt_6m_ago_two end) as two_waimai_cat2_cat_cnt_6m_ago,
        max(case when cat2= '大学教育' then A2.cat_cnt_two end) as two_daxuejiaoyu_cat_cnt,
        max(case when cat2= '大学教育' then A2.cat_cnt_7d_ago_two end) as two_daxuejiaoyu_cat_cnt_7d_ago,
        max(case when cat2= '大学教育' then A2.cat_cnt_1m_ago_two end) as two_daxuejiaoyu_cat_cnt_1m_ago,
        max(case when cat2= '大学教育' then A2.cat_cnt_3m_ago_two end) as two_daxuejiaoyu_cat_cnt_3m_ago,
        max(case when cat2= '大学教育' then A2.cat_cnt_6m_ago_two end) as two_daxuejiaoyu_cat_cnt_6m_ago,
        max(case when cat2= '奢侈品' then A2.cat_cnt_two end) as two_shechipin_cat2_cat_cnt,
        max(case when cat2= '奢侈品' then A2.cat_cnt_7d_ago_two end) as two_shechipin_cat2_cat_cnt_7d_ago,
        max(case when cat2= '奢侈品' then A2.cat_cnt_1m_ago_two end) as two_shechipin_cat2_cat_cnt_1m_ago,
        max(case when cat2= '奢侈品' then A2.cat_cnt_3m_ago_two end) as two_shechipin_cat2_cat_cnt_3m_ago,
        max(case when cat2= '奢侈品' then A2.cat_cnt_6m_ago_two end) as two_shechipin_cat2_cat_cnt_6m_ago,
        max(case when cat2= '娱乐直播' then A2.cat_cnt_two end) as two_yulezhibo_cat_cnt,
        max(case when cat2= '娱乐直播' then A2.cat_cnt_7d_ago_two end) as two_yulezhibo_cat_cnt_7d_ago,
        max(case when cat2= '娱乐直播' then A2.cat_cnt_1m_ago_two end) as two_yulezhibo_cat_cnt_1m_ago,
        max(case when cat2= '娱乐直播' then A2.cat_cnt_3m_ago_two end) as two_yulezhibo_cat_cnt_3m_ago,
        max(case when cat2= '娱乐直播' then A2.cat_cnt_6m_ago_two end) as two_yulezhibo_cat_cnt_6m_ago,
        max(case when cat2= '婚恋社交' then A2.cat_cnt_two end) as two_hunlianshejiao_cat_cnt,
        max(case when cat2= '婚恋社交' then A2.cat_cnt_7d_ago_two end) as two_hunlianshejiao_cat_cnt_7d_ago,
        max(case when cat2= '婚恋社交' then A2.cat_cnt_1m_ago_two end) as two_hunlianshejiao_cat_cnt_1m_ago,
        max(case when cat2= '婚恋社交' then A2.cat_cnt_3m_ago_two end) as two_hunlianshejiao_cat_cnt_3m_ago,
        max(case when cat2= '婚恋社交' then A2.cat_cnt_6m_ago_two end) as two_hunlianshejiao_cat_cnt_6m_ago,
        max(case when cat2= '安全优化' then A2.cat_cnt_two end) as two_anquanyouhua_cat_cnt,
        max(case when cat2= '安全优化' then A2.cat_cnt_7d_ago_two end) as two_anquanyouhua_cat_cnt_7d_ago,
        max(case when cat2= '安全优化' then A2.cat_cnt_1m_ago_two end) as two_anquanyouhua_cat_cnt_1m_ago,
        max(case when cat2= '安全优化' then A2.cat_cnt_3m_ago_two end) as two_anquanyouhua_cat_cnt_3m_ago,
        max(case when cat2= '安全优化' then A2.cat_cnt_6m_ago_two end) as two_anquanyouhua_cat_cnt_6m_ago,
        max(case when cat2= '家居家装' then A2.cat_cnt_two end) as two_jiajujiazhuang_cat_cnt,
        max(case when cat2= '家居家装' then A2.cat_cnt_7d_ago_two end) as two_jiajujiazhuang_cat_cnt_7d_ago,
        max(case when cat2= '家居家装' then A2.cat_cnt_1m_ago_two end) as two_jiajujiazhuang_cat_cnt_1m_ago,
        max(case when cat2= '家居家装' then A2.cat_cnt_3m_ago_two end) as two_jiajujiazhuang_cat_cnt_3m_ago,
        max(case when cat2= '家居家装' then A2.cat_cnt_6m_ago_two end) as two_jiajujiazhuang_cat_cnt_6m_ago,
        max(case when cat2= '小微企业类' then A2.cat_cnt_two end) as two_xiaoweiqiyelei_cat2_cat_cnt,
        max(case when cat2= '小微企业类' then A2.cat_cnt_7d_ago_two end) as two_xiaoweiqiyelei_cat2_cat_cnt_7d_ago,
        max(case when cat2= '小微企业类' then A2.cat_cnt_1m_ago_two end) as two_xiaoweiqiyelei_cat2_cat_cnt_1m_ago,
        max(case when cat2= '小微企业类' then A2.cat_cnt_3m_ago_two end) as two_xiaoweiqiyelei_cat2_cat_cnt_3m_ago,
        max(case when cat2= '小微企业类' then A2.cat_cnt_6m_ago_two end) as two_xiaoweiqiyelei_cat2_cat_cnt_6m_ago,
        max(case when cat2= '居家服务' then A2.cat_cnt_two end) as two_jujiafuwu_cat_cnt,
        max(case when cat2= '居家服务' then A2.cat_cnt_7d_ago_two end) as two_jujiafuwu_cat_cnt_7d_ago,
        max(case when cat2= '居家服务' then A2.cat_cnt_1m_ago_two end) as two_jujiafuwu_cat_cnt_1m_ago,
        max(case when cat2= '居家服务' then A2.cat_cnt_3m_ago_two end) as two_jujiafuwu_cat_cnt_3m_ago,
        max(case when cat2= '居家服务' then A2.cat_cnt_6m_ago_two end) as two_jujiafuwu_cat_cnt_6m_ago,
        max(case when cat2= '工作场景社交' then A2.cat_cnt_two end) as two_gongzuochangjingshejiao_cat_cnt,
        max(case when cat2= '工作场景社交' then A2.cat_cnt_7d_ago_two end) as two_gongzuochangjingshejiao_cat_cnt_7d_ago,
        max(case when cat2= '工作场景社交' then A2.cat_cnt_1m_ago_two end) as two_gongzuochangjingshejiao_cat_cnt_1m_ago,
        max(case when cat2= '工作场景社交' then A2.cat_cnt_3m_ago_two end) as two_gongzuochangjingshejiao_cat_cnt_3m_ago,
        max(case when cat2= '工作场景社交' then A2.cat_cnt_6m_ago_two end) as two_gongzuochangjingshejiao_cat_cnt_6m_ago,
        max(case when cat2= '应用市场' then A2.cat_cnt_two end) as two_yingyongshichang_cat_cnt,
        max(case when cat2= '应用市场' then A2.cat_cnt_7d_ago_two end) as two_yingyongshichang_cat_cnt_7d_ago,
        max(case when cat2= '应用市场' then A2.cat_cnt_1m_ago_two end) as two_yingyongshichang_cat_cnt_1m_ago,
        max(case when cat2= '应用市场' then A2.cat_cnt_3m_ago_two end) as two_yingyongshichang_cat_cnt_3m_ago,
        max(case when cat2= '应用市场' then A2.cat_cnt_6m_ago_two end) as two_yingyongshichang_cat_cnt_6m_ago,
        max(case when cat2= '成人教育' then A2.cat_cnt_two end) as two_chengrenjiaoyu_cat_cnt,
        max(case when cat2= '成人教育' then A2.cat_cnt_7d_ago_two end) as two_chengrenjiaoyu_cat_cnt_7d_ago,
        max(case when cat2= '成人教育' then A2.cat_cnt_1m_ago_two end) as two_chengrenjiaoyu_cat_cnt_1m_ago,
        max(case when cat2= '成人教育' then A2.cat_cnt_3m_ago_two end) as two_chengrenjiaoyu_cat_cnt_3m_ago,
        max(case when cat2= '成人教育' then A2.cat_cnt_6m_ago_two end) as two_chengrenjiaoyu_cat_cnt_6m_ago,
        max(case when cat2= '房产装修买卖' then A2.cat_cnt_two end) as two_fangchanzhuangxiumaimai_cat_cnt,
        max(case when cat2= '房产装修买卖' then A2.cat_cnt_7d_ago_two end) as two_fangchanzhuangxiumaimai_cat_cnt_7d_ago,
        max(case when cat2= '房产装修买卖' then A2.cat_cnt_1m_ago_two end) as two_fangchanzhuangxiumaimai_cat_cnt_1m_ago,
        max(case when cat2= '房产装修买卖' then A2.cat_cnt_3m_ago_two end) as two_fangchanzhuangxiumaimai_cat_cnt_3m_ago,
        max(case when cat2= '房产装修买卖' then A2.cat_cnt_6m_ago_two end) as two_fangchanzhuangxiumaimai_cat_cnt_6m_ago,
        max(case when cat2= '房屋信息APP' then A2.cat_cnt_two end) as two_fangwuxinxiAPP_cat_cnt,
        max(case when cat2= '房屋信息APP' then A2.cat_cnt_7d_ago_two end) as two_fangwuxinxiAPP_cat_cnt_7d_ago,
        max(case when cat2= '房屋信息APP' then A2.cat_cnt_1m_ago_two end) as two_fangwuxinxiAPP_cat_cnt_1m_ago,
        max(case when cat2= '房屋信息APP' then A2.cat_cnt_3m_ago_two end) as two_fangwuxinxiAPP_cat_cnt_3m_ago,
        max(case when cat2= '房屋信息APP' then A2.cat_cnt_6m_ago_two end) as two_fangwuxinxiAPP_cat_cnt_6m_ago,
        max(case when cat2= '房贷计算器' then A2.cat_cnt_two end) as two_fangdaijisuanqi_cat_cnt,
        max(case when cat2= '房贷计算器' then A2.cat_cnt_7d_ago_two end) as two_fangdaijisuanqi_cat_cnt_7d_ago,
        max(case when cat2= '房贷计算器' then A2.cat_cnt_1m_ago_two end) as two_fangdaijisuanqi_cat_cnt_1m_ago,
        max(case when cat2= '房贷计算器' then A2.cat_cnt_3m_ago_two end) as two_fangdaijisuanqi_cat_cnt_3m_ago,
        max(case when cat2= '房贷计算器' then A2.cat_cnt_6m_ago_two end) as two_fangdaijisuanqi_cat_cnt_6m_ago,
        max(case when cat2= '手游' then A2.cat_cnt_two end) as two_shouyou_cat_cnt,
        max(case when cat2= '手游' then A2.cat_cnt_7d_ago_two end) as two_shouyou_cat_cnt_7d_ago,
        max(case when cat2= '手游' then A2.cat_cnt_1m_ago_two end) as two_shouyou_cat_cnt_1m_ago,
        max(case when cat2= '手游' then A2.cat_cnt_3m_ago_two end) as two_shouyou_cat_cnt_3m_ago,
        max(case when cat2= '手游' then A2.cat_cnt_6m_ago_two end) as two_shouyou_cat_cnt_6m_ago,
        max(case when cat2= '拍照美图' then A2.cat_cnt_two end) as two_paizhaomeitu_cat_cnt,
        max(case when cat2= '拍照美图' then A2.cat_cnt_7d_ago_two end) as two_paizhaomeitu_cat_cnt_7d_ago,
        max(case when cat2= '拍照美图' then A2.cat_cnt_1m_ago_two end) as two_paizhaomeitu_cat_cnt_1m_ago,
        max(case when cat2= '拍照美图' then A2.cat_cnt_3m_ago_two end) as two_paizhaomeitu_cat_cnt_3m_ago,
        max(case when cat2= '拍照美图' then A2.cat_cnt_6m_ago_two end) as two_paizhaomeitu_cat_cnt_6m_ago,
        max(case when cat2= '招聘求职' then A2.cat_cnt_two end) as two_zhaopinqiuzhi_cat_cnt,
        max(case when cat2= '招聘求职' then A2.cat_cnt_7d_ago_two end) as two_zhaopinqiuzhi_cat_cnt_7d_ago,
        max(case when cat2= '招聘求职' then A2.cat_cnt_1m_ago_two end) as two_zhaopinqiuzhi_cat_cnt_1m_ago,
        max(case when cat2= '招聘求职' then A2.cat_cnt_3m_ago_two end) as two_zhaopinqiuzhi_cat_cnt_3m_ago,
        max(case when cat2= '招聘求职' then A2.cat_cnt_6m_ago_two end) as two_zhaopinqiuzhi_cat_cnt_6m_ago,
        max(case when cat2= '持牌消金' then A2.cat_cnt_two end) as two_chipaixiaojin_cat_cnt,
        max(case when cat2= '持牌消金' then A2.cat_cnt_7d_ago_two end) as two_chipaixiaojin_cat_cnt_7d_ago,
        max(case when cat2= '持牌消金' then A2.cat_cnt_1m_ago_two end) as two_chipaixiaojin_cat_cnt_1m_ago,
        max(case when cat2= '持牌消金' then A2.cat_cnt_3m_ago_two end) as two_chipaixiaojin_cat_cnt_3m_ago,
        max(case when cat2= '持牌消金' then A2.cat_cnt_6m_ago_two end) as two_chipaixiaojin_cat_cnt_6m_ago,
        max(case when cat2= '挖矿' then A2.cat_cnt_two end) as two_wakuang_cat_cnt,
        max(case when cat2= '挖矿' then A2.cat_cnt_7d_ago_two end) as two_wakuang_cat_cnt_7d_ago,
        max(case when cat2= '挖矿' then A2.cat_cnt_1m_ago_two end) as two_wakuang_cat_cnt_1m_ago,
        max(case when cat2= '挖矿' then A2.cat_cnt_3m_ago_two end) as two_wakuang_cat_cnt_3m_ago,
        max(case when cat2= '挖矿' then A2.cat_cnt_6m_ago_two end) as two_wakuang_cat_cnt_6m_ago,
        max(case when cat2= '政务' then A2.cat_cnt_two end) as two_zhengwu_cat_cnt,
        max(case when cat2= '政务' then A2.cat_cnt_7d_ago_two end) as two_zhengwu_cat_cnt_7d_ago,
        max(case when cat2= '政务' then A2.cat_cnt_1m_ago_two end) as two_zhengwu_cat_cnt_1m_ago,
        max(case when cat2= '政务' then A2.cat_cnt_3m_ago_two end) as two_zhengwu_cat_cnt_3m_ago,
        max(case when cat2= '政务' then A2.cat_cnt_6m_ago_two end) as two_zhengwu_cat_cnt_6m_ago,
        max(case when cat2= '新能源汽车服务' then A2.cat_cnt_two end) as two_xinnengyuanqichefuwu_cat_cnt,
        max(case when cat2= '新能源汽车服务' then A2.cat_cnt_7d_ago_two end) as two_xinnengyuanqichefuwu_cat_cnt_7d_ago,
        max(case when cat2= '新能源汽车服务' then A2.cat_cnt_1m_ago_two end) as two_xinnengyuanqichefuwu_cat_cnt_1m_ago,
        max(case when cat2= '新能源汽车服务' then A2.cat_cnt_3m_ago_two end) as two_xinnengyuanqichefuwu_cat_cnt_3m_ago,
        max(case when cat2= '新能源汽车服务' then A2.cat_cnt_6m_ago_two end) as two_xinnengyuanqichefuwu_cat_cnt_6m_ago,
        max(case when cat2= '旅游APP' then A2.cat_cnt_two end) as two_luyouAPP_cat_cnt,
        max(case when cat2= '旅游APP' then A2.cat_cnt_7d_ago_two end) as two_luyouAPP_cat_cnt_7d_ago,
        max(case when cat2= '旅游APP' then A2.cat_cnt_1m_ago_two end) as two_luyouAPP_cat_cnt_1m_ago,
        max(case when cat2= '旅游APP' then A2.cat_cnt_3m_ago_two end) as two_luyouAPP_cat_cnt_3m_ago,
        max(case when cat2= '旅游APP' then A2.cat_cnt_6m_ago_two end) as two_luyouAPP_cat_cnt_6m_ago,
        max(case when cat2= '旅游相关' then A2.cat_cnt_two end) as two_luyouxiangguan_cat_cnt,
        max(case when cat2= '旅游相关' then A2.cat_cnt_7d_ago_two end) as two_luyouxiangguan_cat_cnt_7d_ago,
        max(case when cat2= '旅游相关' then A2.cat_cnt_1m_ago_two end) as two_luyouxiangguan_cat_cnt_1m_ago,
        max(case when cat2= '旅游相关' then A2.cat_cnt_3m_ago_two end) as two_luyouxiangguan_cat_cnt_3m_ago,
        max(case when cat2= '旅游相关' then A2.cat_cnt_6m_ago_two end) as two_luyouxiangguan_cat_cnt_6m_ago,
        max(case when cat2= '日历APP' then A2.cat_cnt_two end) as two_riliAPP_cat_cnt,
        max(case when cat2= '日历APP' then A2.cat_cnt_7d_ago_two end) as two_riliAPP_cat_cnt_7d_ago,
        max(case when cat2= '日历APP' then A2.cat_cnt_1m_ago_two end) as two_riliAPP_cat_cnt_1m_ago,
        max(case when cat2= '日历APP' then A2.cat_cnt_3m_ago_two end) as two_riliAPP_cat_cnt_3m_ago,
        max(case when cat2= '日历APP' then A2.cat_cnt_6m_ago_two end) as two_riliAPP_cat_cnt_6m_ago,
        max(case when cat2= '时间管理/规划' then A2.cat_cnt_two end) as two_shijianguanli_guihua_cat_cnt,
        max(case when cat2= '时间管理/规划' then A2.cat_cnt_7d_ago_two end) as two_shijianguanli_guihua_cat_cnt_7d_ago,
        max(case when cat2= '时间管理/规划' then A2.cat_cnt_1m_ago_two end) as two_shijianguanli_guihua_cat_cnt_1m_ago,
        max(case when cat2= '时间管理/规划' then A2.cat_cnt_3m_ago_two end) as two_shijianguanli_guihua_cat_cnt_3m_ago,
        max(case when cat2= '时间管理/规划' then A2.cat_cnt_6m_ago_two end) as two_shijianguanli_guihua_cat_cnt_6m_ago,
        max(case when cat2= '智慧城市' then A2.cat_cnt_two end) as two_zhihuichengshi_cat_cnt,
        max(case when cat2= '智慧城市' then A2.cat_cnt_7d_ago_two end) as two_zhihuichengshi_cat_cnt_7d_ago,
        max(case when cat2= '智慧城市' then A2.cat_cnt_1m_ago_two end) as two_zhihuichengshi_cat_cnt_1m_ago,
        max(case when cat2= '智慧城市' then A2.cat_cnt_3m_ago_two end) as two_zhihuichengshi_cat_cnt_3m_ago,
        max(case when cat2= '智慧城市' then A2.cat_cnt_6m_ago_two end) as two_zhihuichengshi_cat_cnt_6m_ago,
        max(case when cat2= '智能家居' then A2.cat_cnt_two end) as two_zhinengjiaju_cat_cnt,
        max(case when cat2= '智能家居' then A2.cat_cnt_7d_ago_two end) as two_zhinengjiaju_cat_cnt_7d_ago,
        max(case when cat2= '智能家居' then A2.cat_cnt_1m_ago_two end) as two_zhinengjiaju_cat_cnt_1m_ago,
        max(case when cat2= '智能家居' then A2.cat_cnt_3m_ago_two end) as two_zhinengjiaju_cat_cnt_3m_ago,
        max(case when cat2= '智能家居' then A2.cat_cnt_6m_ago_two end) as two_zhinengjiaju_cat_cnt_6m_ago,
        max(case when cat2= '本地生活' then A2.cat_cnt_two end) as two_bendishenghuo_cat_cnt,
        max(case when cat2= '本地生活' then A2.cat_cnt_7d_ago_two end) as two_bendishenghuo_cat_cnt_7d_ago,
        max(case when cat2= '本地生活' then A2.cat_cnt_1m_ago_two end) as two_bendishenghuo_cat_cnt_1m_ago,
        max(case when cat2= '本地生活' then A2.cat_cnt_3m_ago_two end) as two_bendishenghuo_cat_cnt_3m_ago,
        max(case when cat2= '本地生活' then A2.cat_cnt_6m_ago_two end) as two_bendishenghuo_cat_cnt_6m_ago,
        max(case when cat2= '机票相关' then A2.cat_cnt_two end) as two_jipiaoxiangguan_cat_cnt,
        max(case when cat2= '机票相关' then A2.cat_cnt_7d_ago_two end) as two_jipiaoxiangguan_cat_cnt_7d_ago,
        max(case when cat2= '机票相关' then A2.cat_cnt_1m_ago_two end) as two_jipiaoxiangguan_cat_cnt_1m_ago,
        max(case when cat2= '机票相关' then A2.cat_cnt_3m_ago_two end) as two_jipiaoxiangguan_cat_cnt_3m_ago,
        max(case when cat2= '机票相关' then A2.cat_cnt_6m_ago_two end) as two_jipiaoxiangguan_cat_cnt_6m_ago,
        max(case when cat2= '母婴' then A2.cat_cnt_two end) as two_muying_cat_cnt,
        max(case when cat2= '母婴' then A2.cat_cnt_7d_ago_two end) as two_muying_cat_cnt_7d_ago,
        max(case when cat2= '母婴' then A2.cat_cnt_1m_ago_two end) as two_muying_cat_cnt_1m_ago,
        max(case when cat2= '母婴' then A2.cat_cnt_3m_ago_two end) as two_muying_cat_cnt_3m_ago,
        max(case when cat2= '母婴' then A2.cat_cnt_6m_ago_two end) as two_muying_cat_cnt_6m_ago,
        max(case when cat2= '母婴生活' then A2.cat_cnt_two end) as two_muyingshenghuo_cat_cnt,
        max(case when cat2= '母婴生活' then A2.cat_cnt_7d_ago_two end) as two_muyingshenghuo_cat_cnt_7d_ago,
        max(case when cat2= '母婴生活' then A2.cat_cnt_1m_ago_two end) as two_muyingshenghuo_cat_cnt_1m_ago,
        max(case when cat2= '母婴生活' then A2.cat_cnt_3m_ago_two end) as two_muyingshenghuo_cat_cnt_3m_ago,
        max(case when cat2= '母婴生活' then A2.cat_cnt_6m_ago_two end) as two_muyingshenghuo_cat_cnt_6m_ago,
        max(case when cat2= '母婴电商' then A2.cat_cnt_two end) as two_muyingdianshang_cat_cnt,
        max(case when cat2= '母婴电商' then A2.cat_cnt_7d_ago_two end) as two_muyingdianshang_cat_cnt_7d_ago,
        max(case when cat2= '母婴电商' then A2.cat_cnt_1m_ago_two end) as two_muyingdianshang_cat_cnt_1m_ago,
        max(case when cat2= '母婴电商' then A2.cat_cnt_3m_ago_two end) as two_muyingdianshang_cat_cnt_3m_ago,
        max(case when cat2= '母婴电商' then A2.cat_cnt_6m_ago_two end) as two_muyingdianshang_cat_cnt_6m_ago,
        max(case when cat2= '求职招聘' then A2.cat_cnt_two end) as two_qiuzhizhaopin_cat2_cat_cnt,
        max(case when cat2= '求职招聘' then A2.cat_cnt_7d_ago_two end) as two_qiuzhizhaopin_cat2_cat_cnt_7d_ago,
        max(case when cat2= '求职招聘' then A2.cat_cnt_1m_ago_two end) as two_qiuzhizhaopin_cat2_cat_cnt_1m_ago,
        max(case when cat2= '求职招聘' then A2.cat_cnt_3m_ago_two end) as two_qiuzhizhaopin_cat2_cat_cnt_3m_ago,
        max(case when cat2= '求职招聘' then A2.cat_cnt_6m_ago_two end) as two_qiuzhizhaopin_cat2_cat_cnt_6m_ago,
        max(case when cat2= '汽车加油类' then A2.cat_cnt_two end) as two_qichejiayoulei_cat_cnt,
        max(case when cat2= '汽车加油类' then A2.cat_cnt_7d_ago_two end) as two_qichejiayoulei_cat_cnt_7d_ago,
        max(case when cat2= '汽车加油类' then A2.cat_cnt_1m_ago_two end) as two_qichejiayoulei_cat_cnt_1m_ago,
        max(case when cat2= '汽车加油类' then A2.cat_cnt_3m_ago_two end) as two_qichejiayoulei_cat_cnt_3m_ago,
        max(case when cat2= '汽车加油类' then A2.cat_cnt_6m_ago_two end) as two_qichejiayoulei_cat_cnt_6m_ago,
        max(case when cat2= '汽车品牌类' then A2.cat_cnt_two end) as two_qichepinpailei_cat_cnt,
        max(case when cat2= '汽车品牌类' then A2.cat_cnt_7d_ago_two end) as two_qichepinpailei_cat_cnt_7d_ago,
        max(case when cat2= '汽车品牌类' then A2.cat_cnt_1m_ago_two end) as two_qichepinpailei_cat_cnt_1m_ago,
        max(case when cat2= '汽车品牌类' then A2.cat_cnt_3m_ago_two end) as two_qichepinpailei_cat_cnt_3m_ago,
        max(case when cat2= '汽车品牌类' then A2.cat_cnt_6m_ago_two end) as two_qichepinpailei_cat_cnt_6m_ago,
        max(case when cat2= '汽车官方品牌' then A2.cat_cnt_two end) as two_qicheguanfangpinpai_cat_cnt,
        max(case when cat2= '汽车官方品牌' then A2.cat_cnt_7d_ago_two end) as two_qicheguanfangpinpai_cat_cnt_7d_ago,
        max(case when cat2= '汽车官方品牌' then A2.cat_cnt_1m_ago_two end) as two_qicheguanfangpinpai_cat_cnt_1m_ago,
        max(case when cat2= '汽车官方品牌' then A2.cat_cnt_3m_ago_two end) as two_qicheguanfangpinpai_cat_cnt_3m_ago,
        max(case when cat2= '汽车官方品牌' then A2.cat_cnt_6m_ago_two end) as two_qicheguanfangpinpai_cat_cnt_6m_ago,
        max(case when cat2= '汽车租赁' then A2.cat_cnt_two end) as two_qichezulin_cat_cnt,
        max(case when cat2= '汽车租赁' then A2.cat_cnt_7d_ago_two end) as two_qichezulin_cat_cnt_7d_ago,
        max(case when cat2= '汽车租赁' then A2.cat_cnt_1m_ago_two end) as two_qichezulin_cat_cnt_1m_ago,
        max(case when cat2= '汽车租赁' then A2.cat_cnt_3m_ago_two end) as two_qichezulin_cat_cnt_3m_ago,
        max(case when cat2= '汽车租赁' then A2.cat_cnt_6m_ago_two end) as two_qichezulin_cat_cnt_6m_ago,
        max(case when cat2= '汽车综合资讯' then A2.cat_cnt_two end) as two_qichezonghezixun_cat_cnt,
        max(case when cat2= '汽车综合资讯' then A2.cat_cnt_7d_ago_two end) as two_qichezonghezixun_cat_cnt_7d_ago,
        max(case when cat2= '汽车综合资讯' then A2.cat_cnt_1m_ago_two end) as two_qichezonghezixun_cat_cnt_1m_ago,
        max(case when cat2= '汽车综合资讯' then A2.cat_cnt_3m_ago_two end) as two_qichezonghezixun_cat_cnt_3m_ago,
        max(case when cat2= '汽车综合资讯' then A2.cat_cnt_6m_ago_two end) as two_qichezonghezixun_cat_cnt_6m_ago,
        max(case when cat2= '法律' then A2.cat_cnt_two end) as two_falu_cat_cnt,
        max(case when cat2= '法律' then A2.cat_cnt_7d_ago_two end) as two_falu_cat_cnt_7d_ago,
        max(case when cat2= '法律' then A2.cat_cnt_1m_ago_two end) as two_falu_cat_cnt_1m_ago,
        max(case when cat2= '法律' then A2.cat_cnt_3m_ago_two end) as two_falu_cat_cnt_3m_ago,
        max(case when cat2= '法律' then A2.cat_cnt_6m_ago_two end) as two_falu_cat_cnt_6m_ago,
        max(case when cat2= '浏览器APP' then A2.cat_cnt_two end) as two_liulanqiAPP_cat_cnt,
        max(case when cat2= '浏览器APP' then A2.cat_cnt_7d_ago_two end) as two_liulanqiAPP_cat_cnt_7d_ago,
        max(case when cat2= '浏览器APP' then A2.cat_cnt_1m_ago_two end) as two_liulanqiAPP_cat_cnt_1m_ago,
        max(case when cat2= '浏览器APP' then A2.cat_cnt_3m_ago_two end) as two_liulanqiAPP_cat_cnt_3m_ago,
        max(case when cat2= '浏览器APP' then A2.cat_cnt_6m_ago_two end) as two_liulanqiAPP_cat_cnt_6m_ago,
        max(case when cat2= '海外代购app' then A2.cat_cnt_two end) as two_haiwaidaigouapp_cat_cnt,
        max(case when cat2= '海外代购app' then A2.cat_cnt_7d_ago_two end) as two_haiwaidaigouapp_cat_cnt_7d_ago,
        max(case when cat2= '海外代购app' then A2.cat_cnt_1m_ago_two end) as two_haiwaidaigouapp_cat_cnt_1m_ago,
        max(case when cat2= '海外代购app' then A2.cat_cnt_3m_ago_two end) as two_haiwaidaigouapp_cat_cnt_3m_ago,
        max(case when cat2= '海外代购app' then A2.cat_cnt_6m_ago_two end) as two_haiwaidaigouapp_cat_cnt_6m_ago,
        max(case when cat2= '消费金融' then A2.cat_cnt_two end) as two_xiaofeijinrong_cat_cnt,
        max(case when cat2= '消费金融' then A2.cat_cnt_7d_ago_two end) as two_xiaofeijinrong_cat_cnt_7d_ago,
        max(case when cat2= '消费金融' then A2.cat_cnt_1m_ago_two end) as two_xiaofeijinrong_cat_cnt_1m_ago,
        max(case when cat2= '消费金融' then A2.cat_cnt_3m_ago_two end) as two_xiaofeijinrong_cat_cnt_3m_ago,
        max(case when cat2= '消费金融' then A2.cat_cnt_6m_ago_two end) as two_xiaofeijinrong_cat_cnt_6m_ago,
        max(case when cat2= '涉黄' then A2.cat_cnt_two end) as two_shehuang_cat2_cat_cnt,
        max(case when cat2= '涉黄' then A2.cat_cnt_7d_ago_two end) as two_shehuang_cat2_cat_cnt_7d_ago,
        max(case when cat2= '涉黄' then A2.cat_cnt_1m_ago_two end) as two_shehuang_cat2_cat_cnt_1m_ago,
        max(case when cat2= '涉黄' then A2.cat_cnt_3m_ago_two end) as two_shehuang_cat2_cat_cnt_3m_ago,
        max(case when cat2= '涉黄' then A2.cat_cnt_6m_ago_two end) as two_shehuang_cat2_cat_cnt_6m_ago,
        max(case when cat2= '游戏' then A2.cat_cnt_two end) as two_youxi_cat2_cat_cnt,
        max(case when cat2= '游戏' then A2.cat_cnt_7d_ago_two end) as two_youxi_cat2_cat_cnt_7d_ago,
        max(case when cat2= '游戏' then A2.cat_cnt_1m_ago_two end) as two_youxi_cat2_cat_cnt_1m_ago,
        max(case when cat2= '游戏' then A2.cat_cnt_3m_ago_two end) as two_youxi_cat2_cat_cnt_3m_ago,
        max(case when cat2= '游戏' then A2.cat_cnt_6m_ago_two end) as two_youxi_cat2_cat_cnt_6m_ago,
        max(case when cat2= '游戏娱乐' then A2.cat_cnt_two end) as two_youxiyule_cat_cnt,
        max(case when cat2= '游戏娱乐' then A2.cat_cnt_7d_ago_two end) as two_youxiyule_cat_cnt_7d_ago,
        max(case when cat2= '游戏娱乐' then A2.cat_cnt_1m_ago_two end) as two_youxiyule_cat_cnt_1m_ago,
        max(case when cat2= '游戏娱乐' then A2.cat_cnt_3m_ago_two end) as two_youxiyule_cat_cnt_3m_ago,
        max(case when cat2= '游戏娱乐' then A2.cat_cnt_6m_ago_two end) as two_youxiyule_cat_cnt_6m_ago,
        max(case when cat2= '游戏社交' then A2.cat_cnt_two end) as two_youxishejiao_cat_cnt,
        max(case when cat2= '游戏社交' then A2.cat_cnt_7d_ago_two end) as two_youxishejiao_cat_cnt_7d_ago,
        max(case when cat2= '游戏社交' then A2.cat_cnt_1m_ago_two end) as two_youxishejiao_cat_cnt_1m_ago,
        max(case when cat2= '游戏社交' then A2.cat_cnt_3m_ago_two end) as two_youxishejiao_cat_cnt_3m_ago,
        max(case when cat2= '游戏社交' then A2.cat_cnt_6m_ago_two end) as two_youxishejiao_cat_cnt_6m_ago,
        max(case when cat2= '游戏类' then A2.cat_cnt_two end) as two_youxilei_cat_cnt,
        max(case when cat2= '游戏类' then A2.cat_cnt_7d_ago_two end) as two_youxilei_cat_cnt_7d_ago,
        max(case when cat2= '游戏类' then A2.cat_cnt_1m_ago_two end) as two_youxilei_cat_cnt_1m_ago,
        max(case when cat2= '游戏类' then A2.cat_cnt_3m_ago_two end) as two_youxilei_cat_cnt_3m_ago,
        max(case when cat2= '游戏类' then A2.cat_cnt_6m_ago_two end) as two_youxilei_cat_cnt_6m_ago,
        max(case when cat2= '演出票务' then A2.cat_cnt_two end) as two_yanchupiaowu_cat_cnt,
        max(case when cat2= '演出票务' then A2.cat_cnt_7d_ago_two end) as two_yanchupiaowu_cat_cnt_7d_ago,
        max(case when cat2= '演出票务' then A2.cat_cnt_1m_ago_two end) as two_yanchupiaowu_cat_cnt_1m_ago,
        max(case when cat2= '演出票务' then A2.cat_cnt_3m_ago_two end) as two_yanchupiaowu_cat_cnt_3m_ago,
        max(case when cat2= '演出票务' then A2.cat_cnt_6m_ago_two end) as two_yanchupiaowu_cat_cnt_6m_ago,
        max(case when cat2= '熟人社交' then A2.cat_cnt_two end) as two_shurenshejiao_cat_cnt,
        max(case when cat2= '熟人社交' then A2.cat_cnt_7d_ago_two end) as two_shurenshejiao_cat_cnt_7d_ago,
        max(case when cat2= '熟人社交' then A2.cat_cnt_1m_ago_two end) as two_shurenshejiao_cat_cnt_1m_ago,
        max(case when cat2= '熟人社交' then A2.cat_cnt_3m_ago_two end) as two_shurenshejiao_cat_cnt_3m_ago,
        max(case when cat2= '熟人社交' then A2.cat_cnt_6m_ago_two end) as two_shurenshejiao_cat_cnt_6m_ago,
        max(case when cat2= '生鲜电商' then A2.cat_cnt_two end) as two_shengxiandianshang_cat_cnt,
        max(case when cat2= '生鲜电商' then A2.cat_cnt_7d_ago_two end) as two_shengxiandianshang_cat_cnt_7d_ago,
        max(case when cat2= '生鲜电商' then A2.cat_cnt_1m_ago_two end) as two_shengxiandianshang_cat_cnt_1m_ago,
        max(case when cat2= '生鲜电商' then A2.cat_cnt_3m_ago_two end) as two_shengxiandianshang_cat_cnt_3m_ago,
        max(case when cat2= '生鲜电商' then A2.cat_cnt_6m_ago_two end) as two_shengxiandianshang_cat_cnt_6m_ago,
        max(case when cat2= '电商平台' then A2.cat_cnt_two end) as two_dianshangpingtai_cat2_cat_cnt,
        max(case when cat2= '电商平台' then A2.cat_cnt_7d_ago_two end) as two_dianshangpingtai_cat2_cat_cnt_7d_ago,
        max(case when cat2= '电商平台' then A2.cat_cnt_1m_ago_two end) as two_dianshangpingtai_cat2_cat_cnt_1m_ago,
        max(case when cat2= '电商平台' then A2.cat_cnt_3m_ago_two end) as two_dianshangpingtai_cat2_cat_cnt_3m_ago,
        max(case when cat2= '电商平台' then A2.cat_cnt_6m_ago_two end) as two_dianshangpingtai_cat2_cat_cnt_6m_ago,
        max(case when cat2= '疑似传销' then A2.cat_cnt_two end) as two_yisichuanxiao_cat_cnt,
        max(case when cat2= '疑似传销' then A2.cat_cnt_7d_ago_two end) as two_yisichuanxiao_cat_cnt_7d_ago,
        max(case when cat2= '疑似传销' then A2.cat_cnt_1m_ago_two end) as two_yisichuanxiao_cat_cnt_1m_ago,
        max(case when cat2= '疑似传销' then A2.cat_cnt_3m_ago_two end) as two_yisichuanxiao_cat_cnt_3m_ago,
        max(case when cat2= '疑似传销' then A2.cat_cnt_6m_ago_two end) as two_yisichuanxiao_cat_cnt_6m_ago,
        max(case when cat2= '直播社交' then A2.cat_cnt_two end) as two_zhiboshejiao_cat_cnt,
        max(case when cat2= '直播社交' then A2.cat_cnt_7d_ago_two end) as two_zhiboshejiao_cat_cnt_7d_ago,
        max(case when cat2= '直播社交' then A2.cat_cnt_1m_ago_two end) as two_zhiboshejiao_cat_cnt_1m_ago,
        max(case when cat2= '直播社交' then A2.cat_cnt_3m_ago_two end) as two_zhiboshejiao_cat_cnt_3m_ago,
        max(case when cat2= '直播社交' then A2.cat_cnt_6m_ago_two end) as two_zhiboshejiao_cat_cnt_6m_ago,
        max(case when cat2= '短视频' then A2.cat_cnt_two end) as two_duanshipin_cat_cnt,
        max(case when cat2= '短视频' then A2.cat_cnt_7d_ago_two end) as two_duanshipin_cat_cnt_7d_ago,
        max(case when cat2= '短视频' then A2.cat_cnt_1m_ago_two end) as two_duanshipin_cat_cnt_1m_ago,
        max(case when cat2= '短视频' then A2.cat_cnt_3m_ago_two end) as two_duanshipin_cat_cnt_3m_ago,
        max(case when cat2= '短视频' then A2.cat_cnt_6m_ago_two end) as two_duanshipin_cat_cnt_6m_ago,
        max(case when cat2= '社保税务' then A2.cat_cnt_two end) as two_shebaoshuiwu_cat_cnt,
        max(case when cat2= '社保税务' then A2.cat_cnt_7d_ago_two end) as two_shebaoshuiwu_cat_cnt_7d_ago,
        max(case when cat2= '社保税务' then A2.cat_cnt_1m_ago_two end) as two_shebaoshuiwu_cat_cnt_1m_ago,
        max(case when cat2= '社保税务' then A2.cat_cnt_3m_ago_two end) as two_shebaoshuiwu_cat_cnt_3m_ago,
        max(case when cat2= '社保税务' then A2.cat_cnt_6m_ago_two end) as two_shebaoshuiwu_cat_cnt_6m_ago,
        max(case when cat2= '社区交友' then A2.cat_cnt_two end) as two_shequjiaoyou_cat_cnt,
        max(case when cat2= '社区交友' then A2.cat_cnt_7d_ago_two end) as two_shequjiaoyou_cat_cnt_7d_ago,
        max(case when cat2= '社区交友' then A2.cat_cnt_1m_ago_two end) as two_shequjiaoyou_cat_cnt_1m_ago,
        max(case when cat2= '社区交友' then A2.cat_cnt_3m_ago_two end) as two_shequjiaoyou_cat_cnt_3m_ago,
        max(case when cat2= '社区交友' then A2.cat_cnt_6m_ago_two end) as two_shequjiaoyou_cat_cnt_6m_ago,
        max(case when cat2= '社区服务' then A2.cat_cnt_two end) as two_shequfuwu_cat_cnt,
        max(case when cat2= '社区服务' then A2.cat_cnt_7d_ago_two end) as two_shequfuwu_cat_cnt_7d_ago,
        max(case when cat2= '社区服务' then A2.cat_cnt_1m_ago_two end) as two_shequfuwu_cat_cnt_1m_ago,
        max(case when cat2= '社区服务' then A2.cat_cnt_3m_ago_two end) as two_shequfuwu_cat_cnt_3m_ago,
        max(case when cat2= '社区服务' then A2.cat_cnt_6m_ago_two end) as two_shequfuwu_cat_cnt_6m_ago,
        max(case when cat2= '篡改定位' then A2.cat_cnt_two end) as two_cuangaidingwei_cat_cnt,
        max(case when cat2= '篡改定位' then A2.cat_cnt_7d_ago_two end) as two_cuangaidingwei_cat_cnt_7d_ago,
        max(case when cat2= '篡改定位' then A2.cat_cnt_1m_ago_two end) as two_cuangaidingwei_cat_cnt_1m_ago,
        max(case when cat2= '篡改定位' then A2.cat_cnt_3m_ago_two end) as two_cuangaidingwei_cat_cnt_3m_ago,
        max(case when cat2= '篡改定位' then A2.cat_cnt_6m_ago_two end) as two_cuangaidingwei_cat_cnt_6m_ago,
        max(case when cat2= '素质教育' then A2.cat_cnt_two end) as two_suzhijiaoyu_cat_cnt,
        max(case when cat2= '素质教育' then A2.cat_cnt_7d_ago_two end) as two_suzhijiaoyu_cat_cnt_7d_ago,
        max(case when cat2= '素质教育' then A2.cat_cnt_1m_ago_two end) as two_suzhijiaoyu_cat_cnt_1m_ago,
        max(case when cat2= '素质教育' then A2.cat_cnt_3m_ago_two end) as two_suzhijiaoyu_cat_cnt_3m_ago,
        max(case when cat2= '素质教育' then A2.cat_cnt_6m_ago_two end) as two_suzhijiaoyu_cat_cnt_6m_ago,
        max(case when cat2= '线上网课' then A2.cat_cnt_two end) as two_xianshangwangke_cat_cnt,
        max(case when cat2= '线上网课' then A2.cat_cnt_7d_ago_two end) as two_xianshangwangke_cat_cnt_7d_ago,
        max(case when cat2= '线上网课' then A2.cat_cnt_1m_ago_two end) as two_xianshangwangke_cat_cnt_1m_ago,
        max(case when cat2= '线上网课' then A2.cat_cnt_3m_ago_two end) as two_xianshangwangke_cat_cnt_3m_ago,
        max(case when cat2= '线上网课' then A2.cat_cnt_6m_ago_two end) as two_xianshangwangke_cat_cnt_6m_ago,
        max(case when cat2= '综合旅游服务' then A2.cat_cnt_two end) as two_zongheluyoufuwu_cat_cnt,
        max(case when cat2= '综合旅游服务' then A2.cat_cnt_7d_ago_two end) as two_zongheluyoufuwu_cat_cnt_7d_ago,
        max(case when cat2= '综合旅游服务' then A2.cat_cnt_1m_ago_two end) as two_zongheluyoufuwu_cat_cnt_1m_ago,
        max(case when cat2= '综合旅游服务' then A2.cat_cnt_3m_ago_two end) as two_zongheluyoufuwu_cat_cnt_3m_ago,
        max(case when cat2= '综合旅游服务' then A2.cat_cnt_6m_ago_two end) as two_zongheluyoufuwu_cat_cnt_6m_ago,
        max(case when cat2= '综合电商' then A2.cat_cnt_two end) as two_zonghedianshang_cat_cnt,
        max(case when cat2= '综合电商' then A2.cat_cnt_7d_ago_two end) as two_zonghedianshang_cat_cnt_7d_ago,
        max(case when cat2= '综合电商' then A2.cat_cnt_1m_ago_two end) as two_zonghedianshang_cat_cnt_1m_ago,
        max(case when cat2= '综合电商' then A2.cat_cnt_3m_ago_two end) as two_zonghedianshang_cat_cnt_3m_ago,
        max(case when cat2= '综合电商' then A2.cat_cnt_6m_ago_two end) as two_zonghedianshang_cat_cnt_6m_ago,
        max(case when cat2= '综合类社交' then A2.cat_cnt_two end) as two_zongheleishejiao_cat_cnt,
        max(case when cat2= '综合类社交' then A2.cat_cnt_7d_ago_two end) as two_zongheleishejiao_cat_cnt_7d_ago,
        max(case when cat2= '综合类社交' then A2.cat_cnt_1m_ago_two end) as two_zongheleishejiao_cat_cnt_1m_ago,
        max(case when cat2= '综合类社交' then A2.cat_cnt_3m_ago_two end) as two_zongheleishejiao_cat_cnt_3m_ago,
        max(case when cat2= '综合类社交' then A2.cat_cnt_6m_ago_two end) as two_zongheleishejiao_cat_cnt_6m_ago,
        max(case when cat2= '综合资讯' then A2.cat_cnt_two end) as two_zonghezixun_cat_cnt,
        max(case when cat2= '综合资讯' then A2.cat_cnt_7d_ago_two end) as two_zonghezixun_cat_cnt_7d_ago,
        max(case when cat2= '综合资讯' then A2.cat_cnt_1m_ago_two end) as two_zonghezixun_cat_cnt_1m_ago,
        max(case when cat2= '综合资讯' then A2.cat_cnt_3m_ago_two end) as two_zonghezixun_cat_cnt_3m_ago,
        max(case when cat2= '综合资讯' then A2.cat_cnt_6m_ago_two end) as two_zonghezixun_cat_cnt_6m_ago,
        max(case when cat2= '综合金融' then A2.cat_cnt_two end) as two_zonghejinrong_cat_cnt,
        max(case when cat2= '综合金融' then A2.cat_cnt_7d_ago_two end) as two_zonghejinrong_cat_cnt_7d_ago,
        max(case when cat2= '综合金融' then A2.cat_cnt_1m_ago_two end) as two_zonghejinrong_cat_cnt_1m_ago,
        max(case when cat2= '综合金融' then A2.cat_cnt_3m_ago_two end) as two_zonghejinrong_cat_cnt_3m_ago,
        max(case when cat2= '综合金融' then A2.cat_cnt_6m_ago_two end) as two_zonghejinrong_cat_cnt_6m_ago,
        max(case when cat2= '网络K歌' then A2.cat_cnt_two end) as two_wangluoKge_cat_cnt,
        max(case when cat2= '网络K歌' then A2.cat_cnt_7d_ago_two end) as two_wangluoKge_cat_cnt_7d_ago,
        max(case when cat2= '网络K歌' then A2.cat_cnt_1m_ago_two end) as two_wangluoKge_cat_cnt_1m_ago,
        max(case when cat2= '网络K歌' then A2.cat_cnt_3m_ago_two end) as two_wangluoKge_cat_cnt_3m_ago,
        max(case when cat2= '网络K歌' then A2.cat_cnt_6m_ago_two end) as two_wangluoKge_cat_cnt_6m_ago,
        max(case when cat2= '美妆' then A2.cat_cnt_two end) as two_meizhuang_cat_cnt,
        max(case when cat2= '美妆' then A2.cat_cnt_7d_ago_two end) as two_meizhuang_cat_cnt_7d_ago,
        max(case when cat2= '美妆' then A2.cat_cnt_1m_ago_two end) as two_meizhuang_cat_cnt_1m_ago,
        max(case when cat2= '美妆' then A2.cat_cnt_3m_ago_two end) as two_meizhuang_cat_cnt_3m_ago,
        max(case when cat2= '美妆' then A2.cat_cnt_6m_ago_two end) as two_meizhuang_cat_cnt_6m_ago,
        max(case when cat2= '美食' then A2.cat_cnt_two end) as two_meishi_cat_cnt,
        max(case when cat2= '美食' then A2.cat_cnt_7d_ago_two end) as two_meishi_cat_cnt_7d_ago,
        max(case when cat2= '美食' then A2.cat_cnt_1m_ago_two end) as two_meishi_cat_cnt_1m_ago,
        max(case when cat2= '美食' then A2.cat_cnt_3m_ago_two end) as two_meishi_cat_cnt_3m_ago,
        max(case when cat2= '美食' then A2.cat_cnt_6m_ago_two end) as two_meishi_cat_cnt_6m_ago,
        max(case when cat2= '翻译服务' then A2.cat_cnt_two end) as two_fanyifuwu_cat_cnt,
        max(case when cat2= '翻译服务' then A2.cat_cnt_7d_ago_two end) as two_fanyifuwu_cat_cnt_7d_ago,
        max(case when cat2= '翻译服务' then A2.cat_cnt_1m_ago_two end) as two_fanyifuwu_cat_cnt_1m_ago,
        max(case when cat2= '翻译服务' then A2.cat_cnt_3m_ago_two end) as two_fanyifuwu_cat_cnt_3m_ago,
        max(case when cat2= '翻译服务' then A2.cat_cnt_6m_ago_two end) as two_fanyifuwu_cat_cnt_6m_ago,
        max(case when cat2= '职能技术类' then A2.cat_cnt_two end) as two_zhinengjishulei_cat_cnt,
        max(case when cat2= '职能技术类' then A2.cat_cnt_7d_ago_two end) as two_zhinengjishulei_cat_cnt_7d_ago,
        max(case when cat2= '职能技术类' then A2.cat_cnt_1m_ago_two end) as two_zhinengjishulei_cat_cnt_1m_ago,
        max(case when cat2= '职能技术类' then A2.cat_cnt_3m_ago_two end) as two_zhinengjishulei_cat_cnt_3m_ago,
        max(case when cat2= '职能技术类' then A2.cat_cnt_6m_ago_two end) as two_zhinengjishulei_cat_cnt_6m_ago,
        max(case when cat2= '航空公司官方APP' then A2.cat_cnt_two end) as two_hangkonggongsiguanfangAPP_cat_cnt,
        max(case when cat2= '航空公司官方APP' then A2.cat_cnt_7d_ago_two end) as two_hangkonggongsiguanfangAPP_cat_cnt_7d_ago,
        max(case when cat2= '航空公司官方APP' then A2.cat_cnt_1m_ago_two end) as two_hangkonggongsiguanfangAPP_cat_cnt_1m_ago,
        max(case when cat2= '航空公司官方APP' then A2.cat_cnt_3m_ago_two end) as two_hangkonggongsiguanfangAPP_cat_cnt_3m_ago,
        max(case when cat2= '航空公司官方APP' then A2.cat_cnt_6m_ago_two end) as two_hangkonggongsiguanfangAPP_cat_cnt_6m_ago,
        max(case when cat2= '虚拟交易' then A2.cat_cnt_two end) as two_xunijiaoyi_cat_cnt,
        max(case when cat2= '虚拟交易' then A2.cat_cnt_7d_ago_two end) as two_xunijiaoyi_cat_cnt_7d_ago,
        max(case when cat2= '虚拟交易' then A2.cat_cnt_1m_ago_two end) as two_xunijiaoyi_cat_cnt_1m_ago,
        max(case when cat2= '虚拟交易' then A2.cat_cnt_3m_ago_two end) as two_xunijiaoyi_cat_cnt_3m_ago,
        max(case when cat2= '虚拟交易' then A2.cat_cnt_6m_ago_two end) as two_xunijiaoyi_cat_cnt_6m_ago,
        max(case when cat2= '虚拟货币' then A2.cat_cnt_two end) as two_xunihuobi_cat2_cat_cnt,
        max(case when cat2= '虚拟货币' then A2.cat_cnt_7d_ago_two end) as two_xunihuobi_cat2_cat_cnt_7d_ago,
        max(case when cat2= '虚拟货币' then A2.cat_cnt_1m_ago_two end) as two_xunihuobi_cat2_cat_cnt_1m_ago,
        max(case when cat2= '虚拟货币' then A2.cat_cnt_3m_ago_two end) as two_xunihuobi_cat2_cat_cnt_3m_ago,
        max(case when cat2= '虚拟货币' then A2.cat_cnt_6m_ago_two end) as two_xunihuobi_cat2_cat_cnt_6m_ago,
        max(case when cat2= '视频会议' then A2.cat_cnt_two end) as two_shipinhuiyi_cat_cnt,
        max(case when cat2= '视频会议' then A2.cat_cnt_7d_ago_two end) as two_shipinhuiyi_cat_cnt_7d_ago,
        max(case when cat2= '视频会议' then A2.cat_cnt_1m_ago_two end) as two_shipinhuiyi_cat_cnt_1m_ago,
        max(case when cat2= '视频会议' then A2.cat_cnt_3m_ago_two end) as two_shipinhuiyi_cat_cnt_3m_ago,
        max(case when cat2= '视频会议' then A2.cat_cnt_6m_ago_two end) as two_shipinhuiyi_cat_cnt_6m_ago,
        max(case when cat2= '视频剪辑' then A2.cat_cnt_two end) as two_shipinjianji_cat_cnt,
        max(case when cat2= '视频剪辑' then A2.cat_cnt_7d_ago_two end) as two_shipinjianji_cat_cnt_7d_ago,
        max(case when cat2= '视频剪辑' then A2.cat_cnt_1m_ago_two end) as two_shipinjianji_cat_cnt_1m_ago,
        max(case when cat2= '视频剪辑' then A2.cat_cnt_3m_ago_two end) as two_shipinjianji_cat_cnt_3m_ago,
        max(case when cat2= '视频剪辑' then A2.cat_cnt_6m_ago_two end) as two_shipinjianji_cat_cnt_6m_ago,
        max(case when cat2= '证券服务' then A2.cat_cnt_two end) as two_zhengquanfuwu_cat_cnt,
        max(case when cat2= '证券服务' then A2.cat_cnt_7d_ago_two end) as two_zhengquanfuwu_cat_cnt_7d_ago,
        max(case when cat2= '证券服务' then A2.cat_cnt_1m_ago_two end) as two_zhengquanfuwu_cat_cnt_1m_ago,
        max(case when cat2= '证券服务' then A2.cat_cnt_3m_ago_two end) as two_zhengquanfuwu_cat_cnt_3m_ago,
        max(case when cat2= '证券服务' then A2.cat_cnt_6m_ago_two end) as two_zhengquanfuwu_cat_cnt_6m_ago,
        max(case when cat2= '语言翻译/学习' then A2.cat_cnt_two end) as two_yuyanfanyi_xuexi_cat_cnt,
        max(case when cat2= '语言翻译/学习' then A2.cat_cnt_7d_ago_two end) as two_yuyanfanyi_xuexi_cat_cnt_7d_ago,
        max(case when cat2= '语言翻译/学习' then A2.cat_cnt_1m_ago_two end) as two_yuyanfanyi_xuexi_cat_cnt_1m_ago,
        max(case when cat2= '语言翻译/学习' then A2.cat_cnt_3m_ago_two end) as two_yuyanfanyi_xuexi_cat_cnt_3m_ago,
        max(case when cat2= '语言翻译/学习' then A2.cat_cnt_6m_ago_two end) as two_yuyanfanyi_xuexi_cat_cnt_6m_ago,
        max(case when cat2= '货币买卖交易' then A2.cat_cnt_two end) as two_huobimaimaijiaoyi_cat_cnt,
        max(case when cat2= '货币买卖交易' then A2.cat_cnt_7d_ago_two end) as two_huobimaimaijiaoyi_cat_cnt_7d_ago,
        max(case when cat2= '货币买卖交易' then A2.cat_cnt_1m_ago_two end) as two_huobimaimaijiaoyi_cat_cnt_1m_ago,
        max(case when cat2= '货币买卖交易' then A2.cat_cnt_3m_ago_two end) as two_huobimaimaijiaoyi_cat_cnt_3m_ago,
        max(case when cat2= '货币买卖交易' then A2.cat_cnt_6m_ago_two end) as two_huobimaimaijiaoyi_cat_cnt_6m_ago,
        max(case when cat2= '货币信息咨询' then A2.cat_cnt_two end) as two_huobixinxizixun_cat1_cat_cnt,
        max(case when cat2= '货币信息咨询' then A2.cat_cnt_7d_ago_two end) as two_huobixinxizixun_cat1_cat_cnt_7d_ago,
        max(case when cat2= '货币信息咨询' then A2.cat_cnt_1m_ago_two end) as two_huobixinxizixun_cat1_cat_cnt_1m_ago,
        max(case when cat2= '货币信息咨询' then A2.cat_cnt_3m_ago_two end) as two_huobixinxizixun_cat1_cat_cnt_3m_ago,
        max(case when cat2= '货币信息咨询' then A2.cat_cnt_6m_ago_two end) as two_huobixinxizixun_cat1_cat_cnt_6m_ago,
        max(case when cat2= '货币信息资讯' then A2.cat_cnt_two end) as two_huobixinxizixun_cat2_cat_cnt,
        max(case when cat2= '货币信息资讯' then A2.cat_cnt_7d_ago_two end) as two_huobixinxizixun_cat2_cat_cnt_7d_ago,
        max(case when cat2= '货币信息资讯' then A2.cat_cnt_1m_ago_two end) as two_huobixinxizixun_cat2_cat_cnt_1m_ago,
        max(case when cat2= '货币信息资讯' then A2.cat_cnt_3m_ago_two end) as two_huobixinxizixun_cat2_cat_cnt_3m_ago,
        max(case when cat2= '货币信息资讯' then A2.cat_cnt_6m_ago_two end) as two_huobixinxizixun_cat2_cat_cnt_6m_ago,
        max(case when cat2= '货币挖矿类' then A2.cat_cnt_two end) as two_huobiwakuanglei_cat_cnt,
        max(case when cat2= '货币挖矿类' then A2.cat_cnt_7d_ago_two end) as two_huobiwakuanglei_cat_cnt_7d_ago,
        max(case when cat2= '货币挖矿类' then A2.cat_cnt_1m_ago_two end) as two_huobiwakuanglei_cat_cnt_1m_ago,
        max(case when cat2= '货币挖矿类' then A2.cat_cnt_3m_ago_two end) as two_huobiwakuanglei_cat_cnt_3m_ago,
        max(case when cat2= '货币挖矿类' then A2.cat_cnt_6m_ago_two end) as two_huobiwakuanglei_cat_cnt_6m_ago,
        max(case when cat2= '货币钱包' then A2.cat_cnt_two end) as two_huobiqianbao_cat_cnt,
        max(case when cat2= '货币钱包' then A2.cat_cnt_7d_ago_two end) as two_huobiqianbao_cat_cnt_7d_ago,
        max(case when cat2= '货币钱包' then A2.cat_cnt_1m_ago_two end) as two_huobiqianbao_cat_cnt_1m_ago,
        max(case when cat2= '货币钱包' then A2.cat_cnt_3m_ago_two end) as two_huobiqianbao_cat_cnt_3m_ago,
        max(case when cat2= '货币钱包' then A2.cat_cnt_6m_ago_two end) as two_huobiqianbao_cat_cnt_6m_ago,
        max(case when cat2= '贷款类' then A2.cat_cnt_two end) as two_daikuanlei_cat_cnt,
        max(case when cat2= '贷款类' then A2.cat_cnt_7d_ago_two end) as two_daikuanlei_cat_cnt_7d_ago,
        max(case when cat2= '贷款类' then A2.cat_cnt_1m_ago_two end) as two_daikuanlei_cat_cnt_1m_ago,
        max(case when cat2= '贷款类' then A2.cat_cnt_3m_ago_two end) as two_daikuanlei_cat_cnt_3m_ago,
        max(case when cat2= '贷款类' then A2.cat_cnt_6m_ago_two end) as two_daikuanlei_cat_cnt_6m_ago,
        max(case when cat2= '贷超' then A2.cat_cnt_two end) as two_daichao_cat_cnt,
        max(case when cat2= '贷超' then A2.cat_cnt_7d_ago_two end) as two_daichao_cat_cnt_7d_ago,
        max(case when cat2= '贷超' then A2.cat_cnt_1m_ago_two end) as two_daichao_cat_cnt_1m_ago,
        max(case when cat2= '贷超' then A2.cat_cnt_3m_ago_two end) as two_daichao_cat_cnt_3m_ago,
        max(case when cat2= '贷超' then A2.cat_cnt_6m_ago_two end) as two_daichao_cat_cnt_6m_ago,
        max(case when cat2= '资讯搜索' then A2.cat_cnt_two end) as two_zixunsousuo_cat_cnt,
        max(case when cat2= '资讯搜索' then A2.cat_cnt_7d_ago_two end) as two_zixunsousuo_cat_cnt_7d_ago,
        max(case when cat2= '资讯搜索' then A2.cat_cnt_1m_ago_two end) as two_zixunsousuo_cat_cnt_1m_ago,
        max(case when cat2= '资讯搜索' then A2.cat_cnt_3m_ago_two end) as two_zixunsousuo_cat_cnt_3m_ago,
        max(case when cat2= '资讯搜索' then A2.cat_cnt_6m_ago_two end) as two_zixunsousuo_cat_cnt_6m_ago,
        max(case when cat2= '资讯类' then A2.cat_cnt_two end) as two_zixunlei_cat_cnt,
        max(case when cat2= '资讯类' then A2.cat_cnt_7d_ago_two end) as two_zixunlei_cat_cnt_7d_ago,
        max(case when cat2= '资讯类' then A2.cat_cnt_1m_ago_two end) as two_zixunlei_cat_cnt_1m_ago,
        max(case when cat2= '资讯类' then A2.cat_cnt_3m_ago_two end) as two_zixunlei_cat_cnt_3m_ago,
        max(case when cat2= '资讯类' then A2.cat_cnt_6m_ago_two end) as two_zixunlei_cat_cnt_6m_ago,
        max(case when cat2= '车后服务' then A2.cat_cnt_two end) as two_chehoufuwu_cat_cnt,
        max(case when cat2= '车后服务' then A2.cat_cnt_7d_ago_two end) as two_chehoufuwu_cat_cnt_7d_ago,
        max(case when cat2= '车后服务' then A2.cat_cnt_1m_ago_two end) as two_chehoufuwu_cat_cnt_1m_ago,
        max(case when cat2= '车后服务' then A2.cat_cnt_3m_ago_two end) as two_chehoufuwu_cat_cnt_3m_ago,
        max(case when cat2= '车后服务' then A2.cat_cnt_6m_ago_two end) as two_chehoufuwu_cat_cnt_6m_ago,
        max(case when cat2= '车票服务' then A2.cat_cnt_two end) as two_chepiaofuwu_cat_cnt,
        max(case when cat2= '车票服务' then A2.cat_cnt_7d_ago_two end) as two_chepiaofuwu_cat_cnt_7d_ago,
        max(case when cat2= '车票服务' then A2.cat_cnt_1m_ago_two end) as two_chepiaofuwu_cat_cnt_1m_ago,
        max(case when cat2= '车票服务' then A2.cat_cnt_3m_ago_two end) as two_chepiaofuwu_cat_cnt_3m_ago,
        max(case when cat2= '车票服务' then A2.cat_cnt_6m_ago_two end) as two_chepiaofuwu_cat_cnt_6m_ago,
        max(case when cat2= '车辆服务类' then A2.cat_cnt_two end) as two_cheliangfuwulei_cat_cnt,
        max(case when cat2= '车辆服务类' then A2.cat_cnt_7d_ago_two end) as two_cheliangfuwulei_cat_cnt_7d_ago,
        max(case when cat2= '车辆服务类' then A2.cat_cnt_1m_ago_two end) as two_cheliangfuwulei_cat_cnt_1m_ago,
        max(case when cat2= '车辆服务类' then A2.cat_cnt_3m_ago_two end) as two_cheliangfuwulei_cat_cnt_3m_ago,
        max(case when cat2= '车辆服务类' then A2.cat_cnt_6m_ago_two end) as two_cheliangfuwulei_cat_cnt_6m_ago,
        max(case when cat2= '输入法' then A2.cat_cnt_two end) as two_shurufa_cat_cnt,
        max(case when cat2= '输入法' then A2.cat_cnt_7d_ago_two end) as two_shurufa_cat_cnt_7d_ago,
        max(case when cat2= '输入法' then A2.cat_cnt_1m_ago_two end) as two_shurufa_cat_cnt_1m_ago,
        max(case when cat2= '输入法' then A2.cat_cnt_3m_ago_two end) as two_shurufa_cat_cnt_3m_ago,
        max(case when cat2= '输入法' then A2.cat_cnt_6m_ago_two end) as two_shurufa_cat_cnt_6m_ago,
        max(case when cat2= '运动瘦身' then A2.cat_cnt_two end) as two_yundongshoushen_cat_cnt,
        max(case when cat2= '运动瘦身' then A2.cat_cnt_7d_ago_two end) as two_yundongshoushen_cat_cnt_7d_ago,
        max(case when cat2= '运动瘦身' then A2.cat_cnt_1m_ago_two end) as two_yundongshoushen_cat_cnt_1m_ago,
        max(case when cat2= '运动瘦身' then A2.cat_cnt_3m_ago_two end) as two_yundongshoushen_cat_cnt_3m_ago,
        max(case when cat2= '运动瘦身' then A2.cat_cnt_6m_ago_two end) as two_yundongshoushen_cat_cnt_6m_ago,
        max(case when cat2= '邮箱APP' then A2.cat_cnt_two end) as two_youxiangAPP_cat_cnt,
        max(case when cat2= '邮箱APP' then A2.cat_cnt_7d_ago_two end) as two_youxiangAPP_cat_cnt_7d_ago,
        max(case when cat2= '邮箱APP' then A2.cat_cnt_1m_ago_two end) as two_youxiangAPP_cat_cnt_1m_ago,
        max(case when cat2= '邮箱APP' then A2.cat_cnt_3m_ago_two end) as two_youxiangAPP_cat_cnt_3m_ago,
        max(case when cat2= '邮箱APP' then A2.cat_cnt_6m_ago_two end) as two_youxiangAPP_cat_cnt_6m_ago,
        max(case when cat2= '金融推广类' then A2.cat_cnt_two end) as two_jinrongtuiguanglei_cat2_cat_cnt,
        max(case when cat2= '金融推广类' then A2.cat_cnt_7d_ago_two end) as two_jinrongtuiguanglei_cat2_cat_cnt_7d_ago,
        max(case when cat2= '金融推广类' then A2.cat_cnt_1m_ago_two end) as two_jinrongtuiguanglei_cat2_cat_cnt_1m_ago,
        max(case when cat2= '金融推广类' then A2.cat_cnt_3m_ago_two end) as two_jinrongtuiguanglei_cat2_cat_cnt_3m_ago,
        max(case when cat2= '金融推广类' then A2.cat_cnt_6m_ago_two end) as two_jinrongtuiguanglei_cat2_cat_cnt_6m_ago,
        max(case when cat2= '银行信用卡' then A2.cat_cnt_two end) as two_yinhangxinyongka_cat2_cat_cnt,
        max(case when cat2= '银行信用卡' then A2.cat_cnt_7d_ago_two end) as two_yinhangxinyongka_cat2_cat_cnt_7d_ago,
        max(case when cat2= '银行信用卡' then A2.cat_cnt_1m_ago_two end) as two_yinhangxinyongka_cat2_cat_cnt_1m_ago,
        max(case when cat2= '银行信用卡' then A2.cat_cnt_3m_ago_two end) as two_yinhangxinyongka_cat2_cat_cnt_3m_ago,
        max(case when cat2= '银行信用卡' then A2.cat_cnt_6m_ago_two end) as two_yinhangxinyongka_cat2_cat_cnt_6m_ago,
        max(case when cat2= '银行系贷款' then A2.cat_cnt_two end) as two_yinhangxidaikuan_cat_cnt,
        max(case when cat2= '银行系贷款' then A2.cat_cnt_7d_ago_two end) as two_yinhangxidaikuan_cat_cnt_7d_ago,
        max(case when cat2= '银行系贷款' then A2.cat_cnt_1m_ago_two end) as two_yinhangxidaikuan_cat_cnt_1m_ago,
        max(case when cat2= '银行系贷款' then A2.cat_cnt_3m_ago_two end) as two_yinhangxidaikuan_cat_cnt_3m_ago,
        max(case when cat2= '银行系贷款' then A2.cat_cnt_6m_ago_two end) as two_yinhangxidaikuan_cat_cnt_6m_ago,
        max(case when cat2= '问答社交' then A2.cat_cnt_two end) as two_wendashejiao_cat_cnt,
        max(case when cat2= '问答社交' then A2.cat_cnt_7d_ago_two end) as two_wendashejiao_cat_cnt_7d_ago,
        max(case when cat2= '问答社交' then A2.cat_cnt_1m_ago_two end) as two_wendashejiao_cat_cnt_1m_ago,
        max(case when cat2= '问答社交' then A2.cat_cnt_3m_ago_two end) as two_wendashejiao_cat_cnt_3m_ago,
        max(case when cat2= '问答社交' then A2.cat_cnt_6m_ago_two end) as two_wendashejiao_cat_cnt_6m_ago,
        max(case when cat2= '闲置物品转让' then A2.cat_cnt_two end) as two_xianzhiwupinzhuanrang_cat_cnt,
        max(case when cat2= '闲置物品转让' then A2.cat_cnt_7d_ago_two end) as two_xianzhiwupinzhuanrang_cat_cnt_7d_ago,
        max(case when cat2= '闲置物品转让' then A2.cat_cnt_1m_ago_two end) as two_xianzhiwupinzhuanrang_cat_cnt_1m_ago,
        max(case when cat2= '闲置物品转让' then A2.cat_cnt_3m_ago_two end) as two_xianzhiwupinzhuanrang_cat_cnt_3m_ago,
        max(case when cat2= '闲置物品转让' then A2.cat_cnt_6m_ago_two end) as two_xianzhiwupinzhuanrang_cat_cnt_6m_ago,
        max(case when cat2= '阅读类' then A2.cat_cnt_two end) as two_yuedulei_cat_cnt,
        max(case when cat2= '阅读类' then A2.cat_cnt_7d_ago_two end) as two_yuedulei_cat_cnt_7d_ago,
        max(case when cat2= '阅读类' then A2.cat_cnt_1m_ago_two end) as two_yuedulei_cat_cnt_1m_ago,
        max(case when cat2= '阅读类' then A2.cat_cnt_3m_ago_two end) as two_yuedulei_cat_cnt_3m_ago,
        max(case when cat2= '阅读类' then A2.cat_cnt_6m_ago_two end) as two_yuedulei_cat_cnt_6m_ago,
        max(case when cat2= '陌生人社交' then A2.cat_cnt_two end) as two_moshengrenshejiao_cat_cnt,
        max(case when cat2= '陌生人社交' then A2.cat_cnt_7d_ago_two end) as two_moshengrenshejiao_cat_cnt_7d_ago,
        max(case when cat2= '陌生人社交' then A2.cat_cnt_1m_ago_two end) as two_moshengrenshejiao_cat_cnt_1m_ago,
        max(case when cat2= '陌生人社交' then A2.cat_cnt_3m_ago_two end) as two_moshengrenshejiao_cat_cnt_3m_ago,
        max(case when cat2= '陌生人社交' then A2.cat_cnt_6m_ago_two end) as two_moshengrenshejiao_cat_cnt_6m_ago,
        max(case when cat2= '驾考服务' then A2.cat_cnt_two end) as two_jiakaofuwu_cat_cnt,
        max(case when cat2= '驾考服务' then A2.cat_cnt_7d_ago_two end) as two_jiakaofuwu_cat_cnt_7d_ago,
        max(case when cat2= '驾考服务' then A2.cat_cnt_1m_ago_two end) as two_jiakaofuwu_cat_cnt_1m_ago,
        max(case when cat2= '驾考服务' then A2.cat_cnt_3m_ago_two end) as two_jiakaofuwu_cat_cnt_3m_ago,
        max(case when cat2= '驾考服务' then A2.cat_cnt_6m_ago_two end) as two_jiakaofuwu_cat_cnt_6m_ago,
        max(case when cat2= '高效办公' then A2.cat_cnt_two end) as two_gaoxiaobangong_cat_cnt,
        max(case when cat2= '高效办公' then A2.cat_cnt_7d_ago_two end) as two_gaoxiaobangong_cat_cnt_7d_ago,
        max(case when cat2= '高效办公' then A2.cat_cnt_1m_ago_two end) as two_gaoxiaobangong_cat_cnt_1m_ago,
        max(case when cat2= '高效办公' then A2.cat_cnt_3m_ago_two end) as two_gaoxiaobangong_cat_cnt_3m_ago,
        max(case when cat2= '高效办公' then A2.cat_cnt_6m_ago_two end) as two_gaoxiaobangong_cat_cnt_6m_ago,
        max(case when cat2= '高端求职APP' then A2.cat_cnt_two end) as two_gaoduanqiuzhiAPP_cat_cnt,
        max(case when cat2= '高端求职APP' then A2.cat_cnt_7d_ago_two end) as two_gaoduanqiuzhiAPP_cat_cnt_7d_ago,
        max(case when cat2= '高端求职APP' then A2.cat_cnt_1m_ago_two end) as two_gaoduanqiuzhiAPP_cat_cnt_1m_ago,
        max(case when cat2= '高端求职APP' then A2.cat_cnt_3m_ago_two end) as two_gaoduanqiuzhiAPP_cat_cnt_3m_ago,
        max(case when cat2= '高端求职APP' then A2.cat_cnt_6m_ago_two end) as two_gaoduanqiuzhiAPP_cat_cnt_6m_ago,
        max(case when cat2= '黑产中介' then A2.cat_cnt_two end) as two_heichanzhongjie_cat_cnt,
        max(case when cat2= '黑产中介' then A2.cat_cnt_7d_ago_two end) as two_heichanzhongjie_cat_cnt_7d_ago,
        max(case when cat2= '黑产中介' then A2.cat_cnt_1m_ago_two end) as two_heichanzhongjie_cat_cnt_1m_ago,
        max(case when cat2= '黑产中介' then A2.cat_cnt_3m_ago_two end) as two_heichanzhongjie_cat_cnt_3m_ago,
        max(case when cat2= '黑产中介' then A2.cat_cnt_6m_ago_two end) as two_heichanzhongjie_cat_cnt_6m_ago
    from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp04 A2
    group by uid, ds
    ) B2 on a.uid = B2.uid and a.ds = B2.ds

left join 
    (
    select 
        uid,
        ds,
        max(case when cat3= '负向类' then A3.cat_cnt_three end) as three_fuxianglei_cat_cnt,
        max(case when cat3= '负向类' then A3.cat_cnt_7d_ago_three end) as three_fuxianglei_cat_cnt_7d_ago,
        max(case when cat3= '负向类' then A3.cat_cnt_1m_ago_three end) as three_fuxianglei_cat_cnt_1m_ago,
        max(case when cat3= '负向类' then A3.cat_cnt_3m_ago_three end) as three_fuxianglei_cat_cnt_3m_ago,
        max(case when cat3= '负向类' then A3.cat_cnt_6m_ago_three end) as three_fuxianglei_cat_cnt_6m_ago,
        max(case when cat3= '超级正向类' then A3.cat_cnt_three end) as three_chaojizhengxianglei_cat_cnt,
        max(case when cat3= '超级正向类' then A3.cat_cnt_7d_ago_three end) as three_chaojizhengxianglei_cat_cnt_7d_ago,
        max(case when cat3= '超级正向类' then A3.cat_cnt_1m_ago_three end) as three_chaojizhengxianglei_cat_cnt_1m_ago,
        max(case when cat3= '超级正向类' then A3.cat_cnt_3m_ago_three end) as three_chaojizhengxianglei_cat_cnt_3m_ago,
        max(case when cat3= '超级正向类' then A3.cat_cnt_6m_ago_three end) as three_chaojizhengxianglei_cat_cnt_6m_ago,
        max(case when cat3= '正向类' then A3.cat_cnt_three end) as three_zhengxianglei_cat_cnt,
        max(case when cat3= '正向类' then A3.cat_cnt_7d_ago_three end) as three_zhengxianglei_cat_cnt_7d_ago,
        max(case when cat3= '正向类' then A3.cat_cnt_1m_ago_three end) as three_zhengxianglei_cat_cnt_1m_ago,
        max(case when cat3= '正向类' then A3.cat_cnt_3m_ago_three end) as three_zhengxianglei_cat_cnt_3m_ago,
        max(case when cat3= '正向类' then A3.cat_cnt_6m_ago_three end) as three_zhengxianglei_cat_cnt_6m_ago
    from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp05 A3
    group by uid , ds
    ) B3 on a.uid = B3.uid and a.ds = B3.ds

left join 
    (
    select 
        uid,
        ds,
        max(case when portrait_5features= '身份特质' then A4.cat_cnt_portrait end) as portrait_shenfentezhi_cat_cnt,
        max(case when portrait_5features= '消费支付' then A4.cat_cnt_portrait end) as portrait_xiaofeizhifu_cat_cnt,
        max(case when portrait_5features= '多头品行' then A4.cat_cnt_portrait end) as portrait_duotoupinxing_cat_cnt,
        max(case when portrait_5features= '资产状况' then A4.cat_cnt_portrait end) as portrait_zicanzhuangkuang_cat_cnt,
        max(case when portrait_5features= '关系网络' then A4.cat_cnt_portrait end) as portrait_guanxiwangluo_cat_cnt,
        max(case when portrait_5features= '其他' then A4.cat_cnt_portrait end) as portrait_qita_cat_cnt
    from ${pdm_risk}.pdm_risk_applist_v3_exists_cate_tmp0501 A4
    group by uid , ds
    ) B4 on a.uid = B4.uid and a.ds = B4.ds;
-- feature-copilot:node-end ordinal=0
