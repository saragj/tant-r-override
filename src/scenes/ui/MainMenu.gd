class_name MainMenu
extends Control

## Pantalla de menu principal. Logo cae con bounce, musica en loop,
## botones PLAY / LEADERBOARD / SETTINGS.

@onready var _logo: Control = $Logo
@onready var _play_button: Button = $VBoxContainer/PlayButton
@onready var _leaderboard_button: Button = $VBoxContainer/LeaderboardButton
@onready var _settings_button: Button = $VBoxContainer/SettingsButton

const LOGO_START_Y: float = -200.0
const LOGO_END_Y: float = 80.0


func _ready() -> void:
	_play_button.pressed.connect(_on_play_pressed)
	_leaderboard_button.pressed.connect(_on_leaderboard_pressed)
	_settings_button.pressed.connect(_on_settings_pressed)

	AudioManager.play_music("menu")
	_animate_logo_entrance()


func _animate_logo_entrance() -> void:
	_logo.position.y = LOGO_START_Y
	_logo.modulate.a = 0.0

	var tween: Tween = create_tween()
	tween.tween_property(_logo, "modulate:a", 1.0, 0.2)
	tween.parallel().tween_property(_logo, "position:y", LOGO_END_Y, 0.6).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)


func _on_play_pressed() -> void:
	TransitionManager.go_to_scene("res://scenes/ui/ModeSelect.tscn")


func _on_leaderboard_pressed() -> void:
	# TODO: implementar pantalla de Leaderboard (extension pendiente de
	# definicion en DESIGN.MD; placeholder funcional por ahora).
	pass


func _on_settings_pressed() -> void:
	# TODO: implementar pantalla de Settings (Sprint posterior).
	pass
