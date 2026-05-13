extends Panel

signal moral_menu_opened

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }
@export var Character_Names: names = names.NONE

@onready var icons: Panel = $Icons
@onready var Stats_Container: Panel = $"Pop-up/Stats Container"
@onready var Pop_up: CanvasLayer = $"Pop-up"

@onready var Select_Button = $"Pop-up/Stats Container/VBoxContainer/Selected"
@onready var Victory_scene = get_parent().get_parent().get_parent().get_parent()

@onready var Name = $"Pop-up/Stats Container/VBoxContainer/Name"

var button_pressed = false

var max_health: float = 0.0
var atk_dmg: float = 0.0
var atk_spd: float = 0.0
var multiplier: float = 1.0

var new_MRL: float
var new_DMG: float
var new_SPD: float
var new_HP: float

var limit: int = 0

var selected: bool = false

var Accepting_Input: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Select_Button.self_modulate = "#24d17ae4"
	_receive_stats()
	self.hide()
	Stats_Container.hide()
	Pop_up.hide()

	for i in get_parent().get_child_count():
		if get_parent().get_child(i) != self:
			get_parent().get_child(i).connect("moral_menu_opened",Callable(self,"_other_menu_opened"))

	for i in icons.get_child_count():
		icons.get_child(i).hide()
	icons.get_child(Character_Names-1).show()

	_current_stats()
	_multiplied_stats()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if selected and Victory_scene.Submitted:
		_on_Submit_pressed()
	pass


func _open_moral_menu() -> void:
	Pop_up.show()
	Victory_scene.button_sfx(0)
	if button_pressed:
		Victory_scene.button_sfx(1)
		button_pressed = false
		Stats_Container.hide()
		Pop_up.hide()
		return
	moral_menu_opened.emit()
	Stats_Container.position = self.position + Vector2(-self.size.x*0.3, self.size.y/2)
	button_pressed = true
	Stats_Container.show()
	pass # Replace with function body.

func _other_menu_opened() -> void:
	if Victory_scene.Selected_Characters == limit and not selected:
		self.visible = false
		
	if button_pressed:
		button_pressed = false
		Stats_Container.hide()
		Pop_up.hide()
		

func _current_stats() -> void:
	Name.text = Globalcharactercheck.CHARACTERNAMES[Character_Names]
	
	var HP_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/Current_stats/HBoxContainer/Hp_Value"
	var DMG_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/Current_stats/HBoxContainer2/Dmg_Value"
	var MRL_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/Current_stats/HBoxContainer3/Morale_Value"
	var SPD_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/Current_stats/HBoxContainer4/Spd_Value"

	if Character_Names == 4:
		$"Pop-up/Stats Container/VBoxContainer/HBoxContainer/Current_stats/HBoxContainer2/Dmglabel".text = "Heal amt :"
		$"Pop-up/Stats Container/VBoxContainer/HBoxContainer/Current_stats/HBoxContainer4/Spdlabel".text = "Heal cd :"

	DMG_Value.text = "%.2f" % atk_dmg
	SPD_Value.text = "%.2f" % atk_spd
	HP_Value.text = "%.2f" % max_health
	MRL_Value.text = "%.2f" % multiplier


func _multiplied_stats() -> void:
	var HP_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer/Hp_Value"
	var DMG_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer2/Dmg_Value"
	var MRL_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer3/Morale_Value"
	var SPD_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer4/Spd_Value"

	var tempMRL = Victory_scene.get_parent().Multiplier_Amount
	new_MRL = multiplier + tempMRL

	new_DMG = atk_dmg + (atk_dmg * tempMRL)
	new_SPD = atk_spd - (atk_spd * tempMRL)
	new_HP = max_health + (max_health * tempMRL)

	DMG_Value.text = "%.2f" % new_DMG
	SPD_Value.text = "%.2f" % new_SPD
	HP_Value.text = "%.2f" % new_HP
	MRL_Value.text = "%.2f" % new_MRL

func _receive_stats():
	var thisname = Globalcharactercheck.CHARACTERNAMES[Character_Names]
	Globalcharactercheck.Character_Stats = Globalcharactercheck.load_stats(Globalcharactercheck.savefilepath)
	if Globalcharactercheck.Character_Stats.has(thisname):
		print("received %s" % thisname)
		print(Globalcharactercheck.Character_Stats[thisname])
		max_health = Globalcharactercheck.Character_Stats[thisname]["Max_Health"]
		atk_dmg = Globalcharactercheck.Character_Stats[thisname]["Damage"]
		atk_spd = Globalcharactercheck.Character_Stats[thisname]["Atk_Speed"]
		multiplier = Globalcharactercheck.Character_Stats[thisname]["Multiplier"]

func _on_Submit_pressed() -> void:
	Globalcharactercheck._updatestats(
		Name.text,
		new_HP,
		new_DMG,
		new_SPD,
		new_MRL
	)

func _on_selected_pressed() -> void:
	if selected:
		Victory_scene.button_sfx(1)
		Select_Button.text = "Select"
		Select_Button.self_modulate = "#24d17ae4"
		selected = false
		Victory_scene.Selected_Characters -= 1
		return
	Victory_scene.button_sfx(0)
	selected = true
	Select_Button.self_modulate = "#d12441e4"
	Select_Button.text = "Cancel"
	Victory_scene.Selected_Characters += 1
	emit_signal("moral_menu_opened")
	if Victory_scene.Selected_Characters == limit:
		Character_selected()
	pass # Replace with function body.

func _reset_self() -> void:
	Victory_scene.victoryLabel.text = Victory_scene._default_title()
	button_pressed = false
	selected = false 
	Select_Button.text = "Select"
	Select_Button.self_modulate = "#24d17ae4"
	Select_Button.visible = true
	Pop_up.hide()
	for i in get_parent().get_child_count():
		get_parent().get_child(i).Select_Button.visible = true

func Character_selected() -> void:
	for i in get_parent().get_child_count():
		get_parent().get_child(i).Select_Button.visible = false
	button_pressed = false
	
	Pop_up.hide()
	Victory_scene.victoryLabel.text = "Character%s has been selected" % ["s" if Victory_scene.Selected_Characters != 1 else ""]