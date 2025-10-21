extends Node
# Enemy definitions for all enemy types in Castle Eidolon

const BASE_ENEMIES = {
	"crypt_shade": {
		"name": "Crypt Shade",
		"appearance": "Ghostly, pale wraith",
		"health": 40.0,
		"damage": 12.0,
		"speed": 150.0,
		"behavior": "Fast, teleport short distances",
		"cpi_reward": 1,
		"special_abilities": ["teleport"]
	},
	"iron_guard": {
		"name": "Iron Guard",
		"appearance": "Rusted plate armor soldier",
		"health": 80.0,
		"damage": 20.0,
		"speed": 80.0,
		"behavior": "Slow, heavy attacks, shield blocks",
		"cpi_reward": 2,
		"special_abilities": ["shield_block"]
	},
	"arcane_familiar": {
		"name": "Arcane Familiar",
		"appearance": "Glowing magic orb with wings",
		"health": 30.0,
		"damage": 15.0,
		"speed": 120.0,
		"behavior": "Ranged fire orbs, evasive",
		"cpi_reward": 1,
		"special_abilities": ["ranged_attack", "flight"]
	}
}

const MID_LAYER_ENEMIES = {
	"astral_sentinel": {
		"name": "Astral Sentinel",
		"appearance": "Floating armor with runes",
		"health": 120.0,
		"damage": 25.0,
		"speed": 100.0,
		"behavior": "Teleports, magic blasts, shield phases",
		"cpi_reward": 3,
		"special_abilities": ["teleport", "magic_blast", "shield_phase"],
		"min_layer": 3
	},
	"mirror_wraith": {
		"name": "Mirror Wraith",
		"appearance": "Reflective, shifting body",
		"health": 90.0,
		"damage": 18.0,
		"speed": 140.0,
		"behavior": "Pass through walls, reflect projectiles",
		"cpi_reward": 2,
		"special_abilities": ["wall_phase", "projectile_reflect"],
		"min_layer": 3
	},
	"iron_chapel_acolyte": {
		"name": "Iron Chapel Acolyte",
		"appearance": "Robed priest with chains",
		"health": 100.0,
		"damage": 22.0,
		"speed": 90.0,
		"behavior": "Melee strikes with curses",
		"cpi_reward": 2,
		"special_abilities": ["curse_debuff"],
		"min_layer": 4
	}
}

const WARDENS = {
	"first_warden": {
		"name": "The Ironclad Warden",
		"appearance": "Massive armored knight with flaming sword",
		"health": 500.0,
		"damage": 40.0,
		"speed": 60.0,
		"behavior": "Heavy attacks, ground slams, flame waves",
		"cpi_reward": 10,
		"layer": 1,
		"special_abilities": ["ground_slam", "flame_wave", "charge_attack"],
		"phases": 2
	},
	"second_warden": {
		"name": "The Astral Executioner",
		"appearance": "Ethereal figure wielding twin blades",
		"health": 700.0,
		"damage": 35.0,
		"speed": 120.0,
		"behavior": "Fast combos, teleportation, shadow clones",
		"cpi_reward": 15,
		"layer": 3,
		"special_abilities": ["teleport_strike", "shadow_clone", "blade_flurry"],
		"phases": 3
	}
}

func get_enemies_for_layer(layer: int) -> Array:
	var available_enemies = []

	# Always include base enemies
	for enemy_id in BASE_ENEMIES.keys():
		available_enemies.append(enemy_id)

	# Add mid-layer enemies if layer requirement met
	for enemy_id in MID_LAYER_ENEMIES.keys():
		var enemy_data = MID_LAYER_ENEMIES[enemy_id]
		if layer >= enemy_data.get("min_layer", 1):
			available_enemies.append(enemy_id)

	return available_enemies

func get_warden_for_layer(layer: int):
	for warden_id in WARDENS.keys():
		var warden_data = WARDENS[warden_id]
		if warden_data.layer == layer:
			return warden_id
	return null

func get_enemy_data(enemy_id: String) -> Dictionary:
	if BASE_ENEMIES.has(enemy_id):
		return BASE_ENEMIES[enemy_id]
	elif MID_LAYER_ENEMIES.has(enemy_id):
		return MID_LAYER_ENEMIES[enemy_id]
	elif WARDENS.has(enemy_id):
		return WARDENS[enemy_id]
	return {}
