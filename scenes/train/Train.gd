
extends Node2D
	
var gear = 0
var targetSpeed = 0
var currentSpeed =0
var waggons = []

func _process(delta):
	if(currentSpeed<targetSpeed):
		currentSpeed += targetSpeed*0.3*delta
	if(currentSpeed>targetSpeed):
		currentSpeed -= targetSpeed*0.3*delta
	$RotationalCenter.rotation += currentSpeed * delta


func _ready():
	changeGear(1)
	changeGear(1)

#takes -1 or 1 as parameter
func changeGear(amount):
	if!((gear == -2) && (amount == -1 )||(gear ==2)&&(amount ==1)):
		gear += amount
		targetSpeed += amount*0.7
		
func appendCar(car):
	waggons ++ car
