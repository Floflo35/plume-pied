extends Node2D

@export var speed = -150

signal hit_player
signal tickled

func _ready():
	pass
	
func _process(delta):
	position.x += delta * speed
	

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	
	
	
func _on_tickle_area_entered(area):
	print("LOL")
	$TickleSound.playing = true
	$AnimationPlayer.active = true
