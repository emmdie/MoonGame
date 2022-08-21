extends ColorRect

# Called when the node enters the scene tree for the first time.
const aboutScene = preload("res://scene/UI/aboutpage.tscn")
const settingsScene = preload("res://scene/UI/settings.tscn")

func _ready():
	get_tree().paused = false

func _on_ExitButton_pressed():
	$ButtonClicked.play()
	get_tree().quit()


func _on_PlayButton_pressed():
	$ButtonClicked.play()
	get_tree().change_scene("res://scene/Levels/Level.tscn")


func _on_AboutButton_pressed():
	$ButtonClicked.play()
	var aboutInstance = aboutScene.instance()
	add_child(aboutInstance)


func _on_SettingsButton_pressed():
	$ButtonClicked.play()
	var settingsInstance = settingsScene.instance()
	add_child(settingsInstance)
