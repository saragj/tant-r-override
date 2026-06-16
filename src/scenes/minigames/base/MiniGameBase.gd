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
var _total_time: float
var _is_active: bool = false
var _difficulty_multiplier: float = 1.0

var _instruction_panel: PanelContainer
var _timer_bar: TimerBar
var _game_area: Control
var _hud: HBoxContainer
var _score_display: Label


func _ready() -> void:
	_instruction_panel = $Control/VBoxContainer/InstructionPanel
	_timer_bar = $Control/VBoxContainer/TimerBar
	_game_area = $Control/VBoxContainer/GameArea
	_hud = $Control/VBoxContainer/HUD
	_score_display = $Control/VBoxContainer/HUD/ScoreDisplay

	_instruction_panel.visible = false
	_timer_bar.timer_finished.connect(_on_time_up)

	# Default total time until setup() is called
	_total_time = base_time
	_time_remaining = base_time

	_setup_game()


func _process(_delta: float) -> void:
	if not _is_active:
		return

	_time_remaining = _timer_bar.get_time_remaining()


# Configura el tiempo según la dificultad de la fase actual.
# difficulty_mult: 0.8 (fase 1) → 0.9 (fase 2) → 1.0 (fase 3)
# El tiempo disminuye a medida que aumenta la dificultad:
#   fase 1 = base_time, fase 2 = base_time × 0.9, fase 3 = base_time × 0.8
func setup(difficulty_mult: float) -> void:
	_difficulty_multiplier = difficulty_mult
	var time_factor: float = clampf(1.8 - difficulty_mult, 0.8, 1.0)
	_total_time = base_time * time_factor
	_time_remaining = _total_time


func show_instructions() -> void:
	_instruction_panel.visible = true

	var hbox: HBoxContainer = _instruction_panel.get_child(0).get_child(0)
	var icon: TextureRect = hbox.get_child(0) as TextureRect
	var label: Label = hbox.get_child(1) as Label

	label.text = instruction_text
	if instruction_icon and icon:
		icon.texture = instruction_icon

	await get_tree().create_timer(2.0).timeout
	_instruction_panel.visible = false
	start()


func start() -> void:
	_is_active = true
	_timer_bar.start_timer(_total_time)
	_start_game()


func _on_success() -> void:
	if not _is_active:
		return

	_is_active = false
	_timer_bar.pause_timer()

	var score: int = ScoreManager.calculate_score(
		100, _time_remaining, _total_time, GameController.combo_count
	)
	AudioManager.play_sfx("success")
	completed.emit(score, _time_remaining)
	_cleanup()


func _on_failure() -> void:
	if not _is_active:
		return

	_is_active = false
	_timer_bar.pause_timer()
	_flash_error()
	AudioManager.play_sfx("fail")
	failed.emit()
	_cleanup()


func _on_time_up() -> void:
	_on_failure()


# Efecto visual de error: destella en rojo y vuelve al color normal.
func _flash_error() -> void:
	var control: Control = $Control
	var tween: Tween = create_tween()
	tween.tween_property(control, "modulate", Color(1.0, 0.2, 0.2), 0.1)
	tween.tween_property(control, "modulate", Color.WHITE, 0.25)


# Virtual — cada minijuego inicializa sus elementos aquí.
func _setup_game() -> void:
	pass


# Virtual — activa la mecánica del minijuego.
func _start_game() -> void:
	pass


# Virtual — limpia el estado al terminar.
func _cleanup() -> void:
	pass
