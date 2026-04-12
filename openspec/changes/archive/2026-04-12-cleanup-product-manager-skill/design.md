## Context

The product_manager skill is the main entry point for the AIPM system. Currently the SKILL.md file has several issues that cause confusion and maintenance burden:

1. **STATE_RULES.md reference**: Points to a file whose content was just merged into _manage.md
2. **Missing directories**: References `references/` (only 1 file exists) and `scripts/` (6 files exist but marked as "don't use")
3. **Node naming mismatch**: SKILL.md references `06-init.md`, `07-prototyping.md`, `08-writing.md`, `09-change.md` but actual files are `06-prototyping.md`, `07-writing.md`, `08-change.md`
4. **Duplicate forced actions**: The same "强制动作 0-4" section appears 3 times in the file

## Goals / Non-Goals

**Goals:**
- Remove STATE_RULES.md after successful merge
- Update all references to point to existing files
- Align node references with actual file names
- Reduce duplicate content in SKILL.md

**Non-Goals:**
- Not rewriting skill logic or nodes
- Not modifying any node implementation files
- Not changing AIPM workflow or behavior

## Decisions

### D1: Delete STATE_RULES.md
**Decision**: Delete the file after merge to _manage.md is complete
**Rationale**: Content has been transferred, keeping both would cause confusion about which is authoritative
**Alternatives**: Keep as redirect file (unnecessary complexity)

### D2: Fix node references in SKILL.md
**Decision**: Update SKILL.md to reference actual node files
**Rationale**: Current references are broken
**Alternatives**: Rename actual files to match (more disruptive)

### D3: Simplify forced actions section
**Decision**: Keep forced actions once at top, remove duplicates elsewhere
**Rationale**: Reduce confusion and maintenance burden

### D4: Mark scripts/ as deprecated
**Decision**: Update resource index to indicate scripts/ are deprecated
**Rationale**: SKILL.md explicitly warns against using them

## Risks / Trade-offs

- [Risk] Breaking Coze skill publishing: Any change to SKILL.md structure could affect Coze sync
  - **Mitigation**: Keep YAML frontmatter (name, description) intact, only cleanup content
- [Risk] Missing edge case references: Some code might reference STATE_RULES.md directly
  - **Mitigation**: Already updated SKILL.md references, verified no other references