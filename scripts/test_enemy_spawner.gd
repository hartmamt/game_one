extends Node2D
# Simple enemy spawner for testing

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 5.0
@export var max_enemies: int = 3

var active_enemies: int = 0
var spawn_timer: float = 0.0

func _ready():
	# Load enemy scene if not set
	if not enemy_scene:
		print("No enemy scene set for spawner")

func _process(delta):
	spawn_timer += delta

	if spawn_timer >= spawn_interval and active_enemies < max_enemies:
		spawn_enemy()
		spawn_timer = 0.0

func spawn_enemy():
	if not enemy_scene:
		return

	var enemy = enemy_scene.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)
	active_enemies += 1

	# Connect to enemy death signal to track count
	if enemy.has_signal("enemy_died"):
		enemy.enemy_died.connect(_on_enemy_died)

func _on_enemy_died():
	active_enemies -= 1
