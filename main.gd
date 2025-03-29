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
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			release_fart()
			
func release_fart():
	fart_level -= release_rate
	fart_level = clamp(fart_level, 0, 100)
	fart_meter.value = fart_level
	print("Fart released Current level: ", fart_level)
	
func game_over():
	print("GAME OVER: Player Exploded")
	get_tree().paused = true
	
