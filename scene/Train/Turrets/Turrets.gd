extends Node2D
export (PackedScene) var Bullet

func _physics_process(delta):
	turn()
	if Input.is_action_just_pressed("shoot"):
		shoot()

	
func turn():
	get_node("Barrel").look_at(get_global_mouse_position())
	


func shoot():
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = get_node("Barrel").transform
