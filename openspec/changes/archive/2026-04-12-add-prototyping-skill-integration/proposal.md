## Why

The current prototyping workflow lacks integration with design system references and MCP-based component libraries. We need to: 1) reference existing design documents in the prototyping node, 2) wrap tdesign-mcp-server as a skill, and 3) automatically determine page style and components using these skills after mock data generation.

## What Changes

- Add design system reference capability to prototyping node (uber_design.md)
- Create skill wrapper for tdesign-mcp-server in the current project
- Add skill-based style/component decision step after mock data generation
- Integrate two skills (design reference + TDesign MCP) into prototyping workflow

## Capabilities

### New Capabilities
- `prototyping-design-reference`: Reference design system documents in prototyping node
- `tdesign-mcp-skill`: Package tdesign-mcp-server as an OpenCode skill
- `style-component-decider`: Use skills to determine page style and components after mock data

### Modified Capabilities
- None

## Impact

- New skill files in `.opencode/skills/` directory
- Modified prototyping workflow to include skill-based design decisions
- MCP configuration added to project
