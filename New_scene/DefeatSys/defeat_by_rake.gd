extends CanvasLayer

@onready var Button_SFX: AudioStreamPlayer2D = $buttonSfx
@export var Current_Scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func button_sfx(value: int) -> void:
	match value:
		0:
			Button_SFX.pitch_scale = 1.0
			Button_SFX.play()
		1:
			Button_SFX.pitch_scale = 1.6
			Button_SFX.play()
		2:
			Button_SFX.pitch_scale = 0.8
			Button_SFX.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_retry_pressed() -> void:
	Current_Scene = Globalcharactercheck.Current_Scene
	button_sfx(2)
	SceneTransition.packed_scene(Current_Scene)
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	button_sfx(0)
	SceneTransition.change_scene(get_parent().menu_path)
	pass # Replace with function body.
