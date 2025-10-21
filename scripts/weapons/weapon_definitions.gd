extends Node
# Weapon definitions and data for all weapons in the game

const WEAPONS = {
	# LIGHT WEAPONS
	"dagger": {
		"name": "Iron Dagger",
		"type": WeaponBase.WeaponType.LIGHT,
		"base_damage": 15.0,
		"attack_speed": 2.0,
		"range": 30.0,
		"description": "A quick, nimble blade for rapid strikes"
	},
	"rapier": {
		"name": "Noble Rapier",
		"type": WeaponBase.WeaponType.LIGHT,
		"base_damage": 18.0,
		"attack_speed": 1.8,
		"range": 40.0,
		"description": "Elegant and deadly, favored by duelists"
	},

	# BALANCED WEAPONS
	"longsword": {
		"name": "Castle Longsword",
		"type": WeaponBase.WeaponType.BALANCED,
		"base_damage": 25.0,
		"attack_speed": 1.2,
		"range": 50.0,
		"description": "A reliable blade for any warrior"
	},
	"broadsword": {
		"name": "Knight's Broadsword",
		"type": WeaponBase.WeaponType.BALANCED,
		"base_damage": 28.0,
		"attack_speed": 1.0,
		"range": 55.0,
		"description": "The standard weapon of castle guards"
	},

	# HEAVY WEAPONS
	"warhammer": {
		"name": "Warden's Warhammer",
		"type": WeaponBase.WeaponType.HEAVY,
		"base_damage": 45.0,
		"attack_speed": 0.6,
		"range": 60.0,
		"description": "Crushes armor and bone alike"
	},
	"greataxe": {
		"name": "Executioner's Greataxe",
		"type": WeaponBase.WeaponType.HEAVY,
		"base_damage": 50.0,
		"attack_speed": 0.5,
		"range": 65.0,
		"description": "Massive blade of devastating power"
	},

	# RANGED WEAPONS
	"shortbow": {
		"name": "Hunter's Shortbow",
		"type": WeaponBase.WeaponType.RANGED,
		"base_damage": 20.0,
		"attack_speed": 1.5,
		"range": 300.0,
		"description": "Quick shots from a safe distance"
	},
	"crossbow": {
		"name": "Heavy Crossbow",
		"type": WeaponBase.WeaponType.RANGED,
		"base_damage": 35.0,
		"attack_speed": 0.8,
		"range": 400.0,
		"description": "Powerful bolts pierce through enemies"
	},
	"magic_staff": {
		"name": "Arcane Staff",
		"type": WeaponBase.WeaponType.RANGED,
		"base_damage": 30.0,
		"attack_speed": 1.0,
		"range": 350.0,
		"description": "Channels magical energy into projectiles"
	},

	# HYBRID WEAPONS
	"enchanted_blade": {
		"name": "Eidolon's Grasp",
		"type": WeaponBase.WeaponType.HYBRID,
		"base_damage": 32.0,
		"attack_speed": 1.1,
		"range": 50.0,
		"description": "Blade infused with castle magic",
		"special": "Fires magic projectiles on heavy attack"
	},
	"elemental_gauntlets": {
		"name": "Flame-Touched Gauntlets",
		"type": WeaponBase.WeaponType.HYBRID,
		"base_damage": 28.0,
		"attack_speed": 1.3,
		"range": 45.0,
		"description": "Fists wreathed in elemental fire",
		"special": "Burns enemies over time"
	}
}

# Unique/boss weapons unlocked through progression
const UNIQUE_WEAPONS = {
	"eidolons_grasp": {
		"name": "Eidolon's True Grasp",
		"type": WeaponBase.WeaponType.HYBRID,
		"base_damage": 60.0,
		"attack_speed": 1.0,
		"range": 70.0,
		"description": "A weapon forged from the castle's heart",
		"unlock_condition": "CPI 60 Milestone",
		"special": "Absorbs enemy souls to empower attacks"
	}
}

func get_weapon_data(weapon_id: String) -> Dictionary:
	if WEAPONS.has(weapon_id):
		return WEAPONS[weapon_id]
	elif UNIQUE_WEAPONS.has(weapon_id):
		return UNIQUE_WEAPONS[weapon_id]
	return {}

func create_weapon(weapon_id: String) -> WeaponBase:
	var data = get_weapon_data(weapon_id)
	if data.is_empty():
		push_error("Weapon ID not found: " + weapon_id)
		return null

	var weapon = WeaponBase.new()
	weapon.weapon_name = data.name
	weapon.weapon_type = data.type
	weapon.base_damage = data.base_damage
	weapon.attack_speed = data.attack_speed
	weapon.range = data.range

	return weapon
