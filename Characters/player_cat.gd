extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction :Vector2 = Vector2 (0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
var dash_cooldown : float  = 0

func _ready () : 
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	).normalized()
	
	update_animation_parameters(input_direction)
	
	if(Input.is_action_pressed("space") == true && dash_cooldown <= 0):
		velocity = (input_direction* move_speed)*20
		dash_cooldown = 5
	else:
		velocity = input_direction * move_speed
		if(0 < dash_cooldown and dash_cooldown <= 5 ):
			dash_cooldown = dash_cooldown - 0.025
		
	
	move_and_slide()
	
	pick_new_state()
	
func update_animation_parameters (move_input : Vector2): 
	if(move_input != Vector2.ZERO): 
		animation_tree.set ("parameters/Walk/blend_position",move_input)
		animation_tree.set ("parameters/Idle/blend_position",move_input)


func pick_new_state() : 
	if (velocity!=Vector2.ZERO) : 
		state_machine.travel("Walk")
	else :
		state_machine.travel("Idle")
