extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta
	if is_outside_view_bounds():
		queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("mice"):
		body.queue_free()
	queue_free()
	
func is_outside_view_bounds():
	return position.x>OS.get_screen_size().x or position.x<0.0\
		or position.y>OS.get_screen_size().y or position.y<0.0
