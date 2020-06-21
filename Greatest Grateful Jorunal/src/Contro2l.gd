extends Control

onready var delBtn := $HBoxContainer/DelBtn
onready var user_comment := $HBoxContainer/UserCommentLbl

func _ready() -> void:
#	rect_size.x = (get_parent().get_parent().get_size().x)
#	rect_size = get_parent().get_parent().get_size()
	delBtn.disabled = true 
	pass

func _on_DelBtn_pressed() -> void:
	queue_free()
	


func _on_DelBtn_mouse_entered() -> void:
	delBtn.disabled = false


func _on_DelBtn_mouse_exited() -> void:
	delBtn.disabled = true 


func _on_Control_mouse_exited():
	pass # Replace with function body.

