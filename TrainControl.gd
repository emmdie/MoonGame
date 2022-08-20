extends Node2D

signal TrainCart_weapon_shot_mouse
signal train_damaged

var gear = 0
var currentSpeed = 0
onready var cart1 = $RotationalCenter/TrainCart1; onready var cart2 = $RotationalCenter/TrainCart2; onready var cart3 = $RotationalCenter/TrainCart3; onready var cart4 = $RotationalCenter/TrainCart4; onready var cart5 = $RotationalCenter/TrainCart5; 
signal gearChanged(gear) 

func _process(delta):
	currentSpeed = updateCurrentSpeed(delta)
	$RotationalCenter.rotation += currentSpeed * delta
	if (Input.is_action_just_pressed("speed_up")):
		gearUp()
	if(Input.is_action_just_pressed("speed_down")):
		gearDown()
		
	if(Input.is_action_just_pressed("select_cart1")):
		deselectAllCarts()
		cart1.select(true)
	if(Input.is_action_just_pressed("select_cart2")):
		deselectAllCarts()
		cart2.select(true)
	if(Input.is_action_just_pressed("select_cart3")):
		deselectAllCarts()
		cart3.select(true)
	if(Input.is_action_just_pressed("select_cart4")):
		deselectAllCarts()
		cart4.select(true)
	if(Input.is_action_just_pressed("select_cart5")):
		deselectAllCarts()
		cart5.select(true)
		
func _ready():
	cart1.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart2.setTurret(load("res://scene/Train/Turrets/Shooter/rocketlauncherT1.tscn"))
	cart3.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart4.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart5.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart1.setEnabled(true)
	cart2.setEnabled(true)
	cart3.setEnabled(true)
	cart4.setEnabled(false)
	cart5.setEnabled(false)
	deselectAllCarts()
	cart1.select(true)


#takes -1 or 1 as parameter
func gearDown():
	if(!(gear==-3)):
		gear = gear -1
		emit_signal("gearChanged", gear)
func gearUp():
	if(!(gear==3)):
		gear=gear+1
	emit_signal("gearChanged", gear)
	
		
func updateCurrentSpeed(delta):
	var targetSpeed = gear*0.25
	if(targetSpeed == currentSpeed):
		return currentSpeed
	if(targetSpeed > currentSpeed):
		return (currentSpeed + 2*(targetSpeed-currentSpeed)*delta)
	else:
		return (currentSpeed-2*delta*(currentSpeed-targetSpeed))

func _on_TrainCart_weapon_hit_mouse():
	emit_signal("TrainCart_weapon_shot_mouse")

func _on_TrainCart_cart_damaged():
	emit_signal("train_damaged")


func _on_locomotive_damaged():
	emit_signal("train_damaged")
	
func deselectAllCarts():
	cart1.select(false)
	cart2.select(false)
	cart3.select(false)
	cart4.select(false)
	cart5.select(false)
