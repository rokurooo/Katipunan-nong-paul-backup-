extends Panel

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }
@onready var icons: Panel = $Icons

@export var Character_Names: names = names.NONE

@onready var Stats_Container: Panel = $"CanvasLayer/Stats Container"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	Stats_Container.hide()

	for i in icons.get_child_count():
		icons.get_child(i).hide()
	icons.get_child(Character_Names-1).show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

var button_pressed = false
func _open_moral_menu() -> void:
	if button_pressed:
		button_pressed = false
		Stats_Container.hide()
		return
	Stats_Container.position = self.position
	button_pressed = true
	Stats_Container.show()
	pass # Replace with function body.


# IcloudAccount#1
