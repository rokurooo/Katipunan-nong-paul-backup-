extends Control

@onready var mainbuttons: VBoxContainer = $Mainbuttons
@onready var options: Panel = $Options
@onready var button_sfx: AudioStreamPlayer2D = $buttonSfx

var button_type = null

func _ready():
	mainbuttons.visible = true
	options.visible = false
	
func _on_start_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Dialouge/first_dia.tscn")

func _on_option_pressed() -> void:
	button_sfx.play()
	mainbuttons.visible = false
	options.visible = true

func _on_exit_pressed() -> void:
	button_sfx.play()
	get_tree().quit()

func _on_back_pressed() -> void:
	button_sfx.play()
	_ready()

func _on_levels_pressed() -> void:
	button_sfx.play()
	SceneTransition.change_scene("res://Scenes and Scripts/level_select1.tscn")
	
