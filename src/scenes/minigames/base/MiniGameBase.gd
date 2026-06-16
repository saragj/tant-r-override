class_name MiniGameBase
extends CanvasLayer

## Minigame metadata (set in inspector or child class)
@export var mg_id: String = ""
@export var mg_name: String = ""
@export var base_time: float = 20.0
@export var instruction_key: String = ""  # i18n key for instruction text (e.g. "mg01.instruction")
@export var instruction_icon: Texture2D

## Lifecycle signals
signal completed(score: int, time_left: float)
signal failed()

## Internal state
var _time_remaining: float = 0.0
var _is_active: bool = false
var _difficulty_multiplier: float = 1.0
var _timer: Timer
var _total_time: float = 0.0

## UI node references
var _instruction_panel: PanelContainer
var _instruction_label: Label
var _instruction_icon: TextureRect
var _timer_bar: ProgressBar
var _game_area: Control
var _hud: HBoxContainer
var _score_display: Label
var _lives_display: HBoxContainer

func _ready() -> void:
	# Cache UI references
	var vbox = $Control/VBoxContainer
	_instruction_panel = vbox.get_node("InstructionPanel")
	_timer_bar = vbox.get_node("TimerBar")
	_game_area = vbox.get_node("GameArea")
	_hud = vbox.get_node("HUD")

	# Extract nested nodes
	var instruction_margin = _instruction_panel.get_node("MarginContainer")
	var instruction_hbox = instruction_margin.get_node("HBoxContainer")
	_instruction_icon = instruction_hbox.get_node("Icon")
	_instruction_label = instruction_hbox.get_node("Label")

	# HUD references
	_lives_display = _hud.get_node("LivesDisplay")
	_score_display = _hud.get_node("ScoreDisplay")

	# Initial state
	_instruction_panel.visible = false
	_timer_bar.modulate.a = 0.7  # Slight transparency for timer bar

	# Initialize game-specific setup
	_setup_game()

## Called to configure the minigame before showing instructions
## difficulty_mult: 1.0 (phase 1), 0.9 (phase 2), 0.8 (phase 3), etc.
func setup(difficulty_mult: float) -> void:
	_difficulty_multiplier = clamp(difficulty_mult, 0.1, 1.0)
	_total_time = base_time / _difficulty_multiplier
	_time_remaining = _total_time

## Show instruction panel for 2 seconds, then start the game
func show_instructions() -> void:
	if not _is_active and _instruction_key:
		_instruction_panel.visible = true

		# Set instruction text using i18n (translation)
		_instruction_label.text = tr(_instruction_key)

		if instruction_icon:
			_instruction_icon.texture = instruction_icon
		else:
			_instruction_icon.visible = false

		# Wait 2 seconds before starting
		await get_tree().create_timer(2.0).timeout

		if is_node_valid(self):  # Check if node still exists
			_instruction_panel.visible = false
			start()

## Start the game timer and activate input
func start() -> void:
	if _is_active:
		return

	_is_active = true
	_time_remaining = _total_time
	_timer_bar.value = 100.0
	_timer_bar.max_value = 100.0
	_timer_bar.show()

	_start_game()
	_start_timer()

## Internal timer management using frame-based countdown
func _start_timer() -> void:
	if _timer:
		_timer.queue_free()

	_timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(_on_timer_tick)
	_timer.start(0.016)  # ~60 FPS delta time

## Called every frame by timer to update remaining time
func _on_timer_tick() -> void:
	if not _is_active or not _timer:
		return

	_time_remaining -= 0.016

	# Update timer bar as percentage
	var percentage = (_time_remaining / _total_time) * 100.0
	_timer_bar.value = percentage

	# Color feedback based on time remaining
	_update_timer_bar_color()

	if _time_remaining <= 0:
		_time_remaining = 0.0
		if _timer:
			_timer.queue_free()
		_on_time_up()

## Update timer bar color: green → yellow → red
func _update_timer_bar_color() -> void:
	var ratio = _time_remaining / _total_time

	if ratio > 0.5:
		# Green zone (> 50%)
		_timer_bar.modulate = Color.GREEN
	elif ratio > 0.25:
		# Yellow zone (25-50%)
		_timer_bar.modulate = Color.YELLOW
	else:
		# Red zone (< 25%)
		_timer_bar.modulate = Color.RED
		# Add subtle pulse animation when time is critical
		if fmod(_time_remaining, 0.5) < 0.25:
			_timer_bar.modulate.a = 0.6
		else:
			_timer_bar.modulate.a = 1.0

## Called when minigame is successfully completed
## Child classes must call this to signal success
func _on_success() -> void:
	if not _is_active:
		return

	_is_active = false
	if _timer:
		_timer.queue_free()

	# Emit completion signal with score and remaining time
	completed.emit(0, max(0.0, _time_remaining))

	# Allow child class to perform cleanup
	_cleanup()

## Called when minigame fails or player makes a mistake
## Child classes must call this to signal failure
func _on_failure() -> void:
	if not _is_active:
		return

	_is_active = false
	if _timer:
		_timer.queue_free()

	failed.emit()
	_cleanup()

## Called when time runs out without success
func _on_time_up() -> void:
	_on_failure()

## Get the time remaining in seconds
func get_time_remaining() -> float:
	return max(0.0, _time_remaining)

## Get time remaining as a percentage (0.0-1.0)
func get_time_ratio() -> float:
	return clamp(_time_remaining / _total_time, 0.0, 1.0)

## Check if the game is currently active
func is_active() -> bool:
	return _is_active

## Get the current difficulty multiplier (< 1.0 means harder)
func get_difficulty_multiplier() -> float:
	return _difficulty_multiplier

## Virtual method: Initialize game elements (called in _ready)
## Override in child class to set up game-specific nodes
func _setup_game() -> void:
	pass

## Virtual method: Activate game mechanics and input (called in start())
## Override in child class to begin gameplay
func _start_game() -> void:
	pass

## Virtual method: Clean up game state and resources
## Override in child class to release resources, disconnect signals, etc.
func _cleanup() -> void:
	pass

## Helper: Check if a node is still valid (useful for async operations)
func is_node_valid(node: Node) -> bool:
	return is_instance_valid(node) and not node.is_queued_for_deletion()
