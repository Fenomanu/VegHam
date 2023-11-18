extends VBoxContainer


@export var starts : Player.EClass
@export var cam : CharacterCam
@export var buttons : Array[Button]
@export var characters : Array[Player]

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons[starts].button_pressed = true;
	if starts == 0:
		_on_rat_pressed()
	elif starts == 1:
		_on_human_pressed()
	elif starts == 2:
		_on_bird_pressed()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rat_pressed():
	cam.track(characters[0],3)
	characters[0].pause(false);
	if characters[1] != null:
		buttons[1].button_pressed = false;
		characters[1].pause(true);
	if characters[2] != null:
		buttons[2].button_pressed = false;
		characters[2].pause(true);
	pass # Replace with function body.


func _on_human_pressed():
	cam.track(characters[1],2)
	if characters[0] != null:
		characters[0].pause(true);
		buttons[0].button_pressed = false;
	characters[1].pause(false);
	if characters[2] != null:
		buttons[2].button_pressed = false;
		characters[2].pause(true);
	pass # Replace with function body.


func _on_bird_pressed():
	cam.track(characters[2], 1.3)
	if characters[0] != null:
		characters[0].pause(true);
		buttons[0].button_pressed = false;
	if characters[1] != null:
		characters[1].pause(true);
		buttons[1].button_pressed = false;
	characters[2].pause(false);
	pass # Replace with function body.
