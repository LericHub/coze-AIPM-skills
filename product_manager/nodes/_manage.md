---
name: _manage
description: 内部共享能力 - 状态管理、记忆持久化、版本管理
---

# _manage - 内部共享能力

> **注意**：此文件为内部基础设施，供其他节点调用，不作为独立节点执行。

---

## 概述

manage 提供以下共享能力：
1. 状态管理 - 节点状态机、流转逻辑、需求变更路由
2. 记忆管理 - Memory.json 读写、节点产出物路径管理（每次从文件读取）
3. 版本管理 - 版本号查询和递增

---

## 1. 状态管理

### 1.1 节点状态

| 状态 | 说明 |
|------|------|
| `DRAFT` | 默认状态、产出后、用户修改后 |
| `CONFIRM` | 用户确认产出后 |

### 1.2 接口

#### get_current_node()
返回当前所在节点名称。

#### get_node_status(node_name)
返回指定节点的状态。

#### update_node_status(node_name, status)
更新指定节点状态为 DRAFT 或 CONFIRM。

#### transition_to_next_node()
用户确认后，流转到下一节点：
1. 当前节点状态改为 CONFIRM
2. 下一节点状态改为 DRAFT
3. current_node 更新为下一节点

### 1.3 需求变更路由

当用户在某节点触发需求变更时：
1. 前序所有节点状态改为 DRAFT
2. 从第一个 DRAFT 节点开始重走
3. 完成后回到变更触发的节点

---

## 2. 记忆管理

### 2.1 Memory.json

Memory.json 存储在项目根目录，作为项目的唯一事实来源。

每次从文件读取，不依赖上下文（解决上下文多版本和需求变更问题）。

### 2.2 接口

#### get_project_directory()
返回项目目录名称（如 `xxx_20250412`）。

#### read_memory()
读取 Memory.json 文件，返回 JSON 对象。

Memory.json 结构：
```json
{
  "project": {
    "name": "项目名称",
    "version": "V1.0",
    "directory": "项目名_YYYYMMDD_HHMMSS"
  },
  "current_node": "detail",
  "node_list": [
    {"name": "router", "status": "CONFIRM"},
    {"name": "brainstorm", "status": "CONFIRM"},
    {"name": "clarify", "status": "CONFIRM"},
    {"name": "detail", "status": "DRAFT", "file": "output/V1.0/detail/detail.md"},
    {"name": "prototyping", "status": "PENDING"},
    {"name": "writing", "status": "PENDING"},
    {"name": "change", "status": "PENDING"}
  ]
}
```

#### write_memory(data)
将 data 写入 Memory.json 文件。

#### update_node_output(node_name, file_path)
节点完成后，更新 node_list 中对应节点的 file 字段为产出物路径。

#### persist_memory()
将当前状态持久化到 Memory.json。

#### restore_memory()
从 Memory.json 恢复状态到内存。

---

## 3. 版本管理

### 3.1 版本号格式

项目版本：`V{major}.{minor}`（如 V1.0, V1.1）

### 3.2 接口

#### get_current_version()
返回当前版本号。

#### increment_version()
版本号递增规则：
- 用户修改后：递增 minor（如 V1.0 → V1.1）
- 用户确认后：不递增

---

## 4. 节点调用规范

各节点在 "完成后" 章节应调用 manage：

```markdown
## 完成后
1. 展示产出摘要
2. 等待用户确认
3. 确认后 → 调用 manage.update_node_status("当前节点", "CONFIRM")
4. 确认后 → 调用 manage.transition_to_next_node()
5. 确认后 → 调用 manage.persist_memory()
6. 进入下一节点
```

### 4.1 产出后更新 Memory.json

节点产出文件后，应更新 Memory.json：

```markdown
## 完成后
1. 保存产出到文件（如 output/V1.0/detail/detail.md）
2. 调用 manage.update_node_output("detail", "output/V1.0/detail/detail.md")
3. ... 继续用户确认流程
```

---

## 5. Memory.json 结构

```json
{
  "project": {
    "name": "项目名称",
    "version": "V1.0",
    "directory": "项目名_YYYYMMDD_HHMMSS"
  },
  "current_node": "detail",
  "node_list": [
    {"name": "router", "status": "CONFIRM"},
    {"name": "brainstorm", "status": "CONFIRM"},
    {"name": "clarify", "status": "CONFIRM"},
    {"name": "detail", "status": "DRAFT", "file": "output/V1.0/detail/detail.md"},
    {"name": "prototyping", "status": "PENDING"},
    {"name": "writing", "status": "PENDING"},
    {"name": "change", "status": "PENDING"}
  ]
}
```

---

## 6. 异常处理

- 节点状态不一致时，以 Memory.md 为准
- 快照不存在时，返回空并记录日志
- 版本号格式错误时，默认 V1.0