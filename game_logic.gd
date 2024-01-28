extends Node

signal game_started
signal game_loose
signal game_win
signal game_reset
signal hit
signal chatouille
signal fly
signal level_changed(level)

const MAX_SCORE = 10.0
const INITIAL_SCORE = 5.0
var score

const AUTO_DECREASE_SPEED = 0.1;
const DELAY_BEFORE_INTR0 = 5;

var state
const STATE_INTRO = 'state_intro'
const STATE_PLAY = 'state_play'
const STATE_PAUSE = 'state_pause'

var current_scene = null
var scene_intro = "res://Scenes/intro.tscn"
var scene_main = "res://Scenes/main.tscn"

var current_level = 1

func _ready():
	reset_game()
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func _process(delta):
	if state == STATE_INTRO:
		pass
		
	if state == STATE_PLAY:
		updateScore(-1 * delta * AUTO_DECREASE_SPEED)
		
		if (current_level == 2 && score >= MAX_SCORE - 0.1):
			launch_victory()
			return
		
		if Input.is_action_just_pressed("up"):
			fly.emit()
		
		if Input.is_action_just_pressed("1"):
			change_level(1)
		
		if Input.is_action_just_pressed("2"):
			change_level(2)
		
	if state == STATE_PAUSE:
		pass

# --- events
func start_game():	
	state = STATE_PLAY
	game_started.emit()
	goto_scene(scene_main)

func end_game():
	state = STATE_PAUSE
	game_loose.emit()
	
	var timer = get_tree().create_timer(DELAY_BEFORE_INTR0)  
	timer.timeout.connect(reset_game)

func reset_game():
	game_reset.emit()
	state = STATE_INTRO
	score = INITIAL_SCORE
	goto_scene(scene_intro)
	change_level(1)

func launch_victory():
	state = STATE_PAUSE
	score = MAX_SCORE
	game_win.emit()
	
	var timer = get_tree().create_timer(DELAY_BEFORE_INTR0)  
	timer.timeout.connect(reset_game)

func obstacle_hit(_node):
	if state == STATE_PLAY:
		hit.emit()
		updateScore(-1)

func chatouille_hit(_node):
	if state == STATE_PLAY:
		chatouille.emit()
		updateScore(1)

func change_level(level):
	if state == STATE_PLAY:
		level_changed.emit(level)
		current_level = level

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

func is_playing():
	return state == STATE_PLAY

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
