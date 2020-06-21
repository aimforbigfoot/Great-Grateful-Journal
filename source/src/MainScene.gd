extends Node2D

onready var settings_btn := $Settings
onready var back_btn := $back_btn
onready var anim_player := $AnimationPlayer
var arr_of_settings_vals := []


func _on_Settings_pressed() -> void:
	settings_btn.visible = false
	back_btn.visible = true
	anim_player.play("come_in_settings")


func _on_Timer_timeout() -> void:
	anim_player.play("start_anim")


func _on_back_btn_pressed() -> void:
	settings_btn.visible = true
	back_btn.visible = false
#	settings_save.settings_save_data(arr_of_settings_vals)
	anim_player.play("bye_settings")
