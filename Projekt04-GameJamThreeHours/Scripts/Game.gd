extends Node2D

var score = 0

func _ready():
	$Score.text = str("Score: ", score)

func _on_KillZone_body_entered(body):
	score -= 1
	if score < 0:
		get_tree().reload_current_scene()
	body.queue_free()

func _on_Confirm_btn_pressed():
	score += 1
	$click.play()
	$win.play()
	$Score.text = str("Score: ", score)
	$Weigh.start()
	if $"Box spawn".spawn_rate != 1:
		$"Box spawn".spawn_rate -= 1

	var boxes = get_tree().get_nodes_in_group("Box")
	for box in boxes:
		box.queue_free()
	
	$explotion.emitting = true
	yield(get_tree().create_timer(5), "timeout")
	$explotion.emitting = false

func _physics_process(delta):
	if $theme.playing == false:
		$theme.play()

func _on_pause_btn_pressed():
	get_tree().paused = true
	$Pause.is_paused = true
