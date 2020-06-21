extends Control

export var max_character_limit := 120
onready var txtEdit := $LineEdit
onready var submit := $SubmitBtn
onready var error_text := $error_text
onready var scrollBox := $ScrollContainer
onready var anim_player := $AnimationPlayer
onready var vboxContainer := $ScrollContainer/VBoxContainer
var user_strings_arr = []
var date_arr = []



func _ready() -> void:
	if !SaveScript.is_file_there():
		pass
	else:
		user_strings_arr = SaveScript.load_data_data()
		date_arr = SaveScript.load_date_data()
		for num in user_strings_arr.size():
			var new_block := preload("res://src/Contro2l.tscn").instance()
			new_block.get_child(0).get_child(0).text = user_strings_arr[num]
			new_block.get_child(0).get_child(1).text = date_arr[num]
			vboxContainer.add_child_below_node(vboxContainer.get_child(0), new_block)
	pass

func _input(event: InputEvent) -> void:
	var temp1 : String = txtEdit.text
	if event.is_action_pressed("enter"):
		insert_text()
	
	if event.is_action_pressed("up") and !txtEdit.text == "" and vboxContainer.get_child_count() >1:
		txtEdit.text = vboxContainer.get_child(1).get_child(0).get_child(0).text
		vboxContainer.get_child(1).queue_free()
#	if event.is_action_pressed("r"):
#		get_tree().reload_current_scene()
#	if event.is_action_pressed("t"):
#		save_everything()


func _on_SubmitBtn_pressed() -> void:
	insert_text()
	

func insert_text() -> void:
	var settable := true
	var new_text : String = txtEdit.text
#	print(new_text.length())
	if new_text.length() >= max_character_limit:
		set_error_text("You exceded the max limit of " +  str(max_character_limit) + " characters. \n This modification helps you be more precise.")
	elif new_text.length() <= 0:
		set_error_text("You need to type some text, you can't leave it empty :(")
	else:
		
		var new_block := preload("res://src/Contro2l.tscn").instance()
		var day_var : String = str(OS.get_date()["day"])
		var year_var : String = str(OS.get_date()["year"])
		var month_var : String = str(OS.get_date()["month"])
		new_block.get_child(0).get_child(0).text = new_text
		new_block.get_child(0).get_child(1).text = (month_var + ", " + day_var + ", " + year_var)

#		Check if they said grateful 
		if !new_text.findn("grateful") == -1:
			set_error_text("""Please refrain from saying \"grateful\" or \"I am grateful\" as it helps with saving 
			and indexing all the texts. Alternatively, you can say \"my life, my family\", instead of 
			the entire grateful part. Please and thank you! """)
			settable = false
#			print("found grateful")
		else:
#			print(new_text.findn("grateful", 0))
#			print("no grateful put in") 
			new_block.get_child(0).get_child(0).text = ("I am grateful for " + new_text).to_lower()

#		Check if there is a similar text
		for texts in user_strings_arr:
			if texts.to_lower() == ("I am grateful for " + new_text).to_lower():
				set_error_text("Sorry, but you have already inputed this message")
				settable = false
#			var temp1 :String= str(texts.format(str(""), str("I am grateful for")))
#			print(temp1)
#			print(texts.erase(0,17))
			
		if settable:
			vboxContainer.add_child_below_node(vboxContainer.get_child(0), new_block)
			txtEdit.text = clear_text()
			save_everything()


func clear_text() -> String:
	var my_str := ""
	return my_str


func set_error_text(inputed_string : String) -> void:
	error_text.text = inputed_string
	anim_player.seek(0, true)
	anim_player.play("text_fade")
	pass



func _on_Control_tree_exiting() -> void:
	save_everything()
	pass


func save_everything() -> void:
	user_strings_arr.clear()
	date_arr.clear()
	for child in vboxContainer.get_children():
		if child.is_in_group("ignore"):
			continue
		else:
			user_strings_arr.push_front(child.get_child(0).get_child(0).text)
			date_arr.push_front(child.get_child(0).get_child(1).text)
#			print(child)
#	print(user_strings_arr, date_arr)
	SaveScript.save_data(user_strings_arr, date_arr)
	pass


func _on_Settings_control_erase_now() -> void:
	for child in vboxContainer.get_children():
		if child.is_in_group("ignore"):
			continue
		else:
			child.queue_free()
