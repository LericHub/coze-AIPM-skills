# Tasks

- [ ] Task 1: 更新 _manage.md - 新增0output相关接口和方法
  - [ ] SubTask 1.1: 新增 `get_output_folder_path(project_name, date, order)` 接口，返回0output目录路径
  - [ ] SubTask 1.2: 新增 `package_latest_version_output(project_name, date, order, version, node_name)` 方法，实现打包并复制到0output目录逻辑
  - [ ] SubTask 1.3: 更新 Memory.json 结构说明，新增0output目录相关说明
  - [ ] SubTask 1.4: 在目录初始化逻辑中，增加自动创建0output目录的步骤

- [ ] Task 2: 优化 nodes/README.md - 增强节点顺序可视化
  - [ ] SubTask 2.1: 优化节点概览表格，增加执行顺序、流转关系说明
  - [ ] SubTask 2.2: 新增完整执行流程图，直观展示节点顺序和依赖
  - [ ] SubTask 2.3: 优化内部能力说明，与节点顺序关联展示

- [ ] Task 3: 优化 SKILL.md - 增强流程可视化和0output说明
  - [ ] SubTask 3.1: 优化工作流图，增加节点执行顺序和路径标识
  - [ ] SubTask 3.2: 优化节点映射表，增加序号列和执行顺序说明
  - [ ] SubTask 3.3: 新增0output目录说明，更新输出文件结构章节

- [ ] Task 4: 更新 05-detail.md - 新增0output目录打包逻辑
  - [ ] SubTask 4.1: 在"完成后"章节，新增调用 manage.package_latest_version_output() 方法
  - [ ] SubTask 4.2: 更新路径说明，增加0output目录相关内容

- [ ] Task 5: 更新 06-prototyping.md - 新增0output目录打包逻辑
  - [ ] SubTask 5.1: 在"完成后"章节，新增调用 manage.package_latest_version_output() 方法
  - [ ] SubTask 5.2: 移除原有打包逻辑（现在统一在manage中处理）
  - [ ] SubTask 5.3: 更新路径说明，增加0output目录相关内容

- [ ] Task 6: 更新 07-writing.md - 新增0output目录打包逻辑
  - [ ] SubTask 6.1: 在"完成后"章节，新增调用 manage.package_latest_version_output() 方法
  - [ ] SubTask 6.2: 移除原有打包逻辑（现在统一在manage中处理）
  - [ ] SubTask 6.3: 更新路径说明，增加0output目录相关内容

- [ ] Task 7: 更新 08-change.md - 新增0output目录打包逻辑
  - [ ] SubTask 7.1: 在"完成后"章节，新增调用 manage.package_latest_version_output() 方法
  - [ ] SubTask 7.2: 移除原有打包逻辑（现在统一在manage中处理）
  - [ ] SubTask 7.3: 更新路径说明，增加0output目录相关内容

- [ ] Task 8: 验证所有变更
  - [ ] SubTask 8.1: 验证节点顺序展示是否清晰直观
  - [ ] SubTask 8.2: 验证0output目录创建逻辑是否正常
  - [ ] SubTask 8.3: 验证各节点打包逻辑是否正确复制到0output目录
  - [ ] SubTask 8.4: 验证打包文件名是否符合规范

# Task Dependencies
- Task 2-7 依赖 Task 1 完成
- Task 8 依赖 Task 2-7 完成
