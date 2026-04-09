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
./src/utils/init_project.sh <project_name>
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
./src/utils/validate_project.sh <project_name>
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
./src/utils/increment_version.sh <project_name>
```

此脚本将:
- 读取当前版本号并递增
- 创建新版本的 Markdown 和 HTML 文档
- 更新 version.json 文件中的版本号