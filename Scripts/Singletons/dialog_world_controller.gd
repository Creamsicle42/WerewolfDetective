extends Node

const DIALOG_PATH_TEMPLATE := "res://DialogScripts/%s.json"

var is_in_cutscene := false

func _ready():
	add_to_group("actor_dialog")


func cutscene_dialog(var script_path:String):
	open_dialog(script_path)
	is_in_cutscene = true

func open_dialog(var script_path:String):
	var completed_path = DIALOG_PATH_TEMPLATE % script_path
	var parser = WhiskersParser.new(self)
	var data = parser.open_whiskers(completed_path)
	var dialog_UI = get_tree().get_nodes_in_group("DialogBox")[0]
	dialog_UI.begin_dialog(parser,data)

func set_talksprite(var id):
	var dialog_UI = get_tree().get_nodes_in_group("DialogBox")[0]
	dialog_UI.set_talksprite(TalkspriteDictionary.get_talksprite(id))

func end_dialog():
	if(is_in_cutscene):
		CutsceneController.actor_finished_cutscene_action(self)
		is_in_cutscene = false

func add_item(id):
	PlayerInventory.add_item(id)
	