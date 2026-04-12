---
name: 06-prototyping
description: 原型设计技能。基于详细设计生成 ASCII 线框图（自动展示），并使用 tdesign-component-helper Skill（如果已安装）或直接基于 TDesign 组件库生成高保真 HTML 原型。
---

# 06 - Prototyping (原型制作)

## 职责
- 生成 ASCII 线框图和 HTML 原型
- Mock 数据生成（欧莱雅兰蔻数据）
- ASCII 线框图生成
- HTML 原型生成（tdesign-component-helper）
- 实时打印要求
- 禁止后台任务规范
- 逐个页面生成规范

---

## 加载指引

### 前序节点产出物

读取 node5 (detail) 的产出物：
- 从 Memory.json 获取 detail 的 file 路径
- 调用 manage.read_memory() 获取 node_list
- 读取该文件内容

---

## 输出文件

- 文件名: `proto_index.html` + `page_{page_name}.html`
- 路径: `./output/V{version}/prototyping/`
  - `proto_index.html`: 原型索引页面
  - `page_{page_name}.html`: 各页面原型文件
- 生成规则: 见 [01-router.md](01-router.md) 中的文件生成规则

---

## 完成后

1. 保存产出到文件：`./output/V{version}/prototyping/` 目录
2. 调用 manage.update_node_output("prototyping", "output/V{version}/prototyping/")
3. 展示产出摘要
4. 等待用户确认
5. 确认后 → 调用 manage.update_node_status("prototyping", "CONFIRM")
6. 确认后 → 调用 manage.transition_to_next_node()
7. 确认后 → 调用 manage.persist_memory()
8. 进入下一节点
