extends Node

func _ready():
	check_for_other_settings()
	apply_other_settings()

func check_for_other_settings():
	$DeveloperModeCheck.pressed = Saved.saved_data["settings"]["other"]["developer_mode"]

func apply_other_settings():
	if $DeveloperModeCheck.pressed:
		Debug.can_show_debug = true
	if not $DeveloperModeCheck.pressed:
		Debug.can_show_debug = false

func _on_ChangeNameButton_pressed():
	Saved.saved_data["settings"]["first_start"] = true
	Saved.save_game()
	$"/root/Sounds".get_node("Click").play()
	yield(get_tree().create_timer(.05), "timeout")
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://FirstStart/FirstStart.tscn")
	

func _on_DeveloperModeCheck_pressed():
	Saved.saved_data["settings"]["other"]["developer_mode"] = $DeveloperModeCheck.pressed
	Saved.save_game()
	apply_other_settings()
	$"/root/Sounds".get_node("Switch").play()
