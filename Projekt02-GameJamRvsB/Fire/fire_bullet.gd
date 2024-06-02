extends RigidBody2D

onready var game = $"../.."

func _ready():
	look_at(game.clostest_enemy.global_position)
	Sounds.get_node("Fire shot").play()

func _physics_process(delta):
	if not game.game_over:
		var all_group_members = get_tree().get_nodes_in_group("Enemy")
		if all_group_members.size() == 0:
			queue_free()
		else:
			position = lerp(position, game.clostest_enemy.position, game.bullet_speed * delta)


func _on_FireBullet_body_entered(body):
	if body.is_in_group("Enemy"):
		body.get_damage()
		Sounds.get_node("Fire hit").play()
	queue_free()
