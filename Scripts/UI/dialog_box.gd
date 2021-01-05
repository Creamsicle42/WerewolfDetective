extends Control

const OPTION_BUTTON_PATH := "res://Assets/Scenes/UI/Dialog/DialogButton.tscn"

var current_parser : WhiskersParser
var current_data : Dictionary
var current_block : Dictionary

onready var text_box = get_node("MarginContainer/HBoxContainer/VBoxContainer/MainText")
onready var button_box = get_node("MarginContainer/HBoxContainer/VBoxContainer/SelectionButtons")

func begin_dialog(var parser : WhiskersParser, var dialog : Dictionary):
	current_parser = parser
	current_data = dialog
	current_block = parser.start_dialogue(current_data)
	set_box_visible(true)
	set_text_portion()

func set_text_portion():
	set_button_box_visible(false)
	set_text_visible(true)
	text_box.bbcode_text = current_block["text"]
	

func set_button_portion():
	if current_block["options"].size() == 0:
		
		advance_dialog()
		return
	set_text_visible(false)
	set_button_box_visible(true)
	
	var button_file = preload(OPTION_BUTTON_PATH)
	for i in current_block["options"]:
		var b = button_file.instance()
		b.text = i["text"]
		b.connect("pressed",self,"advance_dialog",[i["key"]])
		button_box.add_child(b)

func advance_dialog(var id = ""):
	for i in button_box.get_children():
		i.queue_free()
	
	if(id == ""):
		current_block = current_parser.next()
	else:
		current_block = current_parser.next(id)
	if not current_block.has("text"):
		#TODO: Add in dialog closing
		set_box_visible(false)
		DialogWorldController.end_dialog()
		return
	set_text_portion()
	

func set_talksprite(var sprite):
	$MarginContainer/HBoxContainer/TextureRect.texture = sprite

func set_box_visible(var vis:bool):
	visible = vis

func set_text_visible(var vis:bool):
	text_box.visible = vis

func set_button_box_visible(var vis:bool):
	button_box.visible = vis