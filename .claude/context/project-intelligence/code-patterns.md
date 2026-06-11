<!-- Context: project-intelligence/code-patterns | Priority: high | Version: 1.0 | Updated: 2026-06-11 -->

# Code Patterns - Tant-R Override (GDScript)

**Purpose**: Concrete code examples for every architectural pattern used in the project.
**Last Updated**: 2026-06-11

## 1. Autoload Singleton Pattern

```gdscript
# autoloads/GameController.gd
extends Node

## Signals
signal minigame_completed(score: int, time_left: float)
signal life_lost()
signal life_gained()
signal lucky_triggered(minigame_id: String)
signal phase_completed(phase: int, total_score: int)
signal game_over(final_score: int)

## State
enum GameState {
  MENU, MODE_SELECT, PHASE_INTRO, ROULETTE,
  MINIGAME_INTRO, MINIGAME_ACTIVE, MINIGAME_RESULT,
  BONUS_STAGE, PHASE_RESULT, BOSS_ESCAPE,
  FINAL_CONFRONTATION, GAME_OVER, VICTORY
}

var state: GameState = GameState.MENU
var current_lives: int = 3
var current_phase: int = 1
var current_score: int = 0
var combo_count: int = 0
var lucky_fragments: int = 0
var current_mode: String = ""  # "story"|"endless"|"practice"|"multiplayer"


## Public API
func start_game(mode: String) -> void:
  current_mode = mode
  current_lives = 3
  current_score = 0
  combo_count = 0
  lucky_fragments = 0
  current_phase = 1
  _change_state(GameState.PHASE_INTRO)


func on_minigame_success(score: int, time_left: float) -> void:
  combo_count += 1
  var final_score := ScoreManager.calculate_score(score, time_left, combo_count)
  current_score += final_score
  minigame_completed.emit(final_score, time_left)
  _change_state(GameState.MINIGAME_RESULT)


func on_minigame_failure() -> void:
  combo_count = 0
  current_lives -= 1
  life_lost.emit()
  if current_lives <= 0:
    game_over.emit(current_score)
    _change_state(GameState.GAME_OVER)
  else:
    _change_state(GameState.MINIGAME_RESULT)


## Private
func _change_state(new_state: GameState) -> void:
  state = new_state
  match state:
    GameState.ROULETTE:
      TransitionManager.transition_to("res://scenes/ui/Roulette.tscn")
    GameState.GAME_OVER:
      TransitionManager.transition_to("res://scenes/ui/GameOver.tscn")
    _:
      pass  # Handle other states
```

## 2. MiniGameBase Pattern (Scene Inheritance)

```gdscript
# scenes/minigames/base/MiniGameBase.gd
class_name MiniGameBase
extends Control

## Configuration (override per minigame)
@export var mg_id: String = ""
@export var mg_name: String = ""
@export var base_time: float = 20.0
@export var instruction_text: String = ""
@export var instruction_icon: Texture2D

## Internal state
var _time_remaining: float = 0.0
var _is_active: bool = false
var _difficulty_multiplier: float = 1.0

## Signals
signal completed(score: int, time_left: float)
signal failed()

## Node references
@onready var timer_bar: ProgressBar = $TimerBar
@onready var instruction_panel: Control = $InstructionPanel
@onready var game_area: Control = $GameArea


## Lifecycle (call in order)
func setup(difficulty_mult: float) -> void:
  _difficulty_multiplier = difficulty_mult
  _time_remaining = base_time * difficulty_mult
  _setup_game()  # Virtual: each MG implements


func show_instructions() -> void:
  instruction_panel.visible = true
  await get_tree().create_timer(2.0).timeout
  instruction_panel.visible = false
  start()


func start() -> void:
  _is_active = true
  timer_bar.start_timer(_time_remaining)
  _start_game()  # Virtual: each MG implements


func _on_success() -> void:
  _is_active = false
  var score := 1000  # Base score
  completed.emit(score, _time_remaining)


func _on_failure() -> void:
  _is_active = false
  failed.emit()


func _on_time_up() -> void:
  _on_failure()


## Virtual hooks (MUST override in child)
func _setup_game() -> void:
  pass

func _start_game() -> void:
  pass

func _cleanup() -> void:
  pass
```

