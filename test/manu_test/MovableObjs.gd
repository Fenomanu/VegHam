extends Node2D
class_name MovableObjs

enum EMovable {CAT=0, BLOCK=1, KEY=2, DOOR=3, CONTROL=4, CABLETOP=5, CABLELOW=6}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func check_walkable():
	
	pass

func move_object(ini_pos, end_pos):
	pass

func return_objs(pos, player_class):
	
	pass
