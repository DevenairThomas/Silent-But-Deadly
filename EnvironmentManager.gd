extends Node
class_name EnvironmentManager

signal environment_changed

# Base attributes
var sound_dampening : float = 0.5
var smell_masking : float = 0.5

#var event_timeline : $EventTimeline

#func _ready():
#	event_sequence = EventSequence.new()
#	event_sequence.event_changed.connect(_on_event_changed)
#	add_child(event_sequence)
#	event_sequence.start()

func _on_event_changed(modifiers: Dictionary):
	environment_changed.emit

# Utility
func set_sound_dampening(value: float):
	sound_dampening = value

func set_smell_masking(value: float):
	smell_masking = value
	
func get_sound_dampening() -> float:
	return sound_dampening

func get_smell_masking() -> float:
	return smell_masking
