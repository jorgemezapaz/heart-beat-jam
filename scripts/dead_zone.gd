extends Node2D

@export var spot: Node2D

func _on_static_body_2d_body_entered(body: Node2D) -> void:
	print("dead")
	GlobalSignal.transition.emit("out")
	await get_tree().create_timer(.5).timeout
	body.global_position = spot.global_position
	GlobalSignal.transition.emit("in")
	GlobalSignal.player_dead.emit()
