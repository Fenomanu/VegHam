extends Node2D
class_name TimeManager


@export var players : Array[Player]
@export var turnCounter: TrunCounter
@export var maxTurns: int


var player_index : int = 0
var time_step : int = 0


func go_to(step: int):
	#print("go to ", step, " ", time_step)
	while time_step > step:
		time_back(null)
	while time_step < step:
		next_step(null)


func next_step(caller):
	var win = true
	for player in players:
		if len(player.historial) > 0:
			win = win and player.historial[-1].type == Player.EAction.WIN
		else:
			win = false
	if win:
		turnCounter.next_level()
	
	time_step += 1
	#print("###### NEXT #######")
	for player in players:
		turnCounter.set_turns_left(player.type, maxTurns - len(player.historial))
		#print(time_step, player, player != caller, len(player.historial))
		if player != caller and len(player.historial) >= time_step:
			#print(time_step, player, player.historial[time_step-1])
			player.time_step(player.historial[time_step-1])


func time_back(caller):
	if time_step == 0:
		return
	
	time_step -= 1
	#print("###### BACK #######")
	for player in players:
		turnCounter.set_turns_left(player.type, maxTurns - len(player.historial))
		#print(time_step, player, player != caller, len(player.historial))
		if player != caller and len(player.historial) >= (time_step+1):
			player.time_back(player.historial[time_step])


func _ready():
	turnCounter.init_turns(maxTurns)
	for player in players:
		player.max_turn = maxTurns
	for i in range(1, len(players)):
		players[i].clear()
		players[i].paused = true
