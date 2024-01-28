extends Node2D

@export var phase1_rotation_speed = 1.0
var rotation_speed = 0.5
var score = 0


func _ready():
	rotation_speed = phase1_rotation_speed


func _process(delta):
	$Wheel.rotation += delta * rotation_speed
	$WheelShadow.rotation += delta * rotation_speed
	$BossGuy.rotation += delta * rotation_speed
	if score == 4:
		GameLogic.end_game()


func _on_tickle_0_body_entered(body):
	print("TICKLE")
	rotation_speed = rotation_speed * 1.15
	$BossGuy/Tickle0.set_deferred("monitoring", false)
	$BossGuy/Tickle0.set_deferred("visible", false)
	GameLogic.chatouille_hit(body)
	score += 1


func _on_tickle_1_body_entered(body):
	print("TICKLE")
	rotation_speed = rotation_speed * 1.15
	$BossGuy/Tickle1.set_deferred("monitoring", false)
	$BossGuy/Tickle1.set_deferred("visible", false)
	GameLogic.chatouille_hit(body)
	score += 1


func _on_tickle_2_body_entered(body):
	print("TICKLE")
	rotation_speed = rotation_speed * 1.15
	$BossGuy/Tickle2.set_deferred("monitoring", false)
	$BossGuy/Tickle2.set_deferred("visible", false)
	GameLogic.chatouille_hit(body)
	score += 1


func _on_tickle_3_body_entered(body):
	print("TICKLE")
	rotation_speed = rotation_speed * 1.15
	$BossGuy/Tickle3.set_deferred("monitoring", false)
	$BossGuy/Tickle3.set_deferred("visible", false)
	GameLogic.chatouille_hit(body)
	score += 1


func _on_hitbox_body_entered(body):
	GameLogic.obstacle_hit(body)
