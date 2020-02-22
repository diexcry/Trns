extends Control

func get_speed_instance():
	return $"SpeedScroll"


	


func _on_Button_pressed() :
	$Messages/Sprite.visible = !$Messages/Sprite.visible

