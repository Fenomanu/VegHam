extends MovableObjs


@export var basuras : Array[Sprite2D]


func _ready():
	#elem: {"type": EMovable, "block": bool, "can_interact" list[Player.EClass]}
	var tendidoRefs = []
	for basura in basuras:
		interactables[[0, basura.position]] = {
			"type": EMovable.BLOCK, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": basura
		}

	super._ready()
