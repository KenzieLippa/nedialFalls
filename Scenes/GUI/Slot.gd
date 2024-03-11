extends Button

@onready var background = $Background
@onready var container = $CenterContainer

@onready var inventory = preload("res://Scripts/playerInventory.tres")
var itemStackGui : ItemStackGui
var index : int

func insert(isg):
	itemStackGui = isg
	background.frame = 0
	#add as a child
	
	container.add_child(itemStackGui)
	
	#reasons to not call
	if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot: return
	inventory.insertSlot(index, itemStackGui.inventorySlot)
	
	

func takeItem():
	var item = itemStackGui
	
	#also call remove slot
	inventory.removeSlot(itemStackGui.inventorySlot)
	container.remove_child(itemStackGui)
	itemStackGui = null
	background.frame = 1
	return item


func isEmpty():
	return !itemStackGui
