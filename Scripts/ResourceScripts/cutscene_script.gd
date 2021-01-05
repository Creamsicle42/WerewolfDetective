extends Resource
class_name CutsceneScript
#Holds data that can be used by the cutscene controller singleton

#Acts as a container for all the sequence beats
#A sequence beat is an array of cutscene instructions
#ALL ELEMENTS MUST BE OF TYPE ARRAY
export var sequence := []

func get_sequence(var ID:int) -> Array:
	if(sequence.size() <= ID):
		return []
	return sequence[ID]