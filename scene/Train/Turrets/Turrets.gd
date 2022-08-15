extends Node2D

func _physics_process(delta):
	turn()
	
func turn():
	get_node("Barrel").look_at(get_global_mouse_position())
