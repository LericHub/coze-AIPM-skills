# 更新目录结构规范

## Why
当前项目使用相对路径 `./output/` 作为输出目录，不够清晰且不利于用户访问。需要统一使用工作区目录下的标准路径结构，便于用户查找和管理项目文件。

## What Changes
- **BREAKING**: 将主输出目录从 `./output/` 改为 `/AIPM/`
- 采用新的目录结构：`/AIPM/{project_name}_{date}_{order}`
- 所有节点产出物路径都更新为新结构
- 更新 Memory.json 中的路径记录格式

## Impact
- Affected specs: 所有节点输出路径定义
- Affected code: 
  - `product_manager/nodes/02-brainstorm.md` - 目录初始化
  - `product_manager/nodes/03-clarify.md` - 输出路径
  - `product_manager/nodes/04-analysis.md` - 输出路径
  - `product_manager/nodes/05-detail.md` - 输出路径
  - `product_manager/nodes/06-prototyping.md` - 输出路径
  - `product_manager/nodes/07-writing.md` - 输出路径
  - `product_manager/nodes/_manage.md` - Memory.json 结构

## ADDED Requirements

### Requirement: 工作区目录结构
系统 SHALL 使用工作区目录作为项目根目录，所有输出文件都创建在工作区目录下，便于用户访问。

#### Scenario: 项目初始化
- **WHEN** 系统初始化新项目
- **THEN** 在工作区目录下创建 `/AIPM/` 目录结构

### Requirement: 主目录结构规范
系统 SHALL 采用标准的主目录结构：`/AIPM/{project_name}_{date}_{order}`

- `{project_name}`: 项目名称（由用户或系统生成）
- `{date}`: 日期格式 YYYYMMDD
- `{order}`: 序号，用于区分同一天创建的多个同名项目

#### Scenario: 创建新项目目录
- **WHEN** 用户首次创建项目
- **THEN** 系统创建目录结构 `/AIPM/智能客服系统_20260413_01/`

#### Scenario: 同一天创建同名项目
- **WHEN** 用户在同一天再次创建同名项目
- **THEN** 序号递增，创建 `/AIPM/智能客服系统_20260413_02/`

### Requirement: 节点输出路径规范
系统 SHALL 在主目录下创建版本子目录，所有节点产出物存储在对应版本目录下：

```
/AIPM/{project_name}_{date}_{order}/
└── V{version}/
    ├── brainstorm/
    ├── clarify/
    ├── analysis/
    ├── detail/
    ├── prototyping/
    └── writing/
```

#### Scenario: 节点产出物路径
- **WHEN** brainstorm 节点保存产出物
- **THEN** 保存到 `/AIPM/智能客服系统_20260413_01/V1.0/brainstorm/brainstorm.md`

### Requirement: Memory.json 存储位置
系统 SHALL 将 Memory.json 存储在项目根目录下：

```
/AIPM/{project_name}_{date}_{order}/Memory.json
```

#### Scenario: Memory.json 位置
- **WHEN** 系统初始化或恢复状态
- **THEN** 从 `/AIPM/{project_name}_{date}_{order}/Memory.json` 读取状态

## MODIFIED Requirements
无

## REMOVED Requirements
无
