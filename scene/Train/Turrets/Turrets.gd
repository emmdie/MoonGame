extends Node2D

signal shot_mouse

export (PackedScene) var Bullet


func _physics_process(delta):
	turn()
	if Input.is_action_just_pressed("shoot"):
		shoot()


func turn():
	get_node("Barrel").look_at(get_global_mouse_position())
	


func shoot():
	var b = Bullet.instance()
	b.connect("hit_mouse", self, "_on_Bullet_hit_mouse")
	add_child(b)
	b.transform = get_node("Barrel").transform

func _on_Bullet_hit_mouse():
	emit_signal("shot_mouse")
