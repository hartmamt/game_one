# Placeholder Sprite Assets

These are **simple placeholder sprites** for testing Castle Eidolon gameplay.

## What's Included

### Player Sprites
- `player_idle.svg` - Blue stick figure standing
- `player_walk.svg` - Walking animation frame
- `player_attack.svg` - Attacking with sword

### Enemy Sprites
- `enemy_basic.svg` - Red stick figure (basic enemy)
- `enemy_heavy.svg` - Gray armored rectangle (Iron Guard)
- `enemy_ghost.svg` - Purple glowing ghost (Crypt Shade)

### NPC Sprites
- `npc_blacksmith.svg` - Brown figure with hammer
- `npc_merchant.svg` - Purple robed figure with money bag

### Environment
- `ground_tile.svg` - Stone floor tile
- `wall_tile.svg` - Castle wall brick tile

## Usage in Godot

These SVG files can be directly imported into Godot:

1. Drag and drop into the scene editor
2. Godot will automatically convert to texture
3. Assign to Sprite2D or AnimatedSprite2D nodes

## Replacing with Real Art

When you have real sprite sheets:

1. Export your sprites as PNG files
2. Place them in `assets/sprites/`
3. Update the texture references in scene files (`.tscn`)
4. Configure import settings for pixel art if needed:
   - Select sprite in FileSystem
   - Go to Import tab
   - Set Filter to "Nearest" for pixel art style
   - Click "Reimport"

## Animation Setup

For proper animations, create sprite sheets with multiple frames:

### Player Animation Frames Needed:
- **Idle**: 4-6 frames
- **Walk**: 6-8 frames
- **Run**: 6-8 frames
- **Jump**: 3-4 frames (jump, midair, land)
- **Attack**: 4-6 frames
- **Dodge**: 4-5 frames
- **Block**: 2-3 frames

Then use Godot's `AnimatedSprite2D` node:
1. Create SpriteFrames resource
2. Add animation names (idle, walk, run, etc.)
3. Add frames to each animation
4. Set FPS for each animation

## Current Limitations

These placeholders are:
- ✅ Functional for testing movement and gameplay
- ✅ Visually distinct (player vs enemies)
- ✅ Simple and clear
- ❌ Not animated (single frame per action)
- ❌ No visual effects or polish
- ❌ Minimal color variety

They're perfect for prototyping and testing the CPI system, combat, and level design before final art is ready!
