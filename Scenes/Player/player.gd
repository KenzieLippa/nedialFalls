extends CharacterBody2D

const SPEED := 700.0
@onready var animation_player = $AnimationPlayer
@onready var tree_detector = $treeDetector

@export var inventory: Inventory
enum STATE {
	idle,
	walking
}

func _ready():
	pass
	
func _physics_process(delta):
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()
	if is_moving():
		animate_walk()
	else:
		animate_idle()
	if Input.is_action_just_pressed("debugChop"):
		chop()
func is_moving():
	#tell whether we walking or not
	return velocity != Vector2.ZERO
	
func animate_walk():
	#convert to an angle to find direction and then pick a direction to animate
	#will have to snap to 45 to avoid ranges
	var angle = velocity.angle()
	#now convert to degrees
	var angle_in_degree = rad_to_deg(angle)
	#now round to 45
	var rounded_angle = int(round(angle_in_degree/45) * 45)
	match rounded_angle:
		-135, 180, 135: animation_player.play("walkLeft")
		0,-45,45: animation_player.play("walkRight")
		-90:animation_player.play("walkUp")
		90:animation_player.play("walkDown")
		
func animate_idle():
	#check to see if not moving check to see which animation we are playing and match it
	match animation_player.current_animation:
		"walkLeft": animation_player.play("idleLeft")
		"walkRight": animation_player.play("idleRight")
		"walkUp": animation_player.play("idleUp")
		"walkDown": animation_player.play("idleDown")
func chop():
	var trees_in_range = tree_detector.get_overlapping_bodies()
	for area in trees_in_range:
		if area.is_in_group("tree"):
			print("tree found!")
			area.on_chop()



func _on_pickups_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
