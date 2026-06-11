<!-- Context: standards/testing-guidelines | Priority: critical | Version: 1.2 | Updated: 2026-03-17 -->

# Testing Guidelines

**Purpose**: Layered testing strategy aligned with clean architecture. Apply to **new tests only**.

**Last Updated**: 2026-03-17

---

## Strategy by Layer

| Layer              | What to Test                | Mock                  | Goal |
| ------------------ | --------------------------- | --------------------- | ---- |
| **Domain**         | Business rules, validation  | Nothing               | 100% |
| **Application**    | Use cases, orchestration    | Repository interfaces | 90%+ |
| **Infrastructure** | HTTP adapters, API → Domain | apiClient             | 80%+ |
| **Presentation**   | Components, hooks           | Query hooks/services  | 80%+ |

---

## Zod Schema Testing Pattern (Domain Layer)

### Unified it.each Pattern

Use `it.each()` to combine happy path + sad paths in one test. Maximizes coverage, minimizes code.

```typescript
// === 1. Define fixtures ===
const validUser = { id: '1', name: 'John' };

// === 2. Create helper (optional, for complex assertions) ===
type ParseResult<T> = { success: true; data: T } | { success: false; error: { issues: { path: string[] }[] } };
const assertErrorFields = (result: ParseResult<unknown>, fields: string[]) => {
  if (result.success || fields.length === 0) return;
  const paths = result.error.issues.map((i) => i.path[0]);
  for (const f of fields) expect(paths).toContain(f);
};

// === 3. Unified it.each with [description, input, shouldPass, expectedErrorFields] ===
describe('userSchema', () => {
  it.each([
    ['valid', validUser, true, []], // ← happy path
    ['missing id', { name: 'John' }, false, ['id']], // ← sad path
    ['missing name', { id: '1' }, false, ['name']],
    ['empty', {}, false, ['id', 'name']],
  ])('%s', (_, input, shouldPass, fields) => {
    const result = userSchema.safeParse(input);
    expect(result.success).toBe(shouldPass); // Works for both!
    if (!result.success) assertErrorFields(result, fields);
  });
});
```

### Why This Works

| Case       | `shouldPass` | Expected Result               |
| ---------- | ------------ | ----------------------------- |
| Happy path | `true`       | `result.success === true` ✅  |
| Sad path   | `false`      | `result.success === false` ✅ |

**Benefits**:

- ✅ One test block per schema (not two)
- ✅ All cases in one array (easy to add new ones)
- ✅ Verifies **which field** caused the error
- ✅ 100% coverage achievable

---

## Test Types

| Type            | Layer                | Description                    |
| --------------- | -------------------- | ------------------------------ |
| **Unit**        | Domain + Application | Fast, isolated, no I/O         |
| **Integration** | Infrastructure       | Test adapters with mocked HTTP |
| **Component**   | Presentation         | User-visible behavior with RTL |

---

## AAA Pattern

```typescript
it('should calculate total', () => {
  // Arrange
  const items = [{ price: 10 }, { price: 20 }];
  // Act
  const result = calculateTotal(items);
  // Assert
  expect(result).toBe(30);
});
```

---

## Best Practices

**DO**:

- Test **behavior**, not implementation
- Mock at **layer boundaries only**
- Use `beforeEach` → `vi.clearAllMocks()`
- Test edge cases: null, undefined, empty, invalid data
- Use `it.each()` for schema validation

**DON'T**:

- ❌ Mock across layers (component → HTTP)
- ❌ Test third-party libraries (React, Zod)
- ❌ Test private methods
- ❌ Skip cleanup (causes flaky tests)

---

## Quick Commands

```bash
npm test              # Run tests
npm run test:watch   # Watch mode
npm run test:coverage # Coverage report
```

---

## Related Docs

- [By Layer](../guides/testing-by-layer.md) - Detailed patterns
- [Examples](../examples/testing-examples.md) - Real code
- [Patterns](../lookup/testing-patterns.md) - Snippets
