# 节点顺序优化与0output文件夹新增 Spec

## Why
1. 当前节点目录顺序展示不够直观，用户难以快速理解执行流程
2. 输出文件分散在版本目录中，用户查找最新产出物不够方便，需要一个统一的入口目录存放最新版本的打包文件

## What Changes
- 优化节点目录展示，在 `nodes/README.md` 和 `SKILL.md` 中增强节点顺序和流程可视化
- 新增 `0output/` 目录作为项目根目录下的统一输出入口
- 在 node5 (detail)、node6 (prototyping)、node7 (writing)、node8 (change) 完成后，将最新版本的产出物打包并复制到 `0output/` 目录
- 统一打包文件命名规范：`{project_name}_V{version}_{node_name}_{YYYYMMDD_HHmm}.zip`
- **BREAKING**: 无破坏性变更，仅新增功能和优化展示

## Impact
- Affected specs: 节点输出流程、路径规范
- Affected code: 
  - `product_manager/nodes/_manage.md` - 新增0output路径接口、打包方法
  - `product_manager/nodes/05-detail.md` - 新增0output目录打包逻辑
  - `product_manager/nodes/06-prototyping.md` - 新增0output目录打包逻辑
  - `product_manager/nodes/07-writing.md` - 新增0output目录打包逻辑
  - `product_manager/nodes/08-change.md` - 新增0output目录打包逻辑
  - `product_manager/nodes/README.md` - 优化节点顺序展示
  - `product_manager/SKILL.md` - 优化流程可视化、新增0output说明

## ADDED Requirements
### Requirement: 节点顺序可视化优化
系统 SHALL 在节点目录文档中增强流程顺序展示，方便用户理解执行路径。

#### Scenario: 用户查看节点目录
- **WHEN** 用户打开 `nodes/README.md`
- **THEN** 清晰看到节点执行顺序、依赖关系、流转逻辑

### Requirement: 0output目录规范
系统 SHALL 在项目根目录下创建 `0output/` 目录，作为统一的产出物入口：
```
/AIPM/{project_name}_{date}_{order}/
├── 0output/               # 新增：统一输出目录，存放最新版本的打包文件
├── V{version}/            # 版本目录
└── Memory.json
```

#### Scenario: 0output目录结构
- **WHEN** 项目初始化
- **THEN** 自动创建 `/AIPM/{project_name}_{date}_{order}/0output/` 目录

### Requirement: 节点产出物自动打包到0output
系统 SHALL 在以下节点完成并用户确认后，自动将最新版本的产出物打包并复制到0output目录：
1. node5 (detail) - 详细设计完成
2. node6 (prototyping) - 原型制作完成
3. node7 (writing) - PRD撰写完成
4. node8 (change) - 变更分析完成

#### Scenario: node5完成后打包
- **WHEN** 用户确认node5产出物
- **THEN** 打包 `/AIPM/{project_name}_{date}_{order}/V{version}/` 目录
- **THEN** 复制到 `/AIPM/{project_name}_{date}_{order}/0output/{project_name}_V{version}_detail_{YYYYMMDD_HHmm}.zip`

#### Scenario: node6完成后打包
- **WHEN** 用户确认node6产出物
- **THEN** 打包 `/AIPM/{project_name}_{date}_{order}/V{version}/` 目录
- **THEN** 复制到 `/AIPM/{project_name}_{date}_{order}/0output/{project_name}_V{version}_prototyping_{YYYYMMDD_HHmm}.zip`

#### Scenario: node7完成后打包
- **WHEN** 用户确认node7产出物
- **THEN** 打包 `/AIPM/{project_name}_{date}_{order}/V{version}/` 目录
- **THEN** 复制到 `/AIPM/{project_name}_{date}_{order}/0output/{project_name}_V{version}_writing_{YYYYMMDD_HHmm}.zip`

#### Scenario: node8完成后打包
- **WHEN** 用户确认node8产出物
- **THEN** 打包 `/AIPM/{project_name}_{date}_{order}/V{version}/` 目录
- **THEN** 复制到 `/AIPM/{project_name}_{date}_{order}/0output/{project_name}_V{version}_change_{YYYYMMDD_HHmm}.zip`

## MODIFIED Requirements
无

## REMOVED Requirements
无
