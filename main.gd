extends Node2D

# Fart pressure variables
var fart_level : float = 0.0
var fart_rate : float = 10.0

# Fart charge variables
var fart_charge : float = 0.0
var fart_charging: bool = false
var charge_power : float = 0.4

# Fart attributes 
var fart_decibels : float = 0.0
var fart_smell_level : float = 0.0
enum FartType
{
	NONE,
	UNNOTICABLE,
	PEE_YEW,
	STINKY,
	VILE,
	DEATH
}
var fart_smell : FartType = FartType.NONE

# Audience AI
enum AudienceReaction
{
	NONE,        # No one notices anything.
	SUSPICIOUS,  # Some sniffing or minor suspicion.
	ALERT,       # Audience visibly reacting; looking around.
	DISGUSTED,   # Audience clearly disgusted; audible groans.
	PANIC        # Full panic; audience actively fleeing or complaining.
}
var current_reaction : AudienceReaction = AudienceReaction.NONE

# UI Elements
@onready var fart_meter = $UI/FartMeter
@onready var power_meter = $UI/PowerMeter

func _process(delta):
	fart_level_increase(delta)
	charge_fart(fart_charging)
	fart_charge = clamp(fart_charge, 0, 100)
	power_meter.value = fart_charge
	if fart_level >= 100:
		game_over()
		
# Detect inputs
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				fart_charging = true
			else:
				fart_charging = false

# Increase fart pressure over time
func fart_level_increase(delta):
	fart_level += fart_rate * delta
	fart_level = clamp(fart_level, 0, 100)
	fart_meter.value = fart_level

# Control the fart charge power
func charge_fart(charge: bool):
	if charge == true:
		fart_charge += charge_power
		release_fart()
	else:
		fart_charge -= charge_power

func calculate_fart_stink():
	match fart_smell:
		FartType.NONE:
			print("No Smell")
		FartType.UNNOTICABLE:
			print("Unnoticable Smell")
		FartType.PEE_YEW:
			print("Pee Yew Smell")
		FartType.STINKY:
			print("Stinky Smell")
		FartType.VILE:
			print("Vile Smell")
		FartType.DEATH:
			print("Death Smell")
			

# Release fart based on charge value
func release_fart():
	fart_level -= fart_charge/10.0
	fart_level = clamp(fart_level, 0, 100)
	fart_meter.value = fart_level
	print("Fart released Current level: ", fart_level)

# The function
func game_over():
	print("GAME OVER: Player Exploded")
	get_tree().paused = true
