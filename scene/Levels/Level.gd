extends Node

export(PackedScene) var mouse_scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func new_game():
	

func game_over():
	$MouseTimer.stop

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
