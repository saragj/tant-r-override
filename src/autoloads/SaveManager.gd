extends Node

const SAVE_PATH = "user://save.json"

var _save_data: Dictionary = {
	"high_scores": {"story": 0, "endless": 0},
	"unlocked_minigames": [],
	"unlocked_skins": [],
	"lucky_fragments": 0,
	"stats": {},
	"settings": {"sfx_volume": 1.0, "music_volume": 1.0, "crt_effect": false}
}

func _ready() -> void:
	_ensure_all_minigames_tracked()
	load_game()

func save_game() -> void:
	var json = JSON.stringify(_save_data)
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json)

func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return _save_data

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			_save_data = json.data
			_ensure_all_minigames_tracked()
			return _save_data

	return _save_data

func update_minigame_stats(mg_id: String, success: bool, time: float) -> void:
	if mg_id not in _save_data["stats"]:
		_save_data["stats"][mg_id] = {
			"attempts": 0,
			"successes": 0,
			"best_time": 99.0
		}

	var stats = _save_data["stats"][mg_id]
	stats["attempts"] += 1

	if success:
		stats["successes"] += 1
		if time < stats["best_time"]:
			stats["best_time"] = time

	save_game()

func unlock_minigame(mg_id: String) -> void:
	if mg_id not in _save_data["unlocked_minigames"]:
		_save_data["unlocked_minigames"].append(mg_id)
		save_game()

func save_high_score(mode: String, score: int) -> void:
	if mode in _save_data["high_scores"]:
		if score > _save_data["high_scores"][mode]:
			_save_data["high_scores"][mode] = score
			save_game()

func get_settings() -> Dictionary:
	return _save_data["settings"].duplicate()

func update_settings(key: String, value) -> void:
	if key in _save_data["settings"]:
		_save_data["settings"][key] = value
		save_game()

func get_high_score(mode: String) -> int:
	if mode in _save_data["high_scores"]:
		return _save_data["high_scores"][mode]
	return 0

func is_minigame_unlocked(mg_id: String) -> bool:
	return mg_id in _save_data["unlocked_minigames"]

func get_minigame_stats(mg_id: String) -> Dictionary:
	if mg_id in _save_data["stats"]:
		return _save_data["stats"][mg_id].duplicate()
	return {"attempts": 0, "successes": 0, "best_time": 99.0}

func get_lucky_fragments() -> int:
	return _save_data["lucky_fragments"]

func set_lucky_fragments(count: int) -> void:
	_save_data["lucky_fragments"] = count
	save_game()

func reset_game_data() -> void:
	_save_data = {
		"high_scores": {"story": 0, "endless": 0},
		"unlocked_minigames": [],
		"unlocked_skins": [],
		"lucky_fragments": 0,
		"stats": {},
		"settings": {"sfx_volume": 1.0, "music_volume": 1.0, "crt_effect": false}
	}
	_ensure_all_minigames_tracked()
	save_game()

func _ensure_all_minigames_tracked() -> void:
	for i in range(1, 21):
		var mg_id = "mg%02d" % i
		if mg_id not in _save_data["stats"]:
			_save_data["stats"][mg_id] = {
				"attempts": 0,
				"successes": 0,
				"best_time": 99.0
			}
