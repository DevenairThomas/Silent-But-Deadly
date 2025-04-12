extends CanvasLayer

class_name OptionUIManager

# Initialize UI Elements
@onready var btn_back_to_title : Button = $controlOptions/buttonBack
@onready var btn_save_options : Button = $controlOptions/SaveContainer/buttonSaveOptions

@onready var option_list : VBoxContainer = $controlOptions/vboxOptionList
#@onready var menu_btn_screen_mode : MenuButton = option_list.get_node("OptionFullScreen/hbox/menubtnScreenMode")
#@onready var menu_btn_resolution : MenuButton = option_list.get_node("OptionResolution/hbox/menubtnResolution")
@onready var slider_music : HSlider = option_list.get_node("OptionMusic/hbox/sliderMusic")
@onready var slider_sfx : HSlider = option_list.get_node("OptionSFX/hbox/sliderSFX")
@onready var checkbox_fart_sounds : CheckBox = option_list.get_node("OptionFart/hbox/hboxCheckbox/checkboxSound")
@onready var checkbox_fart_visual : CheckBox = option_list.get_node("OptionFart/hbox/hboxCheckbox/checkboxVisual")
@onready var btn_reset_game_data : Button = option_list.get_node("OptionResetData/hbox/hboxResetGameData/buttonReset")

# Enums
enum FullScreenOptions
{
	FULLSCREEN,
	WINDOWED,
	BORDERLESS
}

enum ResolutionOptions
{
	Res_2560x1440,
	Res_1920x1080,
	Res_1366x768,
	Res_1280x720,
	Res_1920x1200,
	Res_1680x1050,
	Res_1440x900,
	Res_1280x800,
	Res_1024x768,
	Res_800x600,
	Res_640x480
}

# Initialize Variables
var current_screen_option       : FullScreenOptions
var current_screen_resolution   : ResolutionOptions
var current_music_level         : float
var current_sfx_level           : float
var current_fart_sound_check    : bool
var current_fart_visual_check   : bool

# Signal
signal on_go_back

func _ready():
	# Connect signals
	btn_save_options.pressed.connect(_on_save_pressed)
	btn_back_to_title.pressed.connect(_on_back_pressed)
	btn_reset_game_data.pressed.connect(_on_reset_pressed)

	#menu_btn_screen_mode.item_selected.connect(_on_screen_mode_selected)
	#menu_btn_resolution.item_selected.connect(_on_resolution_selected)

	slider_music.value_changed.connect(_on_music_slider_changed)
	slider_sfx.value_changed.connect(_on_sfx_slider_changed)
	checkbox_fart_sounds.toggled.connect(_on_fart_sounds_toggled)
	checkbox_fart_visual.toggled.connect(_on_fart_visual_toggled)

func _on_screen_mode_selected(index: int) -> void:
	current_screen_option = index
	print("Screen mode selected:", FullScreenOptions.keys()[index])

func _on_resolution_selected(index: int) -> void:
	current_screen_resolution = index
	print("Resolution selected:", ResolutionOptions.keys()[index])

func _on_music_slider_changed(value: float) -> void:
	current_music_level = value
	print("Music level changed to:", value)

func _on_sfx_slider_changed(value: float) -> void:
	current_sfx_level = value
	print("SFX level changed to:", value)

func _on_fart_sounds_toggled(checked: bool) -> void:
	current_fart_sound_check = checked
	print("Fart sounds toggled:", checked)

func _on_fart_visual_toggled(checked: bool) -> void:
	current_fart_visual_check = checked
	print("Fart visual toggled:", checked)

func _on_save_pressed() -> void:
	print("Saving options...")
	# This is where you'd write to a file or a config, but for now just log
	var config = {
		"screen_mode": FullScreenOptions.keys()[current_screen_option],
		"resolution": ResolutionOptions.keys()[current_screen_resolution],
		"music_level": current_music_level,
		"sfx_level": current_sfx_level,
		"fart_sounds": current_fart_sound_check,
		"fart_visual": current_fart_visual_check
	}
	print("Saved config:", config)

func _on_back_pressed() -> void:
	emit_signal("on_go_back")

func _on_reset_pressed() -> void:
	print("Reset game data pressed.")
