extends Control

func _ready():
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
# warning-ignore:return_value_discarded
	var game = load("res://gameScenes/lvl3/level3.tscn").instance()
	get_parent().add_child(game)
	queue_free()
