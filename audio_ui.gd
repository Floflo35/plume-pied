extends Node2D

func _ready():
	GameLogic.hit.connect(hit)
	GameLogic.chatouille.connect(chatouille)
	
	
func hit():
	$DamageSound.playing = true
	

func chatouille():
	$GuiliSound.playing = true
