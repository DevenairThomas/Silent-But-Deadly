extends Node2D

# Initialize Game Objects
@onready var hud_manager = $UI/canvasHUD
@onready var environment_manager = $LevelEnvironment/EnvironmentManager
@onready var audience_manager = $AudienceSystem/AudienceManager
@onready var player_controller = $PlayerCharacter/PlayerCharacterController

# Attributes
var charging : bool = false
var charge_increase : bool = true

var gas_pressure : float = 0.0
var charge_power : float = 0.0
var charge_rate  : float = 50.0

func _process(delta):
	increase_charge(delta)
	
# ==============================================================================
# ============================== GAME LOOP =====================================
# ==============================================================================
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				charging = true
			if not event.pressed:
				charging = false
				release_fart()

# Power meter will charge up, then down, then up (looping)
func increase_charge(delta):
	if charging: 
		if charge_increase:
			charge_power += charge_rate * delta
			if charge_power >= 100:
				charge_power = 100
				charge_increase = false
		else:
			charge_power -= charge_rate * delta
			if charge_power <= 0:
				charge_power = 0
				charge_increase = true
	hud_manager.charge_meter.value = charge_power

# Release pressure from charge power
func release_fart():
	gas_pressure = hud_manager.pressure_meter.value
	gas_pressure -= charge_power
	gas_pressure = clamp(gas_pressure, 0, 100)
	hud_manager.pressure_meter.value = gas_pressure
	print("Gas Pressure: ", gas_pressure, " Charge Power: ", charge_power)

# GAME OVER
func game_over():
	print("GAME OVER: Player Exploded")
	get_tree().paused = true
# ==============================================================================
