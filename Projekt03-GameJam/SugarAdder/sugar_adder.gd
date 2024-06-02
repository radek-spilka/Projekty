extends Area2D

var can_add_sugar = false

onready var player = $"../PlayerKeyboard"
onready var inventory = $"../../../Inventory"

var x = false

func _physics_process(_delta):
	if can_add_sugar and Input.is_action_just_pressed("interact") and player.sugar == "":
		inventory.current_sugar = "yes"
		player.sugar = "yes"
		$DropInWater.play()
		$Outline.hide()
		if not x:
			$"../../../UI/Tutorial_npc/4".hide()
			$"../../../UI/Tutorial_npc/5".show()
			x = true

func _on_SugarAdder_body_entered(body):
	if body.name == "PlayerKeyboard" and player.player_has_full_coffee and player.sugar == "" :
		can_add_sugar = true
		$Outline.show()

func _on_SugarAdder_body_exited(_body):
	can_add_sugar = false
	$Outline.hide()
