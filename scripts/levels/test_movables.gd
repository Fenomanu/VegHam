extends MovableObjs


@export var basura : Sprite2D


func _ready():
	#elem: {"type": EMovable, "block": bool, "can_interact" list[Player.EClass]}
	interactables = {
		[0, basura.position]: {
			"type": EMovable.BLOCK, 
			"block": true, 
			"can_interact": [Player.EClass.HUMAN]
		}
	}
