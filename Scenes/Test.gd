extends Node2D
class_name World
@onready var level = $Test

var testRoom = preload("res://Scenes/inside.tscn").instantiate()
@onready var internal_dialogue = $InfoBoxes/InternalDialogue
var infoOpened = false
@onready var grid_cursor = $GridCursor
var overInventory = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#RedneringServer.set_default_clear_color(Color.BLACK)
	Events.door_entered.connect(changeLevel)
	MainInstances.gridCursor.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#make sure not visible
	internal_dialogue.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("changeRoom"):
		changescene()
	
	if !overInventory:
		if MainInstances.selectedSlot != -1 and MainInstances.inventory.slots[MainInstances.selectedSlot].item != null:
			if MainInstances.inventory.slots[MainInstances.selectedSlot].item.canPlace == true:
				MainInstances.mouseVisible()
			else:
				MainInstances.mouseInvisible()
	else:
			MainInstances.mouseInvisible()
	
	#not sure if this is the best way or not...
	#if internal_dialogue.visible == true and Input.is_action_just_pressed("Interact"):
		#unpause()
		#internal_dialogue.visible = false
		#

			

func changescene():
	get_tree().root.add_child(testRoom)


	
func changeLevel(door):
	#get access to the player
	var player = MainInstances.player as Player
	if not player is Player: return
	#get rid of old level
	level.queue_free()
	#now create the new level
	var new_level = load(door.new_level_path).instantiate()
	
	#need to load the new level and instantiate it
	#now add it as a child and set the level to be this
	add_child(new_level)
	level = new_level
	var doors = get_tree().get_nodes_in_group("doors") #get all the doors
	for found_doors in doors:
		if found_doors == door: continue #if this is the same door we came out of then continue
		#should figure out how to have multiple doors in a scene
		player.global_position = found_doors.global_position
	pass

#func unpause():
	#get_tree().paused = false


func _on_area_2d_mouse_entered():
	overInventory = true
	MainInstances.mouseInvisible()
	#print("mouse enters")
	





func _on_area_2d_mouse_exited():
	overInventory = false
