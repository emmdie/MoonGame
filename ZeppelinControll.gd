extends Node2D


var target_position

export(PackedScene) var zeppelin_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start():
	$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	var zeppellin = zeppelin_scene.instance()
	
	zeppellin.init(target_position)
	add_child(zeppellin)
