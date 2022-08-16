extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal mouse_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.






func _on_MouseDetectionRange_body_entered(body):
	print("moon entered")
	if (body.get_name().matchn("*Mouse*")):
		print("moon entered by mouse")
		emit_signal("mouse_hit")
		body.queue_free()


