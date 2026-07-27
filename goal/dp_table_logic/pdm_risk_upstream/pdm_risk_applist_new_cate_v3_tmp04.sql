-- feature-copilot:node-begin ordinal=0
-- table_name: pdm_risk_applist_new_cate_v3_tmp04
-- node_id: n_4644409992749187072
-- task_name: pdm_risk_applist_feature_newfeature_di_v3
-- owner_name: 牛莲泽
-- source_json: goal/dp_table_logic/pdm_risk_upstream/pdm_risk_applist_new_cate_v3_tmp04.json
-- source_json_sha256: 49915e2aa20edf90852194f5f535265a795202f6c6d6e79fc4b50147c184f66a
-- upstream_table: pdm_risk.pdm_risk_applist_new_cate_v3_tmp02
-- upstream_table: pdw_manual.pdw_manual_applist_category_202303_v3
-- upstream_table: ods_pdw_loan.ods_pdw_loan_oss_lattebank_client_collect_applist_di
-- upstream_table: pdm_risk.pdm_risk_applist_new_cate_v3_tmp03
-- upstream_table: pdm_risk.pdm_risk_applist_new_cate_v3_tmp06
-- upstream_table: pdm_risk.pdm_risk_applist_new_cate_v3_tmp04
-- upstream_table: pdm_risk.pdm_risk_applist_new_cate_v3_tmp01

drop table if exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp01;
create table if not exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp01 as
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


drop table if exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp02;
create table ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp02 as
with tmp01 as (select * from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp01)
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

drop table if exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp03;
create table ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp03 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,cat1 order by cat_cnt_one desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp04;
create table ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp04 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,cat2 order by cat_cnt_two desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp05;
create table ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp05 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,cat3 order by cat_cnt_three desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp0501;
create table ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp0501 as 
select * from 
(select a.*,row_number() over(partition by uid,ds,portrait_5features order by cat_cnt_portrait desc ) as rn 
from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp02 as a 
) as t
where t.rn=1 and uid is not null;

drop table if exists ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp06;
create table ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp06 as
select a.uid, a.ds, a.cet_tim, a.app_total_num from 
(select uid, ds, cet_tim, app_total_num, row_number() over(partition by uid, ds order by app_total_num desc) as rm 
from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp02
) as a 
where a.rm = 1 and uid is not null;

insert OVERWRITE table pdm_risk.pdm_risk_applist_feature_newfeature_di_v3 partition (ds = '${bizdate}')
select a.uid,
a.cet_tim,

one_zhujilei_cat_cnt,one_zhujilei_cat_cnt_7d_ago,one_zhujilei_cat_cnt_1m_ago,one_zhujilei_cat_cnt_3m_ago,one_zhujilei_cat_cnt_6m_ago,

