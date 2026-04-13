#!/bin/bash

# 从命令行参数获取项目名称和操作类型
PROJECT_NAME=$1
ACTION=${2:-"increment"}

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project_name> [action]"
  echo "Actions: increment, update, refresh, prd"
  exit 1
fi

PROJECT_PATH="/AIPM/$PROJECT_NAME"

if [ ! -d "$PROJECT_PATH" ]; then
  echo "Project $PROJECT_NAME does not exist."
  exit 1
fi

case $ACTION in
  "increment")
    echo "Incrementing version for project $PROJECT_NAME"
    ./increment_version.sh "$PROJECT_NAME"
    ;;
  "update")
    echo "Updating documents for project $PROJECT_NAME"
    # 更新当前版本的文档
    CURRENT_DIR="$PROJECT_PATH/output/V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ' ).0"
    if [ -d "$CURRENT_DIR" ]; then
      touch "$CURRENT_DIR/doc/overview.html"
      touch "$CURRENT_DIR/html/overview.html"
      touch "$CURRENT_DIR/html/PRD_V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ') .0_$(date +%Y%m%d).html"
      touch "$CURRENT_DIR/protoIndex_V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ') .0_$(date +%Y%m%d).html"
      echo "Documents updated in $CURRENT_DIR"
    else
      echo "Current version directory does not exist"
      exit 1
    fi
    ;;
  "refresh")
    echo "Refreshing document links for project $PROJECT_NAME"
    # 重新生成当前版本的文档链接和索引
    CURRENT_DIR="$PROJECT_PATH/output/V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ' ).0"
    if [ -d "$CURRENT_DIR" ]; then
      # 创建或更新索引文件
      INDEX_FILE="$CURRENT_DIR/index.html"
      cat << EOF > "$INDEX_FILE"
<!DOCTYPE html>
<html>
<head>
  <title>Project $PROJECT_NAME Documents Index</title>
</head>
<body>
  <h1>Project $PROJECT_NAME Documents</h1>
  <ul>
    <li><a href="html/overview.html">Overview Document</a></li>
    <li><a href="html/PRD_V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ') .0_$(date +%Y%m%d).html">Full PRD Document</a></li>
    <li><a href="protoIndex_V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ') .0_$(date +%Y%m%d).html">Prototype Index</a></li>
  </ul>
</body>
</html>
EOF
      echo "Index file refreshed at $INDEX_FILE"
    else
      echo "Current version directory does not exist"
      exit 1
    fi
    ;;
  "prd")
    echo "Generating PRD for project $PROJECT_NAME"
    # 生成PRD文档
    CURRENT_DIR="$PROJECT_PATH/output/V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ' ).0"
    if [ -d "$CURRENT_DIR" ]; then
      PRD_FILE="$CURRENT_DIR/html/PRD_V$(grep -o '"version":[[:space:]]*[0-9]*' "$PROJECT_PATH/Memory.md" | cut -d: -f2 | tr -d ' ') .0_$(date +%Y%m%d).html"
      touch "$PRD_FILE"
      echo "PRD document generated at $PRD_FILE"
    else
      echo "Current version directory does not exist"
      exit 1
    fi
    ;;
  *)
    echo "Unknown action: $ACTION"
    echo "Available actions: increment, update, refresh, prd"
    exit 1
    ;;
esac

echo "Action $ACTION completed for project $PROJECT_NAME"