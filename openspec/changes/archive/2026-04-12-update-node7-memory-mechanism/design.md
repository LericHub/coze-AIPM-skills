## Context

node7 (Writing) 当前使用"快照"机制读取前序节点产出，但 Memory 机制已实现为：
- 每次调用 `manage.read_memory()` 从文件读取
- 从 `node_list` 获取前序节点的 `file` 路径
- 根据路径动态读取实际文件内容

需要更新 node7 与新机制对齐。

## Goals / Non-Goals

**Goals:**
- 更新 node7 的数据获取逻辑，使用 Memory 机制
- 保持 node7 的职责边界不变
- 确保数据来源清晰可追溯

**Non-Goals:**
- 不修改其他节点的逻辑
- 不改变文件输出结构

## Decisions

### D1: 数据获取流程
**决定**：node7 通过 `manage.read_memory()` 获取 node_list，从 file 字段读取路径，再读取实际文件

**理由**：与 Memory 机制一致，每次从文件读取最新版本

### D2: 前序节点定位
**决定**：
- detail 产出物：name="detail" 的 file 路径
- prototyping 产出物：name="prototyping" 的 file 路径

**理由**：node_list 中每个节点有唯一 name 字段，可精确定位

### D3: 内容提取规则
**决定**：
- overview 内容：从 detail 文件的概述章节提取
- 页面文档：从 detail 文件的第4部分提取

**理由**：与原有逻辑一致，只是数据来源从快照改为文件

## Risks / Trade-offs

| Risk | Mitigation |
|------|------------|
| file 路径错误导致读取失败 | 基于 Memory.json 的 project.directory 动态拼接路径 |
| 文件不存在 | 先检查文件是否存在，不存在时记录错误但不阻塞 |