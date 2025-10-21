#!/bin/bash

# Castle Eidolon - Web Build Script
# Exports the Godot project to HTML5/WebAssembly for web browsers

set -e  # Exit on error

echo "==================================="
echo "Castle Eidolon - Web Build Script"
echo "==================================="
echo ""

# Find Godot executable
GODOT=""

# Check common locations
if command -v godot &> /dev/null; then
    GODOT="godot"
    echo "Found Godot in PATH"
elif command -v godot4 &> /dev/null; then
    GODOT="godot4"
    echo "Found Godot 4 in PATH"
elif [ -f "/usr/local/bin/godot" ]; then
    GODOT="/usr/local/bin/godot"
    echo "Found Godot at /usr/local/bin/godot"
elif [ -f "/usr/bin/godot" ]; then
    GODOT="/usr/bin/godot"
    echo "Found Godot at /usr/bin/godot"
elif [ -f "$HOME/.local/bin/godot" ]; then
    GODOT="$HOME/.local/bin/godot"
    echo "Found Godot at $HOME/.local/bin/godot"
else
    echo "ERROR: Godot not found!"
    echo "Please install Godot 4.3 or later and make sure it's in your PATH"
    echo "Or set GODOT environment variable to the Godot executable path"
    exit 1
fi

# Verify Godot version
echo ""
echo "Checking Godot version..."
$GODOT --version

# Create builds directory if it doesn't exist
echo ""
echo "Creating builds directory..."
mkdir -p builds/web

# Export for Web
echo ""
echo "Exporting to Web (HTML5/WebAssembly)..."
echo "This may take a minute..."

$GODOT --headless --export-release "Web" builds/web/index.html

# Check if export was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "==================================="
    echo "✓ Web build complete!"
    echo "==================================="
    echo ""
    echo "Output location: builds/web/"
    echo ""
    echo "To test locally:"
    echo "  1. cd builds/web"
    echo "  2. python3 -m http.server 8000"
    echo "  3. Open http://localhost:8000 in your browser"
    echo ""
    echo "Or use the provided server script:"
    echo "  ./serve_web.sh"
    echo ""

    # List generated files
    echo "Generated files:"
    ls -lh builds/web/
else
    echo ""
    echo "==================================="
    echo "✗ Web build FAILED!"
    echo "==================================="
    echo ""
    echo "Common issues:"
    echo "  1. Missing export templates (download from Godot Editor)"
    echo "  2. Godot version mismatch"
    echo "  3. Invalid export preset configuration"
    echo ""
    exit 1
fi
