class_name MiniGameBase
extends CanvasLayer

@export var mg_id: String = ""
@export var mg_name: String = ""
@export var base_time: float = 20.0
@export var instruction_text: String = ""
@export var instruction_icon: Texture2D

signal completed(score: int, time_left: float)
signal failed()

var _time_remaining: float
var _is_active: bool = false
var _difficulty_multiplier: float = 1.0
var _timer: Timer
var _instruction_panel: PanelContainer
var _timer_bar: ProgressBar
var _game_area: Control
var _hud: HBoxContainer

func _ready() -> void:
	_instruction_panel = $Control/VBoxContainer/InstructionPanel
	_timer_bar = $Control/VBoxContainer/TimerBar
	_game_area = $Control/VBoxContainer/GameArea
	_hud = $Control/VBoxContainer/HUD

	_instruction_panel.visible = false
	_setup_game()

func setup(difficulty_mult: float) -> void:
	_difficulty_multiplier = difficulty_mult
	_time_remaining = base_time / difficulty_mult

func show_instructions() -> void:
	_instruction_panel.visible = true
	var label = _instruction_panel.get_child(0).get_child(1)
	var icon = _instruction_panel.get_child(0).get_child(0)

	label.text = instruction_text
	if instruction_icon:
		icon.texture = instruction_icon

	await get_tree().create_timer(2.0).timeout
	_instruction_panel.visible = false
	start()

func start() -> void:
	_is_active = true
	_timer_bar.value = 100.0
	_timer_bar.max_value = _time_remaining
	_start_game()
	_start_timer()

func _start_timer() -> void:
	var timer = Timer.new()
	add_child(timer)
	_timer = timer

	timer.timeout.connect(_on_timer_tick)
	timer.start(0.016)

func _on_timer_tick() -> void:
	if not _is_active:
		return

	_time_remaining -= 0.016
	_timer_bar.value = _time_remaining

	if _time_remaining <= 0:
		_timer.queue_free()
		_on_time_up()

func _on_success() -> void:
	if not _is_active:
		return

	_is_active = false
	if _timer:
		_timer.queue_free()

	var score = GameController.current_score
	completed.emit(score, _time_remaining)
	_cleanup()

func _on_failure() -> void:
	if not _is_active:
		return

	_is_active = false
	if _timer:
		_timer.queue_free()

	failed.emit()
	_cleanup()

func _on_time_up() -> void:
	_on_failure()

func _setup_game() -> void:
	pass

func _start_game() -> void:
	pass

func _cleanup() -> void:
	pass
