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
DIRECTORIES=("snapshots" "Prd_md" "HTML" "Assets/images" "Assets/diagrams" "Change_Logs" "Conversation_Logs")
for dir in "${DIRECTORIES[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "创建缺失目录: $dir"
        mkdir -p "$dir"
    fi
done

# 检查并创建缺失的基础文件
FILES_TO_CHECK=(
    "Change_Logs/change_$(date +%Y%m%d).md"
    "Conversation_Logs/log_$(date +%Y%m%d).md"
)

for file in "${FILES_TO_CHECK[@]}"; do
    if [ ! -f "$file" ]; then
        echo "创建缺失文件: $file"
        touch "$file"
    fi
done

# 检查版本文件是否存在，如果不存在则创建默认版本
if [ ! -f "version.json" ]; then
    echo '{"version": 1}' > version.json
    echo "创建默认版本文件: version.json"
fi

echo "项目 $PROJECT_NAME 目录结构验证完成"