class_name LabyrinthRush
extends MiniGameBase

## MG01 - Labyrinth Rush: el jugador desliza el dedo para mover al
## detective por un laberinto generado con DFS mientras el agua sube
## desde abajo. Llegar a la salida = exito; ser alcanzado por el agua o
## agotar el tiempo = fallo.
##
## Paleta veraniega con acentos neon (ver nota de diseno): turquesa/coral
## de fondo + cian/magenta neon para elementos interactivos.

const CELL_SIZE: float = 36.0
const WALL: int = 1
const FLOOR: int = 0

# Configuracion por fase (ancho, alto, velocidad de agua en celdas/seg)
const PHASE_CONFIG: Dictionary = {
	1: {"width": 7, "height": 9, "water_speed": 0.5},
	2: {"width": 9, "height": 11, "water_speed": 0.6},
	3: {"width": 9, "height": 11, "water_speed": 0.7, "fake_walls": true},
}

var _grid: Array = []
var _grid_width: int = 7
var _grid_height: int = 9
var _fake_walls: Array[Vector2i] = []
var _player_cell: Vector2i = Vector2i.ZERO
var _exit_cell: Vector2i = Vector2i.ZERO
var _water_row: float = 0.0
var _water_speed: float = 0.5
var _drag_start: Vector2 = Vector2.ZERO
var _maze_origin: Vector2 = Vector2.ZERO

var _player_node: ColorRect
var _exit_node: ColorRect
var _water_node: ColorRect
var _walls_container: Node2D


func _setup_game() -> void:
	var phase: int = GameController.current_phase
	var config: Dictionary = PHASE_CONFIG.get(phase, PHASE_CONFIG[1])

	_grid_width = config["width"]
	_grid_height = config["height"]
	_water_speed = config["water_speed"]
	_fake_walls.clear()

	_grid = _generate_maze(_grid_width, _grid_height)
	_player_cell = Vector2i(0, 0)
	_exit_cell = Vector2i(_grid_width - 1, _grid_height - 1)
	_water_row = float(_grid_height)

	if config.get("fake_walls", false):
		_setup_fake_walls()

	_build_visuals()


func _start_game() -> void:
	_water_row = float(_grid_height)
	set_process(true)


func _process(delta: float) -> void:
	super._process(delta)

	if not _is_active:
		return

	_water_row -= _water_speed * delta
	_update_water_visual()

	if _water_row <= float(_player_cell.y):
		_on_failure()


func _input(event: InputEvent) -> void:
	if not _is_active:
		return

	if event is InputEventScreenDrag:
		var drag: InputEventScreenDrag = event
		_handle_drag(drag.relative)
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var motion: InputEventMouseMotion = event
		_handle_drag(motion.relative)


func _handle_drag(relative: Vector2) -> void:
	if relative.length() < 12.0:
		return

	var direction: Vector2i
	if absf(relative.x) > absf(relative.y):
		direction = Vector2i(1 if relative.x > 0 else -1, 0)
	else:
		direction = Vector2i(0, 1 if relative.y > 0 else -1)

	_move_player(direction)


func _move_player(direction: Vector2i) -> void:
	var target: Vector2i = _player_cell + direction

	if not _is_within_bounds(target):
		return

	if _is_wall(target) and not _fake_walls.has(target):
		return

	_player_cell = target
	_update_player_visual()
	_check_win_condition()


func _check_win_condition() -> void:
	if _player_cell == _exit_cell:
		_on_success()


## Genera un laberinto con DFS (Depth-First Search) asegurando que existe
## un camino solucionable entre la entrada (0,0) y la salida.
## Retorna un grid 2D donde 1 = pared, 0 = piso.
func _generate_maze(width: int, height: int) -> Array:
	var grid: Array = []
	for y in height:
		var row: Array = []
		for x in width:
			row.append(WALL)
		grid.append(row)

	var visited: Dictionary = {}
	var stack: Array[Vector2i] = [Vector2i(0, 0)]
	grid[0][0] = FLOOR
	visited[Vector2i(0, 0)] = true

	var directions: Array[Vector2i] = [Vector2i(0, -1), Vector2i(0, 1), Vector2i(-1, 0), Vector2i(1, 0)]

	while not stack.is_empty():
		var current: Vector2i = stack[stack.size() - 1]
		var neighbors: Array[Vector2i] = []

		for dir in directions:
			var next_cell: Vector2i = current + dir
			if next_cell.x >= 0 and next_cell.x < width and next_cell.y >= 0 and next_cell.y < height:
				if not visited.has(next_cell):
					neighbors.append(next_cell)

		if neighbors.is_empty():
			stack.pop_back()
			continue

		var chosen: Vector2i = neighbors[randi() % neighbors.size()]
		grid[chosen.y][chosen.x] = FLOOR
		visited[chosen] = true
		stack.append(chosen)

	grid[height - 1][width - 1] = FLOOR
	return grid


