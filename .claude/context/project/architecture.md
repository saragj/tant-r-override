# Architecture - Godot 4.x Scene-Based + Singleton Pattern

> Pattern reference for Tant-R Override | Last Updated: Jun 2026

## Engine & Renderer

| Aspect | Choice | Rationale |
|--------|--------|-----------|
| Engine | Godot 4.x (4.2+ LTS) | Native iOS/Android export, full 3D |
| Renderer (dev) | Forward+ | Full features during development |
| Renderer (release) | Mobile | Optimized for target devices |
| Language | GDScript (typed) | Fast iteration, Godot-native |

## Scene Tree Architecture

```
Root
+-- GameController        (Autoload Singleton)
+-- ScoreManager          (Autoload Singleton)
+-- AudioManager          (Autoload Singleton)
+-- SaveManager           (Autoload Singleton)
+-- TransitionManager     (Autoload Singleton)
+-- CurrentScene          (managed by SceneTree)
    +-- UI Scenes (MainMenu, ModeSelect, etc.)
    +-- Gameplay Scenes (Roulette, MiniGames, Bonus)
    +-- Story Scenes (PhaseIntro, BossEscape, FinalCapture)
```

## Project Folder Structure

```
res://
+-- autoloads/            # Singleton scripts (.gd)
+-- scenes/
|   +-- ui/              # Menu, HUD, Results screens (.tscn)
|   +-- minigames/
|   |   +-- base/       # MiniGameBase.tscn + .gd
|   |   +-- mg01_.../   # One folder per minigame
|   +-- story/           # Cinematics, phase intros
|   +-- bonus/           # Bonus round scenes
+-- assets/
|   +-- models/          # 3D models (.glb from Blender)
|   +-- textures/        # PBR textures, atlases
|   +-- materials/       # Godot .tres materials
|   +-- animations/      # AnimationLibrary .tres
|   +-- audio/
|   |   +-- sfx/        # Short sounds (.wav)
|   |   +-- music/      # Background tracks (.ogg)
|   +-- fonts/           # .ttf/.otf
|   +-- shaders/         # .gdshader files
|   +-- ui_sprites/      # 2D HUD elements (.png)
+-- scripts/
|   +-- utils/           # Helper scripts
|   +-- resources/       # Custom Resource class definitions
+-- tests/               # GUT framework tests
```

## Core Design Patterns

### 1. Singleton Autoloads
Global managers accessible via name anywhere:
```gdscript
GameController.start_game("story")
ScoreManager.add_score(1000)
AudioManager.play_sfx("success")
```

### 2. Signal-Based Communication
Systems communicate ONLY through signals (decoupled):
```gdscript
# Emitter
signal minigame_completed(score: int, time_left: float)

# Listener (in _ready)
GameController.minigame_completed.connect(_on_mg_completed)
```

### 3. Scene Inheritance (MiniGameBase)
All minigames inherit from MiniGameBase:
```
MiniGameBase.tscn
  +-- LabyrinthRush.tscn (inherits)
  +-- FreezeTimer.tscn (inherits)
  +-- ... (20 total)
```

### 4. Resource-Based Configuration
Game data stored in .tres resources (not hardcoded):
```gdscript
class_name MiniGameConfig extends Resource
@export var mg_id: String
@export var base_time: float
@export var category: MiniGameCategory
```

### 5. State Machine (GameController)
```gdscript
enum GameState {
  MENU, MODE_SELECT, PHASE_INTRO, ROULETTE,
  MINIGAME_INTRO, MINIGAME_ACTIVE, MINIGAME_RESULT,
  BONUS_STAGE, PHASE_RESULT, BOSS_ESCAPE,
  FINAL_CONFRONTATION, GAME_OVER, VICTORY
}
```

## Data Flow

```
Player Input (touch/gesture)
       |
       v
MiniGame Scene (_input / _unhandled_input)
       |
       v  (signal: completed/failed)
GameController (state machine)
       |
       +---> ScoreManager (calculate + store)
       +---> AudioManager (play feedback SFX)
       +---> TransitionManager (next scene)
       +---> SaveManager (persist progress)
```

## Mobile-First Rules

- Touch targets: minimum 44pt
- Input processing: always in _input(), never _process()
- Scene preloading: next scene loaded during current
- Object pooling: for repeated elements (particles, projectiles)
- Pause game loop between minigames (battery)
- Portrait locked (1080x1920 native)

## Reference

- Godot 4.x Docs: https://docs.godotengine.org/en/stable/
- GDScript Reference: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/
- Mobile Optimization: https://docs.godotengine.org/en/stable/tutorials/performance/
