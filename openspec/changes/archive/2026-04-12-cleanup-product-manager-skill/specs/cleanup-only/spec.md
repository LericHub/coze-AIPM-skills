## ADDED Requirements

### Requirement: SKILL.md reference cleanup
The product_manager SKILL.md file SHALL have all references updated to point to existing files after cleanup is complete.

#### Scenario: STATE_RULES reference updated
- **WHEN** cleanup completes
- **THEN** SKILL.md no longer references STATE_RULES.md

#### Scenario: Node references fixed
- **WHEN** cleanup completes  
- **THEN** SKILL.md node references match actual file names

#### Scenario: Duplicate content removed
- **WHEN** cleanup completes
- **THEN** forced actions section appears only once in SKILL.md