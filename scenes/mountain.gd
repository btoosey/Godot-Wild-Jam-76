class_name Mountain
extends Node2D


func get_cell_layer(coords) -> TileMapLayer:
	var layer
	for tile_map_layer in get_children():
		var used_cells = tile_map_layer.get_used_cells()
		if used_cells.has(coords):
			layer = tile_map_layer
	return layer
