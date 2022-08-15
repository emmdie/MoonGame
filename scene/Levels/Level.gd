extends Node

export(PackedScene) var mouse_scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	randomize()
	$GravityField.set_gravity_center($Moon.position)
	
	
#starts a level
func new_game():
	$MouseTimer.start()
	#$Train.start($Moon/TrainStartLocation.position)

#this is called when the player loses in a level
func game_over():
	$MouseTimer.stop

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MouseTimer_timeout():
	print("mouseTimerTimeout")
	var mouse = mouse_scene.instance()
	
	# Choose a random location on Path2D.
	var mouse_spawn_location = get_node("MousePath/MouseSpawnLocation")
	mouse_spawn_location.offset = randi()
	
	mouse.position = mouse_spawn_location.position
	
	mouse.rotation = ($Moon.position - mouse.position).rotated(deg2rad(90)).angle()
	
	var velocity = Vector2(0.0, 0.0)
	mouse.linear_velocity = velocity.rotated(mouse.rotation)
	
	add_child(mouse)
	print("added mouse to scene")
	



