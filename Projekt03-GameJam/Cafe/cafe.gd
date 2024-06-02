extends Node2D

onready var npc_spawn_time = $NPC_spawn_time
var npc = load("res://NPC/NPC.tscn")

var min_spawn_time = 7
var max_spawn_time = 13

onready var one_second_timer = $UI/OneSecondTimer

onready var time_left_label = $UI/TimeLeft
var time_left = 300

onready var money_label = $UI/Money
var money = 0
var best_money = 0

var tutorial_over = false
var tutorial_already_over = false

onready var tutorial_text = $UI/Tutorial_npc
onready var tutorial_npc = $Navigation2D/YSort/Tutorial_NPC

func _ready():
	if tutorial_already_over:
		tutorial_over = true
	if tutorial_over:
		one_second_timer.start()
		npc_spawn_time.start()
		$Navigation2D/YSort/Tutorial_NPC.queue_free()

		var y = npc.instance()
		get_node("Navigation2D").get_node("YSort").add_child(y)
		y.position = Vector2(838, -162)

func _physics_process(_delta):
	if time_left <= 0:
		$MainMenu/PlayTextureButton/PlayLB.text = "Start"
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Cafe/Cafe.tscn")
		time_left = 300

	time_left_label.text = "Time left: " + str(time_left) + "s"
	money_label.text = "Money: " + str(money) + "$"

	if not tutorial_over:
		$UI/Tutorial_npc.show()
	if tutorial_over:
		$UI/Tutorial_npc.hide()

	if Input.is_action_just_pressed("to_main_menu"):
		$MainMenu/PlayTextureButton/PlayLB.text = "Continue"
		$MainMenu.show()
		$MainMenu.game_is_stopped = true

	if best_money < money:
		best_money = money

	$MainMenu/YourBestScore.text = str(best_money) + "$"

func _on_NPC_spawn_time_timeout():
	if get_tree().get_nodes_in_group("NPC").size() < 8 and tutorial_over:
		randomize()
		var spawn_time_num = randi()%min_spawn_time+max_spawn_time
		$NPC_spawn_time.wait_time = spawn_time_num

		var y = npc.instance()
		get_node("Navigation2D").get_node("YSort").add_child(y)
		y.position = Vector2(838, -162)

func _on_OneSecondTimer_timeout():
	time_left -= 1
	one_second_timer.start()

func _on_ExitPoint_body_entered(body):
	if body.is_in_group("Tutorial-NPC"):
		tutorial_over = true
		tutorial_already_over = true
		one_second_timer.start()
		npc_spawn_time.start()
	body.queue_free()

func _on_PayPoint_body_entered(body):
	if body.is_in_group("NPC"):
		money += 3
		$Pay.play()
		body.path = body.exit_point
		body.navigation_agent.set_target_location(body.path.global_position)
		$PayPoint/MoneyParticles2D.emitting = true

	if body.is_in_group("Tutorial-NPC"):
		body.path = body.exit_point
		body.navigation_agent.set_target_location(body.path.global_position)

func _on_Piano_finished():
	$Piano.play()
