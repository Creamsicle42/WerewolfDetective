extends AnimationPlayer

#allows for the swithing of animations without causing the first frame to repeat over and over

var _current_animation := ""

func switch_animation(var target: String):
	if target == _current_animation:
		return
	assert has_animation(target)
	play(target)
