## Context

当前 product_manager 目录结构：
- `nodes/` — 8个精简节点文件 + _manage.md
- `references/` — 12+详细实现指南 + 备份 + 模板

需要解决的问题：
1. references 和 nodes 内容重叠
2. 规范文件与 _manage 逻辑重复
3. 目录结构不符合 add-versioned-output-structure spec

## Goals / Non-Goals

**Goals:**
- 合并 references 内容到 nodes，确保能力边界清晰
- 删除冗余的 backup/ 目录
- 调整目录结构符合 spec 设计
- 保留模板文件（被 nodes 引用）

**Non-Goals:**
- 不修改节点执行逻辑
- 不修改 _manage 的接口定义
- 不改变主流程顺序

## Decisions

### Decision 1: 合并规则

| references 文件 | 合并到 | 理由 |
|----------------|--------|------|
| step1_clarify.md | 03-clarify.md | 深度追问规则补充 |
| step2_analysis.md | 04-analysis.md | 编号规则补充 |
| step3-detail_design.md | 05-detail.md | 文件保存流程 |
| step4_prototyping.md | 06-prototyping.md | Mock数据流程 |
| step5_prd_writing.md | 07-writing.md | 打包流程 |
| step6_change_analysis.md | 08-change.md | 变更分析 |
| flow_enforcement_lock.md | 01-router.md | 流程锁定协议 |
| strict_execution_protocol.md | 01-router.md | 执行协议 |
| initialization_flow.md | 01-router.md | 初始化流程 |
| directory_creation_guide.md | 02-brainstorm.md | 目录创建规范 |
| node_transition_guide.md | _manage.md | 流转逻辑 |
| 状态管理逻辑整理.md | _manage.md | 状态管理 |
| file_management_spec.md | 05-detail.md | 调整后符合spec结构 |
| path_config_guide.md | 分散到相关节点 | 路径规范 |

### Decision 2: 目录结构调整

符合 add-versioned-output-structure spec 设计：

```
output/V{version}/
├── brainstorm/brainstorm.md
├── clarify/clarify.md
├── analysis/analysis.md
├── detail/detail.md
├── prototyping/
│   ├── proto_index.html
│   └── page_*.html
└── writing/
    ├── PRD_index.html
    └── overview.html
```

### Decision 3: _manage 保持独立

_manage.md 只提供接口抽象：
- get_current_version()
- increment_version()
- update_node_status()
- transition_to_next_node()

具体文件保存由各节点按 design.md 中的规则执行。

### Decision 4: 保留文件

| 文件 | 保留位置 |
|------|---------|
| loreal_mock_database.md | references/ (被Node6引用) |
| *.html 模板 | references/ (被各节点引用) |

## Risks / Trade-offs

### Risk 1: 节点文件行数过多
- **Mitigation**: 保持职责清晰，内容按逻辑分组

### Risk 2: LLM 可能不按指定结构保存
- **Mitigation**: 在对应节点中明确输出路径

### Risk 3: 合并后逻辑冗余
- **Mitigation**: 对比检查，确保不重复定义
