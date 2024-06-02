extends Node2D

func _ready():
	randomize()
	rpc("spawn_players", Network.local_player_id, Network.connection_index)

sync func spawn_players(player_id, spawn_position_index):
	var new_player = preload("res://Player/Player.tscn").instance()
	new_player.name = str(player_id)

	var spawn_position = str("SpawnPosition"+str(spawn_position_index-1))
	new_player.position = get_node(spawn_position).position
	Network.path_to_PLAYERS.add_child(new_player)

