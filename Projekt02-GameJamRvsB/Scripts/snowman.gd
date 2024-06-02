extends KinematicBody2D

var move_speed = 25
var health = 3

export var tutorial_snowman = false

const set_time_between_shots = 3
var time_between_shots = 0

onready var snow_bullet_path = preload("res://Snowman/SnowBullet.tscn")

onready var fire_pos = $"../Fire".global_position
onready var fire = $"../Fire"
onready var game = $"../.."

const sticks_path = preload("res://Stick/Sticks.tscn")

var can_shoot = false

func _ready():
	time_between_shots = set_time_between_shots-rand_range(0,2)
	if tutorial_snowman:
		health = 5

func _physics_process(delta):
	if tutorial_snowman:
		pass
	else:
		go_there(delta)

		if can_shoot:
			shoot_time(delta)

		if global_position.x < fire_pos.x:
			$Sprite.flip_h = true
			$HitSprite.flip_h = true

func go_there(delta):
	global_position = global_position.move_toward(fire_pos, delta*move_speed)

	if is_zero_approx(global_position.x - fire_pos.x) or is_zero_approx(global_position.y - fire_pos.y):
		game.player_choose_target = false
		damage_fire(5)
		queue_free()

func shoot_time(delta):
	if time_between_shots > 0:
		time_between_shots -= 1 * delta
	if time_between_shots <= 0:
		shoot()
		time_between_shots = set_time_between_shots-rand_range(0,2)

func shoot():
	var snow_bullet = snow_bullet_path.instance()
	get_parent().add_child(snow_bullet)
	snow_bullet.position = position
	Sounds.get_node("Snow shot").play()

func get_damage():
	health -= 1
	$AnimationPlayer.play("hit")
	if health <= 0:
		spawn_sticks()
		queue_free()
		game.player_choose_target = false

	yield(get_tree().create_timer(0.15), "timeout")

	$AnimationPlayer.play("walking")

func damage_fire(dmg):
	$"../../CanvasLayer/FireMeter".value -= dmg

func spawn_sticks():
	var sticks = sticks_path.instance()
	get_parent().add_child(sticks)
	sticks.global_position = global_position

func _on_TargetButton_pressed():
	game.player_choose_target = true
	game.set_new_target(self)
