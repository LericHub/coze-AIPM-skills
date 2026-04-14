# 验证检查清单

## 节点顺序优化验证
- [ ] `nodes/README.md` 节点概览表格清晰展示执行顺序
- [ ] `nodes/README.md` 包含完整的节点执行流程图
- [ ] `SKILL.md` 工作流图直观展示节点流转路径
- [ ] `SKILL.md` 节点映射表包含序号和执行顺序说明
- [ ] 用户能够一眼看出节点执行的先后顺序和依赖关系

## 0output目录功能验证
- [ ] `_manage.md` 包含 `get_output_folder_path()` 接口定义
- [ ] `_manage.md` 包含 `package_latest_version_output()` 方法定义
- [ ] `_manage.md` 包含0output目录初始化创建逻辑
- [ ] 0output目录路径规范：`/AIPM/{project_name}_{date}_{order}/0output/`
- [ ] node5 (detail) 完成后自动打包到0output目录
- [ ] node6 (prototyping) 完成后自动打包到0output目录
- [ ] node7 (writing) 完成后自动打包到0output目录
- [ ] node8 (change) 完成后自动打包到0output目录
- [ ] 打包文件名符合规范：`{project_name}_V{version}_{node_name}_{YYYYMMDD_HHmm}.zip`
- [ ] 打包内容包含完整的版本目录下所有产出物
- [ ] `SKILL.md` 包含0output目录说明和使用指引

## 兼容性验证
- [ ] 原有功能不受影响，所有节点流程正常执行
- [ ] 原有输出路径保持不变，0output是新增的统一入口
- [ ] 版本管理逻辑正常，历史版本不受影响
- [ ] Memory.json 结构兼容，无需修改原有字段
