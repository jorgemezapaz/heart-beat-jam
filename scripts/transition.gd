extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GlobalSignal.transition.connect(show_transition)
	
func show_transition(type: String):
	if "in" == type:
		animation_player.play("fade_in")
	else:
		animation_player.play("fade_out")
