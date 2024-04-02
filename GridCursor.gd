extends Sprite2D
class_name GridCursor
var gridSize = Vector2(128,128)
var active = true
var snapped_pos = Vector2.ZERO

func _enter_tree():
	MainInstances.gridCursor = self
func _process(delta):
	if active:
		var mouse_pos = get_global_mouse_position()
		snapped_pos = snap_to_grid(mouse_pos)
		position = snapped_pos
	
func snap_to_grid(pos):
	var gridx = 0
	var gridy = 0
	if pos.x >= 0:
		gridx = int(pos.x/gridSize.x) * gridSize.x + gridSize.x /2
	elif pos.x < 0:
		gridx = int(pos.x/gridSize.x) * gridSize.x - gridSize.x /2
	if pos.y >=0:
		gridy = int(pos.y/gridSize.y) * gridSize.y + gridSize.y /2
	elif pos.y < 0:
		gridy = int(pos.y/gridSize.y) * gridSize.y - gridSize.y /2
	return Vector2(gridx, gridy)
