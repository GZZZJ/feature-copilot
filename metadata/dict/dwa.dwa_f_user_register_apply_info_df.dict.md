# dwa_f_user_register_apply_info_df - 用户注册申请信息表

## 表信息
| 属性 | 值 |
|------|-----|
| 数据域 | 经营域 |
| 层级 | DWA |
| 项目 | dwa |
| 创建者 | 何胜 |
| 表类型 | 内部表ALIORC |
| 分区 | ds |
| 生命周期 | 90天 |

## 数据粒度
一行 = uid + ds 的用户注册申请日快照

## 核心字段分类
### 登录行为
- first_login_time_all: 全平台首登(APP/API/H5/MP最小值)
- first_login_platform: 首登平台(app/api/h5/mp/bdmp/alipay_h5/dymp)
- latest_login_time_app/mp: 最近登录时间
- first_login_mp_sub_channel: MP子渠道(weapp/weapp_cash/weapp_zhxloan)

### 申请申完
- first_apply_finish_time_all: 全平台首次申完
- latest_apply_finish_time_all: 全平台最近申完(不含直销)
- first_apply_time_*: 各平台首次申请时间
- first_apply_finish_platform: 首次申完平台

### 进件步骤
- LIVENESS: 人脸识别
- IDENTIFICATION: 身份验证
- BANK_CARD: 绑卡
- COMMON_INFO: 个人信息验证

### 渠道设备
- register_channel_type: 注册渠道(APP/API/H5/MP)
- first_login_level*_channel: 首登渠道归因
- marketing_channel_group_name: 营销渠道分组
- latest_device_brand_original/IDFA/IMEI/OAID: 设备信息
- mobile_city/province: 手机归属地
- telecom_operator_name: 运营商

### 风控经营
- is_direct_sell_user: 是否直销(0/1)
- multi_head_flag: 多头等级(3严重/2中等/1轻微/0其他)
- latest_risk_limit_adjust_apply_reason_code: 最近调额原因
- first_leave_info_time/fake_register_date: 留资信息

## 废弃字段
register_mobile_prefix, disuse, latest_apply_finish_time_direct_sell_app → 固定NULL

## 主要来源
cdmx.cdmx_dim_user_df + 进件步骤时间线 + 设备维表 + 手机归属地 + 留资 + 多头 + 注册记录
