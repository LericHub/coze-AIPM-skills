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
NEW_VERSION_FILE="V${VERSION}_${DATE}.md"
NEW_HTML_C_FILE="C端_V${VERSION}_${DATE}.html"
NEW_HTML_B_FILE="B端_V${VERSION}_${DATE}.html"
NEW_HTML_PRD_FILE="PRD_V${VERSION}_${DATE}.html"

# 创建新版本的文档
touch "Prd_md/$NEW_VERSION_FILE"
touch "HTML/$NEW_HTML_C_FILE"
touch "HTML/$NEW_HTML_B_FILE"
touch "HTML/$NEW_HTML_PRD_FILE"

# 更新版本号
echo "{\"version\": $VERSION}" > version.json

echo "已创建新版本文档:"
echo "- Markdown: $NEW_VERSION_FILE"
echo "- C端 HTML: $NEW_HTML_C_FILE"
echo "- B端 HTML: $NEW_HTML_B_FILE"
echo "- PRD HTML: $NEW_HTML_PRD_FILE"
echo "当前版本号: $VERSION"