## 3. Concrete Minigame Example

```gdscript
# scenes/minigames/mg07_tap_frenzy/TapFrenzy.gd
extends MiniGameBase

const MIN_TAP_INTERVAL: float = 0.08  # 80ms anti-spam

var _tap_count: int = 0
var _target_count: int = 15
var _last_tap_time: float = 0.0

@onready var tap_button: Button = $GameArea/TapButton
@onready var counter_label: Label = $GameArea/CounterLabel
@onready var progress_bar: ProgressBar = $GameArea/TapProgress


func _setup_game() -> void:
  match int(_difficulty_multiplier * 10):
    10: _target_count = 15   # Phase 1
    8:  _target_count = 20   # Phase 2
    6:  _target_count = 25   # Phase 3
    _:  _target_count = 30   # Phase 4
  _tap_count = 0
  counter_label.text = "0 / %d" % _target_count
  progress_bar.max_value = _target_count
  progress_bar.value = 0


func _start_game() -> void:
  tap_button.pressed.connect(_on_button_tapped)


func _on_button_tapped() -> void:
  if not _is_active:
    return
  var now := Time.get_ticks_msec() / 1000.0
  if now - _last_tap_time < MIN_TAP_INTERVAL:
    return  # Anti-spam
  _last_tap_time = now
  _tap_count += 1
  counter_label.text = "%d / %d" % [_tap_count, _target_count]
  progress_bar.value = _tap_count
  AudioManager.play_sfx("tap_button")
  if _tap_count >= _target_count:
    _on_success()


func _cleanup() -> void:
  tap_button.pressed.disconnect(_on_button_tapped)
```

## 4. Custom Resource Pattern

```gdscript
# scripts/resources/minigame_config.gd
class_name MiniGameConfig
extends Resource

enum Category { PUZZLE, COUNTING, MEMORY, BARRAGE, PICTURE_SEARCH }

@export var mg_id: String = ""
@export var mg_name: String = ""
@export var category: Category = Category.PUZZLE
@export var base_time: float = 20.0
@export var instruction_text: String = ""
@export var instruction_icon: Texture2D
@export var scene_path: String = ""
@export var difficulty_time_multipliers: Array[float] = [1.0, 0.8, 0.65, 0.5]
@export var min_difficulty_stars: int = 1
@export var max_difficulty_stars: int = 5
```

## 5. Signal Connection Pattern

```gdscript
# Connecting in _ready (preferred)
func _ready() -> void:
  GameController.life_lost.connect(_on_life_lost)
  GameController.life_gained.connect(_on_life_gained)


func _on_life_lost() -> void:
  _animate_heart_break()


func _on_life_gained() -> void:
  _animate_heart_appear()


# Cleanup when needed
func _exit_tree() -> void:
  if GameController.life_lost.is_connected(_on_life_lost):
    GameController.life_lost.disconnect(_on_life_lost)
```

## 6. Scene Transition Pattern

```gdscript
# autoloads/TransitionManager.gd
extends CanvasLayer

enum TransitionType { WIPE_LEFT, WIPE_RIGHT, FLASH_WHITE, FLASH_BLACK, FADE }

@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer

var _next_scene: String = ""


func transition_to(scene_path: String, type: TransitionType = TransitionType.FADE) -> void:
  _next_scene = scene_path
  match type:
    TransitionType.FADE:
      anim_player.play("fade_out")
    TransitionType.WIPE_LEFT:
      anim_player.play("wipe_left")
    TransitionType.FLASH_WHITE:
      anim_player.play("flash_white")
  await anim_player.animation_finished
  get_tree().change_scene_to_file(_next_scene)
  anim_player.play("fade_in")
```

