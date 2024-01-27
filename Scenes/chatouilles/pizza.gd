extends Area2D

func _ready():
	GameLogic.register_chatouille(self)

func _process(delta):
	pass

func _on_body_entered(body):
	GameLogic.chatouille_hit(body);
