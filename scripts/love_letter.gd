extends Node2D

@onready var particle: GPUParticles2D = $GPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalSignal.show_letter.emit(1)
	GlobalSignal.pause_game.emit()
	particle.emitting = true
	sprite_2d.visible = false
	await get_tree().create_timer(4).timeout
	queue_free()
	
	
