extends Control

signal erase_now
var arr_of_settings_dat : Array = [true, 16]
onready var dbl_check_btn := $ScrollContainer/all_container/VBoxContainer2/dbl_check_btn
onready var particles_btn := $ScrollContainer/all_container/VBoxContainer/particles_btn
onready var export_btn := $ScrollContainer/all_container/Export/export_button
onready var slider_lbl := $ScrollContainer/all_container/size_of_text/slider_label
onready var slider_itself := $ScrollContainer/all_container/size_of_text/HSlider
onready var particles := $Particles2D

func _ready() -> void:
	if settings_save.is_file_there():
#		in the array, first value is particle bool and second is text size
		arr_of_settings_dat = settings_save.load_settings_data()
		change_text_size(arr_of_settings_dat[1], false)
		slider_itself.value = arr_of_settings_dat[1]
		particles_btn.pressed = arr_of_settings_dat[0]
		
	else:
		change_text_size(16, false)
		


func _on_particles_btn_toggled(button_pressed: bool) -> void:
	if button_pressed:
		arr_of_settings_dat[0] = true
		particles.emitting = true 
	else:
		arr_of_settings_dat[0] = false
		particles.emitting = false
	save_settings_data()
#	print(button_pressed, arr_of_settings_dat)
	



func _on_export_button_pressed() -> void:
	OS.alert("Sorry, this is still a work in progress. I will be updating this link very soon.", "Hey wait a minute")
#	replace with youtube video that explains how to import and export data
#	OS.shell_open("https://youtube.com/")
	pass


func _on_HSlider_value_changed(value: float) -> void:
	change_text_size(value, true)


func change_text_size(value : float, save_time : bool) -> void:
	slider_lbl.text = ("Text Size: " +(str(value)))
	var resource := preload("res://assets/fonts/all_editable_texts.tres")
	resource.size = value
	arr_of_settings_dat[1] = value
	if save_time:
		save_settings_data()

func _on_Settings_back_btn_pressed() -> void:
	save_settings_data()


func save_settings_data() -> void:
	settings_save.save_data(arr_of_settings_dat)


func _on_data_btn_pressed() -> void:
	$ScrollContainer/all_container/VBoxContainer2/dbl_check_btn.visible = true

func _on_dbl_check_btn_pressed() -> void:
	$ScrollContainer/all_container/VBoxContainer2/confirm_label.visible = true
	emit_signal("erase_now")

