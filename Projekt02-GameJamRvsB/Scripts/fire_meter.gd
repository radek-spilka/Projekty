extends HSlider

onready var anim_tree = get_node("Fire/AnimationTree")

onready var game = $"../.."

export var speed_loss = 0.03

var anim_speed = 1

var x

func _physics_process(delta):
	if value > 75:
		anim_speed = 1
	elif value > 50:
		anim_speed = 1.5
	elif value > 35:
		anim_speed = 2.5
	elif value > 20:
		anim_speed = 4
	elif value > 10:
		anim_speed = 6

	anim_tree.advance(delta * anim_speed)

	if not game.intro_is_visible:
		value -= game.fire_decrease_speed

	if x: $".".rect_position.y = lerp($".".rect_position.y, 1125 , delta*2)
	if not x: $".".rect_position.y = lerp($".".rect_position.y, 1025 , delta*2)


func _on_Area2D_mouse_entered():
	x = not x
