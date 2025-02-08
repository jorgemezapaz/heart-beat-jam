extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var direction: float
var is_on_ground: bool
var is_jumping: bool

@onready var coyote_time: Timer = $coyote_time
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	is_on_ground = is_on_floor()
	var was_on_floor = is_on_floor()
	
	apply_gravity(delta)
	jump_handler()
	move_handler()
	flip_handler()
	animation_handler()
	
	if was_on_floor and not is_on_floor():
		coyote_time.start()
	move_and_slide()

func apply_gravity(delta: float):
	if not is_on_ground:
		velocity += get_gravity() * delta
	
func jump_handler():
	if Input.is_action_just_pressed("jump") and not coyote_time.is_stopped():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

func move_handler():
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func flip_handler():
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0 :
		sprite.flip_h = true
		
func animation_handler():
	if direction == 0 and is_on_floor():
		animation_player.play("idle")
	elif direction != 0 and is_on_floor():
		animation_player.play("walk") 
	elif velocity.y < 0:
		animation_player.play("jump")
	elif velocity.y > 0:
		animation_player.play("fall")
