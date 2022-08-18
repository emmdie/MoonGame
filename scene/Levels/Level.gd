extends Node

var moon_health 
var train_health
var score

export(PackedScene) var mouse_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	randomize()
	$GravityField.set_gravity_center($Moon.position)


#starts a level
func new_game():
	moon_health = 1000
	train_health = 100
	score = 0
	$MouseTimer.start()
	#$Train.start($Moon/TrainStartLocation.position)

#this is called when the player loses in a level
func game_over():
	$MouseTimer.stop()
	get_tree().call_group("mice", "queue_free")


func _on_MouseTimer_timeout():
	var mouse = mouse_scene.instance()
	
	# Choose a random location on Path2D.
	var mouse_spawn_location = get_node("MousePath/MouseSpawnLocation")
	mouse_spawn_location.offset = randi()


	mouse.position = mouse_spawn_location.position
	
	mouse.rotation = ($Moon.position - mouse.position).rotated(deg2rad(90)).angle()
	
	var velocity = Vector2(20.0, 0.0)
	mouse.linear_velocity = velocity.rotated(mouse.rotation)
	
	add_child(mouse)


func _on_Moon_mouse_hit():
	if moon_health <= 0:
		game_over()
	moon_health -= 10
	print("HP " + str(moon_health))


func _on_TrainControl_TrainCart_weapon_shot_mouse():
	score += 1
	update_score()

func update_score():
	$UI/ScoreLabel.text = str(score)


func _on_TrainControl_train_damaged():
	print(str(train_health))
	if (train_health <= 0):
		game_over()
	train_health -= 10
