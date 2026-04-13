#!/bin/bash

# AIPM Project Initialization Script
# Creates the standard directory structure for a new project

# 从命令行参数获取项目名称
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

# 生成日期时间后缀 (格式: YYYYMMDD_HHMMSS)
DATETIME=$(date +%Y%m%d_%H%M%S)

# 完整的项目目录名 = 项目名_日期时间
FULL_PROJECT_NAME="${PROJECT_NAME}_${DATETIME}"

# 创建 AIPM 根目录（如果不存在）
mkdir -p "/AIPM"

# 创建项目主目录
mkdir -p "/AIPM/${FULL_PROJECT_NAME}"

# 创建 Memory.md 文件，用于存储项目状态
cat << EOF > "/AIPM/${FULL_PROJECT_NAME}/Memory.md"
{
  "project_name": "$PROJECT_NAME",
  "project_directory": "${FULL_PROJECT_NAME}",
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
mkdir -p "/AIPM/${FULL_PROJECT_NAME}/draft"

# 创建 output 目录结构
mkdir -p "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/doc/app"
mkdir -p "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/doc/web"
mkdir -p "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/html/app"
mkdir -p "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/html/web"

# 创建初始版本的占位文件
touch "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/doc/overview.html"
touch "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/html/overview.html"
touch "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/html/PRD_V1.0_${DATETIME}.html"
touch "/AIPM/${FULL_PROJECT_NAME}/output/V1.0/protoIndex_V1.0_${DATETIME}.html"

echo "========================================================================"
echo "✅ Project initialized successfully!"
echo "========================================================================"
echo "📁 Project Name: $PROJECT_NAME"
echo "📁 Project Directory: ${FULL_PROJECT_NAME}"
echo "📁 Full Path: /AIPM/${FULL_PROJECT_NAME}/"
echo "========================================================================"
echo "📋 All projects are organized under /AIPM/ directory"
echo "========================================================================"
