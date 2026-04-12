## ADDED Requirements

### Requirement: TDesign MCP server can be used as a skill
The system SHALL wrap tdesign-mcp-server as an OpenCode skill that provides component recommendations based on mock data structure.

#### Scenario: Initialize TDesign MCP skill
- **WHEN** the TDesign MCP skill is invoked
- **THEN** the skill SHALL provide access to TDesign component library for suggestions

#### Scenario: Get component suggestions from mock data
- **WHEN** mock data is provided to the skill after data generation
- **THEN** the skill SHALL analyze the data structure and recommend appropriate TDesign components
