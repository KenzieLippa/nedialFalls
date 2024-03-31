extends TileMap

#using this approach instead of the resource one
func can_be_tilled(global_position):
	var map_position = local_to_map(global_position)
	#var tile_id = get_cell_atlas_coords(map_position)
	
	
#func _ready():
	#var map_position = local_to_map(global_position)
	#print(map_position)
	#var tile_id = get_cell(map_position.x, map_position.y)
	#if tile_id != -1:
		#print("TIle ID at this position is: ", tile_id)
