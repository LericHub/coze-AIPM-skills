## ADDED Requirements

### Requirement: Legacy product manager scripts are archived outside the active skill path
The repository SHALL move legacy `product_manager` workflow scripts out of the active `product_manager/scripts/` path into a clearly marked archive location so they are not presented as part of the supported workflow.

#### Scenario: Legacy scripts are removed from the active path
- **WHEN** a maintainer inspects the active `product_manager` directory structure
- **THEN** the legacy shell scripts are no longer located under `product_manager/scripts/`
- **AND** the scripts remain available from a clearly marked archive location

### Requirement: Active documentation reflects the supported workflow only
The repository SHALL update active `product_manager` documentation so the current workflow description does not present the legacy scripts as part of the supported skill surface.

#### Scenario: Directory structure excludes active scripts
- **WHEN** a maintainer reads the current `product_manager` documentation
- **THEN** the active directory structure and workflow guidance do not describe `product_manager/scripts/` as part of the live workflow

#### Scenario: Archive status is explicit
- **WHEN** a maintainer encounters documentation that references the archived scripts
- **THEN** the documentation explicitly states that the scripts are retained for historical reference only and are not part of the supported workflow

### Requirement: Workflow terminology aligns with the current state model in touched docs
Any `product_manager` documentation updated by this change SHALL use terminology that matches the current workflow model, including `Memory.json` and the active relative output structure, instead of conflicting script-era terms.

#### Scenario: Updated docs use current state terminology
- **WHEN** this change updates `product_manager` documentation near the archival work
- **THEN** the updated content uses `Memory.json` rather than `Memory.md`
- **AND** the updated content does not describe the `/AIPM` script-based layout as the active workflow