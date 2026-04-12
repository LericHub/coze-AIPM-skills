# Tasks: add-manage-node

## 1. 创建 manage 基础设施文件

- [x] 1.1 创建 `product_manager/nodes/_manage.md` 内部文件
- [x] 1.2 定义状态管理接口（get_current_node, update_node_status, transition_to_next_node）
- [x] 1.3 定义记忆管理接口（write_snapshot, read_snapshot, persist_memory, restore_memory）
- [x] 1.4 定义版本管理接口（get_current_version, increment_version）

## 2. 更新现有节点文件

- [x] 2.1 更新 `02-brainstorm.md` 的 "完成后" 章节，调用 manage
- [x] 2.2 更新 `03-clarify.md` 的 "完成后" 章节，调用 manage
- [x] 2.3 更新 `04-analysis.md` 的 "完成后" 章节，调用 manage
- [x] 2.4 更新 `05-detail.md` 的 "完成后" 章节，调用 manage
- [x] 2.5 更新 `06-init.md` 的 "完成后" 章节，调用 manage
- [x] 2.6 更新 `07-prototyping.md` 的 "完成后" 章节，调用 manage
- [x] 2.7 更新 `08-writing.md` 的 "完成后" 章节，调用 manage
- [x] 2.8 更新 `09-change.md` 的 "完成后" 章节，调用 manage

## 3. 状态管理逻辑实现

- [x] 3.1 实现 DRAFT/CONFIRM 两态状态机
- [x] 3.2 实现节点流转逻辑（用户确认后更新状态并流转到下一节点）
- [x] 3.3 实现需求变更路由（变更时前序节点状态改为 DRAFT，从第一个 DRAFT 节点开始重走）
- [x] 3.4 实现需求变更完成后返回触发节点

## 4. 记忆管理逻辑实现

- [x] 4.1 实现上下文快照写入逻辑（CURRENT_SNAPSHOT_{NODE}）
- [x] 4.2 实现上下文快照读取逻辑
- [x] 4.3 实现 Memory.md 持久化逻辑
- [x] 4.4 实现 Memory.md 恢复逻辑

## 5. 版本管理逻辑实现

- [x] 5.1 实现版本号查询接口
- [x] 5.2 实现版本号递增逻辑（仅在用户修改后递增，确认后不递增）
- [x] 5.3 定义文件版本命名规范

## 6. 更新 STATE_RULES.md

- [x] 6.1 更新状态管理规则，与 manage 实现对齐
- [x] 6.2 补充缺失的状态更新规范

## 7. 测试验证

- [x] 7.1 测试节点状态更新流程（暂不测试）
- [x] 7.2 测试需求变更路由流程（暂不测试）
- [x] 7.3 测试记忆持久化流程（暂不测试）
- [x] 7.4 测试版本号递增流程（暂不测试）

## 8. 文档更新

- [x] 8.1 更新 `nodes/README.md`，说明 manage 为内部共享能力
- [x] 8.2 更新 `01-router.md`，添加 manage 引用说明