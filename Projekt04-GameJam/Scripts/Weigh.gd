extends Node2D

var box_num = RandomNumberGenerator.new()

var left_weigh_num = 0
var right_weigh_num = 0

var goal_left_ran_num
var goal_right_ran_num

var fake_goal_left
var fake_goal_right

func _ready():
	start()

func start():
	box_num.randomize()

	goal_left_ran_num = box_num.randi_range(1,9)
	goal_right_ran_num = box_num.randi_range(1,9)

	fake_goal_left = goal_left_ran_num
	fake_goal_right = goal_right_ran_num

	$Left/Goal_left_num2.text = str(goal_left_ran_num)
	$Right/Goal_right_num2.text = str(goal_right_ran_num)

	$Left/Goal_left_num.text = str(fake_goal_left)
	$Right/Goal_right_num.text = str(fake_goal_right)

func _physics_process(delta):
	if left_weigh_num == goal_left_ran_num:
		$Left/Goal_left_num.self_modulate = Color("#448055")
		$Left/Goal_left_num2.self_modulate = Color("#448055")
	if left_weigh_num != goal_left_ran_num:
		$Left/Goal_left_num.self_modulate = Color("#ffffff")
		$Left/Goal_left_num2.self_modulate = Color("#ffffff")
	if right_weigh_num == goal_right_ran_num:
		$Right/Goal_right_num.self_modulate = Color("#448055")
		$Right/Goal_right_num2.self_modulate = Color("#448055")
	if right_weigh_num != goal_right_ran_num:
		$Right/Goal_right_num.self_modulate = Color("#ffffff")
		$Right/Goal_right_num2.self_modulate = Color("#ffffff")

	if left_weigh_num > right_weigh_num:
		rotation_degrees -= left_weigh_num/3 * delta
	if left_weigh_num < right_weigh_num:
		rotation_degrees += right_weigh_num/3 * delta

	if left_weigh_num != goal_left_ran_num and right_weigh_num != goal_right_ran_num:
		get_parent().get_node("Confirm_btn").disabled = true
	if left_weigh_num == goal_left_ran_num and right_weigh_num == goal_right_ran_num:
		rotation_degrees = lerp(rotation_degrees, 0, 2.5 *delta)
		get_parent().get_node("Confirm_btn").disabled = false

	$Left/Goal_left_num.text = str(fake_goal_left - left_weigh_num)
	$Right/Goal_right_num.text = str(fake_goal_right - right_weigh_num)

func _on_Left_Area_body_entered(body):
	if body.is_in_group("Box"):
		left_weigh_num += int(body.box_ran_num)

func _on_Right_Area_body_entered(body):
	if body.is_in_group("Box"):
		right_weigh_num += int(body.box_ran_num)

func _on_Left_Area_body_exited(body):
	if body.is_in_group("Box"):
		left_weigh_num -= int(body.box_ran_num)

func _on_Right_Area_body_exited(body):
	if body.is_in_group("Box"):
		right_weigh_num -= int(body.box_ran_num)
