extends Control

func _ready():
	GameLogic.register_ui(self)

func _process(delta):
	$score_label.text = str(GameLogic.getScore())
