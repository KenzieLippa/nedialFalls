extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day, hour, minute)

@export var gradient: GradientTexture1D
@export var INGAME_SPEED = 1.0
@export var INITIAL_HOUR = 6:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

var time = 0.0
var past_minute = -1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	_recalculate_time() #make sure to call

func _recalculate_time():
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minutes = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if past_minute != minutes:
		past_minute = minutes
		if minutes %10 == 0:
			time_tick.emit(day, hour, minutes)
	
#signal up and call down
