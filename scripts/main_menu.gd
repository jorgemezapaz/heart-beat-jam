extends CanvasLayer


func _on_play_pressed() -> void:
	GlobalSignal.start_new_game.emit()
	visible = false
	
func _on_exit_pressed() -> void:
	get_tree().quit()
