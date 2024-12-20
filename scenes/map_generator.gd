class_name MapGenerator
extends Node2D

@export var width: float
@export var height: float
@export var mountain: Mountain
@export var min_tree_intensity: float = 0.22
@export var max_tree_intensity: float = 0.17

var tree_coverage_noise = FastNoiseLite.new()


func _ready() -> void:
	generate_map()


func generate_map() -> void:
	MountainTilesData.initialize_matrices(height, width)

	for i: int in width:
		for j: int in height:
			var white_noise_value = randf_range(0.95, 1)
			var width_val = (1 / width) * i
			var height_val = (1 / height) * j
			var cell_noise_value: float = average(width_val, height_val) * white_noise_value
			
			MountainTilesData.update_height_matrix(i, j, cell_noise_value)

			if cell_noise_value <= 0.1:
				set_layer_cell(0, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value <= 0.14:
				set_layer_cell(1, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value <= 0.18:
				set_layer_cell(2, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value <= 0.22:
				set_layer_cell(3, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value <= 0.26:
				set_layer_cell(4, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value <= 0.276:
				set_layer_cell(4, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
			elif cell_noise_value <= 0.33:
				set_layer_cell(5, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value <= 0.4:
				set_layer_cell(5, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
			elif cell_noise_value <= 0.48:
				set_layer_cell(6, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value <= 0.58:
				set_layer_cell(6, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
				MountainTilesData.cell_tile_size_matrix[i][j] = 1
			elif cell_noise_value <= 0.8:
				set_layer_cell(7, Vector2i(i, j), Vector2i(0, 0))


func average(value_1: float, value_2: float) -> float:
	return (value_1 + value_2) / 2


func tree_coverage(coordinates: Vector2i) -> int:
	#Calculates tree coverage based on perlin noise map value

	tree_coverage_noise.seed = randi()
	tree_coverage_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	tree_coverage_noise.frequency = 0.3

	if tree_coverage_noise.get_noise_2d(coordinates[0], coordinates[1]) > tree_coverage_intensity():
		return 1
	else:
		return 0


func tree_coverage_intensity() -> float:
	return randf_range(max_tree_intensity, min_tree_intensity)


func set_layer_cell(layer: int, coords: Vector2i, tileset_coords: Vector2i) -> void:
	MountainTilesData.cell_layer_matrix[coords.x][coords.y] = layer
	var cell_has_tree = tree_coverage(coords)
	mountain.get_child(layer).set_cell(coords, cell_has_tree, tileset_coords)
	if cell_has_tree == 0:
		MountainTilesData.cell_availability_matrix[coords.x][coords.y] = true


func set_as_half_tile(x, y) -> void:
		MountainTilesData.cell_tile_size_matrix[x][y] = 1
