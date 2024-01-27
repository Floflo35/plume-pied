extends CharacterBody2D

@export var gravity = 900.0
@export var jump_force = -300.0

var max_speed = 400
var is_active = true
var fly_on_next_physic_frame = false

func _ready():
	GameLogic.hit.connect(hit)
	GameLogic.chatouille.connect(chatouille)
	GameLogic.fly.connect(fly_requested)
	velocity = Vector2.ZERO
 
func _physics_process(delta):
	if !is_active:
		return
		
	if fly_on_next_physic_frame:
		fly_on_next_physic_frame = false
		jump()
		
	velocity.y += gravity * delta
	velocity.y = min(velocity.y , max_speed)
	
	move_and_collide(velocity * delta)

func fly_requested():
	fly_on_next_physic_frame = true

func jump():
	velocity.y = jump_force
	velocity.x = deg_to_rad(-30)
	
func kill():
	is_active = false

func stop():
	gravity = 0
	velocity = Vector2.ZERO
	kill()
	
func hit():
	print('hit')
	pass

func chatouille():
	print('chatouille')
	pass


