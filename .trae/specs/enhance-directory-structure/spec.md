# 增强目录结构规范

## Why
当前的目录结构缺少节点顺序信息，用户不便查看；同时缺少一个统一的输出文件夹来存放最新版本的节点产出物。

## What Changes
- 在节点目录中添加顺序前缀，方便用户查看
- 新增 `0output` 文件夹，在 node5、6、7、8 内容生成后，将最新版本的节点产出物打包放置到该文件夹下

## Impact
- Affected specs: 目录结构规范、节点输出路径
- Affected code:
  - `product_manager/nodes/02-brainstorm.md` - 目录初始化
  - `product_manager/nodes/05-detail.md` - 完成后处理
  - `product_manager/nodes/06-prototyping.md` - 完成后处理
  - `product_manager/nodes/07-writing.md` - 完成后处理
  - `product_manager/nodes/08-change.md` - 完成后处理
  - `product_manager/README.md` - 目录结构说明
  - `product_manager/SKILL.md` - 输出文件结构

## ADDED Requirements

### Requirement: 节点目录顺序前缀
系统 SHALL 在所有节点目录名前添加顺序前缀，方便用户查看节点执行顺序。

节点目录命名格式：`{序号}-{节点名称}`

| 序号 | 节点 | 目录名 |
|------|------|--------|
| 01 | router | 01-router |
| 02 | brainstorm | 02-brainstorm |
| 03 | clarify | 03-clarify |
| 04 | analysis | 04-analysis |
| 05 | detail | 05-detail |
| 06 | prototyping | 06-prototyping |
| 07 | writing | 07-writing |
| 08 | change | 08-change |

#### Scenario: 用户查看节点目录
- **WHEN** 用户查看项目目录
- **THEN** 节点按顺序显示，便于理解执行流程

### Requirement: 0output 文件夹
系统 SHALL 在项目根目录下创建 `0output` 文件夹，用于存放最新版本的节点产出物。

目录结构：
```
/AIPM/{project_name}_{date}_{order}/
├── Memory.json
├── 0output/              # 新增：最新版本产出物
└── V{version}/
    ├── 01-router/
    ├── 02-brainstorm/
    ├── 03-clarify/
    ├── 04-analysis/
    ├── 05-detail/
    ├── 06-prototyping/
    ├── 07-writing/
    └── 08-change/
```

#### Scenario: 项目初始化
- **WHEN** 系统初始化新项目
- **THEN** 创建 `0output` 文件夹

### Requirement: 节点产出物自动打包到 0output
系统 SHALL 在以下节点完成后，将最新版本的节点产出物打包复制到 `0output` 文件夹：
- node5 (detail)
- node6 (prototyping)
- node7 (writing)
- node8 (change)

打包内容：该节点及之前所有节点的最新产出物。

#### Scenario: node5 完成后打包
- **WHEN** node5 (detail) 完成并获得用户确认
- **THEN** 将 V{version}/02-brainstorm/ 到 V{version}/05-detail/ 的所有产出物复制到 0output/

#### Scenario: node6 完成后打包
- **WHEN** node6 (prototyping) 完成并获得用户确认
- **THEN** 将 V{version}/02-brainstorm/ 到 V{version}/06-prototyping/ 的所有产出物复制到 0output/

#### Scenario: node7 完成后打包
- **WHEN** node7 (writing) 完成并获得用户确认
- **THEN** 将 V{version}/02-brainstorm/ 到 V{version}/07-writing/ 的所有产出物复制到 0output/

#### Scenario: node8 完成后打包
- **WHEN** node8 (change) 完成并获得用户确认
- **THEN** 将受影响节点的最新产出物复制到 0output/

### Requirement: 0output 文件夹内容组织
系统 SHALL 在 `0output` 文件夹中保持节点顺序前缀，便于用户查看：

```
/AIPM/{project_name}_{date}_{order}/0output/
├── 02-brainstorm/
├── 03-clarify/
├── 04-analysis/
├── 05-detail/
├── 06-prototyping/
└── 07-writing/
```

## MODIFIED Requirements

### Requirement: 目录初始化
系统 SHALL 在初始化项目目录时，创建带有顺序前缀的节点子目录。

原目录结构：
```
./output/V{version}/
├── brainstorm/
├── clarify/
├── analysis/
├── detail/
├── prototyping/
└── writing/
```

新目录结构：
```
/AIPM/{project_name}_{date}_{order}/V{version}/
├── 02-brainstorm/
├── 03-clarify/
├── 04-analysis/
├── 05-detail/
├── 06-prototyping/
└── 07-writing/
```

#### Scenario: 初始化带顺序前缀的目录
- **WHEN** 系统初始化项目目录
- **THEN** 创建带有顺序前缀的节点子目录

## REMOVED Requirements
无
