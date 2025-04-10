extends Node

class_name PlayerCharacterController

@onready var fart_controller : FartController = $"../FartController"
@onready var animation_controller = $"AnimationController"
@onready var sprite = $"PlayerSprite"

# Signal to communicate fart results back to main
signal start_charging
signal release_charge

func handle_input(event):
	

func update(delta):
	fart_controller.increase_fart_level(delta)
	fart_controller.update_fart_charge()

func release_fart():
	# Get the charged fart power
	var fart_power = fart_controller.fart_charge
	
	# Emit signal to main with the fart_power, main will handle external managers
	emit_signal("fart_released", fart_power)
