extends CanvasLayer


@onready var letter_1: Control = $letter_1

func _ready() -> void:
	GlobalSignal.show_letter.connect(show_letter)
	
func show_letter(number:int):
	visible = true
	var tween = get_tree().create_tween()
	if 1 == number:
		tween.tween_property(letter_1,"global_position", Vector2(350,160), 0.3)
