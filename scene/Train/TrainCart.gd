extends KinematicBody2D

export (PackedScene) var turret

func fireTurret():
	pass

func setTurret(turretType):
	if !(turret == null):
		turret.que_free()
	turret = turretType.instance()
	add_child(turret)
	turret.position.y = -40
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

