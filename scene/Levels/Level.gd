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
onready var trainControl = get_node("Moon/TrainControl")

const upgradeScene = preload("res://scene/UI/UpgradeScreen.tscn")

export(PackedScene) var mouse_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	randomize()
	$GravityField.set_gravity_center($Moon.position)
	$ZeppelinControll.set("target_position", $ZeppelinControll.position - $Moon.position)
	beginningSequence()
	var t = Timer.new()
	t.set_wait_time(10)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	ratAppearSequence()
	

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
	$Music.stop()
	$GameOverSound.play()
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
		$MoonHit.play()



func _on_TrainControl_TrainCart_weapon_shot_mouse():
	score += 1
	update_score()

func update_score():
	$UI/ScoreLabel.text = str(score)
	checkScoreForThreshhold(score)


func _on_TrainControl_train_damaged():
	$RatHittingTrain.play()
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
	textbox.queue_text("Try moving it a bit with W/S or arrow buttons a few times")
	updateCartLabels()
	#mouseTimer.paused = true
	#zeppelinTimer.paused = true
	
func ratAppearSequence():
	textbox.queue_text("Oh no, a huge mischief of mice is approaching")
	textbox.queue_text("Guess you gauda learn on the job")
	textbox.queue_text("You ought to stop them! I Swiss you best of luck intern")
	textbox.queue_text("Shoot with your mouse. I'll try to get some upgrades ASAP")
	mouseTimer.paused = false
	mouseTimer.wait_time = 6
	
func score14Sequence():
	textbox.queue_text("Wow, doing great out there!")
	textbox.queue_text("Gouda job intern, you get to upgrade one of the carts")
	textbox.queue_text("For now, might be best to upgrade your cart 1")	
	textbox.queue_text("Right now you have the shooter")	
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	upgradeScreen()
	updateCartLabels()
	mouseTimer.wait_time = 5.5
	
func score23Sequence():
	textbox.queue_text("Just got corporate to give you another cart!")
	trainControl.cart2.setEnabled(true)
	updateCartLabels()
	
func score27Sequence():
	textbox.queue_text("Damnit intern, we have spotted zeppelins!")
	textbox.queue_text("Take an extra upgrade to fend them off!")
	zeppelinTimer.paused = false
	zeppelinTimer.wait_time = 10
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	upgradeScreen()
	updateCartLabels()
	
func score40Sequence():
	mouseTimer.wait_time=4.5
	zeppelinTimer.wait_time = 8
	textbox.queue_text("Doin great, working on getting upgrades")
	var t = Timer.new()
	t.set_wait_time(10)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	upgradeScreen()
	updateCartLabels()
	
func score50Sequence():
	trainControl.cart3.setEnabled(true)
	textbox.queue_text("Corporate got you another cart")
	textbox.queue_text("Even threw in an upgrade")
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	upgradeScreen()
	updateCartLabels()
	zeppelinTimer.wait_time = 7
	
func score70Sequence():
	mouseTimer.wait_time = 4
	zeppelinTimer.wait_time = 5
	trainControl.cart4.setEnabled(true)
	updateCartLabels()
	textbox.queue_text("Nice and cheesy, you have collected 70 points!")
	
func score90Sequence():
	textbox.queue_text("By the way, I'm allergic to lactose")
	textbox.queue_text("So I'll leave you here")
	textbox.queue_text("But I will keep the upgrades comming!")

	
	

func updateCartLabels():
	var array = $UI/CartsUI.getArrayOfCarts()
	$Moon/TrainControl.updateAmmoRelations(array)

func checkScoreForThreshhold(score):
	upgradeScreen()
	if (score == 14):
		score14Sequence()
	if (score == 23):
		score23Sequence()
	if (score == 27):
		score27Sequence()
	if(score==40):
		score40Sequence()
	if(score==50):
		score50Sequence()
	if(score ==70):
		score70Sequence()
	if (score >=100 &&(score%20==1)):
		upgradeScreen()
		updateCartLabels()

func upgradeScreen():
	var upgradeInstance = upgradeScene.instance()
	upgradeInstance.connect("upgrade", self, "applyUpgrade")
	add_child(upgradeInstance)

func applyUpgrade(cart, upgrade):
	trainControl.applyUpgrade(cart, upgrade)
	updateCartLabels()
