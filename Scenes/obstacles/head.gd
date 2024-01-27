extends Area2D

func _ready():
	GameLogic.obstacle_created(self)

func _process(delta):
	pass

func _on_body_entered(body):
	GameLogic.obstacle_hit(body);
