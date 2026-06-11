extends Node

# Signals
signal minigame_completed(score: int, time_left: float)
signal life_lost()
signal life_gained()
signal lucky_triggered(minigame_id: String)
signal phase_completed(phase: int, total_score: int)
signal game_over(final_score: int)

# State variables
var current_lives: int = 3
var current_phase: int = 1
var current_score: int = 0
var combo_count: int = 0
var lucky_fragments: int = 0
var current_mode: String = ""  # "story" | "endless" | "practice" | "multiplayer"
var minigames_completed_in_phase: int = 0

# Phase-specific configuration
var phases_config: Dictionary = {
	1: {"difficulty": 0.8, "minigames": []},
	2: {"difficulty": 0.9, "minigames": []},
	3: {"difficulty": 1.0, "minigames": []},
}

# Available minigames
var available_minigames: Array[String] = [
	"mg01", "mg02", "mg03", "mg04", "mg05", "mg06", "mg07", "mg08", "mg09", "mg10",
	"mg11", "mg12", "mg13", "mg14", "mg15", "mg16", "mg17", "mg18", "mg19", "mg20"
]

var _consecutive_successes: int = 0


func _ready() -> void:
	# Initialize phases configuration
	phases_config[1]["minigames"] = ["mg06", "mg02", "mg07", "mg01"]
	phases_config[2]["minigames"] = ["mg03", "mg05", "mg08", "mg04", "mg09"]
	phases_config[3]["minigames"] = ["mg10", "mg11", "mg12", "mg13"]


func start_game(mode: String) -> void:
	current_mode = mode
	current_lives = 3
	current_phase = 1
	current_score = 0
	combo_count = 0
	lucky_fragments = 0
	minigames_completed_in_phase = 0
	_consecutive_successes = 0


func load_next_minigame() -> void:
	# Get available minigames for current phase
	var phase_minigames: Array[String] = phases_config[current_phase]["minigames"]

	# In practice mode, all minigames are available
	if current_mode == "practice":
		phase_minigames = available_minigames

	# Randomly select from available minigames
	if not phase_minigames.is_empty():
		var selected: String = phase_minigames[randi() % phase_minigames.size()]
		# TODO: Load and instantiate the selected minigame scene


func on_minigame_success(score: int, time_left: float) -> void:
	_consecutive_successes += 1
	minigames_completed_in_phase += 1

	# Calculate final score with multipliers
	var final_score: int = score
	final_score = int(final_score * get_score_multiplier())

	current_score += final_score
	minigame_completed.emit(final_score, time_left)

	# Check for Lucky! (10% chance)
	if randf() < 0.1:
		lucky_fragments += 1
		lucky_triggered.emit("")

		# Three fragments = one life
		if lucky_fragments >= 3:
			lucky_fragments = 0
			current_lives += 1
			life_gained.emit()

	# Check for combo (3 consecutive successes)
	if _consecutive_successes >= 3:
		combo_count += 1


func on_minigame_failure() -> void:
	_consecutive_successes = 0
	current_lives -= 1
	life_lost.emit()

	if current_lives <= 0:
		game_over.emit(current_score)


func get_difficulty_multiplier() -> float:
	# Returns difficulty multiplier based on current phase
	match current_phase:
		1: return 0.8
		2: return 0.9
		3: return 1.0
		_: return 1.0


func get_score_multiplier() -> float:
	# Combines speed bonus and combo multiplier
	var speed_mult: float = 1.0
	var combo_mult: float = 1.0

	# Bonus if combo >= 3
	if combo_count >= 3:
		combo_mult = 1.5

	return speed_mult * combo_mult
