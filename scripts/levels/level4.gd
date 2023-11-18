extends MovableObjs


@export var pipa : Sprite2D
@export var cable : Sprite2D
@export var fusible : Sprite2D
@export var basuras : Array[Sprite2D]
@export var metas : Array[Sprite2D]


func _ready():
	interactables[[0, pipa.position]] = {
		"type": EMovable.WIN, 
		"block": true,
		"can_interact": [Player.EClass.RAT],
		"sprite": pipa
	}
	
	interactables[[0, cable.position]] = {
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
		"connected_to": [interactables[[0, cable.position]]]
	}
	
	for meta in metas:
		interactables[[0, meta.position]] = {
			"type": EMovable.WIN, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": meta
		}
	
	for basura in basuras:
		interactables[[0, basura.position]] = {
			"type": EMovable.BLOCK, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": basura
		}

	super._ready()
