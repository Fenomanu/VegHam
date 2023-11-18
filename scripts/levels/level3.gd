extends MovableObjs


@export var basura : Sprite2D
@export var meta_rata : Sprite2D
@export var metas : Array[Sprite2D]


func _ready():
	interactables[[0, basura.position]] = {
		"type": EMovable.BLOCK, 
		"block": true,
		"can_interact": [Player.EClass.HUMAN],
		"sprite": basura
	}
	
	interactables[[0, meta_rata.position]] = {
		"type": EMovable.WIN, 
		"block": true,
		"can_interact": [Player.EClass.RAT],
		"sprite": meta_rata
	}
	
	for meta in metas:
		interactables[[0, meta.position]] = {
			"type": EMovable.WIN, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": meta
		}

	super._ready()
