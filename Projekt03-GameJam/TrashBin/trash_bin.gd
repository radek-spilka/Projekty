extends Area2D

var can_use_trashbin = false

onready var player = $"../PlayerKeyboard"
onready var inventory = $"../../../Inventory"

func _physics_process(_delta):
	if can_use_trashbin and Input.is_action_just_pressed("interact"):
		player.coffee_size = ""
		player.coffee_type = ""
		player.sugar = ""
		inventory.current_cup_size = ""
		inventory.current_cup_type = ""
		inventory.inventory_up = false
		$Outline.hide()
		$"../../../UI/Tutorial_npc/WrongOrder".hide()
		$Trash.play()

func _on_TrashBin_body_entered(body):
	if body.name == "PlayerKeyboard" and player.coffee_size != "":
		can_use_trashbin = true
		$Outline.show()

func _on_TrashBin_body_exited(body):
	if body.name == "PlayerKeyboard":
		can_use_trashbin = false
		$Outline.hide()
