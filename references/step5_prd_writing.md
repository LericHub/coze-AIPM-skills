---
name: step5_prd_rendering
description: PRD整合与渲染技能。整合前序节点产出物，生成完整的PRD文档和可交互的HTML需求展示系统。
trigger:
  - 任务进入RENDERING节点
  - 需要生成最终PRD文档
  - 需要生成可预览的HTML展示系统
---

## 技能操作步骤

1. **CONTEXT_READ**: [CURRENT_SNAPSHOT_ANALYSIS], [CURRENT_SNAPSHOT_DETAIL], [CURRENT_SNAPSHOT_PROTOTYPING]
   - 从 [CURRENT_SNAPSHOT_ANALYSIS] 读取：读取完整的需求分析产出物
   - 从 [CURRENT_SNAPSHOT_DETAIL] 读取：读取完整的需求详细设计产出物
   - 从 [CURRENT_SNAPSHOT_PROTOTYPING] 读取：生成的HTML原型代码文件路径

2. **生成需求概述页面 (overview.html)
   - 使用 `../references/overview_template.html` 作为模板
   - 从 [CURRENT_SNAPSHOT_ANALYSIS] 提取内容：
     - 项目背景、目标、边界、用户角色、页面清单、业务流程
   - 从 output/ 文件夹中读取最新版本的 PrePRD_V{version}_{date}.md 文件，提取 `FullPicture业务流程及功能说明` 章节内容
   - 替换占位符，生成完整的 overview.html
   - 输出路径: `/AIPM/{project_name}/output/V{version}/html/overview.html

3. **生成各页面需求文档（Markdown 转 HTML）
   - 使用 `../references/page_doc_template.html` 作为模板
   - 对每个页面，将 Markdown 内容转换为 HTML
   - **注意事项**：
     - 不允许修改已经生成的内容
     - 必须按照 Markdown 的结构生成 html
     - 需要兼容 mermaid 图表
     - 保持原始 Markdown 的层级结构
   - 输出路径:
     - C端页面: `/AIPM/{project_name}/output/V{version}/doc/app/{page_name}.html
     - B端页面: `/AIPM/{project_name}/output/V{version}/doc/web/{page_name}.html

4. **整合HTML原型
   - 将 [CURRENT_SNAPSHOT_PROTOTYPING] 中的HTML原型文件复制到对应目录：
     - C端原型: `/AIPM/{project_name}/output/V{version}/app/
     - B端原型: `/AIPM/{project_name}/output/V{version}/web/
   - 确保文件名与页面名称对应

5. **生成交互式 PRD 查看器 (index.html)
   - 使用 `../references/prd_viewer_template.html` 作为模板
   - 替换以下占位符：
     - `{{PROJECT_NAME}}` → 项目名称
     - `{{VERSION}}` → 版本号
     - `{{DATE}}` → 日期
     - `{{C_END_MENU_ITEMS}}` → C端菜单项HTML
     - `{{B_END_MENU_ITEMS}}` → B端菜单项HTML
     - **重要**：替换 `let currentPageData = {...};` 整段为真实的 PAGE_DATA 数据
   - 菜单项格式：
     ```html
     <div class="menu-item" data-page="page_key">
       <span class="menu-item-icon">📄</span>
       <span>页面名称</span>
     </div>
     ```
   - 页面数据格式：
     ```javascript
     {
       "overview": {"title": "需求概述"},
       "page1": {
         "title": "页面名称",
         "prototypePath": "app/page1.html",
         "docPath": "doc/app/page1.html"
       }
     }
     ```
   - **替换方式说明**：
     - 不要只替换 `{{PAGE_DATA}}` 字符串
     - 而是找到模板中整个 `let currentPageData = {...};` 代码块，用真实数据完整替换
   - **重要说明**：
     - 点击"需求概述"：右侧显示单视图需求概述
     - 点击各页面按钮：右侧显示**左图右文**的分栏视图
       - 左侧（🎨 原型预览）：显示 app/ 或 web/ 目录下的原型
       - 右侧（📄 需求文档）：显示 doc/ 目录下的需求文档
   - 输出路径: `/AIPM/{project_name}/output/V{version}/index.html

