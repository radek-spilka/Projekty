extends Area2D

onready var coffee_machine_on = load("res://CoffeMachine/Coffee_machine_on.png")
onready var coffee_machine_off = load("res://CoffeMachine/Coffee_machine_off.png")

onready var show_possibilities_sprite = $ShowPossibilities
onready var coffe_name = $ShowPossibilities/CoffeeInfo/CoffeeName
onready var coffe_description = $ShowPossibilities/CoffeeInfo/CoffeeDescription

onready var coffee_img = $ShowPossibilities/CoffeeInfo/CoffeeInfo/CoffeeImg

onready var arrow = $ShowPossibilities/Arrow

var americano_coffee_img = load("res://CoffeMachine/Coffees/americano_coffee.png")
var black_coffee_img = load("res://CoffeMachine/Coffees/black_coffee.png")
var cappuccino_coffee_img = load("res://CoffeMachine/Coffees/cappuccino_coffee.png")
var espresso_coffee_img = load("res://CoffeMachine/Coffees/espresso_coffee.png")
var latte_coffee_img = load("res://CoffeMachine/Coffees/latte_coffe.png")
var lungo_coffee_img = load("res://CoffeMachine/Coffees/lungo_coffee.png")

var can_make_coffe = false
var show_coffe_info = false

onready var player = $"../PlayerKeyboard"
onready var inventory = $"../../../Inventory"

var start_coffee_timer = false
var what_coffee_type_to_take = ""
var what_coffee_size_to_take = ""
onready var coffe_meter = $CoffeeMeter
var coffee_is_done = false

onready var coffee_machine_can_select = $CoffeeMachineCanSelect

var arrow_cursor = load("res://Mouse/Default-export.png")
var hover_cursor = load("res://Mouse/Hover-export.png")

var x = false

func _ready():
	$Cup.hide()

func _physics_process(_delta):
	if not start_coffee_timer:
		if can_make_coffe and Input.is_action_just_pressed("interact"):
			show_possibilities()
		elif not can_make_coffe:
			show_possibilities_sprite.hide()

	if show_coffe_info:
		$ShowPossibilities/CoffeeInfo.show()
		arrow.modulate = Color(1, 1, 1)
	if not show_coffe_info:
		$ShowPossibilities/CoffeeInfo.hide()
		arrow.modulate = Color(0.537255, 0.537255, 0.537255)

	arrow.look_at(get_global_mouse_position())

	if coffee_is_done and can_make_coffe and Input.is_action_just_pressed("interact"):
		player.coffee_type = what_coffee_type_to_take
		player.coffee_size = what_coffee_size_to_take
		inventory.current_cup_type = player.coffee_type
		what_coffee_type_to_take = ""
		what_coffee_size_to_take = ""
		coffee_is_done = false
		coffe_meter.value = 9999
		$Cup/Particles2D.show()
		$Cup.hide()
		show_possibilities_sprite.hide()
		coffe_meter.show()
		coffee_machine_can_select.hide()
		$"../../../UI/Tutorial_npc/3".hide()
		$"../../../UI/Tutorial_npc/4".show()

	if coffe_meter.value == 0:
		start_coffee_timer = false
		coffee_is_done = true
		$Cup/Particles2D.hide()

	if coffee_is_done:
		$CoffeIsDone.show()
		$Coffee.stop()

		if not x:
			if not $Cink.playing:
				$Cink.play()
			x = true
	if not coffee_is_done:
		$CoffeIsDone.hide()

	if start_coffee_timer:
		$Sprite.texture = coffee_machine_off
		if what_coffee_size_to_take == "S": coffe_meter.max_value = 450
		if what_coffee_size_to_take == "M": coffe_meter.max_value = 750
		if what_coffee_size_to_take == "L": coffe_meter.max_value = 1250
		if coffe_meter.value > 0:
			show_possibilities_sprite.hide()
			coffe_meter.show()
			coffe_meter.value -= 1
			$Cup.show()
	else:
		coffe_meter.hide()
		$Sprite.texture = coffee_machine_on

