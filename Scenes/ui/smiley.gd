extends Node2D

@export var low_color = Color(0.65, 0.56, 0.52)
@export var high_color = Color(1, 0.7, 0.04)

var score = 0.5
const available_animations = [ "a", "b", "c", "d", "e" ]

func _ready():
	$halo.stop()
	GameLogic.hit.connect(hit)
	GameLogic.chatouille.connect(chatouille)

func get_score():
	return score

func set_score(s):
	score = s
	
	$Circle.color = get_color_for_score(s)
	$Face.animation = get_animation_for_score(s)
	$RoundGauge.percentage = s

func get_animation_for_score(s):
	return available_animations[
		ceil(s * (available_animations.size() - 1))
	]

func get_color_for_score(s):
	return Color(
		low_color.r + (high_color.r - low_color.r) * s,
		low_color.g + (high_color.g - low_color.g) * s,
		low_color.b + (high_color.b - low_color.b) * s
	)

func hit():
	if GameLogic.getPercentageScore() <= 0.2:
		$AnimationPlayer.play("hit")
	else:
		$AnimationPlayer.play("warning")

func chatouille():
	$AnimationPlayer.play("chatouille")
