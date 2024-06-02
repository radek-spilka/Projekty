extends Label

onready var cze_normal = load("res://Language/Flags/Cze.png")
onready var cze_checked = load("res://Language/Flags/CzeChecked.png")

onready var en_normal = load("res://Language/Flags/En.png")
onready var en_checked = load("res://Language/Flags/EnChecked.png")

func _ready():
	if Saved.saved_data["settings"]["other"]["language"] == "cs":
		cze_is_checked()
	elif Saved.saved_data["settings"]["other"]["language"] == "en":
		en_is_checked()

func _on_CzechTextureButton_pressed():
	cze_is_checked()
	Saved.saved_data["settings"]["other"]["language"] = "cs"
	Saved.save_game()
	$"/root/Sounds".get_node("Language").play()

func _on_EnglishTextureButton_pressed():
	en_is_checked()
	Saved.saved_data["settings"]["other"]["language"] = "en"
	Saved.save_game()
	$"/root/Sounds".get_node("Language").play()

func cze_is_checked():
	TranslationServer.set_locale("cs")
	$"../CzechTextureButton".texture_normal = cze_checked
	$"../EnglishTextureButton".texture_normal = en_normal

func en_is_checked():
	TranslationServer.set_locale("en")
	$"../CzechTextureButton".texture_normal = cze_normal
	$"../EnglishTextureButton".texture_normal = en_checked
