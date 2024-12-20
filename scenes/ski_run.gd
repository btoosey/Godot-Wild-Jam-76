class_name SkiRun
extends Node

signal updated_run

var tiles: Array = []
var run_start_tile: Vector2i
var run_end_tile: Vector2i
var run_type: int

var money_tick_counter:= 0


func initialize(type, coords) -> void:
	run_type = type
	add_cell(coords)


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
	sort_tiles()
	update_start_end_tiles()
	MountainTilesData.cell_availability_matrix[cell.x][cell.y] = false
	updated_run.emit()


func update_start_end_tiles() -> void:
	run_start_tile = tiles[0]
	run_end_tile = tiles[-1]


func sort_tiles() -> void:
	tiles.sort_custom(sort_descending_height)


func sort_descending_height(a, b):
	if MountainTilesData.cell_height_matrix[a.x][a.y] < MountainTilesData.cell_height_matrix[b.x][b.y]:
		return true
	return false

func earn_money(value) -> void:
	PlayerData.player_money += value
