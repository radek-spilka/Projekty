extends Node2D

var selected = false
var can_select = false

onready var fire_meter = $"../../CanvasLayer/FireMeter"
onready var coins_text = $"../../CanvasLayer/CoinsText"

onready var game = $"../.."

func _ready():
	randomize()
	var num = randi()%2+1
	if num == 2:
		$Sticks.visible = false
		$Coins.visible = true

func _physics_process(delta):
	if $"../Shield".visible: pass
	else:
		if selected:
			game.cursor_is_holding = true
			Follow_mouse()

		if can_select and not selected:
			if Input.is_action_just_pressed("left_mouse"):
				Sounds.get_node("Grab").play()
				selected = true

		if Input.is_action_just_released("left_mouse"):
			selected = false
			game.cursor_is_holding = false

		if game.cursor_is_holding:
			$"../../../CustomCursor".change_cursor("holding")
		elif game.cursor_is_hovering:
			$"../../../CustomCursor".change_cursor("ready_to_hold")
		if not game.cursor_is_hovering and not game.cursor_is_holding:
			$"../../../CustomCursor".change_cursor("normal")

func Follow_mouse():
	global_position = lerp(global_position, get_global_mouse_position(), 0.25)

func _on_Area2D_mouse_entered():
	can_select = true
	game.cursor_is_hovering = true

func _on_Area2D_mouse_exited():
	can_select = false
	game.cursor_is_hovering = false

func _on_Area2D_body_entered(body):
	if body.name == "Fire" and $Sticks.visible: 
		fire_meter.value += 20
		selected = false
		can_select = false
		queue_free()
		Sounds.get_node("Item in fire").play()

	if body.name == "Fire" and not $Sticks.visible: 
		fire_meter.value += 5
		coins_text.text = str(int(coins_text.text) + 3)
		selected = false
		can_select = false
		queue_free()
		Sounds.get_node("Item in fire").play()

	game.cursor_is_holding = false
	
