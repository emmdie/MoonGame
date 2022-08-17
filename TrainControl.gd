extends Node2D

signal TrainCart_weapon_shot_mouse

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

func _ready():
	cart2.setEnabled(false)
	cart3.setEnabled(false)
	cart4.setEnabled(false)
	cart5.setEnabled(false)
	cart1.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))


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
