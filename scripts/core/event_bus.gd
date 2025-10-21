extends Node
# Global event bus for decoupled communication between systems

# UI Events
signal show_notification(title: String, message: String)
signal update_health_bar(current: float, maximum: float)
signal update_cpi_display(cpi: int, threat_level: String)

# Combat Events
signal player_hit(damage: float, attacker: Node)
signal enemy_hit(enemy: Node, damage: float)
signal enemy_killed(enemy: Node)
signal boss_defeated(boss_name: String)

# Interaction Events
signal npc_interaction_started(npc: Node)
signal npc_interaction_ended()
signal item_picked_up(item_data: Dictionary)

# Room/Level Events
signal room_cleared()
signal entered_new_layer(layer_number: int)
signal checkpoint_reached()

# Menu Events
signal pause_menu_opened()
signal pause_menu_closed()
signal game_over()
