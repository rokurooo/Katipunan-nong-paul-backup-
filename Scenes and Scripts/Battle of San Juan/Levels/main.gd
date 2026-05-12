extends Node2D

@export var victory_scene: PackedScene
var player_defeated: bool = false
var victory_triggered: bool = false

func _process(_delta):
	if get_tree().get_nodes_in_group("enemies").is_empty() and !victory_triggered:
		victory_triggered = true
		set_process(false)
		SceneTransition.packed_scene(victory_scene)
	
	elif get_tree().get_nodes_in_group("player").is_empty():
		player_defeated = true
		set_process(false)
		SceneTransition.change_scene("res://DefeatScenes/defeat.tscn")
	
	
