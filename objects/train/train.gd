extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var speedBar = $"../MainUI".get_speed_instance()
var next_node
var prev_node
var meInstance
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func getNextNode(node):
	if node['type'] == 'station':
		return $"../../..".graph[node['nextNode']]
		
func getPrevNode(node):
	if node['type'] == 'station':
		return $"../../..".graph[node['prevNode']]
func setRailwayFollow(node):
	meInstance.get_parent().remove_child(meInstance)
	node['forward'].add_child(meInstance)
var speed = 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().offset += speed
	if get_parent().get_unit_offset() == 1:
		next_node = getNextNode(next_node)
		prev_node = getPrevNode(next_node)
		setRailwayFollow(next_node)

	
