#!/bin/bash

# AIPM Project Initialization Script
# Creates the standard directory structure for a new project

PROJECT_NAME=$1
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -z "$PROJECT_NAME" ]; then
    echo "错误: 请提供项目名称作为参数"
    echo "用法: $0 <project_name>"
    exit 1
fi

# 创建项目根目录
echo "正在创建项目: $PROJECT_NAME"
mkdir -p "/AIPM/$PROJECT_NAME"

# 进入项目目录
cd "/AIPM/$PROJECT_NAME" || exit

# 创建项目主目录结构
mkdir -p "snapshots"
mkdir -p "Prd_md"
mkdir -p "HTML"
mkdir -p "Assets/images"
mkdir -p "Assets/diagrams"
mkdir -p "Change_Logs"
mkdir -p "Conversation_Logs"

# 创建核心状态文件
touch "Memory.md"
touch "Memory.bak.${TIMESTAMP}.md"

# 创建占位文件
touch "snapshots/CLARIFY_${TIMESTAMP}.md"
touch "snapshots/ANALYSIS_${TIMESTAMP}.md"
touch "snapshots/DETAIL_${TIMESTAMP}.md"
touch "snapshots/WRITING_${TIMESTAMP}.md"
touch "Change_Logs/change_$(date +%Y%m%d).md"
touch "Conversation_Logs/log_$(date +%Y%m%d).md"

# 初始化版本号为1
echo '{"version": 1}' > version.json

echo "项目 $PROJECT_NAME 目录结构创建完成"