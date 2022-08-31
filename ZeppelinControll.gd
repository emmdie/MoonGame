extends Node2D

var distance = - 600.00


var target_position

export(PackedScene) var zeppelin_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func start():
	$SpawnTimer.start()



func _on_SpawnTimer_timeout():
	var zeppellin = zeppelin_scene.instance()
	var cartesian_position = Vector2(distance, 0.00)
	var polar_position = cartesian2polar(cartesian_position.x,cartesian_position.y)
	zeppellin.position = polar2cartesian(polar_position.x, rand_range(0.00, 2* PI))
	zeppellin.rotation = (target_position - zeppellin.position).angle()
	zeppellin.init(target_position)
	add_child(zeppellin)
	zeppellin.set_owner(get_owner()) 
	print("zeppellin " + zeppellin.get_name() + " added")
