extends Node2D

@onready var button_sfx: AudioStreamPlayer2D = $buttonSfx	

func _on_level_1_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/Battle of San Juan (Map 1)/Levels/main.tscn")

func _on_level_2_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/Battle of San Juan (Map 1)/Levels/lvl_2.tscn")

func _on_level_3_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/Battle of San Juan (Map 1)/Levels/lvl_3.tscn")

func _on_back_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/menu.tscn")

func _on_next_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/level_select_2.tscn")
