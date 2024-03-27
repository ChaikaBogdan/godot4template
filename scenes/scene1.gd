extends Control


func _ready():
	Events.set_state.emit("Scene1")
	Events.save.emit()


func _on_back_button_button_up():
	print("\n[scene1] getting back to main")
	Events.set_state.emit("Main")
	SceneManager.switch_scene("main")
