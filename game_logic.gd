extends Node

signal game_started
signal game_stopped
signal hit
signal chatouille
signal fly

const MAX_SCORE = 10.0
const INITIAL_SCORE = 5.0
var score

const AUTO_DECREASE_SPEED = 0.1;
const DELAY_BEFORE_INTR0 = 5;

var state
const STATE_INTRO = 'state_intro'
const STATE_PLAY = 'state_play'
const STATE_GAMEOVER = 'state_game_over'

var current_scene = null
var scene_intro = "res://Scenes/intro.tscn"
var scene_main = "res://Scenes/main.tscn"

func _ready():
	reset_game()
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func _process(delta):
	if state == STATE_INTRO:
		pass
		
	if state == STATE_PLAY:
		updateScore(-1 * delta * AUTO_DECREASE_SPEED)
		if Input.is_action_just_pressed("up"):
			fly.emit()
			
	if state == STATE_GAMEOVER:
		pass

# --- events
func start_game():	
	print("start_game")
	state = STATE_PLAY
	game_started.emit()
	goto_scene(scene_main)

func end_game():
	print("end_game")
	state = STATE_GAMEOVER
	game_stopped.emit()
	
	var timer = get_tree().create_timer(DELAY_BEFORE_INTR0)  
	timer.timeout.connect(reset_game)

func reset_game():
	print("reset_game")
	state = STATE_INTRO
	score = INITIAL_SCORE
	goto_scene(scene_intro)

func obstacle_hit(_node):
	if state == STATE_PLAY:
		hit.emit()
		updateScore(-1)

func chatouille_hit(_node):
	if state == STATE_PLAY:
		chatouille.emit()
		updateScore(1)

# --- 
func updateScore(delta):
	if state == STATE_PLAY:
		score = min(MAX_SCORE, max(0, score + delta))
		if (score == 0):
			end_game()

func getScore():
	return score

func getPercentageScore():
	return score / MAX_SCORE;

# ---
func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
