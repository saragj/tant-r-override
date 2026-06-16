class_name GameOver
extends Control

## Pantalla de fin de partida. Cuenta el score final con animacion,
## compara con el high score guardado y muestra celebracion si hay record.

@onready var _score_label: Label = $VBoxContainer/ScoreLabel
@onready var _record_label: Label = $VBoxContainer/RecordLabel
@onready var _mood_label: Label = $VBoxContainer/MoodLabel
@onready var _retry_button: Button = $VBoxContainer/ButtonRow/RetryButton
@onready var _menu_button: Button = $VBoxContainer/ButtonRow/MenuButton
@onready var _leaderboard_button: Button = $VBoxContainer/ButtonRow/LeaderboardButton

const COUNT_DURATION: float = 1.2

var _final_score: int = 0
var _mode: String = "story"


func _ready() -> void:
	_retry_button.pressed.connect(_on_retry_pressed)
	_menu_button.pressed.connect(_on_menu_pressed)
	_leaderboard_button.pressed.connect(_on_leaderboard_pressed)

	_final_score = GameController.current_score
	_mode = GameController.current_mode if GameController.current_mode != "" else "story"

	_setup_result()


func _setup_result() -> void:
	var previous_high: int = SaveManager.get_high_score(_mode)
	var is_new_record: bool = _final_score > previous_high

	SaveManager.save_high_score(_mode, _final_score)

	_mood_label.text = "¡Nuevo record! Los detectives celebran." if is_new_record else "Los detectives lo intentaran de nuevo..."
	_record_label.visible = is_new_record
	_record_label.text = "NEW RECORD!" if is_new_record else ""

	_animate_score_count()


func _animate_score_count() -> void:
	_score_label.text = "0"
	var tween: Tween = create_tween()
	tween.tween_method(_update_score_label, 0, _final_score, COUNT_DURATION)


func _update_score_label(value: int) -> void:
	_score_label.text = str(value)


func _on_retry_pressed() -> void:
	GameController.start_game(_mode)
	TransitionManager.go_to_scene("res://scenes/roulette/Roulette.tscn")


func _on_menu_pressed() -> void:
	TransitionManager.go_to_scene("res://scenes/ui/MainMenu.tscn")


func _on_leaderboard_pressed() -> void:
	# TODO: implementar pantalla de Leaderboard (extension pendiente).
	pass
