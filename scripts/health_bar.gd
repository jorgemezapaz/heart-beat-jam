extends Node2D

const DEAD: int = 0
const MAX_HEALTH: int = 9

@export var current_health: int = MAX_HEALTH
@export var time: float = 3.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var health_timer: Timer = $Timer

func _ready() -> void:
	health_timer.wait_time = time
	health_timer.start()
	GlobalSignal.syringe_catch_it.connect(full_health)

func _process(delta: float) -> void:
	sprite_2d.frame = current_health
	if current_health == DEAD:
		GlobalSignal.player_dead.emit()

func full_health():
	current_health = 9
	health_timer.stop()
	health_timer.start()

func _on_timer_timeout() -> void:
	if current_health == DEAD:
		GlobalSignal.player_dead.emit()
	else:
		current_health-=1
		health_timer.start()
