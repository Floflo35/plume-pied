extends Node2D

@export var speed = -150

signal hit_player
signal tickled

@export var base_anim = "run"
@export var fall_anim = "jmj_fall"

func _ready():
	$AnimationPlayer.active = true
	$AnimationPlayer.play(base_anim)
	
	
func _process(delta):
	position.x += delta * speed

	
func _on_hitbox_body_entered(body):
	#print("ouch")
	$Sprite/Tickle.set_deferred("monitoring", false)
	$Sprite/Tickle.set_deferred("visible", false)
	$Sprite/Hitbox.set_deferred("monitoring", false)
	GameLogic.obstacle_hit(body)


func _on_tickle_body_entered(body):
	print("LOL")
	$TickleSound.playing = true
	$AnimationPlayer.active = true
	$AnimationPlayer.play(fall_anim)
	$Sprite/Tickle.set_deferred("monitoring", false)
	$Sprite/Tickle.set_deferred("visible", false)
	$Sprite/Hitbox.set_deferred("monitoring", false)
	GameLogic.chatouille_hit(body)
