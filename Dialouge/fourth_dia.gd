extends Node2D

@onready var characters: Node2D = %Characters
@onready var dialog_ui: Control = %DialogUi

var dialog_index: int = 0

const dialog_lines : Array[String] = [
	"Narrator :(Days later. Bonifacio rallies his men at Santa Mesa. The sound of Spanish troops marching grows louder.)",
	"Bonifacio : “Hold the line! For the Katipunan, for our freedom! Do not falter!”",
	"Narrator:(Gunfire erupts. The Katipuneros fall one by one. Mabini shouts over the chaos.)",
	"Mabini: “We are being overrun! Retreat, Andres! Save who you can!”",
	"Bonifacio : “No! We cannot retreat — not now!” (But as his men are slaughtered, he realizes the truth. He grips his bolo tightly, then lowers it.) “…Pasig River. Fall back! Live to fight another day!”",
	"Narrator :(The Katipuneros retreat, battered and broken. The Spanish stand victorious, their casualties few. Bonifacio watches, grief-stricken, as the revolution’s first great defeat unfolds.)"
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
		SceneTransition.change_scene("res://Scenes and Scripts/level_select_2.tscn")

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
