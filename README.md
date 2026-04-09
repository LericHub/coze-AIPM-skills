# AIPM - AI 产品经理助手

一个基于Coze平台构建的全流程产品管理助手，能够将模糊、不完整的需求逐步转化为结构化、可执行的产品需求文档（PRD）。

## 功能特色

✅ 5节点标准流程：需求澄清 → 需求分析 → 详细设计 → 原型制作 → PRD撰写  
✅ 独立变更分析节点 - 增量变更无需整体回退  
✅ 三级用户确认机制  
✅ 完整状态持久化可追溯  
✅ 历史版本永久保留  
✅ 上下文快照管理 - 确保节点间信息传递的一致性  

## 输出目录结构

```
/AIPM/{project_name}/
├── Memory.md                           # [核心] 项目状态与上下文记忆文件
├── draft/                             # [设计区] 放置中间产物、草稿与原型
│       └── PrePRD_V{version}_{date}.md # 初始PRD草稿 (含需求澄清、分析、详细设计)
└── output/                             # [产出区] 最终交付物目录
    └── V{version}_{date}/              # 发布版本目录
        ├── doc/                        # 交付文档目录
        │   ├── PRD_V{version}_{date}.html  # 最终版PRD文档 (HTML格式)
        │   ├── overview.html               # 项目概览文档
        │   ├── web/                        # B端交付文档
        │   │   └── list.html               # B端页面列表与功能说明
        │   └── app/                        # C端交付文档
        │       └── home.html               # C端页面列表与功能说明
        └── html/                       # 交付原型代码目录
            ├── overview.html           # 项目概览页面
            ├── web/                    # B端原型代码
            │   └── list.html           # B端页面代码与交互演示
            └── app/                    # C端原型代码
                └── home.html           # C端页面代码与交互演示
```



## 节点说明

| 节点 | 文件 | 主要职责 | 输入来源 | 产出物 | 输出路径 |
|------|------|----------|----------|--------|----------|
| 需求澄清 | step1_clarify.md | 从7个维度深度挖掘需求背景、目标、边界、用户、场景、竞品、验收标准 | 用户初始需求 | 需求澄清快照 | CURRENT_SNAPSHOT_CLARIFY |
| 需求分析 | step2_analysis.md | 构建PRD骨架，识别用户角色、页面清单、埋点方案 | [CURRENT_SNAPSHOT_CLARIFY] | 初步PRD文档（Markdown格式） | draft/V{version}_{date}/PrePRD_V{version}_{date}.md |
| 详细设计 | step3-detail_design.md | 细化业务流程，绘制Mermaid流程图，定义数据逻辑 | [CURRENT_SNAPSHOT_ANALYSIS] | 详细设计文档（包含业务流程图、页面流程图、事件列表等） | CURRENT_SNAPSHOT_DETAIL |
| 原型制作 | step4_prototyping.md | 生成ASCII线框图和HTML原型页面，可视化展示产品设计 | [CURRENT_SNAPSHOT_DETAIL] | HTML原型代码和索引文件 | output/V{version}/protoIndex_V{version}_{date}.html<br>output/V{version}/html/app/<br>output/V{version}/html/web/ |
| 原型渲染 | step5_prd_writing.md | 整合所有产出，形成完整PRD文档 | [CURRENT_SNAPSHOT_DETAIL], [CURRENT_SNAPSHOT_PROTOTYPING] | 完整PRD文档（HTML格式） | output/V{version}/html/PRD_V{version}_{date}.html<br>output/V{version}/html/overview.html |
| 变更分析 | step6_change_analysis.md | 独立变更节点，评估变更影响，制定回退策略 | [CURRENT_SNAPSHOT_WRITING] | 变更分析报告 | CURRENT_SNAPSHOT_CHANGE |

## 使用方法

```
# 启动新需求
我需要做一个用户注册功能
只做需求澄清就可以了
执行到详细设计阶段

# 提出变更
我想调整一下登录逻辑
需要增加微信登录选项
```

发送任意消息自动恢复上次任务进度。

