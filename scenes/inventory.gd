extends Control

@export var run_placement: RunPlacement


func _ready() -> void:
	for btn in get_children():
		btn.button_down.connect(_on_button_down.bind(btn))


func _on_button_down(btn) -> void:
	run_placement.run_type = btn.type
