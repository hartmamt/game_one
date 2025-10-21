extends Control
# Main menu screen

@onready var start_button = $VBoxContainer/StartButton
@onready var continue_button = $VBoxContainer/ContinueButton
@onready var settings_button = $VBoxContainer/SettingsButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var stats_label = $StatsPanel/StatsLabel

func _ready():
	# Check if save exists
	if SaveSystem.has_save():
		continue_button.disabled = false
		_display_stats()
	else:
		continue_button.disabled = true

	start_button.pressed.connect(_on_start_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _display_stats():
	var stats_text = "=== CURRENT PROGRESS ===\n"
	stats_text += "Castle Pressure Index: %d\n" % GameState.castle_pressure_index
	stats_text += "Threat Level: %s\n" % GameState.get_cpi_threat_level()
	stats_text += "Max Layer Reached: %d\n" % GameState.max_layer_reached
	stats_text += "Total Deaths: %d\n" % GameState.player_deaths
	stats_text += "Eidolon Cores: %d\n" % GameState.eidolon_cores

	stats_label.text = stats_text

func _on_start_pressed():
	# Start new run
	GameState.start_new_run()
	get_tree().change_scene_to_file("res://scenes/hub.tscn")

func _on_continue_pressed():
	# Continue from save
	SaveSystem.load_game()
	get_tree().change_scene_to_file("res://scenes/hub.tscn")

func _on_settings_pressed():
	# Open settings menu
	print("Settings menu not yet implemented")

func _on_quit_pressed():
	get_tree().quit()
