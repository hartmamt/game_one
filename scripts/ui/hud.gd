extends CanvasLayer
# Main HUD - displays health, CPI, layer info, and notifications

@onready var health_bar = $HealthBar
@onready var health_label = $HealthBar/HealthLabel
@onready var cpi_meter = $CPIMeter
@onready var cpi_label = $CPIMeter/CPILabel
@onready var threat_label = $CPIMeter/ThreatLabel
@onready var layer_label = $LayerLabel
@onready var notification_panel = $NotificationPanel
@onready var notification_label = $NotificationPanel/NotificationLabel

func _ready():
	# Connect to EventBus signals
	EventBus.update_health_bar.connect(_on_health_updated)
	EventBus.show_notification.connect(_on_show_notification)
	GameState.cpi_changed.connect(_on_cpi_changed)
	GameState.layer_changed.connect(_on_layer_changed)

	# Initial update
	_update_hud()

func _update_hud():
	# Update health
	if GameState.is_run_active:
		_on_health_updated(GameState.player_health, GameState.player_max_health)

	# Update CPI
	_on_cpi_changed(GameState.castle_pressure_index, 0)

	# Update layer
	_on_layer_changed(GameState.current_layer)

func _on_health_updated(current: float, maximum: float):
	var percentage = (current / maximum) * 100.0
	health_bar.value = percentage
	health_label.text = "%d / %d" % [int(current), int(maximum)]

	# Color based on health
	if percentage > 66:
		health_bar.modulate = Color.GREEN
	elif percentage > 33:
		health_bar.modulate = Color.YELLOW
	else:
		health_bar.modulate = Color.RED

func _on_cpi_changed(new_cpi: int, delta: int):
	cpi_label.text = "CPI: %d" % new_cpi

	var threat = GameState.get_cpi_threat_level()
	threat_label.text = "Threat: %s" % threat
	threat_label.modulate = GameState.get_cpi_color()

	# Update progress bar visual
	var progress = min(new_cpi / 120.0, 1.0) * 100.0
	cpi_meter.value = progress
	cpi_meter.modulate = GameState.get_cpi_color()

	# Show notification if CPI increased
	if delta > 0:
		_show_cpi_notification(delta)

func _on_layer_changed(layer: int):
	layer_label.text = "Layer %d" % layer

func _on_show_notification(title: String, message: String):
	notification_label.text = "%s\n%s" % [title, message]
	notification_panel.visible = true

	# Auto-hide after 3 seconds
	await get_tree().create_timer(3.0).timeout
	notification_panel.visible = false

func _show_cpi_notification(delta: int):
	var label = Label.new()
	label.text = "+%d CPI" % delta
	label.modulate = Color.ORANGE_RED
	label.position = cpi_meter.position + Vector2(0, -30)
	add_child(label)

	# Fade out and remove
	var tween = create_tween()
	tween.tween_property(label, "position:y", label.position.y - 50, 1.0)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 1.0)
	await tween.finished
	label.queue_free()
