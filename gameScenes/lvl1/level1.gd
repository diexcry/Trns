extends Node2D

var graph
func setGraph():
	graph = [
		{
			'color':null,
			'type':'station',
			'forward':get_node("railwayRoute1/Path"),
			'nextNode': 1,
			'prevNode': null,
			'backward':null,
			'x': 0,
			'y': 0,
		},
		{
			'type':'string',
			'color':null,
			'buttonNode':get_node("string"),
			'forward':get_node("railwayRoute2/Path"),
			'turn':get_node("railwayRoute3/Path"),
			'turned':false,
			'backward':get_node("railwayRoute1/Path"),
			'nextNode': 2,
			'prevNode': 0,
			'turnNode': 3,
			'x': 0,
			'y': 0,
		},
		{
			'type':'station',
			'color':null,
			'forward':get_node("railwayRoute4/Path"),
			'backward':get_node("railwayRoute2/Path"),
			'nextNode': 4,
			'prevNode': 1,
			'x': 0,
			'y': 0,
		},
		{
			'type':'station',
			'color':'blue',
			'forward':null,
			'backward':get_node("railwayRoute3/Path"),
			'nextNode': null,
			'prevNode': 1,
			'x': 0,
			'y': 0,
		},
		{
			'type':'station',

			'color':'red',
			'forward':null,
			'backward':get_node("railwayRoute4/Path"),
			'nextNode': null,
			'prevNode': 2,
			'x': 0,
			'y': 0,
		}
	]
	
var trainList = []
func rmTrain(instns):
	trainList.remove(trainList.find(instns))
	if trainList.size() == 0:
		var gameOver = load("res://gameScenes/MainMenu/MainMenu.tscn").instance()
		get_parent().add_child(gameOver)
		queue_free()
		

func set_train(node_index,TRAIN_COLOR):
	var train = preload("res://objects/train/train.tscn").instance()
	graph[node_index]['forward'].add_child(train)
	train.next_node = graph[node_index]
	train.prev_node = null
	train.position.x = graph[node_index]['x']
	train.position.y = graph[node_index]['y']
	train.meInstance = train
	train.color = TRAIN_COLOR
	trainList.append(train)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	setGraph()
	set_train(0,'blue')
	set_train(1,'red')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
