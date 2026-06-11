<!-- Context: core/workflows/organize | Priority: high | Version: 1.0 | Updated: 2026-03-09 -->

# Organize Workflow (Interactive)

**Purpose**: Restructure flat file directories into function-based folder structure

---

## Overview

The Organize workflow converts flat file structures into organized function-based folders (concepts/, examples/, guides/, lookup/, errors/).

**Command**: `/context organize {directory}/`

**Stages**: 8 (Scan → Categorize → Resolve Conflicts → Preview → Backup → Execute → Update → Report)

---

## Stage 1-2: Scan & Categorize

```
/context organize development/
  ↓
Agent: "Scanning development/ (23 files, flat structure)...

Categorizing by function..."
```

**Auto-categorization** analyzes:

- File content (concepts vs examples vs guides)
- Naming patterns (example-, guide-, concept-)
- Code vs prose ratio
- Step-by-step structure presence

---

## Stage 3: Resolve Conflicts (APPROVAL)

Agent presents ambiguous files and conflicts with letter-based options:

- **[A-C]** Ambiguous: Split or choose primary folder
- **[G-I]** Conflicts: Merge, rename, or skip duplicates

User: "A D G" (selects resolution for each)

---

## Stage 4: Preview (APPROVAL REQUIRED)

```
Agent: "Preview of changes:

CREATE directories:
  development/concepts/
  development/examples/
  development/guides/
  development/errors/

MOVE files (18): ...

SPLIT files (2):
  api-design.md →
    concepts/api-design.md (concepts section)
    guides/api-design-guide.md (guide section)

MERGE files (1):
  authentication.md → concepts/auth.md (merge content)

UPDATE:
  development/navigation.md
  Fix 47 internal references

Dry-run? (yes/no/show-diff):"

User: "yes"
```

**Dry-run mode**: Simulates changes without executing.

---

## Stages 5-8: Execute & Report

**Backup** → `.tmp/backup/organize-{dir}-{timestamp}/`  
**Execute** → Create dirs, move files, split ambiguous, merge conflicts  
**Update** → Fix 47 references, update navigation.md  
**Report** → Summary + rollback path
Agent: "Creating backup...
💾 Backup: .tmp/backup/organize-development-2026-01-06/

```

**Backup includes**:

- All original files
- Original navigation.md
- Rollback script

---

## Stage 6: Execute

```

Agent: "Executing changes...
✅ Created 5 directories
📁 Moved 18 files
🔀 Split 2 ambiguous files
🔗 Merged 1 conflict"

```

**Actions**:

1. Create function-based directories
2. Move/copy files to new locations
3. Split ambiguous files
4. Merge conflicts

---

## Stage 7: Update References

```

Agent: "Updating references...
🔗 Fixed 47 internal links
📊 Updated navigation.md"

```

**Reference types fixed**:

- Markdown links `[text](path)`
- Relative paths `../concepts/auth.md`
- Navigation entries

---

## Stage 8: Report

```

Agent: "✅ Organized 23 files into function folders

Summary:
📁 Created 5 new folders
📄 Moved 18 files
🔀 Split 2 files
🔗 Fixed 47 references
📊 Updated navigation.md

Rollback available at: .tmp/backup/organize-development-2026-01-06/"

```

---

## Quick Reference

**Conflicts**: Mixed content → Split | Duplicate → Merge | Oversized → Split
**Categorization**: Concepts (theory) | Examples (code) | Guides (steps) | Lookup (tables) | Errors (troubleshooting)
**Validation**: Function folders ✓ | <200 lines ✓ | Navigation updated ✓ | References fixed ✓

---

## Related Context

- **Main Workflows** → `../workflows.md`
- **Extract Workflow** → `extract-workflow.md`
- **Operations** → `../../operations/organize.md`
- **Structure Standards** → `../../standards/structure.md`
```
