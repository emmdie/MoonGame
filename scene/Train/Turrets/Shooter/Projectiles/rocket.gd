extends "res://scene/Train/Turrets/Shooter/Projectiles/Bullet.gd"
export onready var steerForce =10
var pointer 
var velocity

func _physics_process(delta):
	pointer = get_global_mouse_position()
	velocity = ($Position2D.global_position -  $Position2D2.global_position) * delta * speed
	velocity = velocity + seek()
	global_rotation = velocity.angle()
	global_position = global_position + velocity
	
func seek():
	var steer = Vector2.ZERO
	if pointer:
		var desired = (pointer - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steerForce
	return steer
