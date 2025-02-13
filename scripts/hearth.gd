extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GlobalSignal.heath_beating.connect(change_animation)

func change_animation(val:int):
	if val > 6:
		animation_player.play("very_high_beating", .2)
	elif val > 4:
		animation_player.play("high_beating", .2)
	elif  val > 2:
		animation_player.play("medium_beating", .2)
	else:
		animation_player.play("low_beating", .2)
