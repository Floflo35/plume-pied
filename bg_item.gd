extends Node2D

@export var speed = -50

func _process(delta):
	$Sprite2D.position.x += speed * delta
