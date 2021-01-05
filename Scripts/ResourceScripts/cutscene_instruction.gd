extends Resource
class_name CutsceneInstruction

#Acts as a single instruction to be used for a cutscene

#The tag held by the actor
#Tags should be unique, if not the first one in the scene higherarchy will be selected
export (String) var actor_tag

#Name of the method to be called in the actor
export (String) var instruction

#Should this contribute to pausing the cutscene till completed
export (bool) var wait_till_end