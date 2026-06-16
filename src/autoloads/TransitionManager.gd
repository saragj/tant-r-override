extends Node

## Gestiona las transiciones entre escenas (wipe horizontal) y el cambio
## de scene tree. Autoload singleton.

signal transition_started()
signal transition_finished()

const DEFAULT_FADE_TIME: float = 0.3

var _overlay: ColorRect
var _is_transitioning: bool = false


func _ready() -> void:
	_overlay = ColorRect.new()
	_overlay.color = Color(0, 0, 0, 0)
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	_overlay.z_index = 4096

	var layer: CanvasLayer = CanvasLayer.new()
	layer.layer = 128
	add_child(layer)
	layer.add_child(_overlay)


## Cambia de escena con un fade/wipe simple. scene_path debe ser una
## ruta valida a un .tscn.
func go_to_scene(scene_path: String, fade_time: float = DEFAULT_FADE_TIME) -> void:
	if _is_transitioning:
		return

	_is_transitioning = true
	transition_started.emit()

	var tween_out: Tween = create_tween()
	tween_out.tween_property(_overlay, "color:a", 1.0, fade_time)
	await tween_out.finished

	get_tree().change_scene_to_file(scene_path)
	await get_tree().process_frame

	var tween_in: Tween = create_tween()
	tween_in.tween_property(_overlay, "color:a", 0.0, fade_time)
	await tween_in.finished

	_is_transitioning = false
	transition_finished.emit()
