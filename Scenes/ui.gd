extends Control

var score_inertia = 10

func _ready():
	clean_ui()
	GameLogic.game_started.connect(clean_ui)
	GameLogic.game_stopped.connect(game_over)

func _process(time_delta):	
	var current_score = GameLogic.getPercentageScore()
	var smiley_score = $smiley.get_score()
	var score_delta = current_score - smiley_score
	var animated_score_delta = score_delta * score_inertia * time_delta
	
	#  if framerate is too low jump to desired value without exceeding it
	if abs(animated_score_delta) > abs(score_delta):
		animated_score_delta = score_delta
	
	# if we're near from desired result, jump to it
	if abs(animated_score_delta) > 0.001:
		$smiley.set_score(smiley_score + animated_score_delta)
	else:
		$smiley.set_score(current_score)

func clean_ui():
	#test 1
	#$AnimationPlayer.play("reset")
	
	#test 2
	$AnimationPlayer.stop()
	$GameOver.modulate = Color(1,1,1,0)

func game_over():
	$AnimationPlayer.play("game_over")
