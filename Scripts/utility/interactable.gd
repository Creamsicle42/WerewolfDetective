extends Area2D

export (Resource) var default_script

export var item_interactions := {}

func interact(var item):
	if item == null:
		CutsceneController.begin_cutscene(default_script)
		return
	if not item_interactions.has(item):
		CutsceneController.begin_cutscene(default_script)
		return
	CutsceneController.begin_cutscene(item_interactions[item])