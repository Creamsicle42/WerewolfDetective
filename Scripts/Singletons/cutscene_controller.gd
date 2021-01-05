extends Node

const ACTOR_NAME_FORMAT := "actor_%s"

var current_cutscene : CutsceneScript
var step_on := 0

var current_waiting_actors := []


func begin_cutscene(var script:CutsceneScript):
	var player = get_tree().get_nodes_in_group("player")[0]
	player.set_player_cutscene_mode(true)
	if current_cutscene == null:
		current_cutscene = script
		step_on = 0
		run_step()

func run_step():
	var cur_seq := current_cutscene.get_sequence(step_on)
	if cur_seq.size() == 0:
		current_cutscene = null
		var player = get_tree().get_nodes_in_group("player")[0]
		player.set_player_cutscene_mode(false)
		return
	for i in cur_seq:
		var actor = get_tree().get_nodes_in_group(ACTOR_NAME_FORMAT % i.actor_tag)[0]
		var expression = Expression.new()
		expression.parse(i.instruction)
		expression.execute([], actor)
		print_debug("sending instruction to %s"%(ACTOR_NAME_FORMAT % i.actor_tag))
		if i.wait_till_end:
			current_waiting_actors.append(actor)

func actor_finished_cutscene_action(var actor):
	if not current_waiting_actors.has(actor):
		return
	current_waiting_actors.erase(actor)
	if(current_waiting_actors.size() == 0):
		step_on += 1
		run_step()