extends StaticBody2D
@onready var animation_player = $AnimationPlayer
@onready var cut_down = $CutDown
@onready var tree_cut = $CutDown/TreeCut

var currstage = 0
var totalHits = 4
var canChop = false


# Called when the node enters the scene tree for the first time.
func _ready():
	print("3")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debugGrow"):
		print("Grow")
	
		currstage +=1
		#print(currstage)
		if currstage < 5:
			animateStage(currstage)
		else:
			currstage = -1
	#if canChop and Input.is_action_just_pressed("debugChop"):
		#on_chop()



	
func animateStage(currStage):
	match currStage:
		0: animation_player.play("seed")
		1: animation_player.play("Stage1")
		2: animation_player.play("Stage2")
		3: animation_player.play("Stage3")
		4: 
			animation_player.play("BigTree") 
			cut_down.body_entered.connect(_on_cut_down_body_entered)
			cut_down.body_exited.connect(_on_cut_down_body_exited)

func on_chop():
	print("chopped down!")
	totalHits -= 1
	if totalHits == 0:
		animation_player.play("CutDown")
	else:
		animation_player.play("axeHit")
			
		
func become_stump():
	animation_player.play("Stump")
	totalHits = 4


func _on_cut_down_body_entered(body):
	canChop = true





func _on_cut_down_body_exited(body):
	canChop = false
