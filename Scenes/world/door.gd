class_name Door
extends Area2D
@onready var down = $Down

@export_file("*.tscn") var new_level_path
# Called when the node enters the scene tree for the first time.
#func get direction():
#if left_cast.is_colliding(): return 1
#if right_cast.is_colliding(): return -1 
#else: return 0

func _physics_process(delta):
	var player = MainInstances.player as Player
	if not player is Player:
		print("nope") 
		return
	if overlaps_body(player):
		
		#print("door entered")
		#if overlapping the player then create an event
		if Input.is_action_just_released("Interact"):
			
			Events.door_entered.emit(self) #we are teh door we are entering
		
