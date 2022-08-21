extends ColorRect

func _on_Github_pressed():
	$ButtonClicked.play()
	yield(get_tree().create_timer(0.15), "timeout")
	OS.shell_open("https://github.com/emmdie/MoonGame")

func _on_Jam_pressed():
	$ButtonClicked.play()
	yield(get_tree().create_timer(0.15), "timeout")
	OS.shell_open("https://godotwildjam.com/")

func _on_close_pressed():
	$ButtonClicked.play()
	yield(get_tree().create_timer(0.15), "timeout")
	queue_free()
