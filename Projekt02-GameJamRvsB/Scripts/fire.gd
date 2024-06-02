extends KinematicBody2D

const bullet_path = preload("res://Fire/FireBullet.tscn")

onready var game = $"../.."

var time_between_shots = 0

func _ready():
	time_between_shots = game.time_between_shots

func _physics_process(delta):
	if not game.intro_is_visible:
		if get_tree().get_nodes_in_group("Enemy").size() == 0:
			time_between_shots = game.time_between_shots
			pass
		if time_between_shots > 0:
			time_between_shots -= 1 * delta
		if time_between_shots >= 1.5 and time_between_shots <= 1.75:
			$AnimationPlayer.play("shoot")
		if time_between_shots <= 0:
			shoot()
			time_between_shots = game.time_between_shots

	if game.game_over:
		$Sprite.visible = false
		$Eyes.visible = false
		$CPUParticles2D.emitting = false

func get_damage():
	$"../../CanvasLayer/FireMeter".value -= 10

func shoot():
	var bullet = bullet_path.instance()

	if get_tree().get_nodes_in_group("Enemy").size() > 0:
		get_parent().add_child(bullet)
		bullet.position = position
