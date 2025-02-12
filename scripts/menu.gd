extends CanvasLayer

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		self.visible = true
		GlobalSignal.pause_game.emit()

func _on_continue_button_pressed() -> void:
	GlobalSignal.continue_game.emit()
	self.visible = false

func _on_quite_button_pressed() -> void:
	get_tree().quit()
