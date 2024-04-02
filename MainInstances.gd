extends Node

#stores the main instances of players and stuff we need
var player : Player = null
var world : World = null
var level : Level = null
var itemBox: internalLine = null
var inventory : Inventory = preload("res://Scripts/playerInventory.tres")
var selectedSlot: int = -1
var gridCursor : GridCursor = null


func mouseVisible():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	MainInstances.gridCursor.visible = true
	gridCursor.active = true
	
func mouseInvisible():
	MainInstances.gridCursor.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	gridCursor.active =  false
	
