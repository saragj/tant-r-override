<!-- Context: core/context-system/guides/navigation | Priority: medium | Version: 1.0 | Updated: 2026-03-09 -->

# Context System Guides

**Purpose**: Navigation for step-by-step context management guides

---

## Structure

```
guides/
├── navigation.md (this file)
├── workflows.md                  # Interactive operation workflows
├── compact.md                    # Compress verbose files → MVI
├── creation.md                   # Create new context from scratch
├── organizing-context.md         # Organize flat → function-based
├── navigation-design-basics.md   # Design efficient navigation files
└── navigation-templates.md       # Templates for navigation files
```

---

## Quick Routes

| Guide                     | File                          | Purpose                                                   |
| ------------------------- | ----------------------------- | --------------------------------------------------------- |
| **Interactive Workflows** | `workflows.md`                | Step-by-step for harvest/organize/update/error operations |
| **Compact Files**         | `compact.md`                  | Compress verbose content → MVI format                     |
| **Create Context**        | `creation.md`                 | Build new context category from scratch                   |
| **Organize Structure**    | `organizing-context.md`       | Restructure flat files → function-based                   |
| **Design Navigation**     | `navigation-design-basics.md` | Create efficient navigation files                         |
| **Navigation Templates**  | `navigation-templates.md`     | Templates for navigation files                            |

---

## By Task

### Starting Fresh

- **New context category?** → `creation.md` (folder structure, templates)
- **New navigation file?** → `navigation-design-basics.md` + `navigation-templates.md`

### Improving Existing Context

- **Files too long?** → `compact.md` (compress to <200 lines)
- **Flat structure?** → `organizing-context.md` (convert to function-based)
- **Hard to navigate?** → `navigation-design-basics.md` (improve navigation)

### Running Operations

- **Harvest summaries?** → `workflows.md` (Section: Harvest Interactive)
- **Organize files?** → `workflows.md` (Section: Organize Interactive)
- **Update context?** → `workflows.md` (Section: Update Interactive)
- **Add error pattern?** → `workflows.md` (Section: Error Interactive)

---

## Compression Guide (Quick Reference)

**When to compress**: Files >200 lines, verbose explanations, duplicate content

**5 Compression Techniques**:

1. **Extract Core Concept** - Paragraphs → 1-3 sentences
2. **Bulletize Key Points** - Long text → 3-5 bullets
3. **Minimize Examples** - Full code → <10 lines
4. **Reference Full Docs** - Don't duplicate, link instead
5. **Remove Redundancy** - Cut repetitive sections

**Full guide** → `compact.md`

---

## Creation Guide (Quick Reference)

**Steps to create new context category**:

1. Create folder structure (concepts/, examples/, guides/, lookup/, errors/)
2. Add navigation.md (index file)
3. Choose templates from `../standards/templates.md`
4. Apply MVI principle (<200 lines)
5. Add frontmatter (HTML comment metadata)
6. Update parent navigation.md

**Full guide** → `creation.md`

---

## Navigation Design (Quick Reference)

**Token-Efficient Pattern**:

```
Structure (ASCII tree) - 100 tokens
  ↓
Quick Routes (table) - 200 tokens
  ↓
By Task (categorized) - 150 tokens
  ↓
Related Context (links) - 100 tokens
```

**Total**: ~550 tokens (vs 2000+ for full content)

**Full guide** → `navigation-design-basics.md`

**Templates** → `navigation-templates.md`

---

## Common Scenarios

**Workspace cluttered?** → `workflows.md` (Harvest) → `/context harvest`  
**Files too long?** → `compact.md` (5 compression techniques)  
**Flat structure?** → `organizing-context.md` (convert to function-based)  
**New project?** → `creation.md` (folder structure + templates)

---

## Quick Start Paths

**Clean Up** → `compact.md` → `workflows.md` → `organizing-context.md`
**Create New** → `creation.md` → `navigation-templates.md` → `../standards/templates.md`
**Improve Navigation** → `navigation-design-basics.md` → `navigation-templates.md`

---

## Related Context

- **Operations** → `../operations/navigation.md`
- **Standards** → `../standards/navigation.md`
- **Examples** → `../examples/navigation.md`
- **MVI Principle** → `../standards/mvi.md`

```

```
