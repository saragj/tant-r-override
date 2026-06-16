class_name SlotCard
extends PanelContainer

## Tarjeta individual de la ruleta. Muestra el icono/nombre de un minijuego
## y anima el "scroll" tipo slot machine mientras gira, con efecto de glow
## al quedar seleccionada.

@export var icon_rect: TextureRect
@export var name_label: Label

var _mg_id: String = ""
var _spin_tween: Tween
var _glow_style: StyleBoxFlat


func _ready() -> void:
	if not icon_rect:
		icon_rect = $Margin/VBox/Icon
	if not name_label:
		name_label = $Margin/VBox/NameLabel

	_glow_style = StyleBoxFlat.new()
	_glow_style.bg_color = Color(0.12, 0.12, 0.18, 1.0)
	_glow_style.corner_radius_top_left = 12
	_glow_style.corner_radius_top_right = 12
	_glow_style.corner_radius_bottom_left = 12
	_glow_style.corner_radius_bottom_right = 12
	_glow_style.border_width_left = 0
	_glow_style.border_width_right = 0
	_glow_style.border_width_top = 0
	_glow_style.border_width_bottom = 0
	_glow_style.border_color = Color(0.2, 0.9, 0.9, 1.0)
	add_theme_stylebox_override("panel", _glow_style)


## Asigna el contenido visible de la tarjeta.
func set_content(mg_id: String, icon: Texture2D, label: String) -> void:
	_mg_id = mg_id
	if icon and icon_rect:
		icon_rect.texture = icon
	if name_label:
		name_label.text = label


## Anima un "scroll" vertical continuo simulando el giro de una slot machine.
## speed: segundos entre cada cambio (menor = mas rapido).
func animate_spinning(speed: float) -> void:
	if _spin_tween:
		_spin_tween.kill()

	icon_rect.pivot_offset = icon_rect.size / 2.0
	_spin_tween = create_tween()
	_spin_tween.set_loops()
	_spin_tween.tween_property(icon_rect, "position:y", icon_rect.position.y + 24.0, speed)
	_spin_tween.tween_property(icon_rect, "position:y", icon_rect.position.y, 0.0)


## Detiene la animacion de giro y fija el contenido final.
func animate_stop(final_mg_id: String) -> void:
	if _spin_tween:
		_spin_tween.kill()
		_spin_tween = null

	_mg_id = final_mg_id
	icon_rect.position.y = 0.0

	var bounce: Tween = create_tween()
	bounce.tween_property(icon_rect, "scale", Vector2(1.15, 1.15), 0.08)
	bounce.tween_property(icon_rect, "scale", Vector2(1.0, 1.0), 0.1)


## Resalta visualmente la tarjeta elegida (glow).
func highlight() -> void:
	var tween: Tween = create_tween()
	tween.set_loops(2)
	tween.tween_property(_glow_style, "border_width_left", 4, 0.15)
	tween.parallel().tween_property(_glow_style, "border_width_right", 4, 0.15)
	tween.parallel().tween_property(_glow_style, "border_width_top", 4, 0.15)
	tween.parallel().tween_property(_glow_style, "border_width_bottom", 4, 0.15)
	tween.tween_property(_glow_style, "border_width_left", 1, 0.15)
	tween.parallel().tween_property(_glow_style, "border_width_right", 1, 0.15)
	tween.parallel().tween_property(_glow_style, "border_width_top", 1, 0.15)
	tween.parallel().tween_property(_glow_style, "border_width_bottom", 1, 0.15)


func get_mg_id() -> String:
	return _mg_id
