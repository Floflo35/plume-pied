extends Node2D


@export var lvl_1_music = AudioStream
@export var lvl_2_music = AudioStream
@export var game_over_music = AudioStream
@export var win_music = AudioStream


func _ready():
	GameLogic.hit.connect(hit)
	GameLogic.chatouille.connect(chatouille)
	GameLogic.fly.connect(fly)
	GameLogic.level_changed.connect(lvl_change)
	GameLogic.game_loose.connect(game_over)
	GameLogic.game_win.connect(win)


func hit():
	$DamageSound.playing = true


func chatouille():
	$GuiliSound.playing = true


func fly():
	$FlySound.playing = true
	
	
func lvl_change(level):
	#$Music.playing = false
	#print ("LEVEL CHANGED")
	if level == 1:
		$Music.stream = lvl_1_music
	elif level == 2:
		$Music.stream = lvl_2_music
	$Music.playing = true

func game_over():
	$Music.stream = game_over_music
	$Music.playing = true
	
	
func win():
	#$Music.stream = win_music
	#$Music.playing = true
	pass
	
