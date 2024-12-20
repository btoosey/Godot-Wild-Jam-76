class_name RunManager
extends Node2D

var ski_runs: Array
var world_timer: WorldTimer

var money_value_earned = {
	0: 2,
	1: 4,
	2: 8,
	3: 16
}

var money_tick_threshold = {
	0: 4,
	1: 5,
	2: 6,
	3: 8
}


func _ready() -> void:
	world_timer = %WorldTimer
	world_timer.money_tick.connect(_on_money_tick)


func get_runs_of_type(type) -> Array:
	var runs = []
	for i in ski_runs:
		if i.run_type == type:
			runs.append(i)
	return runs


func _on_money_tick() -> void:
	for run in ski_runs:
		run.money_tick_counter += 1
		if run.money_tick_counter == money_tick_threshold[run.run_type]:
			run.earn_money(money_value_earned[run.run_type])
			run.money_tick_counter = 0
