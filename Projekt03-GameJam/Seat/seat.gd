extends Area2D

var seat_is_already_taken = false

func _on_Seat_body_entered(body):
	if body.is_in_group("NPC"):
		body.wait_time_timer.start()
		body.can_see_request = true
	if body.is_in_group("Tutorial-NPC"):
		body.can_see_request = true

func _on_Seat_body_exited(_body):
	seat_is_already_taken = false
