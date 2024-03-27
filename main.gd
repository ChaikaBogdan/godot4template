extends Node2D

@onready var health = Global.health
@onready var achievements = Global.achievements
@onready var state_machine = $StateMachine


func _ready():
	Events.load.emit()
	Events.set_state.connect(_on_set_state_signal)
	_on_set_state_signal("Main")


func _on_exit_button_button_up():
	# https://docs.godotengine.org/en/stable/tutorials/inputs/handling_quit_requests.html
	SceneManager.quit_game()


func _on_save_button_button_up():
	Events.debug.emit("pre-saving")
	Events.save.emit()


func _on_load_button_button_up():
	Events.debug.emit("pre-loading")
	Events.load.emit()
	_update()


func _update():
	queue_redraw()


func _on_next_scene_button_up():
	SceneManager.switch_scene("scene1")
	state_machine.transition_to("State1")


func _on_set_state_signal(new_state_name):
	state_machine.transition_to(new_state_name)
