## Context

当前 node7 (writing) 读取原型时假设目录结构为:
```
prototyping/
├── app/
│   └── *.html
└── web/
    └── *.html
```

但 node6 (prototyping) 实际输出为平铺结构:
```
prototyping/
├── proto_index.html
└── page_*.html
```

## Goals / Non-Goals

**Goals:**
- 修复 node7 无法读取 node6 原型的问题
- 兼容现有平铺输出结构

**Non-Goals:**
- 不修改 node6 的输出结构（保持现状）
- 不添加新的原型生成能力

## Decisions

### D1: 扫描平铺目录，从 detail 文件获取端信息

**选择**: 不依赖 app/web 子目录，直接扫描平铺目录获取全部原型文件，然后通过 detail 文件中记录的页面端信息来区分 C端/B端。

**原因**: detail 文件的页面列表已包含端信息（哪页是 app，哪页是 web），可以直接复用。

### D2: 兼容方案

修改 07-writing.md 的 Step 3：

| 原方案 | 新方案 |
|--------|--------|
| 扫描 app/web 子目录 | 扫描平铺目录全部 *.html |
| 从子目录判断端 | 从 detail 文件匹配页面的端属性 |

## Risks / Trade-offs

- **Risk**: 如果 detail 文件的端信息不完整，可能无法完全匹配
- **Mitigation**: 先从 detail 读取完整页面列表，如果匹配失败，记录警告但不阻塞流程