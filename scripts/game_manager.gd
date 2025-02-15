extends Node

@export var player: Node2D
@export var current_level: PackedScene
@export var next_leve: PackedScene
@onready var end_game_canvas: CanvasLayer =$"../CanvasLayer"

var transition_canvas = preload("res://scenes/transition.tscn")

func _ready() -> void:
	var transition = transition_canvas.instantiate()
	self.add_child(transition)
	transition.visible = false
	
	GlobalSignal.player_dead.connect(respawn)
	GlobalSignal.end_game.connect(end_game)


func respawn():
	GlobalSignal.transition.emit("out")	
	await get_tree().create_timer(.5).timeout
	player.visible = true
	GlobalSignal.transition.emit("in")
	
func end_game():
	GlobalSignal.transition.emit("out")	
	await get_tree().create_timer(.5).timeout
	end_game_canvas.visible = true
	GlobalSignal.transition.emit("in")
