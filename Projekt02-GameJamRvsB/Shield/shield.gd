extends KinematicBody2D

func _physics_process(_delta):
	if Input.is_action_pressed("right_mouse"):
		$"../../../CustomCursor".change_cursor("shield")
		visible = true
		$CollisionShape2D.disabled = false
		global_position = get_global_mouse_position()+Vector2(10,40)
	if Input.is_action_just_pressed("right_mouse"):
		Sounds.get_node("Shield up").play()

	elif Input.is_action_just_released("right_mouse"):
		$"../../../CustomCursor".change_cursor("normal")
		visible = false
		$CollisionShape2D.disabled = true
		Sounds.get_node("Shield down").play()
