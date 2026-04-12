## ADDED Requirements

### Requirement: 上下文快照写入
系统 SHALL 提供能力将节点产出物写入上下文快照标签，供后续节点使用。

#### Scenario: 节点完成后写入快照
- **WHEN** 节点（如 clarify）完成后调用 write_snapshot("clarify", content)
- **THEN** 上下文中的 CURRENT_SNAPSHOT_CLARIFY 标签更新为新的产出内容

#### Scenario: 快照覆盖更新
- **WHEN** 节点重新执行后再次调用 write_snapshot()
- **THEN** 原有快照内容被新内容覆盖

### Requirement: 上下文快照读取
系统 SHALL 提供能力读取指定节点的上下文快照内容。

#### Scenario: 读取已有快照
- **WHEN** 调用 read_snapshot("clarify") 读取需求澄清快照
- **THEN** 返回 CURRENT_SNAPSHOT_CLARIFY 标签中的内容

#### Scenario: 读取不存在的快照
- **WHEN** 调用 read_snapshot("clarify") 但快照尚未生成
- **THEN** 返回空或错误提示

### Requirement: 记忆持久化
系统 SHALL 提供能力将当前项目状态持久化到 Memory.md 文件。

#### Scenario: 项目状态持久化
- **WHEN** 调用 persist_memory() 持久化状态
- **THEN** Memory.md 文件中所有状态字段（node_list, current_node, version 等）更新为最新值

#### Scenario: 启动时恢复状态
- **WHEN** 项目启动时调用 restore_memory() 恢复状态
- **THEN** 读取 Memory.md 文件内容并恢复到内存中的当前状态