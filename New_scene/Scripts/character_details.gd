@tool
extends CanvasLayer

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }

@export var Character_Names: names = names.NONE

@onready var icon1: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/1"
@onready var icon2: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/2"
@onready var icon3: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/3"
@onready var icon4: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/4"

@onready var CharnameArray: Array = [
	"null",
	"Emilio Aguinaldo",
	"Andrés Bonifacio",
	"Gregoria de Jesús",
	"Apolinario Mabini"
	]

var atk_dmg: float = 0.0
var heal_amt: float = 0.0
var max_health: float = 0.0
var atk_spd: float = 0.0
var heal_spd: float = 0.0
var multiplier: float = 0.0

@onready var Cur_parent: CharacterBody2D = get_parent()
@onready var Char_name: Label = $ColorRect/HBoxContainer/Main_Details/Name

func Char_update() -> void:
	Char_name.text = CharnameArray[Character_Names] 
	atk_dmg = Cur_parent.attack_damage
	max_health = Cur_parent.max_health
	atk_spd = Cur_parent.attack_cooldown
	heal_spd = Cur_parent.max_health
	multiplier = Cur_parent.max_health

	match Character_Names:
		1:
			icon1.show()
		2:
			icon2.show()
		3:
			icon3.show()
		4:
			icon4.show()
			heal_amt = Cur_parent.max_health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Char_update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
