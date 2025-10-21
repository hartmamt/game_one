extends Node
# Handles saving and loading game state to/from disk

const SAVE_FILE_PATH = "user://castle_eidolon_save.dat"

func save_game():
	var save_data = {
		"version": "1.0",
		"timestamp": Time.get_unix_time_from_system(),

		# CPI and progression
		"castle_pressure_index": GameState.castle_pressure_index,
		"max_layer_reached": GameState.max_layer_reached,
		"player_deaths": GameState.player_deaths,

		# Unlocks
		"unlocked_weapons": GameState.unlocked_weapons,
		"unlocked_sigils": GameState.unlocked_sigils,
		"unlocked_techniques": GameState.unlocked_techniques,
		"milestone_rewards_claimed": GameState.milestone_rewards_claimed,

		# Meta progression
		"eidolon_cores": GameState.eidolon_cores,
	}

	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(save_data)
		file.close()
		print("Game saved successfully")
	else:
		push_error("Failed to save game")

func load_game():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		print("No save file found - starting fresh")
		return

	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var save_data = file.get_var()
		file.close()

		# Restore game state
		GameState.castle_pressure_index = save_data.get("castle_pressure_index", 0)
		GameState.max_layer_reached = save_data.get("max_layer_reached", 1)
		GameState.player_deaths = save_data.get("player_deaths", 0)

		GameState.unlocked_weapons = save_data.get("unlocked_weapons", [])
		GameState.unlocked_sigils = save_data.get("unlocked_sigils", [])
		GameState.unlocked_techniques = save_data.get("unlocked_techniques", [])
		GameState.milestone_rewards_claimed = save_data.get("milestone_rewards_claimed", [])

		GameState.eidolon_cores = save_data.get("eidolon_cores", 0)

		print("Game loaded - CPI: ", GameState.castle_pressure_index)
	else:
		push_error("Failed to load save file")

func delete_save():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		DirAccess.remove_absolute(SAVE_FILE_PATH)
		print("Save file deleted")

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)
