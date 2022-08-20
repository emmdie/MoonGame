extends Node

var max_moon_health = 1000
var moon_health 
var train_health
var max_train_health = 100
var dmg_to_train = 10
var score 
onready var textbox = $Textbox

export(PackedScene) var mouse_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	randomize()
	$GravityField.set_gravity_center($Moon.position)
	beginningSequence()

#starts the 
func new_game():
	$GameOverScreen.hide()
	$UI/ScoreLabel.show()
	
	moon_health = max_moon_health
	
	$UI/MoonHealthBar.max_value = max_moon_health
	$UI/MoonHealthBar.value = moon_health
	
	train_health = max_train_health
	$UI/TrainHealthBar.max_value = max_train_health
	$UI/TrainHealthBar.value = train_health
	updateCartLabels()


	score = 0
	$MouseTimer.start()
	#$Train.start($Moon/TrainStartLocation.position)

#this is called when the player loses in a level
func game_over():
	$MouseTimer.stop()
	get_tree().call_group("mice", "queue_free")
	$GameOverScreen/GameOverScore.text = "Score: "+str(score)
	$GameOverScreen.show()
	$UI/ScoreLabel.hide()
	get_tree().paused = true


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
	else:
		moon_health -= 10
		$UI/MoonHealthBar.value = moon_health



func _on_TrainControl_TrainCart_weapon_shot_mouse():
	score += 1
	update_score()

func update_score():
	$UI/ScoreLabel.text = str(score)


func _on_TrainControl_train_damaged():
	if train_health == 0:
		game_over()
	else:
		train_health -= dmg_to_train
		$UI/TrainHealthBar.value = train_health
		
func _on_GameOverScreen_restart():
	get_tree().change_scene("res://scene/UI/MainMenu.tscn")

func beginningSequence():
	textbox.queue_text("1,2....3, Connection stable, Checks passed, train online")
	textbox.queue_text("Intern! You are the only thing standing between the moon and")
	textbox.queue_text("the space mice swarm")
	textbox.queue_text("Change gears with (w/up) and (s/down)")
	textbox.queue_text("Fire using your mouse, you better don't miss")
	textbox.queue_text("If either the train or moon dies, that's it")
	updateCartLabels()

func updateCartLabels():
	var array = $UI/CartsUI.getArrayOfCarts()
	$Moon/TrainControl.updateAmmoRelations(array)
