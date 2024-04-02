extends Resource

class_name InventoryItem

@export var name = ""
@export_multiline var description = ""
@export var texture: Texture2D
@export var maxPerSlot :int
@export var isPlant : bool
@export var canPlace : bool
@export var canPlant : bool
@export var needsSoil : bool
#probably populated in the item class
#@export var beenWatered : bool
@export var isTool : bool

@export var plantPath : PackedScene
