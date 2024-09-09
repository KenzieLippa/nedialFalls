extends Panel

class_name ItemStackGui

@onready var item_sprite = $ItemSprite
@onready var label = $Label
@onready var item_info_box = $ItemInfoBox
@onready var namedItem = $ItemInfoBox/NinePatchRect/Name
@onready var description = $ItemInfoBox/NinePatchRect2/Description


var inventorySlot

func _ready():
	item_info_box.visible = false
	#print("ready")
	
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
	
	namedItem.text = inventorySlot.item.name 
	description.text = inventorySlot.item.description
