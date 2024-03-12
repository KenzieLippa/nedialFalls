extends Control

signal opened
signal closed
var isOpen = false
var selected_button: Button = null

#preload the inventory, can load a resource in multiple places
@onready var inventory: Inventory = preload("res://Scripts/playerInventory.tres")

@onready var itemStackGuiClass = preload("res://Scenes/Items/ItemStackGUI.tscn")
@onready var hotbar_slots = $Hotbar.get_children()

#@onready var hotbar_slots = $NinePatchRect/HotbarSlots.get_children()
@onready var inventory_window = $InventoryWindow

#get all the children slots
@onready var slots: Array = hotbar_slots + $InventoryWindow/GridContainer.get_children()

var itemInHand: ItemStackGui
var oldIndex: int = -1
var locked = false
var i : int

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	
#connects the slots
func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		var callable = Callable(onSlotClicked)
		#to add input we need to bind to callable
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	#to prevent issues with out of bounds
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot = inventory.slots[i] #curr slot
		
		if !inventorySlot.item: continue #dont need to add cause its already there
		
		var itemStackGui = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = itemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui) #insert into scene tree after instantiated
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()
func open():
	inventory_window.visible = true
	isOpen = true
	opened.emit()
	
func close():
	inventory_window.visible = false
	isOpen = false
	closed.emit()
	


#recieve button signal want to figure out which button cliccked
func onSlotClicked(slot):
	if locked: return
	#see if our current selected button is the selected button
	if selected_button != slot and selected_button != null:
		#deselect old button
		selected_button.deselect()
	#select new button
	selected_button = slot
	selected_button.selected()
	if slot.isEmpty():
		if !itemInHand: return
		
		insertItemInSlot(slot)
		return
	if !itemInHand:
		takeItemFromSlot(slot)
		return
	if slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
		stackItems(slot)
		return
	swapItems(slot)
	
func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()
	
	oldIndex = slot.index
	
func insertItemInSlot(slot):
	var item = itemInHand #store in temp
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)
	
	oldIndex = -1

func swapItems(slot):
	#take and insert
	var tmpItem = slot.takeItem()
	
	insertItemInSlot(slot)
	itemInHand = tmpItem
	add_child(itemInHand)
	updateItemInHand()
	
func stackItems(slot):
	var slotItem :ItemStackGui = slot.itemStackGui
	var maxAmount = slotItem.inventorySlot.item.maxPerSlot
	var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
	
	#three cases
	if slotItem.inventorySlot.amount == maxAmount:
		#just swap
		swapItems(slot)
		return
	if totalAmount <=maxAmount:
		slotItem.inventorySlot.amount = totalAmount
		#remove whats in our hand
		remove_child(itemInHand)
		itemInHand = null
		oldIndex = -1
	else:
		slotItem.inventorySlot.amount = maxAmount
		#item in hand gets whats left
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
		
	slotItem.update()
	if itemInHand: itemInHand.update() #in case removed

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size /2
	
func putItemBack():
	locked = true
	#lock while being returned
	if oldIndex< 0: 
		var emptySlots = slots.filter(func(s) :return s.isEmpty())
		if emptySlots.is_empty(): return
		oldIndex =  emptySlots[0].index
	var targetSlot = slots[oldIndex]
	insertItemInSlot(targetSlot)
	locked = false
	
func _input(event):
	#only need to check for right click if item in hand
	if itemInHand && !locked && Input.is_action_just_pressed("rightClick"):
		putItemBack()
	updateItemInHand()
