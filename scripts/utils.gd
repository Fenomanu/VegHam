extends Object
class_name utils

static func find_by_class(node: Node) -> Array:
	var result = []
	if node is Player:
		result.push_back(node)
	for child in node.get_children():
		result += find_by_class(child)
	return result
