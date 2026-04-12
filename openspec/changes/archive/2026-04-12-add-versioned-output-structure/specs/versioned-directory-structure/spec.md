## ADDED Requirements

### Requirement: Versioned directory structure
输出目录采用版本隔离结构，每个版本有独立的完整目录，历史版本完整保留。

#### Scenario: Initial version directory
- **WHEN** 首次执行项目，版本为 V1.0
- **THEN** 创建目录 `./output/V1.0/`，包含所有节点子目录

#### Scenario: Version increment on requirement change
- **WHEN** 需求变更触发，版本号需要从 V{n} 递增到 V{n+1}
- **THEN** 创建新目录 `./output/V{n+1}/`，包含所有节点子目录，历史目录保留不变

#### Scenario: Directory structure per version
- **WHEN** 创建版本目录
- **THEN** 版本目录下包含 brainstorm/、clarify/、analysis/、detail/、prototyping/、writing/ 六个子目录

### Requirement: Directory initialization timing
目录初始化在第一个需要写文件的节点（brainstorm）执行时触发。

#### Scenario: First file creation triggers directory init
- **WHEN** brainstorm 节点首次需要创建文件
- **THEN** 先创建完整的版本目录结构，再写入文件

### Requirement: Node subdirectory naming
节点子目录使用节点名称命名。

#### Scenario: Node subdirectory names
- **WHEN** 创建版本目录结构
- **THEN** 子目录命名为 brainstorm、clarify、analysis、detail、prototyping、writing