func _setup_fake_walls() -> void:
	# Paredes falsas: celdas marcadas como pared en el grid visual pero
	# transitables. Se eligen entre celdas de pared adyacentes al camino.
	var candidates: Array[Vector2i] = []
	for y in _grid_height:
		for x in _grid_width:
			if _grid[y][x] == WALL:
				candidates.append(Vector2i(x, y))

	candidates.shuffle()
	var count: int = mini(3, candidates.size())
	for i in count:
		_fake_walls.append(candidates[i])


func _is_within_bounds(cell: Vector2i) -> bool:
	return cell.x >= 0 and cell.x < _grid_width and cell.y >= 0 and cell.y < _grid_height


func _is_wall(cell: Vector2i) -> bool:
	return _grid[cell.y][cell.x] == WALL


func _build_visuals() -> void:
	for child in _game_area_children():
		child.queue_free()

	_maze_origin = Vector2(
		(_game_area.size.x - _grid_width * CELL_SIZE) / 2.0,
		(_game_area.size.y - _grid_height * CELL_SIZE) / 2.0
	)

	_walls_container = Node2D.new()
	_game_area.add_child(_walls_container)

	for y in _grid_height:
		for x in _grid_width:
			var cell: Vector2i = Vector2i(x, y)
			if _grid[y][x] == WALL and not _fake_walls.has(cell):
				var wall_rect: ColorRect = ColorRect.new()
				wall_rect.color = Color(0.05, 0.2, 0.35) # azul oscuro (paredes)
				wall_rect.size = Vector2(CELL_SIZE, CELL_SIZE)
				wall_rect.position = _maze_origin + Vector2(x * CELL_SIZE, y * CELL_SIZE)
				_walls_container.add_child(wall_rect)

	_exit_node = ColorRect.new()
	_exit_node.color = Color(1.0, 0.85, 0.2) # estrella/salida dorada
	_exit_node.size = Vector2(CELL_SIZE * 0.8, CELL_SIZE * 0.8)
	_exit_node.position = _maze_origin + Vector2(_exit_cell.x * CELL_SIZE, _exit_cell.y * CELL_SIZE) + Vector2(CELL_SIZE * 0.1, CELL_SIZE * 0.1)
	_game_area.add_child(_exit_node)

	_player_node = ColorRect.new()
	_player_node.color = Color(1.0, 0.45, 0.15) # naranja (detective)
	_player_node.size = Vector2(CELL_SIZE * 0.7, CELL_SIZE * 0.7)
	_game_area.add_child(_player_node)
	_update_player_visual()

	_water_node = ColorRect.new()
	_water_node.color = Color(0.1, 0.85, 0.9, 0.55) # cian translucido
	_water_node.size = Vector2(_grid_width * CELL_SIZE, 0)
	_game_area.add_child(_water_node)
	_update_water_visual()


func _update_player_visual() -> void:
	if not _player_node:
		return
	_player_node.position = _maze_origin + Vector2(_player_cell.x * CELL_SIZE, _player_cell.y * CELL_SIZE) + Vector2(CELL_SIZE * 0.15, CELL_SIZE * 0.15)


func _update_water_visual() -> void:
	if not _water_node:
		return
	var water_height: float = (float(_grid_height) - _water_row) * CELL_SIZE
	water_height = maxf(water_height, 0.0)
	_water_node.size.y = water_height
	_water_node.position = _maze_origin + Vector2(0, _grid_height * CELL_SIZE - water_height)


func _game_area_children() -> Array:
	return _game_area.get_children()


func _cleanup() -> void:
	set_process(false)
