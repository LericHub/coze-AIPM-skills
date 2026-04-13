## Context

当前产品经理工作流输出结构：
- `prototyping/` 为平铺结构，所有原型文件直接存放
- `writing/` 需要 assets 但未自动创建
- 节点完成后无打包机制

## Goals / Non-Goals

**Goals:**
1. prototyping 输出按 app/web 分端存放
2. writing 初始化时创建 assets 并复制 logo.png
3. 节点完成后自动打包输出目录为 zip 文件
4. 明确 prototyping 必须前台运行的约束

**Non-Goals:**
- 不修改原型文件命名规则
- 不调整 node1-5 的输出逻辑
- 不修改项目管理器的核心逻辑

## Decisions

### D1: prototyping 输出结构调整

| 方案 | 优点 | 缺点 |
|------|------|------|
| A. 按端分子目录 | 清晰、便于查找 | 需要调整 node7 路径映射 |
| B. 增加 platform 字段 | 不改变目录结构 | 文件多时仍杂 |

选择 **A**：按 app/ web/ 子目录存放，符合用户明确要求。

### D2: 打包触发时机

| 节点 | 触发时机 | 打包内容 |
|------|----------|----------|
| node6 (prototyping) | 初次输出 + 确认后 | `./output/V{version}/` |
| node7 (writing) | 初次输出 + 确认后 | `./output/V{version}/` |
| node8 (change) | 确认后 | `./output/V{version}/` |

### D3: logo 资源处理

- 从 `/Users/bytealiez/Documents/Code/aipm-skill/assets/logo.png` 复制到 `./output/V{version}/writing/assets/`
- 文件重命名为 `logo.png`（PRD viewer 模板中使用 `assets/image.png`，但文件名以 logo.png 为源）

## Risks / Trade-offs

- [Risk] node7 路径映射需要更新 → 调整 Step 3 的 prototypePath 格式
- [Risk] 现有项目需要迁移旧结构 → 手动迁移，非自动化