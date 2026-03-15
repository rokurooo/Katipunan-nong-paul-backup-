extends Node

@onready var button_sfx: AudioStreamPlayer2D = $buttonSfx

func _ready() -> void:
	get_tree().paused = false 
	 
func _on_resume_pressed() -> void:
	button_sfx.play()
	get_tree().paused = false
	$ColorRect.hide()

func _on_pause_pressed() -> void:
	button_sfx.play()
	get_tree().paused = true
	$ColorRect.show()

func _on_back_pressed() -> void:
	button_sfx.play()
	get_tree().paused = false
	SceneTransition.change_scene("res://Scenes and Scripts/level_select_2.tscn")
