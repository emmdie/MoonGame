extends Node2D


func updateSprite(gear):
	$Sprite.texture = load("res://assets/art/UI/lever/"+ str(gear)+ ".png")
	
func _process(delta):
	pass
	
func _ready():
	updateSprite(0)


func _on_TrainControl_gearChanged(gear):
	updateSprite(gear)
