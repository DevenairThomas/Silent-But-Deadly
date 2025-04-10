extends Node

class_name AudienceManager

# Ref to HUD_UIManager
var ui_manager: HUD_UIManager

# Current audience notice level (0-100)
var notice_level: float = 0.0

# Rate at which the notice level naturally decreases when idle
var decay_rate: float = 5.0 # units per second

# Modifier that controls how quickly the notice_level increases from a fart
var sensitivity_modifier: float = 1.0

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

func _process(delta):
	# Slowly decrease notice level over time when not actively increased
	notice_level -= decay_rate * delta
	if ui_manager:
		ui_manager.set_audience_reaction_meter_value(notice_level)
	#else:
		#print("Audience reaction not created...")
	
func apply_fart_reaction(fart_decibels: float, fart_type: int):
	# Calculate the impact based on fart volume and smell severity
	var impact = (fart_decibels + fart_type) * sensitivity_modifier
	notice_level += impact
	if ui_manager:
		ui_manager.set_audience_reaction_meter_value(notice_level)
		print("Audience reaction increased by ", impact, " to ", notice_level)
	else:
		print("Audience reaction not created...")
	
func set_sensitivity(modifier: float):
	sensitivity_modifier = modifier

func set_decay_rate(rate: float):
	decay_rate = rate
	
func initialize(ui_manager_ref: HUD_UIManager):
	ui_manager = ui_manager_ref
