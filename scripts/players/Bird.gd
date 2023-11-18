extends Player
class_name Bird

func _ready():
	type = Player.EClass.BIRD
	distance = 3
	obstacle_layers = ["obstacles", "bird_obstacles"]
	
	super._ready()


func interact(obj, position):
	pass
