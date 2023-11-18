extends Node2D
class_name TimeManager


@export var players : Array[Player]

var player_index : int = 0





func _ready():
	for i in range(1, len(players)):
		players[i].clear()
		players[i].paused = true


func _process(delta):
	if Input.is_action_just_pressed("Switch"):
		switch_player()


func switch_player():
	players[player_index].clear()
	players[player_index].paused = true
	player_index = (player_index + 1) % len(players)
	players[player_index].paused = false
