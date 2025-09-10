#meta-name: Character default template
#meta-description: Predefined movement, input, etc.
#meta-space-indent: 4

extends CharacterBody2D

@export_category("Movement Variables")
@export var movement_speed: float = 2000.0
@export var air_speed: float = 1500.0
@export var jump_speed: float = 80.0
@export var gravity: float = 100.0
@export var dashing_distance: float = 0.0

@export_category("Defensive Variables")
@export var max_health: int = 1000
@export var defense_modifier: float = 1.0

var is_dashing: bool = false
var has_dashed: bool = false
var is_attacking: bool = false
var is_stuned: bool = false
var current_health: float = max_health
var offense_modifier: float = 1.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	pass


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_movement(delta)
	handle_jump()
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta

func handle_movement_input() -> float:
	return Input.get_axis("move_left", "move_right")
func handle_dash_input() -> bool:
	return Input.is_action_pressed("block") && Input.get_axis("move_left", "move_right") != 0
func handle_movement(delta: float) -> void:
	velocity.x = 0
	if !is_attacking:
		if handle_movement_input() < 0:
			if !is_on_floor():
				velocity.x = -air_speed * delta
			else:
				velocity.x = -movement_speed * delta
		elif handle_movement_input() > 0:
			if !is_on_floor():
				velocity.x = air_speed * delta
			else:
				velocity.x = movement_speed * delta

func handle_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")
func handle_jump() -> void:
	if handle_jump_input() && is_on_floor():
		velocity.y = -jump_speed