two_chengshishangyeyinhang_cat_cnt_ago,two_chengshishangyeyinhang_cat_cnt_7d_ago,two_chengshishangyeyinhang_cat_cnt_1m_ago,two_chengshishangyeyinhang_cat_cnt_3m_ago,two_chengshishangyeyinhang_cat_cnt_6m_ago,two_chengshishangyeyinhangxinyongka_cat_cnt_ago,two_chengshishangyeyinhangxinyongka_cat_cnt_7d_ago,two_chengshishangyeyinhangxinyongka_cat_cnt_1m_ago,two_chengshishangyeyinhangxinyongka_cat_cnt_3m_ago,two_chengshishangyeyinhangxinyongka_cat_cnt_6m_ago,two_cunzhenyinhang_cat_cnt_ago,two_cunzhenyinhang_cat_cnt_7d_ago,two_cunzhenyinhang_cat_cnt_1m_ago,two_cunzhenyinhang_cat_cnt_3m_ago,two_cunzhenyinhang_cat_cnt_6m_ago,two_daxinggufenzhishangyeyinhang_cat_cnt_ago,two_daxinggufenzhishangyeyinhang_cat_cnt_7d_ago,two_daxinggufenzhishangyeyinhang_cat_cnt_1m_ago,two_daxinggufenzhishangyeyinhang_cat_cnt_3m_ago,two_daxinggufenzhishangyeyinhang_cat_cnt_6m_ago,two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_ago,two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_7d_ago,two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_1m_ago,two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_3m_ago,two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_6m_ago,two_guoyoushangyeyinhang_cat_cnt_ago,two_guoyoushangyeyinhang_cat_cnt_7d_ago,two_guoyoushangyeyinhang_cat_cnt_1m_ago,two_guoyoushangyeyinhang_cat_cnt_3m_ago,two_guoyoushangyeyinhang_cat_cnt_6m_ago,two_nongcunshangyeyinhang_cat_cnt_ago,two_nongcunshangyeyinhang_cat_cnt_7d_ago,two_nongcunshangyeyinhang_cat_cnt_1m_ago,two_nongcunshangyeyinhang_cat_cnt_3m_ago,two_nongcunshangyeyinhang_cat_cnt_6m_ago,two_nongcunshangyeyinhangxinyongka_cat_cnt_ago,two_nongcunshangyeyinhangxinyongka_cat_cnt_7d_ago,two_nongcunshangyeyinhangxinyongka_cat_cnt_1m_ago,two_nongcunshangyeyinhangxinyongka_cat_cnt_3m_ago,two_nongcunshangyeyinhangxinyongka_cat_cnt_6m_ago,two_nongcunxinyonghezuoshe_cat_cnt_ago,two_nongcunxinyonghezuoshe_cat_cnt_7d_ago,two_nongcunxinyonghezuoshe_cat_cnt_1m_ago,two_nongcunxinyonghezuoshe_cat_cnt_3m_ago,two_nongcunxinyonghezuoshe_cat_cnt_6m_ago,two_waiziyinhang_cat_cnt_ago,two_waiziyinhang_cat_cnt_7d_ago,two_waiziyinhang_cat_cnt_1m_ago,two_waiziyinhang_cat_cnt_3m_ago,two_waiziyinhang_cat_cnt_6m_ago,two_dianzishuyuedulei_cat_cnt_ago,two_dianzishuyuedulei_cat_cnt_7d_ago,two_dianzishuyuedulei_cat_cnt_1m_ago,two_dianzishuyuedulei_cat_cnt_3m_ago,two_dianzishuyuedulei_cat_cnt_6m_ago,two_jiaoyufuzhulei_cat_cnt_ago,two_jiaoyufuzhulei_cat_cnt_7d_ago,two_jiaoyufuzhulei_cat_cnt_1m_ago,two_jiaoyufuzhulei_cat_cnt_3m_ago,two_jiaoyufuzhulei_cat_cnt_6m_ago,two_jiaoyukaoshilei_cat_cnt_ago,two_jiaoyukaoshilei_cat_cnt_7d_ago,two_jiaoyukaoshilei_cat_cnt_1m_ago,two_jiaoyukaoshilei_cat_cnt_3m_ago,two_jiaoyukaoshilei_cat_cnt_6m_ago,two_zujilei_cat_cnt_ago,two_zujilei_cat_cnt_7d_ago,two_zujilei_cat_cnt_1m_ago,two_zujilei_cat_cnt_3m_ago,two_zujilei_cat_cnt_6m_ago,

one_zhujilei_cat_cnt/app_total_num as one_zhujilei_cat_cnt_rate,
two_chengshishangyeyinhang_cat_cnt_ago/app_total_num as two_chengshishangyeyinhang_cat_cnt_ago_rate,
two_chengshishangyeyinhangxinyongka_cat_cnt_ago/app_total_num as two_chengshishangyeyinhangxinyongka_cat_cnt_ago_rate,
two_cunzhenyinhang_cat_cnt_ago/app_total_num as two_cunzhenyinhang_cat_cnt_ago_rate,
two_daxinggufenzhishangyeyinhang_cat_cnt_ago/app_total_num as two_daxinggufenzhishangyeyinhang_cat_cnt_ago_rate,
two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_ago/app_total_num as two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_ago_rate,
two_guoyoushangyeyinhang_cat_cnt_ago/app_total_num as two_guoyoushangyeyinhang_cat_cnt_ago_rate,
two_nongcunshangyeyinhang_cat_cnt_ago/app_total_num as two_nongcunshangyeyinhang_cat_cnt_ago_rate,
two_nongcunshangyeyinhangxinyongka_cat_cnt_ago/app_total_num as two_nongcunshangyeyinhangxinyongka_cat_cnt_ago_rate,two_nongcunxinyonghezuoshe_cat_cnt_ago/app_total_num as two_nongcunxinyonghezuoshe_cat_cnt_ago_rate,two_waiziyinhang_cat_cnt_ago/app_total_num as two_waiziyinhang_cat_cnt_ago_rate,two_dianzishuyuedulei_cat_cnt_ago/app_total_num as two_dianzishuyuedulei_cat_cnt_ago_rate,two_jiaoyufuzhulei_cat_cnt_ago/app_total_num as two_jiaoyufuzhulei_cat_cnt_ago_rate,two_jiaoyukaoshilei_cat_cnt_ago/app_total_num as two_jiaoyukaoshilei_cat_cnt_ago_rate,two_zujilei_cat_cnt_ago/app_total_num as two_zujilei_cat_cnt_ago_rate
from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp06 as a
left join 
    (
    select 
        uid,
        ds,
        max(case when cat1= '租机类' then A1.cat_cnt_one end) as one_zhujilei_cat_cnt,
        max(case when cat1= '租机类' then A1.cat_cnt_7d_ago_one end) as one_zhujilei_cat_cnt_7d_ago,
        max(case when cat1= '租机类' then A1.cat_cnt_1m_ago_one end) as one_zhujilei_cat_cnt_1m_ago,
        max(case when cat1= '租机类' then A1.cat_cnt_3m_ago_one end) as one_zhujilei_cat_cnt_3m_ago,
        max(case when cat1= '租机类' then A1.cat_cnt_6m_ago_one end) as one_zhujilei_cat_cnt_6m_ago
    from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp03 A1
    group by uid , ds
    ) B1 on a.uid = B1.uid and a.ds = B1.ds

