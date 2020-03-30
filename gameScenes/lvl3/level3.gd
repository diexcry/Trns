extends Node2D


#---------------------------train-spawners----------------------
var trainColors = [
	{
		'color': 'blue',
		'used': false,
		'hex': '0052ff',
	},
	{
		'color': 'red',
		'used': false,
		'hex': 'f61313',
	},
	{
		'color': 'green',
		'used': false,
		'hex': '16ac05',
	},
	{
		'color': 'yellow',
		'used': false,
		'hex': 'd2e20e',
	},
	{
		'color': 'orange',
		'used': false,
		'hex': 'dd6b07',
	},
]

func getRandomNumber(from,to):
	randomize()
	return from+randi()%(to-from+1) 

func get_new_node():
	while (true):
		print('get arrival node')
		var ind = getRandomNumber(0,len(graph)-1)
		var i = graph[ind]
		if i['type']  == 'station' and i['arrival']:
			i['arrival'] = false
			if i['rightEnd']:
				graph[i['nextNode']]['dest'] = false
			i['dest'] = false
			print("tr:")
			print(ind)
			return ind
			
func get_dest_node(col):
	while (true):
		print('get dest node')
		var ind = getRandomNumber(0,len(graph)-1)
		var i = graph[ind]
		if i['type']  == 'station' and \
		(i['nextNode'] == null or i['prevNode'] == null) \
		and i['dest'] == true:
			i['arrival'] = false
			i['dest'] = false
			print("dst:")
			print(ind)
			i['me'].get_node("Sprite").set_self_modulate(col['hex'])
			return ind

func spawnTrains(count):
	for i in range(count):
		print('i:'+str(i))
		var color = trainColors[getRandomNumber(0,len(trainColors)-1)]
		while !color['used']:
			color = trainColors[getRandomNumber(0,len(trainColors)-1)]
		var ndindx = get_new_node()
		set_train(ndindx,color)
		var indofget = get_dest_node(color)
		graph[indofget]['color'] = color['color']
		color['used'] = true
	

var graph
func setGraph():
	graph = [
		{
			'color':null,
			'type':'station',
			'arrival': true,
			'dest': true,
			'rightEnd': false,
			'forward':get_node("railwayRoute1/"),
			'me': get_node("station1"),
			'nextNode': 1,
			'prevNode': null,
			'backward':null,
		},
		{
			'type':'string',
			'color':null,
			'arrival': true,
			'rightEnd': true,
			'dest': false,
			'me': get_node("string1"),
			'buttonNode':get_node("string1"),
			'forward':get_node("railwayRoute3/"),
			'turn':get_node("railwayRoute2/"),
			'turned':false,
			'backward':get_node("railwayRoute1/"),
			'nextNode': 2,
			'prevNode': 0,
			'turnNode': 4,
		},
		{
			'type':'string',
			'arrival': true,
			'rightEnd': true,
			'dest': false,
			'color':null,
			'me': get_node("string2"),
			'buttonNode':get_node("string2"),
			'forward':get_node("railwayRoute5/"),
			'turn':get_node("railwayRoute4/"),
			'turned':false,
			'backward':get_node("railwayRoute3/"),
			'nextNode': 3,
			'prevNode': 1,
			'turnNode': 5,
		},
		{
			'type':'string',
			'color':null,
			'arrival': true,
			'rightEnd': true,
			'dest': false,
			'me': get_node("string3"),
			'buttonNode':get_node("string3"),
			'forward':get_node("railwayRoute7/"),
			'turn':get_node("railwayRoute6/"),
			'turned':false,
			'backward':get_node("railwayRoute5/"),
			'nextNode': 7,
			'prevNode': 2,
			'turnNode': 6,
		},
		{
			'type':'station',
			'arrival': false,
			'rightEnd': false,
			'dest': true,
			'me': get_node("station2"),
			'color':null,
			'forward':null,
			'backward':get_node("railwayRoute2/"),
			'nextNode': null,
			'prevNode': 1,
		},
		{
			'type':'station',
			'color':null,
			'dest': true,
			'me': get_node("station3"),
			'arrival': false,
			'rightEnd': false,
			'forward':null,
			'backward':get_node("railwayRoute4/"),
			'nextNode': null,
			'prevNode': 2,
		},
		{
			'type':'station',
			'arrival': false,
			'rightEnd': false,
			'dest': true,
			'me': get_node("station4"),
			'color':null,
			'forward':null, #? null
			'backward':get_node("railwayRoute6/"),
			'nextNode': null,
			'prevNode': 3,
		},
		{
			'type':'station',
			'arrival': false,
			'dest': true,
			'rightEnd': false,
			'me': get_node("station5"),
			'color':null,
			'forward':null, #? null
			'backward':get_node("railwayRoute7/"),
			'nextNode': null,
			'prevNode': 3,
		}
	]


	
var trainList = []
func rmTrain(instns):
	trainList.remove(trainList.find(instns))
	if trainList.size() == 0:
		var gameOver = load("res://gameScenes/MainMenu/MainMenu.tscn").instance()
		get_parent().add_child(gameOver)
		queue_free()
		
func set_train(node_index,clr):
	var train = preload("res://objects/train/train.tscn").instance()
	if graph[node_index]['rightEnd']:
		graph[node_index]['forward'].add_child(train)
		train.set_unit_offset(1)
		train.forward = false
	else:
		graph[node_index]['forward'].add_child(train)
		train.set_unit_offset(0)
		train.forward = true
	train.next_node = graph[graph[node_index]['nextNode']]
	train.prev_node = graph[node_index]
	train.position.x = 0
	train.position.y = 0
	train.meInstance = train
	train.color = clr['color']
	train.get_node("Sprite").set_self_modulate(clr['hex'])
	trainList.append(train)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	setGraph()
	spawnTrains(2)


# Called every frame. 'delta'is the elapsed time since the previous frame.
#func _process(delta):
#	pass



