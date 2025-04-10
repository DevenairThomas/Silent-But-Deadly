extends Node

class_name FartController







func update_fart_charge():
	if fart_charging:
		fart_charge += charge_power
		fart_charge = clamp(fart_charge, 0, 100)
	else:
		fart_charge -= charge_power
		fart_charge = clamp(fart_charge, 0, 100)

func release_fart(sound_modifier: float, smell_modifier: float):
	fart_level -= fart_charge / 10.0
	fart_level = clamp(fart_level, 0, 100)
	print("Fart released. Current level:", fart_level)
