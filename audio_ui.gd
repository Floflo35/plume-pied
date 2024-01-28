extends Node2D


@export var lvl_1_music = AudioStream
@export var lvl_2_music = AudioStream


func _ready():
	GameLogic.hit.connect(hit)
	GameLogic.chatouille.connect(chatouille)
	GameLogic.fly.connect(fly)
	GameLogic.level_changed.connect(lvl_change)


func hit():
	$DamageSound.playing = true


func chatouille():
	$GuiliSound.playing = true


func fly():
	$FlySound.playing = true
	
	
func lvl_change(level):
	#$Music.playing = false
	print ("LEVEL CHANGED")
	if level == 1:
		$Music.stream = lvl_1_music
	elif level == 2:
		$Music.stream = lvl_2_music
	$Music.playing = true
