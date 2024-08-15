extends Control

@onready var day_label_background = %DayLabelBackground
@onready var day_label = %DayLabel

@onready var time_label_background = %TimeLabelBackground
@onready var time_label = %TimeLabel

@onready var arrow = %Arrow


#set daytime
func set_daytime(day, hour, minute):
	day_label.text = "Day" + str(day+1)
	day_label_background.text = day_label.text
	
	time_label.text = _military_normal(hour)+ ":" + _minute(minute) + " " + _am_pm(hour)
	time_label_background.text = time_label.text
	
	if hour < 6:
		arrow.rotation_degrees = _remap_rangef(hour, 0, 2, 3.5, 96.7)
	elif hour <=12:
		arrow.rotation_degrees = _remap_rangef(hour, 6, 12, -84.4, 3.5)
	else:
		
		arrow.rotation_degrees = _remap_rangef(hour, 12, 26, 3.5, 96.7)
		
			
		
func _military_normal(hour):
	if hour == 0:
		return str(12)
	if hour > 12:
		return str(hour - 12)
	return str(hour)
	
func _minute(minute):
	if minute < 10:
		return "0" + str(minute)
	return str(minute)
	
	
func _am_pm(hour):
	if hour < 12:
		return "am"
	else:
		return "pm"

func _remap_rangef(input, minInput, maxInput, minOutput, maxOutput):
	return float(input - minInput)/ float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
