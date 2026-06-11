<!-- Context: core/workflows/update | Priority: high | Version: 1.0 | Updated: 2026-03-09 -->

# Update Workflow (Interactive)

**Purpose**: Update context files when frameworks/APIs change versions

---

## Overview

The Update workflow finds and updates all references to a framework/library when new versions introduce changes.

**Command**: `/context update for {framework} {version}`

**Stages**: 8 (Identify → Find → Preview → Backup → Update → Migrate → Validate → Report)

---

## Stage 1: Identify Changes (APPROVAL)

```
/context update for Next.js 15
  ↓
Agent: "What changed in Next.js 15?
  [A] API changes
  [B] Deprecations
  [C] New features
  [D] Breaking changes
  [E] Other

Select (A B C D):"

User: "A C D"

Agent: "Describe changes:
  API changes: ___
  New features: ___
  Breaking changes: ___"

User: "API changes: App router is default
New features: Metadata API, Server Actions stable
Breaking changes: Pages router requires opt-in"
```

---

## Stage 2: Find Affected Files

```
Agent: "Searching for Next.js references...

Found 5 files with 17 references:
  📄 concepts/routing.md (3 refs, 145 lines)
  📄 examples/app-router.md (7 refs, 78 lines)
  📄 guides/setup-nextjs.md (2 refs, 132 lines)
  📄 errors/nextjs-errors.md (1 ref, 98 lines)
  📄 lookup/nextjs-commands.md (4 refs, 54 lines)"
```

**Search scope**:

- Direct framework mentions
- Import statements
- Code examples
- Version numbers
- Documentation links

---

## Stage 3: Preview Changes (APPROVAL)

```
Agent: "Proposed updates:

━━━ concepts/routing.md ━━━
Line 15:
  - App router is optional
  + App router is default in Next.js 15

Line 42:
  + ## Metadata API (New in v15)
  + New metadata exports for SEO

━━━ examples/app-router.md ━━━
Line 8:
  - // Optional: app router
  + // Default in Next.js 15+

━━━ lookup/nextjs-commands.md ━━━
Line 12:
  - npx create-next-app@latest
  + npx create-next-app@latest  # App router
  + npx create-next-app@latest --pages  # Pages

Approve? (yes/no/edit):"

User: "edit"

Agent: "Line-by-line approval mode...
[Shows each change individually]"
```

**Edit mode**: Approve/reject/modify each change individually.

---

## Stages 4-8: Execute & Validate

**Backup** → `.tmp/backup/update-{framework}-{timestamp}/`  
**Update** → Apply approved changes to files  
**Add Migration** → Document breaking changes in errors/  
**Validate** → Check file sizes (<200 lines), references (no broken links)  
**Report** → Summary with rollback path

```
Agent: "✅ Updated 5 files
📝 Modified 17 references
🔄 Added migration notes
🔗 Validated references (0 broken)

All files <200 lines ✓

Rollback: .tmp/backup/update-nextjs-2026-01-06/"
```

---

## Migration Notes

Breaking changes are automatically documented in `errors/{framework}-errors.md`:

```markdown
## Migration: {Framework} {OldVer} → {NewVer}

**Breaking Changes**:

- App router is now default
- Pages router requires explicit opt-in

**Migration Steps**:

1. Update to Next.js 15: `npm install next@15`
2. For pages router: Add `pages: true` to config
3. Update metadata: Replace Head with exports

**Reference**: https://nextjs.org/docs/15/upgrade-guide
```

---

## Line-by-Line Approval

When user selects "edit" mode:

```
Agent: "concepts/routing.md - Line 15?
  - App router is optional
  + App router is default in Next.js 15

Approve? (yes/no/modify):"

User: "modify"

Agent: "Enter new text:"

User: "App router is the default routing system in Next.js 15+"

Agent: "Updated. Next change..."
```

---

## Validation Checks

After update:

- [ ] All files still <200 lines
- [ ] No broken references
- [ ] Migration notes added (if breaking changes)
- [ ] Version numbers updated
- [ ] Documentation links current

---

## Common Scenarios

**API Changed**: Update function signatures, parameters  
**Deprecated**: Add deprecation notes, suggest alternatives  
**New Features**: Add sections for new capabilities  
**Breaking Changes**: Document migration path in errors/

---

## Related Context

- **Main Workflows** → `../workflows.md`
- **Extract Workflow** → `extract-workflow.md`
- **Operations** → `../../operations/update.md`
- **MVI Standards** → `../../standards/mvi.md`
