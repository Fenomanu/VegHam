extends Player
class_name Rat


func _ready():
	type = Player.EClass.RAT
	distance = 1
	level = 0
	obstacle_layers = ["obstacles", "rat_obstacles"]
	
	super._ready()


func interact(obj, position):
	if obj.type == MovableObjs.EMovable.CONTROL:
		obj.can_interact = []
		# set sprite to broken
		for t in obj.connected_to:
			t.block = false
			# set sprite no energy
			# all players should recalculate paths
