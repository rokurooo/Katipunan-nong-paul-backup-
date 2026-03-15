extends Node
@onready var button_sfx: AudioStreamPlayer2D = $CanvasLayer/buttonSfx

func _on_exit_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/level_select_2.tscn")

func _on_continue_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Dialouge/seventh_dia.tscn")
