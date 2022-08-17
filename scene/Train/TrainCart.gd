extends KinematicBody2D

signal weapon_hit_mouse

export (PackedScene) var turret

func fireTurret():
	pass

func setTurret(turretType):
	if !(turret == null):
		turret.que_free()
	turret = turretType.instance()
	turret.connect("shot_mouse", self, "_on_turret_shot_mouse")
	add_child(turret)
	turret.position.y = -40

func _on_turret_shot_mouse():
	emit_signal("weapon_hit_mouse")

func setEnabled(boolean):
	$AnimatedSprite.visible = boolean
	$CollisionShape2D.disabled = !boolean
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

