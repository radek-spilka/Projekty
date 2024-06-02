extends CanvasLayer

onready var connection_index_LABEL = $UpVBoxContainer/Connection_index
onready var players_LABEL = $Players
onready var your_ip_address_LABEL = $UpVBoxContainer/YourIpAddress
onready var status_LABEL = $UpVBoxContainer/Status
onready var player_color_LABEL = $UpVBoxContainer/PlayerColorLabel

var your_ip_address = ""

var can_show_debug

func _ready():
	hide()

func _physics_process(_delta):
	debug()
	give_status()

	players_LABEL.text = "Network players: " + str(Network.players)
	connection_index_LABEL.text = "Connection_index: " + str(Network.connection_index)
	your_ip_address_LABEL.text = "Your IpAddress: " + str(your_ip_address)
	check_color()

	var file = File.new()
	file.open("user://IpAddress.txt", File.READ)
	your_ip_address = file.get_line()
	file.close()

func debug():
	if can_show_debug:
		if Input.is_action_just_pressed("show_debug") and not visible:
			show()
		elif Input.is_action_just_pressed("show_debug") and visible:
			hide()

func give_status():
	if not is_on_server(): status_LABEL.text = "Player Status: Not connected"
	elif is_network_master(): status_LABEL.text = "Player Status: Host/Server"
	elif not is_network_master(): status_LABEL.text = "Player Status: Client"

func check_color():
	var what_color
	if is_on_server():
		if Network.player_colors[Network.connection_index-1] == "ff0000": what_color = "red"
		if Network.player_colors[Network.connection_index-1] == "00ff00": what_color = "green"
		if Network.player_colors[Network.connection_index-1] == "0000ff": what_color = "red"
		if Network.player_colors[Network.connection_index-1] == "ff00ff": what_color = "pink"
		player_color_LABEL.text = "Player color: " + str(Network.player_colors[Network.connection_index-1] + " - " + str(what_color))
	else:
		player_color_LABEL.text = "Player color: X - X"

func is_on_server():
	return Network.network.get_connection_status() == 2
