extends Node2D
class_name TimeManager


@export var players : Array[Player]


var player_index : int = 0
var time_step : int = 0


func go_to(step: int):
	print("go to ", step, " ", time_step)
	while time_step > step:
		time_back(null)
	while time_step < step:
		next_step(null)


func next_step(caller):
	time_step += 1
	print("###### NEXT #######")
	for player in players:
		print(time_step, player, player != caller, len(player.historial))
		if player != caller and len(player.historial) >= time_step:
			print(time_step, player, player.historial[time_step-1])
			player.time_step(player.historial[time_step-1])


func time_back(caller):
	if time_step == 0:
		return
	
	time_step -= 1
	print("###### BACK #######")
	for player in players:
		print(time_step, player, player != caller, len(player.historial))
		if player != caller and len(player.historial) >= (time_step+1):
			player.time_back(player.historial[time_step])


func _ready():
	for i in range(1, len(players)):
		players[i].clear()
		players[i].paused = true


func _process(delta):
	if Input.is_action_just_pressed("Switch"):
		switch_player()


func switch_player():
	players[player_index].pause(true)
	player_index = (player_index + 1) % len(players)
	players[player_index].pause(false)
