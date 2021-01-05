extends Node

func get_movement_input() -> Vector2:
	var input : Vector2
	#Case for getting keyboard input
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return input
