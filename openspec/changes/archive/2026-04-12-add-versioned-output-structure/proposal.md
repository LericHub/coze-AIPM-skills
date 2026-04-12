## Why

当前节点结构和输出目录设计存在两个问题：1）init 节点独立存在但逻辑与 router 重叠，可以简化；2）输出目录结构未考虑需求变更场景，版本隔离不完整。需要重构以提升工作流效率和版本追溯能力。

## What Changes

- 移除独立的 init 节点，目录初始化逻辑合并到 brainstorm 节点（第一个需要写文件的节点）
- 节点顺序调整为：router → brainstorm → clarify → analysis → detail → prototyping → writing → change
- 输出目录采用版本隔离结构：每个版本有独立的完整目录，历史版本完整保留
- 每个节点增加输出文件说明，引导 LLM 按规范输出
- 文件生成规则在 router 中统一说明：首次产出 / 当前节点修改 / 需求变更 三种场景

## Capabilities

### New Capabilities

- `node-output-spec`: 定义每个节点的输出文件名、路径和生成规则
- `versioned-directory-structure`: 定义版本隔离的目录结构规范

### Modified Capabilities

- `node-structure`: 调整节点顺序，移除 init 节点

## Impact

- `product_manager/nodes/01-router.md` - 调整节点顺序说明，增加文件生成规则
- `product_manager/nodes/02-brainstorm.md` - 增加输出文件说明，添加目录创建逻辑
- `product_manager/nodes/03-clarify.md` - 增加输出文件说明
- `product_manager/nodes/04-analysis.md` - 增加输出文件说明
- `product_manager/nodes/05-detail.md` - 增加输出文件说明
- `product_manager/nodes/06-init.md` - 删除此文件
- `product_manager/nodes/06-prototyping.md` - 调整序号，增加输出文件说明
- `product_manager/nodes/07-writing.md` - 调整序号，增加输出文件说明
- `product_manager/nodes/08-change.md` - 调整序号
- `product_manager/nodes/README.md` - 更新节点概览表
- `product_manager/nodes/_manage.md` - 更新涉及 init 的引用