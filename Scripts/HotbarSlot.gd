extends Button
@onready var background = $Background
@onready var itemStackGui = $CenterContainer/Panel



func update_to_slot(slot):
	if !slot.item:
		itemStackGui.visible = false
		background.frame = 1
		return
	
	itemStackGui.inventorySlot = slot
	itemStackGui.update()
	itemStackGui.visible = true
	
	background.frame = 0
