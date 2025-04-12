extends PopupPanel

class_name ExitPlayPopupManager

@onready var btn_confirm : Button = $VBoxContainer/HBoxContainer/buttonConfirm
@onready var btn_decline : Button = $VBoxContainer/HBoxContainer/buttonDecline

signal on_pop_up_exit_play

func _ready():
	btn_confirm.pressed.connect(exit_play)
	btn_decline.pressed.connect(resume_play)

func exit_play():
	emit_signal("on_pop_up_exit_play")

func resume_play():
	self.hide()
