# Event bus using autoloaded singleton
# https://www.gdquest.com/tutorial/godot/design-patterns/event-bus-singleton/
extends Node

signal debug(value)
signal save
signal load
signal state(new_state_name)
signal set_state(new_state_name)
signal scene(new_scene_name)


func _ready():
	# We can connect Events singleton to its own signals too, for example, for logging
	debug.connect(_on_debug_signal)
	save.connect(_on_save_signal)
	load.connect(_on_load_signal)
	state.connect(_on_new_state_signal)
	scene.connect(_on_new_scene_signal)


func _on_debug_signal(value):
	# Game logic should not be stored in Events, its just an event bus between distant scenes and nodes
	print("[events] debug: {value}".format({"value": value}))


func _on_save_signal():
	print("[events] saving game...")


func _on_load_signal():
	print("[events] loading game...")


func _on_new_state_signal(new_state_name):
	print("[events] new state: ", new_state_name)


func _on_new_scene_signal(new_signal_name):
	print("[events] new scene: ", new_signal_name)
