## Why

当前项目存在两个问题：
1. **上下文多版本**：节点产出后用户可能修改，重新进入下一节点时，上下文有多个版本，不知道该用哪个
2. **需求变更**：需求变更后前序节点重新走，上下文还是旧内容

解决方案：统一每次都从文件读取最终版本，不依赖上下文。

场景说明：
- node5 完成后产出 final.md，用户修改后重新生成 → 又进入 node6
- 上下文中有 draft_v1, draft_v2 多个版本 → 从 Memory.json 获取最终版本路径，直接读文件
- 需求变更回到前序节点重新走 → 文件是最新的，直接读文件即可

## What Changes

1. **创建 Memory.json** - 项目级别的任务导航索引，记录各节点最终版本的文件路径
2. **更新 _manage.md** - 补充 Memory.json 的读写接口
3. **更新 node7 skill** - 添加加载指引，读取 node5 (detail) 和 node6 (prototyping)
4. **更新其他节点 skill** - 每次都从文件读取前序节点的最终版本

## Capabilities

### New Capabilities

- `memory-index`: 任务导航索引机制，通过 Memory.json 记录项目节点状态和产出物路径，供 LLM 动态读取

### Modified Capabilities

- `memory-persistence`: 原有快照机制将迁移到 Memory.json，保留持久化能力但改变存储格式

## Impact

- 新增文件: `{project_directory}/memory.json`
- 修改文件: `product_manager/nodes/_manage.md`, 各节点 skill 文件
- 依赖: 无新增外部依赖