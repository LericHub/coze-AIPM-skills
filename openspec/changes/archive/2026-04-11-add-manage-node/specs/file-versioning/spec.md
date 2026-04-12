## ADDED Requirements

### Requirement: 当前版本号查询
系统 SHALL 提供能力查询当前项目的版本号。

#### Scenario: 查询项目当前版本
- **WHEN** 调用 get_current_version()
- **THEN** 返回当前版本号（如 "V1.0" 或 1）

### Requirement: 版本号递增
系统 SHALL 提供能力根据用户修改更新版本号。

#### Scenario: 用户修改后递增版本
- **WHEN** 用户提出修改意见，节点重新生成产出后调用 increment_version()
- **THEN** 版本号递增（如 V1.0 → V1.1）

#### Scenario: 用户确认不递增版本
- **WHEN** 用户确认当前产出后调用 increment_version()
- **THEN** 版本号保持不变

### Requirement: 文件版本关联
系统 SHALL 提供能力管理产出文件与版本号的关联。

#### Scenario: 新版本文件生成
- **WHEN** 节点生成新版本产出时
- **THEN** 文件命名包含当前版本号（如 DetailDesign_V1.1_20240409.md）

#### Scenario: 历史版本保留
- **WHEN** 新版本文件生成后
- **THEN** 历史版本文件保留不覆盖