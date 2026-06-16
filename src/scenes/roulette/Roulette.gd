class_name Roulette
extends Control

## Pantalla de ruleta: 4 SlotCards giran como una slot machine.
## El jugador toca "TAP TO STOP!" para detenerla. Tras una animacion de
## desaceleracion, se elige un minijuego al azar entre los disponibles y
## se emite selected(). Hay 10% de probabilidad de activar "Lucky!".

signal selected(minigame_id: String, is_lucky: bool)

const LUCKY_CHANCE: float = 0.1
const MIN_SPIN_SPEED: float = 0.05
const MAX_SPIN_SPEED: float = 0.22
const STOP_ANIM_TIME: float = 1.5

## Iconos placeholder por minijuego (mg_id -> texto). Sustituir por
## Texture2D reales cuando exista arte definitivo.
const MG_LABELS: Dictionary = {
	"mg01": "Laberinto",
	"mg02": "Crono",
	"mg03": "Eco Animal",
	"mg04": "MG04",
	"mg05": "MG05",
	"mg06": "MG06",
	"mg07": "MG07",
	"mg08": "MG08",
	"mg09": "MG09",
	"mg10": "MG10",
}

@onready var _slot_cards: Array[SlotCard] = [
	$VBoxContainer/SlotContainer/SlotCard0,
	$VBoxContainer/SlotContainer/SlotCard1,
	$VBoxContainer/SlotContainer/SlotCard2,
	$VBoxContainer/SlotContainer/SlotCard3,
]
@onready var _press_button: Button = $VBoxContainer/PressButton
@onready var _lucky_effect: CPUParticles2D = $LuckyEffect

var _available_minigames: Array[String] = []
var _spinning: bool = false
var _spin_speed: float = MAX_SPIN_SPEED
var _spin_timer: Timer


func _ready() -> void:
	_lucky_effect.visible = false
	_lucky_effect.emitting = false
	_press_button.pressed.connect(_on_stop_pressed)
	selected.connect(_on_selected)

	_spin_timer = Timer.new()
	_spin_timer.one_shot = false
	add_child(_spin_timer)
	_spin_timer.timeout.connect(_on_spin_tick)

	start_spin(GameController.get_phase_minigames())


func _on_selected(minigame_id: String, _is_lucky: bool) -> void:
	GameController.start_minigame(minigame_id)


## Arranca el giro de la ruleta con los minijuegos disponibles en la fase.
func start_spin(available: Array[String]) -> void:
	_available_minigames = available.duplicate()
	if _available_minigames.is_empty():
		_available_minigames = MG_LABELS.keys()

	_spinning = true
	_spin_speed = MAX_SPIN_SPEED
	_press_button.disabled = false
	_press_button.text = "TAP TO STOP!"

	for card in _slot_cards:
		var mg_id: String = _random_minigame()
		card.set_content(mg_id, null, MG_LABELS.get(mg_id, mg_id))
		card.animate_spinning(_spin_speed)

	_spin_timer.start(_spin_speed)


func _on_spin_tick() -> void:
	if not _spinning:
		return

	for card in _slot_cards:
		var mg_id: String = _random_minigame()
		card.set_content(mg_id, null, MG_LABELS.get(mg_id, mg_id))


func _random_minigame() -> String:
	return _available_minigames[randi() % _available_minigames.size()]


func _on_stop_pressed() -> void:
	if not _spinning:
		return

	_spinning = false
	_press_button.disabled = true
	_spin_timer.stop()

	var selected_id: String = _random_minigame()
	var is_lucky: bool = randf() < LUCKY_CHANCE

	_animate_stop(selected_id)

	if is_lucky:
		_trigger_lucky_effect()

	AudioManager.play_sfx("roulette_stop")

	await get_tree().create_timer(STOP_ANIM_TIME).timeout
	selected.emit(selected_id, is_lucky)


func _animate_stop(selected_id: String) -> void:
	for i in _slot_cards.size():
		var card: SlotCard = _slot_cards[i]
		var mg_id: String = selected_id if i == 0 else _random_minigame()
		card.set_content(mg_id, null, MG_LABELS.get(mg_id, mg_id))
		card.animate_stop(mg_id)

	# La primera tarjeta representa el resultado final elegido.
	_slot_cards[0].highlight()


func _trigger_lucky_effect() -> void:
	_lucky_effect.visible = true
	_lucky_effect.restart()
	AudioManager.play_sfx("lucky")
