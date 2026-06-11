<!-- Context: core/templates | Priority: critical | Version: 2.0 | Updated: 2026-03-09 -->

# Context File Templates

**Purpose**: Standard formats for all context file types

---

## Template Selection

| Type           | Max Lines | Key Sections                                                  |
| -------------- | --------- | ------------------------------------------------------------- |
| **Concept**    | 100-150   | Core Idea (1-3 sent) + Key Points (3-5) + Example (<10 lines) |
| **Example**    | 80-120    | Use Case + Code (10-30 lines) + Explanation                   |
| **Guide**      | 120-180   | Prerequisites + Steps (4-7) + Verification                    |
| **Lookup**     | 60-100    | Tables/Lists + Commands                                       |
| **Error**      | 80-150    | Symptom + Cause + Solution + Prevention (per error)           |
| **Navigation** | 50-150    | Structure (ASCII) + Quick Routes + By Task                    |

---

## Template Structures

### 1. Concept (100-150 lines)

**Sections**: Frontmatter → Purpose → Core Idea (1-3 sent) → Key Points (3-5) → When to Use → Quick Example (<10 lines) → Codebase Refs → Deep Dive → Related

### 2. Example (80-120 lines)

**Sections**: Frontmatter → Purpose → Use Case → Code (10-30 lines) → Explanation → Codebase Refs → Related

### 3. Guide (120-180 lines)

**Sections**: Frontmatter → Purpose → Prerequisites → Steps (4-7) → Verification → Codebase Refs → Related

### 4. Lookup (60-100 lines)

**Sections**: Frontmatter → Purpose → Tables/Lists → Commands → Related

### 5. Error (80-150 lines)

**Sections**: Frontmatter → Purpose → Per Error (Symptom → Cause → Solution → Prevention) → Related

### 6. Navigation (50-150 lines)

**Sections**: Frontmatter → Purpose → Structure (ASCII) → Quick Routes → By Task → Related

---

## Template Rules

**All templates MUST include**:

- ✅ HTML frontmatter (context, priority, version, updated)
- ✅ Purpose statement (1 sentence)
- ✅ Related section (cross-references)
- ✅ File <200 lines (MVI strict)

**Optional but recommended**:

- 📂 Codebase References section
- Last Updated date
- Examples/verification steps

---

## Related Context

- **MVI Standards** → `mvi.md`
- **Structure Standards** → `structure.md`
- **Frontmatter Format** → `frontmatter.md`
- **Codebase References** → `codebase-references.md`
