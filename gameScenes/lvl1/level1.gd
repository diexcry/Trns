extends Node2D

var graph
func setGraph():
	graph = [
		{
			'type':'station',
			'forward':get_node("railwayRoute1/Path"),
			'nextNode': 1,
			'prevNode': null,
			'backward':null,
			'x': 0,
			'y': 0,
		},
		{
			'type':'station',
			'forward':get_node("railwayRoute2/Path"),
			'backward':get_node("railwayRoute1/Path"),
			'nextNode': 2,
			'prevNode': 0,
			'x': 0,
			'y': 0,
		},
		{
			'type':'station',
			'forward':null,
			'backward':get_node("railwayRoute2/Path"),
			'nextNode': null,
			'prevNode': 1,
			'x': 0,
			'y': 0,
		}
	]
func set_train(node_index):
	var train = preload("res://objects/train/train.tscn").instance()
	graph[node_index]['forward'].add_child(train)
	train.next_node = graph[node_index]
	train.prev_node = null
	train.position.x = graph[node_index]['x']
	train.position.y = graph[node_index]['y']
	train.meInstance = train
	
# Called when the node enters the scene tree for the first time.
func _ready():
	setGraph()
	set_train(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
