extends Node

var _total_score: int = 0

func calculate_score(base: int, time_left: float, total_time: float, combo: int) -> int:
	var speed_mult = get_speed_multiplier(time_left, total_time)
	var combo_mult = get_combo_multiplier(combo)
	return int(base * speed_mult * combo_mult)

func get_speed_multiplier(time_left: float, total_time: float) -> float:
	if time_left > total_time * 0.5:
		return 2.0
	return 1.0

func get_combo_multiplier(combo: int) -> float:
	if combo >= 3:
		return 1.5
	return 1.0

func add_score(points: int) -> void:
	_total_score += points

func get_total_score() -> int:
	return _total_score

func reset() -> void:
	_total_score = 0
