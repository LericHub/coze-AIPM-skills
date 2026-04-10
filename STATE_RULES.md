---
name: state_and_rules
description: AIPM状态维护与规则管理
author: Coze PM
version: 1.0.0
---

# AIPM 状态维护与规则管理

## 状态管理

### Memory.md 存储结构
```json
{
  "project_name": "",
  "created_at": "",
  "updated_at": "",
  "node_list": [
    {"node_name": "", "order": 0, "is_confirmed": false, "completed_at": null}
  ],
  "current_node": "",
  "current_node_status": "INIT/DRAFT",
  "end_node": "",
  "change_history": [],
  "conversation_log": [],
  "version": 1
}
```

### 状态操作规则
- 每次Skill启动首先读取状态
- 定位到当前节点后输出AIPM头部信息
- 所有状态变更立即持久化
- 对话日志仅追加不修改
- 每次写入前自动备份历史版本

## 上下文快照管理

### 快照标签机制
在调用技能生成节点产出物时，需要在上下文中写入节点产出物和快照标签，以确保LLM在读取上下文内容时获取到的都是节点最新的输出内容。

逻辑是根据节点最新的快照标签内容作为生成依据，每个节点都有对应的CURRENT_SNAPSHOT_标签：

| 节点 | 快照标签 |
|------|----------|
| CLARIFY | CURRENT_SNAPSHOT_CLARIFY |
| ANALYSIS | CURRENT_SNAPSHOT_ANALYSIS |
| DETAIL | CURRENT_SNAPSHOT_DETAIL |
| PROTOTYPING | CURRENT_SNAPSHOT_PROTOTYPING |
| WRITING | CURRENT_SNAPSHOT_WRITING |
| CHANGE | CURRENT_SNAPSHOT_CHANGE |

### 快照行为规则
- 每个节点完成时，必须在上下文中写入对应的快照标签
- 后续节点在执行时，优先读取相关的快照标签内容作为上下文输入
- 快照标签内容应包含该节点的关键决策、产出物和重要信息摘要
- 当节点被重新执行时，对应的快照标签会被新的内容覆盖

## 版本管理与节点输出文件定义

### 文件版本管理
**只有step3、step4、step5需要产出文件**，文件的版本管理逻辑如下：
- 第一次进入节点，节点状态 = `INIT`,生成内容之后需要生成文件，step3产出的版本号为V1.0，后续节点产出延续最新的版本号
- 用户要求修改节点产出，节点状态 = `Draft`，生成内容之后需要生成文件，版本号需要迭代
- 用户确认节点产出后，将最新版本的文件路径发送给用户，此时无需重新生成文件

### 版本递增机制
- 每次节点内容被编辑或更新时，系统会自动生成新版本的文档
- 版本号按顺序递增（V1, V2, V3...）
- 所有格式的文档（MD, HTML）均生成对应版本

### 版本文件命名规范
- Markdown PREPRD: `PREPRD_V{version}_{date}.md`
- 综合PRD HTML: `PRD_V{version}_{date}.html`
- 概览文档: `overview.html`
- B端文档: `web/{页面编号}.html`
- C端文档: `app/{页面编号}.html`
- 交互式PRD查看器: `index.html` (主入口，左图右文布局)
- 索引文件: `protoIndex_V{version}_{date}.html`

### 节点输入输出文件定义

#### 1. 需求澄清节点 (step1_clarify.md)
- **主要职责**: 从7个维度深度挖掘需求背景、目标、边界、用户、场景、竞品、验收标准
- **输入来源**: 
  - 用户初始需求（纯文本对话输入）
- **处理逻辑**: 接收用户提供的初步需求，通过启发式对话引导用户明确需求，从7个维度评估需求完整性，进行深度追问与多轮确认
- **输出路径**: CURRENT_SNAPSHOT_CLARIFY (上下文标签)
- **输出内容** (CURRENT_SNAPSHOT_CLARIFY):
  - 需求背景描述
  - 项目目标清单
  - 范围边界（包含/不包含）
  - 用户角色定义
  - 使用场景描述
  - 竞品分析
  - 验收标准

