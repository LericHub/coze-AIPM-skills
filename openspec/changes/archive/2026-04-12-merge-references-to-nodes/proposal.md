## Why

当前 product_manager 存在内容分散问题：references/ 目录包含详细实现指南（12+ 文件），nodes/ 目录包含精简的技能定义（8 文件）。两者内容有重叠，导致：
1. 能力边界不清晰 — references 和 nodes 职责有交叉
2. 维护成本高 — 同一份逻辑在两处定义
3. 逻辑冗余 — 部分规范文件与 _manage 重复

需要合并references内容到nodes，确保每个skill能力边界清晰、逻辑完整、无冗余。

## What Changes

- 删除 `product_manager/references/backup/` 目录（历史备份）
- 将 step1_clarify.md ~ step6_change_analysis.md 合并到对应 nodes 文件
- 将规范文件（flow_enforcement_lock.md, strict_execution_protocol.md 等）合并到 nodes 或删除
- 保留 references/ 中的模板文件（*.html）
- 调整目录结构符合 spec 设计（按节点名划分，非按文件类型）
- _manage.md 保持独立，供各节点引用

## Capabilities

### New Capabilities
- `node-output-structure`: 定义符合spec设计的目录结构规范
- `reference-merge-rules`: 定义references到nodes的合并规则

### Modified Capabilities
- `product-manager-nodes`: 合并references内容到各节点文件
- `file-management-spec`: 调整文件保存结构，合并到05-detail.md

## Impact

- `product_manager/nodes/` — 所有节点文件更新
- `product_manager/nodes/_manage.md` — 补充流转逻辑
- `product_manager/references/` — 删除backup/，保留模板
