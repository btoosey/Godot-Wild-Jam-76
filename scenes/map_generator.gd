class_name MapGenerator
extends Node2D

@export var width: float
@export var height: float
@export var steepness: float = 2
@export var mountain: Mountain
@export var min_tree_intensity: float = 0.22
@export var max_tree_intensity: float = 0.17


var tree_coverage_noise = FastNoiseLite.new()


func _ready() -> void:
	generate_map()


func generate_map() -> void:
	MountainTilesData.initialize_matrices(height, width)
	
	var max_distance = sqrt(pow(width - 1, 2) + pow(height - 1, 2))
	for i: int in width:
		for j: int in height:
			var white_noise_value = randf_range(0.97, 1)

			var value = calculate_tile_height_value(i, j, max_distance)

			var cell_noise_value: float = value * white_noise_value
			
			MountainTilesData.update_height_matrix(i, j, cell_noise_value)

			if cell_noise_value >= 0.9:
				set_layer_cell(0, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value >= 0.78:
				set_layer_cell(1, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value >= 0.68:
				set_layer_cell(2, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value >= 0.64:
				set_layer_cell(2, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
			elif cell_noise_value >= 0.55:
				set_layer_cell(3, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value >= 0.53:
				set_layer_cell(3, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
			elif cell_noise_value >= 0.45:
				set_layer_cell(4, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value >= 0.37:
				set_layer_cell(4, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
			elif cell_noise_value >= 0.3:
				set_layer_cell(5, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value >= 0.25:
				set_layer_cell(5, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
			elif cell_noise_value >= 0.2:
				set_layer_cell(6, Vector2i(i, j), Vector2i(0, 0))
			elif cell_noise_value >= 0.15:
				set_layer_cell(6, Vector2i(i, j), Vector2i(1, 0))
				set_as_half_tile(i, j)
				MountainTilesData.cell_tile_size_matrix[i][j] = 1
			elif cell_noise_value >= 0.08:
				set_layer_cell(7, Vector2i(i, j), Vector2i(0, 0))


func average(value_1: float, value_2: float) -> float:
	return (value_1 + value_2) / 2


func calculate_tile_height_value(i, j, max_distance) -> float:
	var distance = sqrt((i ** 2) + (j ** 2))
	var normalised_distance = distance / max_distance
	return exp(-steepness * normalised_distance)


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
	MountainTilesData.update_to_local_matrix(coords.x, coords.y, mountain.get_child(layer).map_to_local(coords))
	var cell_has_tree = tree_coverage(coords)
	mountain.get_child(layer).set_cell(coords, cell_has_tree, tileset_coords)
	if cell_has_tree == 0:
		MountainTilesData.cell_availability_matrix[coords.x][coords.y] = true


func set_as_half_tile(x, y) -> void:
		MountainTilesData.cell_tile_size_matrix[x][y] = 1
