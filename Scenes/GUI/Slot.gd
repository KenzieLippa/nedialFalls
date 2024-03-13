extends Button

@onready var background = $Background
@onready var container = $CenterContainer

@onready var inventory = preload("res://Scripts/playerInventory.tres")
var itemStackGui : ItemStackGui
var index : int
var parent_node = null #no parent by default
var isSelected = false
#get the parent in the ready function
func _ready():
	parent_node = get_parent()
	#if is_instance_valid(parent_node):
		#isHotbar()
func insert(isg):
	itemStackGui = isg
	#background.frame = 0
	#add as a child
	
	container.add_child(itemStackGui)
	
	#reasons to not call
	#isHotbar()
	if is_instance_valid(parent_node):
		if isHotbar():
			if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot: return
			inventory.insertSlot(index, itemStackGui.inventorySlot, inventory.slots)
		


func takeItem():
	var item = itemStackGui
	
	#also call remove slot
	inventory.removeSlot(itemStackGui.inventorySlot, inventory.slots)
	container.remove_child(itemStackGui)
	itemStackGui = null
	#background.frame = 0
	return item


func isEmpty():
	return !itemStackGui
	
func isHotbar():
	if parent_node is HotbarSlot:
		#print("parent is hotbar")
		return true
	elif parent_node is InventoryBar:
		#print("parent is inventory slot")
		return false
	#will need to be changed if this gets messed up, potentially look for a way to standardize it
	
func selected():
	background.frame = 0
	isSelected = true
	
func deselect():
	background.frame = 1
	isSelected = false
