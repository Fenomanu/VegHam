extends Control

@export var scenes : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(scenes[0])
	pass # Replace with function body.


func _on_button_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
