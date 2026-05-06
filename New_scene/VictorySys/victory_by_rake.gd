extends CanvasLayer

@onready var andres: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Andres
@onready var emilio: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Emilio
@onready var gregoria: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Gregoria
@onready var apolinario: Panel = $ColorRect2/VBoxContainer/HBoxContainer/Apolinario


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globalcharactercheck.alivecharacters["Andrés Bonifacio"]:
		andres.show()
	if Globalcharactercheck.alivecharacters["Emilio Aguinaldo"]:
		emilio.show()
	if Globalcharactercheck.alivecharacters["Gregoria De Jesús"]:
		gregoria.show()
	if Globalcharactercheck.alivecharacters["Apolinario Mabini"]:
		apolinario.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
