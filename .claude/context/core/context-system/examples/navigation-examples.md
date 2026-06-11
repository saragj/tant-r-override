<!-- Context: core/navigation-examples | Priority: high | Version: 2.0 | Updated: 2026-03-09 -->

# Navigation File Examples

**Purpose**: Real-world navigation file patterns (6 complete examples)

---

## Example Files

### Basic Patterns (Examples 1-3)

**File**: `navigation-examples/basic-patterns.md`

- **Example 1**: Function-Based Category Navigation (~250 tokens)
- **Example 2**: Concern-Based Category Navigation (~300 tokens)
- **Example 3**: Specialized Domain Navigation (~350 tokens)

**Use for**: Standard categories, 10-30 files, straightforward structure

---

### Advanced Patterns (Examples 4-6)

**File**: `navigation-examples/advanced-patterns.md`

- **Example 4**: Subcategory Navigation with Nested Structure (~400 tokens)
- **Example 5**: Full-Stack Multi-Domain Navigation (~450 tokens)
- **Example 6**: Minimal Micro-Category Navigation (~150 tokens)

**Use for**: Complex hierarchies, 30+ files, multiple subcategories

---

## Quick Selection Guide

| Your Situation                        | Use Example                | Tokens | Lines |
| ------------------------------------- | -------------------------- | ------ | ----- |
| **3-10 files, single level**          | Example 6 (Minimal)        | ~150   | ~50   |
| **10-20 files, function folders**     | Example 1 (Function-Based) | ~250   | ~80   |
| **20-30 files, concern-based**        | Example 2 (Concern-Based)  | ~300   | ~100  |
| **Specialized domain (testing, API)** | Example 3 (Specialized)    | ~350   | ~120  |
| **30+ files, subcategories**          | Example 4 (Subcategory)    | ~400   | ~140  |
| **Multiple domains, full-stack**      | Example 5 (Full-Stack)     | ~450   | ~160  |

---

## Pattern Comparison

### Token Efficiency

```
Minimal (Ex 6):     ~150 tokens ████░░░░░░
Function (Ex 1):    ~250 tokens ███████░░░
Concern (Ex 2):     ~300 tokens ████████░░
Specialized (Ex 3): ~350 tokens █████████░
Subcategory (Ex 4): ~400 tokens ██████████
Full-Stack (Ex 5):  ~450 tokens ███████████
```

**Target**: <500 tokens for navigation files

---

## Common Elements

All examples include:

- ✅ **Structure** (ASCII tree) - Visual hierarchy
- ✅ **Quick Routes** (table) - Common tasks
- ✅ **By Type/Task** - Categorized links
- ✅ **Related Context** - Cross-references

---

## Anti-Patterns

See `basic-patterns.md` (end of file) for anti-patterns to avoid:

- ❌ Over-documentation
- ❌ Nested tables
- ❌ Duplicate content
- ❌ No structure visualization
- ❌ Missing task-based sections

---

## When to Use Which Pattern

### Start Simple → Scale Up

1. **<10 files**: Start with Example 6 (Minimal)
2. **Growing to 10-20**: Upgrade to Example 1 (Function-Based)
3. **Specialized domain**: Use Example 3 pattern
4. **30+ files**: Add subcategories (Example 4)
5. **Multiple domains**: Full-Stack pattern (Example 5)

---

## Design Principles

From analyzing all 6 examples:

1. **ASCII trees win** - Visual structure beats prose (100 tokens)
2. **Tables for routes** - Scannable 2-column format (200 tokens)
3. **Task-based sections** - User-centric organization (150 tokens)
4. **Related context** - Cross-links for discovery (100 tokens)
5. **Keep <200 lines** - MVI compliance

**Total sweet spot**: ~550 tokens, ~150 lines

---

## Related Context

- **Navigation Design** → `../guides/navigation-design-basics.md`
- **Navigation Templates** → `../guides/navigation-templates.md`
- **MVI Standards** → `../standards/mvi.md`
- **Structure Standards** → `../standards/structure.md`

---

## Next Steps

1. **Read examples**: Pick closest match to your situation
2. **Copy pattern**: Use structure from example
3. **Adapt**: Replace with your content
4. **Validate**: <200 lines, <500 tokens, scannable
