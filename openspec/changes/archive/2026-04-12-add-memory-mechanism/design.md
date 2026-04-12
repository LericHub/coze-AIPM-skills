## Context

当前 product_manager 工作流有 8 个节点，节点产出物存储在 `output/V{version}/{node}/` 目录下。项目状态通过 _manage.md 中的快照机制管理，但存在以下问题：

1. **上下文多版本**：节点产出后用户可能修改，重新进入下一节点时，上下文有多个版本，不知道该用哪个
2. **需求变更**：需求变更后前序节点重新走，上下文还是旧内容
3. **缺乏统一索引**：没有文件记录各节点产出物的具体路径

## Goals / Non-Goals

**Goals:**
- 解决上下文多版本问题：统一每次从文件读取最终版本
- 解决需求变更问题：文件是最新的，直接读文件
- 创建 Memory.json 作为任务导航索引

**Non-Goals:**
- 不修改节点产出物的存储格式
- 不实现自动摘要生成
- 不迁移已有的历史项目数据

## Decisions

### D1: Memory.json 存储位置
**决定**：`{project_directory}/memory.json`

**理由**：
- 放在项目根目录，作为项目的唯一事实来源
- 与 output 目录同级，方便引用

### D2: 分层加载策略
**决定**：加载指引写入各节点 skill 文件，不写入 Memory.json

**理由**：
- 各节点的加载需求不同，灵活配置
- skill 文件可版本化管理
- 避免 Memory.json 过于复杂

**替代方案考虑**：
- 方案A（采用）：加载指引放在 skill 里 → 灵活、各节点自定义
- 方案B：放在 Memory.json 的 load_guide 字段 → 集中管理但不够灵活

### D3: 节点状态存储
**决定**：node_list 中每个节点只记录 name + status + file（可选）

**理由**：
- 保持精简，只记录必要信息
- file 字段仅在节点有产出物时才存在

### D4: 统一从文件读取
**决定**：每个节点每次都从文件读取前序节点的最终版本，不依赖上下文

**理由**：
- 上下文多版本 → 直接读文件，只有最终版本
- 需求变更 → 文件是最新的，直接读文件即可

### D5: 节点加载策略
**决定**：
- node2-node6：只需加载前一个节点的最终版本
- node7：需要加载 node5 和 node6 的最终版本

**理由**：
- 其他节点只依赖前序节点的产出物
- node7 生成 PRD overview 时需要 detail 和 prototyping 的内容

## Risks / Trade-offs

| Risk | Mitigation |
|------|------------|
| LLM 忘记读取前序产出物 | 在 skill 里明确写入"加载指引"章节 |
| 文件路径错误找不到 | 基于 project.directory 动态拼接路径 |

## Migration Plan

1. **创建 Memory.json 框架**
   - 放在项目目录下：`{project_directory}/.memory/memory.json`
   
2. **更新 _manage.md**
   - 新增 read_memory(), write_memory() 接口
   - 更新节点产出后自动写入 Memory.json

3. **更新节点 skill**
   - 在各节点 skill 添加"加载指引"章节，明确从文件读取前序节点产出物
   
4. **迁移现有项目**
   - 手动为已有项目创建 Memory.json
   - 不强制要求迁移

## Open Questions

1. **Q: Memory.json 放在哪？**
   - 方案A（采用）：项目根目录 `{project_directory}/memory.json`
   - 方案B：`.opencode/memory/{project}.json`

2. **Q: 是否需要版本历史？**
   - 当前只记录最终版本，也可记录变更历史