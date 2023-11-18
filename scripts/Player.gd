extends Node2D
class_name Player

enum EAction {MOVE, INTERACT, PASS, ACTION}
enum EClass {RAT, HUMAN, BIRD}

@export var disp : Vector2
@export var grid : Grid
@export var movables : MovableObjs

var distance : int = 1
var level : int = 0
var type : EClass
var obstacle_layers = []

var paused : bool = false

var paths = {}
var interactables = {}
var steps = []
var gridPosition

var historial = []

var prev_path = []
var prev_selected = []
var prev_target


func _ready():
	for i in range(len(obstacle_layers)):
		obstacle_layers[i] = grid.get_layer_by_name(obstacle_layers[i])
	gridPosition = grid.local_to_map(position)
	update_position(gridPosition)


func _process(delta):
	if paused: return
	
	var mouse = grid.to_local(get_viewport().get_mouse_position())
	var pos = grid.local_to_map(mouse)
	var mov_pos = Vector3i(pos.x, pos.y, level)
	
	if draw_path(pos) and Input.is_action_just_pressed("Action"):
		move()
	elif Input.is_action_just_pressed("Back"):
		back()
	elif mov_pos in interactables and Input.is_action_just_pressed("Action"):
		interact(interactables[mov_pos], mov_pos)
		update_position(gridPosition)
	elif Input.is_action_just_pressed("Pass"):
		historial.append({"type": EAction.PASS})


func time_back(action):
	if action.type == EAction.MOVE:
		update_position(action.path[0])
	elif action.type == EAction.PASS:
		pass
	else:
		return false
	return true


func interact(obj, position):
	pass


func update_position(pos):
	movables.move_object(Vector3i(gridPosition.x, gridPosition.y, level), \
						 Vector3i(pos.x, pos.y, level))
	gridPosition = pos
	
	clear()
	
	position = grid.map_to_local(pos) + disp * grid.tile_set.tile_size.x
	paths = grid.get_paths(distance, pos, obstacle_layers, type, level)
	interactables = movables.get_interactable(Vector3i(pos.x, pos.y, level), type)
	
	var selected_tiles = []
	for k in interactables.keys():
		selected_tiles.append(Vector2i(k.x, k.y))
	prev_selected = grid.draw_path(selected_tiles, 1)


func clear():
	grid.clear_path(prev_path)
	grid.clear_path(prev_selected)


func back():
	if not historial.is_empty():
		var action = historial.pop_back()
		time_back(action)


func move():
	historial.append({"type": EAction.MOVE, "path": steps})
	update_position(steps[-1])


func draw_path(pos):
	if pos == prev_target:
		return pos in paths
	
	grid.clear_path(prev_path)
	
	var prev = prev_target
	prev_target = pos
	if pos not in paths:
		return false
	
	var path
	if prev in paths[pos]: 
		path = paths[pos][prev]
	else:
		path = paths[pos].values()[0]
	steps = path
	
	prev_path = grid.draw_path(path.slice(1, len(path)), 0)
	
	return true
