extends Node
# Configuration for each castle layer

const LAYER_DATA = {
	1: {
		"name": "The Forsaken Entrance",
		"description": "Crumbling halls where the castle's corruption began",
		"environment": "dungeon",
		"theme_color": Color.DARK_SLATE_GRAY,
		"enemies": ["crypt_shade", "iron_guard", "arcane_familiar"],
		"warden": "first_warden",
		"hazards": ["spike_pits", "collapsing_floors"]
	},
	2: {
		"name": "The Crimson Corridors",
		"description": "Blood-stained passages echo with ancient screams",
		"environment": "castle_interior",
		"theme_color": Color.DARK_RED,
		"enemies": ["iron_guard", "crypt_shade", "arcane_familiar"],
		"warden": null,
		"hazards": ["spike_pits", "flame_jets"]
	},
	3: {
		"name": "The Astral Archives",
		"description": "Library twisted by eldritch knowledge",
		"environment": "library",
		"theme_color": Color.DARK_BLUE,
		"enemies": ["astral_sentinel", "mirror_wraith", "arcane_familiar"],
		"warden": "second_warden",
		"hazards": ["magic_barriers", "void_zones"]
	},
	4: {
		"name": "The Iron Chapel",
		"description": "A corrupted place of worship to forgotten gods",
		"environment": "chapel",
		"theme_color": Color.DARK_SLATE_BLUE,
		"enemies": ["iron_chapel_acolyte", "mirror_wraith", "astral_sentinel"],
		"warden": null,
		"hazards": ["cursed_altars", "chain_traps"]
	},
	5: {
		"name": "The Eidolon's Heart",
		"description": "The pulsing core of the castle's corruption",
		"environment": "boss_arena",
		"theme_color": Color.PURPLE,
		"enemies": ["all_types"],
		"warden": "final_warden",
		"hazards": ["all_hazards"]
	}
}

func get_layer_info(layer: int) -> Dictionary:
	if LAYER_DATA.has(layer):
		return LAYER_DATA[layer]
	return LAYER_DATA[1]  # Default to layer 1

func get_layer_name(layer: int) -> String:
	return get_layer_info(layer).get("name", "Unknown Layer")

func get_layer_enemies(layer: int) -> Array:
	return get_layer_info(layer).get("enemies", [])

func get_layer_warden(layer: int):
	return get_layer_info(layer).get("warden", null)
