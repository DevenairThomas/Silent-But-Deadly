extends CanvasLayer

class_name UIManager

@onready var title_screen = $canvasTitleScreen
@onready var option_screen = $canvasOptions
@onready var hud_manager = $canvasHUD

enum GameState
{
	TITLE_SCREEN,
	LEVEL_SCREEN,
	OPTIONS,
	EXIT_GAME,
	GAME_MAIN,
	GAME_OVER,
	GAME_WIN
}

var current_state = GameState.TITLE_SCREEN

# Signals
signal game_state_changed(game_state: GameState)

func _ready():
	run_title_screen()
	title_screen.connect("on_start_selected", _on_start_game_pressed)
	title_screen.connect("on_option_selected", _on_option_selected)
	hud_manager.popup_exit_level.connect("on_pop_up_exit_confirm", _on_pop_up_exit_level)
	option_screen.connect("on_go_back",run_title_screen)


func _on_pop_up_exit_level():
	hud_manager.popup_exit_level.hide()
	run_title_screen()

func get_game_play_window() -> Rect2:
	return Rect2(hud_manager.hud_control.position, hud_manager.hud_control.size)

func run_title_screen():
	show_screen("canvasTitleScreen")
	current_state = GameState.TITLE_SCREEN
	emit_signal("game_state_changed", current_state)

func _on_start_game_pressed():
	show_screen("canvasHUD")
	current_state = GameState.GAME_MAIN
	emit_signal("game_state_changed", current_state)

func _on_option_selected():
	show_screen("canvasOptions")
	current_state = GameState.OPTIONS
	emit_signal("game_state_changed", current_state)
	
func _on_exit_play_pressed():
	run_title_screen()

func show_screen(screen_name: String):
	for child in get_children():
		if child is CanvasLayer:
			child.visible = child.name == screen_name

func get_current_state() -> GameState:
	return current_state

			
