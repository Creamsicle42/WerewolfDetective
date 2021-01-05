extends Sprite

#Forces a sprite to be on the pixel grid

func _process(delta):
	var ideal_gpos := Vector2(round(global_position.x),round(global_position.y))
	offset = global_position - ideal_gpos
