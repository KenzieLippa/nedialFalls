extends Panel

class_name ItemStackGui

@onready var item_sprite = $ItemSprite
@onready var label = $Label

var inventorySlot

func update():
	if !inventorySlot || !inventorySlot.item:return
	#if nothing is in there or it doesnt exist
	
	item_sprite.visible = true
	item_sprite.texture = inventorySlot.item.texture
	if inventorySlot.amount >1:
		label.visible = true
		label.text = str(inventorySlot.amount)
	else:
		label.visible = false

