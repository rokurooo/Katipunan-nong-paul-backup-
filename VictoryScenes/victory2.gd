extends Node

func _on_exit_pressed() -> void:
	SceneTransition.change_scene("res://Scenes and Scripts/level_select1.tscn")

func _on_continue_pressed() -> void:
	SceneTransition.change_scene("res://Dialouge/fourth_dia.tscn")
