extends Node2D

const DEAD: int = 0
const MAX_HEALTH: int = 8
var health_decrement_timer: float = 0.0 
var healh_timer: float = 0

@export var current_health: int = MAX_HEALTH
@export var time: float = 3.0

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	GlobalSignal.syringe_catch_it.connect(full_health)
	GlobalSignal.player_dead.connect(reset_ui)
	
func _physics_process(delta: float) -> void:
	if current_health == DEAD:
		GlobalSignal.player_dead.emit()
	
	sprite_2d.frame = current_health
	
	if current_health > DEAD:
		healh_timer += delta
	
	if healh_timer >= time:
		current_health -= 1
		healh_timer = 0.0
	

func full_health():
	current_health = MAX_HEALTH
	healh_timer = 0.0
	sprite_2d.frame = current_health

func reset_ui():
	full_health()
