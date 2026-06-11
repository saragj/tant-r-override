# Testing Patterns Lookup

**Purpose**: Quick reference snippets for common patterns

**Last Updated**: 2026-03-17

---

## Domain - Schema Test

```typescript
describe('myEntitySchema', () => {
  it('parses valid entity', () => {
    const result = myEntitySchema.safeParse({ id: '1', name: 'Test' });
    expect(result.success).toBe(true);
  });
  it('rejects invalid', () => {
    expect(myEntitySchema.safeParse({ id: '1' }).success).toBe(false);
  });
});
```

---

## Application - Mock Repository

```typescript
describe('MyUseCase', () => {
  it('fetches data', async () => {
    const mockRepo = { findAll: vi.fn().mockResolvedValue([e1, e2]) };
    const result = await new MyUseCase(mockRepo).execute();
    expect(mockRepo.findAll).toHaveBeenCalled();
  });
});
```

---

## Infrastructure - Mock apiClient

```typescript
vi.mock('~/infrastructure/http/axios', () => ({
  apiClient: { get: vi.fn(), post: vi.fn() },
}));

describe('HttpRepository', () => {
  const mockGet = apiClient.get as unknown as ReturnType<typeof vi.fn>;
  beforeEach(() => vi.clearAllMocks());

  it('fetches from endpoint', async () => {
    mockGet.mockResolvedValue({ data: [{ id: 1 }], status: 200 });
    const result = await new HttpRepo().findAll();
    expect(mockGet).toHaveBeenCalledWith('/my-endpoint');
  });
});
```

---

## Presentation - Render with Providers

```typescript
const renderWithProviders = (ui: React.ReactNode) => {
  const client = new QueryClient({ defaultOptions: { queries: { retry: false } } });
  return render(<QueryClientProvider client={client}><MemoryRouter>{ui}</MemoryRouter></QueryClientProvider>);
};
```

### Mock Query Hook

```typescript
describe('MyComponent', () => {
  let spyFetch: MockInstance;
  beforeEach(() => { spyFetch = vi.spyOn(Module, 'fetchData'); });
  afterEach(() => { spyFetch.mockRestore(); });

  it('renders data', async () => {
    spyFetch.mockResolvedValue([item1]);
    renderWithProviders(<MyComponent />);
    expect(await screen.findByText('Item 1')).toBeInTheDocument();
  });
});
```

### Test Interaction

```typescript
it('submits form', async () => {
  fireEvent.change(screen.getByLabelText('Name'), { target: { value: 'Test' } });
  fireEvent.click(screen.getByRole('button', { name: 'Submit' }));
  await waitFor(() => {
    expect(mockSubmit).toHaveBeenCalledWith({ name: 'Test' });
  });
});
```

---

## Common Snippets

### AAA Pattern

```typescript
it('does X', () => {
  const mockFn = vi.fn();
  const result = myFunction(input, mockFn);
  expect(result).toBe(20);
  expect(mockFn).toHaveBeenCalled();
});
```

### Cleanup

```typescript
afterEach(() => {
  spy.mockRestore();
  vi.clearAllMocks();
});
```

### AG Grid Cell Renderer

```typescript
const createProps = <T>(data: T) => ({ data }) as CustomCellRendererProps<T, string>;
it('renders', () => { render(<MyCell {...createProps({ name: 'Test' })} />); });
```

---

## References

- [Guidelines](../standards/testing-guidelines.md)
- [By Layer](../guides/testing-by-layer.md)
- [Examples](../examples/testing-examples.md)
