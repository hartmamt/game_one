# Castle Eidolon - Quick Start Guide

## Get Playing in 5 Minutes!

### Step 1: Install Godot
1. Download **Godot 4.3** from https://godotengine.org/download
2. Download the "Standard" version (not .NET unless you want C# support)
3. Extract and run `Godot_v4.3_win64.exe` (or your OS version)

### Step 2: Open the Project
1. Launch Godot
2. Click **"Import"**
3. Navigate to this folder and select `project.godot`
4. Click **"Import & Edit"**

### Step 3: Play the Game!
Press **F5** or click the **Play button** in the top-right corner!

## What You'll See

The game will open with placeholder stick figure sprites:
- **Blue stick figure** = Your player
- **Red stick figures** = Enemies
- **Purple shapes** = NPCs

It's intentionally simple so you can test the gameplay mechanics!

## Controls

| Action | Keys |
|--------|------|
| **Move** | A/D or Arrow Keys |
| **Jump** | Space or W |
| **Dodge Roll** | Shift |
| **Attack** | Left Mouse Button |
| **Block** | Right Mouse Button |
| **Interact** | E |

## Testing the CPI System

1. **Start from Main Menu** - You'll see "Castle Eidolon" screen
2. **Click "START NEW RUN"** - Begins at Layer 1, CPI starts at 0
3. **Move around** - Test the platforming
4. **Kill enemies** - Watch CPI increase in the top-left
5. **Try to survive!** - CPI makes enemies harder over time
6. **Die** - You'll respawn at hub with HIGHER CPI
7. **Repeat** - Each run gets progressively harder!

## Testing Scenes

Godot has multiple test scenes you can try:

### Main Menu (Default)
- Scene: `scenes/main_menu.tscn`
- Full game experience with save/load

### Test Level (Quick Combat Test)
- Scene: `scenes/test_level.tscn`
- Jump straight into action
- To run: Select scene in FileSystem → Press F6

### Hub (NPC Testing)
- Scene: `scenes/hub.tscn`
- Test NPC interactions
- To run: Select scene → Press F6

## Understanding the HUD

**Top-Left Corner:**
- **Green Bar** = Your health
- **Colored Progress Bar** = Castle Pressure Index (CPI)
  - Green = Low threat
  - Yellow = Moderate
  - Orange = High
  - Red = Extreme
  - Purple = OVERWHELMING

**Top-Center:**
- Current Layer number

## What to Test

### Movement & Combat
- ✅ Smooth walking/running
- ✅ Jump height and feel
- ✅ Dodge roll with invincibility frames
- ✅ Attack animations
- ✅ Blocking reduces damage

### CPI System
- ✅ Kill enemies → CPI increases
- ✅ Die → CPI increases more
- ✅ Enemies get tougher with higher CPI
- ✅ Check the stats: Open `scripts/core/game_state.gd` to see CPI scaling

### Save System
- ✅ Die or exit game
- ✅ Restart Godot
- ✅ Click "CONTINUE" on main menu
- ✅ CPI should be saved!

## Common Issues

### "Can't find script/scene"
- Make sure all files were extracted
- Try: Project → Reload Current Project

### Player falls through floor
- Physics might need a frame to initialize
- Try restarting the scene (F5 again)

### No sprites visible
- Godot is importing SVG files
- Wait a few seconds after first opening project
- Check bottom panel for import progress

### Controls not working
- Click the game window to focus it
- Check Project → Project Settings → Input Map

## Next Steps

Once you've tested with placeholder graphics:

1. **Add Real Art** - Replace SVGs in `assets/sprites/placeholder/`
2. **Design Levels** - Create new scenes with platforms and enemies
3. **Add Sounds** - Drop audio files in `assets/audio/`
4. **Export Game** - Project → Export → Windows Desktop

## Viewing the Code

All game logic is in `scripts/` folder:
- `scripts/core/game_state.gd` - CPI system
- `scripts/player/player_controller.gd` - Player movement
- `scripts/enemies/enemy_base.gd` - Enemy AI

Open any `.gd` file to see how it works!

## Questions?

Check the documentation:
- `README.md` - Project overview
- `GAME_DESIGN.md` - Full game design specs
- `DEVELOPMENT.md` - Detailed dev guide

---

**Have fun conquering the Eidolon!** 🏰⚔️
