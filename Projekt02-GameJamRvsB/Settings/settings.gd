extends Node2D

onready var SETTINGS = $SETTINGS

onready var game = $".."

func _ready():
	$SETTINGS/Debug.pressed = Saved.saved_data["game"]["debug"]
	$"../Debug".visible = Saved.saved_data["game"]["debug"]

	$SETTINGS/Fullscreen.pressed = Saved.saved_data["game"]["fullscreen"]
	OS.window_fullscreen = Saved.saved_data["game"]["fullscreen"]

	$SETTINGS/ProMode.pressed = Saved.saved_data["game"]["pro_mode"]
	$"../Keybindings".visible = Saved.saved_data["game"]["pro_mode"]

func _physics_process(delta):
	if SETTINGS.visible:
		get_tree().paused = true
	if not SETTINGS.visible:
		get_tree().paused = false

	if Input.is_action_just_pressed("esc") and is_equal_approx($"../Intro/Camera2D".zoom.x, 1) and $".".visible:
		Sounds.get_node("Button_click").play()
		SETTINGS.visible = not SETTINGS.visible


func _on_SettingsButton_pressed():
	SETTINGS.visible = not SETTINGS.visible
	Sounds.get_node("Button_click").play()


func _on_ProMode_pressed():
	$"../Keybindings".visible = $SETTINGS/ProMode.pressed
	Saved.saved_data["game"]["pro_mode"] = $"../Keybindings".visible
	Saved.save_game()
	Sounds.get_node("Button_click").play()

func _on_Fullscreen_pressed():
	OS.window_fullscreen = $SETTINGS/Fullscreen.pressed
	Saved.saved_data["game"]["fullscreen"] = $SETTINGS/Fullscreen.pressed
	Saved.save_game()
	Sounds.get_node("Button_click").play()

func _on_Debug_pressed():
	$"../Debug".visible = $SETTINGS/Debug.pressed
	Saved.saved_data["game"]["debug"] = $"../Debug".visible
	Saved.save_game()
	Sounds.get_node("Button_click").play()

func _on_Button_pressed():
	get_tree().quit()


func _on_BackButton_pressed():
	SETTINGS.visible = false
	Sounds.get_node("Button_click").play()
