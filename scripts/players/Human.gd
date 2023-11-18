extends Player
class_name Human


func _ready():
	type = Player.EClass.HUMAN
	distance = 2
	level = 0
	obstacle_layers = ["obstacles", "human_obstacles"]
	
	super._ready()


func interact(obj, position):
	if obj.type == MovableObjs.EMovable.BLOCK:
		var mov_pos = position + (position - Vector3i(gridPosition.x, gridPosition.y, position.z))
		var pos = Vector2i(mov_pos.x, mov_pos.y)
		# #######################################
		# WARNING!
		# Posible bug if: 
		# - There is ground obstacle in a layr not included on obstacle_layers
		if !movables.occupied(mov_pos) and grid.walkable(pos, obstacle_layers, level, type):
			movables.move_object(position, mov_pos)
			obj.sprite.position = grid.map_to_local(pos) - Vector2(0.5, 0.5) * grid.tile_set.tile_size.x
			update_position(Vector2i(position.x, position.y))
			historial.append({
				"type": EAction.INTERACT, 
				"obj": obj, 
				"position": position,
				"mov_pos": mov_pos
			})


func time_step(action):
	if super.time_step(action): 
		return true
	
	if action.type == EAction.INTERACT and action.obj.type == MovableObjs.EMovable.BLOCK:
		var pos = Vector2i(action.mov_pos.x, action.mov_pos.y)
		
		movables.move_object(action.position, action.mov_pos)
		action.obj.sprite.position = grid.map_to_local(pos) - Vector2(0.5, 0.5) * grid.tile_set.tile_size.x
		update_position(Vector2i(action.position.x, action.position.y))
	else:
		return false
	return true


func time_back(action):
	if super.time_back(action):
		return true
	
	if action.type == EAction.INTERACT:
		var obj = action.obj
		if obj.type == MovableObjs.EMovable.BLOCK:
			var position = action.mov_pos
			
			var mov_player = Vector3i(gridPosition.x, gridPosition.y, position.z)
			var mov_pos = mov_player + (mov_player - position)
			var pos = Vector2i(mov_pos.x, mov_pos.y)
			
			movables.move_object(position, mov_player)
			obj.sprite.position = grid.map_to_local(gridPosition) - Vector2(0.5, 0.5) * grid.tile_set.tile_size.x
			update_position(pos)
	else:
		return false
	return true
