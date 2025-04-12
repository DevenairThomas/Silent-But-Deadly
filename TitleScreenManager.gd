extends CanvasLayer

class_name TitleScreenManager

# UI Elements
@onready var control : Control = $Control
@onready var btnStartGame : Button = $Control/buttonStart
@onready var btnOptions : Button = $Control/buttonOptions
@onready var btnExit : Button = $Control/buttonExit

@onready var popup_exit_game : PopupPanel = $popupExitGame

# Placeholder for future assets
var start_button_asset : Texture = null
var option_button_asset : Texture = null
var exit_button_asset : Texture = null

# Signals
signal on_start_selected
signal on_option_selected

func _ready():
	btnStartGame.pressed.connect(on_start_button_pressed)
	btnOptions.pressed.connect(on_option_button_pressed)
	btnExit.pressed.connect(on_exit_button_pressed)
	popup_exit_game.on_pop_up_exit_game.connect(_on_quit_game)
	
func show_ui():
	control.visible = true

func hide_ui():
	control.visible = false

func on_start_button_pressed():
	print("Start selected")
	emit_signal("on_start_selected")
	
func on_option_button_pressed():
	emit_signal("on_option_selected")
	
func on_exit_button_pressed():
	popup_exit_game.show()

func _on_quit_game():
	get_tree().quit()
