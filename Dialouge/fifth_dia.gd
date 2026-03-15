extends Node2D

@onready var characters: Node2D = %Characters
@onready var dialog_ui: Control = %DialogUi

var dialog_index: int = 0

const dialog_lines : Array[String] = [
	"Narrator: (Inside a Cavite estate. Aguinaldo, Bonifacio, and Katipuneros gather around a map spread across a wooden table.)",
	"Aguinaldo: This is where we strike. The Spaniards will expect us to face them head-on, but we will use the riverbanks and the estate walls. Surprise is our weapon.",
	"Bonifacio: “Your plan is sound. Cavite knows its land better than any soldier from Madrid. Let us turn their arrogance into their downfall.”",
	"Katipunero: “The Guardia Civil march at dawn. They are confident, but they do not know we wait.”",
]

# CHANGE THIS TO YOUR NEXT SCENE
@export var next_scene: PackedScene

func _ready():
	dialog_index = 0
	process_current_line()

func _input(event):
	if event.is_action_pressed("click"):
		if dialog_ui.anim_text:  # Text is still animating
			dialog_ui.skip_text_animation()
		else:
			advance_dialog()

func advance_dialog():
	if dialog_index < dialog_lines.size() - 1:
		dialog_index += 1
		process_current_line()
	else:
		change_to_next_scene()


func change_to_next_scene():
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
	else:
		# Fallback if not set in editor
		await get_tree().create_timer(1.0).timeout
		SceneTransition.change_scene("res://Dialouge/sixth_dia.tscn")

func _on_dialog_ui_text_finished():
	if dialog_index >= dialog_lines.size() - 1:
		change_to_next_scene()

func parse_line(line: String):
	var parts = line.split(":", true, 1)  # Split only on first ":"
	if parts.size() < 2:
		return {"speaker_name": "Narrator", "dialog_line": line.strip_edges()}
	return {
		"speaker_name": parts[0].strip_edges(),
		"dialog_line": parts[1].strip_edges()
	}

func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info = parse_line(line)
	dialog_ui.change_line(line_info["speaker_name"], line_info["dialog_line"])
	characters.change_character(line_info["speaker_name"])
