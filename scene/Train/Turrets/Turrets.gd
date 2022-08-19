extends Node2D

signal shot_mouse
signal turret_damaged

export (PackedScene) var Bullet
var selected = false

func _ready():
	$Hitbox.connect("body_entered", self, "_on_Hitbox_body_entered")

func _physics_process(_delta):
	if(selected):
		turn()
		if Input.is_action_just_pressed("shoot"):
			shoot()

func setEnabled(boolean):
	$Barrel.visible = boolean
	$Base.visible = boolean
	get_node("Hitbox/HitboxArea").disabled = !boolean
	
func turn():
	get_node("Barrel").look_at(get_global_mouse_position())
	


func shoot():
	var b = Bullet.instance()
	b.global_position = get_node("Barrel/Muzzle").global_position
	b.global_rotation =  get_node("Barrel/Muzzle").global_rotation
	b.connect("hit_mouse", self, "_on_Bullet_hit_mouse")
	get_node('/root').add_child(b)
	

func _on_Bullet_hit_mouse():
	emit_signal("shot_mouse")

func _on_Hitbox_body_entered(body):
	if body.get_name().matchn("*mouse*"):
		emit_signal("turret_damaged")
	
func select(boolean):
	selected = boolean
