extends TileMap
class_name Grid


enum ActionType {MOVE}


@export var arrow : Texture
@export var selected : Texture
@export var movables : MovableObjs

static var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]


func clear_path(path):
	while not path.is_empty():
		path.pop_front().queue_free()


func draw_path(path, text):
	var result = []
	for step in path: 
		var sprite = Sprite2D.new()
		result.append(sprite)
		add_child(sprite)
		sprite.position = map_to_local(step)
		sprite.texture = (arrow if text == 0 else selected)
	return result


func get_layer_by_name(name):
	for i in range(get_layers_count()):
		if get_layer_name(i) == name:
			return i
	push_warning("Can not found layer " + name)
	return -1


func tile_exists_in_layer(pos, layer): 
	return get_cell_tile_data(layer, pos) != null


func straight_path(dist, src, obstacle_layers, type, level):
	var paths = {}
	var options = []
	for dir in directions:
		options.append([dir, src])
	var aux = []
	for i in range(dist):
		for path in options:
			var curr = path[-1] + path[0]
			if walkable(curr, obstacle_layers, level, type):
				var new_path = path + [curr]
				aux.append(new_path)
				paths[curr] = {path[-1]: new_path.slice(1, len(new_path))}
		options = aux
		aux = []
	return paths


func walkable(pos, obstacle_layers, level, type):
	return not obstacle_layers.any(func(o): return tile_exists_in_layer(pos, o)) and \
		movables.check_walkable(Vector3i(pos.x, pos.y, level), type)


func get_paths(dist, src, obstacle_layers, type, level):
	if type == Player.EClass.BIRD:
		return straight_path(dist, src, obstacle_layers, type, level)
	var paths = {}
	var options = [[src]]
	var aux = []
	for i in range(dist):
		for path in options:
			for dir in directions:
				var curr = path[-1] + dir
				if curr not in path and walkable(curr, obstacle_layers, level, type):
					var new_path = path + [curr]
					if curr not in paths:
						aux.append(new_path)
						paths[curr] = {path[-1]: new_path}
					elif path[-1] not in paths[curr]:
						aux.append(new_path)
						paths[curr][path[-1]] = new_path
		options = aux
		aux = []
	return paths
