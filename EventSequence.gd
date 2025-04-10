extends Node

class_name EventSequence

signal event_changed(modifiers: Dictionary)

var events : Array = []
var current_index : int = 0

var json_path : String = ""

func _ready():
	# If a JSON path is preset, try to load it
	if json_path != "":
		load_events_from_json(json_path)
	# Default event
	events = [
		{"sound_dampening": 1.0, "smell_masking": 0.0, "duration": 5.0},
		{"sound_dampening": -0.5, "smell_masking": 0.0, "duration": 8.0},
	]

func set_json_path(path: String):
	json_path = path
	load_events_from_json(json_path)
	
func load_events_from_json(path: String):
	var file  = FileAccess.open(path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var parsed = JSON.parse_string(json_text)
		if parsed is Array:
			events = parsed
			current_index = 0
			print("Event sequence loaded successfully from: " + path)
		else:
			push_error("Invalid JSON format: expected an array")
	else:
		push_error("Failed to open JSON file: " + path)

func start():
	if events.size() > 0:
		_run_next_event()
		
func _run_next_event():
	if current_index >= events.size():
		return
	
	var event = events[current_index]
	event_changed.emit(event)
	
	var timer = Timer.new()
	timer.wait_time = event.get("duration", 5.0)
	timer.one_shot = true
	timer.timeout.connect(_on_event_end)
	add_child(timer)
	timer.start()
	
func _on_event_end():
	event_changed.emit({ "sound_dampening": 0.0, "smell_masking": 0.0 })
	current_index += 1
	_run_next_event()
	
