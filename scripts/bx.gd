extends CharacterBody2D

@onready var love_particles: GPUParticles2D = $GPUParticles2D
@onready var bubble_message: Sprite2D = $bubble

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalSignal.pause_game.emit()
	bubble_message.visible = true
	await get_tree().create_timer(2).timeout
	love_particles.emitting = true
	await get_tree().create_timer(5).timeout
	GlobalSignal.end_game.emit()
