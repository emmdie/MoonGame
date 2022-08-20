extends KinematicBody2D

signal weapon_hit_mouse
signal cart_damaged

export (PackedScene) var turret
var selected = false
var enabled = true
var label

func fireTurret():
	pass

func setTurret(turretType):
	if !(turret == null):
		turret.queue_free()
	turret = turretType.instance()
	turret.connect("shot_mouse", self, "_on_turret_shot_mouse")
	turret.connect("turret_damaged", self, "_on_turret_turret_damaged")
	add_child(turret)
	turret.position.y = -40

func _on_turret_shot_mouse():
	emit_signal("weapon_hit_mouse")

func _on_turret_turret_damaged():
	emit_signal("cart_damaged")

func setEnabled(boolean):
	enabled=boolean
	$AnimatedSprite.visible = boolean
	$CollisionShape2D.disabled = !boolean
	turret.setEnabled(boolean)
	
func setLabel(newLabel):
	label = newLabel
	turret.setLabel(newLabel)

func select(boolean):
	turret.select(boolean)
	selected = boolean


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

