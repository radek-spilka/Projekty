extends KinematicBody2D

onready var seats = [
	$"../Seat1",
	$"../Seat2",
	$"../Seat3",
	$"../Seat4",
	$"../Seat5",
	$"../Seat6",
	$"../Seat7",
	$"../Seat8",
]

var path

onready var navigation_agent = $NavigationAgent2D
onready var exit_point = $"../../../ExitPoint"
onready var pay_point = $"../../../PayPoint"
onready var timer = $Timer

onready var coffe_type_label = $Request/CoffeeType
onready var coffe_size_label = $Request/CoffeeSize
onready var coffe_sugar_label = $Request/CoffeeSugar

export var current_state = "goes_to_seat" # = goes to seat 
						  #"waits_for_coffe" # = waites
						  #"timer_over" # = leaves

onready var request = $Request

var velocity = Vector2.ZERO
var max_speed = 150

var wants_coffe_type = ""
var wants_coffe_size = ""
var wants_sugar = ""

var coffe_type_num
var coffe_size_num
var coffe_sugar_num

var can_see_request = false

var can_hand_coffee = false

onready var player = get_parent().get_node("PlayerKeyboard")
onready var inventory = $"../../../Inventory"

onready var animated_sprite = $AnimatedSprite

var seat_num

var x = false

var npc_skin

func _ready():
	request.hide()
	randomize()
	seat_num = randi()%8+0
	coffe_type_num = randi()%6+1 #1 az 6
	coffe_size_num = randi()%3+1 #1 az 3
	coffe_sugar_num = randi()%2+1 #1 nebo 2

	npc_skin = randi()%6+1 #1 az 6

	while seats[seat_num].seat_is_already_taken:
		seat_num = randi()%8+0 #returns an int from 0 to 8
	seat_num = 3
	seats[seat_num].seat_is_already_taken = true
	path = seats[seat_num]

	if coffe_type_num == 1: wants_coffe_type = "Americano"
	if coffe_type_num == 2: wants_coffe_type = "Black"
	if coffe_type_num == 3: wants_coffe_type = "Cappuccino"
	if coffe_type_num == 4: wants_coffe_type = "Espresso"
	if coffe_type_num == 5: wants_coffe_type = "Latte"
	if coffe_type_num == 6: wants_coffe_type = "Lungo"
	coffe_type_label.text = wants_coffe_type
	
	if coffe_size_num == 1:
		wants_coffe_size = "S"
		coffe_size_label.text = "Size: S"
	if coffe_size_num == 2:
		wants_coffe_size = "M"
		coffe_size_label.text = "Size: M"
	if coffe_size_num == 3:
		wants_coffe_size = "L"
		coffe_size_label.text = "Size: L"
	
	wants_sugar = "yes"

	navigation_agent.set_target_location(path.global_position)
	timer.connect("timeout", self, "_update_pathfinding")

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		if seat_num == 0: animated_sprite.flip_h = false
		if seat_num == 1: animated_sprite.flip_h = false
		if seat_num == 2: animated_sprite.flip_h = true
		if seat_num == 3: animated_sprite.flip_h = true
		if seat_num == 4: animated_sprite.flip_h = false
		if seat_num == 5: animated_sprite.flip_h = true
		if seat_num == 6: animated_sprite.flip_h = false
		if seat_num == 7: animated_sprite.flip_h = true
		if can_hand_coffee:
			if player.player_has_full_coffee:
				$Request/RequestOutline.show()
				if Input.is_action_just_pressed("interact"):
					print("want ", str(wants_coffe_type, wants_coffe_size, wants_sugar))
					print("has ", str(player.coffee_type, player.coffee_size, player.sugar))
					right_order_check()
		if not can_hand_coffee:
			$Request/RequestOutline.hide()
		animated_sprite.play("NPC_0"+str(npc_skin)+"_idle")
		return

	elif velocity.x > 0:
		animated_sprite.play("NPC_0"+str(npc_skin)+"_walking")
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.play("NPC_0"+str(npc_skin)+"_walking")
		animated_sprite.flip_h = true

	var direction = global_position.direction_to(navigation_agent.get_next_location())
	var desired_velocity = direction * max_speed
	var steering = (desired_velocity - velocity) * delta * 7.5
	velocity += steering
	velocity = move_and_slide(velocity)

func _update_pathfinding():
	navigation_agent.set_target_location(path.global_position)

func _on_PlayerCheck_body_entered(body):
	if body.name == "PlayerKeyboard" and can_see_request:
		request.show()
		can_hand_coffee = true
		if not x:
			$"../../../UI/Tutorial_npc/1".hide()
			$"../../../UI/Tutorial_npc/2".show()
			x = true

func _on_PlayerCheck_body_exited(_body):
	request.hide()
	can_hand_coffee = false

func right_order_check():
	if player.coffee_type == wants_coffe_type and player.coffee_size == wants_coffe_size and player.sugar == wants_sugar:
		print("Right order")
		can_see_request = false
		path = pay_point
		navigation_agent.set_target_location(path.global_position)
		player.coffee_type = ""
		player.coffee_size = ""
		player.sugar = ""
		inventory.current_cup_size = ""
		inventory.current_cup_type = ""
		inventory.current_sugar = ""
		request.hide()
		$"../../../UI/Tutorial_npc/5".hide()
	else:
		$"../../../UI/Tutorial_npc/WrongOrder".show()
		$"../../../UI/Tutorial_npc/2".hide()
		$"../../../UI/Tutorial_npc/3".show()
		$"../../../UI/Tutorial_npc/4".hide()
		$"../../../UI/Tutorial_npc/5".hide()

		print("Wrong order")












