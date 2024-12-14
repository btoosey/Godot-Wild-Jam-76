class_name MapGenerator
extends Node2D

@export var width: float
@export var height: float
var mountain_noise_map: Array[float]
@onready var mountain: Mountain = $Mountain


func _ready() -> void:
	generate_map()


func generate_map() -> void:
	for i: int in width:
		for j: int in height:
			var white_noise_value = randf_range(0.95, 1)
			var width_val = (1 / width) * i
			var height_val = (1 / height) * j
			var cell_noise_value: float = average(width_val, height_val) * white_noise_value
			mountain_noise_map.append(cell_noise_value)

			if cell_noise_value <= 0.1:
				mountain.get_child(0).set_cell(Vector2i(i - 16, j - 16), 0, Vector2i(0, 0))
			elif cell_noise_value <= 0.14:
				mountain.get_child(1).set_cell(Vector2i(i - 15, j - 15), 0, Vector2i(0, 0))
			elif cell_noise_value <= 0.18:
				mountain.get_child(2).set_cell(Vector2i(i - 14, j - 14), 0, Vector2i(0, 0))
			elif cell_noise_value <= 0.22:
				mountain.get_child(3).set_cell(Vector2i(i - 13, j - 13), 0, Vector2i(0, 0))
			elif cell_noise_value <= 0.26:
				mountain.get_child(4).set_cell(Vector2i(i - 12, j - 12), 0, Vector2i(0, 0))
			elif cell_noise_value <= 0.276:
				mountain.get_child(4).set_cell(Vector2i(i - 12, j - 12), 0, Vector2i(1, 0))
			elif cell_noise_value <= 0.33:
				mountain.get_child(5).set_cell(Vector2i(i - 11, j - 11), 0, Vector2i(0, 0))
			elif cell_noise_value <= 0.4:
				mountain.get_child(5).set_cell(Vector2i(i - 11, j - 11), 0, Vector2i(1, 0))
			elif cell_noise_value <= 0.48:
				mountain.get_child(6).set_cell(Vector2i(i - 10, j - 10), 0, Vector2i(0, 0))
			elif cell_noise_value <= 0.58:
				mountain.get_child(6).set_cell(Vector2i(i - 10, j - 10), 0, Vector2i(1, 0))
			elif cell_noise_value <= 0.75:
				mountain.get_child(7).set_cell(Vector2i(i - 9, j - 9), 0, Vector2i(0, 0))


func average(value_1: float, value_2: float) -> float:
	return (value_1 + value_2) / 2
