extends Camera2D

@export var shake_intensity = 20
@export var shake_length = 0.3

var screenshake = false

func _ready():
	GameLogic.hit.connect(hit)
	
	
func hit():
	#print("SCREENSHAKE")
	var timer = get_tree().create_timer(shake_length)
	screenshake = true
	timer.timeout.connect(shake_stop)
	pass
	

func shake_stop():
	screenshake = false
	position.x = 0
	position.y = 0
	

func _process(delta):
	if screenshake == true:
		position.x = randi_range(shake_intensity * -1, shake_intensity)
		position.y = randi_range(shake_intensity * -1, shake_intensity)
		
		
