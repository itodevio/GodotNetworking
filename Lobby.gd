extends Node2D

func _ready():
	get_tree().connect('network_peer_connected', self, '_player_connected')

func _player_connected(id):
	print('Player connceted to the server!')
	$Label.text += '\n' + str(id)
	#Game on!
	globals.otherPlayerId.append(id)
	

func _on_buttonHost_pressed():
	print("Hosting Network")
	var host = NetworkedMultiplayerENet.new()
	var res = host.create_server(4242, 4)
	if res != OK:
		print("Error creating server")
		return
	
	$buttonJoin.hide()
	$buttonHost.disabled = true
	get_tree().set_network_peer(host)


func _on_buttonJoin_pressed():
	print("Joining network")
	var host = NetworkedMultiplayerENet.new()
	host.create_client("127.0.0.1", 4242)
	get_tree().set_network_peer(host)
	$buttonHost.hide()
	$buttonJoin.disabled = true


func _on_buttonStart_pressed():
	start_game()

master func start_game():
	rpc("start_game_all")
	
sync func start_game_all():
	var game = preload('res://Game.tscn').instance()
	get_tree().get_root().add_child(game)
	hide()