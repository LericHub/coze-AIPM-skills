## 1. 创建 Memory.json 框架

- [x] 1.1 确定 Memory.json 存储位置：项目根目录 `{project_directory}/memory.json`
- [x] 1.2 创建初始 Memory.json 模板

## 2. 更新 _manage.md

- [x] 2.1 新增 read_memory() 接口 - 读取 Memory.json
- [x] 2.2 新增 write_memory() 接口 - 写入 Memory.json
- [x] 2.3 新增 update_node_output() 接口 - 节点完成后更新产出物路径

## 3. 更新节点 Skill 文件（添加加载指引）

- [x] 3.1 更新 02-brainstorm.md - 读取 node1 (router) 产出
- [x] 3.2 更新 03-clarify.md - 读取 node2 (brainstorm) 产出
- [x] 3.3 更新 04-analysis.md - 读取 node3 (clarify) 产出
- [x] 3.4 更新 05-detail.md - 读取 node4 (analysis) 产出
- [x] 3.5 更新 06-prototyping.md - 读取 node5 (detail) 产出
- [x] 3.6 更新 07-writing.md - 读取 node5 (detail) + node6 (prototyping) 产出

## 4. 验证和测试

- [ ] 4.1 测试新项目初始化时创建 Memory.json
- [ ] 4.2 测试节点完成后更新 Memory.json
- [ ] 4.3 测试 node7 能正确读取 node5 + node6 内容