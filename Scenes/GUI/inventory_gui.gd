extends Control

signal opened
signal closed
var isOpen = false
var selected_button: Button = null
var previous_slot: Button = null

#preload the inventory, can load a resource in multiple places
@onready var inventory: Inventory = MainInstances.inventory

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
		var buttonEnt = Callable(buttonEntered)
		buttonEnt = buttonEnt.bind(slot)
		slot.mouse_entered.connect(buttonEnt)
		var buttonExt = Callable(buttonExited)
		buttonExt = buttonExt.bind(slot)
		slot.mouse_exited.connect(buttonExt)

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
	
func buttonEntered(slot):
	if slot.itemStackGui != null and !itemInHand:
		var infoBox = slot.itemStackGui.item_info_box
		infoBox.visible = true
		
func buttonExited(slot):
	if slot.itemStackGui != null:
		var infoBox = slot.itemStackGui.item_info_box
		infoBox.visible = false

#recieve button signal want to figure out which button cliccked
func onSlotClicked(slot):
	if locked: return
	#see if our current selected button is the selected button
	if selected_button != slot and selected_button != null:
		#deselect old button
		
		selected_button.deselect()
	#select new button
	previous_slot = selected_button
	selected_button = slot
	selected_button.selected(slot.index)
	
	#print(slot.index)
	#if inventory.slots[slot.index].item != null:
		#print(inventory.slots[slot.index].item.name)
	if isOpen:
		if previous_slot == selected_button: pass
		if !itemInHand and !slot.isEmpty():
			takeItemFromSlot(slot)
			return
		#print("this is true")
		if slot.isEmpty():
			if !itemInHand: return
			
			insertItemInSlot(slot)
			return
		if !itemInHand:return
		if slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
			stackItems(slot)
			return
		swapItems(slot)

	
func takeItemFromSlot(slot):
	#try running this to see if we can get this to take the label away
	
	buttonExited(slot)
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()
	
	oldIndex = slot.index
	
func insertItemInSlot(slot):
	var item = itemInHand #store in temp
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)
	buttonEntered(slot)
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
	
	if Input.is_action_just_pressed("swap inventory"):
		print("swap rows")
		#for slot in hotbar_slots:
			#if slot.itemStackGui != null:
				#print(slot.itemStackGui.inventorySlot.item.name)
		swap_inventory_rows()
	

	if Input.is_action_just_pressed("hotbar_1"):
		onSlotClicked(hotbar_slots[0])
	if Input.is_action_just_pressed("hotbar_2"):
		onSlotClicked(hotbar_slots[1])
	if Input.is_action_just_pressed("hotbar_3"):
		onSlotClicked(hotbar_slots[2])
	if Input.is_action_just_pressed("hotbar_4"):
		onSlotClicked(hotbar_slots[3])
	if Input.is_action_just_pressed("hotbar_5"):
		onSlotClicked(hotbar_slots[4])
	if Input.is_action_just_pressed("hotbar_6"):
		onSlotClicked(hotbar_slots[5])
	if Input.is_action_just_pressed("hotbar_7"):
		onSlotClicked(hotbar_slots[6])
	if Input.is_action_just_pressed("hotbar_8"):
		onSlotClicked(hotbar_slots[7])
		
#TODO: fix the day night UI
				
func swap_inventory_rows():
	var row_size = hotbar_slots.size()
	
#init the rows
	var tmp_hotbar = []
	var row_one = []
	var row_two = []
	var row_three = []
	
#fill the rows with the corresponding slots
	for slot in hotbar_slots:
		tmp_hotbar.append(slot)
		
	for i in range(row_size):
		row_one.append(slots[i+row_size])
		row_two.append(slots[i+row_size * 2])
		row_three.append(slots[i+ row_size * 3])
		
	# store the items temporarily with null checks
	var tmp_items_hotbar = []
	var tmp_items_row_one = []
	var tmp_items_row_two = []
	var tmp_items_row_three = []
	
	for i in range(row_size):
		tmp_items_hotbar.append(tmp_hotbar[i].takeItem() if tmp_hotbar[i].itemStackGui else null)
		tmp_items_row_one.append(row_one[i].takeItem() if row_one[i].itemStackGui else null)
		tmp_items_row_two.append(row_two[i].takeItem() if row_two[i].itemStackGui else null)
		tmp_items_row_three.append(row_three[i].takeItem() if row_three[i].itemStackGui else null)
#now we swap baby!
	for i in range(row_size):
		if tmp_items_row_three[i]:
			#move from hotbar to three
			tmp_hotbar[i].insert(tmp_items_row_three[i])
		if tmp_items_row_two[i]:
			row_three[i].insert(tmp_items_row_two[i])
		if tmp_items_row_one[i]:
			row_two[i].insert(tmp_items_row_one[i])
		if tmp_items_hotbar[i]:
			row_one[i].insert(tmp_items_hotbar[i])


	
#will need to get all items in current row and add to their position
				
