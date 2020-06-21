extends Node


var settings_path := "user://settings.dat"
var file := File.new()


func save_data(arr_of_settings_data : Array):
	file.open(settings_path, File.WRITE)
	file.store_var(arr_of_settings_data)
	file.close()


func load_settings_data() -> Array:
	var arr_of_data = []
	file.open(settings_path, File.READ)
	arr_of_data = file.get_var()
	file.close()
	print(arr_of_data)
	return arr_of_data



func is_file_there() -> bool:
	var state : bool = false
	if file.file_exists(settings_path):
		state = true
#	print(state)
	return state
