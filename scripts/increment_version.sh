#!/bin/bash

# AIPM Version Increment Script
# Creates new versioned documents when content is edited

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

# 读取当前版本号并递增
if [ -f "version.json" ]; then
    # 获取当前版本号
    VERSION=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1/p' version.json)
    if [ -z "$VERSION" ]; then
        VERSION=1
    else
        ((VERSION++))
    fi
else
    VERSION=1
fi

DATE=$(date +%Y%m%d)
VERSION_DIR="output/V${VERSION}.0"

# 创建新版本的目录
mkdir -p "$VERSION_DIR"
mkdir -p "draft/V${VERSION}.0_${DATE}"

# 创建新版本的文档
touch "draft/V${VERSION}.0_${DATE}/PrePRD_V${VERSION}.0_${DATE}.md"
touch "$VERSION_DIR/protoIndex_V${VERSION}.0_${DATE}.html"
touch "$VERSION_DIR/html/PRD_V${VERSION}.0_${DATE}.html"

# 更新版本号
echo "{\"version\": $VERSION}" > version.json

echo "已创建新版本文档:"
echo "- Markdown PREPRD: draft/V${VERSION}.0_${DATE}/PrePRD_V${VERSION}.0_${DATE}.md"
echo "- 原型 HTML: $VERSION_DIR/protoIndex_V${VERSION}.0_${DATE}.html"
echo "- PRD HTML: $VERSION_DIR/html/PRD_V${VERSION}.0_${DATE}.html"
echo "当前版本号: $VERSION"