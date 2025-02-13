extends Node2D

@onready var ui_canva: CanvasLayer = $Camera2D/CanvasLayer

func _ready() -> void:
	ui_canva.visible = true
