## Why

node07 (`07-writing.md`) 目前生成的是一套通用 PRD 查看器，既没有对齐最新 Figma 设计，也没有把版本选择、页面导航、概述单页视图与原型/文档双栏视图串成稳定的输出契约。随着 node6 原型输出和 writing 目录结构已经定型，现在需要把 node07 的最终页面生成规则收敛到这两份 Figma 设计上，避免生成结果与预期审阅界面持续偏离。

## What Changes

- 更新 node07 写作节点的输出契约，使其生成的 `index.html` 对齐 Figma `30:296` 的整体 PRD 查看器布局，包括版本选择、分组侧边栏、选中态和双 iframe 工作区。
- 更新 node07 的概述页展示方式，使 Figma `7:11899` 定义的 overview 容器成为独立单视图入口，并与页面级原型/文档双栏视图共存。
- 规范写作节点的页面元数据组装逻辑，从 detail 页面信息和 versioned output 目录中解析 app/web 页面、原型路径和文档路径，支撑 node07 中的页面切换。
- 刷新写作节点引用的模板和说明文档，明确 flat prototyping 输出与 writing 文档输出如何映射到新界面。

## Capabilities

### New Capabilities
- `node07-prd-viewer-layout`: node07 生成的 PRD 查看器应输出与 Figma 设计一致的整体布局、导航结构和页面切换外观。
- `node07-page-rendering`: node07 应基于版本目录、页面平台信息和生成产物路径，正确渲染概述、原型和页面文档内容。

### Modified Capabilities

无。

## Impact

- `product_manager/nodes/07-writing.md`
- `product_manager/references/prd_viewer_template.html`
- 可能涉及 `product_manager/references/overview_template.html` 或写作节点引用的相关模板文件
- `./output/V{version}/writing/` 下生成的 `index.html`、`html/overview.html`、`doc/app/*.html`、`doc/web/*.html`
- node5 detail 与 node6 prototyping 到 node07 writing 的页面数据传递逻辑
