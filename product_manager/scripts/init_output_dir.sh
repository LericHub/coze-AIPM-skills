#!/bin/bash

# AIPM Output Directory Initialization Script
# Creates the output directory structure for a specific version

PROJECT_NAME=$1
VERSION=$2

if [ -z "$PROJECT_NAME" ] || [ -z "$VERSION" ]; then
  echo "Usage: $0 <project_name> <version>"
  echo "Example: $0 my_project V1.0"
  exit 1
fi

# 创建 output 目录结构
mkdir -p "/AIPM/$PROJECT_NAME/output/$VERSION"
mkdir -p "/AIPM/$PROJECT_NAME/output/$VERSION/app"
mkdir -p "/AIPM/$PROJECT_NAME/output/$VERSION/web"
mkdir -p "/AIPM/$PROJECT_NAME/output/$VERSION/html"
mkdir -p "/AIPM/$PROJECT_NAME/output/$VERSION/doc/app"
mkdir -p "/AIPM/$PROJECT_NAME/output/$VERSION/doc/web"

echo "Output directory structure created successfully for $PROJECT_NAME $VERSION"
echo "Directories created under /AIPM/$PROJECT_NAME/output/$VERSION/"
