## 1. Setup

- [x] 1.1 Create design reference skill directory at .opencode/skills/prototyping-design-reference
- [x] 1.2 Copy uber_design.md to skill directory as reference resource
- [x] 1.3 Create MCP configuration file (mcp.json) with tdesign-mcp-server

## 2. Create TDesign MCP Skill

- [x] 2.1 Create .opencode/skills/tdesign-mcp-skill directory
- [x] 2.2 Create SKILL.md with TDesign MCP integration instructions
- [x] 2.3 Add skill metadata to skill definition

## 3. Integrate Skills into Prototyping Workflow

- [x] 3.1 Modify prototyping node to load design reference skill after initialization
- [x] 3.2 Add skill invocation logic after mock data generation
- [x] 3.3 Implement two-skill workflow (design reference + TDesign MCP)
- [x] 3.4 Add result merging logic for style and component decisions

## 4. Testing

- [x] 4.1 Test design reference skill loads correctly
- [x] 4.2 Test TDesign MCP skill provides component suggestions
- [x] 4.3 Test full workflow produces correct style/component output
