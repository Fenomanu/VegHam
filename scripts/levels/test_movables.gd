extends MovableObjs


@export var basura : Sprite2D
@export var cable : Sprite2D
@export var tendido : Array[Sprite2D]


func _ready():
	#elem: {"type": EMovable, "block": bool, "can_interact" list[Player.EClass]}
	interactables = {
		[0, basura.position]: {
			"type": EMovable.BLOCK, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": basura
		}
	}
	
	var tendidoRefs = []
	for t in tendido:
		interactables[[1, t.position]] = {
			"type": EMovable.CABLE, 
			"block": true,
			"can_interact": [],
			"sprite": t
		}
		tendidoRefs.append(interactables[[1, t.position]])
	
	interactables[[0, cable.position]] = {
			"type": EMovable.CONTROL, 
			"block": true,
			"can_interact": [Player.EClass.RAT],
			"sprite": cable,
			"connected_to": tendidoRefs
		}
		
	super._ready()
