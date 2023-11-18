extends Player
class_name Rat


func _ready():
	type = Player.EClass.RAT
	distance = 1
	level = 0
	obstacle_layers = ["obstacles", "rat_obstacles"]
	
	super._ready()


func interact(obj, position):
	pass
