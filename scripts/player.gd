extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
var direction: float

# coyote time
var was_on_floor: bool = false
var can_coyote_jump: bool = false

@onready var coyote_time: Timer = $coyote_time
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_particle: GPUParticles2D = $GPUParticles2D

@export var controll_disabled: bool = true

func _ready() -> void:
	GlobalSignal.syringe_catch_it.connect(show_health_particle)
	GlobalSignal.start_new_game.connect(new_game)
	GlobalSignal.start_game.connect(new_game)

func _physics_process(delta: float) -> void:
	var was_on_floor_this_frame = is_on_floor()
	
	if !controll_disabled:
		apply_gravity(delta)
		jump_handler()
		move_handler()
		flip_handler()
		animation_handler()
		coyote_time_handler()

	move_and_slide()
	was_on_floor = was_on_floor_this_frame

func new_game():
	controll_disabled = false
	
func coyote_time_handler():
	if not is_on_floor() and was_on_floor and velocity.y >= 0:
		can_coyote_jump = true
		coyote_time.start()

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
func jump_handler():
	if Input.is_action_just_pressed("jump") and (is_on_floor() or can_coyote_jump):
		velocity.y = JUMP_VELOCITY
		can_coyote_jump = false

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

func _on_coyote_time_timeout() -> void:
	can_coyote_jump = false

func show_health_particle():
	health_particle.emitting = true
	await get_tree().create_timer(1).timeout
	health_particle.emitting = false
