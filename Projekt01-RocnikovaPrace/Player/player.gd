extends KinematicBody2D

const UP_DIRECTION = Vector2.UP

var gravity = 1
const GRAVITY = 2350

# ----------------------- Movement -----------------------
var horizontal_dir = 0
var velocity = Vector2.ZERO
export var move_speed = 415
export var acceleration = 12.5
export var deccelaration = 10

var ignore_input = true

# ----------------------- Jumping -----------------------
var can_jump = false
export var jump_strength = 750
var hang_time = 1
const HANG_TIME = 0.075

# ----------------------- Rotation -----------------------
var rotate_speed = 15
onready var pivot = $PlayerSkin
var is_looking_right

# ----------------------- Animation -----------------------
var state_machine
var animation_tree
var what_animation_to_play = ""
var play_different_animation = false

# ----------------------- Attack -----------------------
var can_attack_again = true
var can_deal_damage = false
var push_to_what_side = null
var damaged_player = null
var is_kicking = false
var can_enter_punch_zone = true

# ----------------------- Networking -----------------------
sync var players = {}
var player_data = {
	"global_position":null, 
	"is_looking_right":false, 
	"what_animation_to_play":"",
	"play_different_animation":false,
	"can_deal_damage":false
	}

func _ready():
	animation_tree = $PlayerSkin/AnimationTree
	state_machine = animation_tree.get("parameters/playback")

	players[name] = player_data
	players[name].global_position = global_position

	set_nametag_as_name()

	yield(get_tree().create_timer(2.5), "timeout")

	ignore_input = false

func _physics_process(delta):
	if is_local_Player():
		modulate = Saved.saved_data["player"]["player_color"]

		movement(delta)

		handle_animations()

		update_server(name, global_position, is_looking_right, what_animation_to_play, play_different_animation, can_deal_damage)

		kick_check()

	if not is_local_Player():
		global_position = players[name].global_position
		is_looking_right = players[name].is_looking_right
		what_animation_to_play = players[name].what_animation_to_play
		play_different_animation = players[name].play_different_animation
		can_deal_damage = players[name].can_deal_damage

		state_machine.travel(what_animation_to_play)

	handle_rotation(delta)

	damage_check()

	set_punch01_col_position()
	set_kick01_col_position()

	get_node("/root/Debug").get_node("Player_data").text = "Player_data = " + str(players)

func update_server(player_id, player_global_position, player_looking_right, player_what_animation_to_play, player_play_different_animation, player_can_deal_damage):
	if not is_network_master():
		rpc_unreliable_id(1, "manage_clients", player_id, player_global_position, player_looking_right, player_what_animation_to_play, player_play_different_animation, player_can_deal_damage)
	elif is_network_master():
		manage_clients(player_id, player_global_position, player_looking_right, player_what_animation_to_play, play_different_animation, player_can_deal_damage)

sync func manage_clients(player_id, player_global_position, player_looking_right, player_what_animation_to_play, player_play_different_animation, player_can_deal_damage):
	players[player_id].global_position = player_global_position
	players[player_id].is_looking_right = player_looking_right
	players[player_id].what_animation_to_play = player_what_animation_to_play
	players[player_id].play_different_animation = player_play_different_animation
	players[player_id].can_deal_damage = player_can_deal_damage
	rset("players", players)

func is_local_Player():
	return name == str(Network.local_player_id)

#--------------------------------------------------------------------------

func movement(delta):
	if not play_different_animation:
		pressed_jump()
		set_rotation_()

	jump_check(delta)

	set_gravity(delta)
	set_velocity()

	get_input(delta)

func pressed_jump():
	if can_jump and Input.is_action_just_pressed("jump"):
		jump()
	if Input.is_action_just_released("jump"): velocity.y /= 1.5

func handle_animations():
	if not play_different_animation:
		if not is_on_ground():
			if velocity.y < 0: what_animation_to_play = "JumpingLoop"
			elif velocity.y > 0: what_animation_to_play = "FallingLoop"
		elif abs(horizontal_dir) <= 0.25: what_animation_to_play = "Idling"
		elif abs(horizontal_dir) > 0.25: what_animation_to_play = "Running"

	state_machine.travel(what_animation_to_play)

func handle_rotation(delta):
	if is_looking_right: pivot.scale.x = lerp(pivot.scale.x, 1, delta * rotate_speed)
	if not is_looking_right: pivot.scale.x = lerp(pivot.scale.x, -1, delta * rotate_speed)

func jump_check(delta):
	if is_on_ground():
		hang_time = HANG_TIME
		can_jump = true
	if not is_on_ground() and hang_time > 0:
		hang_time -= delta
	elif hang_time < 0:
		can_jump = false

func damage_check():
	if play_different_animation and can_deal_damage and can_enter_punch_zone:
		rpc("deal_damage", damaged_player, push_to_what_side)
		push_back(push_to_what_side)
		can_deal_damage = false
		can_enter_punch_zone = false
		yield(get_tree().create_timer(.5), "timeout")
		can_enter_punch_zone = true

func jump():
	velocity.y = 0
	velocity.y -= jump_strength
	can_jump = false
	yield(get_tree().create_timer(.05), "timeout")
	can_jump = false

