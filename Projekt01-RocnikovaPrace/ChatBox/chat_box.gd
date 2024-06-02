extends Node

onready var chatLog = $VBoxContainer/RichTextLabel
onready var input_LABEL = $VBoxContainer/HBoxContainer/Label
onready var inputField = $VBoxContainer/HBoxContainer/LineEdit

var groups = [
	{"color" : "#"+Network.player_colors[0]},
	{"color" : "#"+Network.player_colors[1]},
	{"color" : "#"+Network.player_colors[2]},
	{"color" : "#"+Network.player_colors[3]}
]

var group_index = 0
var user_name = ""

func _ready():
	inputField.connect("text_entered", self, "text_entered")

func _set_name(_name, _connection_index):
	user_name = _name
	group_index = _connection_index-1
	input_LABEL.text = "["+_name+"] "

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			inputField.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			inputField.release_focus()

sync func add_message(username, text, group):
	chatLog.bbcode_text += "[color=" + groups[group]["color"] + "]"
	chatLog.bbcode_text += "[" + username + "]: "
	chatLog.bbcode_text += "[/color]"
	chatLog.bbcode_text += text
	chatLog.bbcode_text += "\n" 

func text_entered(text):
	if text != "":
		rpc("add_message", user_name, text, group_index)
		inputField.text = ""

func clear_chat_box():
	chatLog.bbcode_text = ""

