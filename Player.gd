extends Node2D

slave func setPosition(pos):
	position = pos

master func shutItDown():
	#manda o comando de shutdown pra todos os clients conectados, incluindo esse
	rpc("shutDown")

sync func shutDown():
	get_tree().quit()

func _process(delta):
	var moveByX = 0
	var moveByY = 0
	
	if(is_network_master()):
		if Input.is_key_pressed(KEY_LEFT):
			moveByX = -5
		if Input.is_key_pressed(KEY_RIGHT):
			moveByX = 5
		if Input.is_key_pressed(KEY_UP):
			moveByY = -5
		if Input.is_key_pressed(KEY_DOWN):
			moveByY = 5	
			
		if Input.is_key_pressed(KEY_Q):
			if get_tree().is_network_server():
				shutItDown()
			
		#Diz aos outros clients a nossa nova posição, para ele atualizar:
		rpc_unreliable("setPosition", Vector2(position.x - moveByX, position.y))
	
	translate(Vector2(moveByX, moveByY))