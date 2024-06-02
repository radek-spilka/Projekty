extends ParallaxBackground

onready var camera = get_parent().get_node("Camera2D")
export var camera_y_mainmenu = 1300
export var camera_speed = 1.5

var title_ = false

export var multiplier = 5

func _input(event):
	if not title_:
		if event is InputEventMouseMotion:
			var screensize = Vector2(1920, 1080)
			var mouse_x = event.position.x
			var mouse_y = event.position.y
			var relative_x = (mouse_x - (screensize.x/2)) / (screensize.x/2)
			var relative_y = (mouse_y - (screensize.y/2)) / (screensize.y/2)
			for child in get_children():
				child.motion_offset.x = multiplier * relative_x * (child.get_index() + 1)
				child.motion_offset.y = multiplier * relative_y * (child.get_index() + 1)

		if event is InputEventMouseButton or event is InputEventKey:
			title_ = true
	else:
		for child in get_children():
			child.motion_offset.x = lerp(child.motion_offset.x,0,0.5)
			child.motion_offset.y = lerp(child.motion_offset.y,0,0.5)

func _physics_process(delta):
	if title_:
		camera.position.y = lerp(camera.position.y, camera_y_mainmenu, camera_speed * delta)
