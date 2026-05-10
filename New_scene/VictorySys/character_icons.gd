extends Panel

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }
@export var Character_Names: names = names.NONE

@onready var icons: Panel = $Icons
@onready var Stats_Container: Panel = $"Pop-up/Stats Container"
@onready var Pop_up: CanvasLayer = $"Pop-up"
signal moral_menu_opened

var button_pressed = false

var max_health: float = 0.0
var atk_dmg: float = 0.0
var atk_spd: float = 0.0
var multiplier: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_receive_stats()
	self.hide()
	Stats_Container.hide()
	Pop_up.hide()

	for i in get_parent().get_child_count():
		get_parent().get_child(i).connect("moral_menu_opened",Callable(self,"_other_menu_opened"))

	for i in icons.get_child_count():
		icons.get_child(i).hide()
	icons.get_child(Character_Names-1).show()

	_current_stats()
	_multiplied_stats()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _open_moral_menu() -> void:
	Pop_up.show()
	if button_pressed:
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
	if button_pressed:
		button_pressed = false
		Stats_Container.hide()
		Pop_up.hide()


func _pop_down() -> void:
	button_pressed = false
	Stats_Container.hide()
	Pop_up.hide()
	pass # Replace with function body.


@onready var Name = $"Pop-up/Stats Container/VBoxContainer/Name"

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

var new_MRL: float
var new_DMG: float
var new_SPD: float
var new_HP: float


func _multiplied_stats() -> void:
	var HP_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer/Hp_Value"
	var DMG_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer2/Dmg_Value"
	var MRL_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer3/Morale_Value"
	var SPD_Value = $"Pop-up/Stats Container/VBoxContainer/HBoxContainer/After_stats/HBoxContainer4/Spd_Value"

	var tempMRL= get_parent().get_parent().get_parent().get_parent().Multiplier_Amount
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
		max_health,
		atk_dmg,
		atk_spd,
		multiplier
	)
