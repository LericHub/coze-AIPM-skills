## ADDED Requirements

### Requirement: Node07 viewer SHALL render the Figma-aligned shell layout
The writing node MUST generate a PRD viewer shell whose information architecture matches the Figma review screen: a left navigation rail for version and page selection, and a right workspace for rendered content.

#### Scenario: Viewer shell is generated for writing output
- **WHEN** node07 generates `output/V{version}/writing/index.html`
- **THEN** the HTML SHALL include a persistent left sidebar, a top header area for the workspace, and a main content region sized for embedded page rendering

#### Scenario: Sidebar groups requirement entries
- **WHEN** the viewer loads page metadata for a generated version
- **THEN** the sidebar SHALL show a version selector section, a requirement overview entry, an app page group, and a web page group using the page order supplied by writing metadata

### Requirement: Node07 viewer SHALL expose active navigation state
The generated viewer MUST visually distinguish the currently selected entry so reviewers can identify whether they are viewing the overview or a specific page.

#### Scenario: Overview entry is active on initial load
- **WHEN** a reviewer opens `index.html` without a page selection in the URL or runtime state
- **THEN** the overview navigation item SHALL render as active and the workspace SHALL open in overview mode

#### Scenario: Page entry becomes active after selection
- **WHEN** a reviewer selects an app or web page from the sidebar
- **THEN** the selected page item SHALL render as active and previously active items SHALL return to the inactive state

### Requirement: Node07 viewer SHALL support version switching from generated outputs
The generated viewer MUST provide a version selection control that reflects available output versions and allows the reviewer to switch the loaded version context.

#### Scenario: Version selector lists generated versions
- **WHEN** writing assembles the viewer for a project with one or more generated output versions
- **THEN** the selector SHALL render the available version directory names and highlight the current version

#### Scenario: Switching version reloads the viewer context
- **WHEN** a reviewer chooses another available version from the selector
- **THEN** the viewer SHALL update its navigation metadata and content paths to the selected version before rendering overview or page content