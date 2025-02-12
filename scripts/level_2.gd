extends Node2D

func _ready() -> void:
	GlobalSignal.start_new_game.emit()
