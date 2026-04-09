#!/bin/bash

# AIPM Project Validation Script
# Validates the directory structure of an existing project and restores missing components

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo "错误: 请提供项目名称作为参数"
    echo "用法: $0 <project_name>"
    exit 1
fi

PROJECT_PATH="/AIPM/$PROJECT_NAME"

# 检查项目目录是否存在
if [ ! -d "$PROJECT_PATH" ]; then
    echo "错误: 项目目录 $PROJECT_PATH 不存在"
    exit 1
fi

# 进入项目目录
cd "$PROJECT_PATH" || exit

# 验证必需文件
REQUIRED_FILES=("Memory.md")
for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "错误: 缺少必需文件 $file"
        exit 1
    fi
done

# 检查并创建缺失的目录
VERSION="V1.0"
DATE=$(date +%Y%m%d)
mkdir -p "draft/"
mkdir -p "output/$VERSION"

# 检查并创建缺失的基础目录
mkdir -p "draft/V${VERSION}_${DATE}/"
mkdir -p "output/$VERSION/doc/"
mkdir -p "output/$VERSION/doc/web/"
mkdir -p "output/$VERSION/doc/app/"
mkdir -p "output/$VERSION/html/"
mkdir -p "output/$VERSION/html/web/"
mkdir -p "output/$VERSION/html/app/"

# 检查并创建缺失的基础文件
FILES_TO_CHECK=(
    "draft/V${VERSION}_${DATE}/PrePRD_V${VERSION}_${DATE}.md"
    "output/$VERSION/doc/overview.html"
    "output/$VERSION/doc/web/list.html"
    "output/$VERSION/doc/app/home.html"
    "output/$VERSION/html/overview.html"
    "output/$VERSION/html/web/list.html"
    "output/$VERSION/html/app/home.html"
    "output/$VERSION/protoIndex_V${VERSION}_${DATE}.html"
    "output/$VERSION/html/PRD_V${VERSION}_${DATE}.html"
)

for file in "${FILES_TO_CHECK[@]}"; do
    if [ ! -f "$file" ]; then
        echo "创建缺失文件: $file"
        mkdir -p "$(dirname "$file")"
        touch "$file"
    fi
done

echo "项目 $PROJECT_NAME 目录结构验证完成"