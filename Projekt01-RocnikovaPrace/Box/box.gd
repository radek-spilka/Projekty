extends RigidBody2D

var can_be_kicked = false
var damage_player = false

var _player = null

var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	random_skin()

func random_skin():
	var variants = [$"1",$"2",$"3",$"4"]
	var sel_box = randi() % 4
	variants[sel_box].show()

func _physics_process(_delta):
	if damage_player:
		set_collision_mask(1)

	if can_be_kicked and _player.is_kicking:
		rpc("kick_box")

func _on_Area2D_area_entered(area):
	if area.name == "Kick01":
		can_be_kicked = true
		_player = area.get_parent()

func _on_Area2D_area_exited(area):
	if area.name == "Kick01":
		can_be_kicked = false

func _on_Box_body_entered(_body):
	if damage_player:
		rpc("destroy_box")

sync func destroy_box():
	yield(get_tree().create_timer(.05), "timeout")
	queue_free()

sync func kick_box():
	yield(get_tree().create_timer(.20), "timeout")
	can_be_kicked = false
	if _player.is_looking_right:
		linear_velocity.x += 2000
	if not _player.is_looking_right:
		linear_velocity.x -= 2000
	linear_velocity.y -= 450
	yield(get_tree().create_timer(.05), "timeout")
	damage_player = true


