# Castle Eidolon - Development Guide

## Getting Started

### Prerequisites

1. **Godot 4.3** or later
   - Download from: https://godotengine.org/download
   - Use the .NET version if you plan to use C# (optional)

2. **Git** (for version control)

### Opening the Project

1. Clone this repository
2. Open Godot Engine
3. Click "Import" and navigate to the project folder
4. Select `project.godot` and click "Import & Edit"

## Project Structure

```
castle_eidolon/
├── project.godot          # Main Godot project file
├── export_presets.cfg     # Export configuration for Windows .exe
├── icon.svg               # Game icon
│
├── scenes/                # All game scenes (.tscn files)
│   ├── main_menu.tscn    # Main menu screen
│   ├── hub.tscn          # Castle entrance hub
│   ├── player.tscn       # Player character
│   ├── hud.tscn          # In-game HUD
│   └── levels/           # Level/room scenes
│
├── scripts/              # All GDScript code
│   ├── core/             # Core game systems
│   │   ├── game_state.gd      # CPI, progression, stats
│   │   ├── save_system.gd     # Save/load functionality
│   │   └── event_bus.gd       # Global event system
│   │
│   ├── player/           # Player-related scripts
│   │   └── player_controller.gd
│   │
│   ├── weapons/          # Weapon system
│   │   ├── weapon_base.gd
│   │   └── weapon_definitions.gd
│   │
│   ├── enemies/          # Enemy AI and definitions
│   │   ├── enemy_base.gd
│   │   └── enemy_definitions.gd
│   │
│   ├── npcs/             # NPC interactions
│   │   └── npc_base.gd
│   │
│   ├── ui/               # UI controllers
│   │   ├── hud.gd
│   │   └── main_menu.gd
│   │
│   └── level/            # Level generation
│       ├── room_manager.gd
│       └── layer_config.gd
│
├── assets/               # Art, audio, and data (to be added)
│   ├── sprites/
│   ├── audio/
│   └── tilesets/
│
└── data/                 # JSON configs (to be added)
```

## Core Systems

### 1. GameState (Autoload)

**Location:** `scripts/core/game_state.gd`

The central manager for all game state, including:
- Castle Pressure Index (CPI)
- Player stats and progression
- Current layer and run state
- Milestone tracking

**Key Functions:**
```gdscript
GameState.start_new_run()
GameState.add_cpi(amount: int)
GameState.enemy_defeated(enemy_type: String, cpi_gain: int)
GameState.advance_layer()
```

### 2. SaveSystem (Autoload)

**Location:** `scripts/core/save_system.gd`

Handles persistent data storage:
- Saves CPI, unlocks, and meta-progression
- Auto-saves on run end
- Loads on game start

**Key Functions:**
```gdscript
SaveSystem.save_game()
SaveSystem.load_game()
SaveSystem.has_save() -> bool
```

### 3. EventBus (Autoload)

**Location:** `scripts/core/event_bus.gd`

Global event system for decoupled communication:
```gdscript
EventBus.emit_signal("player_hit", damage, attacker)
EventBus.emit_signal("enemy_killed", enemy)
EventBus.emit_signal("show_notification", title, message)
```

## Implementing Game Systems

### Adding a New Weapon

1. Add weapon data to `scripts/weapons/weapon_definitions.gd`:
```gdscript
"new_weapon": {
    "name": "Cool Sword",
    "type": WeaponBase.WeaponType.BALANCED,
    "base_damage": 30.0,
    "attack_speed": 1.0,
    "range": 55.0,
    "description": "A really cool sword"
}
```

2. Create weapon scene (extends `weapon_base.gd`)
3. Assign to player or make available in hub

### Adding a New Enemy

1. Add enemy data to `scripts/enemies/enemy_definitions.gd`
2. Create enemy scene extending `enemy_base.gd`
3. Add to layer spawn pools in `layer_config.gd`
4. Implement special abilities if needed

### Creating a New Layer

1. Add layer configuration to `scripts/level/layer_config.gd`:
```gdscript
5: {
    "name": "New Layer Name",
    "description": "Layer description",
    "enemies": ["enemy1", "enemy2"],
    "warden": "warden_id",
    "hazards": ["hazard1"]
}
```

2. Create room scenes for the layer
3. Design unique visuals and hazards

## Testing

### Quick Test Checklist

- [ ] Player movement (walk, run, jump, dodge)
- [ ] Combat (attack, block, damage)
- [ ] Enemy AI (chase, attack, death)
- [ ] CPI increases on enemy kills
- [ ] CPI scaling affects enemy stats
- [ ] Save/load works correctly
- [ ] Milestone rewards trigger
- [ ] Death returns to hub with CPI increase

### Debug Commands

Add debug shortcuts in player controller or GameState:
```gdscript
# Example debug inputs (add to _input() function)
if Input.is_action_just_pressed("ui_page_up"):
    GameState.add_cpi(10)  # Add 10 CPI for testing

if Input.is_action_just_pressed("ui_page_down"):
    GameState.player_health = GameState.player_max_health  # Full heal
```

## Building for Steam

### Export Process

1. **Install Export Templates**
   - In Godot: Editor → Manage Export Templates → Download and Install

2. **Configure Export**
   - Project → Export
   - Select "Windows Desktop" preset (already configured in `export_presets.cfg`)
   - Set export path: `./builds/CastleEidolon.exe`

3. **Export Project**
   - Click "Export Project"
   - Choose "Release" build for final distribution

4. **Test the .exe**
   - Run the exported executable
   - Verify all features work outside the editor

### Steam Integration (Future)

To add Steam features (achievements, cloud saves, leaderboards):

1. Install **GodotSteam** plugin: https://godotsteam.com/
2. Register app on Steamworks
3. Implement Steam API calls for achievements
4. Test with Steamworks SDK

## Next Steps for Development

### Immediate Priorities

1. **Art Assets**
   - Player sprite sheets (idle, walk, run, jump, attack, dodge, block)
   - Enemy sprites for all enemy types
   - Tileset for castle layers
   - UI elements and icons

2. **Animation**
   - Create AnimatedSprite2D frames for player
   - Enemy attack animations
   - VFX for attacks and abilities

3. **Audio**
   - Background music per layer
   - Combat sound effects
   - UI sounds
   - Ambient castle audio

4. **Level Design**
   - Design room layouts for each layer
   - Implement procedural generation (optional)
   - Create boss arenas for Wardens

### Advanced Features

- [ ] Sigil system implementation
- [ ] Grimoire/lore system
- [ ] NPC dialogue system
- [ ] Shop/merchant UI
- [ ] Weapon upgrade UI
- [ ] Challenge rooms
- [ ] Additional layers (5+)
- [ ] More enemy types
- [ ] More weapon types
- [ ] Particle effects and polish
- [ ] Controller support
- [ ] Steam achievements

## Troubleshooting

### Common Issues

**Problem:** Autoloads not found
- **Solution:** Go to Project → Project Settings → Autoload and verify paths

**Problem:** Player not responding to input
- **Solution:** Check Input Map in Project Settings → Input Map

**Problem:** Scenes not loading
- **Solution:** Verify scene paths use `res://` prefix

**Problem:** Save file not persisting
- **Solution:** Check file path (should be `user://` for cross-platform compatibility)

## Contributing

When making changes:

1. Test thoroughly in the editor
2. Check for errors in Output console
3. Verify save/load still works
4. Export and test .exe build
5. Document new systems in this file

## Resources

- **Godot Documentation:** https://docs.godotengine.org/
- **GDScript Reference:** https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/
- **Godot Community:** https://godotengine.org/community

---

**Good luck conquering the Eidolon!**
