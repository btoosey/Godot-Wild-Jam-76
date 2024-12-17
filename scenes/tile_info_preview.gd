class_name TileInfoPreview
extends Control

@export var tile_selector: TileSelector
@export var mountain: Mountain

@onready var tile_availability_label: Label = $TileAvailabilityLabel
@onready var tile_height_label: Label = $TileHeightLabel


func _ready() -> void:
	tile_selector.current_cell_changed.connect(_on_current_cell_changed)


func _on_current_cell_changed(coords) -> void:
	if coords == null:
		tile_availability_label.text = "?"
		tile_height_label.text = "?"
	else:
		tile_availability_label.text = str(MountainTilesData.cell_availability_matrix[coords.x][coords.y])
		tile_height_label.text = str(snapped(1 - MountainTilesData.cell_height_matrix[coords.x][coords.y], 0.001) * 3000) + "m"
	
