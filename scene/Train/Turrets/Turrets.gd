extends Node2D

func turn():
	var aimPosition = get_global_mouse_position()
	get_node("Turret").look_at(aimPosition)
