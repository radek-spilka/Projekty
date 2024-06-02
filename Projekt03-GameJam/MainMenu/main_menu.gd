extends CanvasLayer

var game_is_stopped = true

func _physics_process(_delta):
	get_tree().paused = game_is_stopped

func _on_PlayTextureButton_pressed():
	$MenuClick.play()
	hide()
	game_is_stopped = false

func _on_ResetTextureButton_pressed():
	$MenuClick.play()
	yield(get_tree().create_timer(.5), "timeout")
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Cafe/Cafe.tscn")
	$PlayTextureButton/PlayLB.text = "Start"
	
