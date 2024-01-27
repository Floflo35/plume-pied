extends Node2D

@export var speed = -150

signal hit_player
signal tickled

var fall_anim = "jmj_fall"

func _ready():
	pass
	
	
func _process(delta):
	position.x += delta * speed
	

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	
	
	
	
func _on_hitbox_body_entered(body):
	#print("ouch")
	$Tickle/TickleShape.set_deferred("disabled", true)
	$Hitbox/HitboxShape.set_deferred("disabled", true)
	GameLogic.obstacle_hit(body)


func _on_tickle_body_entered(body):
	#print("LOL")
	$TickleSound.playing = true
	$AnimationPlayer.active = true
	$AnimationPlayer.play("jmj_fall")
	$Tickle/TickleShape.set_deferred("disabled", true)
	$Hitbox/HitboxShape.set_deferred("disabled", true)
	GameLogic.chatouille_hit(body)
