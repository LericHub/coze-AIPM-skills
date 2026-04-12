## Context

The product manager system needs to enhance the prototyping node with design system integration and MCP-based component selection. Current state:
- Prototyping node generates mock data but lacks design guidance
- No skill wrapper exists for tdesign-mcp-server
- No automated way to determine page style and components after mock data generation

## Goals / Non-Goals

**Goals:**
- Integrate uber_design.md reference into prototyping node workflow
- Create tdesign-mcp-server skill wrapper
- Add skill-based style/component decision step after mock generation
- Enable two-skill workflow (design reference + TDesign MCP) for prototyping

**Non-Goals:**
- Modify existing spec generation workflow
- Add new MCP servers beyond tdesign
- Change mock data generation logic

## Decisions

1. **Skill-based design reference** - Use existing skill infrastructure to wrap design reference, allowing prototyping node to load uber_design.md as a skill resource.

2. **TDesign MCP as skill** - Package tdesign-mcp-server configuration as a skill that can be invoked to get component suggestions based on mock data structure.

3. **Two-skill workflow** - After mock data generation, invoke both skills:
   - Design reference skill → provides visual/style guidelines
   - TDesign MCP skill → provides component recommendations
   - Merge results to determine final page style and components

4. **Configuration-based MCP** - Store MCP configuration in project root (mcp.json or similar) and load it when invoking the TDesign skill.

## Risks / Trade-offs

- [Risk] Skills may return conflicting recommendations → Mitigation: Use priority ordering (TDesign components override design guidelines for specific elements)
- [Risk] MCP server not available in all environments → Mitigation: Graceful fallback to default TDesign components if MCP unavailable
