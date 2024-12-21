class_name SkiRun
extends Node

signal updated_run


var text_particle = preload("res://scenes/text_particle.tscn")

var tiles: Array = []
var run_start_tile: Vector2i
var run_end_tile: Vector2i
var run_type: int
var money_tick_counter:= 0

var run_colour = {
	0: "#159115",
	1: "#1b5acf",
	2: "#cf1b2b",
	3: "#000000"
}


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
	if MountainTilesData.cell_height_matrix[a.x][a.y] > MountainTilesData.cell_height_matrix[b.x][b.y]:
		return true
	return false

func earn_money(value) -> void:
	create_text_particle(value)
	PlayerData.player_money += value

func create_text_particle(value) -> void:
	var particle = text_particle.instantiate()
	particle.particle_text = str(value)
	particle.particle_text_colour = run_colour[run_type]
	particle.position = MountainTilesData.cell_to_local_matrix[run_end_tile.x][run_end_tile.y] - (Vector2(0, 16) * (7 - MountainTilesData.cell_layer_matrix[run_end_tile.x][run_end_tile.y]))
	add_child(particle)
	
