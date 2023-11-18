extends Node2D
class_name Player

enum EAction {MOVE, INTERACT, PASS}
enum EClass {RAT=0, HUMAN=1, BIRD=2}

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

var prev_path = []
var historial = []
var prev_target


func _ready():
	for i in range(len(obstacle_layers)):
		obstacle_layers[i] = grid.get_layer_by_name(obstacle_layers[i])
	update_position(grid.local_to_map(position))


func _process(delta):
	if paused: return
	
	var mouse = grid.to_local(get_viewport().get_mouse_position())
	var pos = grid.local_to_map(mouse)
	
	if draw_path(pos) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		move()
	elif Input.is_action_just_pressed("Back"):
		back()
	elif pos in interactables and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		interact(interactables[pos], pos)


func interact(obj, position):
	pass


func update_position(pos):
	grid.clear_path(prev_path)
	position = grid.map_to_local(pos) + disp * grid.tile_set.tile_size.x
	paths = grid.get_paths(distance, pos, obstacle_layers, type, level)
	interactables = movables.get_interactable(Vector3i(pos.x, pos.y, level), type)


func back():
	if not historial.is_empty():
		var action = historial.pop_back()
		if action.type == EAction.MOVE:
			update_position(action.path[0])
		elif action.type == EAction.PASS:
			pass


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
	
	prev_path = grid.draw_path(path.slice(1, len(path)))
	
	return true
