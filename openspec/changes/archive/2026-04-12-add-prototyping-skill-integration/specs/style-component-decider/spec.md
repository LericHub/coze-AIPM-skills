## ADDED Requirements

### Requirement: System determines page style and components after mock data generation
After mock data generation completes, the system SHALL automatically invoke design skills to determine page style and component selection.

#### Scenario: Invoke design skills after mock generation
- **WHEN** mock data generation completes
- **THEN** the system SHALL invoke both the design reference skill and TDesign MCP skill to gather recommendations

#### Scenario: Merge skill recommendations
- **WHEN** both skills return recommendations
- **THEN** the system SHALL merge results, prioritizing TDesign components for UI elements while respecting design guidelines for styling
