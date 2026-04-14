---
name: 06-prototyping
description: 原型设计技能。基于详细设计生成 ASCII 线框图（自动展示），并使用 tdesign-component-helper Skill（如果已安装）或直接基于 TDesign 组件库生成高保真 HTML 原型。
---

# 06 - Prototyping (原型制作)

## 职责
- 生成 ASCII 线框图和 HTML 原型
- Mock 数据生成（欧莱雅兰蔻数据）
- ASCII 线框图生成
- HTML 原型生成（tdesign-component-helper）
- 使用 Design Reference Skill 和 TDesign MCP Skill 确定页面风格和组件
- 实时打印要求
- **禁止后台任务规范**：本节点必须在前台运行，逐个页面生成以便实时展示和用户确认
- 逐个页面生成规范

---

## Skill 集成

### Design Reference Skill (prototyping-design-reference)
- 位置: `.opencode/skills/prototyping-design-reference/`
- 功能: 提供设计系统指南（颜色、字体、组件样式）
- 引用文件: `uber_design.md`

### TDesign MCP Skill (tdesign-mcp-skill)
- 位置: `.opencode/skills/tdesign-mcp-skill/`
- 功能: 基于 mock 数据结构推荐 TDesign 组件
- MCP 配置: `mcp.json` 中的 tdesign-mcp-server

### 工作流程
1. 生成 Mock 数据后
2. 调用 Design Reference Skill 获取设计指南
3. 调用 TDesign MCP Skill 获取组件推荐
4. 合并两个 Skill 的结果，确定最终页面风格和组件

---

## 加载指引

### 前序节点产出物

读取 node5 (detail) 的产出物：
- 从 Memory.json 获取 detail 的 file 路径
- 调用 manage.read_memory() 获取 node_list
- 读取该文件内容

---

## 输出文件

- 文件名: `page_{page_name}.html`
- 路径: `/AIPM/{project_name}_{date}_{order}/V{version}/prototyping/{platform}/`
  - 平台子目录: `app/` (C端页面) / `web/` (B端页面)
  - `page_{page_name}.html`: 各页面原型文件
- 生成规则: 见 [01-router.md](01-router.md) 中的文件生成规则
- **注意**: 必须按平台归属分别存放到 app/ 或 web/ 子目录

---

## 完成后

1. 保存产出到文件：`/AIPM/{project_name}_{date}_{order}/V{version}/prototyping/` 目录（按 app/web 分端存放）
2. 调用 manage.update_node_output("prototyping", "/AIPM/{project_name}_{date}_{order}/V{version}/prototyping/")
3. 展示产出摘要
4. 等待用户确认
5. 确认后 → 调用 manage.package_latest_version_output("{project_name}", "{date}", "{order}", "{version}", "prototyping")
6. 确认后 → 调用 manage.update_node_status("prototyping", "CONFIRM")
7. 确认后 → 调用 manage.transition_to_next_node()
8. 确认后 → 调用 manage.persist_memory()
9. 进入下一节点
