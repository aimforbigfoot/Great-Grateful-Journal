extends Node2D

signal back_btn_pressed

func _on_back_btn_pressed() -> void:
	emit_signal("back_btn_pressed")
