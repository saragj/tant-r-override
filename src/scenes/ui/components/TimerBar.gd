class_name TimerBar
extends ProgressBar

## Barra de tiempo reutilizable para minijuegos.
## Desciende de max_value a 0, cambia de color segun el tiempo restante
## y emite timer_finished() al llegar a 0.

signal timer_finished()

const COLOR_OK: Color = Color(0.2, 0.85, 0.4)      # verde, >50%
const COLOR_WARNING: Color = Color(0.95, 0.75, 0.15) # amarillo, 25-50%
const COLOR_DANGER: Color = Color(0.9, 0.2, 0.2)     # rojo, <25%

const PULSE_THRESHOLD: float = 0.25

var _duration: float = 0.0
var _time_remaining: float = 0.0
var _is_running: bool = false
var _style_box: StyleBoxFlat
var _pulse_tween: Tween


func _ready() -> void:
	show_percentage = false
	_setup_style()


func _process(delta: float) -> void:
	if not _is_running:
		return

	_time_remaining = maxf(_time_remaining - delta, 0.0)
	value = _time_remaining
	_update_color()

	if _time_remaining <= 0.0:
		_is_running = false
		_stop_pulse()
		timer_finished.emit()


func start_timer(duration: float) -> void:
	_duration = maxf(duration, 0.01)
	_time_remaining = _duration
	max_value = _duration
	value = _duration
	_is_running = true
	_update_color()


func pause_timer() -> void:
	_is_running = false
	_stop_pulse()


func resume_timer() -> void:
	if _time_remaining > 0.0:
		_is_running = true


func get_time_remaining() -> float:
	return _time_remaining


func get_progress_ratio() -> float:
	if _duration <= 0.0:
		return 0.0
	return _time_remaining / _duration


func _setup_style() -> void:
	_style_box = StyleBoxFlat.new()
	_style_box.bg_color = COLOR_OK
	_style_box.corner_radius_top_left = 6
	_style_box.corner_radius_top_right = 6
	_style_box.corner_radius_bottom_left = 6
	_style_box.corner_radius_bottom_right = 6
	add_theme_stylebox_override("fill", _style_box)


func _update_color() -> void:
	var ratio: float = get_progress_ratio()
	var target_color: Color

	if ratio > 0.5:
		target_color = COLOR_OK
	elif ratio > PULSE_THRESHOLD:
		target_color = COLOR_WARNING
	else:
		target_color = COLOR_DANGER
		_start_pulse()
		return

	_stop_pulse()
	_style_box.bg_color = target_color


func _start_pulse() -> void:
	if _pulse_tween and _pulse_tween.is_running():
		return

	_pulse_tween = create_tween()
	_pulse_tween.set_loops()
	_pulse_tween.tween_property(_style_box, "bg_color", COLOR_DANGER.lightened(0.3), 0.25)
	_pulse_tween.tween_property(_style_box, "bg_color", COLOR_DANGER, 0.25)


func _stop_pulse() -> void:
	if _pulse_tween:
		_pulse_tween.kill()
		_pulse_tween = null
