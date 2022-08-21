extends ColorRect

func _ready():
	get_tree().paused = true
	
func _on_close_pressed():
	get_tree().paused = false
	$ButtonClicked.play()
	yield(get_tree().create_timer(0.15), "timeout")
	queue_free()

func _on_Button_pressed():
	$ButtonClicked.play()
	OS.set_window_fullscreen(!OS.window_fullscreen)
