extends RigidBody2D

var selected = false

var box_num = RandomNumberGenerator.new()
var box_ran_num = 0

var box_color = [
	Color("#000000"), #0
	Color("#5c5e67"),
	Color("#5a5d6b"),
	Color("#5b6075"),
	Color("#74798c"),
	Color("#666975"),
	Color("#585c6e"),
	Color("#484d63"),
	Color("#373c4f"),
	Color("#363a4a"), #9
]

func _ready():
	box_num.randomize()
	
	box_ran_num = box_num.randi_range(1,9)

	$Box_num.text = str(box_ran_num)

	$Sprite.self_modulate = box_color[box_ran_num]

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 10 * delta)
		sleeping = true
	if not selected:
		sleeping = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			
