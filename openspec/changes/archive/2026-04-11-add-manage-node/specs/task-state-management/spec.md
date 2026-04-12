## ADDED Requirements

### Requirement: 节点状态查询
系统 SHALL 提供能力查询当前项目的节点状态列表，包括每个节点的状态值。

#### Scenario: 查询所有节点状态
- **WHEN** 调用 get_node_status() 获取节点列表
- **THEN** 返回所有9个节点的状态（clarify, analysis, detail, init, prototyping, writing, change）

#### Scenario: 查询当前节点
- **WHEN** 调用 get_current_node() 获取当前所在节点
- **THEN** 返回当前节点名称和状态值

### Requirement: 节点状态更新
系统 SHALL 提供能力更新指定节点的状态值。

#### Scenario: 更新节点状态为 DRAFT
- **WHEN** 调用 update_node_status(node_name, "DRAFT")
- **THEN** 指定的节点状态更新为 DRAFT

#### Scenario: 更新节点状态为 CONFIRM
- **WHEN** 调用 update_node_status(node_name, "CONFIRM")
- **THEN** 指定的节点状态更新为 CONFIRM

### Requirement: 节点流转
系统 SHALL 提供能力将当前节点流转到下一个节点。

#### Scenario: 正常流转到下一节点
- **WHEN** 用户确认当前节点产出后调用 transition_to_next_node()
- **THEN** 当前节点状态变为 CONFIRM，下一节点状态变为 DRAFT，current_node 更新为下一节点

#### Scenario: 已经是最后一个节点
- **WHEN** 在结束节点（如 writing）调用 transition_to_next_node()
- **THEN** 返回错误或保持当前状态

### Requirement: 需求变更路由
系统 SHALL 提供能力在需求变更时重走前序节点。

#### Scenario: 需求变更触发重走
- **WHEN** 在某节点（如 prototyping）触发需求变更
- **THEN** 前序所有节点（clarify 到 detail）状态更新为 DRAFT，从第一个 DRAFT 节点开始执行

#### Scenario: 需求变更完成后返回
- **WHEN** 需求变更完成后调用 return_to_trigger_node()
- **THEN** 回到变更触发的节点继续执行