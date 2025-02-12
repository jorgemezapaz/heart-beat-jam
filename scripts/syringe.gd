extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalSignal.syringe_catch_it.emit()
	queue_free()
