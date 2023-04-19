extends CharacterBody2D

var experience_level: ExperienceLevel = preload("res://Player/ExperienceLevel.tres")

@export var coin_storage: CoinStorage

const MAX_SPEED = 100
const ROLL_SPEED = MAX_SPEED * 1.2
const ACCELERATION = 600
const FRICTION = 600

enum {
	MOVE,
	ROLL,
	ATTACK
}

var calculated_velocity = Vector2.ZERO
var state = MOVE
var roll_vector = Vector2.RIGHT
var stats = PlayerStats
var can_hurt_player = true

@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var hurt_cooldown_timer = $HurtCooldownTimer

func _ready():
	stats.no_health.connect(queue_free)
	add_to_group("Player")

func _process(delta):
	match state:
		MOVE:
			handle_movement(delta)
		ROLL:
			handle_roll(delta)
		ATTACK:
			handle_attack(delta)

func handle_movement(delta):
	var input_vector = get_input_vector().normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.limit_length(MAX_SPEED)
		animation_state.travel("run")
		self.set_animations_directions(input_vector)
	else:
		animation_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
	
	if Input.is_action_pressed("attack"):
		animation_state.travel("attack")
	
	if Input.is_action_pressed("roll"):
		state = ROLL
		
func set_animations_directions(input_vector):
	animation_tree.set("parameters/run/blend_position", input_vector)
	animation_tree.set("parameters/idle/blend_position", input_vector)
	animation_tree.set("parameters/attack/blend_position", input_vector)
	animation_tree.set("parameters/roll/blend_position", input_vector)

func handle_roll(delta):
	velocity = roll_vector * ROLL_SPEED
	move_and_slide()
	animation_state.travel("roll")

func handle_attack(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta / 1.5)
	move_and_slide()
	animation_state.travel("attack")

func finish_attack_animation():
	state = MOVE

func finish_roll_animation():
	velocity /= 2
	state = MOVE

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector

func _on_hurtbox_area_entered(area: Area2D):
	if self.can_hurt_player:
		stats.inflict_damage(area.damage)
		self.can_hurt_player = false
		hurt_cooldown_timer.start(1)

func _on_hurt_cooldown_timer_timeout():
	hurt_cooldown_timer.stop()
	self.can_hurt_player = true
