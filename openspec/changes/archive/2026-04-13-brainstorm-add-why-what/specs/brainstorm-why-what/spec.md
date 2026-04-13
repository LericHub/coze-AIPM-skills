## ADDED Requirements

### Requirement: BRAINSTORM shall prompt for background and pain points

The system SHALL prompt the user with guided questions to collect the background and pain points of the requirement. Questions SHALL be open-ended and non-prescriptive.

#### Scenario: Prompts for background
- **WHEN** entering BRAINSTORM node with initial user input
- **THEN** system SHALL ask: "为什么要做这个？现状有什么问题？"
- **AND** system SHALL allow free-text response

#### Scenario: Prompts for pain points
- **WHEN** user has provided initial background
- **THEN** system SHALL ask follow-up questions to clarify pain points
- **AND** system SHALL use scenario-based probing techniques

### Requirement: BRAINSTORM shall prompt for business objectives

The system SHALL prompt the user to describe the expected outcomes and business value after implementation.

#### Scenario: Prompts for business objectives
- **WHEN** user has described background and pain points
- **THEN** system SHALL ask: "做完后想达到什么效果？"
- **AND** system SHALL allow free-text response

#### Scenario: Encourages quantified goals
- **WHEN** user provides vague objectives
- **THEN** system SHALL encourage quantification without forcing specific formats

### Requirement: BRAINSTORM shall expand user responses through induction

The system SHALL NOT simply pass through user responses verbatim. When user provides answers, the system SHALL generate expanded descriptions based on user input.

#### Scenario: Expands background description
- **WHEN** user provides background and pain points
- **THEN** system SHALL generate an expanded description that:
  - Preserves user-original content
  - Adds contextual understanding
  - Maintains business perspective

#### Scenario: Expands objective description
- **WHEN** user provides business objectives
- **THEN** system SHALL generate an expanded description that:
  - Preserves user-original content
  - Clarifies implicit assumptions
  - Maintains goal-oriented framing

### Requirement: BRAINSTORM shall use block quote format for citations

The system SHALL display user-original responses using block quote format (`>`) to distinguish from LLM-generated content.

#### Scenario: Quotes user original answer
- **WHEN** displaying background/pain points
- **THEN** system SHALL display user's original text with `>` prefix
- **AND** system SHALL display LLM-generated expansion below

#### Scenario: Output format example
```
## 背景与痛点

> 用户原始回答...

**归纳扩展**：
基于用户描述的归纳内容...
```

### Requirement: BRAINSTORM shall include WHY/WHAT in final output

The system SHALL include the background, pain points, and business objectives as part of the brainstorm.md output file, alongside the feature skeleton.

#### Scenario: Combines WHY/WHAT/HOW
- **WHEN** user confirms feature skeleton
- **THEN** system SHALL output complete brainstorm.md containing:
  - 背景与痛点 (WHY)
  - 业务目标 (WHAT)
  - 功能骨架 (HOW)

### Requirement: CLARIFY shall reference BRAINSTORM's WHY/WHAT

The CLARIFY node SHALL reference the background and business objectives confirmed in BRAINSTORM node, instead of re-asking.

#### Scenario: References BRAINSTORM content
- **WHEN** CLARIFY node loads previous node output
- **THEN** dimensions 1-2 SHALL display:
  - Title and explanation
  - Reference to BRAINSTORM confirmation
  - Content from brainstorm.md

#### Scenario: Indicates citation source
- **WHEN** displaying dimension 1-2
- **THEN** system SHALL indicate: "已由 BRAINSTORM 阶段确认"
- **AND** SHALL quote the original content
