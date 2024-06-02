extends Area2D

var open_door = false

func _physics_process(delta):
	if open_door: $Door.position.x = lerp($Door.position.x, 711, delta * 5)
	else: $Door.position.x = lerp($Door.position.x, 846, delta * 5)

func _on_Doors_body_entered(body):
	if body.is_in_group("NPC") or body.is_in_group("Tutorial-NPC"):
		$EntranceBell.play()
		open_door = true

func _on_Doors_body_exited(_body):
	open_door = false
