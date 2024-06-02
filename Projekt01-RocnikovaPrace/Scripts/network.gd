extends Node

const MAX_PLAYERS = 4

var ip_adress = ""
var port = 0

var local_player_id = 0
var connection_index = 0
sync var players = {}
sync var player_data = {}

sync var ready_players = 0

var network = NetworkedMultiplayerENet.new()

onready var path_to_PLAYERS = get_node("/root/Players")

var player_colors = [
	"ff1b28",
	"8cf83b",
	"014d7c",
	"ffe62d"
]

func _ready():
	# warning-ignore:return_value_discarded
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	# warning-ignore:return_value_discarded
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	# warning-ignore:return_value_discarded
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")

	find_ip_adress()

func create_server():
	network.create_server(port, MAX_PLAYERS-1)
	get_tree().set_network_peer(network)
	print("Server created.")

	update_lobby()
	add_to_player_list()

	Debug.give_status()
	set_connection_index()
	set_player_color()

	get_tree().call_group("Lobby", "show")
	get_tree().call_group("Lobby", "set_player_shadow_color")
	get_tree().call_group("MainMenu", "hide")
	get_tree().call_group("Lobby", "chat_box", local_player_id, connection_index)
	get_tree().call_group("Lobby", "show_or_hide")

	yield(get_tree().create_timer(.05), "timeout")
	get_tree().call_group("Lobby", "on_player_connectivity_status_changed", Saved.saved_data["player"]["player_name"], "has created Server...", connection_index)

func connect_to_server():
	network.create_client(ip_adress, port)

	check_valid_connection()

	#warning-ignore:return_value_discarded
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().set_network_peer(network)

func _connected_to_server():
	add_to_player_list()
	rpc("_send_player_info", local_player_id, player_data)

	yield(get_tree().create_timer(.15), "timeout")

	Debug.give_status()
	set_connection_index()
	set_player_color()

	rpc("_send_player_info", local_player_id, player_data)

	get_tree().call_group("Lobby", "show")
	get_tree().call_group("Lobby", "set_player_shadow_color")
	get_tree().call_group("JoinLobby", "hide")
	get_tree().call_group("Lobby", "chat_box", local_player_id, connection_index)
	get_tree().call_group("Lobby", "show_or_hide")

	yield(get_tree().create_timer(.05), "timeout")
	get_tree().call_group("Lobby", "on_player_connectivity_status_changed", Saved.saved_data["player"]["player_name"], "has connected...", connection_index)

func add_to_player_list():
	local_player_id = get_tree().get_network_unique_id()
	player_data = Saved.saved_data
	players[local_player_id] = player_data

func _on_player_connected(id):
	print(str(id) + " has connected.")

func _on_player_disconnected(id):
	print(str(id) + " has disconnected.")

	if player_is_in_main_menu():
		players.erase(id)
		get_tree().call_group("Lobby", "refresh_players", players)
#	else:
#		get_node("/root/Players").get_node(str(id)).queue_free()

func _on_server_disconnected():
	print("Server ended.")
	get_tree().call_group("Lobby", "host_left_lobby")

sync func update_lobby():
	get_tree().call_group("Lobby", "refresh_players", players)

remote func _send_player_info(id, player_info):
	if is_network_master():
		players[id] = player_info
		rset("players", players)
		rpc("update_lobby")

func player_is_in_main_menu():
	return get_tree().get_current_scene().get_name() == "MainMenu"

func set_connection_index():
	connection_index = players.size()

func set_player_color():
	if connection_index == 1:
		Saved.saved_data["player"]["player_color"] = player_colors[0]
	if connection_index == 2:
		Saved.saved_data["player"]["player_color"] = player_colors[1]
	if connection_index == 3:
		Saved.saved_data["player"]["player_color"] = player_colors[2]
	if connection_index == 4:
		Saved.saved_data["player"]["player_color"] = player_colors[3]
	Saved.save_game()

func check_valid_connection():
	yield(get_tree().create_timer(.25), "timeout")
	
	if network.get_connection_status() == 2:
		print("povedlo se")
	else:
		get_tree().disconnect("connected_to_server", self, "_connected_to_server")
		get_tree().network_peer = null
		yield(get_tree().create_timer(.05), "timeout")
		network.close_connection()

func find_ip_adress():
	var _output = []
	var _exit_code = OS.execute("route", ['print'], true, _output)
	var output = _output[0]
	var right_line = ""
	var right_ip_address = ""

	var file = File.new()
	file.open("user://IpAddress.txt", File.WRITE)
	file.store_line(output)
	file.close()

	file.open("user://IpAddress.txt", File.READ)
	while not file.eof_reached():
		var line = file.get_line()
		line += " "
		if " 0.0.0.0 " in line:
			right_line = line
	file.close()

	file.open("user://IpAddress.txt", File.WRITE)
	var addresses = IP.get_local_addresses()
	for i in range(addresses.size()):
		if addresses[i] in right_line:
			right_ip_address = addresses[i]
			ip_adress = right_ip_address
	if right_ip_address == "":
		file.store_line("No connection to internet")
	else:
		file.store_line(right_ip_address)
	file.close()
