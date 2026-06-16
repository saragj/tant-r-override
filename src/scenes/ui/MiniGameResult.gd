class_name MiniGameResult
extends Control

## Pantalla intermedia post-minijuego. Muestra SUCCESS/FAIL durante 1.5s
## de forma automatica y luego emite continue_requested() para que el
## GameController avance a la ruleta o al siguiente minijuego.

signal continue_requested()

const DISPLAY_TIME: float = 1.5

const FAIL_MESSAGES: Array[String] = [
	"¡Casi! Vuelve a intentarlo.",
	"El detective se resbalo... ¡pero no se rinde!",
	"Una pista se escapo, pero hay mas por descubrir.",
]

@onready var _result_label: Label = $VBoxContainer/ResultLabel
@onready var _detail_label: Label = $VBoxContainer/DetailLabel
@onready var _heart_icon: Control = $VBoxContainer/HeartIcon


func _ready() -> void:
	continue_requested.connect(_on_continue_requested)
	if GameController.last_minigame_success:
		show_success(GameController.last_minigame_score, GameController.combo_count)
	else:
		show_failure()


func _on_continue_requested() -> void:
	if GameController.current_lives <= 0:
		TransitionManager.go_to_scene("res://scenes/ui/GameOver.tscn")
	else:
		GameController.load_next_minigame()


func show_success(score: int, combo: int) -> void:
	_result_label.text = "SUCCESS"
	_result_label.modulate = Color(0.2, 0.9, 0.4)
	_heart_icon.visible = false

	var combo_text: String = (" x%d COMBO!" % combo) if combo >= 3 else ""
	_detail_label.text = "+%d pts%s" % [score, combo_text]

	_animate_in()
	await get_tree().create_timer(DISPLAY_TIME).timeout
	continue_requested.emit()


func show_failure() -> void:
	_result_label.text = "FAIL"
	_result_label.modulate = Color(0.9, 0.2, 0.2)
	_heart_icon.visible = true
	_animate_broken_heart()

	_detail_label.text = FAIL_MESSAGES[randi() % FAIL_MESSAGES.size()]

	_animate_in()
	await get_tree().create_timer(DISPLAY_TIME).timeout
	continue_requested.emit()


func _animate_in() -> void:
	modulate.a = 0.0
	scale = Vector2(0.85, 0.85)
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.15)
	tween.parallel().tween_property(self, "scale", Vector2(1.0, 1.0), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func _animate_broken_heart() -> void:
	_heart_icon.rotation = 0.0
	var tween: Tween = create_tween()
	tween.tween_property(_heart_icon, "rotation", -0.3, 0.1)
	tween.tween_property(_heart_icon, "rotation", 0.3, 0.1)
	tween.tween_property(_heart_icon, "rotation", 0.0, 0.1)
