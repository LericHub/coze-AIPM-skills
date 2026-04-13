import re
import os

# Fix PRD_index.html -> index.html in 01-router.md
router_path = "product_manager/nodes/01-router.md"
with open(router_path, "r", encoding="utf-8") as f:
    content = f.read()

content = content.replace("PRD_index.html", "index.html")

with open(router_path, "w", encoding="utf-8") as f:
    f.write(content)

# Mark tasks as completed
tasks_path = "openspec/changes/implement-node07-figma-pages/tasks.md"
with open(tasks_path, "r", encoding="utf-8") as f:
    tasks_content = f.read()

tasks_content = tasks_content.replace("- [ ]", "- [x]")

with open(tasks_path, "w", encoding="utf-8") as f:
    f.write(tasks_content)

