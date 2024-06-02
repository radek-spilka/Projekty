extends Node

#time of day: day/night
#weather: sunny/rain/thunderstorm
#boxes: spawn/respawn/destroy
#reset level

onready var day = $"../CanvasLayer/Day"
onready var night_1 = $"../CanvasLayer/Night_1"
onready var sunny = $"../CanvasLayer/Sunny"
onready var rain = $"../CanvasLayer/Rain"
onready var thunderstorm = $"../CanvasLayer/Thunderstorm"

onready var rain_particles = $"../Rain"

onready var thunder = $"../CanvasLayer/Lightning"

onready var vsechno = [
	day,
	night_1,
	sunny,
	rain,
	thunderstorm
]

func _ready():
	for i in range(vsechno.size()):
		vsechno[i].hide()
	rain_particles.emitting = false
	thunder.hide()
	day.show()

func _on_time_Day_pressed():
	for i in range(vsechno.size()):
		if vsechno[i] == day:
			vsechno[i].show()
		else:
			vsechno[i].hide()
	$Timer.stop()
	rain_particles.emitting = false

func _on_time_Night_pressed():
	for i in range(vsechno.size()):
		if vsechno[i] == night_1:
			vsechno[i].show()
		else:
			vsechno[i].hide()
	$Timer.stop()
	rain_particles.emitting = false

func _on_weather_Sunny_pressed():
	for i in range(vsechno.size()):
		if vsechno[i] == sunny:
			vsechno[i].show()
		else:
			vsechno[i].hide()
	$Timer.stop()
	rain_particles.emitting = false

func _on_weather_Rain_pressed():
	for i in range(vsechno.size()):
		if vsechno[i] == rain:
			vsechno[i].show()
		else:
			vsechno[i].hide()
	$Timer.stop()
	rain_particles.emitting = true

func _on_weather_Thunderstorm_pressed():
	for i in range(vsechno.size()):
		if vsechno[i] == thunderstorm:
			vsechno[i].show()
		else:
			vsechno[i].hide()
	rain_particles.emitting = true
	$Timer.start()

func _on_Box_spawn_pressed():
	rpc("spawn_box")

func _on_Box_respawn_pressed():
	rpc("kill_box")
	rpc("spawn_box")

func _on_Box_destroy_pressed():
	rpc("kill_box")

sync func spawn_box():
	var my_scene = load("res://Box/Box.tscn")
	var box1 = my_scene.instance()
	var box2 = my_scene.instance()
	var box3 = my_scene.instance()
	box1.global_position = Vector2(848, 648)
	box2.global_position = Vector2(1341, 679)
	box3.global_position = Vector2(168, 636)
	add_child(box1)
	add_child(box2)
	add_child(box3)

sync func kill_box():
	get_tree().call_group("Kickable", "destroy_box")

func _on_Timer_timeout():
	var thunder_pos = randi() % (1776 - 152 + 1) + 152 #152 - 1776
	thunder.position.x = thunder_pos
	thunder.show()
	yield(get_tree().create_timer(.15), "timeout")
	thunder.hide()
	$Timer.start()
