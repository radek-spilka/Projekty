extends Node

var saved_data = {}
const SAVEGAME = "user://Savegame.json"

const CURRENT_GAME_VERSION = "0.3"

func _ready():
	saved_data = get_data()
	check_save_data_version()

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
	if saved_data.has("version") and saved_data["version"] == CURRENT_GAME_VERSION:
		print("funguje")
	else: create_default_save_file()

func create_default_save_file():
	saved_data = {
		"version":CURRENT_GAME_VERSION,
		"player":{
			"player_name": "",
			"player_color": "000000"
			},
		"settings":{
			"video":{
				"vsync":true,
				"show_fps":true,
				"fullscreen":false,
				"post-processing":true,
				"brightness":10
				},
			"audio":{
				"master":0,
				"music":-12,
				"sfx":-12
				},
			"other":{
				"language":"cs", #en, cs
				"developer_mode":false
				},
			"first_start":true
			}
		}
	save_game()















