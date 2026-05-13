extends Node

@export_category("Victrory/Defeat Systems")
@export_enum("0-1","1-3","4-6","7-9") var current_level_range:int = 0
var menu_path

@export var victory_scene: PackedScene
@export var defeat_scene: PackedScene

@export_category("Victory parameters")
@export var Next_Scene: PackedScene
@export_range(0,4) var Character_Limit: int
@export var Multiplier_Amount: float

@export_category("Defeat parameters")
@export var Current_Scene: PackedScene

var player_defeated: bool = false
var victory_triggered: bool = false

func _ready() -> void:
	if Character_Limit < 1:
		Character_Limit = 1
	Globalcharactercheck.Next_Scene = Next_Scene
	if Current_Scene == null:
		Current_Scene = load("%s" %owner.scene_file_path)
	Globalcharactercheck.Current_Scene = Current_Scene 
	menu_path = level_menus(current_level_range)
	

func _process(_delta):
	if get_tree().get_nodes_in_group("enemies").is_empty() and !victory_triggered:
		victory_triggered = true
		for i in get_tree().get_nodes_in_group("CharDetails"):
			i.hide()
		get_tree().paused = true
		SceneTransition.transition_dissolve("in")
		add_child(victory_scene.instantiate())
		SceneTransition.transition_dissolve("out")
	
	elif get_tree().get_nodes_in_group("player").is_empty():
		player_defeated = true
		set_process(false)
		SceneTransition.transition_dissolve("in")
		add_child(defeat_scene.instantiate())
		SceneTransition.transition_dissolve("out")
	
func level_menus(my_level):
	var level_menu_path
	match my_level:
		1:
			level_menu_path = "res://Scenes and Scripts/Battle of San Juan/level_select1.tscn"
		2:
			level_menu_path = "res://Scenes and Scripts/Battle of San Juan/level_select1.tscn"
		3:
			level_menu_path = "res://Scenes and Scripts/Battle of San Juan/level_select1.tscn"
	return level_menu_path
