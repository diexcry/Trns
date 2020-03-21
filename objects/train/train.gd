extends PathFollow2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var speedBar = $"../MainUI".get_speed_instance()
var next_node
var prev_node
var meInstance
var SpeedBar
var forward
var color

func chdir():
	if forward:
		forward = false
	else:
		forward = true
# Called when the node enters the scene tree for the first time.
func _ready():
	SpeedBar = $"../../MainUI" #.instance()
	pass

func checkStation(node):
	if node != null && node['color'] != null:
		if node['color']  == color:
			$"../..".rmTrain(meInstance)
			queue_free()

func getNextNode(node):
	if node['type'] == 'station':
		return $"../..".graph[node['nextNode']]
	if node['type'] == 'string':
		if node['turned'] == true:
			return $"../..".graph[node['turnNode']]
		else:
			return $"../..".graph[node['nextNode']]
func getPrevNode(node):
	if node['type'] == 'station' or node['type'] == 'string':
			return $"../..".graph[node['prevNode']]
func setRailwayFollow(node):
	meInstance.get_parent().remove_child(meInstance)
	node.add_child(meInstance)

func reFollow(node):
	if !forward:
		setRailwayFollow(node['backward'])
	elif forward:
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
	speed = SpeedBar.get_speed_value(color)
	if forward:
		offset += speed
	else:
		offset -= speed
	if get_unit_offset() == 1:
		if next_node != null && next_node['forward'] != null:
			reFollow(next_node)
			set_unit_offset(0)
			next_node = getNextNode(next_node)
			prev_node = getPrevNode(next_node)
		elif next_node == null or next_node['forward'] == null:
			forward = false
			$"../../MainUI".set_speed_zero()
			checkStation(next_node)
	elif get_unit_offset() == 0:
		if prev_node != null && prev_node['backward'] != null:
			reFollow(prev_node)
			set_unit_offset(1)
			next_node = getPrevNode(next_node)
			prev_node = getPrevNode(next_node)
		elif prev_node == null or prev_node['backward'] == null:
			forward = true
			$"../../MainUI".set_speed_zero()
			checkStation(prev_node)
			
			

	


func _on_Button_button_down():
	var t = $"../../MainUI"
	$"../../MainUI/SpeedScroll".visible = true
	$"../../MainUI/NinePatchRect".visible = true
	t.set_speed_zero()
	t.color = color



func _on_Area2D_area_entered(area):
	var alarm = preload("res://objects/jam.tscn").instance()
	get_parent().get_parent().add_child(alarm)
	alarm.transform.x = transform.x
	alarm.transform.y = transform.y
	$"../..".rmTrain(meInstance)
	$"../..".rmTrain(area.get_parent())
	area.get_parent().queue_free()
	queue_free()
