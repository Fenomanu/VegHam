extends Player
class_name Human


func _ready():
	type = Player.EClass.HUMAN
	distance = 2
	level = 0
	obstacle_layers = ["obstacles", "human_obstacles"]
	
	super._ready()


func interact(obj, position):
	pass
