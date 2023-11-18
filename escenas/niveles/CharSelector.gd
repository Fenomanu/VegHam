extends VBoxContainer

@export var cam : CharacterCam
@export var buttons : Array[Button]
@export var characters : Array[Player]

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons[0].button_pressed = true;
	_on_rat_pressed();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rat_pressed():
	cam.track(characters[0],3)
	characters[0].paused = false;
	#characters[0].pause(false);
	buttons[1].button_pressed = false;
	characters[1].paused = true;
	#characters[1].pause(true);
	buttons[2].button_pressed = false;
	characters[2].paused = true;
	#characters[2].pause(true);
	pass # Replace with function body.


func _on_human_pressed():
	cam.track(characters[1],2)
	characters[0].paused = true;
	#characters[0].pause(true);
	buttons[0].button_pressed = false;
	characters[1].paused = false;
	#characters[1].pause(false);
	buttons[2].button_pressed = false;
	characters[2].paused = true;
	#characters[2].pause(true);
	pass # Replace with function body.


func _on_bird_pressed():
	cam.track(characters[2], 1.3)
	characters[0].paused = true;
	#characters[0].pause(true);
	buttons[0].button_pressed = false;
	characters[1].paused = true;
	#characters[1].pause(true);
	buttons[1].button_pressed = false;
	characters[2].paused = false;
	#characters[2].pause(false);
	pass # Replace with function body.
