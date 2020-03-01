extends Control

var Train = preload("res://gameScenes/lvl1/level1.gd").new()

func get_speed_instance():
	return $"SpeedScroll"




func _on_icon_pressed() :
	$Messages/Window/.visible = !$Messages/Window/.visible






func _on_spawn_pressed():
	var train = preload("res://objects/train/train.tscn").instance()
	train.meInstance = train
	train.color = "blue"
