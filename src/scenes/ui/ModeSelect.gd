class_name ModeSelect
extends Control

## Pantalla de seleccion de modo de juego.
## Modos: Historia, Contrarreloj, Practica, Multijugador (2-4 jugadores).

const MODE_DESCRIPTIONS: Dictionary = {
	"story": "Recorre las fases y resuelve los minijuegos antes de perder tus 3 vidas.",
	"endless": "Contrarreloj: sobrevive el mayor tiempo posible enfrentando minijuegos sin parar.",
	"practice": "Practica cualquier minijuego sin presion ni perdida de vidas.",
	"multiplayer": "Hasta 4 jugadores compiten por turnos en la misma ruleta de minijuegos.",
}

@onready var _story_button: Button = $VBoxContainer/StoryButton
@onready var _endless_button: Button = $VBoxContainer/EndlessButton
@onready var _practice_button: Button = $VBoxContainer/PracticeButton
@onready var _multiplayer_button: Button = $VBoxContainer/MultiplayerButton
@onready var _description_label: Label = $DescriptionPanel/DescriptionLabel
@onready var _player_stepper: HBoxContainer = $PlayerStepper
@onready var _player_count_label: Label = $PlayerStepper/PlayerCountLabel
@onready var _decrease_button: Button = $PlayerStepper/DecreaseButton
@onready var _increase_button: Button = $PlayerStepper/IncreaseButton
@onready var _confirm_multiplayer_button: Button = $PlayerStepper/ConfirmButton
@onready var _back_button: Button = $BackButton

var _player_count: int = 2
var _selected_mode: String = ""


func _ready() -> void:
	_story_button.pressed.connect(_on_mode_selected.bind("story"))
	_endless_button.pressed.connect(_on_mode_selected.bind("endless"))
	_practice_button.pressed.connect(_on_mode_selected.bind("practice"))
	_multiplayer_button.pressed.connect(_on_mode_selected.bind("multiplayer"))
	_decrease_button.pressed.connect(_on_decrease_players)
	_increase_button.pressed.connect(_on_increase_players)
	_confirm_multiplayer_button.pressed.connect(_on_confirm_multiplayer)
	_back_button.pressed.connect(_on_back_pressed)

	_player_stepper.visible = false
	_update_player_count_label()


func _on_mode_selected(mode: String) -> void:
	_selected_mode = mode
	_description_label.text = MODE_DESCRIPTIONS.get(mode, "")
	_player_stepper.visible = (mode == "multiplayer")

	if mode != "multiplayer":
		_confirm_start(mode)


func _on_decrease_players() -> void:
	_player_count = clampi(_player_count - 1, 2, 4)
	_update_player_count_label()


func _on_increase_players() -> void:
	_player_count = clampi(_player_count + 1, 2, 4)
	_update_player_count_label()


func _update_player_count_label() -> void:
	_player_count_label.text = "%d players" % _player_count


func _on_confirm_multiplayer() -> void:
	_confirm_start("multiplayer")


func _confirm_start(mode: String) -> void:
	GameController.start_game(mode)
	TransitionManager.go_to_scene("res://scenes/roulette/Roulette.tscn")


func _on_back_pressed() -> void:
	TransitionManager.go_to_scene("res://scenes/ui/MainMenu.tscn")
