extends Node2D

var current_wave = 0
var num_of_enemies = 1

var snowman1 = preload("res://Snowman/Snowman.tscn")

onready var game = $".."

var spawn_wave = false

func _ready():
	randomize()

func _physics_process(delta):
	if not game.intro_is_visible:
		if get_tree().get_nodes_in_group("Enemy").size() == 0 and not spawn_wave:
			spawn_wave = true

			if $"../CanvasLayer/FireMeter".value < 75: $"../CanvasLayer/FireMeter".value = 80
			else: $"../CanvasLayer/FireMeter".value += 15

			current_wave += 1
			print("wave: ", current_wave)

			if current_wave <= 10:
				$"../SnowParticles".amount = 1000 * current_wave
				print($"../SnowParticles".amount)


			if Saved.saved_data["game"]["high_score"] < current_wave:
				Saved.saved_data["game"]["high_score"] = current_wave

			var romanNumeral = int_to_roman(current_wave)

			$"../CanvasLayer/WaveText".bbcode_text = str("[center]",romanNumeral,"[/center]")
			$"../CanvasLayer/AnimationPlayer".play("show_wave")

			Sounds.get_node("Wave porazena").play()

			$TimerBetweenWaves.start()

func int_to_roman(number: int) -> String:
	var romanNumerals = {
		1000: "M",
		900: "CM",
		500: "D",
		400: "CD",
		100: "C",
		90: "XC",
		50: "L",
		40: "XL",
		10: "X",
		9: "IX",
		5: "V",
		4: "IV",
		1: "I"
	}

	var romanResult = ""
	var remaining = number

	var keys = romanNumerals.keys()
	keys.sort()

	keys = keys.duplicate()
	keys.invert()

	var i = 0
	var key_count = keys.size()

	while remaining > 0 and i < key_count:
		var value = keys[i]
		var numeral = romanNumerals[value]

		while remaining >= value:
			romanResult += numeral
			remaining -= value

		i += 1

	return romanResult




func spawn_enemies(num):
	print("spawning ",num," enemies")
	for i in range(num):
		var enemy = snowman1.instance()
		get_parent().get_node("YSort").add_child(enemy)
		var rect_num = randi() % 4 + 1
		var rect = get_parent().get_node(str("SpawnRect",str(rect_num)))
		enemy.position = rect.rect_position + Vector2(randf() * rect.rect_size.x, randf() * rect.rect_size.y)


func _on_TimerBetweenWaves_timeout():
	spawn_enemies(current_wave + randi() % current_wave + 1)
	spawn_wave = false
