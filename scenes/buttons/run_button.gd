class_name run_button
extends TextureButton

@export var stats: RunButtonStats : set = set_stats

var type


func set_stats(value: RunButtonStats) -> void:
	stats = value

	if value == null:
		return

	if not is_node_ready():
		await ready

	texture_normal = stats.normal_image
	type = stats.type
