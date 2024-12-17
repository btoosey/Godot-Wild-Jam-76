extends Node

var cell_height_matrix =[]
var cell_availability_matrix =[]


func initialize_matrices(height, width) -> void:
	for i in width:
		cell_height_matrix.append([])
		cell_availability_matrix.append([])
		for j in height:
			cell_height_matrix[i].append(0.0)
			cell_availability_matrix[i].append(false)


func update_height_matrix(x, y, value) -> void:
	cell_height_matrix[x][y] = value


func update_availability_matrix(x, y, value) -> void:
	cell_height_matrix[x][y] = value