left join 
    (
    select 
        uid,
        ds,
        max(case when cat2= '城市商业银行'  then A2.cat_cnt_two end) as two_chengshishangyeyinhang_cat_cnt_ago,
        max(case when cat2= '城市商业银行'  then A2.cat_cnt_7d_ago_two end) as two_chengshishangyeyinhang_cat_cnt_7d_ago,
        max(case when cat2= '城市商业银行'  then A2.cat_cnt_1m_ago_two end) as two_chengshishangyeyinhang_cat_cnt_1m_ago,
        max(case when cat2= '城市商业银行'  then A2.cat_cnt_3m_ago_two end) as two_chengshishangyeyinhang_cat_cnt_3m_ago,
        max(case when cat2= '城市商业银行'  then A2.cat_cnt_6m_ago_two end) as two_chengshishangyeyinhang_cat_cnt_6m_ago,
        max(case when cat2= '城市商业银行信用卡'  then A2.cat_cnt_two end) as two_chengshishangyeyinhangxinyongka_cat_cnt_ago,
        max(case when cat2= '城市商业银行信用卡'  then A2.cat_cnt_7d_ago_two end) as two_chengshishangyeyinhangxinyongka_cat_cnt_7d_ago,
        max(case when cat2= '城市商业银行信用卡'  then A2.cat_cnt_1m_ago_two end) as two_chengshishangyeyinhangxinyongka_cat_cnt_1m_ago,
        max(case when cat2= '城市商业银行信用卡'  then A2.cat_cnt_3m_ago_two end) as two_chengshishangyeyinhangxinyongka_cat_cnt_3m_ago,
        max(case when cat2= '城市商业银行信用卡'  then A2.cat_cnt_6m_ago_two end) as two_chengshishangyeyinhangxinyongka_cat_cnt_6m_ago,
        max(case when cat2= '村镇银行'  then A2.cat_cnt_two end) as two_cunzhenyinhang_cat_cnt_ago,
        max(case when cat2= '村镇银行'  then A2.cat_cnt_7d_ago_two end) as two_cunzhenyinhang_cat_cnt_7d_ago,
        max(case when cat2= '村镇银行'  then A2.cat_cnt_1m_ago_two end) as two_cunzhenyinhang_cat_cnt_1m_ago,
        max(case when cat2= '村镇银行'  then A2.cat_cnt_3m_ago_two end) as two_cunzhenyinhang_cat_cnt_3m_ago,
        max(case when cat2= '村镇银行'  then A2.cat_cnt_6m_ago_two end) as two_cunzhenyinhang_cat_cnt_6m_ago,
        max(case when cat2= '大型股份制商业银行'  then A2.cat_cnt_two end) as two_daxinggufenzhishangyeyinhang_cat_cnt_ago,
        max(case when cat2= '大型股份制商业银行'  then A2.cat_cnt_7d_ago_two end) as two_daxinggufenzhishangyeyinhang_cat_cnt_7d_ago,
        max(case when cat2= '大型股份制商业银行'  then A2.cat_cnt_1m_ago_two end) as two_daxinggufenzhishangyeyinhang_cat_cnt_1m_ago,
        max(case when cat2= '大型股份制商业银行'  then A2.cat_cnt_3m_ago_two end) as two_daxinggufenzhishangyeyinhang_cat_cnt_3m_ago,
        max(case when cat2= '大型股份制商业银行'  then A2.cat_cnt_6m_ago_two end) as two_daxinggufenzhishangyeyinhang_cat_cnt_6m_ago,
        max(case when cat2= '大型股份制商业银行信用卡'  then A2.cat_cnt_two end) as two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_ago,
        max(case when cat2= '大型股份制商业银行信用卡'  then A2.cat_cnt_7d_ago_two end) as two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_7d_ago,
        max(case when cat2= '大型股份制商业银行信用卡'  then A2.cat_cnt_1m_ago_two end) as two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_1m_ago,
        max(case when cat2= '大型股份制商业银行信用卡'  then A2.cat_cnt_3m_ago_two end) as two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_3m_ago,
        max(case when cat2= '大型股份制商业银行信用卡'  then A2.cat_cnt_6m_ago_two end) as two_daxinggufenzhishangyeyinhangxinyongka_cat_cnt_6m_ago,
        max(case when cat2= '国有商业银行'  then A2.cat_cnt_two end) as two_guoyoushangyeyinhang_cat_cnt_ago,
        max(case when cat2= '国有商业银行'  then A2.cat_cnt_7d_ago_two end) as two_guoyoushangyeyinhang_cat_cnt_7d_ago,
        max(case when cat2= '国有商业银行'  then A2.cat_cnt_1m_ago_two end) as two_guoyoushangyeyinhang_cat_cnt_1m_ago,
        max(case when cat2= '国有商业银行'  then A2.cat_cnt_3m_ago_two end) as two_guoyoushangyeyinhang_cat_cnt_3m_ago,
        max(case when cat2= '国有商业银行'  then A2.cat_cnt_6m_ago_two end) as two_guoyoushangyeyinhang_cat_cnt_6m_ago,
        max(case when cat2= '农村商业银行'  then A2.cat_cnt_two end) as two_nongcunshangyeyinhang_cat_cnt_ago,
        max(case when cat2= '农村商业银行'  then A2.cat_cnt_7d_ago_two end) as two_nongcunshangyeyinhang_cat_cnt_7d_ago,
        max(case when cat2= '农村商业银行'  then A2.cat_cnt_1m_ago_two end) as two_nongcunshangyeyinhang_cat_cnt_1m_ago,
        max(case when cat2= '农村商业银行'  then A2.cat_cnt_3m_ago_two end) as two_nongcunshangyeyinhang_cat_cnt_3m_ago,
        max(case when cat2= '农村商业银行'  then A2.cat_cnt_6m_ago_two end) as two_nongcunshangyeyinhang_cat_cnt_6m_ago,
        max(case when cat2= '农村商业银行信用卡'  then A2.cat_cnt_two end) as two_nongcunshangyeyinhangxinyongka_cat_cnt_ago,
        max(case when cat2= '农村商业银行信用卡'  then A2.cat_cnt_7d_ago_two end) as two_nongcunshangyeyinhangxinyongka_cat_cnt_7d_ago,
        max(case when cat2= '农村商业银行信用卡'  then A2.cat_cnt_1m_ago_two end) as two_nongcunshangyeyinhangxinyongka_cat_cnt_1m_ago,
        max(case when cat2= '农村商业银行信用卡'  then A2.cat_cnt_3m_ago_two end) as two_nongcunshangyeyinhangxinyongka_cat_cnt_3m_ago,
        max(case when cat2= '农村商业银行信用卡'  then A2.cat_cnt_6m_ago_two end) as two_nongcunshangyeyinhangxinyongka_cat_cnt_6m_ago,
        max(case when cat2= '农村信用合作社'  then A2.cat_cnt_two end) as two_nongcunxinyonghezuoshe_cat_cnt_ago,
        max(case when cat2= '农村信用合作社'  then A2.cat_cnt_7d_ago_two end) as two_nongcunxinyonghezuoshe_cat_cnt_7d_ago,
        max(case when cat2= '农村信用合作社'  then A2.cat_cnt_1m_ago_two end) as two_nongcunxinyonghezuoshe_cat_cnt_1m_ago,
        max(case when cat2= '农村信用合作社'  then A2.cat_cnt_3m_ago_two end) as two_nongcunxinyonghezuoshe_cat_cnt_3m_ago,
        max(case when cat2= '农村信用合作社'  then A2.cat_cnt_6m_ago_two end) as two_nongcunxinyonghezuoshe_cat_cnt_6m_ago,
        max(case when cat2= '外资银行'  then A2.cat_cnt_two end) as two_waiziyinhang_cat_cnt_ago,
        max(case when cat2= '外资银行'  then A2.cat_cnt_7d_ago_two end) as two_waiziyinhang_cat_cnt_7d_ago,
        max(case when cat2= '外资银行'  then A2.cat_cnt_1m_ago_two end) as two_waiziyinhang_cat_cnt_1m_ago,
        max(case when cat2= '外资银行'  then A2.cat_cnt_3m_ago_two end) as two_waiziyinhang_cat_cnt_3m_ago,
        max(case when cat2= '外资银行'  then A2.cat_cnt_6m_ago_two end) as two_waiziyinhang_cat_cnt_6m_ago,
        max(case when cat2= '电子书阅读类'  then A2.cat_cnt_two end) as two_dianzishuyuedulei_cat_cnt_ago,
        max(case when cat2= '电子书阅读类'  then A2.cat_cnt_7d_ago_two end) as two_dianzishuyuedulei_cat_cnt_7d_ago,
        max(case when cat2= '电子书阅读类'  then A2.cat_cnt_1m_ago_two end) as two_dianzishuyuedulei_cat_cnt_1m_ago,
        max(case when cat2= '电子书阅读类'  then A2.cat_cnt_3m_ago_two end) as two_dianzishuyuedulei_cat_cnt_3m_ago,
        max(case when cat2= '电子书阅读类'  then A2.cat_cnt_6m_ago_two end) as two_dianzishuyuedulei_cat_cnt_6m_ago,
        max(case when cat2= '教育辅助类'  then A2.cat_cnt_two end) as two_jiaoyufuzhulei_cat_cnt_ago,
        max(case when cat2= '教育辅助类'  then A2.cat_cnt_7d_ago_two end) as two_jiaoyufuzhulei_cat_cnt_7d_ago,
        max(case when cat2= '教育辅助类'  then A2.cat_cnt_1m_ago_two end) as two_jiaoyufuzhulei_cat_cnt_1m_ago,
        max(case when cat2= '教育辅助类'  then A2.cat_cnt_3m_ago_two end) as two_jiaoyufuzhulei_cat_cnt_3m_ago,
        max(case when cat2= '教育辅助类'  then A2.cat_cnt_6m_ago_two end) as two_jiaoyufuzhulei_cat_cnt_6m_ago,
        max(case when cat2= '教育考试类'  then A2.cat_cnt_two end) as two_jiaoyukaoshilei_cat_cnt_ago,
        max(case when cat2= '教育考试类'  then A2.cat_cnt_7d_ago_two end) as two_jiaoyukaoshilei_cat_cnt_7d_ago,
        max(case when cat2= '教育考试类'  then A2.cat_cnt_1m_ago_two end) as two_jiaoyukaoshilei_cat_cnt_1m_ago,
        max(case when cat2= '教育考试类'  then A2.cat_cnt_3m_ago_two end) as two_jiaoyukaoshilei_cat_cnt_3m_ago,
        max(case when cat2= '教育考试类'  then A2.cat_cnt_6m_ago_two end) as two_jiaoyukaoshilei_cat_cnt_6m_ago,
        max(case when cat2= '租机类'  then A2.cat_cnt_two end) as two_zujilei_cat_cnt_ago,
        max(case when cat2= '租机类'  then A2.cat_cnt_7d_ago_two end) as two_zujilei_cat_cnt_7d_ago,
        max(case when cat2= '租机类'  then A2.cat_cnt_1m_ago_two end) as two_zujilei_cat_cnt_1m_ago,
        max(case when cat2= '租机类'  then A2.cat_cnt_3m_ago_two end) as two_zujilei_cat_cnt_3m_ago,
        max(case when cat2= '租机类'  then A2.cat_cnt_6m_ago_two end) as two_zujilei_cat_cnt_6m_ago
    from ${pdm_risk}.pdm_risk_applist_new_cate_v3_tmp04 A2
    group by uid, ds
    ) B2 on a.uid = B2.uid and a.ds = B2.ds;
-- feature-copilot:node-end ordinal=0
