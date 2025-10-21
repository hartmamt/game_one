extends CharacterBody2D
class_name Player

# Movement constants
const WALK_SPEED = 200.0
const RUN_SPEED = 350.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 1500.0
const DODGE_SPEED = 500.0
const DODGE_DURATION = 0.3

# Player stats
var max_health: float = 100.0
var current_health: float = 100.0
var is_blocking: bool = false
var is_dodging: bool = false
var is_climbing: bool = false
var is_attacking: bool = false

# State tracking
var facing_right: bool = true
var can_dodge: bool = true
var dodge_cooldown: float = 0.5
var invulnerable: bool = false

# References
var current_weapon = null
@onready var sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var dodge_timer = $DodgeTimer
@onready var attack_area = $AttackArea

func _ready():
	current_health = max_health
	dodge_timer.wait_time = dodge_cooldown

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor() and not is_climbing:
		velocity.y += GRAVITY * delta

	# Handle dodging
	if is_dodging:
		_handle_dodge(delta)
		move_and_slide()
		return

	# Handle climbing
	if is_climbing:
		_handle_climbing(delta)
		move_and_slide()
		return

	# Handle blocking
	if Input.is_action_pressed("block") and not is_attacking:
		is_blocking = true
	else:
		is_blocking = false

	# Handle attack
	if Input.is_action_just_pressed("attack") and not is_blocking and not is_attacking:
		attack()

	# Handle dodge/roll
	if Input.is_action_just_pressed("dodge") and can_dodge and not is_blocking:
		start_dodge()

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle horizontal movement
	var direction = Input.get_axis("move_left", "move_right")

	if direction != 0 and not is_blocking:
		# Check if running
		var is_running = Input.is_action_pressed("run")
		var speed = RUN_SPEED if is_running else WALK_SPEED

		velocity.x = direction * speed

		# Update facing direction
		if direction > 0:
			facing_right = true
			sprite.flip_h = false
		else:
			facing_right = false
			sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)

	move_and_slide()
	_update_animation()

func _handle_dodge(delta):
	# Invulnerable during dodge
	invulnerable = true

func start_dodge():
	is_dodging = true
	can_dodge = false
	invulnerable = true

	# Dodge in facing direction
	var dodge_direction = 1 if facing_right else -1
	velocity.x = dodge_direction * DODGE_SPEED

	dodge_timer.start(DODGE_DURATION)
	await dodge_timer.timeout

	is_dodging = false
	invulnerable = false

	# Start cooldown
	dodge_timer.start(dodge_cooldown)
	await dodge_timer.timeout
	can_dodge = true

func _handle_climbing(delta):
	# Climbing mechanics (for chains)
	var vertical_input = Input.get_axis("move_up", "move_down")
	velocity.y = vertical_input * WALK_SPEED

	if Input.is_action_just_pressed("jump"):
		is_climbing = false
		velocity.y = JUMP_VELOCITY

func attack():
	if is_attacking:
		return

	is_attacking = true
	velocity.x = 0

	# Play attack animation
	sprite.play("attack")

	# Deal damage in attack area
	await get_tree().create_timer(0.2).timeout
	_check_attack_hit()

	await sprite.animation_finished
	is_attacking = false

func _check_attack_hit():
	var bodies = attack_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var damage = 20.0  # Base damage, modified by weapon
			if current_weapon:
				damage = current_weapon.get_damage()
			body.take_damage(damage)

func take_damage(amount: float, attacker: Node = null):
	if invulnerable:
		return

	# Reduce damage if blocking
	if is_blocking:
		amount *= 0.3  # 70% damage reduction

	current_health -= amount
	current_health = max(0, current_health)

	EventBus.emit_signal("player_hit", amount, attacker)
	EventBus.emit_signal("update_health_bar", current_health, max_health)

	# Flash effect
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

	if current_health <= 0:
		die()

func heal(amount: float):
	current_health += amount
	current_health = min(current_health, max_health)
	EventBus.emit_signal("update_health_bar", current_health, max_health)

func die():
	print("Player died")
	EventBus.emit_signal("game_over")
	GameState.end_run(true)
	# Reset to hub/entrance
	get_tree().change_scene_to_file("res://scenes/hub.tscn")

func _update_animation():
	if is_dodging:
		sprite.play("dodge")
	elif is_attacking:
		sprite.play("attack")
	elif is_blocking:
		sprite.play("block")
	elif not is_on_floor():
		sprite.play("jump")
	elif velocity.x != 0:
		if abs(velocity.x) > WALK_SPEED:
			sprite.play("run")
		else:
			sprite.play("walk")
	else:
		sprite.play("idle")

func enter_climbing_zone():
	is_climbing = true
	velocity = Vector2.ZERO

func exit_climbing_zone():
	is_climbing = false
