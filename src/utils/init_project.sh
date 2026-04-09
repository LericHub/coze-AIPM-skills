#!/bin/bash

# AIPM Project Initialization Script
# Creates the standard directory structure for a new project

# 从命令行参数获取项目名称
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

# 创建项目主目录
mkdir -p "/AIPM/$PROJECT_NAME"

# 创建 Memory.md 文件，用于存储项目状态
cat << EOF > "/AIPM/$PROJECT_NAME/Memory.md"
{
  "project_name": "$PROJECT_NAME",
  "created_at": "$(date)",
  "updated_at": "$(date)",
  "node_list": [
    {"node_name": "CLARIFY", "order": 0, "is_confirmed": false, "completed_at": null},
    {"node_name": "ANALYSIS", "order": 1, "is_confirmed": false, "completed_at": null},
    {"node_name": "DETAIL", "order": 2, "is_confirmed": false, "completed_at": null},
    {"node_name": "PROTOTYPING", "order": 3, "is_confirmed": false, "completed_at": null},
    {"node_name": "WRITING", "order": 4, "is_confirmed": false, "completed_at": null}
  ],
  "current_node": "CLARIFY",
  "current_node_status": "INIT",
  "end_node": "WRITING",
  "change_history": [],
  "conversation_log": [],
  "version": 1
}
EOF

# 创建 draft 目录
mkdir -p "/AIPM/$PROJECT_NAME/draft"

# 创建 output 目录结构
mkdir -p "/AIPM/$PROJECT_NAME/output/V1.0/doc/app"
mkdir -p "/AIPM/$PROJECT_NAME/output/V1.0/doc/web"
mkdir -p "/AIPM/$PROJECT_NAME/output/V1.0/html/app"
mkdir -p "/AIPM/$PROJECT_NAME/output/V1.0/html/web"

# 创建初始版本的占位文件
touch "/AIPM/$PROJECT_NAME/output/V1.0/doc/overview.html"
touch "/AIPM/$PROJECT_NAME/output/V1.0/html/overview.html"
touch "/AIPM/$PROJECT_NAME/output/V1.0/html/PRD_V1.0_$(date +%Y%m%d).html"
touch "/AIPM/$PROJECT_NAME/output/V1.0/protoIndex_V1.0_$(date +%Y%m%d).html"

echo "Project $PROJECT_NAME initialized successfully!"
echo "Directory structure created under /AIPM/$PROJECT_NAME/"