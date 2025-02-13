extends CanvasLayer

@onready var health_bar: Node2D = $NinePatchRect/health_bar
@onready var hearth: Node2D = $NinePatchRect/hearth

func _ready() -> void:
	GlobalSignal.start_game.connect(new_game)
	GlobalSignal.start_new_game.connect(new_game)
	GlobalSignal.pause_game.connect(hide_health_bar)

func new_game():
	health_bar.visible = true
	hearth.visible = true

func hide_health_bar():
	health_bar.visible = false
	hearth.visible = false
