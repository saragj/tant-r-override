class_name AnimalEcho
extends MiniGameBase

## MG03 - Animal Echo: se reproduce una secuencia de sonidos de animales
## (Simon Says). El jugador debe repetir tocando los animales en orden.
## Fase 1: 3 sonidos, Fase 2: 4 sonidos, Fase 3: 5 sonidos.

const ANIMAL_IDS: Array[String] = ["cat", "dog", "bird", "cow", "frog", "monkey"]
const ANIMAL_EMOJI: Dictionary = {
	"cat": "🐱",
	"dog": "🐶",
	"bird": "🐦",
	"cow": "🐮",
	"frog": "🐸",
	"monkey": "🐵",
}
const ANIMAL_SFX: Dictionary = {
	"cat": "animal_cat",
	"dog": "animal_dog",
	"bird": "animal_bird",
	"cow": "animal_cow",
	"frog": "animal_frog",
	"monkey": "animal_monkey",
}

const PHASE_SEQUENCE_LENGTH: Dictionary = {
	1: 3,
	2: 4,
	3: 5,
}

const HIGHLIGHT_TIME: float = 0.5
const GAP_TIME: float = 0.25

var _sequence: Array[String] = []
var _player_input: Array[String] = []
var _is_showing_sequence: bool = false

var _animal_buttons: Dictionary = {}
var _progress_label: Label


func _setup_game() -> void:
	var phase: int = GameController.current_phase
	var length: int = PHASE_SEQUENCE_LENGTH.get(phase, 3)
	_sequence = _generate_sequence(length)
	_player_input.clear()

	_build_visuals()


func _start_game() -> void:
	_play_sequence()


## Genera una secuencia aleatoria de animales de longitud dada.
func _generate_sequence(length: int) -> Array[String]:
	var sequence: Array[String] = []
	for i in length:
		sequence.append(ANIMAL_IDS[randi() % ANIMAL_IDS.size()])
	return sequence


## Corutina: reproduce la secuencia iluminando y sonando cada animal con
## un delay entre ellos. No interactivo (input deshabilitado).
func _play_sequence() -> void:
	_is_showing_sequence = true
	_set_buttons_disabled(true)

	for animal_id in _sequence:
		await get_tree().create_timer(GAP_TIME).timeout
		_highlight_animal(animal_id)
		AudioManager.play_sfx(ANIMAL_SFX.get(animal_id, ""))
		await get_tree().create_timer(HIGHLIGHT_TIME).timeout
		_unhighlight_animal(animal_id)

	_is_showing_sequence = false
	_set_buttons_disabled(false)
	_update_progress_label()


func _on_animal_tapped(animal_id: String) -> void:
	if _is_showing_sequence or not _is_active:
		return

	_player_input.append(animal_id)
	var index: int = _player_input.size() - 1

	if _player_input[index] != _sequence[index]:
		_flash_wrong(animal_id)
		_on_failure()
		return

	_flash_correct(animal_id)
	_update_progress_label()
	_check_sequence()


func _check_sequence() -> void:
	if _player_input.size() == _sequence.size():
		_on_success()


func _update_progress_label() -> void:
	if not _progress_label:
		return

	var filled: int = _player_input.size()
	var total: int = _sequence.size()
	var dots: String = ""
	for i in total:
		dots += "●" if i < filled else "○"
	_progress_label.text = dots


func _build_visuals() -> void:
	for child in _game_area.get_children():
		child.queue_free()
	_animal_buttons.clear()

	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	_game_area.add_child(vbox)

	_progress_label = Label.new()
	_progress_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_progress_label.add_theme_font_size_override("font_size", 24)
	vbox.add_child(_progress_label)
	_update_progress_label()

	var grid: GridContainer = GridContainer.new()
	grid.columns = 3
	grid.add_theme_constant_override("h_separation", 12)
	grid.add_theme_constant_override("v_separation", 12)
	vbox.add_child(grid)

	for animal_id in ANIMAL_IDS:
		var button: Button = Button.new()
		button.text = ANIMAL_EMOJI.get(animal_id, animal_id)
		button.custom_minimum_size = Vector2(80, 80)
		button.add_theme_font_size_override("font_size", 32)
		button.pressed.connect(_on_animal_tapped.bind(animal_id))
		grid.add_child(button)
		_animal_buttons[animal_id] = button


func _highlight_animal(animal_id: String) -> void:
	var button: Button = _animal_buttons.get(animal_id)
	if button:
		button.modulate = Color(1.3, 1.3, 0.6)


func _unhighlight_animal(animal_id: String) -> void:
	var button: Button = _animal_buttons.get(animal_id)
	if button:
		button.modulate = Color.WHITE


func _flash_correct(animal_id: String) -> void:
	var button: Button = _animal_buttons.get(animal_id)
	if button:
		button.modulate = Color(0.5, 1.0, 0.6)
		var tween: Tween = create_tween()
		tween.tween_property(button, "modulate", Color.WHITE, 0.2)


func _flash_wrong(animal_id: String) -> void:
	var button: Button = _animal_buttons.get(animal_id)
	if button:
		button.modulate = Color(1.0, 0.3, 0.3)


func _set_buttons_disabled(disabled: bool) -> void:
	for animal_id in _animal_buttons:
		var button: Button = _animal_buttons[animal_id]
		button.disabled = disabled


func _cleanup() -> void:
	_is_showing_sequence = false
