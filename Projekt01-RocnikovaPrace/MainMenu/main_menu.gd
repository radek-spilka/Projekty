extends Control

onready var name_LINE_EDIT = $ParallaxBackground/Menu/NameLineEdit
onready var host_BUTTON = $ParallaxBackground/Menu/MainMenu/HostButton
onready var join_BUTTON = $ParallaxBackground/Menu/MainMenu/JoinButton
onready var join_LINE_EDIT = $ParallaxBackground/Menu/JoinLobby/JoinLineEdit

onready var JOIN_LOBBY = $ParallaxBackground/Menu/JoinLobby
onready var MAINMENU = $ParallaxBackground/Menu/MainMenu
onready var LOBBY = $ParallaxBackground/Menu/Lobby
onready var VIDEO_SETTINGS = $ParallaxBackground/Menu/VideoSettings
onready var AUDIO_SETTINGS = $ParallaxBackground/Menu/AudioSettings
onready var OTHER_SETTINGS = $ParallaxBackground/Menu/OtherSettings

var join_text = "127.0.0.1-7777"

var rng = RandomNumberGenerator.new()

var _port
var _adress

func _ready():
	print(IP.get_local_addresses())

	any_key_language()

	join_LINE_EDIT.text = "127.0.0.1-7777"
	rng.randomize()
	load_player_name_to_line_edit()

	MAINMENU.show()
	JOIN_LOBBY.hide()
	LOBBY.hide()
	VIDEO_SETTINGS.hide()
	AUDIO_SETTINGS.hide()
	OTHER_SETTINGS.hide()

func _on_HostButton_pressed():
	_port = rng.randi_range(7001, 7999)
	Network.port = _port

	Network.create_server()

	$"/root/Sounds".get_node("Click").play()

func _on_JoinButton_pressed():
	MAINMENU.hide()
	JOIN_LOBBY.show()
	$"/root/Sounds".get_node("Click").play()

func _on_JoinButton_to_game_pressed():
	if ":" in join_text: _port = join_text.substr(join_text.find(":")+1)
	if "-" in join_text: _port = join_text.substr(join_text.find("-")+1)
	if "_" in join_text: _port = join_text.substr(join_text.find("_")+1)
	if "/" in join_text: _port = join_text.substr(join_text.find("/")+1)
	_adress = join_text

	_adress.erase(_adress.length() - 5, 5)

	Network.port = int(_port)
	Network.ip_adress = str(_adress)

	Network.connect_to_server()

func load_player_name_to_line_edit():
	name_LINE_EDIT.text = Saved.saved_data["player"]["player_name"]

func _on_NameLineEdit_text_changed(new_text):
	Saved.saved_data["player"]["player_name"] = new_text
	Saved.save_game()

func _on_StartButton_pressed():
	rpc("to_training_hall")

sync func to_training_hall():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://TrainingHall/TrainingHall.tscn")

func _on_BackJoinLobbyButton_pressed():
	MAINMENU.show()
	JOIN_LOBBY.hide()
	$"/root/Sounds".get_node("Click").play()

func _on_BackLobbyButton_pressed():
	MAINMENU.show()
	LOBBY.hide()
	$"/root/Sounds".get_node("Click").play()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_JoinLineEdit_text_changed(new_text):
	join_text = new_text


func _on_VideoButton_pressed():
	MAINMENU.hide()
	VIDEO_SETTINGS.show()
	$"/root/Sounds".get_node("Click").play()
func _on_BackVideoButton_pressed():
	MAINMENU.show()
	VIDEO_SETTINGS.hide()
	$"/root/Sounds".get_node("Click").play()

func _on_AudioButton_pressed():
	MAINMENU.hide()
	AUDIO_SETTINGS.show()
	$"/root/Sounds".get_node("Click").play()
func _on_BackAudioButton_pressed():
	MAINMENU.show()
	AUDIO_SETTINGS.hide()
	$"/root/Sounds".get_node("Click").play()

func _on_OtherButton_pressed():
	MAINMENU.hide()
	OTHER_SETTINGS.show()
	$"/root/Sounds".get_node("Click").play()
func _on_BackOtherButton_pressed():
	MAINMENU.show()
	OTHER_SETTINGS.hide()
	$"/root/Sounds".get_node("Click").play()

func any_key_language():
	if Saved.saved_data["settings"]["other"]["language"] == "en":
		$ParallaxBackground/ParallaxLayer6/PressAnyKey.bbcode_text = "[wave amp=50 freq=5][center]Press any key to continue...[/center][/wave]"
	elif Saved.saved_data["settings"]["other"]["language"] == "cs":
		$ParallaxBackground/ParallaxLayer6/PressAnyKey.bbcode_text = "[wave amp=50 freq=5][center]Stiskněte libovolnou klávesu pro pokračování…[/center][/wave]" 
