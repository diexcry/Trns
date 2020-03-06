extends Control

var Train = preload("res://gameScenes/lvl1/level1.gd").new()
var color = null
func get_speed_instance():
	return $"SpeedScroll"
func set_speed_zero():
	$"SpeedScroll".visible = true
	$"SpeedScroll".value = 0;
func get_speed_value(tr_color):
	if color == tr_color:
		return $"SpeedScroll".value
	else:
		return 0
func _ready():
	$"SpeedScroll".visible = false

func _on_Button_pressed() :
	$Messages/Window/.visible = !$Messages/Window/.visible




