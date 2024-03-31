extends StaticBody2D
@onready var animation_player = $AnimationPlayer
@onready var cut_down = $CutDown
@onready var tree_cut = $CutDown/TreeCut
@onready var right_cast = $RightCast
@onready var left_cast = $LeftCast

var currstage = 0
var totalHits = 4
var canChop = false
var dead = false
var isGrown = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#print("3")
	#dead = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debugGrow"):
		#print("Grow")
	
		currstage +=1
		#print(currstage)
		if currstage < 5:
			animateStage(currstage)
		else:
			currstage = -1
	#if canChop and Input.is_action_just_pressed("debugChop"):
		#on_chop()

func get_directions():
	if left_cast.is_colliding():
		return -1
	if right_cast.is_colliding():
		return 1
	else: return 0

	
func animateStage(currStage):
	match currStage:
		0: animation_player.play("seed")
		1: animation_player.play("Stage1")
		2: animation_player.play("Stage2")
		3: animation_player.play("Stage3")
		4: 
			isGrown = true
			animation_player.play("BigTree") 
			cut_down.body_entered.connect(_on_cut_down_body_entered)
			cut_down.body_exited.connect(_on_cut_down_body_exited)

func on_chop():
	#print("we want to chop!")
	if !dead and isGrown:
#print("chopped down!")
		totalHits -= 1
		var dir = get_directions()
		if totalHits == 0:
			if dir == -1:
				animation_player.play("CutDownLeft")
			else:
				animation_player.play("CutDownRight")
			#
				dead = true
				#become_stump()
		else:
			if dir == -1:
				animation_player.play("axeHitLeft")
			else:
				animation_player.play("axeHitRight")
				
		
func become_stump():
	animation_player.play("Stump")
	totalHits = 4
	canChop = false


func _on_cut_down_body_entered(body):
	if !dead:
		canChop = true





func _on_cut_down_body_exited(body):
	canChop = false
