import re

file_path = "product_manager/nodes/07-writing.md"
with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# Replace Step 2 & 3
old_step_2_3 = """## Step 2: 初始化输出目录

### 2.1 检查或创建目录

检查路径：`./{project_name}/output/V{version}/`

- **如果 Step4 已创建带时间戳的目录**：直接复用
- **如果未创建**：创建新目录，格式：`V{version}_{datetime}`（如 V1.0_20260412_160000）

### 2.2 确保目录结构

```
./{project_name}/output/V{version}/V{version}_{datetime}/
├── app/              # C端原型（Step4 已生成，跳过）
├── web/              # B端原型（Step4 已生成，跳过）
├── doc/              # 页面文档（Step5 新生成）
│   ├── app/
│   └── web/
├── html/             # 概述页面（Step5 新生成）
└── assets/           # 静态资源
```

---

## Step 3: 检查原型文件（跳过生成）

### 3.1 获取原型文件列表

从 node_list 获取 name="prototyping" 的 file 路径（如 `output/V1.0/proto/`），扫描目录：
- `app/` 目录：C端原型文件
- `web/` 目录：B端原型文件

### 3.2 确认规则

**Step5 不重复生成原型**。如果原型不存在，记录缺失但不阻塞流程。"""

new_step_2_3 = """## Step 2: 初始化输出目录

### 2.1 目录定位

输出目录为 `writing` 节点专属目录：`./output/V{version}/writing/`
如果目录不存在，则创建它。

### 2.2 确保目录结构

```
./output/V{version}/writing/
├── doc/              # 页面需求文档
│   ├── app/
│   └── web/
├── html/             # 概述页面
└── assets/           # 静态资源（Logo等）
```
注意：原型文件仍保留在 `./output/V{version}/prototyping/` 目录中，本节点仅引用它们，不复制。

---

## Step 3: 原型文件与端信息映射

### 3.1 读取原型文件与端信息

- 获取 `prototyping` 节点产出目录（如 `./output/V{version}/prototyping/`），该目录为平铺结构（包含 `page_*.html` 等）。
- 根据 `detail` 节点提取的 C端/B端页面列表获取页面的端信息（平台归属）。

### 3.2 页面路径映射

为每个页面建立映射关系：
- `prototypePath`: 对应的平铺原型文件相对路径，例如 `../prototyping/page_home.html`。如果不确定文件名，可根据页面拼音或英文缩写匹配。
- 如果找不到对应原型，不要丢弃该页面，仍保留它（设置 prototypePath 为空或展示占位），保证文档能够被查阅。"""

content = content.replace(old_step_2_3, new_step_2_3)

# Replace Step 4.3
content = content.replace("`./{project_name}/output/V{version}/V{version}_{datetime}/html/overview.html`", "`./output/V{version}/writing/html/overview.html`")

# Replace Step 5.3
content = content.replace("`./{project_name}/output/V{version}/V{version}_{datetime}/doc/app/{page}.html`", "`./output/V{version}/writing/doc/app/{page}.html`")
content = content.replace("`./{project_name}/output/V{version}/V{version}_{datetime}/doc/web/{page}.html`", "`./output/V{version}/writing/doc/web/{page}.html`")

# Replace Step 6.3 - 6.5
old_step_6 = """### 6.3 页面数据格式

```javascript
{
  "overview": {"title": "需求概述"},
  "home": {
    "title": "首页",
    "prototypePath": "app/home.html",
    "docPath": "doc/app/home.html"
  }
}
```

### 6.4 查看器交互

- 点击"需求概述"：右侧显示单视图 `html/overview.html`
- 点击页面按钮：左侧显示原型 `app/` 或 `web/`，右侧显示文档 `doc/`

### 6.5 保存路径

`./{project_name}/output/V{version}/V{version}_{datetime}/index.html`"""

new_step_6 = """### 6.3 页面数据格式

结合 Step 3 的映射结果生成：
```javascript
{
  "overview": {"title": "需求概述"},
  "home": {
    "title": "首页",
    "platform": "app", // 或 "web"
    "prototypePath": "../prototyping/page_home.html",
    "docPath": "doc/app/home.html"
  }
}
```

### 6.4 查看器交互

- 点击"需求概述"：工作区显示单视图 `html/overview.html`（隐藏双栏）
- 点击页面按钮：工作区显示双视图，左侧 iframe 加载 `prototypePath`，右侧 iframe 加载 `docPath`。

### 6.5 保存路径

`./output/V{version}/writing/index.html`"""

content = content.replace(old_step_6, new_step_6)

# Replace Output Structure
old_output_struct = """## 输出目录结构

```
./{project_name}/output/V{version}/V{version}_{datetime}/
├── index.html              # 交互式 PRD 查看器
├── assets/
│   └── image.png           # Logo
├── app/                    # C端原型（Step4 生成）
│   └── *.html
├── web/                    # B端原型（Step4 生成）
│   └── *.html
├── html/
│   └── overview.html       # 需求概述
└── doc/
    ├── app/
    │   └── *.html          # C端页面需求文档
    └── web/
        └── *.html          # B端页面需求文档
```"""

new_output_struct = """## 输出目录结构

```
./output/V{version}/writing/
├── index.html              # 交互式 PRD 查看器
├── assets/
│   └── image.png           # Logo
├── html/
│   └── overview.html       # 需求概述（单视图）
└── doc/
    ├── app/
    │   └── *.html          # C端页面需求文档
    └── web/
        └── *.html          # B端页面需求文档
```
注意：原型不在此目录下，而是引用 `../prototyping/` 中的平铺文件。"""

content = content.replace(old_output_struct, new_output_struct)

with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)
