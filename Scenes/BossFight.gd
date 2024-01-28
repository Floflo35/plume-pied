extends Node2D

func _ready():
	GameLogic.game_reset.connect(clean)
	GameLogic.level_changed.connect(clean)

func clean():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()
