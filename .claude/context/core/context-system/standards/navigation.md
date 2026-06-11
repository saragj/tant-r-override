<!-- Context: core/context-system/standards/navigation | Priority: critical | Version: 1.0 | Updated: 2026-03-09 -->

# Context System Standards

**Purpose**: Navigation for context file standards and templates

---

## Structure

```
standards/
├── navigation.md (this file)
├── mvi.md                    # Minimal Viable Information principle
├── structure.md              # Function-based directory structure
├── templates.md              # File templates (concept, example, guide, lookup, error)
├── frontmatter.md            # HTML comment metadata format
└── codebase-references.md    # How to reference code files
```

---

## Quick Routes

| Standard                | File                     | Purpose                                              |
| ----------------------- | ------------------------ | ---------------------------------------------------- |
| **MVI Principle**       | `mvi.md`                 | Core concept extraction (<200 lines, scannable)      |
| **Directory Structure** | `structure.md`           | Function-based folder organization                   |
| **File Templates**      | `templates.md`           | Templates for concept, example, guide, lookup, error |
| **Frontmatter Format**  | `frontmatter.md`         | HTML comment metadata (context, priority, version)   |
| **Code References**     | `codebase-references.md` | Link to source code from context files               |

---

## By Task

### Writing New Context Files

1. **Start with MVI** → `mvi.md` (understand core principle)
2. **Choose template** → `templates.md` (concept/example/guide/lookup/error)
3. **Add frontmatter** → `frontmatter.md` (metadata format)
4. **Apply structure** → `structure.md` (place in correct folder)
5. **Link to code** → `codebase-references.md` (if referencing implementation)

### Reviewing Existing Files

1. **Check MVI compliance** → `mvi.md` (<200 lines? Core concept clear?)
2. **Verify structure** → `structure.md` (function-based folders?)
3. **Validate frontmatter** → `frontmatter.md` (metadata present?)
4. **Check references** → `codebase-references.md` (links working?)

### Refactoring Context

1. **Compress verbose files** → `mvi.md` + `../guides/compact.md`
2. **Reorganize flat files** → `structure.md` + `../operations/organize.md`
3. **Update templates** → `templates.md` (apply current patterns)

---

## MVI Principle (Quick Reference)

**Core Rule**: Files MUST be <200 lines

**Formula**:

```
Core Concept (1-3 sentences)
  ↓
Key Points (3-5 bullets)
  ↓
Minimal Example (<10 lines)
  ↓
Reference Link (full docs)
```

**Goal**: Scannable in <30 seconds

**Full details** → `mvi.md`

---

## Function-Based Structure (Quick Reference)

**Standard folders**:

```
{category}/
├── navigation.md       # Navigation index
├── concepts/           # What it is (theoretical)
├── examples/           # Working code (practical)
├── guides/             # How to (step-by-step)
├── lookup/             # Quick reference (tables, lists)
└── errors/             # Common issues (troubleshooting)
```

**Full details** → `structure.md`

---

## Template Types

| Type           | Purpose                   | Length        | Location            |
| -------------- | ------------------------- | ------------- | ------------------- |
| **Concept**    | Explain theoretical ideas | 100-150 lines | `concepts/`         |
| **Example**    | Show working code         | 80-120 lines  | `examples/`         |
| **Guide**      | Step-by-step instructions | 120-180 lines | `guides/`           |
| **Lookup**     | Quick reference tables    | 60-100 lines  | `lookup/`           |
| **Error**      | Troubleshooting patterns  | 80-120 lines  | `errors/`           |
| **Navigation** | Directory index           | 50-150 lines  | Root of each folder |

**Full templates** → `templates.md`

---

## Frontmatter Format (Quick Reference)

**Required format** (HTML comment):

```html
<!-- Context: path/to/file | Priority: level | Version: X.Y | Updated: YYYY-MM-DD -->
```

**Priority levels**: `critical`, `high`, `medium`, `low`

**Example**:

```html
<!-- Context: core/mvi | Priority: critical | Version: 1.0 | Updated: 2026-03-09 -->
```

**Full details** → `frontmatter.md`

---

## Critical Rules

<critical_rules>
<rule id="mvi_strict">Files MUST be <200 lines (MVI principle)</rule>
<rule id="function_structure">ALWAYS use function-based folders (not flat)</rule>
<rule id="scannable">Content must be scannable in <30 seconds</rule>
<rule id="frontmatter">All files MUST have HTML comment frontmatter</rule>
<rule id="minimal_examples">Examples <10 lines, reference full code</rule>
</critical_rules>

---

## Validation Checklist

After creating/editing context files:

- [ ] **File size** <200 lines? (`mvi.md`)
- [ ] **Frontmatter** present? (`frontmatter.md`)
- [ ] **Core concept** stated in 1-3 sentences? (`mvi.md`)
- [ ] **Key points** are 3-5 bullets? (`mvi.md`)
- [ ] **Example** is minimal (<10 lines)? (`mvi.md`)
- [ ] **Reference link** to full docs included? (`mvi.md`)
- [ ] **Function-based folder** used? (`structure.md`)
- [ ] **Template** followed? (`templates.md`)
- [ ] **Code references** formatted correctly? (`codebase-references.md`)

---

## Related Context

- **Main Navigation** → `../navigation.md`
- **Operations** → `../operations/navigation.md`
- **Guides** → `../guides/navigation.md`
- **Examples** → `../examples/navigation.md`
- **Compaction Guide** → `../guides/compact.md`
- **Creation Guide** → `../guides/creation.md`

---

## Next Steps

1. **New to context system?** Start with `mvi.md`
2. **Creating new file?** Check `templates.md` for your file type
3. **Refactoring?** Review `structure.md` + `mvi.md`
4. **Validating?** Use checklist above
