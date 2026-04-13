# Legacy Assets

`product_manager/legacy/` 保存已经退出主工作流的历史材料，仅用于追溯和参考。

## scripts/

`product_manager/legacy/scripts/` 中的 shell 脚本保留为历史参考，不属于当前受支持的 `product_manager` 工作流。

这些脚本基于旧模型构建，包括但不限于：

- `/AIPM` 绝对路径
- `Memory.md`
- 旧版输出目录结构

当前工作流以以下模型为准：

- `product_manager/SKILL.md`
- `product_manager/nodes/_manage.md`
- `Memory.json`
- 相对路径 `./output/V{version}/...`

如果需要实现或维护现行流程，请不要从这些 legacy scripts 开始。
