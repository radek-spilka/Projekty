extends Node2D

var normal = preload("res://Mouse/Default-export.png")
var ready_to_hold = preload("res://Mouse/ReadyToHold-export.png")
var holding = preload("res://Mouse/Holding-export.png")

var shield = preload("res://pixel1x1.png")

func change_cursor(type):
	if type == "shield":
		Input.set_custom_mouse_cursor(shield, Input.CURSOR_ARROW)
	elif type == "normal":
		Input.set_custom_mouse_cursor(normal, Input.CURSOR_ARROW, Vector2(16,16))
	elif type == "ready_to_hold":
		Input.set_custom_mouse_cursor(ready_to_hold, Input.CURSOR_ARROW, Vector2(16,16))
	elif type == "holding":
		Input.set_custom_mouse_cursor(holding, Input.CURSOR_ARROW, Vector2(16,16))
