extends Area2D

export var cupsize = "" # S, M, L

var can_take_cupsize

onready var player = $"../PlayerKeyboard"

var size_s = load("res://CupSize/Size_s.png")
var size_m = load("res://CupSize/Size_m.png")
var size_l = load("res://CupSize/Size_l.png")

var size_s_outline = load("res://CupSize/Size_s_outline.png")
var size_m_outline = load("res://CupSize/Size_m_outline.png")
var size_l_outline = load("res://CupSize/Size_l_outline.png")

func _ready():
	if cupsize == "S":
		$Sprite.texture = size_s
		$Outline.texture = size_s_outline
	if cupsize == "M":
		$Sprite.texture = size_m
		$Outline.texture = size_m_outline
	if cupsize == "L":
		$Sprite.texture = size_l
		$Outline.texture = size_l_outline

func _physics_process(_delta):
	if can_take_cupsize and Input.is_action_just_pressed("interact") and not player.player_has_full_coffee:
		player.coffee_size = cupsize
		$TakingCup.play()
		print("you took cup of size :" + cupsize)
		$"../../../Inventory/CoffeSize".position.y = 425
		$"../../../UI/Tutorial_npc/2".hide()
		$"../../../UI/Tutorial_npc/3".show()

func _on_Cupsize_body_entered(body):
	if body.name == "PlayerKeyboard" and player.coffee_type == "":
		can_take_cupsize = true
		$Outline.show()

func _on_Cupsize_body_exited(body):
	if body.name == "PlayerKeyboard":
		can_take_cupsize = false
		$Outline.hide()
