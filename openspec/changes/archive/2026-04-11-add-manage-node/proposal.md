## Why

当前 product_manager 的节点产出后状态更新逻辑分散在各节点 "完成后" 章节中（如"见各节点内状态更新规范"），但实际规范并未抽取，导致：
1. 状态更新时机和规则不统一
2. 记忆持久化逻辑散落各处
3. 版本号管理缺乏统一入口

需要创建一个集中式的 manage 节点基础设施，统一处理这些高频操作。

## What Changes

- 创建 `product_manager/nodes/_manage.md` 内部文件，定义状态更新、记忆持久化、版本号管理的统一逻辑
- 更新所有节点的 "完成后" 章节，改为调用 manage 提供的功能
- Memory.md 结构保持不变，manage 负责读写操作
- manage 节点不作为线性节点（第10号），而是作为共享能力被各节点引用

## Capabilities

### New Capabilities

- `task-state-management`: 节点状态机管理（DRAFT/CONFIRM），包括状态读取、更新、流转逻辑
- `memory-persistence`: 上下文快照的写入和读取，记忆持久化逻辑
- `file-versioning`: 文件版本号管理，项目级和节点级版本控制

## Impact

- 修改 `product_manager/nodes/` 下的所有节点文件（02-09）的 "完成后" 章节
- 更新 STATE_RULES.md 中的状态管理规则，与 manage 实现对齐
- 依赖 Memory.md 的读写逻辑