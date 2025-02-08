extends CanvasLayer

@onready var label:Label = $NinePatchRect/Label

func _ready() -> void:
	GlobalSignal.syringe_catch_it.connect(update_life_bar)

func update_life_bar():
	label.text="updated"
