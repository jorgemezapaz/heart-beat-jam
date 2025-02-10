extends Node2D

@onready var ui_canva: CanvasLayer = $Camera2D/CanvasLayer
@onready var transition: CanvasLayer = $transition

func _ready() -> void:
	ui_canva.visible = true
	transition.visible = true