6. **生成完整PRD文档 (PRD_V{version}_{date}.html)
   - 使用 `../references/prd_template.html` 作为模板
   - 整合以下内容：
     - 需求概述部分
     - C端需求设计内容
     - B端需求设计内容
     - 技术要求内容
   - 替换以下占位符：
     - `{{PROJECT_NAME}}` → 项目名称
     - `{{VERSION}}` → 版本号
     - `{{DATE}}` → 日期
     - `{{OWNER}}` → 负责人
     - `{{BACKGROUND_CONTENT}}` → 项目背景内容
     - `{{OBJECTIVE_CONTENT}}` → 项目目标内容
     - `{{IN_SCOPE}}` → 范围内内容
     - `{{OUT_SCOPE}}` → 范围外内容
     - `{{USER_ROLES}}` → 用户角色表格行
     - `{{PAGE_LIST}}` → 页面清单卡片
     - `{{FLOW_DIAGRAM}}` → 业务流程图
     - `{{C_END_CONTENT}}` → C端fullpicture的完整HTML内容
     - `{{B_END_CONTENT}}` → B端fullpicture的完整HTML内容
     - `{{API_CONTENT}}` → API规划内容
     - `{{TRACKING_CONTENT}}` → 埋点方案内容
   - 输出路径: `/AIPM/{project_name}/output/V{version}/html/PRD_V{version}_{date}.html

7. **CONTEXT_WRITE**: [CURRENT_SNAPSHOT_RENDERING]
   - 写入生成的HTML文件路径列表
   - 写入完整PRD文档路径
   - 写入overview.html路径
   - 写入交互式查看器index.html路径

8. **输出交付物
   - 展示交互式PRD查看器路径: `/AIPM/{project_name}/output/V{version}/index.html
   - 展示完整PRD文档路径: `/AIPM/{project_name}/output/V{version}/html/PRD_V{version}_{date}.html
   - 展示需求概述路径: `/AIPM/{project_name}/output/V{version}/html/overview.html
   - 说明交互式PRD查看器功能：
     - 左侧菜单栏：包含"需求概述"按钮
     - 点击"需求概述"：右侧显示单视图需求概述内容，内容来自：
       - CURRENT_SNAPSHOT_ANALYSIS 内容（转HTML格式）
       - PrePRD 文件的 FullPicture 章节
     - 点击各页面按钮：右侧显示**左图右文**的分栏视图
       - 左侧（🎨 原型预览）：显示 app/ 或 web/ 目录下的原型
       - 右侧（📄 需求文档）：显示 doc/ 目录下的需求文档
   - 说明完整PRD文档包含需求概述、页面需求设计等全部内容
   - 说明完整PRD文档支持Mermaid图表渲染

9. **用户确认
   - **【等待用户确认】**：询问用户："以上是根据所有节点产出物整合生成的完整PRD文档。我们提供了两种查看方式：1) 交互式查看器（推荐，左侧菜单导航，点击各页面显示左图右文分栏，左侧原型右侧文档）；2) 完整单页PRD文档。请查看并确认是否满足您的要求？"
   - 情形A：用户回复"确认" → 输出最新版本的交付物
   - 情形B：用户提出修改 → 返回原型设计或详细设计节点进行调整

## 模板占位符说明

### overview_template.html 占位符
| 占位符 | 说明 | 示例 |
|--------|------|------|
| `{{PROJECT_NAME}}` | 项目名称 | 用户中心系统 |
| `{{VERSION}}` | 版本号 | V1.0 |
| `{{DATE}}` | 日期 | 2026-04-09 |
| `{{OWNER}}` | 负责人 | 产品经理 |
| `{{BACKGROUND_CONTENT}}` | 项目背景HTML内容 | `<p>...</p>` |
| `{{OBJECTIVE_CONTENT}}` | 项目目标HTML内容 | `<ul>...</ul>` |
| `{{IN_SCOPE}}` | 范围内内容 | `<ul>...</ul>` |
| `{{OUT_SCOPE}}` | 范围外内容 | `<ul>...</ul>` |
| `{{USER_ROLES}}` | 用户角色表格行 | `<tr><td>...</td></tr>` |
| `{{PAGE_LIST}}` | 页面清单卡片 | `<div class="card">...</div>` |
| `{{FLOW_DIAGRAM}}` | 业务流程图 | `<pre>...</pre>` |

