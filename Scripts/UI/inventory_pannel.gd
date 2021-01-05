extends MarginContainer

const ITEM_PANNEL_PATH := "res://Assets/Scenes/UI/Inventory/InventoryItemDisplay.tscn"
const SELECTED_SPRITE_PATH := "NinePatchRect/MarginContainer/VBoxContainer/NinePatchRect2/HBoxContainer/NinePatchRect/CenterContainer/TextureRect"
const SELECTED_TEXT_PATH := "NinePatchRect/MarginContainer/VBoxContainer/NinePatchRect2/HBoxContainer/VBoxContainer/RichTextLabel"
const SELECTED_DISPLAY_PATH := "NinePatchRect/MarginContainer/VBoxContainer/NinePatchRect2"

var menu_is_open := false
var cur_selected_item_index := -1

onready var item_grid_cont := $NinePatchRect/MarginContainer/VBoxContainer/GridContainer



func inventory_item_entered_focus(var index):
	var item_code = PlayerInventory.inventory[index]
	get_node(SELECTED_SPRITE_PATH).texture = ItemTextureDict.get_item_texture(item_code)
	get_node(SELECTED_TEXT_PATH).bbcode_text = item_code
	get_node(SELECTED_DISPLAY_PATH).visible = true
	cur_selected_item_index = index

func toggle_inventory():
	if(menu_is_open):
		menu_is_open = false
		visible = false
		get_node(SELECTED_DISPLAY_PATH).visible = false
	else:
		clear_item_grid()
		for i in PlayerInventory.inventory.size():
			add_item_pannel(i)
		menu_is_open = true
		get_node(SELECTED_DISPLAY_PATH).visible = false
		visible = true

func clear_item_grid():
	for i in item_grid_cont.get_children():
		i.queue_free()

func add_item_pannel(var index):
	var new_button = preload(ITEM_PANNEL_PATH).instance()
	var item_code = PlayerInventory.inventory[index]
	#TODO: set up button image
	new_button.set_sprite(ItemTextureDict.get_item_texture(item_code))
	#TODO: hook up clicked on to indicate on the bottom pannel
	new_button.connect("pressed",self,"inventory_item_entered_focus",[index])
	#TODO: add to the grid pannel
	item_grid_cont.add_child(new_button)

func _on_EquipButton_pressed():
	var item_code = PlayerInventory.inventory[cur_selected_item_index]
	PlayerInventory.set_selected_item(item_code)
	toggle_inventory()
