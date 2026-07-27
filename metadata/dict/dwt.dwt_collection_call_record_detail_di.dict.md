# dwt_collection_call_record_detail_di - 催收外呼记录宽表

## 表信息
| 属性 | 值 |
|------|-----|
| 数据域 | 贷后域 |
| 层级 | DWT |
| 项目 | dwt |
| 创建者 | 李冰清 |
| 表类型 | 外部表ORC |
| 分区 | ds |
| 更新 | 每日 (回溯近7天) |

## 数据粒度
一行 = 一次催收外呼记录(call_id + call_date + source_system)

## 核心字段
- call_id: 电话流水ID
- call_date: 拨打日期
- call_mode: 呼叫模式(0-人工/1-AI)
- call_time/answer_time/end_time: 拨打/应答/结束时间
- ring_duration/talk_duration: 振铃/通话时长(秒)
- ring_result: 振铃结果
- is_valid_contact: 是否联络到人(1/0)
- uid/cust_no: 用户/客户标识
- called_phone_sha256: 被叫号码加密
- called_phone_province/city: 被叫归属地
- called_phone_social_relations: 社会关系(本人/朋友/家人等)
- is_assign: 是否经办在库案件
- is_new_assign: 是否经办当日新分案件
- queue_name/strategy_code/strategy_name: 队列/策略
- operator_id/name/employee_number: 经办信息
- followup_record_time/phone_code/action_code: 催记信息
- followup_promise_repay_amount: 承诺还款金额
- record_file_url: 录音文件
- source_system: ares系统(人工)/智催系统(AI)

## 来源系统
- ares系统: 人工外呼 → cdmx_fct_collection_manual_call_record_df
- 智催系统: AI外呼 → cdmx_fct_ai_call_collectioncore_df (filter: supplier_call_status='外呼完成')

## 关联上游
- 分案结果/日期维表/客户宽表/手机归属地/经办维表/催记记录/用户维表
