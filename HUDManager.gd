extends CanvasLayer

class_name HUDManager

# UI Elements
@onready var hud_control : Control          = $HUDContainer
@onready var pressure_meter : ProgressBar   = $HUDContainer/hboxContainerPressure/PressureMeter
@onready var charge_meter :   ProgressBar   = $HUDContainer/hboxContainerCharge/ChargeMeter
@onready var reaction_meter : ProgressBar   = $HUDContainer/ReactionWrapper/ReactionMeter

@onready var btn_exit_play : Button         = $ToolbarContainer/BackButton
@onready var btn_menu : Button              = $ToolbarContainer/MenuButton

@onready var popup_exit_level : PopupPanel  = $HUDContainer/popupExitPlay

# Placeholder for Level Information stuff
@onready var level_information : RichTextLabel = $ToolbarContainer/LevelInformationLabel

# Placeholder for futur assets
var pressure_meter_asset : Texture = null
var charge_meter_asset 	 : Texture = null
var reaction_meter_asset : Texture = null

# Constants for layout : placeholder

func _ready():
	# Create and add UI elements
	pressure_meter.value = 100
	btn_exit_play.pressed.connect(on_exit_play_button_pressed)

func on_exit_play_button_pressed():
	popup_exit_level.show()
	
func show_ui():
	hud_control.visible = true

func hide_ui():
	hud_control.visible = false

func get_pressure_meter() -> ProgressBar:
	return pressure_meter

func get_charge_meter() -> ProgressBar:
	return charge_meter

func get_audience_reaction_meter() -> ProgressBar:
	return reaction_meter
	
