extends Node

class_name AudioManager

# Audio buses configuration
const MASTER_BUS = "Master"
const SFX_BUS = "SFX"
const MUSIC_BUS = "Music"

# SFX pool configuration
const SFX_POOL_SIZE = 8

# Preloaded audio streams
var _sfx_cache: Dictionary = {}
var _music_cache: Dictionary = {}

# SFX pool for low-latency playback
var _sfx_pool: Array[AudioStreamPlayer] = []
var _current_sfx_index: int = 0

# Music player
var _music_player: AudioStreamPlayer
var _current_music: String = ""
var _music_fade_tween: Tween

# Default volume levels
var _sfx_volume: float = 0.8
var _music_volume: float = 0.8


func _ready() -> void:
	# Create audio buses if they don't exist
	_create_audio_buses()

	# Create SFX pool
	_create_sfx_pool()

	# Create music player
	_create_music_player()

	# Preload all audio streams
	_preload_audio_streams()

	# Apply default volumes
	set_sfx_volume(_sfx_volume)
	set_music_volume(_music_volume)


func _create_audio_buses() -> void:
	var audio_server = AudioServer

	# Check if buses exist, create if needed
	if audio_server.get_bus_index(MASTER_BUS) == -1:
		audio_server.add_bus(0)
		audio_server.set_bus_name(audio_server.bus_count - 1, MASTER_BUS)

	if audio_server.get_bus_index(SFX_BUS) == -1:
		var sfx_bus_idx = audio_server.bus_count
		audio_server.add_bus(sfx_bus_idx)
		audio_server.set_bus_name(sfx_bus_idx, SFX_BUS)
		audio_server.set_bus_send(sfx_bus_idx, MASTER_BUS)

	if audio_server.get_bus_index(MUSIC_BUS) == -1:
		var music_bus_idx = audio_server.bus_count
		audio_server.add_bus(music_bus_idx)
		audio_server.set_bus_name(music_bus_idx, MUSIC_BUS)
		audio_server.set_bus_send(music_bus_idx, MASTER_BUS)


func _create_sfx_pool() -> void:
	for i in range(SFX_POOL_SIZE):
		var player = AudioStreamPlayer.new()
		player.bus = SFX_BUS
		add_child(player)
		_sfx_pool.append(player)


func _create_music_player() -> void:
	_music_player = AudioStreamPlayer.new()
	_music_player.bus = MUSIC_BUS
	_music_player.volume_db = 0.0
	add_child(_music_player)


func _preload_audio_streams() -> void:
	# Define all SFX that will be used in the game
	var sfx_files = {
		"success": "res://assets/audio/sfx/success.ogg",
		"fail": "res://assets/audio/sfx/fail.ogg",
		"lucky": "res://assets/audio/sfx/lucky.ogg",
		"tick": "res://assets/audio/sfx/tick.ogg",
		"combo": "res://assets/audio/sfx/combo.ogg",
		"roulette_spin": "res://assets/audio/sfx/roulette_spin.ogg",
		"roulette_stop": "res://assets/audio/sfx/roulette_stop.ogg",
		"life_lost": "res://assets/audio/sfx/life_lost.ogg",
		"life_gained": "res://assets/audio/sfx/life_gained.ogg",
		"animal_cat": "res://assets/audio/sfx/animal_cat.ogg",
		"animal_dog": "res://assets/audio/sfx/animal_dog.ogg",
		"animal_bird": "res://assets/audio/sfx/animal_bird.ogg",
		"animal_cow": "res://assets/audio/sfx/animal_cow.ogg",
		"animal_frog": "res://assets/audio/sfx/animal_frog.ogg",
		"animal_monkey": "res://assets/audio/sfx/animal_monkey.ogg",
	}

	# Preload SFX files (non-blocking, handles missing files gracefully)
	for sfx_name in sfx_files:
		var path = sfx_files[sfx_name]
		if ResourceLoader.exists(path):
			_sfx_cache[sfx_name] = load(path)
		else:
			push_warning("SFX file not found: %s" % path)

	# Define all music tracks
	var music_files = {
		"menu": "res://assets/audio/music/music_menu.ogg",
		"phase1": "res://assets/audio/music/music_phase1.ogg",
		"phase2": "res://assets/audio/music/music_phase2.ogg",
		"phase3": "res://assets/audio/music/music_phase3.ogg",
		"endless": "res://assets/audio/music/music_endless.ogg",
		"victory": "res://assets/audio/music/music_victory.ogg",
	}

	# Preload music files
	for track_name in music_files:
		var path = music_files[track_name]
		if ResourceLoader.exists(path):
			_music_cache[track_name] = load(path)
		else:
			push_warning("Music file not found: %s" % path)


func play_sfx(sfx_name: String) -> void:
	if sfx_name not in _sfx_cache:
		push_warning("SFX not found or not preloaded: %s" % sfx_name)
		return

	# Get next available player from pool
	var player = _sfx_pool[_current_sfx_index]
	_current_sfx_index = (_current_sfx_index + 1) % SFX_POOL_SIZE

	# Stop any currently playing sound and play new one
	player.stream = _sfx_cache[sfx_name]
	player.play()


func play_music(track_name: String) -> void:
	if track_name not in _music_cache:
		push_warning("Music track not found or not preloaded: %s" % track_name)
		return

	# If same track is already playing, don't restart it
	if _current_music == track_name and _music_player.playing:
		return

	_current_music = track_name
	_music_player.stream = _music_cache[track_name]
	_music_player.play()


func stop_music(fade_time: float = 0.5) -> void:
	if not _music_player.playing:
		return

	# Kill existing fade tween if any
	if _music_fade_tween:
		_music_fade_tween.kill()

	# Fade out and stop
	_music_fade_tween = create_tween()
	_music_fade_tween.tween_property(_music_player, "volume_db", -80.0, fade_time)
	await _music_fade_tween.finished
	_music_player.stop()
	_music_player.volume_db = 0.0


func set_sfx_volume(value: float) -> void:
	_sfx_volume = clamp(value, 0.0, 1.0)
	var db = linear2db(_sfx_volume) if _sfx_volume > 0.0 else -80.0
	AudioServer.set_bus_mute(AudioServer.get_bus_index(SFX_BUS), _sfx_volume == 0.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(SFX_BUS), db)


func set_music_volume(value: float) -> void:
	_music_volume = clamp(value, 0.0, 1.0)
	var db = linear2db(_music_volume) if _music_volume > 0.0 else -80.0
	AudioServer.set_bus_mute(AudioServer.get_bus_index(MUSIC_BUS), _music_volume == 0.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS), db)


func get_sfx_volume() -> float:
	return _sfx_volume


func get_music_volume() -> float:
	return _music_volume


# Fade in music when starting a new track
func fade_in_music(track_name: String, fade_time: float = 0.5) -> void:
	if track_name not in _music_cache:
		push_warning("Music track not found or not preloaded: %s" % track_name)
		return

	_current_music = track_name
	_music_player.stream = _music_cache[track_name]
	_music_player.volume_db = -80.0
	_music_player.play()

	if _music_fade_tween:
		_music_fade_tween.kill()

	_music_fade_tween = create_tween()
	_music_fade_tween.tween_property(_music_player, "volume_db", 0.0, fade_time)
