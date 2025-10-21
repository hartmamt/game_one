extends CharacterBody2D
class_name EnemyBase

# Enemy stats
@export var enemy_name: String = "Enemy"
@export var base_health: float = 50.0
@export var base_damage: float = 10.0
@export var base_speed: float = 100.0
@export var cpi_reward: int = 1

# Current stats (modified by CPI)
var max_health: float
var current_health: float
var damage: float
var speed: float

# AI state
enum State { IDLE, PATROL, CHASE, ATTACK, STUNNED, DEAD }
var current_state: State = State.IDLE

# Detection
@export var detection_range: float = 300.0
@export var attack_range: float = 60.0
var player_ref: Player = null

# Attack
var can_attack: bool = true
var attack_cooldown: float = 1.5

# CPI mutations
var has_regeneration: bool = false
var has_elemental: bool = false
var elemental_type: String = ""
var is_elite: bool = false

@onready var sprite = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer
@onready var detection_area = $DetectionArea

func _ready():
	# Apply CPI scaling
	apply_cpi_scaling()

	attack_timer.wait_time = attack_cooldown

	# Add to enemies group
	add_to_group("enemies")

func apply_cpi_scaling():
	# Scale stats based on CPI
	var health_mult = GameState.get_enemy_health_multiplier()
	var damage_mult = GameState.get_enemy_damage_multiplier()
	var speed_mult = GameState.get_enemy_speed_multiplier()

	max_health = base_health * health_mult
	current_health = max_health
	damage = base_damage * damage_mult
	speed = base_speed * speed_mult

	# Apply mutations at high CPI
	var cpi = GameState.castle_pressure_index

	if cpi >= 40 and randf() < 0.3:
		has_regeneration = true
		print(enemy_name, " has regeneration!")

	if cpi >= 60 and randf() < 0.25:
		has_elemental = true
		elemental_type = ["fire", "ice", "lightning"].pick_random()
		print(enemy_name, " has ", elemental_type, " element!")

	if cpi >= 80 and randf() < 0.15:
		is_elite = true
		max_health *= 2.0
		current_health = max_health
		damage *= 1.5
		print(enemy_name, " is ELITE!")

func _physics_process(delta):
	if current_state == State.DEAD:
		return

	# Regeneration mutation
	if has_regeneration and current_health < max_health:
		current_health += max_health * 0.01 * delta

	match current_state:
		State.IDLE:
			_idle_behavior(delta)
		State.PATROL:
			_patrol_behavior(delta)
		State.CHASE:
			_chase_behavior(delta)
		State.ATTACK:
			_attack_behavior(delta)

	move_and_slide()

func _idle_behavior(delta):
	velocity.x = move_toward(velocity.x, 0, speed)

	# Check for player
	if player_ref and player_ref.global_position.distance_to(global_position) < detection_range:
		current_state = State.CHASE

func _patrol_behavior(delta):
	# Simple patrol logic (can be enhanced)
	pass

func _chase_behavior(delta):
	if not player_ref:
		current_state = State.IDLE
		return

	var distance = player_ref.global_position.distance_to(global_position)

	if distance > detection_range * 1.5:
		# Lost player
		current_state = State.IDLE
		player_ref = null
		return

	if distance <= attack_range:
		# In attack range
		current_state = State.ATTACK
		return

	# Move toward player
	var direction = sign(player_ref.global_position.x - global_position.x)
	velocity.x = direction * speed

	# Face player
	sprite.flip_h = direction < 0

func _attack_behavior(delta):
	if not player_ref:
		current_state = State.IDLE
		return

	velocity.x = 0

	var distance = player_ref.global_position.distance_to(global_position)
	if distance > attack_range * 1.2:
		current_state = State.CHASE
		return

	if can_attack:
		perform_attack()

func perform_attack():
	can_attack = false
	sprite.play("attack")

	# Deal damage after animation delay
	await get_tree().create_timer(0.3).timeout

	if player_ref and player_ref.global_position.distance_to(global_position) <= attack_range:
		var actual_damage = damage
		if has_elemental:
			actual_damage *= 1.2
		player_ref.take_damage(actual_damage, self)

	attack_timer.start()
	await attack_timer.timeout
	can_attack = true

func take_damage(amount: float, attacker: Node = null):
	current_health -= amount
	current_health = max(0, current_health)

	# Flash effect
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

	EventBus.emit_signal("enemy_hit", self, amount)

	if current_health <= 0:
		die()

func die():
	current_state = State.DEAD
	sprite.play("death")

	# Award CPI
	var cpi_gain = cpi_reward
	if is_elite:
		cpi_gain *= 2

	GameState.enemy_defeated(enemy_name, cpi_gain)
	EventBus.emit_signal("enemy_killed", self)

	await sprite.animation_finished
	queue_free()

func _on_detection_area_body_entered(body):
	if body is Player:
		player_ref = body
		if current_state == State.IDLE:
			current_state = State.CHASE
