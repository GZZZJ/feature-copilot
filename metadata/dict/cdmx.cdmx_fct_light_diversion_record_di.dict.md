# cdmx_fct_light_diversion_record_di - 轻资产导流记录事实表

## 表信息
| 属性 | 值 |
|------|-----|
| 所属层级 | DWD |
| 项目 | cdmx |
| 创建者 | dataphin_su |
| 表类型 | 外部表 (ORC) |
| 分区字段 | ds |
| 生命周期 | 3600天 |
| 更新频率 | 每日00:01 |

## 数据粒度
一行 = 一个用户在某次轻资产导流流水(light_diversion_sn)下，对应资方处理的一条授信结果记录

## 核心字段
| 字段 | 类型 | 说明 |
|------|------|------|
| uid | string | 用户编号 |
| light_diversion_sn | string | 轻资产导流流水号 |
| fund_code | string | 资方代码 |
| sort_strategy | string | 排序策略(来自业务日志JSON) |
| light_diversion_scene | string | 轻资产导流场景 |
| light_credit_status | string | 轻资产授信状态 |
| light_credit_limit | decimal | 轻资产授信额度(元, 上游/100) |
| fund_annual_ir | decimal | 资方年化利率(百分制) |
| fail_reason | string | 失败原因 |
| fund_credit_time | timestamp | 资方授信时间 |

## 枚举值
### light_diversion_scene
| 编码 | 名称 |
|-----|------|
| LOAN_BEFORE | 贷前 |
| LOAN_LIGHT_PRELOAN | 轻资产预借款 |
| LOAN_LIGHT_HEAVY_REJECTED | 贷中拒绝 |
| LOAN_BLOAN_LIGHT_HEAVY_LENDFIALEDEFORE | 贷中放款失败 |
| LIGHT_RAISE_LIMIT | 轻资产提额 |
| LIGHT_AUTO_APPLY | 轻资产自动送审 |

### light_credit_status
| 编码 | 名称 |
|-----|------|
| PROCESSING | 处理中 |
| FAILURE | 失败 |
| SUCCESS | 成功 |

## 核心加工逻辑
- 临时表承载清洗、映射与字段补全
- 左关联业务日志表解析JSON获取策略与资方代码
- 按ds分区覆盖写入
