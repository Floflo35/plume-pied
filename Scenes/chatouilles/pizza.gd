extends Area2D

@export var speed = -150

func _process(delta):
	position.x += speed * delta

func _on_body_entered(body):
	GameLogic.chatouille_hit(body)
