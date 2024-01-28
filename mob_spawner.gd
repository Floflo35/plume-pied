extends Node

@export var mob_scene: PackedScene
@export var mob_scene_reversed: PackedScene
@export var position = Vector2.ZERO
@export var can_reverse = true
@export var timer_min = 1.0
@export var timer_max = 3.0
@export var y_min = 450
@export var y_max = 1080
@export var size = 0.5
@export var speed_min = -1000
@export var speed_max = -500

func _ready():
	print("spawner ready")
	randomizer()
	

func randomizer():
	var time = randi_range(timer_min, timer_max)
	print(time)
	var timer = get_tree().create_timer(time)
	timer.timeout.connect(spawn)
	


func spawn():
	#print("Spawn")
	
	var mob = mob_scene.instantiate()
	var reversed = randi_range(0, 1)
	
	if reversed == 1 and can_reverse == true:
		mob.speed = randi_range(speed_min, speed_max) * -1
		mob.position.x = 0
		mob.scale.x = size * -1
		mob.scale.y = size
	else:
		mob.position.x = 2000
		mob.speed = randi_range(speed_min, speed_max)
		mob.scale.x = size
		mob.scale.y = size
		
	mob.position.y = randi_range(y_min, y_max)
	
	add_child(mob)
	randomizer()
