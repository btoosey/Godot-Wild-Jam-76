class_name RunPlacement
extends Node2D

signal run_created(run)

@export var tile_selector: TileSelector
@export var mountain: Mountain
var run_type
@export var ski_runs: RunManager
var single_ski_runs: Array[SkiRun]

var hovered_cell

enum RunTypeSelection {GREEN, BLUE, RED, BLACK}

func _ready() -> void:
	tile_selector.current_cell_changed.connect(_on_cell_hovered)


func _on_cell_hovered(coords) -> void:
	if coords == null:
		hovered_cell = null
	else:
		hovered_cell = coords


func _input(event: InputEvent) -> void:
	if hovered_cell == null:
		return

	if MountainTilesData.cell_availability_matrix[hovered_cell.x][hovered_cell.y] == false:
		return

	if event.is_action_pressed("select_tile"):
		if run_type == null:
			return

		if ski_runs.ski_runs.is_empty():
			create_new_run(hovered_cell)
		else:
			var valid_neighbours = get_valid_neighbours(hovered_cell)
			if valid_neighbours.is_empty():
				create_new_run(hovered_cell)
			else:
				check_for_joinable_runs(hovered_cell, valid_neighbours)


func get_valid_neighbours(cell) -> Array:
	var matching_runs = []
	for run in ski_runs.get_children():
		for neighbour in get_surrounding_cells(cell):
			if run.run_type == run_type and run.tiles.has(neighbour):
				matching_runs.append(run)
	return matching_runs


func get_surrounding_cells(coords) -> Array:
	var cell_layer = mountain.get_cell_layer(coords)
	return cell_layer.get_surrounding_cells(coords)


func create_new_run(cell_coords) -> void:
	var new_run = SkiRun.new()
	ski_runs.add_child(new_run)
	ski_runs.ski_runs.append(new_run)
	single_ski_runs.append(new_run)
	new_run.initialize(run_type, cell_coords)
	for run in ski_runs.ski_runs:
		print(run.tiles)
	run_created.emit(new_run)


func check_for_joinable_runs(cell, runs) -> void:
	for run in runs:
		if MountainTilesData.cell_height_matrix[cell.x][cell.y] < MountainTilesData.cell_height_matrix[run.run_start_tile.x][run.run_start_tile.y] or MountainTilesData.cell_height_matrix[cell.x][cell.y] > MountainTilesData.cell_height_matrix[run.run_end_tile.x][run.run_end_tile.y]:
			if cell - run.run_start_tile == Vector2i(-1, 1) or cell - run.run_start_tile == Vector2i(1, -1) or cell - run.run_end_tile == Vector2i(-1, 1) or cell - run.run_end_tile == Vector2i(1, -1):
				create_new_run(cell)
			else:
				run.add_cell(cell)
				return
		else:
			continue
