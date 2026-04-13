## Why

当前 BRAINSTORM 节点仅产出"功能骨架"（HOW），缺少对"背景/痛点"（WHY）和"业务目标"（WHAT）的引导和记录。这导致后续节点缺少业务锚点，LLM 在功能策划时缺乏深度思考基础。

通过在 BRAINSTORM 阶段增加 WHY/WHAT 引导提问，并要求 LLM 归纳扩展用户回答，可以强制 LLM 从业务角度思考，提高整体策划质量。

## What Changes

- **修改 BRAINSTORM 节点** (`product_manager/nodes/02-brainstorm.md`)
  - 增加背景/痛点引导提问
  - 增加业务目标引导提问
  - 增加 LLM 归纳扩展机制
  - 调整输出文件结构（引用格式展示 WHY/WHAT）

- **修改 CLARIFY 节点** (`product_manager/nodes/03-clarify.md`)
  - 维度 1-2 改为显示 BRAINSTORM 已确认的内容
  - 标注引用来源，不再重复提问

## Capabilities

### New Capabilities

- `brainstorm-why-what`: BRAINSTORM 节点的 WHY/WHAT 引导能力
  - 引导提问模块（背景/痛点 + 业务目标）
  - 用户回答收集模块
  - LLM 归纳扩展模块
  - 引用格式输出模块

## Impact

- 修改文件：`product_manager/nodes/02-brainstorm.md`
- 修改文件：`product_manager/nodes/03-clarify.md`
- 产出文件：`output/V{version}/brainstorm/brainstorm.md` 结构变更
