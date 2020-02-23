extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func get_speed(color):
	if color == $"../".COLOR:
		return value
	else:
		return 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
