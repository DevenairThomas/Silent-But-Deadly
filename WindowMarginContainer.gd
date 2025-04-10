extends MarginContainer

@onready var top_toolbar := $VBoxContainer/TopToolbar
@onready var center_row := $VBoxContainer/CenterRow
@onready var left_meter := $VBoxContainer/CenterRow/LeftMeter
@onready var right_meter := $VBoxContainer/CenterRow/RightMeter
@onready var bottom_bar := $VBoxContainer/BottomBar
# Constants
const MARGIN_PERCENT := 0.04

func _ready():
	call_deferred("_finalize_layout")
	get_tree().root.connect("size_changed", Callable(self, "_update_margins"))

func _update_margins():
	var viewport_size = get_viewport().get_visible_rect().size
	var margin = int(viewport_size.x * MARGIN_PERCENT)

	add_theme_constant_override("margin_left", margin)
	add_theme_constant_override("margin_top", margin)
	add_theme_constant_override("margin_right", margin)
	add_theme_constant_override("margin_bottom", margin)

	# If you're using containers inside this MarginContainer,
	# they will now layout their children within these margins.
	# Ensure child Control nodes do not use absolute positioning.

func _finalize_layout():
	_update_margins()

	# Now it's safe to access and modify children
	var top_toolbar = $VBoxContainer/TopToolbar
	var bottom_bar = $VBoxContainer/BottomBar
	var left_meter = $VBoxContainer/CenterRow/LeftMeter
	var right_meter = $VBoxContainer/CenterRow/RightMeter

	if top_toolbar:
		top_toolbar.custom_minimum_size = Vector2(0, 40)
	if bottom_bar:
		bottom_bar.custom_minimum_size = Vector2(0, 30)
	if left_meter:
		left_meter.custom_minimum_size = Vector2(40, 0)
		left_meter.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	if right_meter:
		right_meter.custom_minimum_size = Vector2(40, 0)
		right_meter.size_flags_horizontal = Control.SIZE_EXPAND_FILL
