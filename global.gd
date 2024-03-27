# Global singleton to store global state, consts and variables
# Game logic should not be stored here... too much
# https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
extends Node

# https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html
# Windows: %APPDATA%\Godot\app_userdata\[project_name]
# macOS: ~/Library/Application Support/Godot/app_userdata/[project_name]
# Linux: ~/.local/share/godot/app_userdata/[project_name]

enum States { STATE1, STATE2 }

const SAVE_FILE = "user://state.save"

@onready var health = 100
@onready
var achievements = {"Achievement #1": false, "Achievement #2": false, "Achievement #3": false}
@onready var scene = "main"
@onready var state = "Main"


func _ready():
	Events.save.connect(_on_save_signal)
	Events.load.connect(_on_load_signal)
	Events.state.connect(_on_new_state_signal)
	Events.scene.connect(_on_new_scene_signal)


# Mixed saving system (binary data + objects) to prevent save files modifications
# https://www.gdquest.com/tutorial/godot/best-practices/save-game-formats/
func export_save(file: FileAccess) -> void:
	file.store_64(health)
	file.store_line(var_to_str(scene))
	print("[save] scene: ", scene)
	file.store_line(var_to_str(state))
	print("[save] state: ", state)
	file.store_var(achievements)


func import_save(file: FileAccess) -> void:
	health = file.get_64()
	scene = str_to_var(file.get_line())
	print("[load] scene: ", scene)
	state = str_to_var(file.get_line())
	print("[load] state: ", state)
	achievements = file.get_var()


func _on_save_signal():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	export_save(file)
	file.close()


func _on_load_signal():
	if not FileAccess.file_exists(SAVE_FILE):
		_on_save_signal()
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	import_save(file)
	file.close()


func _on_new_scene_signal(new_scene_name):
	scene = new_scene_name


func _on_new_state_signal(new_state_name):
	state = new_state_name
