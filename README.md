# Castle Eidolon

A brutal Metroidvania roguelike with permanent difficulty escalation.

## Game Overview

You are an eternal challenger in Eidolon Castle, a living fortress corrupted by ancient magic. The castle adapts relentlessly to your presence through the mysterious **Castle Pressure Index (CPI)** — a measure of how much your power and progress threaten its dominion.

## Key Features

- **No Checkpoints**: Death returns you to the castle entrance
- **Castle Pressure Index (CPI)**: Permanent difficulty scaling that never resets
- **5 Weapon Types**: Light, Balanced, Heavy, Ranged, and Hybrid weapons
- **Deep Progression**: Weapon upgrades, Sigils, Grimoire knowledge
- **Adaptive Enemies**: AI evolves based on CPI level
- **Hub NPCs**: Blacksmith, Archivist, Merchant, and Warden's Spirit
- **Milestone Rewards**: Unlock permanent upgrades at CPI thresholds

## Controls

- **WASD / Arrow Keys**: Move
- **Space**: Jump
- **Shift**: Dodge/Roll
- **Left Click**: Attack
- **Right Click**: Block
- **E**: Interact

## Development

Built with Godot 4.3

### Project Structure

```
castle_eidolon/
├── scenes/          # Game scenes (levels, UI, entities)
├── scripts/         # GDScript code
│   ├── core/        # Core systems (CPI, SaveSystem, GameState)
│   ├── player/      # Player controller and abilities
│   ├── enemies/     # Enemy AI and behaviors
│   ├── weapons/     # Weapon system
│   └── ui/          # UI components
├── assets/          # Art, audio, and data
└── data/            # JSON configs for weapons, enemies, etc.
```

## Building & Deployment

### Build for Web (Browser-based)

The game can be played directly in web browsers! **Recommended for easy distribution.**

```bash
# Build web version
./build_web.sh

# Test locally
./serve_web.sh
# Then open http://localhost:8000
```

**Deploy to:**
- GitHub Pages (free)
- Netlify (free)
- itch.io (game platform)
- Your own server

See [WEB_DEPLOYMENT.md](WEB_DEPLOYMENT.md) for detailed deployment guide.

### Build for Windows (Desktop)

Export as Windows .exe using provided build scripts:

```bash
# Windows
build_windows.bat

# Linux/Mac
./build_windows.sh
```

Or manually via Godot:
1. Project → Export
2. Add Windows Desktop preset
3. Export Project
4. Upload to Steam/itch.io

### Build for Other Platforms

Godot supports exporting to:
- Linux
- macOS
- Android
- iOS

Configure export presets in Godot Editor.

## License

All rights reserved.
