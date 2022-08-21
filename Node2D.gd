extends Node2D


export(PackedScene) var MouseZeppelin_scene
var speed = 400
var angular_speed = PI


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$MouseZeppelin.rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated() * speed
	
	$MouseZeppelin.position += velocity * delta
