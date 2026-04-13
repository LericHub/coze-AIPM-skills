## Why

node7 (writing) 期望从 app/web 子目录读取原型文件，但 node6 (prototyping) 实际输出为平铺目录结构（page_*.html）。这导致 node7 无法正确读取原型文件，流程阻塞。

## What Changes

- 更新 07-writing.md 的 Step 3：改为扫描平铺目录而非 app/web 子目录
- 改用文件名前缀规则区分 C端/B端（如 app_* 或 web_* 前缀，或通过 detail 文件的页面端信息匹配）

## Capabilities

### New Capabilities

无需新增 capability，这是对现有流程的兼容修正。

### Modified Capabilities

- `node7-prototype-scanning`: 修改 node7 读取原型的逻辑，兼容 node6 的平铺输出结构

## Impact

- 修改文件: product_manager/nodes/07-writing.md
- 影响范围: node6 → node7 的数据传递流程