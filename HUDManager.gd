extends CanvasLayer

class_name HUDManager

# UI Elements
@onready var hud_control : 	  Control 	  = $HUDContainer
@onready var selectable_area : BoxContainer = $HUDContainer/SelectableArea
@onready var pressure_meter : ProgressBar = $HUDContainer/hboxContainerPressure/PressureMeter
@onready var charge_meter :   ProgressBar = $HUDContainer/hboxContainerCharge/ChargeMeter
@onready var reaction_meter : ProgressBar = $HUDContainer/ReactionWrapper/ReactionMeter


# Placeholder for futur assets
var pressure_meter_asset : Texture = null
var charge_meter_asset 	 : Texture = null
var reaction_meter_asset : Texture = null

# Constants for layout : placeholder

func _ready():
	# Create and add UI elements
	pressure_meter.value = 100
	_position_ui_elements()
	get_tree().root.connect("size_changed", _on_window_resized)

func _position_ui_elements():
	DisplayServer.window_get_size()
	
func show_ui():
	hud_control.visible = true

func hide_ui():
	hud_control.visible = false

func _on_window_resized():
	_position_ui_elements()

func get_pressure_meter() -> ProgressBar:
	return pressure_meter

func get_charge_meter() -> ProgressBar:
	return charge_meter

func get_audience_reaction_meter() -> ProgressBar:
	return reaction_meter
	
