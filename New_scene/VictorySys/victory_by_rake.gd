extends CanvasLayer

@onready var andres: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Andres
@onready var emilio: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Emilio
@onready var gregoria: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Gregoria
@onready var apolinario: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Apolinario


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var shown = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $anim.animation_finished and not shown:
		await get_tree().create_timer(1).timeout
		_show_icons()
	pass


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
