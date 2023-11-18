extends MovableObjs

@export var sprite1 : AnimatedSprite2D
@export var sprite2 : AnimatedSprite2D

var dict_objs

# Called when the node enters the scene tree for the first time.
func _ready():
	var dict_objs = {Vector3i(0,0,0):{EMovable.BLOCK:sprite1}}
	dict_objs[Vector3i(0,1,0)] = {EMovable.KEY:sprite2}
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func check_walkable(pos, player_class):
	var objs = [false, false]
	var down = Vector3i(pos[0], pos[1], 0)
	var top = Vector3i(pos[0], pos[1], 1)
	if down in dict_objs:
		objs[0] = dict_objs[down]
	if top in dict_objs:
		objs[1] = dict_objs[top]
	
	if !objs[0] and !objs[1]: return true
	
	if player_class == Player.EClass.HUMAN:
		if objs[0]: return false
	elif player_class == Player.EClass.BIRD:
		if objs[1]: return false
	elif player_class == Player.EClass.RAT:
		if objs[0]: return false
		
	return true
	pass

func move_object(ini_pos, end_pos):
	
	pass

func return_objs(pos, player_class):
	
	pass
