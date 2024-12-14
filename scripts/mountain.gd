class_name Mountain
extends Node2D

var mountain_layers: Array

func _ready() -> void:
	mountain_layers = get_mountain_layers()

func get_mountain_layers() -> Array:
	return get_children()
