## Why

当前产品经理工作流的输出结构存在三个问题：prototyping 节点输出未按端分类（app/web），PRD viewer 的 logo 资源未在输出时自动创建，且缺少输出物的版本打包机制。影响协作效率和交付规范化。

## What Changes

1. **调整 prototyping 节点输出结构** - 输出目录增加 app/ 和 web/ 子文件夹，分别存放对应端的原型文件
2. **调整 writing 节点 assets 处理** - 初始化输出目录时创建 assets/ 并复制 logo.png，同时更新文件引用路径
3. **增加 _output 打包** - node6/7/8 完成后自动打包项目输出目录为 zip 文件
4. **增加 node6 前台运行说明** - 显式说明 prototyping 节点必须在前台运行

## Capabilities

### New Capabilities

- `node-output-structure`: 调整 node6/7 输出目录结构，分 app/web 子文件夹
- `node-output-packaging`: 节点完成后自动打包输出物为 zip 文件

### Modified Capabilities

- `node06-prototyping`: 增加前台运行约束说明
- `node07-writing`: 增加 assets 目录初始化和路径引用调整

## Impact

- 修改 `product_manager/nodes/06-prototyping.md`
- 修改 `product_manager/nodes/07-writing.md`
- 修改 `product_manager/nodes/08-change.md`（增加打包）
- 修改 `product_manager/references/prd_viewer_template.html`（路径示例注释）