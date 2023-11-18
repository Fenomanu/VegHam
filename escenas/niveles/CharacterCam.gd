extends Camera2D
class_name CharacterCam

var player : Player
var camzoom : float

var time_to_zoom = .7
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(player):
		if time < time_to_zoom:
			time += delta
		position = position.lerp(player.global_position, delta * 10)
		zoom = zoom + (Vector2(camzoom, camzoom) - zoom) * time
	pass


func track(pl : Player, zm : float):
	player = pl
	camzoom = zm
	time = 0
	pass
