extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scewne tree for the first time.
func _ready():
	pass

func set_gravity_center(pos):
	gravity_vec.x = pos.x
	gravity_vec.y = pos.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
