extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
var direction: float

# coyote time
var was_on_floor: bool = false
var can_coyote_jump: bool = false
@onready var coyote_time: Timer = $timers/coyote_timer

#Input Buffer
const JUMP_BUFFER_TIME:float= 0.15 #son 9 frames
@onready var input_buffer_timer: Timer = $timers/input_buffer_timer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_particle: GPUParticles2D = $GPUParticles2D

@export var controll_disabled: bool = true
@export var default_respawn: Node2D
var check_point: Vector2

func _ready() -> void:
	GlobalSignal.syringe_catch_it.connect(show_health_particle)
	GlobalSignal.start_new_game.connect(new_game)
	GlobalSignal.start_game.connect(new_game)
	GlobalSignal.player_dead.connect(dead)
	GlobalSignal.pause_game.connect(pause)

func _physics_process(delta: float) -> void:
	var was_on_floor_this_frame = is_on_floor()
	apply_gravity(delta)
	if !controll_disabled:
		
		jump_handler()
		move_handler()
		flip_handler()
		animation_handler()
		coyote_time_handler()
		handler_jump_buffer()
		
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
	if (Input.is_action_just_pressed("jump") or input_buffer_timer.time_left > 0) and (is_on_floor() or can_coyote_jump):
		velocity.y = JUMP_VELOCITY
		can_coyote_jump = false
		input_buffer_timer.stop()

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

func handler_jump_buffer():
	if Input.is_action_just_pressed("jump"):
		input_buffer_timer.start(JUMP_BUFFER_TIME)

func dead():
	controll_disabled = true
	visible = false
	velocity = Vector2.ZERO
	print(check_point)
	if check_point:
		print("check point")
		position = check_point
	else:
		position = default_respawn.global_position
		print("default")
		
	await get_tree().create_timer(.5).timeout
	animation_player.play("idle")
	controll_disabled = false

func pause():
	controll_disabled = true
	velocity = Vector2.ZERO
	animation_player.play("idle")
