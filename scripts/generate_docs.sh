#!/bin/bash

# AIPM Document Generation Script
# Generates new versioned documents during various workflow stages

PROJECT_NAME=$1
ACTION=${2:-"increment"}  # 默认动作为递增版本

if [ -z "$PROJECT_NAME" ]; then
    echo "错误: 请提供项目名称作为参数"
    echo "用法: $0 <project_name> [action]"
    echo "可用动作: increment, update, refresh"
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

# 函数：获取并递增版本号
get_next_version() {
    if [ -f "version.json" ]; then
        # 获取当前版本号
        VERSION=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1/p' version.json 2>/dev/null)
        if [ -z "$VERSION" ]; then
            VERSION=1
        else
            ((VERSION++))
        fi
    else
        VERSION=1
    fi
    echo $VERSION
}

# 函数：创建新版本的文档
create_versioned_docs() {
    local version=$1
    local date=$(date +%Y%m%d)
    local version_dir="output/V${version}.0"
    local draft_dir="draft/V${version}.0_${date}"
    
    # 定义文档文件名
    NEW_MD_FILE="$draft_dir/PrePRD_V${version}.0_${date}.md"
    NEW_HTML_PROTO_FILE="$version_dir/protoIndex_V${version}.0_${date}.html"
    NEW_HTML_PRD_FILE="$version_dir/html/PRD_V${version}.0_${date}.html"
    
    # 创建文档目录（如果不存在）
    mkdir -p "$version_dir"
    mkdir -p "$draft_dir"
    
    # 创建新版本的文档
    if [ ! -f "$NEW_MD_FILE" ]; then
        touch "$NEW_MD_FILE"
        echo "# 产品需求文档 V${version}.0" > "$NEW_MD_FILE"
        echo "" >> "$NEW_MD_FILE"
        echo "生成时间: $(date)" >> "$NEW_MD_FILE"
    fi
    
    if [ ! -f "$NEW_HTML_PROTO_FILE" ]; then
        touch "$NEW_HTML_PROTO_FILE"
        cat > "$NEW_HTML_PROTO_FILE" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>页面原型 V${version}.0</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
    <h1>页面原型 V${version}.0</h1>
    <p>生成时间: $(date)</p>
</body>
</html>
EOF
    fi
    
    if [ ! -f "$NEW_HTML_PRD_FILE" ]; then
        touch "$NEW_HTML_PRD_FILE"
        cat > "$NEW_HTML_PRD_FILE" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>产品需求文档 V${version}.0</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
    <h1>产品需求文档 V${version}.0</h1>
    <p>生成时间: $(date)</p>
</body>
</html>
EOF
    fi
    
    # 更新版本号
    echo "{\"version\": $version}" > version.json
    
    echo "已创建新版本文档:"
    echo "- Markdown PREPRD: $NEW_MD_FILE"
    echo "- HTML 原型: $NEW_HTML_PROTO_FILE"
    echo "- HTML PRD: $NEW_HTML_PRD_FILE"
    echo "当前版本号: $version"
}

# 根据动作执行相应操作
case $ACTION in
    "increment"|"update"|"refresh")
        NEXT_VERSION=$(get_next_version)
        create_versioned_docs $NEXT_VERSION
        ;;
    "prd")
        # Generate complete PRD document
        if [ -z "$3" ]; then
            echo "错误: 请提供版本号用于生成PRD"
            echo "用法: $0 <project_name> prd <version>"
            exit 1
        fi
        VERSION=$3
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        "$SCRIPT_DIR/generate_prd.sh" "$PROJECT_NAME" "$VERSION"
        ;;
    *)
        echo "错误: 未知的动作 '$ACTION'"
        echo "可用动作: increment, update, refresh, prd"
        exit 1
        ;;
esac