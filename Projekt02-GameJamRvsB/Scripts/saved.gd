extends Node

var saved_data = {}
const SAVEGAME = "user://Savegame.json"

func _ready():
	saved_data = get_data()

func get_data():
	var file = File.new()
	if not file.file_exists(SAVEGAME):
		create_default_save_file()
	file.open(SAVEGAME, File.READ)
	var content = file.get_as_text()
	var data = parse_json(content)
	saved_data = data
	file.close()
	return(data)

func save_game():
	var save_game = File.new()
	save_game.open(SAVEGAME, File.WRITE)
	save_game.store_line(to_json(saved_data))

func check_save_data_version():
	create_default_save_file()

func create_default_save_file():
	saved_data = {
		"game":{
			"high_score": 0,
			"pro_mode": true,
			"fullscreen": false,
			"debug": false,
			"volume":0
			}
		}
	save_game()















