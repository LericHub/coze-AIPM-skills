---
name: step7_html_rendering
description: HTML原型渲染技能。基于详细设计内容和HTML原型代码，使用标准化模板生成可预览的HTML需求展示页面。
trigger:
  - 任务进入HTML_RENDERING节点
  - 需要生成HTML格式的需求展示页面
  - 已有HTML原型代码需要整合展示
---

## 技能操作步骤

1. **CONTEXT_READ**: [CURRENT_SNAPSHOT_DETAIL] 和 [CURRENT_SNAPSHOT_PROTOTYPING]
   - 从 [CURRENT_SNAPSHOT_DETAIL] 读取：项目名称、版本、日期、负责人、项目背景、目标、边界、用户角色、页面清单、业务流程、各页面详细设计
   - 从 [CURRENT_SNAPSHOT_PROTOTYPING] 读取：生成的HTML原型代码文件路径

2. **生成需求概述页面 (overview.html)**:
   - 使用 `templates/overview.html` 作为模板
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
   - 输出路径: `/AIPM/{project_name}/output/V{version}/html/overview.html`

3. **生成各页面需求文档**:
   - 对每个页面，使用 `templates/page.html` 作为模板
   - 替换以下占位符：
     - `{{BREADCRUMB}}` → 面包屑导航
     - `{{PAGE_NAME}}` → 页面名称
     - `{{PAGE_PATH}}` → 页面路径
     - `{{PAGE_TYPE}}` → 页面类型（C端/B端）
     - `{{DATE}}` → 日期
     - `{{PAGE_DESCRIPTION}}` → 页面描述
     - `{{LAYOUT_ZONES}}` → 布局分区示意图
     - `{{LAYOUT_TABLE}}` → 布局表格
     - `{{ELEMENT_LIST}}` → 页面元素列表
     - `{{INTERACTION_DESCRIPTION}}` → 交互说明
     - `{{DATA_LOGIC}}` → 数据逻辑
     - `{{TRACKING_TABLE}}` → 埋点说明表格
   - 输出路径: 
     - C端页面: `/AIPM/{project_name}/output/V{version}/doc/app/{page_name}.html`
     - B端页面: `/AIPM/{project_name}/output/V{version}/doc/web/{page_name}.html`

4. **整合HTML原型**:
   - 将 [CURRENT_SNAPSHOT_PROTOTYPING] 中的HTML原型文件复制到对应目录：
     - C端原型: `/AIPM/{project_name}/output/V{version}/html/app/`
     - B端原型: `/AIPM/{project_name}/output/V{version}/html/web/`
   - 确保文件名与页面名称对应

5. **生成主索引页面 (index.html)**:
   - 使用 `templates/index.html` 作为模板
   - 替换以下占位符：
     - `{{PROJECT_NAME}}` → 项目名称
     - `{{VERSION}}` → 当前版本号（用于默认选中和初始路径）
     - `{{VERSION_OPTIONS}}` → 版本选择器的option列表
     - `{{MINIAPP_PAGES}}` → 小程序端页面菜单项
     - `{{ADMIN_PAGES}}` → 管理端页面菜单项
   - 输出路径: `/AIPM/{project_name}/output/V{version}/index.html`

6. **CONTEXT_WRITE**: [CURRENT_SNAPSHOT_HTML_RENDERING]
   - 写入生成的HTML文件路径列表
   - 写入主索引页面路径

7. **输出交付物**:
   - 展示主索引页面路径: `/AIPM/{project_name}/output/V{version}/index.html`
   - 说明可以通过左侧菜单切换查看不同页面
   - 说明页面需求页面采用双栏布局，左侧展示HTML原型，右侧展示需求文档

8. **用户确认**:
   - **【等待用户确认】**：询问用户："以上是根据详细设计和HTML原型生成的可预览需求展示页面，您可以通过左侧导航栏查看需求概述和各页面的详细需求。请查看并确认是否满足您的要求？"
   - 情形A：用户回复"确认" → 结束节点
   - 情形B：用户提出修改 → 返回原型设计或详细设计节点进行调整

## 模板占位符说明

### overview.html 占位符
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

### page.html 占位符
| 占位符 | 说明 | 示例 |
|--------|------|------|
| `{{BREADCRUMB}}` | 面包屑导航 | 用户中心系统 > 小程序端 > <span>首页</span> |
| `{{PAGE_NAME}}` | 页面名称 | 首页 |
| `{{PAGE_PATH}}` | 页面路径 | /app/home |
| `{{PAGE_TYPE}}` | 页面类型 | C端 |
| `{{DATE}}` | 日期 | 2026-04-09 |
| `{{PAGE_DESCRIPTION}}` | 页面描述HTML内容 | `<p>...</p>` |
| `{{LAYOUT_ZONES}}` | 布局分区示意图 | `<div class="layout-item">...</div>` |
| `{{LAYOUT_TABLE}}` | 布局表格行 | `<tr><td>...</td></tr>` |
| `{{ELEMENT_LIST}}` | 页面元素列表 | `<li class="element-item">...</li>` |
| `{{INTERACTION_DESCRIPTION}}` | 交互说明HTML内容 | `<ul>...</ul>` |
| `{{DATA_LOGIC}}` | 数据逻辑HTML内容 | `<p>...</p>` |
| `{{TRACKING_TABLE}}` | 埋点说明表格行 | `<tr><td>...</td></tr>` |

### index.html 占位符
| 占位符 | 说明 | 示例 |
|--------|------|------|
| `{{PROJECT_NAME}}` | 项目名称 | 用户中心系统 |
| `{{VERSION}}` | 当前版本号 | V1.0_20260409 |
| `{{VERSION_OPTIONS}}` | 版本选择器option | `<option value="V1.0_20260409" selected>用户中心系统 - V1.0_20260409</option>` |
| `{{MINIAPP_PAGES}}` | 小程序端页面菜单 | `<a href="#" class="menu-link submenu-link" onclick="loadSpecificPage('app/home')">首页</a>` |
| `{{ADMIN_PAGES}}` | 管理端页面菜单 | `<a href="#" class="menu-link submenu-link" onclick="loadSpecificPage('web/user_list')">用户列表</a>` |

## 注意事项
1. 内容不做任何修改，原样保留所有结构和格式
2. 确保HTML文件编码为UTF-8
3. 保持模板中的CSS样式不变
4. 页面清单卡片需要区分C端和B端，使用不同的图标
5. 用户角色表格需要添加对应的标签（C端/B端/管理等）
