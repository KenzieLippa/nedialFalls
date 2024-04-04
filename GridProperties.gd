extends TileMap

#using this approach instead of the resource one
@export var can_till :bool
@export var can_plant_tree : bool
@export var is_active : bool
@export var isFull : Dictionary
var isValid = false
const TILESIZE = 128
var mouseInRange = false
var tmp = preload("res://Scenes/world/bush.tscn")

func can_be_tilled(global_position):
	var map_position = local_to_map(global_position)
	#var tile_id = get_cell_atlas_coords(map_position)
	
	
func _ready():
	var map_position = local_to_map(global_position)
	#print(map_position)
	#var tile_id = get_cell(map_position.x, map_position.y)
	var usedCell = get_used_cells(0)
	for cell in usedCell:
		isFull[cell] = false
	#print(isFull)
	#print(usedCell)
	#print(can_till)
	var mouse = get_global_mouse_position()
	#print(mouse)
	turn_into_tile(mouse)
	
	#print(mouse)
	#if tile_id != -1:
		#print("TIle ID at this position is: ", tile_id)
func _process(delta):
	if !MainInstances.gridCursor.active:
		is_active = false
	if MainInstances.gridCursor.active:
		
		is_active = true
	if is_active:
		var mouse = get_global_mouse_position()
		#print(mouse)
		if MainInstances.player.cursorInRange:
				MainInstances.gridCursor.frame = 0
				isValid = true
		else:
			MainInstances.gridCursor.frame = 1
			isValid = false
				
		if isValid:
			turn_into_tile(mouse)
			if mouseInRange:
				#if MainInstances.player.cursorInRange:
				MainInstances.gridCursor.frame = 0
				isValid = true
			else:
				MainInstances.gridCursor.frame = 1
				isValid = false
			
	
func turn_into_tile(pos):
	var tileLoc = floor(pos/ TILESIZE)
	var usedCell = get_used_cells(0)
	mouseInRange = false
	for cell in usedCell:
		var tmpCell = Vector2(cell.x, cell.y)
		if tileLoc == tmpCell:
			#MainInstances.gridCursor.frame = 0
			if isFull[cell] == false:
				mouseInRange = true
			if Input.is_action_just_pressed("leftClick"):
				var selectedItem = MainInstances.inventory.slots[MainInstances.selectedSlot].item
				if selectedItem:
					if selectedItem.isPlant:
						#print("plant selected")
						if !selectedItem.needsSoil:
							if selectedItem.plantPath != null:
								create_plant(pos, cell, selectedItem.plantPath) #will need to fix up the grid properties so it reflects if its soil and then stores if that is the case
				#create_bush(pos,cell)
				#print("true")
				pass
			break
			
		

		
	#print(tileLoc)
	
#func create_bush(pos, tileLoc):
	##print(isFull)
	#MainInstances.gridCursor.frame =1
	#if isFull.has(tileLoc):
		#if isFull[tileLoc] == false:
			#var tmpInstance = tmp.instantiate()
			#if MainInstances.gridCursor != null:
				#tmpInstance.position =  MainInstances.gridCursor.snapped_pos
				#add_child(tmpInstance)
				#isFull[tileLoc] = true
		

func create_plant(pos, tileLoc, scene):
	#print(isFull)
	MainInstances.gridCursor.frame =1
	if isFull.has(tileLoc):
		if isFull[tileLoc] == false:
			var tmpInstance = scene.instantiate()
			if MainInstances.gridCursor != null:
				tmpInstance.position =  MainInstances.gridCursor.snapped_pos
				MainInstances.level.add_child(tmpInstance)
				isFull[tileLoc] = true
		
