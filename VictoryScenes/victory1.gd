extends Node
@onready var button_sfx: AudioStreamPlayer2D = $buttonSfx

func _on_continue_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Dialouge/third_dia.tscn")
	
func _on_exit_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/level_select1.tscn")
