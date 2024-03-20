extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 10
@onready var animation_tree = $AnimationTree

@onready var state_machine = animation_tree.get("parameters/playback")


@export var move_speed : float = 75

func _physics_process(_delta):
	pass
	

	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"),
	)

	input_direction = input_direction.normalized()
	velocity = input_direction * move_speed
	move_and_slide()

	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		$Sprite2D.flip_h = true
	
	pick_new_state()

func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	if Input.is_action_pressed("mouse_left"):
		# Ensure that the attack animation continues until it finishes
		state_machine.travel("attack_right")
	elif (velocity==Vector2.ZERO):
		state_machine.travel("Idle")

func player():
	pass






func update_health():
	var healthbar = $HealthBar
	healthbar.value = health
	
	if health >= 10:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regentimer_timeout():
	if health < 10:
		health = health + 2
		if health > 10:
			health = 10
	if health <= 0:
		health = 0

func player_shop_method():
	pass
