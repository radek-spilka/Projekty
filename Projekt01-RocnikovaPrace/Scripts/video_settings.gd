extends Node

func _ready():
	check_for_video_settings()
	apply_video_settings()

func check_for_video_settings():
	$Vsync.pressed = Saved.saved_data["settings"]["video"]["vsync"]
	$Fullscreen.pressed = Saved.saved_data["settings"]["video"]["fullscreen"]
	$ShowFPS.pressed = Saved.saved_data["settings"]["video"]["show_fps"]
	$PostProcessing.pressed = Saved.saved_data["settings"]["video"]["post-processing"]
	$BrightnessHSlider.value = Saved.saved_data["settings"]["video"]["brightness"]

func apply_video_settings():
	OS.set_use_vsync($Vsync.pressed)
	OS.set_window_fullscreen($Fullscreen.pressed)
	get_tree().call_group("show_fps", "hide_or_show", Saved.saved_data["settings"]["video"]["show_fps"])
	#post-processing

func _on_Vsync_pressed():
	Saved.saved_data["settings"]["video"]["vsync"] = $Vsync.pressed
	Saved.save_game()
	apply_video_settings()
	$"/root/Sounds".get_node("Switch").play()

func _on_Fullscreen_pressed():
	Saved.saved_data["settings"]["video"]["fullscreen"] = $Fullscreen.pressed
	Saved.save_game()
	apply_video_settings()
	$"/root/Sounds".get_node("Switch").play()

func _on_ShowFPS_pressed():
	Saved.saved_data["settings"]["video"]["show_fps"] = $ShowFPS.pressed
	Saved.save_game()
	apply_video_settings()
	$"/root/Sounds".get_node("Switch").play()

func _on_PostProcessing_pressed():
	Saved.saved_data["settings"]["video"]["post-processing"] = $PostProcessing.pressed
	Saved.save_game()
	apply_video_settings()
	$"/root/PostProcessing".check_for_post_processing()
	$"/root/PostProcessing".change_brightness(Saved.saved_data["settings"]["video"]["brightness"])
	$"/root/Sounds".get_node("Switch").play()

func _on_BrightnessHSlider_value_changed(value):
	Saved.saved_data["settings"]["video"]["brightness"] = value
	Saved.save_game()
	apply_video_settings()
	$"/root/PostProcessing".change_brightness(value)
	$"/root/Sounds".get_node("Slider").play()


