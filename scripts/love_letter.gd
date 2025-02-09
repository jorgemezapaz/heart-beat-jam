extends Node2D

@onready var particle: GPUParticles2D = $GPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalSignal.love_letter_catch_it.emit()
	particle.emitting = true
	sprite_2d.visible = false
	await get_tree().create_timer(2).timeout
	queue_free()
	
	
