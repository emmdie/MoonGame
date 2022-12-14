extends Node2D

signal shot_mouse
signal turret_damaged

export (PackedScene) var Bullet
var selected = false
var enabled
onready var gunfire = get_node("Barrel/Muzzle/Gunfire")
export var maxAmmo = 5
export onready var ammo = maxAmmo
export var reloadTime = 2
var label
var reloading = false
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
	if (label != null):
		label.visible = boolean
	enabled = boolean
	
func turn():
	get_node("Barrel").look_at(get_global_mouse_position())

func shoot():
	if (!reloading):
		var b = Bullet.instance()
		b.global_position = get_node("Barrel/Muzzle").global_position
		b.global_rotation =  get_node("Barrel/Muzzle").global_rotation
		b.connect("hit_mouse", self, "_on_Bullet_hit_mouse")
		get_node('/root').add_child(b)
		gunfire.emitting = true
		label.shoot()
		ammo =ammo- 1
		if (ammo == 0&&!reloading):
			reload()
	else:
		$OutOfBullets.play()

func _on_Bullet_hit_mouse():
	$RatDeath.play()
	emit_signal("shot_mouse")

func _on_Hitbox_body_entered(body):
	if body.get_name().matchn("*Mouse*"):
		body.queue_free()
		emit_signal("turret_damaged")
		body.queue_free()

func select(boolean):
	selected = boolean

func reload():
	$Reloading.play()
	reloading = true
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	label.reload(reloadTime+0.7)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	ammo = maxAmmo
	reloading = false
	

func setLabel(newLabel):
	label = newLabel
	newLabel.ammoCurrent = ammo
	newLabel.ammoMax = maxAmmo
	newLabel.updateLabel()
	if enabled == false:
		label.visible = false
