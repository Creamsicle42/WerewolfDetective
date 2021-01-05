extends NinePatchRect

signal pressed

func _ready():
	$Button.connect("pressed",self,"emit_signal",["pressed"])

func set_sprite(var sprite : Texture):
	$CenterContainer/TestItem.texture = sprite
