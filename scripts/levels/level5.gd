extends MovableObjs


@export var pipa : Sprite2D
@export var cables : Array[Sprite2D]
@export var fusible : Sprite2D
@export var basura : Sprite2D
@export var arbol : Sprite2D
@export var metas : Array[Sprite2D]


func _ready():
	interactables[[0, pipa.position]] = {
		"type": EMovable.WIN, 
		"block": true,
		"can_interact": [Player.EClass.RAT],
		"sprite": pipa
	}
	
	var cabs = []
	for cable in cables:
		interactables[[1, cable.position]] = {
			"type": EMovable.CABLE, 
			"block": true,
			"can_interact": [],
			"sprite": cable
		}
	
	interactables[[0, fusible.position]] = {
		"type": EMovable.CONTROL, 
		"block": true,
		"can_interact": [Player.EClass.RAT],
		"sprite": fusible,
		"connected_to": cabs
	}
	
	for meta in metas:
		interactables[[0, meta.position]] = {
			"type": EMovable.WIN, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": meta
		}
	
	interactables[[0, basura.position]] = {
		"type": EMovable.BLOCK, 
		"block": true,
		"can_interact": [Player.EClass.HUMAN],
		"sprite": basura
	}
	
	interactables[[0, arbol.position]] = {
		"type": EMovable.WIN, 
		"block": true,
		"can_interact": [Player.EClass.BIRD],
		"sprite": arbol
	}

	super._ready()
