<!-- Context: core/workflows | Priority: high | Version: 2.0 | Updated: 2026-03-09 -->

# Context Operation Workflows

**Purpose**: Interactive workflow guides for context operations

---

## Available Workflows

All context operations follow detailed multi-stage interactive workflows with approval gates.

| Operation    | File                             | Stages   | Purpose                                         |
| ------------ | -------------------------------- | -------- | ----------------------------------------------- |
| **Extract**  | `workflows/extract-workflow.md`  | 5 stages | Extract from docs/code/URLs → context files     |
| **Organize** | `workflows/organize-workflow.md` | 8 stages | Restructure flat files → function-based folders |
| **Update**   | `workflows/update-workflow.md`   | 8 stages | Update context when APIs/frameworks change      |
| **Error**    | `workflows/error-workflow.md`    | 6 stages | Add recurring errors to knowledge base          |

---

## Workflow Pattern

All operations follow this structure:

```
Stage 1: Detect/Scan
  ↓
Stage 2: Analyze & Categorize
  ↓
Stage 3: Approval Gate (User confirms selections)
  ↓
Stage 4: Preview Changes (User approves plan)
  ↓
Stage 5: Backup & Execute
  ↓
Stage 6: Validate & Report
```

**Key principle**: Multiple approval gates ensure user control over all changes.

---

## Quick Start

**Extract**: `/context extract from https://react.dev/hooks` → `workflows/extract-workflow.md`  
**Organize**: `/context organize development/` → `workflows/organize-workflow.md`  
**Update**: `/context update for Next.js 15` → `workflows/update-workflow.md`  
**Error**: `/context error for "Cannot read..."` → `workflows/error-workflow.md`

---

## Features

**Approval Gates**: Selection → Conflict Resolution → Preview → Line-by-Line (optional)  
**Dry Run**: Simulate changes before executing (`--dry-run`)  
**Backup & Rollback**: `.tmp/backup/{operation}-{timestamp}/`  
**Conflict Resolution**: Ambiguous files, duplicates, broken references, MVI violations

---

## Workflow Summaries

### Extract (5 stages)

Read Source → Analyze & Categorize → Select (approval) → Preview (approval) → Create & Report  
**Details** → `workflows/extract-workflow.md`

### Organize (8 stages)

Scan → Categorize → Resolve Conflicts (approval) → Preview (approval) → Backup → Execute → Update Refs → Report  
**Details** → `workflows/organize-workflow.md`

### Update (8 stages)

Identify Changes (approval) → Find Files → Preview (approval) → Backup → Update → Add Migration → Validate → Report  
**Details** → `workflows/update-workflow.md`

### Error (6 stages)

Search Existing → Check Duplication (approval) → Preview (approval) → Update/Create → Validate → Report  
**Details** → `workflows/error-workflow.md`

---

## Related Context

- **Operations** → `../operations/navigation.md`
- **Standards** → `../standards/navigation.md`
- **Guides** → `../guides/navigation.md`
- **MVI Principle** → `../standards/mvi.md`
- **Structure** → `../standards/structure.md`

---

## When to Use Each Workflow

| Scenario                                  | Workflow                       |
| ----------------------------------------- | ------------------------------ |
| **New framework documentation published** | Extract → Update (if existing) |
| **Workspace cluttered with flat files**   | Organize                       |
| **Framework version upgraded**            | Update                         |
| **Recurring error encountered**           | Error                          |
| **Pull context from external docs**       | Extract                        |
| **Hard to find files in category**        | Organize                       |
| **API deprecated/changed**                | Update                         |
| **Team asks same error question**         | Error                          |
