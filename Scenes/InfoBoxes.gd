extends CanvasLayer

@onready var internal_dialogue = $InternalDialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	internal_dialogue.close()




func _input(event):
	#print("pressing e and info enter is: ")
	#print(internal_dialogue.infoEnter)
	if event.is_action_pressed("Interact") and internal_dialogue.infoEnter == true:
		#print("this was called now")
		#need some way to check if we can interact with the signal
		if internal_dialogue.isOpen:
			#print("reclosing dialogue...")
			internal_dialogue.close()
		else:
			#print("opening box now!")
			internal_dialogue.open()
		


func _on_internal_dialogue_opened():
	get_tree().paused = true

func _on_internal_dialogue_closed():
	get_tree().paused = false
