extends Node2D

func _ready():
	$smiley_a.set_score(0.0)
	$smiley_b.set_score(0.2)
	$smiley_c.set_score(0.5)
	$smiley_d.set_score(0.7)
	$smiley_e.set_score(1.0)

func _process(delta):
	if Input.is_action_just_pressed("up"):
		$smiley_a.hit()
		$smiley_b.chatouille()
