extends Node2D

var fart_level : float = 0.0
var fart_rate : float = 5.0
var release_rate : float = 5.0

@onready var fart_meter = $UI/FartMeter

func _process(delta):
	fart_level += fart_rate * delta
	fart_level = clamp(fart_level, 0, 100)
	fart_meter.value = fart_level
	if fart_level >= 100:
		game_over()
		
func _input(event):
	if event is InputEventMouseButton:
		if event.is_ctrl_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				release_fart(true)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				release_fart(true)
		else:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				release_fart(true)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				release_fart(false)
	elif event is InputEventMagnifyGesture:
		if event.factor > 1.0: #Touchpad fingers spread
			release_fart(true)
			print("Hit spread")
		if event.factor < 1.0: #Touchpad pinch
			release_fart(false)
			print("Hit pinch")
	else:
		release_fart(false)
		print("Hit input event screen touch equals false")
		
func release_fart(release: bool):
	if release == true:
		fart_level -= release_rate
		fart_level = clamp(fart_level, 0, 100)
		fart_meter.value = fart_level
		print("Fart released Current level: ", fart_level)
	
func game_over():
	print("GAME OVER: Player Exploded")
	get_tree().paused = true
	