### prd_viewer_template.html 占位符
| 占位符 | 说明 | 示例 |
|--------|------|------|
| `{{PROJECT_NAME}}` | 项目名称 | 用户中心系统 |
| `{{VERSION}}` | 版本号 | V1.0 |
| `{{DATE}}` | 日期 | 2026-04-09 |
| `{{C_END_MENU_ITEMS}}` | C端菜单项HTML | `<div class="menu-item">...</div>` |
| `{{B_END_MENU_ITEMS}}` | B端菜单项HTML | `<div class="menu-item">...</div>` |
| **特殊替换** | 替换整段 `let currentPageData = {...};` 代码为真实数据 | 见步骤5说明 |

### prd_template.html 占位符
| 占位符 | 说明 | 示例 |
|--------|------|------|
| `{{PROJECT_NAME}}` | 项目名称 | 用户中心系统 |
| `{{VERSION}}` | 版本号 | V1.0 |
| `{{DATE}}` | 日期 | 2026-04-09 |
| `{{OWNER}}` | 负责人 | 产品经理 |
| `{{BACKGROUND_CONTENT}}` | 项目背景HTML内容 | `<p>...</p>` |
| `{{OBJECTIVE_CONTENT}}` | 项目目标HTML内容 | `<ul>...</ul>` |
| `{{IN_SCOPE}}` | 范围内内容 | `<ul>...</ul>` |
| `{{OUT_SCOPE}}` | 范围外内容 | `<ul>...</ul>` |
| `{{USER_ROLES}}` | 用户角色表格行 | `<tr><td>...</td></tr>` |
| `{{PAGE_LIST}}` | 页面清单卡片 | `<div class="card">...</div>` |
| `{{FLOW_DIAGRAM}}` | 业务流程图 | `<pre>...</pre>` |
| `{{C_END_CONTENT}}` | C端fullpicture完整HTML | 完整的HTML内容，包含所有Markdown转换后的内容 |
| `{{B_END_CONTENT}}` | B端fullpicture完整HTML | 完整的HTML内容，包含所有Markdown转换后的内容 |
| `{{API_CONTENT}}` | API规划HTML内容 | `<p>...</p>` |
| `{{TRACKING_CONTENT}}` | 埋点方案HTML内容 | `<p>...</p>` |

## 输出目录结构
```
/AIPM/{project_name}/output/V{version}/
├── index.html                      # 交互式PRD查看器（主入口）
├── app/                          # C端原型
│   └── {page1}.html
├── web/                          # B端原型
│   └── {page2}.html
├── html/
│   ├── overview.html                   # 需求概述
│   └── PRD_V{version}_{date}.html     # 完整PRD文档（单文件）
└── doc/
    ├── app/                          # C端需求文档
    │   └── {page1}.html
    └── web/                          # B端需求文档
        └── {page2}.html
```

## Markdown 转 HTML 规则

### 转换规则
1. **标题转换**：
   - `#` → `<h1>`
   - `##` → `<h2>`
   - `###` → `<h3>`
   - 以此类推

2. **列表转换**：
   - `-` 或 `*` → `<ul><li>`
   - `1.` → `<ol><li>`

3. **代码块转换**：
   - ``` 或 ```` → `<pre><code>`
   - 特别注意：Mermaid 代码块（`mermaid`）需要保留，交给 Mermaid 渲染

4. **链接转换**：
   - `[text](url)` → `<a href="url">text</a>`

5. **图片转换**：
   - `![alt](url)` → `<img src="url" alt="alt">`

6. **引用转换**：
   - `>` → `<blockquote>`

7. **表格转换**：
   - Markdown 表格 → HTML `<table>`

8. **粗体/斜体转换**：
   - `**text**` → `<strong>text</strong>`
   - `*text*` → `<em>text</em>`

### Mermaid 图表支持
- 保留 ```mermaid 代码块原样保留，不做转换
- 引入 mermaid.js 库自动渲染

## 注意事项
1. 内容不做任何修改，原样保留所有结构和格式
2. 确保HTML文件编码为UTF-8
3. 保持模板中的CSS样式不变
4. 页面清单卡片需要区分C端和B端，使用不同的图标
5. 用户角色表格需要添加对应的标签（C端/B端/管理等）
6. Markdown 转 HTML 时，**不允许修改内容**，仅做格式转换
7. 必须兼容 Mermaid 图表，保留原始代码块
8. 交互式查看器是推荐的查看方式，提供左侧菜单导航
9. **重要**：点击页面按钮时，必须显示左图右文的分栏视图，左侧显示原型，右侧显示文档

## 相关规范
参考 [../STATE_RULES.md](../STATE_RULES.md) 中的上下文快照管理、确认机制和强制规则部分。
