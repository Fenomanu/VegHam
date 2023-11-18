extends MovableObjs


@export var basuras : Array[Sprite2D]
@export var metas : Array[Sprite2D]


func _ready():
	#elem: {"type": EMovable, "block": bool, "can_interact" list[Player.EClass]}
	for basura in basuras:
		interactables[[0, basura.position]] = {
			"type": EMovable.BLOCK, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": basura
		}
		
	for meta in metas:
		interactables[[0, meta.position]] = {
			"type": EMovable.WIN, 
			"block": true,
			"can_interact": [Player.EClass.HUMAN],
			"sprite": meta
		}

	super._ready()
