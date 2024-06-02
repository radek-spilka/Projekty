extends Node2D

var inventory_up = false

var coffee_size_s = load("res://Inventory/coffee_cup_s.png")
var coffee_size_m = load("res://Inventory/coffee_cup_m.png")
var coffee_size_l = load("res://Inventory/coffee_cup_l.png")

export var current_cup_size = ""
export var current_cup_type = ""
export var current_sugar = ""

onready var player = $"../Navigation2D/YSort/PlayerKeyboard"

func _physics_process(delta):
	if inventory_up:$CoffeSize.position = Vector2(120, lerp($CoffeSize.position.y, 425, delta * 3)) 
	if not inventory_up: $CoffeSize.position = Vector2(120, lerp($CoffeSize.position.y, 520, delta * 3))

	if player.sugar != "": $CoffeSize/Sugar.text = "X"
	if player.sugar == "": $CoffeSize/Sugar.text = ""

	if player.coffee_size == "S":
		$CoffeSize.texture = coffee_size_s
		$CoffeSize.offset.y = -5
		current_cup_size = "S"
		$CoffeSize/CoffeeName.rect_position.y = -9.8
		$CoffeSize/Particles2D.position.y = -8
		$CoffeSize/Sugar.rect_position.y = -5.4
	elif player.coffee_size == "M":
		$CoffeSize.texture = coffee_size_m
		$CoffeSize.offset.y = 0
		current_cup_size = "M"
		$CoffeSize/CoffeeName.rect_position.y = -11.6
		$CoffeSize/Particles2D.position.y = -8
		$CoffeSize/Sugar.rect_position.y = -5.6
	elif player.coffee_size == "L":
		$CoffeSize.texture = coffee_size_l
		$CoffeSize.offset.y = 5
		current_cup_size = "L"
		$CoffeSize/CoffeeName.rect_position.y = -12.8
		$CoffeSize/Particles2D.position.y = -8
		$CoffeSize/Sugar.rect_position.y = -4.6
	else:
		$CoffeSize.texture = null
		current_cup_size = ""

	$CoffeSize/CoffeeName.text = current_cup_type

	if player.player_has_full_coffee:
		$CoffeSize/Particles2D.emitting = true
	if not player.player_has_full_coffee:
		$CoffeSize/Particles2D.emitting = false

func _on_InventoryUp_mouse_entered():
	if player.coffee_size != "":
		inventory_up = true

func _on_InventoryUp_mouse_exited():
	inventory_up = false
