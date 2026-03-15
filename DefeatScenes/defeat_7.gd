extends Node

@onready var button_sfx: AudioStreamPlayer2D = $buttonSfx

func _on_retry_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/bridge2.tscn")

func _on_exit_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/level_select_3.tscn")
