extends Node

var ui
var plume
var obstacles = []
var chatouilles = []

const MAX_SCORE = 10
var score = 5

signal player_hit
signal player_chatouille

func _ready():
	pass

func _process(delta):
	pass

# --- regsitrations
func register_ui(node):
	ui = node
	
func register_obstacle(node):
	obstacles.push_back(node)
	
func register_chatouille(node):
	chatouilles.push_back(node)
	
func register_plume(node):
	plume = node

# --- events
func obstacle_hit(node):
	plume.hit()
	player_hit.emit()
	updateScore(-1)

func chatouille_hit(node):
	plume.chatouille()
	player_chatouille.emit()
	updateScore(1)

# --- 
func updateScore(delta):
	score = min(MAX_SCORE, max(0, score + delta))

func getScore():
	return score
	
