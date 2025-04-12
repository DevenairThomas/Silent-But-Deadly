extends Node

class_name GameLoopEngine

# Charging attributes
var charging : bool = false
var charge_increase : bool = true

# Meter attributes
var gas_pressure : float = 100.0
var charge_power : float = 0.0
var charge_rate  : float = 50.0

# Pressure attributes
var flow_coefficient : float = 0.5

# Audience attributes
var audience_reaction : float = 0.0
var sensitivity : float = 0.5			# easy = 0.5, hard = 1.5
var decision_threshold : float = 10.0 	# Minimum Response trigger

# Signals
signal on_charge_power_changed(power: float)
signal on_gas_pressure_changed(pressure: float)
signal on_reaction_changed(reaction: float)

func _ready():
	gas_pressure = 100.0

func _process(delta):
	if charging :
		increase_charge(delta)
		
func set_charging(charge: bool):
	charging = charge
	if charging == false:
		release_fart()

# Power meter will charge up, then down, then up (looping)
func increase_charge(delta):
	var initial_charge = charge_power
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
	if (initial_charge != charge_power):
		set_charge_power(charge_power)

# Release pressure from charge power
func release_fart():
	var released = pressure_released(charge_power, gas_pressure)
	gas_pressure = max(gas_pressure - released, 0.0)
	gas_pressure = clamp(gas_pressure, 0, 100)
	set_gas_pressure(gas_pressure)
	audience_reaction += detection_calculation(released)
	set_reaction(audience_reaction)
	print("Gas Pressure: ", gas_pressure, " Charge Power: ", charge_power)
	set_charge_power(0)
	

func detection_calculation(signal_strength: float) -> float:
	var raw := (signal_strength * sensitivity / 1) # Magic number is a placeholder value
	var normalized := (raw / decision_threshold) * 100.0
	return clamp(normalized, 0.0, 100.0)

func pressure_released(charge: float, current_pressure: float) -> float:
	var c := 0.5
	var a := charge / 100.0
	var q := c * a * sqrt(current_pressure)
	return q

# ============================= SETTERS/GETTERS ================================

func set_gas_pressure(pressure: float):
	gas_pressure = pressure
	emit_signal("on_gas_pressure_changed", pressure)

func set_charge_power(power: float):
	charge_power = power
	emit_signal("on_charge_power_changed", power)

func set_reaction(reaction: float):
	audience_reaction = reaction
	emit_signal("on_reaction_changed", audience_reaction)

# ==============================================================================
