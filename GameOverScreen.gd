extends ColorRect


signal restart


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_return_pressed():
	$ButtonClicked.play()
	yield(get_tree().create_timer(0.15), "timeout")
	emit_signal("restart")
