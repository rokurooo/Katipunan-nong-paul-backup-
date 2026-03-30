@tool
extends CanvasLayer

enum names { NONE, Emilio, Andres, Gregoria, Apolinario }

@export var Character_Names: names = names.NONE

@onready var icon1: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/1"
@onready var icon2: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/2"
@onready var icon3: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/3"
@onready var icon4: AnimatedSprite2D = $"ColorRect/HBoxContainer/Border/Icons/4"

@onready var Charname: Array = [
	"null",
	"Emilio Aguinaldo",
	"Andrés C. Bonifacio",
	"Gregoria de Jesús",
	"Apolinario Mabini"
	]
git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

func Char_update() -> void:
	match Character_Names:
		1:
			icon1.show()
		2:
			icon2.show()
		3:
			icon3.show()
		4:
			icon4.show()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Char_update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
