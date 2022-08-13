xtends KinematicBody2D

var gear
export var targetSpeedGear1 = 100
var currentSpeed



func _physics_process(delta):
	changeSpeed()
	
	
	
func _ready():
	var gear = 1
	var currentSpeed = 0
	
func changeSpeed():
	if(gear==1):
		if(currentSpeed < targetSpeedGear1):
			currentSpeed += targetSpeedGear1/100
		elif(currentSpeed> targetSpeedGear1):
			currentSpeed -=targetSpeedGear1/50
	
