<!-- Context: project-intelligence/technical | Priority: critical | Version: 1.0 | Updated: 2026-06-11 -->

# Technical Domain - Tant-R Override

**Purpose**: Tech stack, architecture, folder structure, naming conventions, and development rules.
**Last Updated**: 2026-06-11

## Quick Reference

**Update Triggers**: Stack changes | Folder restructure | Naming changes | New minigame added
**Audience**: Developers, AI agents, code reviewers
**Code patterns & examples** -> see `code-patterns.md`

## Primary Stack

| Layer | Technology | Version | Rationale |
|-------|-----------|---------|-----------|
| Engine | Godot Engine | 4.2.x LTS | Native mobile export, 3D + 2D, GDScript |
| Language | GDScript (typed) | 4.2 | Fast iteration, Godot-native, static typing |
| Renderer (dev) | Forward+ | — | Full features during development |
| Renderer (release) | Mobile | — | Optimized for target devices (Vulkan subset) |
| 3D Modeling | Blender | 3.6+ | Industry standard, free, glTF export |
| 3D Format | glTF 2.0 (.glb) | — | Godot-native import, binary, compact |
| Audio | Godot AudioServer | — | Low latency, bus mixing |
| Audio Format | OGG (music) + WAV (SFX) | — | Loop-friendly + low-latency |
| Backend | Firebase | — | Analytics, Crashlytics, Realtime DB |
| Testing | GUT (Godot Unit Testing) | latest | GDScript-native test framework |
| CI/CD | GitHub Actions | — | Auto-build via firebelley/godot-export |
| UI Design | Google Stitch + Blender | — | Mockups (Stitch) + Production (Blender) |
| Version Control | Git + GitHub | — | main/develop/feature/* branching |

## Target Platforms

| Platform | Min Version | Target Device | FPS Target |
|----------|------------|---------------|------------|
| iOS | 15.0+ | iPhone 12 | 60fps |
| Android | 10+ (API 29) | Samsung Galaxy A52 | 60fps |

## Folder Structure

```
res://
+-- autoloads/                    # Singleton scripts
|   +-- GameController.gd        # Game state machine, flow orchestration
|   +-- ScoreManager.gd          # Score calculation, combos, multipliers
|   +-- AudioManager.gd          # SFX pool, music crossfade, bus control
|   +-- SaveManager.gd           # Local persistence (user://save.json)
|   +-- TransitionManager.gd     # Scene transitions, wipes, flashes
+-- scenes/
|   +-- ui/                      # Menu screens, HUD, results
|   +-- minigames/
|   |   +-- base/               # MiniGameBase.tscn + MiniGameBase.gd
|   |   +-- mg{NN}_{name}/     # One folder per minigame (01-20)
|   +-- story/                   # PhaseIntro, BossEscape, FinalCapture
|   +-- bonus/                   # BalloonBurst bonus round
+-- assets/
|   +-- models/                  # glTF from Blender (.glb)
|   |   +-- characters/
|   |   +-- props/
|   |   +-- environments/
|   |   +-- minigames/
|   +-- textures/                # PBR textures
|   +-- materials/               # Godot .tres materials
|   +-- animations/              # AnimationLibrary .tres
|   +-- audio/sfx/              # Short WAV files
|   +-- audio/music/            # OGG loops
|   +-- fonts/                   # TTF/OTF
|   +-- shaders/                 # .gdshader files
|   +-- ui_sprites/              # 2D PNG for HUD overlay
+-- scripts/
|   +-- utils/                   # Helper scripts (screen_effects.gd, etc.)
|   +-- resources/               # Custom Resource class definitions
+-- tests/                       # GUT framework tests
    +-- unit/
    +-- integration/
    +-- minigames/
    +-- performance/
```

## Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Scripts | snake_case.gd | game_controller.gd |
| Classes | PascalCase (class_name) | class_name MiniGameBase |
| Functions | snake_case | func start_game() -> void |
| Variables | snake_case | var current_lives: int = 3 |
| Constants | UPPER_SNAKE | const MAX_LIVES: int = 3 |
| Signals | snake_case descriptive | signal life_lost() |
| Enums | PascalCase + UPPER values | enum GameState { MENU, PLAYING } |
| Exports | @export + type | @export var base_time: float = 20.0 |
| Nodes (tree) | PascalCase | TimerBar, GameArea, HUD |
| Scenes | PascalCase.tscn | MainMenu.tscn, LabyrinthRush.tscn |
| Resources | PascalCase.tres | MiniGameConfig.tres |
| Models | category_name_variant.glb | char_detective_tall.glb |
| Textures | model_type.png | char_detective_tall_albedo.png |
| Audio SFX | snake_case.wav | roulette_stop.wav |
| Audio Music | music_context.ogg | music_phase1_city.ogg |

## Architecture Rules (Strict)

1. **Singletons**: GameController, ScoreManager, AudioManager, SaveManager, TransitionManager are Autoloads.
2. **Signals only**: Systems communicate exclusively via signals. No direct method calls between unrelated systems.
3. **Scene inheritance**: All minigames MUST inherit MiniGameBase.tscn/gd.
4. **Resource configs**: Game data in .tres Resources, never hardcoded in scripts.
5. **Typed GDScript**: All functions MUST have typed parameters and return types.
6. **Mobile renderer compat**: All shaders/effects MUST work on Mobile renderer.
7. **No get_node() with absolute paths**: Use @onready, @export, or signals.
8. **Max 200 lines per script**: Extract to components/classes if exceeded.

## Performance Budgets

| Metric | Target | Hard Limit |
|--------|--------|-----------|
| FPS | 60fps stable | >55fps min |
| Input lag | <50ms | <80ms |
| Scene load | <300ms | <500ms |
| RAM | <200MB | <250MB |
| Build size | <250MB | <300MB |
| Draw calls/scene | <50 | <80 |
| Triangles visible | <30,000 | <50,000 |
| Particles simultaneous | <100 | <150 |

## Escalation Triggers

**STOP AND ASK** before:
- Adding a new Autoload singleton
- Changing GameController state machine states
- Modifying signal signatures on MiniGameBase
- Adding new minigame categories beyond the 5 defined
- Changing the scene transition flow
- Modifying SaveManager data structure (backward compat risk)
- Any change that affects all 20 minigames simultaneously

## Related Files

- `code-patterns.md` — GDScript code examples for every pattern
- `business-domain.md` — Game design context and DESIGN.MD summary
- `decisions-log.md` — Major architectural decisions
