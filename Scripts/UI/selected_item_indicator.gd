extends NinePatchRect


func set_indicator(var item_code:String):
	$CenterContainer/TextureRect.texture = ItemTextureDict.get_item_texture(item_code)