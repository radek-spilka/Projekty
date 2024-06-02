extends Node2D

var all_group_members
var clostest_enemy

onready var fire = $YSort/Fire
onready var target = $Target

onready var fire_shadow = $YSort/Fire.get_node("FireShadow")
onready var fire_light = $Light2D

onready var BS_info_price = $Shop/BS_price
onready var FR_info_price = $Shop/FR_price
onready var FDS_info_price = $Shop/FDS_price
onready var HP_info_price = $Shop/HP_price

onready var BS_info = $Shop/BS_price/BS_info
onready var FR_info = $Shop/FR_price/FR_info
onready var FDS_info = $Shop/FDS_price/FDS_info
onready var HP_info = $Shop/HP_price/HP_info

onready var BS_info_cost = $Shop/BS_price/BS_info/Cost
onready var FR_info_cost = $Shop/FR_price/FR_info/Cost
onready var FDS_info_cost = $Shop/FDS_price/FDS_info/Cost
onready var HP_info_cost = $Shop/HP_price/HP_info/Cost

onready var wave_system = $WaveSystem

var player_choose_target = false

var time_between_shots = 2.5
var fire_decrease_speed = 0.03
var bullet_speed = 1.5

var cursor_is_hovering = false
var cursor_is_holding = false

var intro_is_visible = true

var game_over = false

var x = false

func _ready():
	all_group_members = get_tree().get_nodes_in_group("Enemy")
	clostest_enemy = all_group_members[0]

func _physics_process(delta):
	if game_over:
		if not x:
			Sounds.get_node("rada umrel").play()
			x = true
		all_group_members = get_tree().get_nodes_in_group("Enemy")
		for i in range(all_group_members.size()):
			all_group_members[i].queue_free()

		$Intro/Camera2D.global_position = lerp($Intro/Camera2D.global_position, Vector2(959, 404), 0.05)
		$Intro/Camera2D.zoom = lerp($Intro/Camera2D.zoom, Vector2(0.5, 0.5), 0.05)

		$GameOver.visible = true
		$GameOver/Text.text = str("Game over! \n\n Wave: ", wave_system.int_to_roman(wave_system.current_wave), "\n Best try: Wave:", wave_system.int_to_roman(Saved.saved_data["game"]["high_score"]))

		if Input.is_action_just_pressed("restart"): get_tree().reload_current_scene()

	if not intro_is_visible and not game_over:
		if get_tree().get_nodes_in_group("Enemy").size() > 0 and not player_choose_target:
			target.visible = false
			all_group_members = get_tree().get_nodes_in_group("Enemy")
			clostest_enemy = all_group_members[0]
			for i in range(all_group_members.size()):
				if clostest_enemy.global_position < fire.global_position:
					clostest_enemy = all_group_members[i]

		if player_choose_target:
			target.global_position.x = clostest_enemy.global_position.x
			target.global_position.y = clostest_enemy.global_position.y - 225



		BS_info_cost.text = str("[Cost: ", BS_info_price.text, "]")
		FR_info_cost.text = str("[Cost: ", FR_info_price.text, "]")
		FDS_info_cost.text = str("[Cost: ", FDS_info_price.text, "]")
		HP_info_cost.text = str("[Cost: ", HP_info_price.text, "]")

	scale_fireshadow()
	scale_firelight()

	$Debug.text = str("Bullet speed: ", bullet_speed, "\n Time between shots: ", time_between_shots, "\n Fire decrease speed: ", fire_decrease_speed)

	if $CanvasLayer/FireMeter.value == 0:
		game_over = true
		intro_is_visible = true

	if Input.is_action_just_pressed("Q"): _increase_BS()
	if Input.is_action_just_pressed("W"): _increase_FR()
	if Input.is_action_just_pressed("E"): _decrease_FDS()
	if Input.is_action_just_pressed("R"): _increase_HP()

func set_new_target(snowman):
	clostest_enemy = snowman
	target.visible = true
	target.global_position = clostest_enemy.global_position

func scale_fireshadow():
	fire_shadow.scale = Vector2($CanvasLayer/FireMeter.value/10,$CanvasLayer/FireMeter.value/10 )

func scale_firelight():
	fire_light.texture_scale = $CanvasLayer/FireMeter.value/20

func _on_CanShootArea_body_entered(body):
	if body.is_in_group("Enemy"):
		body.can_shoot = true

func _on_BulletSpeed_pressed():
	_increase_BS()

func _increase_BS():
	if int($CanvasLayer/CoinsText.text) >= int(BS_info_price.text):
		$CanvasLayer/CoinsText.text = str(int($CanvasLayer/CoinsText.text)-int(BS_info_price.text))
		BS_info_price.text = str(int(BS_info_price.text)+1)
		bullet_speed += 0.5
		Sounds.get_node("Upgrade").play()


func _on_FireRate_pressed():
	_increase_FR()

func _increase_FR():
	if int($CanvasLayer/CoinsText.text) >= int(FR_info_price.text) and not time_between_shots < 0.20:
		$CanvasLayer/CoinsText.text = str(int($CanvasLayer/CoinsText.text)-int(FR_info_price.text))
		FR_info_price.text = str(int(FR_info_price.text)+1)
		time_between_shots -= 0.20
		Sounds.get_node("Upgrade").play()

func _on_FireDecreaseSpeed_pressed():
	_decrease_FDS()

func _decrease_FDS():
	if int($CanvasLayer/CoinsText.text) >= int(FDS_info_price.text) and not fire_decrease_speed < 0.005:
		$CanvasLayer/CoinsText.text = str(int($CanvasLayer/CoinsText.text)-int(FDS_info_price.text))
		FDS_info_price.text = str(int(FDS_info_price.text)+1)
		fire_decrease_speed -= 0.0005
		Sounds.get_node("Upgrade").play()

func _on_FireHp_pressed():
	_increase_HP()

func _increase_HP():
	if int($CanvasLayer/CoinsText.text) >= int(HP_info_price.text):
		$CanvasLayer/CoinsText.text = str(int($CanvasLayer/CoinsText.text)-int(HP_info_price.text))
		HP_info_price.text = str(int(HP_info_price.text)+1)
		$CanvasLayer/FireMeter.value += 15
		Sounds.get_node("Upgrade").play()


func _on_BulletSpeed_mouse_entered():
	BS_info.visible = true

func _on_BulletSpeed_mouse_exited():
	BS_info.visible = false

func _on_FireRate_mouse_entered():
	FR_info.visible = true

func _on_FireRate_mouse_exited():
	FR_info.visible = false

func _on_FireDecreaseSpeed_mouse_entered():
	FDS_info.visible = true

func _on_FireDecreaseSpeed_mouse_exited():
	FDS_info.visible = false

func _on_FireHp_mouse_entered():
	HP_info.visible = true

func _on_FireHp_mouse_exited():
	HP_info.visible = false
