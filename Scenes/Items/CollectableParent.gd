extends Area2D

@export var itemRes : InventoryItem
#so that we can tie it to its resource

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()