func _on_CoffeeMachine_body_entered(body):
	if body.name == "PlayerKeyboard" and not player.player_has_full_coffee:
		if coffee_is_done and player.coffee_size == "":
			coffee_machine_can_select.show()
			can_make_coffe = true
		elif player.coffee_size != "" and not coffee_is_done and not start_coffee_timer:
			coffee_machine_can_select.show()
			can_make_coffe = true


func _on_CoffeeMachine_body_exited(body):
	if body.name == "PlayerKeyboard":
		can_make_coffe = false
		coffee_machine_can_select.hide()

func show_possibilities():
	show_possibilities_sprite.show()

func _on_Btn_Black_pressed():
	if player.coffee_size != "" and inventory.current_cup_type == "":
		what_coffee_type_to_take = "Black"
		$CoffeIsDone/CoffeeImg.texture = black_coffee_img
		what_coffee_size_to_take = inventory.current_cup_size
		inventory.get_node(".").current_cup_type = ""
		coffe_meter.value = 9999
		start_coffee_timer = true
		player.coffee_size = ""
		coffee_machine_can_select.hide()
		Input.set_custom_mouse_cursor(arrow_cursor)
		$Coffee.play()
	else: print("Dont have cup size or already have one coffe")

func _on_Btn_Latte_pressed():
	if player.coffee_size != "" and inventory.current_cup_type == "":
		what_coffee_type_to_take = "Latte"
		$CoffeIsDone/CoffeeImg.texture = latte_coffee_img
		what_coffee_size_to_take = inventory.current_cup_size
		inventory.get_node(".").current_cup_type  = ""
		coffe_meter.value = 9999
		start_coffee_timer = true
		player.coffee_size = ""
		coffee_machine_can_select.hide()
		Input.set_custom_mouse_cursor(arrow_cursor)
		$Coffee.play()
	else: print("Dont have cup size or already have one coffe")

func _on_Btn_Capuccino_pressed():
	if player.coffee_size != "" and inventory.current_cup_type == "":
		what_coffee_type_to_take = "Cappuccino"
		$CoffeIsDone/CoffeeImg.texture = cappuccino_coffee_img
		what_coffee_size_to_take = inventory.current_cup_size
		inventory.get_node(".").current_cup_type  = ""
		coffe_meter.value = 9999
		start_coffee_timer = true
		player.coffee_size = ""
		coffee_machine_can_select.hide()
		Input.set_custom_mouse_cursor(arrow_cursor)
		$Coffee.play()
	else: print("Dont have cup size or already have one coffe")

func _on_Btn_Espresso_pressed():
	if player.coffee_size != "" and inventory.current_cup_type == "":
		what_coffee_type_to_take = "Espresso"
		$CoffeIsDone/CoffeeImg.texture = espresso_coffee_img
		what_coffee_size_to_take = inventory.current_cup_size
		inventory.get_node(".").current_cup_type  = ""
		coffe_meter.value = 9999
		start_coffee_timer = true
		player.coffee_size = ""
		coffee_machine_can_select.hide()
		Input.set_custom_mouse_cursor(arrow_cursor)
		$Coffee.play()
	else: print("Dont have cup size or already have one coffe")

func _on_Btn_Lungo_pressed():
	if player.coffee_size != "" and inventory.current_cup_type == "":
		what_coffee_type_to_take = "Lungo"
		$CoffeIsDone/CoffeeImg.texture = lungo_coffee_img
		what_coffee_size_to_take = inventory.current_cup_size
		inventory.get_node(".").current_cup_type  = ""
		coffe_meter.value = 9999
		start_coffee_timer = true
		player.coffee_size = ""
		coffee_machine_can_select.hide()
		Input.set_custom_mouse_cursor(arrow_cursor)
		$Coffee.play()
	else: print("Dont have cup size or already have one coffe")

func _on_Btn_Americano_pressed():
	if player.coffee_size != "" and inventory.current_cup_type == "":
		what_coffee_type_to_take = "Americano"
		$CoffeIsDone/CoffeeImg.texture = americano_coffee_img
		what_coffee_size_to_take = inventory.current_cup_size
		inventory.get_node(".").current_cup_type  = ""
		coffe_meter.value = 9999
		start_coffee_timer = true
		player.coffee_size = ""
		coffee_machine_can_select.hide()
		Input.set_custom_mouse_cursor(arrow_cursor)
		$Coffee.play()
	else: print("Dont have cup size or already have one coffe")

