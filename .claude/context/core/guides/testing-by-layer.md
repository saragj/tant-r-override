# Testing by Layer

**Purpose**: Testing patterns for each clean architecture layer

**Last Updated**: 2026-03-17

---

## Domain Layer

| Aspect   | Details                |
| -------- | ---------------------- |
| **Type** | Pure unit tests        |
| **Goal** | 100% coverage          |
| **Mock** | NONE - No dependencies |

**What to Test**: Entity validation, business rules, value objects, domain calculations

```typescript
describe('Project Entity', () => {
  it('creates valid project', () => {
    const project = new Project({ name: 'Test', code: 'TST' });
    expect(project.name).toBe('Test');
  });
});
```

---

## Application Layer

| Aspect   | Details                    |
| -------- | -------------------------- |
| **Type** | Unit tests                 |
| **Goal** | 90%+ coverage              |
| **Mock** | Repository interfaces only |

**What to Test**: Use case orchestration, error handling, data transformation

```typescript
describe('GetProjectsUseCase', () => {
  it('fetches projects from repository', async () => {
    const mockRepo = { findAll: vi.fn().mockResolvedValue([p1, p2]) };
    const result = await useCase.execute(mockRepo);
    expect(mockRepo.findAll).toHaveBeenCalled();
    expect(result).toHaveLength(2);
  });
});
```

---

## Infrastructure Layer

| Aspect   | Details                 |
| -------- | ----------------------- |
| **Type** | Integration tests       |
| **Goal** | 80%+ coverage           |
| **Mock** | apiClient (HTTP client) |

**What to Test**: HTTP requests, API → Domain transformation, error handling

```typescript
describe('ProjectsRepository', () => {
  it('fetches from correct endpoint', async () => {
    mockGet.mockResolvedValue({ data: [{ id: 1 }], status: 200 });
    await repository.findAll();
    expect(mockGet).toHaveBeenCalledWith('/projects');
  });
});
```

---

## Presentation Layer

| Aspect   | Details                   |
| -------- | ------------------------- |
| **Type** | Component/hook tests      |
| **Goal** | 80%+ coverage             |
| **Mock** | Query hooks/services only |

**What to Test**: Rendering, user interactions, loading/error states

```typescript
describe('ProjectsTable', () => {
  it('renders projects list', () => {
    vi.mocked(useProjects).mockReturnValue({ data: [p1], isLoading: false });
    render(<ProjectsTable />);
    expect(screen.getByText('Test')).toBeInTheDocument();
  });
});
```

---

## Mocking Boundaries

| Layer          | Mock What             | Don't Mock             |
| -------------- | --------------------- | ---------------------- |
| Domain         | Nothing               | N/A                    |
| Application    | Repository interfaces | Domain entities        |
| Infrastructure | apiClient             | Repositories, entities |
| Presentation   | Query hooks/services  | HTTP, repositories     |

### Anti-Patterns

- ❌ Mocking across layers (e.g., component mocking HTTP)
- ❌ Mocking internal helpers
- ❌ Making real API calls in unit tests

---

## Quick Decision Tree

```
Testing what layer?
├─ Domain → Real instances, no mocks
├─ Application → Mock repository interfaces
├─ Infrastructure → Mock apiClient
└─ Presentation → Mock query hooks/services
```

---

## References

- [Guidelines](../standards/testing-guidelines.md)
- [Examples](../examples/testing-examples.md)
- [Patterns](../lookup/testing-patterns.md)
