extends Panel

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }
@onready var icons: Panel = $Icons

@export var Character_Names: names = names.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	
	for i in icons.get_child_count():
		icons.get_child(i).hide()
	icons.get_child(Character_Names-1).show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
