extends Node2D

signal shot_mouse
<<<<<<< Updated upstream
=======
signal turret_damaged

>>>>>>> Stashed changes
export (PackedScene) var Bullet

func _ready():
	$Hitbox.connect("body_entered", self, "_on_Hitbox_body_entered")

func _physics_process(_delta):
	turn()
	if Input.is_action_just_pressed("shoot"):
		shoot()


func turn():
	get_node("Barrel").look_at(get_global_mouse_position())
	


func shoot():
	var b = Bullet.instance()
	b.connect("hit_mouse", self, "_on_Bullet_hit_mouse")
	b.transform = get_node("Barrel").transform
	get_parent().get_parent().get_parent().add_child(b)
	b.position = get_node("Barrel/Muzzle").position

func _on_Bullet_hit_mouse():
	emit_signal("shot_mouse")

func _on_Hitbox_body_entered(body):
	if body.get_name().matchn("*mouse*"):
		emit_signal("turret_damaged")
	
