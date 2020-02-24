extends Control

var Train = preload("res://gameScenes/lvl1/level1.gd").new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var COLOR = null
func get_speed_instance(color):
	if color == COLOR:
		return $"SpeedScroll"
func _on_Button_pressed() :
	$Messages/Window/.visible = !$Messages/Window/.visible




