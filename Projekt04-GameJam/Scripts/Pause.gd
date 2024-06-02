extends Node2D

var is_paused = true

func _ready():
	get_tree().paused = true

func _physics_process(delta):
	if Input.is_action_just_pressed("click") and is_paused:
		get_parent().get_node("click").play()
		get_tree().paused = not get_tree().paused 
		is_paused = not is_paused
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused 
		is_paused = not is_paused

	if is_paused:
		visible = true
	if not is_paused:
		visible = false
