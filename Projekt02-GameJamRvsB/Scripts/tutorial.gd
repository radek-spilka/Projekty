extends Node2D

onready var game = $".."

var x = false

func _physics_process(delta):
	if not game.intro_is_visible and not x:
		$".".visible = true
		x = true
		yield(get_tree().create_timer(13), "timeout")
		$Text3.visible = true
		yield(get_tree().create_timer(4), "timeout")
		$".".visible = false
