extends Node2D

@export var speed = -30

func _process(delta):
	position.x += speed * delta
