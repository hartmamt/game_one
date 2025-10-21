extends Node2D
# Manages room generation, progression, and challenges

@export var current_room_index: int = 0
@export var rooms_per_layer: int = 5

var rooms_cleared_this_layer: int = 0
var active_enemies: Array = []

signal room_cleared()
signal layer_complete()
signal warden_room_entered()

func _ready():
	EventBus.enemy_killed.connect(_on_enemy_killed)

func generate_room():
	var layer = GameState.current_layer

	# Determine room type
	var is_warden_room = (rooms_cleared_this_layer >= rooms_per_layer - 1)

	if is_warden_room:
		_generate_warden_room()
	else:
		_generate_standard_room()

func _generate_standard_room():
	var layer = GameState.current_layer
	var cpi = GameState.castle_pressure_index

	# Determine enemy count based on CPI
	var base_enemy_count = 3 + layer
	var cpi_bonus = int(cpi / 20)
	var total_enemies = base_enemy_count + cpi_bonus

	print("Generating room with ", total_enemies, " enemies")

	# Spawn enemies (placeholder - would spawn actual enemy scenes)
	# for i in range(total_enemies):
	#     spawn_enemy()

func _generate_warden_room():
	print("Generating Warden room for Layer ", GameState.current_layer)
	emit_signal("warden_room_entered")

	# Spawn warden boss
	# TODO: Implement warden spawning

func spawn_enemy(enemy_type: String = ""):
	# TODO: Instantiate enemy scene
	pass

func _on_enemy_killed(enemy: Node):
	if enemy in active_enemies:
		active_enemies.erase(enemy)

	# Check if room is cleared
	if active_enemies.is_empty():
		_room_cleared()

func _room_cleared():
	rooms_cleared_this_layer += 1
	emit_signal("room_cleared")

	if rooms_cleared_this_layer >= rooms_per_layer:
		_layer_complete()
	else:
		# Progress to next room
		current_room_index += 1

func _layer_complete():
	emit_signal("layer_complete")
	GameState.advance_layer()
	rooms_cleared_this_layer = 0

func reset_for_new_run():
	current_room_index = 0
	rooms_cleared_this_layer = 0
	active_enemies.clear()
