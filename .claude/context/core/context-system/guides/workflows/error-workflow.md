<!-- Context: core/workflows/error | Priority: high | Version: 1.0 | Updated: 2026-03-09 -->

# Error Workflow (Interactive)

**Purpose**: Add recurring errors to knowledge base with solutions

---

## Overview

The Error workflow searches for similar existing errors to avoid duplication, then adds new error patterns to the appropriate category.

**Command**: `/context error for "{error message}"`

**Stages**: 6 (Search → Check Duplication → Preview → Update → Validate → Report)

---

## Stage 1: Search Existing

```
/context error for "Cannot read property 'map' of undefined"
  ↓
Agent: "Searching existing errors...

Found 1 similar error:
  📄 development/errors/react-errors.md (Line 45)
     ## Error: Cannot read property 'X' of undefined
     Covers: General undefined property access
     Frequency: common

Found 2 related errors:
  📄 development/errors/react-errors.md
     ## Error: Cannot read property 'length' of undefined
     ## Error: Undefined is not an object"
```

**Search uses**:

- Fuzzy matching on error messages
- Common error patterns
- Stack trace similarities
- Framework/category tags

---

## Stage 2: Check Duplication (APPROVAL)

```
Agent: "Options:
  [A] Add as new error to react-errors.md
      (Specific case: 'map' on undefined array)

  [B] Update existing 'Cannot read property X' error
      (Add 'map' as common example)

  [C] Skip (already covered sufficiently)

Which framework/category?
  [1] React (react-errors.md)
  [2] JavaScript (js-errors.md)
  [3] General (common-errors.md)
  [4] Create new: ___

Select (e.g., 'B 1'):"

User: "B 1"
```

**Options explained**:

- **A**: New standalone error section
- **B**: Enhance existing error with new example
- **C**: Don't add (duplicate/trivial)

---

## Stage 3: Preview (APPROVAL)

````
Agent: "Would update development/errors/react-errors.md:

━━━ Line 45 ━━━
## Error: Cannot read property 'X' of undefined

**Problem**: Accessing property on undefined/null object

**Common in React**:
- Props not passed
- State not initialized
+ - Array undefined before map()

**Example**:
```js
// ❌ Wrong
const MyComponent = ({ items }) => {
+   return items.map(item => <div>{item}</div>);
};

// ✅ Right
const MyComponent = ({ items = [] }) => {
  return items.map(item => <div>{item}</div>);
};
````

**Solution**:

- Default props/parameters
- Optional chaining: `items?.map()`
- Guard clause: `if (!items) return null`

Approve? (yes/no/edit):"

User: "yes"

```

---

## Stages 4-6: Execute & Validate

**Update/Create** → Add error pattern to file
**Validate** → Check file <200 lines, proper format
**Report** → Confirm addition with file location

```

Agent: "✅ Updated development/errors/react-errors.md
📝 Added 'map' example to existing error
📊 File size: 187 lines (within limit)

Error now documented at:
development/errors/react-errors.md#L45"

````

---

## Error Template & Guidelines

**Format**: Error message → Problem → Common causes → Example (❌/✅) → Solutions → Reference
**Deduplication**: Similar → Update | Exact → Skip | Distinct → New section
**Categories**: React/JS/Framework-specific/General
**Validation**: <200 lines, template followed, example + solution present

---

## Related Context

- **Main Workflows** → `../workflows.md`
- **Operations** → `../../operations/error.md`
- **Error Template** → `../../standards/templates.md`
- **MVI Standards** → `../../standards/mvi.md`
```
````
