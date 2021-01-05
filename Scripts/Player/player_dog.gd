extends KinematicBody2D

#Acts as the players human form
#Can move and interact with human interactable items

const MAX_SPEED := 40.0
const ACCELERATION := 50.0
const GRAVITY := 98.0

var under_player_controll := true
var facing_right := true
var velocity := Vector2(0,0)
var target_x = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if under_player_controll:
		#Code to run if the player can controll their movement
		#Obviously this shouldnt be running if the player is in a cutscene
		horizontal_movement(delta)
		vertical_movement(delta)
		test_flip()
		move_and_slide(velocity)
		do_animation()
		attempt_interaction()
		if Input.is_action_just_pressed("toggle_inventory"):
			get_tree().get_nodes_in_group("InventoryPannel")[0].toggle_inventory()
	else:
		do_animation()
		if(target_x != null):
			var target_x_dif = target_x -global_position.x 
			var dir_x = clamp(target_x_dif,-1,1)
			velocity.x = dir_x * MAX_SPEED 
			test_flip()
			move_and_slide(velocity)
			
			if(abs(target_x_dif) <= 5):
				velocity.x = 0
				target_x = null
				CutsceneController.actor_finished_cutscene_action(self)

func set_player_cutscene_mode(var eyy : bool):
	under_player_controll = not eyy

#Handles movement on the horisontal axis
func horizontal_movement(var delta):
	#Get input direction
	var input = InputManager.get_movement_input()
	var target_x_velocity = input.x * MAX_SPEED
	velocity.x = lerp(velocity.x,target_x_velocity,ACCELERATION * delta)

#Handles movement on vertical axis
#If floor cast is colliding, move to that collision point and cancel out vertical velocity
#Otherwise accelerate downwards
func vertical_movement(var delta):
	if $FloorCast.is_colliding():
		global_position.y = $FloorCast.get_collision_point().y
		velocity.y = 0
	else:
		velocity.y += GRAVITY * delta

#Tests to see if the player should flip their facing direction
func test_flip():
	if facing_right and velocity.x < -1:
		flip()
	elif !facing_right and velocity.x > 1:
		flip()

#flips the player facing dierection
func flip():
	facing_right = !facing_right
	$SpriteAxis.scale.x = -$SpriteAxis.scale.x 

func attempt_interaction():
	if(Input.is_action_just_pressed("interact")):
		var overlaping_objects = $InteractionTestBox.get_overlapping_areas()
		if(overlaping_objects.size() == 0):
			return
		else:
			overlaping_objects[0].interact("dog_%s" % PlayerInventory.selected_item)

func do_animation():
	if abs(velocity.x) > 1:
		$AnimationPlayer.switch_animation("Walk")
	else:
		$AnimationPlayer.switch_animation("Idle")

func move_to_x(var x_pos):
	target_x = x_pos
	under_player_controll = false
	velocity.x = 0