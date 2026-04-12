## Memory.json Specification

### Requirement: 任务导航索引
系统 SHALL 提供 Memory.json 文件，记录项目节点状态和产出物路径，供 LLM 动态读取。

#### Scenario: 项目初始化
- **WHEN** 新项目启动时
- **THEN** 创建空的 Memory.json 框架，包含 project, current_node, node_list 字段

#### Scenario: 节点产出后更新
- **WHEN** 节点完成并产出文件后
- **THEN** 更新 Memory.json 中对应节点的 status 和 file 字段

#### Scenario: 读取导航
- **WHEN** LLM 执行当前节点需要引用前序节点产出物时
- **THEN** 从 Memory.json 查询前序节点的 file 路径并读取

### Requirement: 动态加载指引
各节点 skill SHALL 在"加载指引"章节明确说明需要读取哪些前序产出物。

#### Scenario: writing 节点加载 detail
- **WHEN** node7 (writing) 需要生成 overview
- **THEN** 从 Memory.json 查询 node5 (detail) 的 file 并读取全文

#### Scenario: 跳过大型文件
- **WHEN** 节点 skill 判断前序产出物过大（如 HTML 原型）
- **THEN** 在加载指引中说明"跳过"或"仅在用户明确要求时加载"