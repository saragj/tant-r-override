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

const MINIGAME_SCENES: Dictionary = {
	"mg01": "res://scenes/minigames/mg01_labyrinth/LabyrinthRush.tscn",
	"mg02": "res://scenes/minigames/mg02_freeze_timer/FreezeTimer.tscn",
	"mg03": "res://scenes/minigames/mg03_animal_echo/AnimalEcho.tscn",
}

var last_minigame_score: int = 0
var last_minigame_success: bool = false

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
	ScoreManager.reset()


## Minijuegos disponibles para la fase/modo actual (la ruleta elige entre estos).
func get_phase_minigames() -> Array[String]:
	if current_mode == "practice":
		return available_minigames
	return phases_config[current_phase]["minigames"]


## Avanza el flujo de juego mostrando la ruleta, que elegira el siguiente minijuego.
func load_next_minigame() -> void:
	TransitionManager.go_to_scene("res://scenes/roulette/Roulette.tscn")


## Carga la escena del minijuego elegido por la ruleta.
func start_minigame(mg_id: String) -> void:
	var scene_path: String = MINIGAME_SCENES.get(mg_id, "")
	if scene_path == "":
		push_warning("GameController: no hay escena registrada para '%s' (Sprint 2+), usando mg01 como fallback" % mg_id)
		scene_path = MINIGAME_SCENES["mg01"]
	TransitionManager.go_to_scene(scene_path)


func on_minigame_success(score: int, time_left: float) -> void:
	_consecutive_successes += 1
	minigames_completed_in_phase += 1
	last_minigame_score = score
	last_minigame_success = true

	# score already includes speed/combo multipliers, applied by ScoreManager
	# before this signal handler runs (see MiniGameBase._on_success)
	current_score = ScoreManager.get_total_score()
	minigame_completed.emit(score, time_left)

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
	combo_count = 0
	current_lives -= 1
	last_minigame_success = false
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