#### 2. 需求分析节点 (step2_analysis.md)
- **主要职责**: 构建PRD骨架，识别用户角色、页面清单、埋点方案
- **输入来源**: 
  - [CURRENT_SNAPSHOT_CLARIFY] 上下文标签
  - 需求澄清的完整产出物
- **输入内容** (CURRENT_SNAPSHOT_CLARIFY):
  - 需求背景、目标、边界
  - 用户角色、场景、竞品、验收标准
- **处理逻辑**: 读取需求澄清快照内容，生成详细的初步PRD文档，识别用户类型和端口，梳理页面列表和功能，设计埋点方案
- **输出路径**: `/AIPM/{project_name}/draft/V{version}_{date}/PrePRD_V{version}_{date}.md`
- **输出内容** (PrePRD 文件):
  - 项目基本信息
  - 需求背景
  - 项目目标
  - 范围边界
  - 用户角色定义
  - 页面清单（分端口）
  - FullPicture 业务流程及功能说明（分端口、分页面）
  - 埋点方案

#### 3. 详细设计节点 (step3-detail_design.md)
- **主要职责**: 细化业务流程，绘制Mermaid流程图，定义数据逻辑
- **输入来源**: 
  - [CURRENT_SNAPSHOT_ANALYSIS] 上下文标签
  - PrePRD 文件内容
- **输入内容** (CURRENT_SNAPSHOT_ANALYSIS + PrePRD):
  - 完整的 PrePRD 文档
  - 各页面的功能说明
  - 用户角色和业务流程
- **处理逻辑**: 读取需求分析快照，细化事件列表，绘制业务流程图和页面流程图，整理数据逻辑和异常处理，更新埋点方案
- **输出路径**: CURRENT_SNAPSHOT_DETAIL (上下文标签)
- **输出内容** (CURRENT_SNAPSHOT_DETAIL):
  - 各页面的事件列表
  - 业务流程图（Mermaid）
  - 页面流程图（Mermaid）
  - 数据处理逻辑
  - 异常场景处理
  - 更新后的埋点方案

#### 4. 原型制作节点 (step4_prototyping.md)
- **主要职责**: 生成ASCII线框图和HTML原型页面，可视化展示产品设计
- **输入来源**: 
  - [CURRENT_SNAPSHOT_DETAIL] 上下文标签
  - PrePRD 文件（作为补充参考）
- **输入内容** (CURRENT_SNAPSHOT_DETAIL):
  - 各页面的事件列表
  - 页面元素定义
  - 交互流程说明
- **处理逻辑**: 读取详细设计快照，生成ASCII线框图，调用tdesign-component-helper生成HTML原型，整理原型文件结构
- **输出路径**:
  - 主索引文件: `/AIPM/{project_name}/output/V{version}/protoIndex_V{version}_{date}.html`
  - C端原型: `/AIPM/{project_name}/output/V{version}/html/app/`
  - B端原型: `/AIPM/{project_name}/output/V{version}/html/web/`
  - 上下文标签: `CURRENT_SNAPSHOT_PROTOTYPING`
- **输出内容** (CURRENT_SNAPSHOT_PROTOTYPING):
  - HTML 原型文件路径列表
  - C端原型文件目录
  - B端原型文件目录

#### 5. PRD撰写节点 (step5_prd_writing.md)
- **主要职责**: 整合所有产出，形成完整PRD文档
- **输入来源**: 
  - [CURRENT_SNAPSHOT_ANALYSIS] 上下文标签
  - [CURRENT_SNAPSHOT_DETAIL] 上下文标签
  - [CURRENT_SNAPSHOT_PROTOTYPING] 上下文标签
  - PrePRD 文件（从 output/ 读取最新版本）
