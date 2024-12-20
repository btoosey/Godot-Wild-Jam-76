extends Node

@export var run_placement_manager: RunPlacement
@export var mountain: Mountain

@export var direction_dictionary = {
	"None": Vector2i(0, 0),
	"TopL": Vector2i(1, 0),
	"TopR": Vector2i(2, 0),
	"BotL": Vector2i(0, 1),
	"BotR": Vector2i(0, 2),
}


func _ready() -> void:
	run_placement_manager.run_created.connect(_on_run_created)


func _on_run_created(run) -> void:
		run.updated_run.connect(_on_updated_run.bind(run))
		update_run(run)


func _on_updated_run(run) -> void:
	update_run(run)


func update_run(run) -> void:
	var new_sprites = calculate_tile_sprites(run)
	for i in run.tiles.size():
		mountain.get_cell_layer(run.tiles[i]).set_cell(run.tiles[i], run_placement_manager.run_type + 2, new_sprites[i])


func calculate_tile_sprites(run) -> Array:
	var return_array = []

	for i in run.tiles.size():
		var start_vector:= Vector2i.ZERO

		if run.run_end_tile == run.run_start_tile:
			start_vector += direction_dictionary["None"]
		else:
			if i == 0:
				start_vector += direction_dictionary["None"]
			elif run.tiles[i] - run.tiles[i - 1] == Vector2i(1, 0):
				start_vector += direction_dictionary["TopL"]
			else:
				start_vector += direction_dictionary["TopR"]
			
			if i == run.tiles.size() - 1:
				start_vector += direction_dictionary["None"]
			elif run.tiles[i + 1] - run.tiles[i] == Vector2i(0, 1):
				start_vector += direction_dictionary["BotL"]
			else:
				start_vector += direction_dictionary["BotR"]

		if MountainTilesData.cell_tile_size_matrix[run.tiles[i].x][run.tiles[i].y] == 1:
			start_vector += Vector2i(0, 3)

		return_array.append(start_vector)
	return return_array
