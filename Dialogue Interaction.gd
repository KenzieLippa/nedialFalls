extends Area2D

@export_multiline var infoText

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




#func _physics_process(delta):
	#var player = MainInstances.player as Player
	#var interact = player.interact
	#if not player is Player:
		#print("nope") 
		#return
	#if overlaps_area(interact):
		#
		#print("door entered")
		##if overlapping the player then create an event
		##we are teh door we are entering
		#Events.info_box_entered.emit(self) 
	

func _on_body_exited(body):
	print("exit")
	Events.info_box_exited.emit(self)


func _on_body_entered(body):
	print(body)
	Events.info_box_entered.emit(self) 
	#pass


#func _on_area_exited(area):
	#print("exited")
	#Events.info_box_exited.emit(self)
