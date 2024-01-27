extends Node2D


func _ready():
	GameLogic.hit.connect(hit)
	GameLogic.chatouille.connect(chatouille)
	GameLogic.fly.connect(fly)


func hit():
	$DamageSound.playing = true


func chatouille():
	$GuiliSound.playing = true


func fly():
	$FlySound.playing = true
