extends Control

func _process(delta):
	if Input.is_action_just_pressed("enter"):
		GameLogic.start_game()

func _on_button_button_up():
	GameLogic.start_game()
