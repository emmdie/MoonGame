extends Node2D
	
var gear = 0
var targetSpeed = 0
var currentSpeed =0
onready var cart1 = $RotationalCenter/TrainCart1; onready var cart2 = $RotationalCenter/TrainCart2; onready var cart3 = $RotationalCenter/TrainCart3; onready var cart4 = $RotationalCenter/TrainCart4; onready var cart5 = $RotationalCenter/TrainCart5;  

func _process(delta):
	updateCurrentSpeed(delta)
	$RotationalCenter.rotation += currentSpeed * delta

func _ready():
	cart2.setEnabled(false)
	cart3.setEnabled(false)
	cart4.setEnabled(false)
	cart5.setEnabled(false)
	cart1.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	changeGear(1)
	changeGear(1)

#takes -1 or 1 as parameter
func changeGear(amount):
	if!((gear == -2) && (amount == -1 )||(gear ==2)&&(amount ==1)):
		gear += amount
		targetSpeed += amount*0.5

func updateCurrentSpeed(delta):
	if(currentSpeed<targetSpeed):
		currentSpeed += targetSpeed*0.3*delta
	if(currentSpeed>targetSpeed):
		currentSpeed -= targetSpeed*0.3*delta

