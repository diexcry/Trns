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

func get_strings_rend(i):
	if i['type'] == 'string':
		if graph[i['nextNode']]['nextNode'] == null:
			return i['nextNode']
		else:
			return i['turnNode']
	else:
		return i['nextNode']

func get_new_node():
	while (true):
		var ind = getRandomNumber(0,len(graph)-1)
		var i = graph[ind]
		if i['arrival']:
			i['arrival'] = false
			if i['rightEnd']:
				graph[get_strings_rend(i)]['dest'] = false
			else:
				i['dest'] = false
			print("tr:")
			print(ind)
			return ind
			
func get_dest_node(col):
	var x = 0
	while (x < 10000):
		var ind = getRandomNumber(0,len(graph)-1)
		var i = graph[ind]
		if i['dest'] == true:
			if !i['rightEnd']:
				i['arrival'] = false
			i['dest'] = false
			print("dst:")
			print(ind)
			i['me'].get_node("Sprite").set_self_modulate(col['hex'])
			return ind
		x += 1
	print("No dests")

func spawnTrains(count):
	for i in range(count):
		var color = trainColors[getRandomNumber(0,len(trainColors)-1)]
		if color['used']:
			continue
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
			'arrival': true,
			'dest': false,
			'rightEnd': true,
			'color':null,
			'me': get_node("string"),
			'buttonNode':get_node("string"),
			'forward':get_node("railwayRoute2/"),
			'turn':get_node("railwayRoute3/"),
			'turned':false,
			'backward':get_node("railwayRoute1/"),
			'nextNode': 2,
			'prevNode': 0,
			'turnNode': 3,
		},
		{
			'type':'station',
			'arrival': true,
			'dest': true,
			'rightEnd': true,
			'me': get_node("station2"),
			'color':null,
			'forward':get_node("railwayRoute4/"),
			'backward':get_node("railwayRoute2/"),
			'nextNode': 4,
			'prevNode': 1,
		},
		{
			'type':'station',
			'color':null,
			'dest': true,
			'rightEnd': false,
			'me': get_node("station4"),
			'arrival': false,
			'forward':null,
			'backward':get_node("railwayRoute3/"),
			'nextNode': null,
			'prevNode': 1,
		},
		{
			'type':'station',
			'arrival': false,
			'rightEnd': false,
			'dest': true,
			'me': get_node("station5"),
			'color':null,
			'forward':null, #? null
			'backward':get_node("railwayRoute4/"),
			'nextNode': null,
			'prevNode': 2,
		}
	]


	
var trainList = []
func rmTrain(instns):
	trainList.remove(trainList.find(instns))
	if trainList.size() == 0:
		var gameOver = load("res://gameScenes/lvl2/level2.tscn").instance()
		get_parent().add_child(gameOver)
		queue_free()
		
func get_strings_curve(i):
	if i['type'] == 'string':
		if graph[i['nextNode']]['nextNode'] == null:
			return i['forward']
		else:
			return i['turn']
	else:
		return i['forward']
		
func set_train(node_index,clr):
	var train = preload("res://objects/train/train.tscn").instance()
	if graph[node_index]['rightEnd']:
		get_strings_curve(graph[node_index]).add_child(train)
		train.set_unit_offset(1)
		train.forward = false
	else:
		get_strings_curve(graph[node_index]).add_child(train)
		train.set_unit_offset(0)
		train.forward = true
	train.next_node = graph[get_strings_rend(graph[node_index])]
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
