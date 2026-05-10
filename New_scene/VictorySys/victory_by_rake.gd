extends CanvasLayer

@onready var victoryLabel: Label = $ColorRect2/VBoxContainer/Victory_Label

@onready var andres: Panel = $ColorRect2/VBoxContainer/Icons/Andres
@onready var emilio: Panel = $ColorRect2/VBoxContainer/Icons/Emilio
@onready var gregoria: Panel = $ColorRect2/VBoxContainer/Icons/Gregoria
@onready var apolinario: Panel = $ColorRect2/VBoxContainer/Icons/Apolinario
@onready var anim: AnimationPlayer = $anim

@export_category("Dev Mode")
@export var Rake_Mode: bool = Globalcharactercheck.Rake_Mode

@export_category("Victory Screen Stats")
@export_range(1, 4) var Character_Limit: int 
@export var Multiplier_Amount: float = 0.2


var shown = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Rake_Mode:
		anim.play("Initialization")
	else:
		_Rake_mode()

	victoryLabel.text = "Pick %d Character%s to add Morale" % [Character_Limit, "s" if Character_Limit != 1 else ""]
	pass # Replace with function body.


func _show_icons():
	if !Rake_Mode:
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
	else:
		andres.show()
		apolinario.show()
		emilio.show()
		gregoria.show()
		shown = true
	pass

func _anim_done(_anim_name: StringName) -> void:
	if not shown:
		_show_icons()
	pass # Replace with function body.

func _Rake_mode() -> void:
	Character_Limit = 4
	_anim_done("Initialization")
