<!-- Context: core/examples/testing-examples | Priority: high | Version: 1.1 | Updated: 2026-03-17 -->

# Testing Examples

**Purpose**: Real code examples from project tests per layer

**Last Updated**: 2026-03-17

---

## Domain Layer - Unified it.each Pattern

File: `src/domain/projects.test.ts` (253 lines, 49 tests, 100% coverage)

### 1. Fixtures + Helper

```typescript
// Fixtures - reuse across tests
const validResponsible: Responsible = {
  id: 'resp-1',
  name: 'John',
  lastName: 'Doe',
  department: 'Engineering',
};

// Helper - verify error fields
type ParseResult<T> = { success: true; data: T } | { success: false; error: { issues: { path: string[] }[] } };
const assertErrorFields = (result: ParseResult<unknown>, fields: string[]) => {
  if (result.success || fields.length === 0) return;
  const paths = result.error.issues.map((i) => i.path[0]);
  for (const f of fields) expect(paths).toContain(f);
};
```

### 2. Unified Test

```typescript
describe('responsibleSchema', () => {
  it.each([
    ['valid', validResponsible, true, []], // happy path
    ['missing id', { ...validResponsible, id: undefined }, false, ['id']],
    ['missing name', { ...validResponsible, name: undefined }, false, ['name']],
    ['missing lastName', { ...validResponsible, lastName: undefined }, false, ['lastName']],
    ['missing department', { ...validResponsible, department: undefined }, false, ['department']],
    ['empty object', {}, false, ['id', 'name', 'lastName', 'department']],
  ])('%s', (_, input, shouldPass, fields) => {
    const result = responsibleSchema.safeParse(input);
    expect(result.success).toBe(shouldPass); // works for both!
    if (!result.success) assertErrorFields(result, fields);
  });
});
```

**Benefits**: 6 test cases in 5 lines, verifies exact error fields, 100% coverage achievable

---

## Application Layer - Pure Functions

File: `src/application/users/responsibility-options.test.ts`

```typescript
describe('buildResponsibilityOptions', () => {
  it('returns options with correct structure', () => {
    const options = buildResponsibilityOptions();
    expect(options).toHaveLength(Object.values(TaskType).length);
    expect(options.every((o) => 'value' in o && 'label' in o)).toBe(true);
  });
  it('returns same options on multiple calls', () => {
    expect(buildResponsibilityOptions()).toEqual(buildResponsibilityOptions());
  });
});
```

---

## Infrastructure Layer - Mock HTTP

File: `src/infrastructure/http/projects-repository.test.ts`

```typescript
vi.mock('~/infrastructure/http/axios', () => ({
  apiClient: { get: vi.fn(), patch: vi.fn() },
}));

describe('HttpProjectsRepository', () => {
  const mockGet = apiClient.get as unknown as ReturnType<typeof vi.fn>;
  beforeEach(() => vi.clearAllMocks());

  it('returns validated DTOs', async () => {
    mockGet.mockResolvedValue({ data: mockProjectCollectionHateoasDto, status: 200 });
    const result = await repository.fetchProjects();
    expect(result[0]).toHaveProperty('_links');
  });
});
```

---

## Presentation Layer - Mock Queries

File: `src/presentation/components/projects/projects-table/projects-table.test.tsx`

```typescript
const renderWithProviders = (ui: React.ReactNode) => {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  return render(<QueryClientProvider client={client}><MemoryRouter>{ui}</MemoryRouter></QueryClientProvider>);
};

describe('ProjectsTable', () => {
  let spyFetch: MockInstance;
  beforeEach(() => { spyFetch = vi.spyOn(ProjectQueries, 'fetchAllProjects'); });
  afterEach(() => { spyFetch.mockRestore(); });

  it('renders data', async () => {
    spyFetch.mockResolvedValue(mockProjectsList);
    renderWithProviders(<ProjectsTable />);
    expect(await screen.findByText(mockProjectsList[0].name)).toBeInTheDocument();
  });
});
```

---

## Key Points

| Layer          | Pattern            | Coverage Target |
| -------------- | ------------------ | --------------- |
| Domain         | it.each + fixtures | 100%            |
| Application    | Pure functions     | 90%+            |
| Infrastructure | Mock apiClient     | 80%+            |
| Presentation   | Mock queries       | 80%+            |

---

## References

- [Guidelines](../standards/testing-guidelines.md)
- [By Layer](../guides/testing-by-layer.md)
- [Patterns](../lookup/testing-patterns.md)
