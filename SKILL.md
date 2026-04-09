---
name: product_manager
description: 产品经理全流程工作流 - 模糊需求到标准PRD完整链路
author: Coze PM
version: 1.3.0
triggers:
  - 用户提出产品需求
  - 启动PM工作流程
  - 继续未完成任务
  - 提出需求变更
---

# 产品经理工作流Skill

## 核心能力
✅ 6节点标准流程：需求澄清 → 需求分析 → 详细设计 → 原型制作 → PRD撰写 → 变更分析
✅ 独立变更分析节点 - 增量变更无需整体回退
✅ 三级用户确认机制
✅ 完整状态持久化可追溯
✅ 历史版本永久保留
✅ 上下文快照管理 - 确保节点间信息传递的一致性

---

## 完整工作流

```
flowchart LR
    START[启动] --> CHECK{存在Memory.md?}
    CHECK -->|否| INIT[意图识别 + 方案确认]
    CHECK -->|是| RESTORE[恢复状态]
    
    INIT --> CONFIRM1{用户确认?}
    CONFIRM1 -->|否| END
    CONFIRM1 -->|是| CLARIFY
    
    RESTORE --> CURRENT[定位当前节点 → 输出AIPM头部]
    
    CLARIFY[1.需求澄清] --> CONFIRM2{确认?}
    CONFIRM2 -->|是| ANALYSIS[2.需求分析]
    CONFIRM2 -->|修改| CLARIFY
    CONFIRM2 -->|变更| CHANGE[0.变更分析]
    
    ANALYSIS --> CONFIRM3{确认?}
    CONFIRM3 -->|是| DETAIL[3.详细设计]
    CONFIRM3 -->|修改| ANALYSIS
    CONFIRM3 -->|变更| CHANGE
    
    DETAIL --> CONFIRM4{确认?}
    CONFIRM4 -->|是| PROTOTYPING[4.原型制作]
    CONFIRM4 -->|修改| DETAIL
    CONFIRM4 -->|变更| CHANGE
    
    PROTOTYPING --> CONFIRM5{确认?}
    CONFIRM5 -->|是| WRITING[5.PRD撰写]
    CONFIRM5 -->|修改| PROTOTYPING
    CONFIRM5 -->|变更| CHANGE
    
    WRITING --> DONE[交付完成]
    WRITING -->|变更| CHANGE
    
    CHANGE --> CONFIRM6{确认变更方案?}
    CONFIRM6 -->|是| ROLLBACK[回退到受影响节点]
    CONFIRM6 -->|否| CURRENT
    ROLLBACK --> CURRENT
```

---

## 节点映射表
| 节点 | 顺序 | 子Skill文件 | 确认后流转 |
|------|-------------|-------------|------------|
| CLARIFY | 0 | step1_clarify.md | ANALYSIS |
| ANALYSIS | 1 | step2_analysis.md | DETAIL |
| DETAIL | 2 | step3-detail_design.md | PROTOTYPING |
| PROTOTYPING | 3 | step4_prototyping.md | WRITING |
| WRITING | 4 | step5_prd_writing.md | DONE |
| CHANGE | - | step6_change_analysis.md | 回退到指定节点 |

---

## 执行逻辑

### 0. 节点进入输出规范
**初始化完成，正式进入技能节点执行时，必须首先输出以下固定头部：**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SKILL: AIPM
📍 当前节点: {node_name}
🔄 节点状态: {node_status}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

> 触发时机：
> ✅ 新项目初始化完成后，进入第一个节点前输出
> ✅ 恢复已有任务后，定位到当前节点时输出
> ✅ 节点流转、变更回退后，进入新节点时输出
> ❌ 不在skill刚被调用、还在检查/初始化阶段输出

### 1. 新项目流程
1.  解析用户需求，识别结束节点
2.  输出执行方案等待用户确认
3.  确认后创建目录结构，初始化Memory.md
4.  输出AIPM节点头部信息
5.  进入第一个节点执行

### 2. 节点执行循环
```
WHILE 未到达结束节点:
    调用对应子Skill执行
    输出节点产出
    暂停等待用户反馈
    IF 用户确认:
        标记节点已完成 → 进入下一节点
    ELIF 修改:
        重新执行当前节点
    ELIF 变更:
        调用 step6_change_analysis 变更分析
```

### 3. 变更处理流程
1.  调用变更分析Skill输出完整变更方案
2.  用户确认后回退到最早受影响节点
3.  仅重置受影响节点，保留已确认部分
4.  从回退节点重新执行流程

---

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

---

## 上下文快照管理

### 快照标签机制
在调用技能生成节点产出物时，需要在上下文中写入节点产出物和快照标签，以确保LLM在读取上下文内容时获取到的都是节点最新的输出内容。

逻辑是根据节点最新的快照标签内容作为生成依据，每个节点都有对应的CURRENT_SNAPSHOT_标签：

| 节点 | 快照标签 |
|------|----------|
| CLARIFY | CURRENT_SNAPSHOT_CLARIFY |
| ANALYSIS | CURRENT_SNAPSHOT_ANALYSIS |
| DETAIL | CURRENT_SNAPSHOT_DETAIL |
| WRITING | CURRENT_SNAPSHOT_WRITING |
| CHANGE | CURRENT_SNAPSHOT_CHANGE |

### 快照行为规则
- 每个节点完成时，必须在上下文中写入对应的快照标签
- 后续节点在执行时，优先读取相关的快照标签内容作为上下文输入
- 快照标签内容应包含该节点的关键决策、产出物和重要信息摘要
- 当节点被重新执行时，对应的快照标签会被新的内容覆盖

---

## 版本管理

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
- 索引文件: `protoIndex_V{version}_{date}.html`

---

## 确认机制

| 场景 | 确认等级 | 要求 |
|------|----------|------|
| 执行方案、节点通过、变更执行 | 🔴 强确认 | 必须明确"确认/同意" |
| 修改重跑 | 🟡 弱确认 | 重新询问用户意见,重新生成内容，重新根据节点说明生成新版本文件 |
| 查询、查看历史 | 🟢 无需确认 | 直接执行 |

---

## 项目初始化与验证脚本

### 项目创建脚本
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

---

## 核心工作流程说明

### 6大核心节点
1. **CLARIFY** (step1_clarify.md): 需求澄清，从7个维度深度挖掘需求
2. **ANALYSIS** (step2_analysis.md): 需求分析，构建PRD骨架
3. **DETAIL** (step3-detail_design.md): 详细设计，细化业务流程和数据逻辑
4. **PROTOTYPING** (step4_prototyping.md): 原型制作，生成可视化原型
5. **WRITING** (step5_prd_writing.md): PRD撰写，整合所有产出形成完整文档
6. **CHANGE** (step6_change_analysis.md): 变更分析，处理需求变更

---

## 强制规则
1.  节点输出后必须暂停等待确认
2.  变更必须先分析再执行
3.  所有状态变更先获得用户确认
4.  历史版本永不覆盖
5.  未确认前绝不自动流转

---

## 使用方法
```
# 启动新需求
我需要做一个用户注册功能
只做需求澄清就可以了
执行到详细设计阶段

# 提出变更
我想调整一下登录逻辑
需要增加微信登录选项
```

发送任意消息自动恢复上次任务进度。