extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.check_point = self.global_position
	GlobalSignal.syringe_catch_it.emit()
	queue_free()
