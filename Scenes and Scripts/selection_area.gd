extends Area2D

signal selection_toggled(selection)

@export var exclusive = true
@export var selection_action = "click"

var selected: bool= false: set = set_selected

func set_selected(selection):
	if selection:
		_make_exclusive()
		add_to_group("selected")
	else:
		remove_from_group("selected")
	selected = selection
	emit_signal("selection_toggled", selected)
	
func _make_exclusive():
	if not exclusive:
		return
	get_tree().call_group("selected", "set_selected", false)
	pass

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed(selection_action):
		set_selected(not selected)
