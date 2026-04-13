#!/bin/bash

# AIPM Version Increment Script
# Creates new versioned documents when content is edited

# 从命令行参数获取项目名称
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

PROJECT_PATH="/AIPM/$PROJECT_NAME"

if [ ! -f "$PROJECT_PATH/Memory.md" ]; then
  echo "Project $PROJECT_NAME Memory.md file not found."
  exit 1
fi

# 读取当前版本号
CURRENT_VERSION=$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ')
if [ -z "$CURRENT_VERSION" ]; then
    CURRENT_VERSION=0
fi
NEW_VERSION=$((CURRENT_VERSION + 1))

# 更新Memory.md中的版本号
sed -i.bak "s/\"version\":[[:space:]]*[0-9]*/\"version\": $NEW_VERSION/" "$PROJECT_PATH/Memory.md"
# 清理备份文件
rm -f "$PROJECT_PATH/Memory.md.bak"

# 创建新版本的目录结构
mkdir -p "$PROJECT_PATH/output/V$NEW_VERSION.0/doc/app"
mkdir -p "$PROJECT_PATH/output/V$NEW_VERSION.0/doc/web"
mkdir -p "$PROJECT_PATH/output/V$NEW_VERSION.0/html/app"
mkdir -p "$PROJECT_PATH/output/V$NEW_VERSION.0/html/web"

DATE=$(date +%Y%m%d)

# 创建新版本的占位文件
touch "$PROJECT_PATH/output/V$NEW_VERSION.0/doc/overview.html"
touch "$PROJECT_PATH/output/V$NEW_VERSION.0/html/overview.html"
touch "$PROJECT_PATH/output/V$NEW_VERSION.0/html/PRD_V${NEW_VERSION}.0_${DATE}.html"
touch "$PROJECT_PATH/output/V$NEW_VERSION.0/protoIndex_V${NEW_VERSION}.0_${DATE}.html"

echo "Version incremented from $CURRENT_VERSION to $NEW_VERSION for project $PROJECT_NAME"
echo "New version directory created: $PROJECT_PATH/output/V$NEW_VERSION.0/"