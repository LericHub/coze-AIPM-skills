---
name: 08-change
description: 变更分析技能。针对已进入开发阶段的需求进行变更影响评估，输出页面/事件粒度的增量变更方案，避免整体回退。适用于任何阶段的需求变更请求。
---

# 08 - Change (变更分析)

## 职责
- 评估变更影响，制定回退策略
- 变更识别维度
- 影响范围评估
- 增量变更模式
- 变更分析报告格式

---

## 完成后

1. 展示产出摘要
2. 等待用户确认
3. 确认后 → 调用 manage.update_node_status("change", "CONFIRM")
4. 确认后 → 调用 manage.return_to_trigger_node()
5. 确认后 → 调用 manage.persist_memory()
6. 回退到受影响的主流程节点
