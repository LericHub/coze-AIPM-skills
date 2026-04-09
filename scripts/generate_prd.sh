#!/bin/bash

# PRD Generation Script
# Generates PRD documents from snapshot content

PROJECT_NAME=$1
VERSION=$2

if [ -z "$PROJECT_NAME" ] || [ -z "$VERSION" ]; then
    echo "Usage: $0 <project_name> <version>"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_PATH="/AIPM/$PROJECT_NAME"
OUTPUT_DIR="$PROJECT_PATH/output/V${VERSION}"
DATE=$(date +%Y%m%d)

mkdir -p "$OUTPUT_DIR/html"

echo "Generating PRD for $PROJECT_NAME V$VERSION"

# Step 1: Generate overview.html
echo "Generating overview.html..."
if [ -f "$PROJECT_PATH/CURRENT_SNAPSHOT_DETAIL.md" ]; then
    node "$SCRIPT_DIR/md2html.js" \
        "$PROJECT_PATH/CURRENT_SNAPSHOT_DETAIL.md" \
        "$OUTPUT_DIR/html/overview.html" \
        "$SCRIPT_DIR/../templates/overview.html"
else
    echo "Warning: Snapshot file not found, using template."
    cp "$SCRIPT_DIR/../templates/overview.html" "$OUTPUT_DIR/html/overview.html"
fi

# Step 2: Generate final combined PRD
echo "Generating final PRD document..."
FINAL_PRD="$OUTPUT_DIR/html/PRD_V${VERSION}_${DATE}.html"
if [ -f "$PROJECT_PATH/CURRENT_SNAPSHOT_WRITING.md" ]; then
    node "$SCRIPT_DIR/md2html.js" \
        "$PROJECT_PATH/CURRENT_SNAPSHOT_WRITING.md" \
        "$FINAL_PRD" \
        "$SCRIPT_DIR/../templates/prd_template.html"
else
    echo "Warning: Writing snapshot file not found, using template."
    cp "$SCRIPT_DIR/../templates/prd_template.html" "$FINAL_PRD"
fi

echo "PRD Generation complete:"
echo "  Overview: $OUTPUT_DIR/html/overview.html"
echo "  Full PRD: $FINAL_PRD"