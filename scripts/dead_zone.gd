extends Node2D

@export var spot: Node2D



func _on_static_body_2d_body_entered(body: Node2D) -> void:
	print("dead")
	body.global_position = spot.global_position
