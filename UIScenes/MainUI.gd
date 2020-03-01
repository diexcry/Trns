extends Control

var Train = preload("res://gameScenes/lvl1/level1.gd").new()

func get_speed_instance():
	return $"SpeedScroll"




func _on_Button_pressed() :
	$Messages/Window/.visible = !$Messages/Window/.visible




