extends PanelContainer
class_name internalLine
#do the animation of text thingy
# Called when the node enters the scene tree for the first time.
@onready var rich_text_label = $NinePatchRect/MarginContainer/RichTextLabel
#will need a way to load in the text based on where we getting it from
signal text_finished
signal opened
signal closed
var isOpen = false
var infoEnter = false

func _enter_tree():
	#set the main instances to be player
	MainInstances.itemBox = self
	
func _ready():
	Events.info_box_entered.connect(infoBox)
	Events.info_box_exited.connect(noInfo)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(infoEnter)
	pass

func set_text(new_text):
	rich_text_label.bbcode_text = new_text
	text_finished.emit() #may still need for text animation, not sure

func open():
	#print("attempting to open?")
	visible = true
	isOpen = true
	opened.emit()
	
	
func close():
	visible = false
	isOpen = false
	#infoEnter = false
	closed.emit()
	
	
func infoBox(info):
	print("We have called this!")
	#if infoOpened == true:
	#	return
	#internal_dialogue.visible = true
	#internal_dialogue.set_text(info.infoText)
	#next figure out how to pause the game
	#get_tree().paused = true
	#infoOpened = true
	infoEnter = true
	set_text(info.infoText)
	#print(info.infoText)
	
func noInfo(info):
	infoEnter = false


func _on_texture_rect_pressed():
	#print("presesd!")
	close() # Replace with function body.
