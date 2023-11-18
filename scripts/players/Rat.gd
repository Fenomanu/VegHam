extends Player
class_name Rat


func _ready():
	type = Player.EClass.RAT
	distance = 1
	level = 0
	obstacle_layers = ["obstacles", "rat_obstacles"]
	
	super._ready()


func interact(obj, position):
	if super.interact(obj, position):
		return true
	
	if obj.type == MovableObjs.EMovable.CONTROL:
		var action = {
			"type": EAction.INTERACT, 
			"obj": obj
		}
		time_step(action)
		historial.append({
			"type": EAction.INTERACT, 
			"obj": obj
		})
	else:
		return false
	return true


func time_step(action):
	if super.time_step(action): 
		return true
	
	if action.type == EAction.INTERACT and action.obj.type == MovableObjs.EMovable.CONTROL:
		action.obj.can_interact = []
		action.obj.sprite.set_frame(1)
		for t in action.obj.connected_to:
			t.block = false
			t.sprite.set_frame(1)
	else:
		return false
	return true

func time_back(action):
	if super.time_back(action):
		return true
	
	if action.type == EAction.INTERACT:
		var obj = action.obj
		if obj.type == MovableObjs.EMovable.CONTROL:
			obj.can_interact = [Player.EClass.RAT]
			obj.sprite.set_frame(0)
			for t in obj.connected_to:
				t.block = true
				t.sprite.set_frame(0)
	else:
		return false
	return true
