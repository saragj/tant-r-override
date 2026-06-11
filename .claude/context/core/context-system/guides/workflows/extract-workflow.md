<!-- Context: core/workflows/extract | Priority: high | Version: 1.0 | Updated: 2026-03-09 -->

# Extract Workflow (Interactive)

**Purpose**: Extract context from external sources (docs, code, URLs) into structured context files

---

## Overview

The Extract workflow pulls knowledge from external sources and converts it into MVI-compliant context files organized by function (concepts/, examples/, guides/, errors/).

**Command**: `/context extract from {source}`

**Stages**: 5 (Read → Analyze → Select → Preview → Create)

---

## Stage 1: Read Source

```
/context extract from https://react.dev/hooks
  ↓
Agent: "Reading source (8,500 lines)...
Analyzing content for extractable items..."
```

**What happens**:

- Fetches content from URL/file/code
- Parses markdown/HTML/code structure
- Identifies extractable sections

---

## Stage 2: Analyze & Categorize

```
Agent: "Analysis complete.

Found 12 core concepts:
  - useState (state management)
  - useEffect (side effects)
  - useContext (context consumption)
  ... (9 more)

Found 8 common errors:
  - Hooks called conditionally
  - Hooks in loops
  - Hooks outside components
  ... (5 more)

Found 3 workflows:
  - Setting up custom hooks
  - Debugging hook issues
  - Testing components with hooks"
```

**Auto-categorization logic**:

- **Concepts**: Theoretical explanations, "what is X"
- **Examples**: Code samples, working demonstrations
- **Guides**: Step-by-step instructions, "how to"
- **Errors**: Error messages, troubleshooting
- **Lookup**: Quick reference tables, command lists

---

## Stage 3: Select Category (APPROVAL REQUIRED)

```
Agent: "Which category should this go in?
  [1] development/
  [2] core/
  [3] Create new category: ___

Select items to extract:
  Concepts:
    ✓ [A] useState
    ✓ [B] useEffect
    ✓ [C] useContext
    ... [D-L] (9 more)

  Errors:
    ✓ [M] Hooks called conditionally
    ✓ [N] Hooks in loops
    ... [O-T] (6 more)

  Guides:
    ✓ [U] Setting up custom hooks
    ✓ [V] Debugging hook issues
    ✓ [W] Testing components

Type items (A B M or 'all') + category (1/2/3):"

User: "all 1"
```

**Selection format**:

- **Letter-based**: A B M (select specific items)
- **'all'**: Select everything
- **Category number**: 1, 2, or 3

---

## Stage 4: Preview (APPROVAL REQUIRED)

```
Agent: "Would create in development/:

  concepts/use-state.md (45 lines)
  concepts/use-effect.md (52 lines)
  concepts/use-context.md (38 lines)
  ... (9 more concept files)

  errors/react-hooks-errors.md (124 lines)
    - 8 errors grouped in one file

  guides/custom-hooks.md (87 lines)
  guides/debugging-hooks.md (65 lines)
  guides/testing-hooks.md (72 lines)

Total: 15 files, ~850 lines

Preview specific file? (type filename or 'skip')
Approve? (yes/no/preview):"

User: "preview use-state.md"

Agent: [Shows first 30 lines of use-state.md]

User: "yes"
```

**Preview options**:

- **preview {filename}**: See content before creating
- **yes**: Create all files
- **no**: Cancel operation
- **edit**: Modify selections

---

## Stage 5: Create, Update, Report

```
Agent: "Creating files...
✅ Extracted 20 items into development/
📄 Created 15 files
📊 Updated development/navigation.md

Files created:
  - development/concepts/ (12 files)
  - development/errors/react-hooks-errors.md
  - development/guides/ (3 files)

All files comply with MVI (<200 lines) ✓"
```

**Actions performed**:

1. Create files with MVI-compliant content
2. Add HTML frontmatter (context, priority, version, date)
3. Update navigation.md in target category
4. Validate file sizes (<200 lines)
5. Check for broken references

---

## Key Features

**Error Grouping**: 8 related errors → 1 file (if combined <200 lines)  
**MVI Auto-Compression**: Verbose docs → Core concept + key points + example + link  
**Validation**: Files <200 lines, frontmatter present, function-based folders

---

## Related Context

- **Main Workflows** → `../workflows.md`
- **Organize Workflow** → `organize-workflow.md`
- **Update Workflow** → `update-workflow.md`
- **Operations** → `../../operations/extract.md`
- **MVI Standards** → `../../standards/mvi.md`
