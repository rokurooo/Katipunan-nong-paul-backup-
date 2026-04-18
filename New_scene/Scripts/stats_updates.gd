@tool
extends Node

@onready var charparent = get_parent()
@onready var chardets = get_parent().get_node("Panel")

@onready var max_health = charparent.max_health
@onready var atk_dmg = charparent.attack_damage
@onready var atk_spd = charparent.attack_cooldown
@onready var multiplier = chardets.multiplier

@onready var NAME = Globalcharactercheck.CHARACTERNAMES[chardets.Character_Names]

func _send_stats():
	if Globalcharactercheck.Character_Stats[NAME]["Multiplier"] == multiplier:
		return
	
#	update
	Globalcharactercheck._updatestats(NAME,max_health,atk_dmg,atk_spd,multiplier)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
