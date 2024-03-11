extends Resource


class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item : InventoryItem):
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
	var itemSlots = slots.filter(func(slot):return slot.item == item && slot.amount < slot.item.maxPerSlot)
	if !itemSlots.is_empty():
		itemSlots[0].amount +=1
	else:
		var emptySlots = slots.filter(func(slot):return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
			
	updated.emit()

func removeSlot(inventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return #not there
	
	slots[index] = InventorySlot.new()
	updated.emit()
	
func insertSlot(index, inventorySlot):
	#var oldIndex = slots.find(inventorySlot)
	#removeItemAtIndex(oldIndex)
	slots[index] = inventorySlot
	updated.emit()
