extends CharacterBody2D

@export var gravity = 900.0
@export var jump_force = -300.0

var max_speed = 400
var is_active = true

func _ready():
	velocity = Vector2.ZERO
 
func _physics_process(delta):
	if !is_active:
		return
		
	if Input.is_action_just_pressed("up"):
		jump()
		
	velocity.y += gravity * delta
	velocity.y = min(velocity.y , max_speed)
	
	move_and_collide(velocity * delta)

func jump():
	velocity.y = jump_force
	velocity.x = deg_to_rad(-30)
	
	
func kill():
	is_active = false

func stop():
	gravity = 0
	velocity = Vector2.ZERO
	kill()
