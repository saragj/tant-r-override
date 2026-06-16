class_name LivesDisplay
extends HBoxContainer

@export var icon_active: Texture2D
@export var icon_lost: Texture2D

var _lives: int = 3
var _fragments: int = 0
var _slots: Array[Control] = []

func _ready() -> void:
	_slots = [$Slot0, $Slot1, $Slot2]
	_update_icons()

func set_lives(count: int) -> void:
	_lives = clampi(count, 0, 3)
	_update_icons()

func set_fragments(count: int) -> void:
	_fragments = clampi(count, 0, 3)

func animate_lose_life() -> void:
	if _lives <= 0:
		return
	var slot := _slots[_lives - 1]
	_lives -= 1
	var icon := slot.get_node("Icon") as TextureRect
	var particles := slot.get_node("Particles") as CPUParticles2D
	particles.restart()
	var tween := create_tween()
	tween.tween_property(icon, "position:y", 20.0, 0.25).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(icon, "modulate:a", 0.0, 0.25)
	tween.tween_callback(_update_icons)

func animate_gain_life() -> void:
	if _lives >= 3:
		return
	var slot := _slots[_lives]
	_lives += 1
	var icon := slot.get_node("Icon") as TextureRect
	icon.modulate = Color(1, 1, 1, 0)
	icon.scale = Vector2(0.1, 0.1)
	icon.texture = icon_active
	var tween := create_tween()
	tween.tween_property(icon, "modulate:a", 1.0, 0.1)
	tween.parallel().tween_property(icon, "scale", Vector2(1.2, 1.2), 0.15).set_ease(Tween.EASE_OUT)
	tween.tween_property(icon, "scale", Vector2(0.9, 0.9), 0.08)
	tween.tween_property(icon, "scale", Vector2(1.0, 1.0), 0.07)

func _update_icons() -> void:
	for i in 3:
		var icon := _slots[i].get_node("Icon") as TextureRect
		var is_active := i < _lives
		icon.texture = icon_active if is_active else icon_lost
		icon.modulate = Color(1.0, 1.0, 1.0, 1.0) if is_active else Color(0.4, 0.4, 0.4, 0.6)
		icon.position = Vector2.ZERO
		icon.scale = Vector2.ONE
