extends Control
@onready var dialog_line: RichTextLabel = %DialogLine
@onready var speaker_name: Label = %SpeakerName

const ANIM_SPEED : int = 30
var anim_text: bool = false
var current_visible_characters : int = 0

func _process(delta: float) -> void:
	if anim_text:
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0/dialog_line.text.length()) * (ANIM_SPEED * delta)
			current_visible_characters = dialog_line.visible_characters
		else:
			anim_text = false

func change_line(speaker: String,line: String):
	speaker_name.text = speaker
	current_visible_characters = 0
	dialog_line.text = line
	dialog_line.visible_characters = 0
	anim_text = true
	
func skip_text_animation():
	dialog_line.visible_ratio = 1
