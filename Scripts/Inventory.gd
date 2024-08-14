extends Resource


class_name Inventory

signal updated
const InventorySlot = preload("res://Scripts/InventorySlot.gd")
@export var slots: Array[InventorySlot]
#i dont think im using this currently
#@export var hotbarSlots: Array[InventorySlot]
var isSelected = false

func insert(item : InventoryItem, slotType):
	#garbage method
	#for slot in slots:
		##check if in slot
		#if slot.item == item:
			#if slot.amount < slot.item.maxPerSlot:
				#slot.amount +=1
				#updated.emit()
				#return 
			#else:
				#fill_empty(item)
				#print(slot.item.maxPerSlot)
				#updated.emit()
				#return
			#
	#fill_empty(item)
		#
#
#func fill_empty(item):	
	#for i in range(slots.size()):
		#if !slots[i].item:
			#slots[i].item = item
			##insert a new item if not here
			#slots[i].amount = 1
			#updated.emit()
			#return
	var itemSlots = slotType.filter(func(slot):return slot.item == item && slot.amount < slot.item.maxPerSlot)
	if !itemSlots.is_empty():
		itemSlots[0].amount +=1
	else:
		var emptySlots = slots.filter(func(slot):return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	print("updated")	
	updated.emit()

func removeSlot(inventorySlot, slotType):
	var index = slotType.find(inventorySlot)
	if index < 0: return #not there
	
	slotType[index] = InventorySlot.new()
	updated.emit()
	
func insertSlot(index, inventorySlot, slotType):
	#var oldIndex = slots.find(inventorySlot)
	#removeItemAtIndex(oldIndex)
	slotType[index] = inventorySlot
	updated.emit()


func swap_slots():
	pass
#might want to add in the possibility to swap the inventory row like stardew
