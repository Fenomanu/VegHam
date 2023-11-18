extends Node2D
class_name MovableObjs


enum EMovable {BLOCK, CONTROL, CABLE, PLAYER}


@export var grid: Grid


static var directions = [Vector3i(0, 1, 0), Vector3i(0, -1, 0), Vector3i(1, 0, 0), Vector3i(-1, 0, 0)]


var interactables = {}
#elem: {"type": EMovable, "block": true, "can_interact" list[]}


func _ready():
	var result = {}
	for k in interactables.keys():
		var p = grid.local_to_map(k[1])
		result[Vector3i(p.x, p.y, k[0])] = interactables[k]
	interactables = result


func check_walkable(pos: Vector3i, type: Player.EClass):
	if pos not in interactables:
		return true
	
	if type == Player.EClass.BIRD:
		# Bird collides with all in his layer
		return !interactables[pos].block
	elif type == Player.EClass.HUMAN:
		# Human collides with all in his layer
		return !interactables[pos].block
	elif type == Player.EClass.RAT:
		# Rat collides with all in his layer
		return !interactables[pos].block
	
	push_warning("Unknown player class")
	return false


func move_object(ini_pos: Vector3i, end_pos: Vector3i):
	if ini_pos in interactables:
		interactables[end_pos] = interactables[ini_pos]
		interactables.erase(ini_pos)


func get_interactable(pos: Vector3i, player_class: Player.EClass):
	var result = {}
	for dir in directions:
		var key = pos + dir
		if key in interactables and player_class in interactables[key].can_interact:
			result[key] = interactables[key]
	return result


func occupied(pos: Vector3i):
	return pos in interactables
