extends StaticBody2D

signal damaged

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hitbox_body_entered(body):
	if body.get_name().matchn("*Mouse*"):
		body.queue_free()
		emit_signal("damaged")
<<<<<<< Updated upstream
=======
		body.queue_free()
>>>>>>> Stashed changes
