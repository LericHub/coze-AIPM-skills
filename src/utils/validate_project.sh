#!/bin/bash

# AIPM Project Validation Script
# Validates the directory structure of an existing project and restores missing components

# 从命令行参数获取项目名称
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

PROJECT_PATH="/AIPM/$PROJECT_NAME"

if [ ! -d "$PROJECT_PATH" ]; then
  echo "Project $PROJECT_NAME does not exist."
  exit 1
fi

# 检查必要的目录和文件
MISSING_COMPONENTS=()

if [ ! -f "$PROJECT_PATH/Memory.md" ]; then
  MISSING_COMPONENTS+=("Memory.md")
fi

if [ ! -d "$PROJECT_PATH/draft" ]; then
  MISSING_COMPONENTS+=("draft/")
fi

if [ ! -d "$PROJECT_PATH/output" ]; then
  MISSING_COMPONENTS+=("output/")
else
  if [ ! -d "$PROJECT_PATH/output/V1.0/doc/app" ]; then
    MISSING_COMPONENTS+=("output/V1.0/doc/app/")
  fi
  if [ ! -d "$PROJECT_PATH/output/V1.0/doc/web" ]; then
    MISSING_COMPONENTS+=("output/V1.0/doc/web/")
  fi
  if [ ! -d "$PROJECT_PATH/output/V1.0/html/app" ]; then
    MISSING_COMPONENTS+=("output/V1.0/html/app/")
  fi
  if [ ! -d "$PROJECT_PATH/output/V1.0/html/web" ]; then
    MISSING_COMPONENTS+=("output/V1.0/html/web/")
  fi
fi

# 如果有任何缺失组件，创建它们
if [ ${#MISSING_COMPONENTS[@]} -ne 0 ]; then
  echo "Found missing components:"
  for component in "${MISSING_COMPONENTS[@]}"; do
    echo "  - $component"
  done
  
  echo "Creating missing components..."
  
  # 创建缺失的文件和目录
  if [[ " ${MISSING_COMPONENTS[@]} " =~ " Memory.md " ]]; then
    cat << EOF > "$PROJECT_PATH/Memory.md"
{
  "project_name": "$PROJECT_NAME",
  "created_at": "$(date)",
  "updated_at": "$(date)",
  "node_list": [
    {"node_name": "CLARIFY", "order": 0, "is_confirmed": false, "completed_at": null},
    {"node_name": "ANALYSIS", "order": 1, "is_confirmed": false, "completed_at": null},
    {"node_name": "DETAIL", "order": 2, "is_confirmed": false, "completed_at": null},
    {"node_name": "PROTOTYPING", "order": 3, "is_confirmed": false, "completed_at": null},
    {"node_name": "WRITING", "order": 4, "is_confirmed": false, "completed_at": null}
  ],
  "current_node": "CLARIFY",
  "current_node_status": "INIT",
  "end_node": "WRITING",
  "change_history": [],
  "conversation_log": [],
  "version": 1
}
EOF
  fi
  
  if [[ " ${MISSING_COMPONENTS[@]} " =~ " draft/ " ]]; then
    mkdir -p "$PROJECT_PATH/draft"
  fi
  
  if [[ " ${MISSING_COMPONENTS[@]} " =~ " output/V1.0/doc/app/ " ]]; then
    mkdir -p "$PROJECT_PATH/output/V1.0/doc/app"
  fi
  
  if [[ " ${MISSING_COMPONENTS[@]} " =~ " output/V1.0/doc/web/ " ]]; then
    mkdir -p "$PROJECT_PATH/output/V1.0/doc/web"
  fi
  
  if [[ " ${MISSING_COMPONENTS[@]} " =~ " output/V1.0/html/app/ " ]]; then
    mkdir -p "$PROJECT_PATH/output/V1.0/html/app"
  fi
  
  if [[ " ${MISSING_COMPONENTS[@]} " =~ " output/V1.0/html/web/ " ]]; then
    mkdir -p "$PROJECT_PATH/output/V1.0/html/web"
  fi
fi

echo "Project $PROJECT_NAME validated successfully!"
echo "All required directories and files are present."