extends CanvasLayer

var now = false
var x = false

onready var game = $".."

func _physics_process(delta):
	if now and not game.game_over:
		get_node("Camera2D").global_position = lerp(get_node("Camera2D").global_position, Vector2(1920/2, 1080/2), 0.05)
		get_node("Camera2D").zoom = lerp(get_node("Camera2D").zoom, Vector2(1, 1), 0.05)
		game.intro_is_visible = false
		if x:
			get_parent().get_node("Intro/AnimationPlayer").play("hide")
			x = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER and not now:
			now = true
			x = true
			Sounds.get_node("Button_click").play()
