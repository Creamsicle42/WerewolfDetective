extends Node

var inventory := []
var selected_item := ""

func set_selected_item(var item : String):
	selected_item = item
	var item_display = get_tree().get_nodes_in_group("SelectedItemDisplay")[0]
	item_display.set_indicator(item)

func has_item(var id : String) -> bool:
	return inventory.has(id)

func add_item(var id : String):
	if inventory.has(id):
		return
	inventory.append(id)

func remove_item(var id : String):
	inventory.remove(inventory.find(id))
	if selected_item == id:
		set_selected_item("")