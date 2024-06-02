extends Control

onready var player_list_ITEM_LIST = $CenterContainer/VBoxContainer/PlayerList
onready var players_LABEL = $CenterContainer/VBoxContainer/PlayersLabel
onready var used_ip_port_LABEL = $UsedIpPort
onready var MAIN_MENU = $"../MainMenu"				#vedlejsi hlavni menu

func _ready():
	player_list_ITEM_LIST.clear()

func _physics_process(_delta):
	if TranslationServer.get_locale() == "cs" or TranslationServer.get_locale() == "cs_CZ":
		players_LABEL.text = "Hráči: " + str(Network.players.size()) + "/4"
	if TranslationServer.get_locale() == "en":
		players_LABEL.text = "Players: " + str(Network.players.size()) + "/4"

func refresh_players(players):
	player_list_ITEM_LIST.clear()
	for player_id in players:
		var player = players[player_id]["player"]["player_name"]
		player_list_ITEM_LIST.add_item(player, null, false)

func _on_BackButton_pressed():
	hide()
	MAIN_MENU.show()
	$"/root/Sounds".get_node("Click").play()

	if is_network_master():
		rpc("host_left_lobby")
	else:
		get_tree().call_group("Lobby", "on_player_connectivity_status_changed", Saved.saved_data["player"]["player_name"], "has disconnected...", Network.connection_index)
		yield(get_tree().create_timer(.05), "timeout")
		remove_me_from_lobby()

sync func host_left_lobby():
	remove_me_from_lobby()

func remove_me_from_lobby():
	hide()
	MAIN_MENU.show()

	get_tree().call_group("Lobby", "set_player_shadow_color")
	get_tree().call_group("ChatBox", "clear_chat_box")

	Network.players.clear()
	Network.connection_index = 0

	get_tree().disconnect("connected_to_server", self, "_connected_to_server")
	get_tree().network_peer = null
	yield(get_tree().create_timer(.05), "timeout")
	Network.network.close_connection()

func _on_Lobby_visibility_changed():
	used_ip_port_LABEL.text = str(Network.ip_adress) + "-" + str($"../../.."._port)

func chat_box(player_id, connection_index):
	var player_name = Network.players[player_id]["player"]["player_name"]
	$ChatBox._set_name(player_name, connection_index)

func on_player_connectivity_status_changed(player_id, message, index):
	#							username, text, group
	$ChatBox.rpc("add_message", str(player_id), message, index-1)

func set_player_shadow_color():
	if visible:
		$"../PlayerShadow".modulate = Network.player_colors[Network.connection_index-1]
	if not visible:
		$"../PlayerShadow".modulate = "#1c121c"

func show_or_hide():
	if get_node("/root/Debug").is_on_server():
		if is_network_master():
			get_tree().call_group("HostOnly", "show")
			get_tree().call_group("ClientOnly", "hide")
		if not is_network_master():
			get_tree().call_group("HostOnly", "hide")
			get_tree().call_group("ClientOnly", "show")















