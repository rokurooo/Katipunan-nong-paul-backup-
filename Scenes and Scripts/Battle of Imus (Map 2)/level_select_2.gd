extends Node2D

@onready var button_sfx: AudioStreamPlayer2D = $buttonSfx

func _on_level_1_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/Battle of Imus (Map 2)/Levels/river_banks.tscn")

func _on_level_2_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/Battle of Imus (Map 2)/Levels/cavity.tscn")

func _on_level_3_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/Battle of Imus (Map 2)/Levels/cavity_2.tscn")


func _on_back_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/menu.tscn")


func _on_previous_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/level_select1.tscn")


func _on_next_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/level_select_3.tscn")
