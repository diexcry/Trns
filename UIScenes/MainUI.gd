extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var COLOR = null
func get_speed_instance(color):
	if color == COLOR:
		return $"SpeedScroll"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
