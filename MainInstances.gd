extends Node

#stores the main instances of players and stuff we need
var player : Player = null
var world : World = null
var level : Level = null
var itemBox: internalLine = null
var inventory : Inventory = preload("res://Scripts/playerInventory.tres")
var selectedSlot: int = -1
