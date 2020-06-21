extends Node

var data_path := "user://sentences.dat"
var date_path := "user://date.dat"
var file := File.new()
var tempp := []


func save_data(arr_of_data : Array, arr_of_date : Array):
	file.open(data_path, File.WRITE)
	file.store_var(arr_of_data)
	file.close()
	file.open(date_path, File.WRITE)
	file.store_var(arr_of_date)
	file.close()


func load_date_data() -> Array:
	var arr_of_date = []
	file.open(date_path, File.READ)
	arr_of_date = file.get_var()
	file.close()
	print(arr_of_date)
	return arr_of_date


func load_data_data() -> Array:
	var arr_of_data = []
	file.open(data_path, File.READ)
	arr_of_data = file.get_var()
	file.close()
	print(arr_of_data)
	return arr_of_data


func is_file_there() -> bool:
	var state : bool = false
	var temp1 : bool = false
	var temp2 : bool = false
	if file.file_exists(data_path):
		temp1 = true
	if file.file_exists(date_path):
		temp2 = true
	if temp1 and temp2:
		state = true
#	print(state)
	return state
