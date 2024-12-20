class_name TileSelector
extends Node2D

signal current_cell_changed(coords)

@export var enabled:= true
@export var map_generator: MapGenerator
@export var mountain: Mountain

var mountain_layers: Array
var mouse_pos: Vector2
var hovered_rids: Array = []


func _ready() -> void:
	mountain_layers = mountain.get_children()


func _physics_process(_delta):
	mouse_pos = get_global_mouse_position()

	var params = PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true
	params.position = mouse_pos
	var intersections = get_world_2d().direct_space_state.intersect_point(params)
	if intersections == hovered_rids:
		return
	else:
		hovered_rids = intersections
		get_highest_cell_coords(hovered_rids)


func get_highest_cell_coords(rids) -> void:
	var highest_cell_coords = null

	for rid in rids:
		var selection = rid.collider.get_coords_for_body_rid(rid.rid)
		if highest_cell_coords == null:
			highest_cell_coords = selection
		else:
			if selection - highest_cell_coords > Vector2i(0,0):
				highest_cell_coords = selection

	current_cell_changed.emit(highest_cell_coords)
