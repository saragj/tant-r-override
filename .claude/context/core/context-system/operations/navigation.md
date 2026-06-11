<!-- Context: core/context-system/operations/navigation | Priority: medium | Version: 1.0 | Updated: 2026-03-09 -->

# Context System Operations

**Purpose**: Navigation for context management operations

---

## Structure

```
operations/
├── navigation.md (this file)
├── harvest.md         # Extract from summaries → permanent context
├── extract.md         # Extract from docs/code/URLs
├── organize.md        # Restructure flat files → function-based
├── update.md          # Update context when APIs change
├── migrate.md         # Copy global → local context
└── error.md           # Add recurring errors to knowledge base
```

---

## Quick Routes

| Operation               | File          | Purpose                                              |
| ----------------------- | ------------- | ---------------------------------------------------- |
| **Harvest summaries**   | `harvest.md`  | Clean workspace, extract knowledge from AI summaries |
| **Extract from source** | `extract.md`  | Pull context from docs, code, or URLs                |
| **Organize structure**  | `organize.md` | Convert flat files to function-based folders         |
| **Update context**      | `update.md`   | Refresh when frameworks/APIs change                  |
| **Migrate to local**    | `migrate.md`  | Copy global project-intelligence to local            |
| **Add error pattern**   | `error.md`    | Document recurring errors and solutions              |

---

## By Use Case

### Cleanup & Maintenance

- **Workspace cluttered?** → `harvest.md` (extract summaries, delete originals)
- **Files too verbose?** → See `../guides/compact.md`
- **Flat file structure?** → `organize.md` (convert to function-based)

### Content Creation

- **New documentation?** → `extract.md` (pull from docs/URLs)
- **Recurring error?** → `error.md` (add to knowledge base)
- **Framework updated?** → `update.md` (refresh context)

### Project Setup

- **New project?** → `migrate.md` (copy global context locally)
- **Share with team?** → `migrate.md` (git-commit local context)

---

## Operation Workflows

All operations follow multi-stage workflows defined in `../guides/workflows.md`:

1. **Detect** - Identify source files/patterns
2. **Analyze** - Assess content and structure
3. **Extract** - Pull key information (MVI principle)
4. **Transform** - Apply templates and structure
5. **Validate** - Check compliance (<200 lines, function-based)
6. **Cleanup** - Archive/delete source files (with approval)

---

## Common Patterns

### Harvest Operation (Most Common)

```bash
# Default: Scan workspace for summaries
/context harvest

# Specific directory
/context harvest .tmp/

# Single file
/context harvest OVERVIEW.md
```

### Extract Operation

```bash
# From documentation
/context extract from docs/api.md

# From URL
/context extract from https://react.dev/hooks

# From code
/context extract from src/core/engine.ts
```

### Organize Operation

```bash
# Dry run (preview only)
/context organize development/ --dry-run

# Execute restructure
/context organize development/
```

---

## Critical Rules

<critical_rules>
<rule id="mvi_strict">Files MUST be <200 lines</rule>
<rule id="approval_gate">ALWAYS show approval UI before deleting/archiving</rule>
<rule id="function_structure">ALWAYS organize by function (concepts/, examples/, guides/, lookup/, errors/)</rule>
</critical_rules>

---

## Related Context

- **Main Navigation** → `../navigation.md`
- **Standards** → `../standards/navigation.md`
- **Guides** → `../guides/navigation.md`
- **MVI Principle** → `../standards/mvi.md`
- **Structure Standards** → `../standards/structure.md`
- **Interactive Workflows** → `../guides/workflows.md`

---

## Next Steps

1. **Choose an operation** from Quick Routes above
2. **Read the operation file** for detailed workflow
3. **Follow the multi-stage process** (Detect → Validate → Cleanup)
4. **Check compliance** after completion (file size, structure, references)

**Need help choosing?** Start with `harvest.md` - it's the most common operation for cleaning up AI-generated summaries.
