extends Node

const MASTER_BUS = 0
const MUSIC_BUS = 1
const SFX_BUS = 2

func _ready():
	check_for_audio_settings()

func check_for_audio_settings():
	var master_volume = Saved.saved_data["settings"]["audio"]["master"]
	var music_volume = Saved.saved_data["settings"]["audio"]["music"]
	var sfx_volume = Saved.saved_data["settings"]["audio"]["sfx"]

	$MasterHSlider.value = master_volume
	$MusicHSlider.value = music_volume
	$SFXHSlider.value = sfx_volume

	AudioServer.set_bus_volume_db(MASTER_BUS, master_volume)
	AudioServer.set_bus_volume_db(MUSIC_BUS, music_volume)
	AudioServer.set_bus_volume_db(SFX_BUS, sfx_volume)

func _on_MasterHSlider_value_changed(value):
	Saved.saved_data["settings"]["audio"]["master"] = value
	AudioServer.set_bus_volume_db(MASTER_BUS, value)
	Saved.save_game()
	$"/root/Sounds".get_node("Slider").play()

func _on_MusicHSlider_value_changed(value):
	Saved.saved_data["settings"]["audio"]["music"] = value
	AudioServer.set_bus_volume_db(MUSIC_BUS, value)
	Saved.save_game()
	$"/root/Sounds".get_node("Slider").play()

func _on_SFXHSlider_value_changed(value):
	Saved.saved_data["settings"]["audio"]["sfx"] = value
	AudioServer.set_bus_volume_db(SFX_BUS, value)
	Saved.save_game()
	$"/root/Sounds".get_node("Slider").play()
