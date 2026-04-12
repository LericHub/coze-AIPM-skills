---
name: state_and_rules
description: AIPM状态维护与规则管理
author: Coze PM
version: 1.0.0
---

# AIPM 状态维护与规则管理

> **注意**：状态管理具体实现已移至 `nodes/_manage.md`，本文件保留确认机制和强制规则。

## 确认机制

| 场景 | 确认等级 | 要求 |
|------|----------|------|
| 执行方案、节点通过、变更执行 | 🔴 强确认 | 必须明确"确认/同意" |
| 修改重跑 | 🟡 弱确认 | 重新询问用户意见，重新生成内容，重新生成新版本文件 |
| 查询、查看历史 | 🟢 无需确认 | 直接执行 |

## 强制规则

1. 节点输出后必须暂停等待确认
2. 变更必须先分析再执行
3. 所有状态变更先获得用户确认
4. 历史版本永不覆盖
5. 未确认前绝不自动流转

## 项目脚本说明

### 项目初始化脚本

```
./scripts/init_project.sh <project_name>
```

- 在 `/AIPM/` 目录下创建项目
- 自动添加日期时间后缀：`{项目名}_{YYYYMMDD}_{HHMMSS}`
- 初始化 Memory.md 文件
- 创建 doc、html、index 等子目录

### 项目恢复脚本

```
./scripts/validate_project.sh <project_name>
```

- 验证项目目录结构完整性
- 从 Memory.md 恢复项目状态

### 版本递增脚本

```
./scripts/increment_version.sh <project_name>
```

- 读取当前版本号并递增
- 创建新版本的 Markdown 和 HTML 文档