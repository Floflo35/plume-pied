extends Area2D

@export var speed = -150

func _ready():
	GameLogic.register_obstacle(self)

func _process(delta):
	position.x += speed * delta

func _on_body_entered(body):
	GameLogic.obstacle_hit(body);
