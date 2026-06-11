<!-- Context: project/project-context | Priority: high | Version: 2.0 | Updated: 2026-06-11 -->

# Tant-R Override — Project Context

## Technology Stack

**Engine:** Godot Engine 4.x (4.2+ LTS)
**Language:** GDScript (typed)
**Renderer:** Forward+ (dev) / Mobile (release)
**3D Pipeline:** Blender 3.6+ → glTF 2.0 (.glb) → Godot Import
**Platforms:** iOS 15+ / Android 10+ (API 29)
**Backend:** Firebase (Analytics, Crashlytics, Realtime DB)
**Testing:** GUT (Godot Unit Testing)
**CI/CD:** GitHub Actions + firebelley/godot-export
**Design Authority:** DESIGN.MD (absolute source of truth for game design)

## Project Structure

```
/                          # Repository root
├── DESIGN.md              # Game Design Document (AUTHORITY)
├── TantR_Modern_PRD_v1.md # Product Requirements Document
├── TantR_Modern_Tasks_v1.md # Sprint-based task plan
├── opencode.json          # OpenCode configuration
└── opencode/              # AI agent system
    ├── agent/
    │   ├── core/          # Primary orchestrator agents
    │   └── subagents/
    │       ├── gamedev/   # Game-specific agents (7 agents)
    │       ├── code/      # Generic code agents
    │       └── core/      # Core utility agents
    └── context/
        ├── project/       # Project-specific patterns
        └── project-intelligence/ # Domain knowledge
```

## Core Design Principles

1. **DESIGN.MD is absolute authority** for all game design decisions
2. **Godot patterns**: Singletons, Signals, Scene inheritance, Resources
3. **Mobile-first**: 60fps on mid-range, <50ms input lag, <250MB build
4. **3D Stylized**: Chibi-High-Poly, tilt-shift, neon accents (Fall Guys aesthetic)
5. **Typed GDScript**: All functions must declare types
6. **Signal-only communication**: Between decoupled systems

## Agent System

| Agent | Role |
|-------|------|
| Orchestrator (OpenCoder) | Coordinate, delegate, validate |
| Game_Design_Agent | Validate against DESIGN.MD (absolute) |
| Lead_Developer_Agent | GDScript implementation, Godot architecture |
| QA_Agent | Testing, performance, regression |
| Audio_Agent | SFX, music, AudioManager |
| VFX_Shader_Agent | Shaders, particles, post-processing |
| Asset_Pipeline_Agent | Blender→Godot pipeline, optimization |
| Narrative_Level_Agent | Story, levels, progression |

## Quality Gates

- GUT tests pass (unit + integration)
- 60fps on Samsung A52 / iPhone 12
- Input lag < 50ms
- Build exports without errors (iOS + Android)
- Game_Design_Agent validates design compliance
- QA_Agent certifies build
