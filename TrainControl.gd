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
		if(cart1.enabled==true):
			deselectAllCarts()
			cart1.select(true)
	if(Input.is_action_just_pressed("select_cart2")):
		if(cart2.enabled==true):
			deselectAllCarts()
			cart2.select(true)
	if(Input.is_action_just_pressed("select_cart3")):
		if(cart3.enabled==true):
			deselectAllCarts()
			cart3.select(true)
	if(Input.is_action_just_pressed("select_cart4")):
		if(cart4.enabled==true):
			deselectAllCarts()
			cart4.select(true)
	if(Input.is_action_just_pressed("select_cart5")):
		if(cart5.enabled==true):
			deselectAllCarts()
			cart5.select(true)
		
func _ready():
	cart1.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart2.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart3.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart4.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart5.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	cart1.setEnabled(true)
	cart2.setEnabled(false)
	cart3.setEnabled(false)
	cart4.setEnabled(false)
	cart5.setEnabled(false)
	deselectAllCarts()
	cart1.select(true)

#takes -1 or 1 as parameter
func gearDown():
	if(!(gear==-3)):
		gear = gear -1
		emit_signal("gearChanged", gear)
		$LeverChanged.play()

func gearUp():
	if(!(gear==3)):
		gear=gear+1
		$LeverChanged.play()
	emit_signal("gearChanged", gear)

func updateCurrentSpeed(delta):
	var targetSpeed = gear*0.25
	if(targetSpeed == currentSpeed):
		return currentSpeed
	if(targetSpeed > currentSpeed):
		return (currentSpeed + 2*(targetSpeed-currentSpeed)*delta)
	else:
		return (currentSpeed-2*delta*(currentSpeed-targetSpeed))

func applyUpgrade(cart, upgrade):
	print ("TrainControl: "+str(cart) + "  "+ str(upgrade))
	if(cart == 1):
		cart = cart1
		print("changed cart")
	elif(cart == 2):
		cart = cart2
		print("changed cart")
	elif(cart == 3):
		cart = cart3
		print("changed cart")
	elif(cart == 4):
		cart = cart4
		print("changed cart")
	elif(cart == 5):
		cart = cart5
		print("changed cart")
	if(upgrade==1):
		cart.setTurret(load("res://scene/Train/Turrets/Shooter/rocketlauncherT1.tscn"))
	if(upgrade==2):
		cart.setTurret(load("res://scene/Train/Turrets/Shooter/MineLauncher.tscn"))
	if(upgrade==3):
		cart.setTurret(load("res://scene/Train/Turrets/Shooter/ShooterT1.tscn"))
	else:
		cart.turret.maxAmmo = cart.turret.maxAmmo + 2
	cart.select(cart.selected)
	cart.setEnabled(cart.enabled)

	
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

func updateAmmoRelations(array):
	cart1.setLabel(array[0])
	cart2.setLabel(array[1])
	cart3.setLabel(array[2])
	cart4.setLabel(array[3])
	cart5.setLabel(array[4])
