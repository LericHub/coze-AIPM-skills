## ADDED Requirements

### Requirement: Node6 must run in foreground
The prototyping node (node6) SHALL explicitly run in foreground mode and MUST NOT be executed as a background task.

#### Scenario: Node6 cannot run as background task
- **WHEN** a user attempts to run node6 as a background task
- **THEN** the system SHALL reject the request with an error message indicating node6 must run in foreground
- **AND** the error message SHALL explain the interactive nature of prototyping

#### Scenario: Node6 execution demonstrates real-time progress
- **WHEN** node6 is executing
- **THEN** the system SHALL display real-time progress to the user
- **AND** allow user interaction during prototype generation