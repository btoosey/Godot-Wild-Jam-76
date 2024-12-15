class_name CameraScreenshot
extends Node

#TODO change path to game title in this script and in project settings
#Test to see if this works in html5 export
func _ready() -> void:
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("screenshot"):
		screenshot()


func screenshot() -> void:
	await RenderingServer.frame_post_draw

	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	var timestamp = Time.get_datetime_string_from_system(false, true).replace(":", "-")
	img.save_png("user://screenshots/gwj76-" + timestamp + ".png")
