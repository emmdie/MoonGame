extends Node2D

signal shot_mouse
signal turret_damaged

export (PackedScene) var Bullet
export var maxAmmo = 3
export onready var ammo = maxAmmo
export var reloadTime = 2

var reloading = false
var selected = false
var enabled
var label
onready var gunfire = get_node("Barrel/Muzzle/Gunfire")

func _ready():
	$Hitbox.connect("body_entered", self, "_on_Hitbox_body_entered")

func _physics_process(_delta):
	if(selected&&enabled):
		turn()
		if Input.is_action_just_pressed("shoot"):
			shoot()

func setEnabled(boolean):
	$Barrel.visible = boolean
	$Base.visible = boolean
	get_node("Hitbox/HitboxArea").disabled = !boolean
	enabled = boolean
	
func turn():
	get_node("Barrel").look_at(get_global_mouse_position())

func shoot():
	if (ammo >= 1):
		var b = Bullet.instance()
		b.global_position = get_node("Barrel/Muzzle").global_position
		b.global_rotation =  get_node("Barrel/Muzzle").global_rotation
		b.connect("hit_mouse", self, "_on_Bullet_hit_mouse")
		get_node('/root').add_child(b)
		gunfire.emitting = true
		ammo -= 1
		label.shoot()
		if (ammo == 0&&!reloading):
			reload()

func _on_Bullet_hit_mouse():
	emit_signal("shot_mouse")

func _on_Hitbox_body_entered(body):
	if body.get_name().matchn("*mouse*"):
		emit_signal("turret_damaged")
		body.queue_free()

func select(boolean):
	selected = boolean

func reload():
	reloading = true
	label.reload(reloadTime)
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	ammo = maxAmmo
	reloading = false

func setLabel(newLabel):
	label = newLabel
	label.ammoCurrent = ammo
	label.ammoMax = maxAmmo
	
