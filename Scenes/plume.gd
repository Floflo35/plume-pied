extends CharacterBody2D

@export var gravity = 900.0
@export var fly_force = -300.0

var max_speed = 400
var is_active = true
var fly_on_next_physic_frame = false

const MIN_Y = 30
const MAX_Y = 1080
const BOUND_ZONE = 50
const rejection_force = 0.01

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
		fly()
		
	var y_delta = gravity * delta
	var desired_velocity = min(velocity.y + y_delta , max_speed)

	if desired_velocity < 0 && (position.y <= (MIN_Y + BOUND_ZONE)):
		var rejection_distance = MIN_Y + BOUND_ZONE - position.y
		desired_velocity = gravity * rejection_distance * rejection_force
	
	if desired_velocity > 0 && position.y >= (MAX_Y - BOUND_ZONE):
		GameLogic.obstacle_hit(self)
		desired_velocity = 0
		
	velocity.y = desired_velocity
	
	move_and_collide(velocity * delta)

func fly_requested():
	fly_on_next_physic_frame = true

func fly():
	velocity.y = fly_force
	
func kill():
	is_active = false

func stop():
	gravity = 0
	velocity = Vector2.ZERO
	kill()

func hit():
	$AnimationPlayer.play("hit")

func chatouille():
	$AnimationPlayer.play("chatouille")

func _on_animation_player_animation_finished(anim_name):
	if anim_name != "fall":
		$AnimationPlayer.play("fall")