func is_on_ground():
	if $GroundCheck.is_colliding() or $GroundCheck2.is_colliding():
		return true
	else: return false

func set_gravity(delta):
	if not is_on_ground():
		velocity.y += gravity * delta
	if velocity.y < 0:
		gravity = GRAVITY
	if velocity.y > 0:
		gravity = GRAVITY * 2.25

func set_rotation_():
	if not ignore_input:
		if Input.get_action_raw_strength("gamepad_move_right") > 0.20 or Input.is_action_pressed("keyboard_move_right"): is_looking_right = true
		if Input.get_action_raw_strength("gamepad_move_left") > 0.20 or Input.is_action_pressed("keyboard_move_left"): is_looking_right = false

func set_velocity():
	if not play_different_animation:
		velocity.x = horizontal_dir * move_speed
	velocity = move_and_slide(velocity, UP_DIRECTION, true)

func get_input(delta):
	if not ignore_input:
		if Input.is_action_just_pressed("punch") and can_attack_again:
			punch01()

		if Input.is_action_just_pressed("kick") and can_attack_again:
			kick01()

		if Input.is_action_pressed("keyboard_move_left") or Input.get_action_raw_strength("gamepad_move_left") > .25:
			horizontal_dir = lerp(horizontal_dir, -1, delta * acceleration)
		elif Input.is_action_pressed("keyboard_move_right") or Input.get_action_raw_strength("gamepad_move_right") > .25:
			horizontal_dir = lerp(horizontal_dir, 1, delta * acceleration)
		else:
			horizontal_dir = lerp(horizontal_dir, 0, delta * deccelaration)

#--------------------------------------------------------------------------

func punch01():
	play_different_animation = true
	can_attack_again = false
	what_animation_to_play = "Punch01"
	velocity.x /= 1.35

	if is_looking_right:
		yield(get_tree().create_timer(.10), "timeout")
		velocity.x = 1000
		yield(get_tree().create_timer(.075), "timeout")
		velocity.x = 0
	else:
		yield(get_tree().create_timer(.10), "timeout")
		velocity.x = -1000
		yield(get_tree().create_timer(.075), "timeout")
		velocity.x = 0

	yield(get_tree().create_timer(.10), "timeout")

	play_different_animation = false

	yield(get_tree().create_timer(.05), "timeout")

	can_attack_again = true

func set_punch01_col_position():
	if is_looking_right: $Punch01/CollisionShape2D.position.x = 35
	if not is_looking_right: $Punch01/CollisionShape2D.position.x = -35

func set_kick01_col_position():
	if is_looking_right: $Kick01/CollisionShape2D.position.x = 35
	if not is_looking_right: $Kick01/CollisionShape2D.position.x = -35

func kick01():
	play_different_animation = true
	can_attack_again = false
	what_animation_to_play = "Kick01"
	velocity.x /= 2

	if is_looking_right:
		yield(get_tree().create_timer(.10), "timeout")
		velocity.x = 250
		yield(get_tree().create_timer(.075), "timeout")
		velocity.x = 0
	else:
		yield(get_tree().create_timer(.10), "timeout")
		velocity.x = -250
		yield(get_tree().create_timer(.075), "timeout")
		velocity.x = 0

	yield(get_tree().create_timer(.10), "timeout")

	play_different_animation = false

	yield(get_tree().create_timer(.05), "timeout")

	can_attack_again = true

func set_nametag_as_name():
	$CenterContainer/NameTag.text = Network.players[int(name)]["player"]["player_name"]

func _on_Punch01_area_entered(area):
	if (area.name == "Left" or area.name == "Right") and can_enter_punch_zone:
		can_deal_damage = true
		damaged_player = area.get_parent().name
		push_to_what_side = area.name

func _on_Punch01_area_exited(_area):
	can_deal_damage = false
	damaged_player = null
	push_to_what_side = null

sync func deal_damage(_damaged_player, _push_to_what_side):
	for i in range(Network.path_to_PLAYERS.get_child_count()):
		if _damaged_player == Network.path_to_PLAYERS.get_children()[i].name:
			Network.path_to_PLAYERS.get_children()[i].apply_hit(_push_to_what_side)

func push_back(_push_to_what_side):
	play_different_animation = true
	yield(get_tree().create_timer(.05), "timeout")
	if _push_to_what_side == "Right":
		velocity.x += 2500
	if _push_to_what_side == "Left":
		velocity.x -= 2500
	yield(get_tree().create_timer(1), "timeout")
	velocity.x = 0
	play_different_animation = false

func apply_hit(_push_to_what_side):
	play_different_animation = true
	what_animation_to_play = "Hit"
	if _push_to_what_side == "Right":
		velocity.x -= 1000
	if _push_to_what_side == "Left":
		velocity.x += 1000
	yield(get_tree().create_timer(.20), "timeout")
	velocity.x = 0

	yield(get_tree().create_timer(.01), "timeout")
	play_different_animation = false


func kick_check():
	is_kicking = Input.is_action_just_pressed("kick") and what_animation_to_play == "Kick01"

func _on_Left_body_entered(body):
	if body.is_in_group("Kickable") and body.damage_player:
		apply_hit("Left")

func _on_Right_body_entered(body):
	if body.is_in_group("Kickable") and body.damage_player:
		apply_hit("Right")

