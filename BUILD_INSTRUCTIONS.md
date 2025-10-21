# How to Build Castle Eidolon .exe

## Method 1: One-Click Build Script (Recommended)

### Windows Users:

1. **Download Godot 4.3** (one time only)
   - Go to: https://godotengine.org/download
   - Download "Windows 64-bit" (Standard version)
   - Save to your Downloads folder (or anywhere)

2. **Double-click `build_windows.bat`** in this folder
   - The script will find Godot automatically
   - It builds the .exe for you
   - Done! Your .exe is in `builds/CastleEidolon.exe`

### Mac/Linux Users:

1. Download Godot 4.3 for your system
2. Run: `bash build_windows.sh`

---

## Method 2: Manual Build in Godot

If the script doesn't work:

### Step 1: Download Export Templates (One Time Setup)

1. Open Godot
2. Click **"Import"** and open `project.godot`
3. Go to: **Editor → Manage Export Templates**
4. Click **"Download and Install"**
5. Wait for download to complete

### Step 2: Export the Game

1. In Godot, go to: **Project → Export**
2. Click **"Export Project"** (don't change any settings)
3. Name your file: `CastleEidolon.exe`
4. Choose where to save it
5. Click **"Save"**

**Done!** You now have a standalone `.exe` file.

---

## Method 3: GitHub Actions Auto-Build (Advanced)

Want the .exe built automatically on every commit?

### Setup (One Time):

1. Go to your GitHub repo
2. Click **"Actions"** tab
3. Click **"Set up a workflow yourself"**
4. Paste this workflow (I can create this if you want)
5. Commit - it auto-builds on every push!

The .exe will appear in "Releases" or "Actions" artifacts.

---

## Troubleshooting

### "Godot not found"
- Make sure you downloaded Godot 4.3
- Edit `build_windows.bat` line 9 to point to your Godot.exe location

### "Export template not found"
- In Godot: Editor → Manage Export Templates → Download and Install
- Restart Godot after installing

### "Missing dependencies"
- Make sure you have .NET Framework 4.7+ installed (Windows)
- Or just download the "Standard" version of Godot (not .NET)

---

## What Gets Created

After building, you'll have:

```
builds/
└── CastleEidolon.exe    ← This is your game!
```

**This .exe file:**
- ✅ Runs without Godot installed
- ✅ Can be shared with anyone
- ✅ Can be uploaded to Steam
- ✅ Is 50-100 MB in size

Just share the entire `builds/` folder or zip it up!

---

## Fast Track Summary

**Absolute fastest way:**

1. Download this: https://godotengine.org/download (click "Windows 64-bit")
2. Double-click: `build_windows.bat`
3. Play: `builds/CastleEidolon.exe`

Takes 2 minutes total! ⚡
