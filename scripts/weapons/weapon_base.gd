extends Node2D
class_name WeaponBase

# Weapon type enum
enum WeaponType {
	LIGHT,      # Fast, precise strikes; low damage
	BALANCED,   # Versatile and reliable
	HEAVY,      # Slow, powerful strikes; armor penetration
	RANGED,     # Attack from distance
	HYBRID      # Mix melee & magic/ranged
}

# Base weapon stats
@export var weapon_name: String = "Basic Sword"
@export var weapon_type: WeaponType = WeaponType.BALANCED
@export var base_damage: float = 20.0
@export var attack_speed: float = 1.0  # Attacks per second
@export var range: float = 50.0
@export var upgrade_level: int = 0
@export var max_upgrade_level: int = 10

# Type-specific modifiers
var type_stats = {
	WeaponType.LIGHT: {
		"damage_mult": 0.7,
		"speed_mult": 1.5,
		"crit_chance": 0.25,
		"description": "Fast, precise strikes"
	},
	WeaponType.BALANCED: {
		"damage_mult": 1.0,
		"speed_mult": 1.0,
		"crit_chance": 0.15,
		"description": "Versatile and reliable"
	},
	WeaponType.HEAVY: {
		"damage_mult": 1.8,
		"speed_mult": 0.5,
		"crit_chance": 0.1,
		"armor_pen": 0.5,
		"description": "Slow, devastating blows"
	},
	WeaponType.RANGED: {
		"damage_mult": 1.0,
		"speed_mult": 0.8,
		"crit_chance": 0.2,
		"projectile": true,
		"description": "Attack from distance"
	},
	WeaponType.HYBRID: {
		"damage_mult": 1.2,
		"speed_mult": 0.9,
		"crit_chance": 0.18,
		"elemental": true,
		"description": "Melee and magic combined"
	}
}

# Sigil slots
var sigil_slots: Array = []
var equipped_sigils: Array = []

signal weapon_upgraded(new_level: int)
signal attack_performed(damage: float, is_crit: bool)

func get_damage() -> float:
	var stats = type_stats[weapon_type]
	var damage = base_damage * stats.damage_mult

	# Add upgrade bonus
	damage += upgrade_level * 5.0

	# Check for critical hit
	if randf() < stats.crit_chance:
		damage *= 2.0

	# Apply sigil effects
	for sigil in equipped_sigils:
		damage = sigil.modify_damage(damage)

	return damage

func get_attack_speed() -> float:
	var stats = type_stats[weapon_type]
	return attack_speed * stats.speed_mult

func upgrade():
	if upgrade_level >= max_upgrade_level:
		print("Weapon already at max level")
		return false

	upgrade_level += 1
	emit_signal("weapon_upgraded", upgrade_level)
	print(weapon_name, " upgraded to level ", upgrade_level)
	return true

func equip_sigil(sigil):
	if equipped_sigils.size() < sigil_slots.size():
		equipped_sigils.append(sigil)
		return true
	return false

func get_weapon_info() -> Dictionary:
	return {
		"name": weapon_name,
		"type": WeaponType.keys()[weapon_type],
		"damage": get_damage(),
		"attack_speed": get_attack_speed(),
		"level": upgrade_level,
		"description": type_stats[weapon_type].description
	}
