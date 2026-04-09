---
name: step5_prd_writing
description: PRD撰写技能。整合前序节点产出物，生成完整的产品需求文档(HTML格式)。
trigger:
  - 任务进入WRITING节点
  - 需要生成最终PRD文档
  - 需要整合所有产出物
---

## 技能操作步骤

1. **CONTEXT_READ**: [CURRENT_SNAPSHOT_ANALYSIS] (读取需求分析快照)
   - 获取PRD骨架、用户角色、页面清单、埋点方案等信息
   - **必须显性调用** Figma MCP 获取设计稿内容：需求概述页面 (@https://www.figma.com/design/EsRhGXGgTpdRMhG05JNWEO/Untitled?node-id=7-11382&m=dev)

2. **CONTEXT_READ**: [CURRENT_SNAPSHOT_DETAIL] (读取详细设计快照)
   - 获取B、C端fullpicture章节的内容
   - **必须显性调用** Figma MCP 获取设计稿内容：页面需求页面 (@https://www.figma.com/design/EsRhGXGgTpdRMhG05JNWEO/Untitled?node-id=30-296&m=dev)

3. **内容整合逻辑**:
   - 从 [CURRENT_SNAPSHOT_ANALYSIS] 提取全部内容
   - 从 [CURRENT_SNAPSHOT_DETAIL] 提取: B端fullpicture、C端fullpicture、API规划、埋点方案
   - **内容不做任何修改**，原样保留所有结构、格式和Mermaid图表

4. **生成overview.html**:
   - 仅包含项目概览部分，用于快速预览
   - 输出路径: `/AIPM/{project_name}/output/V{version}/html/overview.html`

5. **生成最终整合PRD文档**:
   - 单文件整合全部内容: 概览 + B端需求 + C端需求 + 技术要求
   - 文件命名: `PRD_V{version}_{date}.html`
   - 输出路径: `/AIPM/{project_name}/output/V{version}/html/`
   - 所有内容直接按章节顺序填充，保持原始结构

6. **CONTEXT_WRITE**: [CURRENT_SNAPSHOT_WRITING] (将最终PRD文档路径和内容写入上下文快照标签)

7. **输出交付物**:
   - 展示生成的PRD文档路径: `/AIPM/{project_name}/output/V{version}/html/PRD_V{version}_{date}.html`
   - 提醒用户查看完整的PRD文档

8. **用户确认**:
   - **【等待用户确认】**：询问用户："以上是根据前面所有节点产出物整合而成的完整PRD文档，包含了需求概述、页面需求设计等内容。请查看并确认是否满足您的要求？如需调整，请告知具体修改意见；若无误，请回复'确认'。"
   - 情形A：用户回复"确认" → 结束节点，完成整个AIPM流程
   - 情形B：用户提出修改 → 返回详细设计节点进行迭代调整

## HTML模板规范

### 基础模板结构
- 遵循Figma设计稿UI风格
- 支持Mermaid图表渲染
- 响应式布局适配不同屏幕尺寸
- 清晰的导航结构，方便阅读

### 内容填充规则
1. **概览章节**: 从ANALYSIS快照提取背景、目标、边界、用户角色、页面清单、业务流程
2. **B端需求章节**: 原样保留DETAIL快照中B端fullpicture的Markdown结构和Mermaid图表
3. **C端需求章节**: 原样保留DETAIL快照中C端fullpicture的Markdown结构和Mermaid图表
4. **技术要求章节**: 从DETAIL快照提取API规划、埋点方案

### 输出文件结构
```
/AIPM/{project_name}/output/V{version}/
└── html/
    ├── overview.html                 # 项目概览文档
    └── PRD_V{version}_{date}.html    # 完整PRD文档
```

## 用户确认环节 【等待用户确认】

询问用户：以上是根据前面所有节点产出物整合而成的完整PRD文档，包含了需求概述、页面需求设计等内容。请查看并确认是否满足您的要求？如需调整，请告知具体修改意见；若无误，请回复'确认'。

**🛑 强制暂停：在此处必须停止输出！等待用户回复同意后，才能进入下一个节点或结束流程。**
