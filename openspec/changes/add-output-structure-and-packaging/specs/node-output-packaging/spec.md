## ADDED Requirements

### Requirement: Node output packaging after completion
After a node completes its output, the system SHALL automatically package the versioned output directory into a zip file.

#### Scenario: Node6 completion packaging
- **WHEN** node6 (prototyping) completes its output (initial or confirmed)
- **THEN** the system SHALL create a zip file named `{project_name}_V{version}_output_{YYYYMMDD_HHmm}.zip`
- **AND** save it to `./output/` directory

#### Scenario: Node7 completion packaging
- **WHEN** node7 (writing) completes its output (initial or confirmed)
- **THEN** the system SHALL create a zip file with the same naming convention
- **AND** save it to `./output/` directory

#### Scenario: Node8 completion packaging
- **WHEN** node8 (change) completes and confirms a change
- **THEN** the system SHALL create a zip file with the same naming convention
- **AND** save it to `./output/` directory

### Requirement: Package content
The packaged zip file SHALL contain the complete versioned output directory.

#### Scenario: Package contents verification
- **WHEN** a package is created
- **THEN** it SHALL include all contents from `./output/V{version}/`
- **AND** maintain the directory structure within the zip