extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var direction: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	player_control()
	flip_handler()
	animation_handler()
	
	move_and_slide()

func player_control():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
