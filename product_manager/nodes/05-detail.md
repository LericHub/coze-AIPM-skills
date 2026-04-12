---
name: 05-detail
description: 详细设计技能。细化业务流程、页面流程、数据点位和埋点方案，使用Mermaid绘制可视化流程图。
---

# 05 - Detail (详细设计)

## 职责
- 细化业务流程，绘制 Mermaid 流程图
- 事件列表细化
- 数据逻辑定义
- 埋点方案细化
- 版本管理规范
- 文件保存规范

---

## 加载指引

### 前序节点产出物

读取 node4 (analysis) 的产出物：
- 从 Memory.json 获取 analysis 的 file 路径
- 调用 manage.read_memory() 获取 node_list
- 读取该文件内容

---

## 🚨 核心原则：文件保存与版本管理（最重要）

**⚠️ 强制要求：Step3 的所有产出物必须立即保存到文件，并严格进行版本管理！**

### 为什么重要？
1. **防丢失**：避免中断后内容丢失
2. **可追溯**：记录每个版本的完整内容
3. **版本对比**：方便用户对比不同版本
4. **流程衔接**：为 Step4 和 Step5 提供稳定的输入源

---

## 输出文件

- 文件名: `detail.md`
- 路径: `./output/V{version}/detail/detail.md`
- 生成规则: 见 [01-router.md](01-router.md) 中的文件生成规则

---

## 完成后

1. 保存产出到文件：`./output/V{version}/detail/detail.md`
2. 调用 manage.update_node_output("detail", "output/V{version}/detail/detail.md")
3. 展示产出摘要
4. 等待用户确认
5. 确认后 → 调用 manage.update_node_status("detail", "CONFIRM")
6. 确认后 → 调用 manage.transition_to_next_node()
7. 确认后 → 调用 manage.persist_memory()
8. 进入下一节点
