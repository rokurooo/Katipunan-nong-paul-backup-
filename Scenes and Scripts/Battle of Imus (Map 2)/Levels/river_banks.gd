extends Node2D

@export var victory_scene: PackedScene
var player_defeated: bool = false

func _process(_delta):
	if get_tree().get_nodes_in_group("enemies").is_empty():
		set_process(false)
		SceneTransition.change_scene("res://VictoryScenes/victory_3.tscn")
	
	elif get_tree().get_nodes_in_group("player").is_empty():
		player_defeated = true
		set_process(false)
		SceneTransition.change_scene("res://DefeatScenes/defeat_3.tscn")
	
	
