class_name RunManager
extends Node2D

var ski_runs: Array


func get_runs_of_type(type) -> Array:
	var runs = []
	for i in ski_runs:
		if i.run_type == type:
			runs.append(i)
	return runs
