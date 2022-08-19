extends Area2D

signal hit_mouse

var speedx = 100
var speedy = 100


func _physics_process(delta):
	print(str(global_rotation))
	
func _ready():
	pass

func _on_Bullet_body_entered(body):
	if body.is_in_group("mice"):
		emit_signal("hit_mouse")
		body.queue_free()
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()

