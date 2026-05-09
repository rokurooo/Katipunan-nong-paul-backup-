extends CanvasLayer

@onready var andres: Panel = $ColorRect2/VBoxContainer/Icons/Andres
@onready var emilio: Panel = $ColorRect2/VBoxContainer/Icons/Emilio
@onready var gregoria: Panel = $ColorRect2/VBoxContainer/Icons/Gregoria
@onready var apolinario: Panel = $ColorRect2/VBoxContainer/Icons/Apolinario
@onready var icons: HBoxContainer = $ColorRect2/VBoxContainer/Icons
var shown = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _show_icons():
	await get_tree().create_timer(0.5).timeout
	if Globalcharactercheck.alivecharacters["Andrés Bonifacio"]:
		andres.show()
	await get_tree().create_timer(0.5).timeout
	if Globalcharactercheck.alivecharacters["Apolinario Mabini"]:
		apolinario.show()
	await get_tree().create_timer(0.5).timeout
	if Globalcharactercheck.alivecharacters["Emilio Aguinaldo"]:
		emilio.show()
	await get_tree().create_timer(0.5).timeout
	if Globalcharactercheck.alivecharacters["Gregoria De Jesús"]:
		gregoria.show()
	shown = true
	pass


func _anim_done(_anim_name: StringName) -> void:
	if not shown:
		_show_icons()
	pass # Replace with function body.
