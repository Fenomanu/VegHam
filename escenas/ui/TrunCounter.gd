extends Control

@export var next_scene : PackedScene
@export var sliders : Array[Slider]
@export var scores : Array[Label]


var max_ts : int

# Called when the node enters the scene tree for the first time.
func _ready():
	init_turns(10)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_turns(max_turns : int):
	max_ts = max_turns
	set_turns_left(Player.EClass.RAT, max_turns)
	set_turns_left(Player.EClass.HUMAN, max_turns)
	set_turns_left(Player.EClass.BIRD, max_turns)

func set_turns_left(player : Player.EClass, tl : int):
	if player == Player.EClass.RAT && scores[0] != null:
		scores[0].text = str(tl)
		sliders[0].value = float(max_ts - tl)/max_ts
	elif player == Player.EClass.HUMAN && scores[1] != null:
		scores[1].text = str(tl)
		sliders[1].value = float(max_ts - tl)/max_ts
	elif player == Player.EClass.BIRD && scores[2] != null:
		scores[2].text = str(tl)
		sliders[2].value = float(max_ts - tl)/max_ts

func next_level():
	get_tree().change_scene_to_packed(next_scene)
