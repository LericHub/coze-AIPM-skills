# Tasks: AIPM Skill 节点重构（第一期）

## Implementation Tasks

- [x] 创建 `product_manager/nodes/` 目录结构

### Node Creation Tasks

- [x] 创建 `01-router.md` - 入口路由器
  - 定义全局执行规范
  - 创建节点概览表
  - 添加节点文件引用

- [x] 创建 `02-brainstorm.md` - 头脑风暴
  - 定义头脑风暴规则
  - 定义产出格式
  - 添加完成后流程说明

- [x] 创建 `03-clarify.md` - 需求澄清
  - 从 `step1_clarify.md` 迁移内容
  - 移除初始化相关逻辑
  - 添加完成后流程说明

- [x] 创建 `04-analysis.md` - 需求分析
  - 从 `step2_analysis.md` 迁移内容
  - 保留编号生成规则
  - 添加完成后流程说明

- [x] 创建 `05-detail.md` - 详细设计
  - 从 `step3-detail_design.md` 迁移内容
  - 保留文件保存规范
  - 添加完成后流程说明

- [x] 创建 `06-init.md` - 项目初始化
  - 从 `initialization_flow.md` 提取内容
  - 定义目录创建逻辑
  - 定义 Memory.md 初始化
  - 添加完成后流程说明

- [x] 创建 `07-prototyping.md` - 原型制作
  - 从 `step4_prototyping.md` 迁移内容
  - 保留实时打印规范
  - 添加完成后流程说明

- [x] 创建 `08-writing.md` - PRD撰写
  - 从 `step5_prd_writing.md` 迁移内容
  - 保留 Markdown 转 HTML 规则
  - 添加完成后流程说明

- [x] 创建 `09-change.md` - 变更分析
  - 从 `step6_change_analysis.md` 迁移内容
  - 保留变更分析报告格式
  - 添加完成后流程说明

> **注意**：manage 节点将在后续迭代中设计和实现

### Documentation Tasks

- [x] 更新 `SKILL.md`
  - 更新节点文件引用路径
  - 添加新架构说明

- [x] 更新或创建 `nodes/README.md`
  - 节点目录说明
  - 文件命名规范

### Backup & Cleanup Tasks

- [x] 备份旧文件到 `references/backup/`

- [x] 验证流程完整性后删除备份

### Testing Tasks

- [x] 测试 router 节点加载

- [x] 测试 brainstorm 节点执行

- [x] 测试 clarify 节点执行

- [x] 测试 analysis 节点执行

- [x] 测试 detail 节点执行

- [x] 测试 init 节点执行

- [x] 测试 prototyping 节点执行

- [x] 测试 writing 节点执行

- [x] 测试 change 节点执行

- [x] 测试各节点内状态更新逻辑

## Migration Details

### 03-clarify.md Migration

从 `references/step1_clarify.md` 迁移时：
```
保留：
- 7 维度评估框架（第 24-33 行）
- 深度追问规则（第 39-143 行）
- 启发式追问策略
- 禁止/允许询问的问题列表

移除：
- 初始化相关逻辑（已移至 init 节点）

新增：
- "完成后" 章节（状态更新在各节点内处理）
```

### 06-init.md Migration

从 `references/initialization_flow.md` 迁移时：
```
保留：
- 初始化时机规则
- 目录创建规范
- Memory.md 初始化模板

新增：
- "完成后" 章节（状态更新在各节点内处理）
```

## Validation Checklist

- [x] 所有节点文件已创建（01-09）
- [x] 节点编号正确
- [x] 每个节点包含 "完成后" 章节
- [x] router 包含全局执行规范
- [x] SKILL.md 已更新
- [x] 旧文件已备份
- [x] 流程测试通过

## 后续迭代：manage 节点

manage 节点将在后续迭代中单独设计和实现，包含：
- 统一的调用时机表
- 统一的执行逻辑
- 统一的异常处理规范
- 统一的快照写入规则
