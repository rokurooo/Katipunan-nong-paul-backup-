@tool
extends CanvasLayer

@onready var victoryLabel: Label = $ColorRect2/VBoxContainer/Victory_Label

@onready var andres: Panel = $ColorRect2/VBoxContainer/Icons/Andres
@onready var emilio: Panel = $ColorRect2/VBoxContainer/Icons/Emilio
@onready var gregoria: Panel = $ColorRect2/VBoxContainer/Icons/Gregoria
@onready var apolinario: Panel = $ColorRect2/VBoxContainer/Icons/Apolinario
@onready var anim: AnimationPlayer = $anim
@onready var Character_container: HBoxContainer = $ColorRect2/VBoxContainer/Icons

@onready var Button_SFX: AudioStreamPlayer2D = $buttonSfx

@export_category("Dev Mode")
@export var Rake_Mode: bool = false:
	set(value):
		Rake_Mode = value
		Globalcharactercheck.Rake_Mode = value

@export_category("Victory Screen Stats")
@export_range(0, 4) var Character_Limit: int 
@export var Multiplier_Amount: float = 0.2
@export var Next_Scene: PackedScene


var Selected_Characters: int = 0

var shown = false

func _Rake_mode() -> void:
	_anim_done("Initialization")
	$BgSfx.stop() 


func _default_title() -> String:
	return "Pick %s Character%s to add Morale" % [str(Character_Limit) if Character_Limit < 4 else "all", "s" if Character_Limit != 1 else ""]

func _ready() -> void:
	if !Rake_Mode:
		$BgSfx.play()
		anim.play("Initialization")
	else:
		_Rake_mode()
	
	Character_Limit = get_parent().Character_Limit
	Multiplier_Amount = get_parent().Multiplier_Amount
	for i in Character_container.get_child_count():
		Character_container.get_child(i).limit = Character_Limit

	victoryLabel.text = _default_title()

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


func button_sfx(value: int) -> void:
	match value:
		0:
			Button_SFX.pitch_scale = 1.0
			Button_SFX.play()
		1:
			Button_SFX.pitch_scale = 1.6
			Button_SFX.play()
		2:
			Button_SFX.pitch_scale = 0.8
			Button_SFX.play()


var Submitted: bool = false

func _on_next_level() -> void:
	button_sfx(0)
	if Selected_Characters != Character_Limit:
		for i in 2:
			victoryLabel.modulate = "#ff2b50"
			await get_tree().create_timer(0.2).timeout
			victoryLabel.modulate = "#ffffff"
			await get_tree().create_timer(0.2).timeout
		return
	Next_Scene = Globalcharactercheck.Next_Scene
	get_tree().paused = false
	Submitted = true
	await get_tree().create_timer(2).timeout
	SceneTransition.packed_scene(Next_Scene)
	pass # Replace with function body.

func _on_reset() -> void:
	Selected_Characters = 0
	_show_icons()
	for i in Character_container.get_child_count():
		Character_container.get_child(i)._reset_self()
	button_sfx(2)
	pass # Replace with function body.
