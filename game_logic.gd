extends Node

var ui
var plume
var obstacles = []
var chatouilles = []

const MAX_SCORE = 10.0
var score = 5

const AUTO_DECREASE_SPEED = 0.1;

var state
const STATE_START = 'state_start'
const STATE_PLAY = 'state_play'
const STATE_GAMEOVER = 'state_game_over'

signal hit
signal chatouille

func _ready():
	state = STATE_PLAY

func _process(delta):
	updateScore(-1 * delta * AUTO_DECREASE_SPEED)

# --- events
func obstacle_hit(_node):
	hit.emit()
	updateScore(-1)

func chatouille_hit(_node):
	chatouille.emit()
	updateScore(1)

# --- 
func updateScore(delta):
	score = min(MAX_SCORE, max(0, score + delta))

func getScore():
	return score

func getPercentageScore():
	return score / MAX_SCORE;
	
