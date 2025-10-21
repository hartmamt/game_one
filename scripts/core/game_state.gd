extends Node
# Central game state manager - handles CPI, progression, and game stats

# Castle Pressure Index - the core mechanic that never resets
var castle_pressure_index: int = 0
var cpi_this_run: int = 0  # CPI gained in current run

# Layer progression
var current_layer: int = 1
var max_layer_reached: int = 1

# Player stats
var player_health: float = 100.0
var player_max_health: float = 100.0
var player_deaths: int = 0

# Unlocks and progression
var unlocked_weapons: Array[String] = []
var unlocked_sigils: Array[String] = []
var unlocked_techniques: Array[String] = []
var milestone_rewards_claimed: Array[int] = []

# Eidolon Cores (meta progression currency)
var eidolon_cores: int = 0

# Current run state
var is_run_active: bool = false
var enemies_defeated_this_run: int = 0
var wardens_defeated_this_run: int = 0

# CPI milestone thresholds and rewards
const CPI_MILESTONES = {
	10: {"type": "weapon_tokens", "amount": 3, "description": "3 Weapon Upgrade Tokens"},
	25: {"type": "sigil_slot", "description": "Additional Sigil Slot"},
	40: {"type": "skill_point", "description": "Passive Skill Point"},
	60: {"type": "unique_weapon", "description": "Unique Weapon: Eidolon's Grasp"},
	80: {"type": "combat_technique", "description": "Aerial Combo Technique"},
	100: {"type": "eidolon_core", "amount": 1, "description": "Major Eidolon Core"},
	120: {"type": "cosmetic", "description": "Phantom Knight Armor Set"}
}

signal cpi_changed(new_value: int, delta: int)
signal cpi_milestone_reached(milestone: int)
signal player_died()
signal layer_changed(new_layer: int)
signal run_started()
signal run_ended()

func _ready():
	# Load saved data on startup
	SaveSystem.load_game()

func start_new_run():
	is_run_active = true
	current_layer = 1
	cpi_this_run = 0
	enemies_defeated_this_run = 0
	wardens_defeated_this_run = 0
	player_health = player_max_health

	emit_signal("run_started")
	print("Run started - CPI: ", castle_pressure_index)

func end_run(player_died: bool = false):
	is_run_active = false

	if player_died:
		player_deaths += 1
		emit_signal("player_died")
		# Death increases CPI
		add_cpi(5 + current_layer)

	emit_signal("run_ended")
	SaveSystem.save_game()

func add_cpi(amount: int):
	var old_cpi = castle_pressure_index
	castle_pressure_index += amount
	cpi_this_run += amount

	emit_signal("cpi_changed", castle_pressure_index, amount)

	# Check for milestone rewards
	for milestone in CPI_MILESTONES.keys():
		if old_cpi < milestone and castle_pressure_index >= milestone:
			if milestone not in milestone_rewards_claimed:
				emit_signal("cpi_milestone_reached", milestone)
				claim_milestone_reward(milestone)

	print("CPI increased by ", amount, " - Total CPI: ", castle_pressure_index)

func claim_milestone_reward(milestone: int):
	if milestone in milestone_rewards_claimed:
		return

	milestone_rewards_claimed.append(milestone)
	var reward = CPI_MILESTONES[milestone]

	print("CPI Milestone ", milestone, " reached! Reward: ", reward.description)
	EventBus.emit_signal("show_notification", "CPI Milestone Reached!", reward.description)

func advance_layer():
	current_layer += 1
	if current_layer > max_layer_reached:
		max_layer_reached = current_layer

	# Advancing layers increases CPI
	add_cpi(2 + current_layer)

	emit_signal("layer_changed", current_layer)
	print("Advanced to Layer ", current_layer)

func enemy_defeated(enemy_type: String, cpi_gain: int = 1):
	enemies_defeated_this_run += 1
	add_cpi(cpi_gain)

func warden_defeated(warden_name: String):
	wardens_defeated_this_run += 1
	add_cpi(10)
	advance_layer()

# CPI scaling calculations
func get_enemy_health_multiplier() -> float:
	return 1.0 + (castle_pressure_index * 0.02)

func get_enemy_damage_multiplier() -> float:
	return 1.0 + (castle_pressure_index * 0.015)

func get_enemy_speed_multiplier() -> float:
	return 1.0 + (castle_pressure_index * 0.01)

func get_loot_quality_multiplier() -> float:
	return 1.0 + (castle_pressure_index * 0.03)

# Get CPI threat level for UI display
func get_cpi_threat_level() -> String:
	if castle_pressure_index < 20:
		return "LOW"
	elif castle_pressure_index < 50:
		return "MODERATE"
	elif castle_pressure_index < 80:
		return "HIGH"
	elif castle_pressure_index < 120:
		return "EXTREME"
	else:
		return "OVERWHELMING"

func get_cpi_color() -> Color:
	match get_cpi_threat_level():
		"LOW": return Color.GREEN
		"MODERATE": return Color.YELLOW
		"HIGH": return Color.ORANGE
		"EXTREME": return Color.RED
		"OVERWHELMING": return Color.PURPLE
		_: return Color.WHITE
