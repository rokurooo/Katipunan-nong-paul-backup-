extends Panel

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }
@export var Character_Names: names = names.NONE

@onready var icons: Panel = $Icons
@onready var Stats_Container: Panel = $"Pop-up/Stats Container"
signal moral_menu_opened

var button_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	Stats_Container.hide()

	for i in get_parent().get_child_count():
		get_parent().get_child(i).connect("moral_menu_opened",Callable(self,"_other_menu_opened"))

	for i in icons.get_child_count():
		icons.get_child(i).hide()
	icons.get_child(Character_Names-1).show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _open_moral_menu() -> void:
	if button_pressed:
		button_pressed = false
		Stats_Container.hide()
		return
	moral_menu_opened.emit()
	Stats_Container.position = self.position + Vector2(-self.get_size().x/2, self.get_size().y/2)
	button_pressed = true
	Stats_Container.show()
	pass # Replace with function body.

func _other_menu_opened() -> void:
	print("other menu opened")
	if button_pressed:
		button_pressed = false
		Stats_Container.hide()
