extends Node2D
class_name Player

enum EAction {MOVE}
enum EClass {RAT=0, HUMAN=1, BIRD=2}


@export var grid : Grid
@export var distance : int

var paused : bool = false
var type : EClass
var obstacle_layers = []

var paths = {}
var steps = []

var prev_path = []
var historial = []
var prev_target


func _ready():
	obstacle_layers = [grid.get_layer_by_name("obstacles")]
	paths = grid.get_paths(distance, global_position, obstacle_layers)


func _process(delta):
	if paused: return
	
	var mouse = grid.to_local(get_viewport().get_mouse_position())
	var pos = grid.local_to_map(mouse)
	
	if draw_path(pos) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		move()
	elif Input.is_action_just_pressed("Back"):
		back()


func back():
	if not historial.is_empty():
		var action = historial.pop_back()
		if action.type == EAction.MOVE:
			position = grid.map_to_local(action.path[0]) - Vector2.ONE * (grid.size / 2)
			grid.clear_path(prev_path)
			paths = grid.get_paths(distance, global_position, obstacle_layers)


func move():
	historial.append({"type": EAction.MOVE, "path": steps})
	position = grid.map_to_local(steps[-1]) - Vector2.ONE * (grid.size / 2)
	grid.clear_path(prev_path)
	paths = grid.get_paths(distance, global_position, obstacle_layers)


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
