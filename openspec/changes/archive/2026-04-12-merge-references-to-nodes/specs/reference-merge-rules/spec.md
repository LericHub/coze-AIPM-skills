## ADDED Requirements

### Requirement: Reference file merge rules
定义 references 文件到 nodes 的合并规则，确保能力边界清晰、无冗余。

#### Scenario: Step files merge
- **WHEN** 需要合并 step1_clarify.md ~ step6_change_analysis.md
- **THEN** 按以下映射关系合并到对应节点文件：
  - step1_clarify.md → 03-clarify.md
  - step2_analysis.md → 04-analysis.md
  - step3-detail_design.md → 05-detail.md
  - step4_prototyping.md → 06-prototyping.md
  - step5_prd_writing.md → 07-writing.md
  - step6_change_analysis.md → 08-change.md

#### Scenario: Specification files merge
- **WHEN** 需要合并规范文件
- **THEN** 按以下映射关系合并：
  - flow_enforcement_lock.md → 01-router.md
  - strict_execution_protocol.md → 01-router.md
  - initialization_flow.md → 01-router.md
  - directory_creation_guide.md → 02-brainstorm.md
  - node_transition_guide.md → _manage.md
  - 状态管理逻辑整理.md → _manage.md
  - file_management_spec.md → 05-detail.md（调整后符合spec结构）
  - path_config_guide.md → 分散到相关节点

#### Scenario: Backup directory deletion
- **WHEN** 执行合并操作
- **THEN** 删除 product_manager/references/backup/ 目录

#### Scenario: Template files retention
- **WHEN** 执行合并操作
- **THEN** 保留以下模板文件：
  - loreal_mock_database.md（被Node6引用）
  - prd_viewer_template.html
  - prd_template.html
  - overview_template.html
  - page_doc_template.html

#### Scenario: Manage capability independence
- **WHEN** 执行合并操作
- **THEN** _manage.md 保持独立，只提供接口抽象：
  - get_current_version()
  - increment_version()
  - update_node_status()
  - transition_to_next_node()
  - get_current_node()
  - get_node_status()
  - read_memory()
  - write_memory()
  - update_node_output()
  - persist_memory()
  - restore_memory()
  - get_project_directory()
