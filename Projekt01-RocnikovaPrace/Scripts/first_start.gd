extends Control

var _text = ""

onready var accept = $CanvasLayer/Button

func _ready():
	check_fist_start()
	$"/root/PostProcessing".change_brightness(Saved.saved_data["settings"]["video"]["brightness"])
	$CanvasLayer/NameLineEdit.text = Saved.saved_data["player"]["player_name"]

func _physics_process(_delta):
	if $CanvasLayer/NameLineEdit.text.empty(): accept.disabled = true
	if not $CanvasLayer/NameLineEdit.text.empty(): accept.disabled = false

func check_fist_start():
	if not Saved.saved_data["settings"]["first_start"]:
		get_tree().change_scene("res://MainMenu/MainMenu.tscn")

func _on_NameLineEdit_text_changed(new_text):
	Saved.saved_data["player"]["player_name"] = new_text
	Saved.save_game()

func _on_Button_pressed():
	Saved.saved_data["settings"]["first_start"] = false
	
	$"/root/Sounds".get_node("Confirm").play()
	yield(get_tree().create_timer(0.05), "timeout")
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")

func check_language_from_file():
	if Saved.saved_data["settings"]["other"]["language"] == "cs":
		TranslationServer.set_locale("cs")
	elif Saved.saved_data["settings"]["other"]["language"] == "en":
		TranslationServer.set_locale("en")
