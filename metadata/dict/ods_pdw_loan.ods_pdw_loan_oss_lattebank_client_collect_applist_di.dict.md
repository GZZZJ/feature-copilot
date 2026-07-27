## 一、表信息

| 属性 | 值 |
|------|-----|
| 表名称 | ods_pdw_loan_oss_lattebank_client_collect_applist_di |
| 中文名称 | 客户端收集应用列表明细表（爆炸后粒度） |
| 所属层级 | ODS |
| 所属项目 | ods_pdw_loan |

## 二、表描述

### 2.1 业务定义
该表用于存储客户端采集的用户设备已安装应用列表明细数据，属于客户端埋点/设备信息采集场景中的原始明细表。
从表注释"客户端收集applist明细(爆炸后粒度)"可判断，该表是在应用列表采集结果基础上进行"爆炸"展开后的明细数据，即一条客户端采集事件会拆分为多条应用级记录，每条记录对应设备上的一个安装应用。

该表主要服务于风控建模、反欺诈识别、设备画像、客户行为分析等场景。

### 2.2 数据粒度
一行代表某客户在某次客户端采集事件中上报的一个已安装应用明细。

### 2.3 更新频率
每日（表名后缀 _di，按天增量明细分区表）

### 2.4 核心应用场景
1. 反欺诈风控
2. 用户画像构建
3. 贷前审核辅助
4. 设备风险关联分析
5. 模型特征工程

### 2.5 其他
- 表类型：外部表（EXTERNAL TABLE）
- 存储格式：ORC
- 分区字段：ds
- 存储位置：oss://oss-cn-beijing-internal.aliyuncs.com/lattebank-bigdata-dp-ods/dp_ods_pdw_loan.db/ods_pdw_loan_oss_lattebank_client_collect_applist_di/

## 三、字段清单

### 3.1 主体标识与事件关联信息
| 序号 | 英文字段名 | 中文名称 | 数据类型 |
|------|-----------|---------|---------|
| 1 | uid | 客户编号 | string |
| 2 | cjj_id | cjj编号 | string |
| 3 | behavior_id | 用户行为事件id | string |
| 4 | correlation_id | 会话id | string |
| 5 | event | 系统事件 | string |

### 3.2 设备与应用安装信息
| 序号 | 英文字段名 | 中文名称 | 数据类型 |
|------|-----------|---------|---------|
| 1 | os_name | 系统名称 | string |
| 2 | app_package_name | app包名 | string |
| 3 | app_name | app名称 | string |
| 4 | app_install_time | app安装时间 | string |
| 5 | app_scheme | appschema信息 | string |
| 6 | system_app | 是否是系统应用true,false | string |

### 3.3 时间与分区信息
| 序号 | 英文字段名 | 中文名称 | 数据类型 |
|------|-----------|---------|---------|
| 1 | created_at | 创建时间 | string |
| 2 | create_timestamp | 采集时间戳 | bigint |
| 3 | ds | 业务日期分区 | string |
