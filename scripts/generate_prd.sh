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
node "$SCRIPT_DIR/md2html.js" \
    "$PROJECT_PATH/snapshots/overview.md" \
    "$OUTPUT_DIR/html/overview.html" \
    "$SCRIPT_DIR/../templates/overview.html"

# Step 2: Generate final combined PRD
echo "Generating final PRD document..."
FINAL_PRD="$OUTPUT_DIR/html/PRD_V${VERSION}_${DATE}.html"
node "$SCRIPT_DIR/md2html.js" \
    "$PROJECT_PATH/snapshots/full_prd.md" \
    "$FINAL_PRD" \
    "$SCRIPT_DIR/../templates/prd_full.html"

echo "PRD Generation complete:"
echo "  Overview: $OUTPUT_DIR/html/overview.html"
echo "  Full PRD: $FINAL_PRD"
