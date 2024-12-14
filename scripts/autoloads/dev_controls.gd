extends Node

var is_fullscreen:= false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_fullscreen"):
		if is_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			is_fullscreen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			is_fullscreen = true
		get_viewport().set_input_as_handled()
