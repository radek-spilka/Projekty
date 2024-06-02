extends KinematicBody2D

var velocity = Vector2()

export var speed = 200
export var friction = 0.01
export var acceleration = 0.1

onready var animation_sprite = $AnimatedSprite

export var coffee_type = ""
export var coffee_size = ""
export var sugar = ""

var player_has_full_coffee = false

onready var inventory = $"../../../Inventory"

func get_input():
	var input = Vector2()
	if Input.is_action_pressed("right"):
		input.x += 1
		animation_sprite.flip_h = false
		$Particles2D.position.x = 33
	if Input.is_action_pressed("left"):
		input.x -= 1
		animation_sprite.flip_h = true
		$Particles2D.position.x = -33
	if Input.is_action_pressed("down"):
		input.y += 1
	if Input.is_action_pressed("up"):
		input.y -= 1
	return input

func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * speed, acceleration)
		if player_has_full_coffee:
			animation_sprite.animation = "walking_full_cup"
			$Particles2D.emitting = true
		elif coffee_size != "":
			animation_sprite.animation = "walking_empty_cup"
			$Particles2D.emitting = false
		else:
			animation_sprite.animation = "walking"
			$Particles2D.emitting = false
	elif velocity != Vector2.ZERO:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		if player_has_full_coffee:
			animation_sprite.animation = "idle_full_cup"
			$Particles2D.emitting = true
		elif coffee_size != "":
			animation_sprite.animation = "idle_empty_cup"
			$Particles2D.emitting = false
		else:
			animation_sprite.animation = "idle"
			$Particles2D.emitting = false

	velocity = move_and_slide(velocity)

	if coffee_size != "" and inventory.current_cup_type != "":
		player_has_full_coffee = true
	if coffee_size == "" or inventory.current_cup_type == "":
		player_has_full_coffee = false







