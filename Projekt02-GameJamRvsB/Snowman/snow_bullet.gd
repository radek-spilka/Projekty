extends RigidBody2D

var snow_bullet_speed = 1.5

onready var game = $"../.."

func _ready():
	look_at(game.clostest_enemy.global_position)

func _physics_process(delta):
	snow_bullet_speed += delta*2
	position = lerp(position, game.fire.position, snow_bullet_speed * delta)

func _on_SnowBullet_body_entered(body):
	if body.is_in_group("Fire"):
		body.get_damage()
		Sounds.get_node("Fire hit").play()
	if body.is_in_group("Shield"):
		Sounds.get_node("Bullet to shield").play()
	queue_free()

