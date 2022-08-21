extends Node

var max_moon_health = 1000
var moon_health 
var train_health
var max_train_health = 100
var dmg_to_train = 10
var score 
onready var textbox = $Textbox
onready var mouseTimer = $MouseTimer
onready var zeppelinTimer = get_node("ZeppelinControll/SpawnTimer")

export(PackedScene) var mouse_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	randomize()
	$GravityField.set_gravity_center($Moon.position)
	$ZeppelinControll.set("target_position", $ZeppelinControll.position - $Moon.position)
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
	checkScoreForThreshhold(score)


func _on_TrainControl_train_damaged():
	if train_health == 0:
		game_over()
	else:
		train_health -= dmg_to_train
		$UI/TrainHealthBar.value = train_health
		
func _on_GameOverScreen_restart():
	get_tree().change_scene("res://scene/UI/MainMenu.tscn")

func beginningSequence():
	textbox.queue_text("Welcome to your first day, intern! You are the cheesen one!")
	textbox.queue_text("Our job is to remote control the robot train cheesepiercer")
	textbox.queue_text("It's humanities strongest weapon against the space mice")
	textbox.queue_text("Imagine a life without the moon... No more tides")
	textbox.queue_text("Try moving it a bit with W/S or the arrow buttons")
	updateCartLabels()
	mouseTimer.paused = true
	zeppelinTimer.paused = true
	


func updateCartLabels():
	var array = $UI/CartsUI.getArrayOfCarts()
	$Moon/TrainControl.updateAmmoRelations(array)

func checkScoreForThreshhold(score):
	if (score > 14):
		pass
