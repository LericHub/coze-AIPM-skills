#!/bin/bash

# AIPM Project Initialization Script
# Creates the standard directory structure for a new project

PROJECT_NAME=$1
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
VERSION="V1.0"
DATE=$(date +%Y%m%d)

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
mkdir -p "output/$VERSION"

# 创建核心状态文件
touch "Memory.md"

# 创建输出目录下的文件结构
mkdir -p "output/$VERSION/"
touch "output/$VERSION/PREPRD_${VERSION}_${DATE}.md"
touch "output/$VERSION/Pr0totye_${VERSION}_${DATE}.html"
touch "output/$VERSION/PRD_${VERSION}_${DATE}.html"

echo "项目 $PROJECT_NAME 目录结构创建完成"