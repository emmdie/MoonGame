extends "res://scene/Train/Turrets/Shooter/Projectiles/Bullet.gd"

func _ready():
	var t = Timer.new()
	t.set_wait_time(15)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	queue_free()
