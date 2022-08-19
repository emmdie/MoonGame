extends ColorRect

func _ready():
	get_tree().paused = true
	
func _on_close_pressed():
	get_tree().paused = false
	queue_free()


func _on_Button_pressed():
	OS.set_window_fullscreen(!OS.window_fullscreen)
