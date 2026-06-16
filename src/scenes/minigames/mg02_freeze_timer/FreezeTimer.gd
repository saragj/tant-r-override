class_name FreezeTimer
extends MiniGameBase

## MG02 - Freeze Timer: un cronometro digital baja de 10.0s a 0.0.
## El jugador debe tocar STOP para detenerlo lo mas cerca posible de 0.0s.
## Zona de exito: 0.0-0.3s (perfect), 0.3-0.6s (close), resto = miss/fail.
## Este cronometro es independiente del TimerBar del minijuego (que mide
## el tiempo total disponible para intentarlo).

const COUNTDOWN_START: float = 10.0
const PERFECT_THRESHOLD: float = 0.3
const CLOSE_THRESHOLD: float = 0.6

# Velocidad base del cronometro (multiplicador). En fases 2/3 hay
# "acelerones" aleatorios que multiplican momentaneamente la velocidad.
const PHASE_BURST_CHANCE: Dictionary = {
	1: 0.0,
	2: 0.15,
	3: 0.3,
}

var _countdown: float = COUNTDOWN_START
var _running: bool = false
var _burst_chance: float = 0.0
var _speed_mult: float = 1.0

var _digit_label: Label
var _stop_button: Button
var _feedback_label: Label


func _setup_game() -> void:
	var phase: int = GameController.current_phase
	_burst_chance = PHASE_BURST_CHANCE.get(phase, 0.0)
	_countdown = COUNTDOWN_START
	_speed_mult = 1.0

	_build_visuals()


func _start_game() -> void:
	_running = true
	_update_digit_display()


func _process(delta: float) -> void:
	super._process(delta)

	if not _running:
		return

	if _burst_chance > 0.0 and randf() < _burst_chance * delta:
		_speed_mult = randf_range(1.5, 2.5)
	else:
		_speed_mult = move_toward(_speed_mult, 1.0, delta * 2.0)

	_countdown -= delta * _speed_mult
	_countdown = maxf(_countdown, -1.0)
	_update_digit_display()

	if _countdown <= -1.0:
		_running = false
		_on_failure()


func _on_stop_pressed() -> void:
	if not _running:
		return

	_running = false
	var stopped_at: float = _countdown
	var accuracy: String = _calculate_accuracy(stopped_at)

	_show_feedback(accuracy)

	if accuracy == "miss":
		_on_failure()
	else:
		_on_success()


## Determina la precision del freeze: "perfect" | "close" | "miss".
func _calculate_accuracy(stopped_at: float) -> String:
	var distance: float = absf(stopped_at)

	if stopped_at < 0.0:
		return "miss"

	if distance <= PERFECT_THRESHOLD:
		return "perfect"
	elif distance <= CLOSE_THRESHOLD:
		return "close"
	else:
		return "miss"


func _show_feedback(accuracy: String) -> void:
	match accuracy:
		"perfect":
			_feedback_label.text = "PERFECT!"
			_feedback_label.modulate = Color(0.2, 0.9, 0.4)
		"close":
			_feedback_label.text = "CLOSE!"
			_feedback_label.modulate = Color(1.0, 0.6, 0.1)
		_:
			_feedback_label.text = "MISS!"
			_feedback_label.modulate = Color(0.9, 0.2, 0.2)

	_feedback_label.visible = true


func _update_digit_display() -> void:
	if _digit_label:
		_digit_label.text = "%05.2f" % maxf(_countdown, 0.0)


func _build_visuals() -> void:
	for child in _game_area.get_children():
		child.queue_free()

	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	_game_area.add_child(vbox)

	_digit_label = Label.new()
	_digit_label.text = "10.00"
	_digit_label.add_theme_font_size_override("font_size", 64)
	_digit_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(_digit_label)

	_feedback_label = Label.new()
	_feedback_label.visible = false
	_feedback_label.add_theme_font_size_override("font_size", 28)
	_feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(_feedback_label)

	_stop_button = Button.new()
	_stop_button.text = "STOP"
	_stop_button.custom_minimum_size = Vector2(160, 64)
	_stop_button.pressed.connect(_on_stop_pressed)
	vbox.add_child(_stop_button)


func _cleanup() -> void:
	_running = false
