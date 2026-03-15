extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const CHARACTER = {
	"Bonifacio": preload("res://PNG tres/Andres_png.tres"),
	"Aguinaldo": preload("res://PNG tres/Aguinaldo_png.tres"),
	"Mabini": preload("res://PNG tres/Mabini_png.tres"),
	"Gregoria de Jesus": preload("res://PNG tres/Gregoria_png.tres"),
	"Narrator": preload("res://PNG tres/Rizal_png.tres"),
	"Katipunero": null,
	"Teniente" : null
}

func change_character(character_name : String ):
	sprite_2d.texture = CHARACTER[character_name]
	
	
