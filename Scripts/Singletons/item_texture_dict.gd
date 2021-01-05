extends Node

var item_dict := {
	"":null,
	"test":preload("res://Assets/Sprites/Items/TestItem.png"),
}

func get_item_texture(var id: String) -> Texture:
	return item_dict[id]