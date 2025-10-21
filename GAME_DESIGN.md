# Castle Eidolon — Complete Game Design Document

## Table of Contents
1. [Setting & Lore](#setting--lore)
2. [Castle Structure & Progression](#castle-structure--progression)
3. [Castle Pressure Index (CPI)](#castle-pressure-index-cpi)
4. [Movement & Core Actions](#movement--core-actions)
5. [Weapons & Combat](#weapons--combat)
6. [Enemies & AI](#enemies--ai)
7. [NPCs in Hub](#npcs-in-hub)
8. [Reward System](#reward-system)
9. [Gameplay Loop](#gameplay-loop)
10. [UI & Visual Feedback](#ui--visual-feedback)

## Setting & Lore

You are an eternal challenger in **Eidolon Castle**, a living fortress corrupted by ancient magic. The castle adapts relentlessly to your presence through the mysterious **Castle Pressure Index (CPI)** — a measure of how much your power and progress threaten its dominion.

- Legends say the castle was built to imprison a primordial force
- **Wardens**, corrupted guardians, seek to end intruders with brutal efficiency
- Your goal is to delve deeper through the castle's twisted **Layers**, defeat Wardens, and harness **Eidolon Cores** — sources of immense power

## Castle Structure & Progression

- The castle is divided into multiple **Layers**, each with distinct environments and escalating difficulty
- You start at **Layer 1** and descend deeper with every victory
- **No checkpoints** — death means you return to the castle entrance
- Each death or progress increases the **CPI**, permanently making the castle harder

## Castle Pressure Index (CPI)

The core mechanic that makes Castle Eidolon unique:

- **CPI never resets** and only increases
- **Influences:**
  - Enemy health, damage, and AI behavior
  - Environmental hazards and curses
  - Quality and rarity of loot
- **CPI creates constant pressure** — no easy runs, only mastery and adaptation

### CPI Scaling

- **Enemy Health:** +2% per CPI point
- **Enemy Damage:** +1.5% per CPI point
- **Enemy Speed:** +1% per CPI point
- **Loot Quality:** +3% per CPI point

### CPI Mutations (High CPI)

- **CPI 40+**: 30% chance for enemy regeneration
- **CPI 60+**: 25% chance for elemental attacks
- **CPI 80+**: 15% chance for Elite enemies (2x health, 1.5x damage)

## Movement & Core Actions

| Action | Description |
|--------|-------------|
| **Walking/Running** | Smooth side-scrolling movement |
| **Jumping** | Platforming over obstacles and gaps |
| **Rolling/Dodging** | Invulnerability frames to evade attacks |
| **Climbing Chains** | Vertical traversal for reaching new areas |
| **Shield Blocking** | Defensive stance (70% damage reduction, frontal only) |

## Weapons & Combat

### Weapon Types

| Type | Description | Visual & Style | Damage Mult | Speed Mult | Crit Chance |
|------|-------------|----------------|-------------|------------|-------------|
| **Light** | Fast, precise strikes; low damage | Daggers, rapiers | 0.7x | 1.5x | 25% |
| **Balanced** | Versatile and reliable | Longswords, broadswords | 1.0x | 1.0x | 15% |
| **Heavy** | Slow, powerful strikes; armor penetration | Warhammers, great axes | 1.8x | 0.5x | 10% |
| **Ranged** | Attack from distance | Bows, crossbows, magic staffs | 1.0x | 0.8x | 20% |
| **Hybrid** | Mix melee & magic/ranged | Enchanted blades, elemental gauntlets | 1.2x | 0.9x | 18% |

### Progression

- Weapon upgrading (max level 10)
- Reforging with boss parts
- **Sigils** for special effects
- **Grimoire** knowledge for passive buffs

## Enemies & AI

### Base Enemies (Layers 1-2)

| Enemy Name | Appearance | Behavior | Health | Damage | Speed |
|------------|------------|----------|--------|--------|-------|
| **Crypt Shade** | Ghostly, pale wraith | Fast, teleport short distances | 40 | 12 | 150 |
| **Iron Guard** | Rusted plate armor soldier | Slow, heavy attacks, shield blocks | 80 | 20 | 80 |
| **Arcane Familiar** | Glowing magic orb with wings | Ranged fire orbs, evasive | 30 | 15 | 120 |

### Mid-Layer Enemies (Layers 3-4)

| Enemy Name | Appearance | Behavior | Special Abilities |
|------------|------------|----------|-------------------|
| **Astral Sentinel** | Floating armor with runes | Teleports, magic blasts, shield phases | Teleport, Magic Blast, Shield Phase |
| **Mirror Wraith** | Reflective, shifting body | Pass through walls, reflect projectiles | Wall Phase, Projectile Reflect |
| **Iron Chapel Acolyte** | Robed priest with chains | Melee strikes with curses | Curse Debuff |

### Wardens (Bosses)

- **The Ironclad Warden** (Layer 1): Massive armored knight with flaming sword
- **The Astral Executioner** (Layer 3): Ethereal figure wielding twin blades

## NPCs in Hub

| NPC | Role | Services |
|-----|------|----------|
| **Blacksmith** | Weapon upgrades | Upgrade weapons, reforge with boss parts |
| **Archivist** | Lore & knowledge | Unlock grimoire entries, reveal enemy weaknesses |
| **Merchant** | Shop | Sell materials, blueprints (inventory scales with CPI) |
| **Warden's Spirit** | Quests | Provide hints, rare assistance |

## Reward System

### CPI Milestones

| CPI | Reward |
|-----|--------|
| 10 | 3 Weapon Upgrade Tokens |
| 25 | Additional Sigil Slot |
| 40 | Passive Skill Point |
| 60 | Unique Weapon: Eidolon's Grasp |
| 80 | Aerial Combo Technique |
| 100 | Major Eidolon Core (permanent boost) |
| 120+ | Cosmetics, titles, prestige |

### Additional Rewards

- **Challenge rooms** at higher CPI with rare rewards
- **Vendor inventory** improves with CPI
- **Eidolon Cores** for permanent meta upgrades
- **High-risk zones** with CPI multipliers

## Gameplay Loop

1. Start at **Layer 1**, CPI low
2. Progress by defeating enemies and Wardens
3. Acquire and upgrade weapons and Sigils
4. Face increasingly difficult enemies as CPI rises
5. **Die?** Restart at entrance, CPI higher
6. Unlock milestone rewards for power growth
7. **Repeat**, pushing your limits deeper into the castle

## UI & Visual Feedback

- **Layer indicator** (top center)
- **CPI meter** ("Castle Pulse") with color-coded threat level
  - **GREEN**: Low (CPI < 20)
  - **YELLOW**: Moderate (CPI 20-49)
  - **ORANGE**: High (CPI 50-79)
  - **RED**: Extreme (CPI 80-119)
  - **PURPLE**: Overwhelming (CPI 120+)
- **Alerts** for CPI milestones and enemy mutations
- **Loadout and upgrade screens** for weapons and Sigils

## Summary

**Castle Eidolon** is a brutal, relentless Metroidvania roguelike with:
- **No checkpoints**
- **Permanent difficulty escalation (CPI)**
- **Deep weapon and Sigil progression**
- **Immersive, adaptive castle environment** that fights back

The castle never forgets. The castle never forgives. The castle only grows stronger.

**Will you conquer the Eidolon?**
