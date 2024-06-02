extends Position2D

onready var box = load("res://Scenes/Box.tscn")

var spawn_rate = 4

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	var x = box.instance()
	x.set_position(position)
	add_child(x)

	if spawn_rate != 0:
		spawn_rate -= get_parent().get_node(".").score


	$Timer.wait_time = spawn_rate
	$Timer.start()
