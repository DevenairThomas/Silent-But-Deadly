extends Node2D

# Game Objects
@onready var ui_manager = $UI
@onready var game_loop_engine = $GameLoopEngine
@onready var environment_manager = $LevelEnvironment/EnvironmentManager
@onready var audience_manager = $AudienceSystem/AudienceManager
@onready var player_controller = $PlayerCharacter/PlayerCharacterController

# Winning/Losing Conditions
var fully_noticed : bool = false
var no_pressure : bool = false

var current_state : UIManager.GameState
var play_area : Rect2

func _ready():
	ui_manager.connect("game_state_changed", _on_game_state_changed)

	game_loop_engine.connect("on_charge_power_changed", _on_charge_power_changed)
	game_loop_engine.connect("on_gas_pressure_changed", _on_gas_pressure_changed)
	game_loop_engine.connect("on_reaction_changed", _on_reaction_changed)

func _process(delta):
	calculate_conditions()

func _input(event):
	if current_state == UIManager.GameState.GAME_MAIN:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					var click_position = event.position
					var bounds = ui_manager.get_game_play_window()
					print("Play Area: ", play_area, "Click Position: ", click_position)
					if bounds.has_point(click_position):
						game_loop_engine.set_charging(true)
				if not event.pressed:
					game_loop_engine.set_charging(false)

func _on_game_play_window_changed(window: Rect2):
	print("hit")
	play_area = window

func _on_game_state_changed(game_state: UIManager.GameState):
	current_state = game_state

func _on_charge_power_changed(power: float):
	ui_manager.hud_manager.charge_meter.value = power

func _on_gas_pressure_changed(pressure: float):
	ui_manager.hud_manager.pressure_meter.value = pressure

func _on_reaction_changed(reaction: float):
	ui_manager.hud_manager.reaction_meter.value = reaction

func calculate_conditions():
	if fully_noticed:
		game_over()
	if no_pressure:
		game_win()

func observe_conditions(pressure: float, reaction: float):
	if pressure <= 0.0:
		no_pressure = true
	if reaction >= 100.0:
		fully_noticed = true

func game_win():
	print("GAME WIN!")
	get_tree().paused = true

func game_over():
	print("GAME OVER: Player Exploded")
	get_tree().paused = true
