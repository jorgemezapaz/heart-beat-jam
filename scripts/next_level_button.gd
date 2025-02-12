extends Control

@export var next_level: int

func _on_button_pressed() -> void:
	var next_level_path = "res://scenes/level_"+str(next_level)+".tscn"
	get_tree().change_scene_to_file(next_level_path)
