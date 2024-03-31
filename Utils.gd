extends Node

func instantiate_scene_on_world(scene: PackedScene, position: Vector2):
	#get the root node
	var world = get_tree().current_scene
	#instantiat4 the desired type
	var instance = scene.instantiate()
	world.add_child.call_deferred(instance)
	instance.global_position = position
	return instance #so we can access if we stored it
	
func instantiate_scene_on_level(scene: PackedScene, position: Vector2):
	var world = get_tree().current_scene
	if not world is World: return
	var level = world.level
	var instance = scene.instantiate()
	level.add_child.call_deferred(instance)
	instance.global_position = position
	return instance
