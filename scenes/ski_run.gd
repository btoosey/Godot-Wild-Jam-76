class_name SkiRun
extends Node

signal updated_run(run)

var tiles: Array = []
var run_start_tile: Vector2i
var run_end_tile: Vector2i
var run_type: int


func initialize(type, coords) -> void:
	run_type = type
	tiles.append(coords)
	run_start_tile = coords
	run_end_tile = coords


func run_length() -> int:
	return tiles.size()


func run_avg_slope() -> float:
	var sum:= 0.0
	for tile in tiles:
		if tile + 1:
			sum += MountainTilesData.cell_height_matrix[tile.x][tile.y] - MountainTilesData.cell_height_matrix[(tile + 1).x][(tile + 1).y]
	var average_slope = sum / tiles.size()
	return average_slope


func add_cell(cell) -> void:
	tiles.append(cell)
	update_start_end_tiles()
	updated_run.emit(self)


func update_start_end_tiles() -> void:
	for tile in tiles:
		if MountainTilesData.cell_height_matrix[tile.x][tile.y] > MountainTilesData.cell_height_matrix[run_start_tile.x][run_start_tile.y]:
			run_start_tile = tile
		if MountainTilesData.cell_height_matrix[tile.x][tile.y] < MountainTilesData.cell_height_matrix[run_end_tile.x][run_end_tile.y]:
			run_end_tile = tile
