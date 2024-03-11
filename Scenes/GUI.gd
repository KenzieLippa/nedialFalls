extends CanvasLayer

@onready var inventory_gui = $InventoryGui

func _ready():
	#start with closed inventory
	inventory_gui.close()

func _input(event):
	if event.is_action_pressed("toggle_Inventory"):
		if inventory_gui.isOpen:
			inventory_gui.close()
		else:
			inventory_gui.open()


func _on_inventory_gui_opened():
	get_tree().paused = true


func _on_inventory_gui_closed():
	get_tree().paused = false
