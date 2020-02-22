extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var nodeNum = 1
func _on_string_button_up():
	if get_parent().graph[1]['turned'] == true:
		get_parent().graph[1]['turned'] = false
	else:
		get_parent().graph[1]['turned'] = true
