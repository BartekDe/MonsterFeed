extends CharacterBody2D

@export var KNOCKBACK_FORCE = 100
@export var KNOCKBACK_FRICTION = 200

@export var FRICTION = 500
@export var ACCELERATION = 600
@export var MAX_SPEED = 50

@export var EXPERIENCE_AMOUNT = 2

var knockback = Vector2.ZERO

@onready var stats = $Stats
@onready var player_detection_zone = $PlayerDetectionZone
@onready var soft_collision = $SoftCollision
@onready var wander_controller = $WanderController

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE,
	KNOCKBACK
}

var state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			wander_or_idle()

		WANDER:
			seek_player()
			wander_or_idle()
			
			var direction = global_position.direction_to(wander_controller.target_position)
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			if global_position.distance_to(wander_controller.target_position) < wander_controller.tolerance:
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

		CHASE:
			var player = player_detection_zone.player
			if player != null:
				var chase_direction = global_position.direction_to(player.global_position).normalized()
				velocity = velocity.move_toward(chase_direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
		KNOCKBACK:
			if knockback > 0:
				knockback = knockback.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
				velocity = knockback
			else:
				state = IDLE
	
	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * delta * 400
	move_and_slide()

func wander_or_idle():
	if wander_controller.get_time_left() == 0:
		state = pick_random_state_from([IDLE, WANDER])
		wander_controller.start_timer(randi_range(2, 5))

func pick_random_state_from(states: Array):
	states.shuffle()
	return states.pop_front()

func seek_player():
	if player_detection_zone.can_see_player():
		state = CHASE

func _on_hurtbox_area_entered(area: Area2D):
	print(area.name)
	var damage = area.damage
	self.stats.inflict_damage(damage)
	var knockback_direction = (self.position - area.owner.position).normalized()
	knockback = knockback_direction * KNOCKBACK_FORCE

func _on_stats_no_health():
	queue_free()
	var enemy_death_effect = EnemyDeathEffect.instantiate()
	get_parent().add_child(enemy_death_effect)
	enemy_death_effect.position = self.position
	Events.grant_experience.emit(EXPERIENCE_AMOUNT)