- **输入内容**:
  - CURRENT_SNAPSHOT_ANALYSIS: 项目背景、目标、用户角色、页面清单
  - CURRENT_SNAPSHOT_DETAIL: 业务流程图、页面流程图、数据逻辑
  - CURRENT_SNAPSHOT_PROTOTYPING: HTML 原型文件路径
  - PrePRD 文件: FullPicture 章节内容
- **处理逻辑**: 读取分析、详细设计和原型快照，生成需求概述页面，转换Markdown为HTML格式，整合HTML原型，生成完整PRD文档
- **输出路径**:
  - 交互式 PRD 查看器: `/AIPM/{project_name}/output/V{version}/index.html` (主入口，左图右文布局)
  - 完整PRD: `/AIPM/{project_name}/output/V{version}/html/PRD_V{version}_{date}.html`
  - 概览文档: `/AIPM/{project_name}/output/V{version}/html/overview.html`
  - C端需求文档: `/AIPM/{project_name}/output/V{version}/doc/app/{page_name}.html`
  - B端需求文档: `/AIPM/{project_name}/output/V{version}/doc/web/{page_name}.html`
  - C端原型: `/AIPM/{project_name}/output/V{version}/app/`
  - B端原型: `/AIPM/{project_name}/output/V{version}/web/`
  - 上下文标签: `CURRENT_SNAPSHOT_WRITING`
- **输出内容** (CURRENT_SNAPSHOT_WRITING):
  - 所有生成的 HTML 文件路径
  - 交互式 PRD 查看器路径
  - 完整 PRD 文档路径

#### 6. 变更分析节点 (step6_change_analysis.md)
- **主要职责**: 独立变更节点，评估变更影响，制定回退策略
- **输入来源**: 
  - [CURRENT_SNAPSHOT_WRITING] 上下文标签
  - 用户变更需求
- **输入内容** (CURRENT_SNAPSHOT_WRITING):
  - 完整的 PRD 产出物
  - 所有页面文档和原型
  - 项目当前状态
- **处理逻辑**: 读取PRD撰写快照，按照详细设计格式输出变更分析，评估变更影响范围，制定变更实施方案
- **输出路径**: CURRENT_SNAPSHOT_CHANGE (上下文标签)
- **输出内容** (CURRENT_SNAPSHOT_CHANGE):
  - 变更影响范围评估
  - 变更实施方案
  - 回退策略

## 确认机制

| 场景 | 确认等级 | 要求 |
|------|----------|------|
| 执行方案、节点通过、变更执行 | 🔴 强确认 | 必须明确"确认/同意" |
| 修改重跑 | 🟡 弱确认 | 重新询问用户意见,重新生成内容，重新根据节点说明生成新版本文件 |
| 查询、查看历史 | 🟢 无需确认 | 直接执行 |

## 强制规则
1.  节点输出后必须暂停等待确认
2.  变更必须先分析再执行
3.  所有状态变更先获得用户确认
4.  历史版本永不覆盖
5.  未确认前绝不自动流转

## 项目脚本说明

### 项目初始化脚本
当用户启动新项目时，系统将自动执行以下脚本创建目录结构：

```
# 执行项目初始化脚本
./scripts/init_project.sh <project_name>
```

此脚本将:
- 创建完整的项目目录结构
- 初始化 Memory.md 文件
- 创建doc、html、index等所有必需的子目录
- 生成必需的占位文件
- 初始化版本号为1

### 项目恢复脚本
当用户恢复现有项目时，系统将执行以下脚本验证目录结构：

```
# 执行项目验证脚本
./scripts/validate_project.sh <project_name>
```

此脚本将:
- 验证项目目录结构完整性
- 检查必需文件是否存在
- 如发现缺失目录或文件，自动创建缺失的组件
- 从现有 Memory.md 文件恢复项目状态

### 版本递增脚本
每当有内容编辑或更新时，执行以下脚本生成新版本：

```
# 递增项目版本并生成新文档
./scripts/increment_version.sh <project_name>
```

此脚本将:
- 读取当前版本号并递增
- 创建新版本的 Markdown 和 HTML 文档
- 更新 version.json 文件中的版本号