# Proposal: 重构 AIPM Skill 节点结构

## Summary

将 AIPM Skill 从现有的 "step 文件 + references 目录" 结构重构为清晰的 "节点文件 (nodes/) + 路由器" 架构。

## Motivation

### 当前问题

1. **节点边界模糊**：CLARIFY 节点承担了需求澄清 + 初始化时机判断 + 状态文件创建等多重职责
2. **初始化逻辑分散**：初始化流程定义在独立的 `initialization_flow.md` 中，与 CLARIFY 耦合
3. **全局规范重复**：执行规范在每个 step 文件中重复出现
4. **状态更新分散**：状态更新逻辑分散在各个 step 文件中

### 预期收益

1. **节点职责清晰**：每个节点只做一件事
2. **规范集中管理**：全局执行规范在 router 中定义一次
3. **线性流程可视化**：节点顺序一目了然

### 后续计划

- **manage 节点**将在后续迭代中单独设计和实现
- 当前阶段各节点的状态更新逻辑保留在各节点文件中
- 后续会将状态更新逻辑抽取为统一的 manage 节点

## Changes

### 新节点结构（第一期）

| 序号 | 节点名 | 说明 | 来源 | 状态更新 |
|------|--------|------|------|----------|
| 01 | router | 入口路由器，加载技能配置 | 新增 | 无 |
| 02 | brainstorm | 头脑风暴，创意发散 | 新增 | 各节点内 |
| 03 | clarify | 需求澄清，7维度挖掘 | 从 step1 迁移 | 各节点内 |
| 04 | analysis | 需求分析，PRD骨架 | 从 step2 迁移 | 各节点内 |
| 05 | detail | 详细设计，流程图 | 从 step3 迁移 | 各节点内 |
| 06 | init | 项目初始化，目录创建 | 从 CLARIFY 后提取 | 各节点内 |
| 07 | prototyping | 原型制作 | 从 step4 迁移 | 各节点内 |
| 08 | writing | PRD撰写 | 从 step5 迁移 | 各节点内 |
| 09 | change | 变更分析 | 从 step6 迁移 | 各节点内 |

> **注意**：manage 节点（状态管理中心）将在后续迭代中单独实现

### 执行规范（集中定义在 router）

1. **线性执行**：节点按顺序执行
2. **用户确认**：除 init 外，所有节点完成后需用户确认
3. **状态管理**：各节点内部处理状态更新（待后续抽取为 manage）

### 文件结构变化

**Before:**
```
product_manager/
├── SKILL.md
├── STATE_RULES.md
└── references/
    ├── step1_clarify.md
    ├── step2_analysis.md
    ├── step3-detail_design.md
    ├── step4_prototyping.md
    ├── step5_prd_writing.md
    ├── step6_change_analysis.md
    └── initialization_flow.md  # 分散的初始化逻辑
```

**After:**
```
product_manager/
├── SKILL.md
├── STATE_RULES.md
└── nodes/
    ├── 01-router.md        # 全局规范 + 入口
    ├── 02-brainstorm.md   # 头脑风暴
    ├── 03-clarify.md      # 需求澄清
    ├── 04-analysis.md     # 需求分析
    ├── 05-detail.md       # 详细设计
    ├── 06-init.md         # 项目初始化
    ├── 07-prototyping.md  # 原型制作
    ├── 08-writing.md      # PRD撰写
    └── 09-change.md       # 变更分析
```

## Migration Strategy

1. 创建新的 `nodes/` 目录
2. 按顺序迁移/创建每个节点文件
3. 保留原有的 `references/` 目录作为备份
4. 更新 `SKILL.md` 指向新的节点目录
5. 验证流程完整性后删除备份

## Risks

- 迁移过程中需要保留旧文件作为参考
- 测试需要覆盖所有节点流程
