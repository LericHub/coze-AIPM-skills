## ADDED Requirements

### Requirement: Node07 SHALL render overview content in a dedicated single-view container
The writing node MUST treat the overview page as a distinct content mode so requirement summaries can be reviewed without the prototype/document split workspace.

#### Scenario: Overview loads in single-view mode
- **WHEN** the reviewer selects the overview entry in `index.html`
- **THEN** the viewer SHALL load `html/overview.html` into a dedicated overview iframe container and SHALL hide the prototype/document split view

### Requirement: Node07 SHALL render page content in a dual-frame workspace
The writing node MUST render page-level requirement review with two coordinated frames: one for the generated prototype artifact and one for the generated requirement document artifact.

#### Scenario: App page renders prototype and document together
- **WHEN** the reviewer selects an app page entry
- **THEN** the viewer SHALL load that page's prototype artifact in the left frame and the matching `doc/app/*.html` artifact in the right frame

#### Scenario: Web page renders prototype and document together
- **WHEN** the reviewer selects a web page entry
- **THEN** the viewer SHALL load that page's prototype artifact in the left frame and the matching `doc/web/*.html` artifact in the right frame

### Requirement: Node07 SHALL derive page rendering paths from detail metadata and generated outputs
The writing node MUST build a page data object that maps each page title to its platform, prototype path, and document path using detail metadata plus the generated output directory contents.

#### Scenario: Page metadata preserves detail ordering and platform grouping
- **WHEN** writing reads the detail artifact and prepares viewer data
- **THEN** it SHALL preserve the detail-defined page order and SHALL assign each page to the app or web group based on the page platform information from detail

#### Scenario: Flat prototyping output is mapped to viewer paths
- **WHEN** writing reads prototype files from the flat `prototyping` output directory
- **THEN** it SHALL map each resolved page to the correct prototype file path without requiring `app/` or `web/` subdirectories in the prototyping source

#### Scenario: Missing prototype file does not block document review
- **WHEN** a page document exists but the matching prototype artifact cannot be resolved
- **THEN** writing SHALL still generate the viewer metadata and SHALL surface the page with a missing-prototype indication instead of dropping the page entirely