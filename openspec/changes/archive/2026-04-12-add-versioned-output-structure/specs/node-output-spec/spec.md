## ADDED Requirements

### Requirement: Node output specification
每个节点必须在节点文件中明确定义输出文件的文件名、路径和生成规则。

#### Scenario: Brainstorm node output
- **WHEN** brainstorm 节点执行完成需要输出文件
- **THEN** 输出文件为 `brainstorm.md`，路径为 `./output/V{version}/brainstorm/brainstorm.md`

#### Scenario: Clarify node output
- **WHEN** clarify 节点执行完成需要输出文件
- **THEN** 输出文件为 `clarify.md`，路径为 `./output/V{version}/clarify/clarify.md`

#### Scenario: Analysis node output
- **WHEN** analysis 节点执行完成需要输出文件
- **THEN** 输出文件为 `analysis.md`，路径为 `./output/V{version}/analysis/analysis.md`

#### Scenario: Detail node output
- **WHEN** detail 节点执行完成需要输出文件
- **THEN** 输出文件为 `detail.md`，路径为 `./output/V{version}/detail/detail.md`

#### Scenario: Prototyping node output
- **WHEN** prototyping 节点执行完成需要输出文件
- **THEN** 输出文件包括：
  - `proto_index.html`：原型索引页面，列出所有原型页面链接
  - `page_{page_name}.html`：各页面原型文件，命名格式为 `page_{页面名}.html`
  - 路径为 `./output/V{version}/prototyping/`

#### Scenario: Writing node output
- **WHEN** writing 节点执行完成需要输出文件
- **THEN** 输出文件包括：
  - `PRD_index.html`：PRD查看器，左侧导航 + 右侧分页内容
  - `overview.html`：需求概述页面，展示项目概览和核心需求
  - 路径为 `./output/V{version}/writing/`

### Requirement: File generation rules
文件生成规则必须在 router 节点文件中统一说明，包含三种场景的定义。

#### Scenario: First-time output
- **WHEN** 节点首次产出内容
- **THEN** 生成新文件到当前版本目录

#### Scenario: User modification in current node
- **WHEN** 用户在当前节点修改内容
- **THEN** 更新源文件，版本号不变

#### Scenario: Requirement change with previous node modification
- **WHEN** 需求变更且前序节点内容需要修改
- **THEN** 生成新文件到新版目录，版本号+1（如 V1.0 → V2.0）