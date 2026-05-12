extends CanvasLayer

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }


@export var Character_Names: names = names.NONE

@onready var icons: Panel = $ColorRect/HBoxContainer/Border/Icons
@onready var CharnameArray: Array = [
	"null",
	"Emilio Aguinaldo",
	"Andrés Bonifacio",
	"Gregoria De Jesús",
	"Apolinario Mabini"
	]

var char_class = [
	"Tank",
	"Warrior",
	"Gunner",
	"Healer"
]

var max_health: float = 0.0
var atk_dmg: float = 0.0
var atk_spd: float = 0.0
var multiplier: float = 1.0


@onready var Cur_parent = get_parent()
@onready var Char_name: Label = $ColorRect/HBoxContainer/Main_Details/Name
@onready var max_hp: Label = $ColorRect/HBoxContainer/Ability_details/HBoxContainer/MaxHP
@onready var dmg: Label = $ColorRect/HBoxContainer/Ability_details/HBoxContainer2/Dmg
@onready var morale: Label = $ColorRect/HBoxContainer/Ability_details/HBoxContainer3/morale
@onready var spd: Label = $ColorRect/HBoxContainer/Ability_details/HBoxContainer4/Spd
@onready var real_time_hp: ProgressBar = $ColorRect/HBoxContainer/Main_Details/RealTimeHP
@onready var ClassName: Label = $ColorRect/HBoxContainer/Main_Details/HBoxContainer/ClassName
@onready var dmglabel: Label = $ColorRect/HBoxContainer/Ability_details/HBoxContainer2/Dmglabel
@onready var spdlabel: Label = $ColorRect/HBoxContainer/Ability_details/HBoxContainer4/Spdlabel

@onready var thisname = Globalcharactercheck.CHARACTERNAMES[Character_Names]

func Char_update() -> void:
	Cur_parent.curhealth.connect(_health_update)
	Char_name.text = Globalcharactercheck.CHARACTERNAMES[Character_Names]
	ClassName.text = char_class[Character_Names-1]
	
	max_health = Cur_parent.max_health
	real_time_hp.max_value = max_health
	real_time_hp.value = max_health
	
	max_hp.text = "%.2f" % max_health
	
	if Character_Names != 4:
		atk_dmg = Cur_parent.attack_damage
		atk_spd = Cur_parent.attack_cooldown
	else:
		atk_dmg = Cur_parent.heal_amount
		atk_spd = Cur_parent.heal_cooldown
		dmglabel.text = "Heal Amt"
		spdlabel.text = "Heal CD"
	dmg.text = "%.2f" % atk_dmg
	
	spd.text = "%.2f" % atk_spd
	
	multiplier = Cur_parent.multiplier
	morale.text = "%.2f" % multiplier
	
	for i in icons.get_child_count():
		icons.get_child(i).hide()
	icons.get_child(Character_Names-1).show()
	
	Globalcharactercheck._updatestats(
		Char_name.text,
		max_health,
		atk_dmg,
		atk_spd,
		multiplier
	)

func _active(me):
	match me:
		true:	self.show()
		false:	self.hide()

func _receive_stats():
	
	Globalcharactercheck.Character_Stats = Globalcharactercheck.load_stats(Globalcharactercheck.savefilepath)
	if Globalcharactercheck.Character_Stats.has(thisname):
		print("received %s" % thisname)
		print(Globalcharactercheck.Character_Stats[thisname])
		max_health = Globalcharactercheck.Character_Stats[thisname]["Max_Health"]
		atk_dmg = Globalcharactercheck.Character_Stats[thisname]["Damage"]
		atk_spd = Globalcharactercheck.Character_Stats[thisname]["Atk_Speed"]
		multiplier = Globalcharactercheck.Character_Stats[thisname]["Multiplier"]
	#print(NAME + ":")
	#print(Globalcharactercheck.Character_Stats[NAME])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	_receive_stats()
	Cur_parent.ui.connect(_active)
	Char_update()
	Globalcharactercheck.alivecharacters[thisname] = true
	
	
func _health_update(h):
	real_time_hp.value = h