## 7. Save/Load Pattern

```gdscript
# autoloads/SaveManager.gd
extends Node

const SAVE_PATH: String = "user://save.json"

var _data: Dictionary = {}


func _ready() -> void:
  _data = load_game()


func save_game() -> void:
  var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
  if file:
    file.store_string(JSON.stringify(_data, "\t"))
    file.close()


func load_game() -> Dictionary:
  if not FileAccess.file_exists(SAVE_PATH):
    return _get_default_data()
  var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
  var json := JSON.new()
  var error := json.parse(file.get_as_text())
  file.close()
  if error != OK:
    return _get_default_data()
  return json.data


func _get_default_data() -> Dictionary:
  return {
    "high_scores": {"story": 0, "endless": 0},
    "unlocked_minigames": ["mg01"],
    "unlocked_skins": [],
    "lucky_fragments": 0,
    "stats": {},
    "settings": {"sfx_volume": 0.8, "music_volume": 0.7, "master_volume": 1.0}
  }
```

## 8. Input Handling Pattern (Mobile)

```gdscript
# Touch drag for movement (Labyrinth Rush)
func _input(event: InputEvent) -> void:
  if not _is_active:
    return
  if event is InputEventScreenDrag:
    var drag := event as InputEventScreenDrag
    _handle_drag(drag.relative)
  elif event is InputEventScreenTouch:
    var touch := event as InputEventScreenTouch
    if touch.pressed:
      _handle_tap(touch.position)


func _handle_drag(relative: Vector2) -> void:
  # Convert screen drag to game movement
  var direction := Vector2.ZERO
  if abs(relative.x) > abs(relative.y):
    direction = Vector2.RIGHT if relative.x > 0 else Vector2.LEFT
  else:
    direction = Vector2.DOWN if relative.y > 0 else Vector2.UP
  _move_player(direction)
```

## 9. Timer Bar Component

```gdscript
# scripts/utils/timer_bar.gd
class_name TimerBar
extends ProgressBar

signal timer_finished()

var _duration: float = 0.0
var _time_remaining: float = 0.0
var _running: bool = false


func start_timer(duration: float) -> void:
  _duration = duration
  _time_remaining = duration
  max_value = duration
  value = duration
  _running = true


func pause_timer() -> void:
  _running = false


func get_time_remaining() -> float:
  return _time_remaining


func _process(delta: float) -> void:
  if not _running:
    return
  _time_remaining -= delta
  value = _time_remaining
  _update_color()
  if _time_remaining <= 0.0:
    _running = false
    timer_finished.emit()


func _update_color() -> void:
  var ratio := _time_remaining / _duration
  if ratio > 0.5:
    modulate = Color.GREEN
  elif ratio > 0.25:
    modulate = Color.YELLOW
  else:
    modulate = Color.RED
```

## 10. GUT Test Pattern

```gdscript
# tests/unit/test_score_manager.gd
extends GutTest

var score_mgr: ScoreManager


func before_each() -> void:
  score_mgr = ScoreManager.new()
  add_child(score_mgr)


func after_each() -> void:
  score_mgr.queue_free()


func test_speed_bonus_above_50_percent() -> void:
  var result := score_mgr.get_speed_multiplier(12.0, 20.0)
  assert_eq(result, 2.0, "Should get x2 when >50% time remaining")


func test_speed_bonus_below_50_percent() -> void:
  var result := score_mgr.get_speed_multiplier(8.0, 20.0)
  assert_eq(result, 1.0, "Should get x1 when <50% time remaining")


func test_combo_multiplier_at_3() -> void:
  var result := score_mgr.get_combo_multiplier(3)
  assert_eq(result, 1.5, "Should get x1.5 at combo 3")


func test_combo_multiplier_below_3() -> void:
  var result := score_mgr.get_combo_multiplier(2)
  assert_eq(result, 1.0, "Should get x1 below combo 3")
```
