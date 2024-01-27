extends Node2D

@export var phase1_rotation_speed = 1.0

func _process(delta):
	$Wheel.rotation += delta * phase1_rotation_speed
	$BossGuy.rotation += delta * phase1_rotation_speed
