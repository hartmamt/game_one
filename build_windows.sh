#!/bin/bash
# Auto-build Castle Eidolon to Windows .exe

echo "=========================================="
echo "Castle Eidolon - Windows Build Script"
echo "=========================================="
echo ""

# Check if Godot is installed
if ! command -v godot &> /dev/null; then
    echo "ERROR: Godot not found!"
    echo ""
    echo "Please download Godot 4.3 from: https://godotengine.org/download"
    echo "Then either:"
    echo "  1. Add Godot to your PATH, or"
    echo "  2. Run: /path/to/Godot_v4.3_win64.exe --headless --export-release \"Windows Desktop\" builds/CastleEidolon.exe"
    exit 1
fi

echo "Building Windows .exe..."
echo ""

# Create builds directory
mkdir -p builds

# Export the project
godot --headless --export-release "Windows Desktop" builds/CastleEidolon.exe

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ BUILD SUCCESSFUL!"
    echo "=========================================="
    echo ""
    echo "Your .exe is ready at: builds/CastleEidolon.exe"
    echo ""
    echo "You can now:"
    echo "  - Double-click CastleEidolon.exe to play"
    echo "  - Share the builds/ folder with others"
    echo "  - Upload to Steam"
else
    echo ""
    echo "❌ BUILD FAILED"
    echo "Make sure export templates are installed:"
    echo "  Editor → Manage Export Templates → Download"
fi
