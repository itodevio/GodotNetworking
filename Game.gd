extends Node2D

func _ready():
	#criando o player "local"
	var thisPlayer = preload("res://Player.tscn").instance()
	thisPlayer.set_name(str(get_tree().get_network_unique_id()))
	thisPlayer.set_network_master(get_tree().get_network_unique_id())
	add_child(thisPlayer)
	
	#criando os outros players
	for i in range(globals.otherPlayerId.size()):
		
		var otherPlayer = preload("res://Player.tscn").instance()
		otherPlayer.set_name(str(globals.otherPlayerId[i]))
		otherPlayer.set_network_master(globals.otherPlayerId[i])
		add_child(otherPlayer)