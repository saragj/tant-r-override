<!-- Context: core/context-system/examples/navigation | Priority: medium | Version: 1.0 | Updated: 2026-03-09 -->

# Context System Examples

**Purpose**: Navigation for practical navigation file examples

---

## Structure

```
examples/
├── navigation.md (this file)
└── navigation-examples.md    # 6+ complete navigation examples + anti-patterns
```

---

## Quick Routes

| Resource                | File                     | Purpose                             |
| ----------------------- | ------------------------ | ----------------------------------- |
| **Navigation Examples** | `navigation-examples.md` | Real-world navigation file patterns |

---

## What's Inside navigation-examples.md

### Example Categories

1. **Basic Navigation** (Examples 1-3)

   - Simple category navigation
   - Minimal structure
   - Quick routes pattern

2. **Specialized Navigation** (Examples 4-6)

   - Complex multi-level navigation
   - Domain-specific patterns
   - Advanced routing

3. **Anti-Patterns**
   - Common mistakes to avoid
   - Over-engineered navigation
   - Token-inefficient patterns

### Example Types Covered

| Example       | Type        | Lines | Tokens | Use Case                  |
| ------------- | ----------- | ----- | ------ | ------------------------- |
| **Example 1** | Simple      | ~80   | ~400   | Single-level categories   |
| **Example 2** | Medium      | ~120  | ~600   | Multi-file categories     |
| **Example 3** | Complex     | ~150  | ~800   | Deep hierarchies          |
| **Example 4** | Specialized | ~130  | ~650   | Domain-specific (testing) |
| **Example 5** | Specialized | ~140  | ~700   | Technical (APIs)          |
| **Example 6** | Advanced    | ~160  | ~850   | Cross-category routing    |

---

## By Use Case

### Creating New Navigation File

**Need inspiration?** → `navigation-examples.md`

- Find example matching your complexity level
- Copy structure pattern
- Adapt to your category
- Verify <200 lines, scannable

### Improving Existing Navigation

**Navigation hard to scan?** → `navigation-examples.md` (Anti-Patterns section)

- Check if you're making common mistakes
- Compare to efficient examples
- Refactor using token-efficient patterns

### Learning Navigation Design

**New to navigation files?** → Read in order:

1. `../guides/navigation-design-basics.md` - Principles
2. `navigation-examples.md` - See patterns in action
3. `../guides/navigation-templates.md` - Apply templates

---

## Example Patterns

**Simple (80 lines)**: Structure → Quick Routes → Related (3-5 links) | 400 tokens  
**Medium (120 lines)**: + By Task section | 600 tokens  
**Complex (150 lines)**: + By Type, prioritized routes | 800 tokens

See `navigation-examples.md` for full examples (6 complete patterns + anti-patterns).

## How to Use Examples

1. **Identify complexity**: Simple (3-8 files) | Medium (10-20) | Complex (20+)
2. **Copy pattern** from `navigation-examples.md`
3. **Customize** with your content
4. **Validate**: <200 lines, scannable
   Simple: 3-8 files, single level
   → Use Example 1 pattern

Medium: 10-20 files, some subcategories
→ Use Example 2 pattern

Complex: 20+ files, deep hierarchy
→ Use Example 3 pattern

Specialized: Domain-specific needs
→ See Examples 4-6, adapt pattern

```

### Step 2: Copy Structure Pattern

```

1. Open navigation-examples.md
2. Find matching example
3. Copy structure sections
4. Replace with your content
5. Verify <200 lines

```

### Step 3: Customize for Your Domain

```

1. Update ASCII tree (your folders/files)
2. Fill Quick Routes table (your links)
3. Add task-based sections (your use cases)
4. Link related context (your cross-refs)

```

### Step 4: Validate

```

- [ ] File <200 lines?
- [ ] Structure scannable?
- [ ] Routes clearly labeled?
- [ ] Related context linked?
- [ ] Frontmatter present?

```

## Anti-Patterns

❌ Over-documentation, nested tables, duplicate content, no structure, no task sections
✅ Concise labels, flat tables, route (don't teach), ASCII tree, user-centric

See `navigation-examples.md` Anti-Patterns section for details.

---

## Related Context

- **Operations** → `../operations/navigation.md`
- **Standards** → `../standards/navigation.md`
- **Guides** → `../guides/navigation.md`
- **Navigation Design** → `../guides/navigation-design-basics.md`
- **Navigation Templates** → `../guides/navigation-templates.md`

---

## Next Steps

**Beginners**: Read `../guides/navigation-design-basics.md` → Study Example 1 → Practice
**Experienced**: Browse patterns → Copy relevant example → Adapt
**Refactoring**: Check Anti-Patterns → Find better pattern → Apply
```
