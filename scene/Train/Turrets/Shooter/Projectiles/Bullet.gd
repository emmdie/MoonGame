extends Area2D

signal hit_mouse

export var speed = 10


func _physics_process(delta):
	var velocity = ($Position2D.global_position -  $Position2D2.global_position) * delta * speed
	global_position = global_position + velocity

func _ready():
	$VisibilityNotifier2D.connect("viewport_exited", self, "_on_VisibilityNotifier2D_viewport_exited")
	connect("body_entered", self, "_on_Bullet_body_entered")
	$ShotSound.play()

func _on_Bullet_body_entered(body):
	if body.is_in_group("mice"):
		emit_signal("hit_mouse")
		body.queue_free()
		$MouseDeath.play()
	queue_free()

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
