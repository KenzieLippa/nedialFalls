extends HBoxContainer

@onready var inventory = preload("res://Scripts/playerInventory.tres")
@onready var slots : Array = get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	update() # Replace with function body.
	inventory.updated.connect(update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	for i in range(slots.size()):
		var inventory_slot = inventory.slots[i]
		slots[i].update_to_slot(inventory_slot)
