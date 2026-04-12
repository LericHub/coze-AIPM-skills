---
name: tdesign-mcp-skill
description: Wraps tdesign-mcp-server as an OpenCode skill for TDesign component recommendations. Analyzes mock data structure and suggests appropriate TDesign components.
license: MIT
compatibility: Requires Node.js and npx
metadata:
  author: aipm-skill
  version: "1.0"
  generatedBy: "1.2.0"
---

# Skill: TDesign MCP Skill

This skill wraps the tdesign-mcp-server as an OpenCode skill for component recommendations.

---

## Usage

When invoked, this skill:
1. Runs tdesign-mcp-server via npx
2. Analyzes mock data structure provided after data generation
3. Returns recommended TDesign components based on data types and patterns

## Integration

This skill is used in the prototyping workflow:
1. Load after mock data generation
2. Provide component recommendations based on data structure
3. Merge with design reference skill for final style/component decisions

## MCP Configuration

The skill uses the following MCP configuration from `mcp.json`:

```json
{
  "mcpServers": {
    "tdesign-mcp-server": {
      "command": "npx",
      "args": ["-y", "tdesign-mcp-server"]
    }
  }
}
```

## Component Suggestion Logic

The skill analyzes mock data to suggest components:
- **Array data with multiple fields** → Table, DataTable, or List
- **Key-value pairs** → Form, Input, or Descriptions
- **Hierarchical data** → Tree, TreeSelect, or Cascader
- **Date/time fields** → DatePicker, TimePicker, or Calendar
- **Boolean flags** → Switch, Checkbox, or Radio
- **Numeric data** → InputNumber, Slider, or Rate
- **Text content** → Input, Textarea, or RichText
- **Selection lists** → Select, TreeSelect, or Transfer