func _on_Btn_Black_mouse_entered():
	$ShowPossibilities/Btn_Black.rect_scale = Vector2(1.55, 1.55)
	coffe_name.text = "Black"
	coffe_description.text = "- Rich in antioxidants\n - Contains vitamin B2 and magnesium"
	coffee_img.texture = black_coffee_img
	show_coffe_info = true
	Input.set_custom_mouse_cursor(hover_cursor)
func _on_Btn_Black_mouse_exited():
	$ShowPossibilities/Btn_Black.rect_scale = Vector2(1, 1)
	show_coffe_info = false
	Input.set_custom_mouse_cursor(arrow_cursor)

func _on_Btn_Latte_mouse_entered():
	$ShowPossibilities/Btn_Latte.rect_scale = Vector2(1.55, 1.55)
	coffe_name.text = "Latte"
	coffe_description.text = "- ...coffee made up of one or two shots of espresso with steamed milk."
	coffee_img.texture = latte_coffee_img
	show_coffe_info = true
	Input.set_custom_mouse_cursor(hover_cursor)
func _on_Btn_Latte_mouse_exited():
	$ShowPossibilities/Btn_Latte.rect_scale = Vector2(1, 1)
	show_coffe_info = false
	Input.set_custom_mouse_cursor(arrow_cursor)

func _on_Btn_Capuccino_mouse_entered():
	$ShowPossibilities/Btn_Capuccino.rect_scale = Vector2(1.55, 1.55)
	coffe_name.text = "Cappuccino"
	coffe_description.text = "- ...most consumable espresso-based milk coffee across the world."
	coffee_img.texture = cappuccino_coffee_img
	show_coffe_info = true
	Input.set_custom_mouse_cursor(hover_cursor)
func _on_Btn_Capuccino_mouse_exited():
	$ShowPossibilities/Btn_Capuccino.rect_scale = Vector2(1, 1)
	show_coffe_info = false
	Input.set_custom_mouse_cursor(arrow_cursor)

func _on_Btn_Espresso_mouse_entered():
	$ShowPossibilities/Btn_Espresso.rect_scale = Vector2(1.55, 1.55)
	coffe_name.text = "Espresso"
	coffe_description.text = "- The purest distillation of the coffee bean\n- Italian origin"
	coffee_img.texture = espresso_coffee_img
	show_coffe_info = true
	Input.set_custom_mouse_cursor(hover_cursor)
func _on_Btn_Espresso_mouse_exited():
	$ShowPossibilities/Btn_Espresso.rect_scale = Vector2(1, 1)
	show_coffe_info = false
	Input.set_custom_mouse_cursor(arrow_cursor)

func _on_Btn_Lungo_mouse_entered():
	$ShowPossibilities/Btn_Lungo.rect_scale = Vector2(1.55, 1.55)
	coffe_name.text = "Lungo"
	coffe_description.text = " - Italian for “long”\n - Higher level of caffeine then others"
	coffee_img.texture = lungo_coffee_img
	show_coffe_info = true
	Input.set_custom_mouse_cursor(hover_cursor)
func _on_Btn_Lungo_mouse_exited():
	$ShowPossibilities/Btn_Lungo.rect_scale = Vector2(1, 1)
	show_coffe_info = false
	Input.set_custom_mouse_cursor(arrow_cursor)

func _on_Btn_Americano_mouse_entered():
	$ShowPossibilities/Btn_Americano.rect_scale = Vector2(1.55, 1.55)
	coffe_name.text = "Americano"
	coffe_description.text = "...type of coffee drink prepared by diluting an espresso with hot water..."
	coffee_img.texture = americano_coffee_img
	show_coffe_info = true
	Input.set_custom_mouse_cursor(hover_cursor)
func _on_Btn_Americano_mouse_exited():
	$ShowPossibilities/Btn_Americano.rect_scale = Vector2(1, 1)
	show_coffe_info = false
	Input.set_custom_mouse_cursor(arrow_cursor)

