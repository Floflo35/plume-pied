extends Node

var plume
var obstacles = []
var chatouilles = []

func _ready():
	pass

func _process(delta):
	pass

# --- regsitrations
func obstacle_created(obj):
	obstacles.push_back(obj)
	
func chatouille_created(obj):
	chatouilles.push_back(obj)
	
func plume_created(obj):
	plume = obj
	
# --- events
func obstacle_hit(obj):
	plume.hit();

func chatouille_hit(obj):
	plume.chatouille();
