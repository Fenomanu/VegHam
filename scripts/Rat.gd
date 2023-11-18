extends Player


func _ready():
	obstacle_layers = [grid.get_layer_by_name("obstacles")]
	type = Player.EClass.RAT
	distance = 1


func interact(obj, position):
	pass
