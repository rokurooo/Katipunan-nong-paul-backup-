extends Node

var SAVE_DIR = DirAccess.open("user://")
const savefilepath = "user://save_data/rake_characters.save"

var Rake_Mode: bool = false

var CHARACTERNAMES: Array = [
	"null",
	"Emilio Aguinaldo",
	"Andrés Bonifacio",
	"Gregoria De Jesús",
	"Apolinario Mabini"
	]
	
var Character_Stats = {
	"Rake": {
		"Max_Health":100,
		"Damage": 25, #also use this for healing character - R
		"Atk_Speed": 1,
		"Multiplier": 1
		}
}

var alivecharacters = {
	"Emilio Aguinaldo": false,
	"Andrés Bonifacio": false,
	"Gregoria De Jesús": false,
	"Apolinario Mabini": false
}


#to check if the character is alive or dead
#use the checking of names under get_nodes_in_group("Re_characters")
func _updatestats(N,H,D,S,M):
	Character_Stats[N] = {
		"Max_Health": H,
		"Damage": D,
		"Atk_Speed": S,
		"Multiplier": M
	}
	print("updated %s" % N)
	print(Character_Stats[N])
	save_stats(savefilepath,Character_Stats)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SAVE_DIR.dir_exists("user://save_data"):
		SAVE_DIR.make_dir("user://save_data")

	var charstats = get_tree().get_nodes_in_group("Re_characters")
	for i in charstats:
		i.charstatus.connect(_updatestats)
	if Rake_Mode:
		_on_Rake_Mode()
	pass # Replace with function body.


func save_stats(path: String, data: Dictionary):
	var json_string = JSON.stringify(data, "\t")
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	if file:
		# 3. Store the string in the file
		file.store_string(json_string)
		print("saved")
		file.close()
		# File automatically closes when the variable goes out of scope in Godot 4
	else:
		print("Failed to open file: ", FileAccess.get_open_error())

func load_stats(path: String):
	if not FileAccess.file_exists(path):
		return {}

	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	
	# Convert the string back into a Dictionary
	var data = JSON.parse_string(content)
	
	if data is Dictionary:
		return data
	return {}

func _on_Rake_Mode() -> void:
	Rake_Mode = true
	for i in alivecharacters.keys():
		alivecharacters[i] = true
