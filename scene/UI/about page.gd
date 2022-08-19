extends ColorRect

func _on_Github_pressed():
	OS.shell_open("https://github.com/emmdie/MoonGame")

func _on_Jam_pressed():
	OS.shell_open("https://godotwildjam.com/")

func _on_close_pressed():
	queue_free()
