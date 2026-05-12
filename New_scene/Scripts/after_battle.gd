extends Node

@export_category("Victrory/Defeat Systems")
@export var victory_scene: PackedScene
@export var defeat_scene: PackedScene

@export_category("Victory parameters")
@export var Next_Scene: PackedScene
@export var Alive_character: int = 0

@export_category("Defeat parameters")
@export var Current_Scene: PackedScene

var player_defeated: bool = false
var victory_triggered: bool = false

func _ready() -> void:
	Globalcharactercheck.Next_Scene = Next_Scene
	Globalcharactercheck.Current_Scene = Current_Scene

func _process(_delta):
	if get_tree().get_nodes_in_group("enemies").is_empty() and !victory_triggered:
		victory_triggered = true
		for i in get_tree().get_nodes_in_group("CharDetails"):
			i.hide()
		get_tree().paused = true
		add_child(victory_scene.instantiate())
	
	elif get_tree().get_nodes_in_group("player").is_empty():
		player_defeated = true
		set_process(false)
		add_child(defeat_scene.instantiate())
	
