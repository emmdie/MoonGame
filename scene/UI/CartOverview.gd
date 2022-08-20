extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getArrayOfCarts():
	var array = []
	for child in get_children():
		array.append(child)
	return array
