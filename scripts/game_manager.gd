extends Node

@export var player: Node2D
@export var player_respawn: Node2D
@export var current_level: PackedScene
@export var next_leve: PackedScene

var transition_canvas = preload("res://scenes/transition.tscn")

func _ready() -> void:
	var transition = transition_canvas.instantiate()
	self.add_child(transition)
	transition.visible = false
	
	GlobalSignal.player_dead.connect(respawn)


func respawn():
	GlobalSignal.transition.emit("out")	
	await get_tree().create_timer(.5).timeout
	player.visible = true
	GlobalSignal.transition.emit("in")
	
