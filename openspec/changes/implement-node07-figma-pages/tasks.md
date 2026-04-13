## 1. 更新 node07 写作节点说明

- [x] 1.1 修改 `product_manager/nodes/07-writing.md`，将原型读取规则从 `app/`、`web/` 子目录假设调整为平铺 prototyping 输出与 detail 平台信息映射
- [x] 1.2 在 `product_manager/nodes/07-writing.md` 中补充页面数据对象、overview 单视图模式和 page 双视图模式的生成规则
- [x] 1.3 校正 `product_manager/nodes/07-writing.md` 的输出路径描述，使其与 `output/V{version}/writing/` 实际目录结构一致

## 2. 重建 PRD 查看器模板

- [x] 2.1 更新 `product_manager/references/prd_viewer_template.html`，实现与 Figma `30:296` 对齐的侧边栏、版本选择区、导航分组和双 iframe 工作区布局
- [x] 2.2 在模板脚本中实现 overview 单视图与 page 双视图切换逻辑，并维护菜单激活态
- [x] 2.3 调整模板占位符和页面数据消费方式，支持版本列表、概述入口以及 app/web 页面分组渲染

## 3. 对齐写作产物映射

- [x] 3.1 更新 writing 阶段的页面元数据组装逻辑或对应说明，确保页面标题、平台、prototypePath 和 docPath 可以从 detail 与 output 目录稳定推导
- [x] 3.2 补充缺失原型文件时的降级规则，保证页面文档仍可在查看器中访问
- [x] 3.3 如有需要，更新 overview 相关模板或容器样式，使 `html/overview.html` 能在新查看器中作为独立入口展示

## 4. 验证输出

- [x] 4.1 用一个已有版本目录验证 `index.html` 默认打开需求概述，且可以切换到 app/web 页面
- [x] 4.2 验证页面切换后 prototype 与 doc iframe 路径正确，且版本切换入口能够反映可用版本目录
- [x] 4.3 检查文档说明、模板占位符和最终输出结构保持一致，无遗留旧的 `app/`、`web/` 原型读取假设
