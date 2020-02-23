extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var speedBar = $"../MainUI".get_speed_instance()
var next_node
var prev_node
var meInstance
var SpeedBar
var color
# Called when the node enters the scene tree for the first time.
func _ready():
	SpeedBar = $"../../../MainUI".get_speed_instance(color)
	pass

func checkStation(node):
	if node['color'] != null:
		if node['color']  == color:
			$"../../..".rmTrain(meInstance)
			queue_free()

func getNextNode(node):
	if node['type'] == 'station':

		return $"../../..".graph[node['nextNode']]
	if node['type'] == 'string':
		if node['turned'] == true:
			return $"../../..".graph[node['turnNode']]
		else:
			return $"../../..".graph[node['nextNode']]
func getPrevNode(node):
	if node['type'] == 'station':
		return $"../../..".graph[node['prevNode']]
func setRailwayFollow(node):
	meInstance.get_parent().remove_child(meInstance)
	node.add_child(meInstance)

func reFollow(node,route):
	if route == 'back':
		setRailwayFollow(node['backward'])
	elif route == 'front':
		if node['type'] == 'station':
			setRailwayFollow(node['forward'])
		if node['type'] == 'string' and node['turned'] == false:
			setRailwayFollow(node['forward'])
		if node['type'] == 'string' and node['turned'] == true:
			setRailwayFollow(node['turn'])
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
var speed
var goesForward = true
func _process(delta):
	speed = SpeedBar.get_speed(color)
	get_parent().offset += speed
	if get_parent().get_unit_offset() == 1:
		if next_node != null:
			checkStation(next_node)
		if next_node != null && next_node['forward'] != null:
			reFollow(next_node,'front')
			next_node = getNextNode(next_node)
			prev_node = getPrevNode(next_node)
	elif get_parent().get_unit_offset() == 0:
		if prev_node != null:
			checkStation(prev_node)
		if prev_node != null && prev_node['backward'] != null:
			reFollow(prev_node,'back')
			next_node = getPrevNode(next_node)
			prev_node = getPrevNode(next_node)
			
			



func _on_Button_button_down():
	$"../../../MainUI".COLOR = color
