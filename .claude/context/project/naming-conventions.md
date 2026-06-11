# Naming Conventions - Tant-R Override

> Quick reference for Godot 4.x / GDScript | Last Updated: Jun 2026

## Scripts & Classes

| Type | Pattern | Example |
|------|---------|---------|
| Script files | snake_case.gd | game_controller.gd, score_manager.gd |
| Class names | PascalCase | class_name MiniGameBase, class_name TimerBar |
| Functions | snake_case | func start_game() -> void |
| Variables | snake_case | var current_lives: int = 3 |
| Constants | UPPER_SNAKE | const MAX_LIVES: int = 3 |
| Signals | snake_case_descriptive | signal life_lost(), signal minigame_completed() |
| Enums | PascalCase + UPPER values | enum GameState { MENU, PLAYING, GAME_OVER } |
| Exports | @export + typed | @export var base_time: float = 20.0 |
| Private vars | _prefixed | var _time_remaining: float |
| Virtual funcs | _prefixed | func _setup_game() -> void |

## Scenes & Nodes

| Type | Pattern | Example |
|------|---------|---------|
| Scene files | PascalCase.tscn | MainMenu.tscn, LabyrinthRush.tscn |
| Node names | PascalCase | TimerBar, GameArea, HUD, InstructionPanel |
| Resource files | PascalCase.tres | MiniGameConfig.tres, mat_toon_base.tres |
| Autoload names | PascalCase | GameController, ScoreManager, AudioManager |

## Assets - 3D Models

| Type | Pattern | Example |
|------|---------|---------|
| Characters | char_{name}_{variant}.glb | char_detective_tall.glb |
| Props | prop_{name}_{variant}.glb | prop_balloon_red.glb |
| Environments | env_{world}_{element}.glb | env_city_bigben.glb |
| Minigame assets | mg{NN}_{name}_{element}.glb | mg01_labyrinth_walls.glb |

## Assets - Textures

| Type | Pattern | Example |
|------|---------|---------|
| Albedo/Diffuse | {model}_albedo.png | char_detective_tall_albedo.png |
| Normal map | {model}_normal.png | char_detective_tall_normal.png |
| Emission | {model}_emission.png | prop_neon_sign_emission.png |
| UI elements | hud_{name}_{state}.png | hud_heart_full.png |

## Assets - Audio

| Type | Pattern | Example |
|------|---------|---------|
| SFX (system) | {event}.wav | success.wav, fail.wav, lucky.wav |
| SFX (minigame) | mg{NN}_{action}.wav | mg07_tap_button.wav |
| SFX (UI) | ui_{action}.wav | ui_btn_press.wav |
| Music tracks | music_{context}.ogg | music_phase1_city.ogg |

## Assets - Materials & Shaders

| Type | Pattern | Example |
|------|---------|---------|
| Materials | mat_{name}.tres | mat_toon_base.tres, mat_neon_emissive.tres |
| Shaders | {effect}.gdshader | tilt_shift.gdshader, toon_character.gdshader |

## Folder Structure

```
res://
+-- autoloads/           # Singleton scripts only
+-- scenes/
|   +-- ui/             # PascalCase.tscn
|   +-- minigames/
|   |   +-- base/      # MiniGameBase.tscn
|   |   +-- mg{NN}_{snake_name}/
|   +-- story/
|   +-- bonus/
+-- assets/
|   +-- models/{category}/
|   +-- textures/{category}/
|   +-- materials/
|   +-- animations/
|   +-- audio/{sfx|music}/
|   +-- fonts/
|   +-- shaders/
|   +-- ui_sprites/
+-- scripts/
|   +-- utils/
|   +-- resources/      # Custom Resource class definitions
+-- tests/
    +-- unit/
    +-- integration/
    +-- minigames/
```

## Commit Messages

```
feat(s1): implement GameController singleton [S1-T01]
feat(mg01): labyrinth rush minigame core [S1-T16]
fix(roulette): lucky icon probability off by one [S1-T10]
test(score): add speed bonus unit tests [S6-T07]
chore(s0): setup project structure and export presets [S0-T05]
asset(char): add detective tall model [S0-T08]
shader(vfx): implement tilt-shift post-process [S5-T01]
audio(sfx): add core system sound effects [S2-T10]
```
