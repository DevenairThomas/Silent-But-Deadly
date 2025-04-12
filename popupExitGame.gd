extends PopupPanel

class_name ExitGameManager

@onready var btn_confirm : Button = $VBoxContainer/HBoxContainer/buttonConfirm
@onready var btn_decline : Button = $VBoxContainer/HBoxContainer/buttonDecline

signal on_pop_up_exit_game

func _ready():
	btn_confirm.pressed.connect(exit_)
	btn_decline.pressed.connect(resume_)

func exit_():
	emit_signal("on_pop_up_exit_game")

func resume_():
	self.hide()
