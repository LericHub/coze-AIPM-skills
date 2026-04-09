#!/bin/bash

# 从命令行参数获取项目名称和版本号
PROJECT_NAME=$1
VERSION=${2:-"latest"}

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project_name> [version]"
  exit 1
fi

PROJECT_PATH="/AIPM/$PROJECT_NAME"

if [ ! -d "$PROJECT_PATH" ]; then
  echo "Project $PROJECT_NAME does not exist."
  exit 1
fi

# 如果版本号是"latest"，则获取Memory.md中的版本号
if [ "$VERSION" == "latest" ]; then
  VERSION_NUM=$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ')
  VERSION="V${VERSION_NUM}.0"
fi

OUTPUT_DIR="$PROJECT_PATH/output/$VERSION"

if [ ! -d "$OUTPUT_DIR" ]; then
  echo "Output directory $OUTPUT_DIR does not exist."
  exit 1
fi

# 从模板生成PRD文档
TEMPLATE_DIR="../../core"
PRD_TEMPLATE="$TEMPLATE_DIR/prd_template.html"
OVERVIEW_TEMPLATE="$TEMPLATE_DIR/overview.html"

# 检查模板是否存在，如果不存在则创建基本的PRD文档
PRD_FILE="$OUTPUT_DIR/html/PRD_${VERSION}_$(date +%Y%m%d).html"
OVERVIEW_FILE="$OUTPUT_DIR/html/overview.html"

# 创建PRD文档
cat << EOF > "$PRD_FILE"
<!DOCTYPE html>
<html>
<head>
  <title>Product Requirements Document - $PROJECT_NAME</title>
  <meta charset="UTF-8">
</head>
<body>
  <h1>Product Requirements Document</h1>
  <h2>Project: $PROJECT_NAME</h2>
  <h3>Version: $VERSION</h3>
  <p>This document contains the complete PRD for the $PROJECT_NAME project.</p>
  <p>Generated on: $(date)</p>
  <section>
    <h3>Snapshot Data Included:</h3>
    <p>CURRENT_SNAPSHOT_ANALYSIS, CURRENT_SNAPSHOT_DETAIL, CURRENT_SNAPSHOT_PROTOTYPING</p>
  </section>
</body>
</html>
EOF

# 创建概览文档
cat << EOF > "$OVERVIEW_FILE"
<!DOCTYPE html>
<html>
<head>
  <title>Project Overview - $PROJECT_NAME</title>
  <meta charset="UTF-8">
</head>
<body>
  <h1>Project Overview</h1>
  <h2>Project: $PROJECT_NAME</h2>
  <h3>Version: $VERSION</h3>
  <p>This document provides an overview of the $PROJECT_NAME project.</p>
  <p>Generated on: $(date)</p>
</body>
</html>
EOF

echo "PRD and overview documents generated for project $PROJECT_NAME, version $VERSION"
echo "PRD: $PRD_FILE"
echo "Overview: $OVERVIEW_FILE"