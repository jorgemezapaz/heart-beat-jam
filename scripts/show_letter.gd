extends CanvasLayer


@onready var letter_1: Control = $letter_1
@onready var letter_2: Control = $letter_2
var target_position: Vector2 = Vector2(350,160)

func _ready() -> void:
	GlobalSignal.show_letter.connect(show_letter)
	
func show_letter(number:int):
	visible = true
	var tween = get_tree().create_tween()
	if 1 == number:
		tween.tween_property(letter_1,"global_position", target_position, 0.3)
	elif 2 == number:
		tween.tween_property(letter_2,"global_position", target_position, 0.3)
		
