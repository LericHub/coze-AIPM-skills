## Context

node07 当前负责把 detail 与 prototyping 的产物整合为 `writing/index.html`、`html/overview.html` 与各页面文档 HTML，但 `prd_viewer_template.html` 仍是一套偏通用的卡片式后台布局。新的 Figma 设计给出了更明确的审阅台结构：左侧是窄栏菜单，包含版本切换、需求概述入口、C/B 端页面分组和当前页面高亮；右侧是工作区，概述为单 iframe 视图，页面为 prototype/doc 双 iframe 并排视图。

现有上下文还存在两个约束。第一，node6 的原型输出为平铺目录 `prototyping/page_*.html` 与 `proto_index.html`，不能再假设 `app/` 和 `web/` 子目录存在。第二，writing 节点最终产出路径已在 README 与 node7 流程中约定为 `output/V{version}/writing/`，因此改动必须在既有目录结构内完成，而不是引入新的运行时或构建系统。

## Goals / Non-Goals

**Goals:**
- 让 node07 的最终查看器布局、导航组织和选中态接近 Figma `30:296` 的信息架构。
- 让概述页作为单独入口稳定渲染在 overview 容器中，并在页面视图与概述视图之间平滑切换。
- 明确页面元数据组装规则，保证 detail 中的页面名称/端信息可以映射到 prototype 与 doc 文件路径。
- 保持 writing 输出为静态 HTML 体系，方便技能文档直接生成和落盘。

**Non-Goals:**
- 不修改 node6 的输出目录结构或重新生成 Figma 中的真实前端应用。
- 不引入新的前端框架、打包器或远程依赖管理方式。
- 不重写 detail 节点的业务内容生产逻辑，仅消费其页面信息与概述内容。

## Decisions

### D1: 继续使用单个静态 `index.html` 作为查看器外壳

将新布局落在现有 `prd_viewer_template.html` 上，而不是拆成多文件应用。原因是 node07 当前能力是模板填充和静态文件生成，保持单文件外壳可以最大限度复用现有生成流程，同时让 `07-writing.md` 的执行描述与最终实现一致。

备选方案是引入更复杂的多页面壳层，但这会要求 writing 节点新增资源编译、脚本组织和更多模板依赖，超出本次变更范围。

### D2: 以 detail 页面清单作为导航真源，以 output 文件路径作为渲染真源

导航项的显示顺序、文案和 app/web 分组从 detail 中提取；每个页面实际加载的 `prototypePath` 与 `docPath` 从 writing 版本目录推导。这样既能保留业务命名，又能适配 node6 平铺的原型文件现实。若页面名称需要 slug 化，slug 规则在 writing 阶段集中处理，避免模板侧猜测。

备选方案是直接扫描输出目录生成菜单，但那样会丢失 detail 中的业务排序和页面端属性，还会在文件命名与展示名不一致时造成错配。

### D3: 使用两种视图模式而不是为每个菜单项生成独立模板

查看器只维护两种模式：`overview` 单视图模式和 `page` 双视图模式。侧边栏点击概述时仅展示 `html/overview.html`；点击页面时左侧加载 prototype，右侧加载 doc。这样可以让模板逻辑保持简单，并直接对应 Figma 注释里“选中的版本+页面渲染到 iframe”的要求。

备选方案是把概述也塞进双栏模式的一侧，但这会制造无意义空白区域，与设计稿中的 overview 容器意图不符。

### D4: 在 writing 说明中显式收敛 flat prototyping 到页面元数据映射

`07-writing.md` 需要同步更新，明确 Step 1/3/6 如何从平铺原型目录、detail 端信息和版本目录拼出页面数据对象。模板更新如果不反映到技能说明，后续节点执行仍会沿用旧假设，导致文档与实现脱节。

## Risks / Trade-offs

- [Risk] detail 页面标题与原型文件 slug 无法自动一一对应 -> Mitigation: 在 writing 中定义统一 slug/path 映射规则，并在找不到对应文件时保留警告但不让概述页失效。
- [Risk] Figma 仅提供局部节点与注释，未覆盖全部交互细节 -> Mitigation: 保持现有查看器核心交互，只将视觉结构、菜单层级和 iframe 分栏改到设计要求范围内。
- [Risk] 静态模板内脚本变复杂后更难维护 -> Mitigation: 将页面数据对象、视图切换和 DOM 更新逻辑限制为少量集中函数，不新增运行时依赖。

## Migration Plan

1. 更新 `07-writing.md`，让写作节点描述与新布局及路径映射规则一致。
2. 更新 `prd_viewer_template.html` 及相关模板，使新生成的 `index.html` 可以消费新的页面数据对象。
3. 用已有版本输出目录验证 overview、app 页面和 web 页面都能在新查看器里打开。
4. 若发现布局或映射失败，可临时回滚到旧模板文件，不影响已有 detail/prototyping 产物。

## Open Questions

- Figma `7:11899` 仅暴露为 overview iframe 容器，没有更多子层信息；实施时需要依据现有 overview HTML 内容决定其最终样式是否只做容器级适配。
- 版本下拉是否只需要展示并切换 output 一级目录，还是还要支持无刷新重载当前页面状态；当前提案按静态切换入口设计，实施时可根据仓库能力微调。
