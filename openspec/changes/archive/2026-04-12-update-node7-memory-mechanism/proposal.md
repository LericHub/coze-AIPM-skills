## Why

当前 node7 (Writing) 的数据获取逻辑仍然使用"快照"机制，但 `2026-04-12-add-memory-mechanism` change 已经将 Memory 机制实现为：从 Memory.json 的 node_list 获取前序节点的 file 路径，每次从文件读取最新版本。

node7 需要更新为新的 Memory 机制逻辑，确保数据获取与系统设计一致。

## What Changes

1. **更新 Step 1**：从 Memory.json 的 node_list 动态获取 node5 (detail) 和 node6 (prototyping) 的 file 路径
2. **更新 Step 3**：从 node_list 获取 prototyping 的 file 路径，扫描目录获取原型文件列表
3. **更新 Step 4**：根据 file 路径读取 detail 文件，提取 overview 内容
4. **更新 Step 5**：根据 file 路径读取 detail 文件，提取第4部分页面需求
5. **更新 Step 7**：更新 Memory 的描述，反映最终版本文件路径

## Capabilities

### New Capabilities
- 无新增 capability

### Modified Capabilities
- `memory-index`: 更新 node7 的加载指引，与 Memory 机制对齐

## Impact

- 修改文件：`product_manager/nodes/07-writing.md`
- 无新增依赖