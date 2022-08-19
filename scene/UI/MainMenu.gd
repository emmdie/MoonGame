extends ColorRect

# Called when the node enters the scene tree for the first time.
const aboutScene = preload("res://scene/UI/aboutpage.tscn")

func _ready():
	get_tree().paused = false

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://scene/Levels/Level.tscn")


func _on_AboutButton_pressed():
	var aboutInstance = aboutScene.instance()
	add_child(aboutInstance)
