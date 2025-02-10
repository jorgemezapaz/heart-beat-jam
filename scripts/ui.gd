extends CanvasLayer

@onready var health_bar: Node2D = $NinePatchRect/health_bar
func _ready() -> void:
	GlobalSignal.start_game.connect(new_game)
	GlobalSignal.start_new_game.connect(new_game)

func new_game():
	health_bar.visible = true
