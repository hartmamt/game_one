#!/bin/bash

# Castle Eidolon - Local Web Server
# Serves the game locally for testing

echo "==================================="
echo "Castle Eidolon - Local Web Server"
echo "==================================="
echo ""

# Check if builds/web exists
if [ ! -d "builds/web" ]; then
    echo "ERROR: builds/web directory not found!"
    echo ""
    echo "Please build the web version first:"
    echo "  ./build_web.sh"
    echo ""
    exit 1
fi

# Copy custom HTML and CSS if they exist
if [ -f "web/index.html" ] && [ -f "web/styles.css" ]; then
    echo "Copying custom web assets..."
    cp web/index.html builds/web/landing.html
    cp web/styles.css builds/web/styles.css
    echo "✓ Custom assets copied"
    echo ""
fi

# Determine which server to use
PORT=8000

if command -v python3 &> /dev/null; then
    echo "Starting Python HTTP server on port $PORT..."
    echo ""
    echo "===================================="
    echo "Game is now running at:"
    echo ""
    echo "  http://localhost:$PORT"
    echo ""
    echo "For custom page with game info:"
    echo "  http://localhost:$PORT/landing.html"
    echo ""
    echo "===================================="
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    cd builds/web && python3 -m http.server $PORT

elif command -v python &> /dev/null; then
    echo "Starting Python 2 HTTP server on port $PORT..."
    echo ""
    echo "===================================="
    echo "Game is now running at:"
    echo ""
    echo "  http://localhost:$PORT"
    echo ""
    echo "===================================="
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    cd builds/web && python -m SimpleHTTPServer $PORT

elif command -v php &> /dev/null; then
    echo "Starting PHP built-in server on port $PORT..."
    echo ""
    echo "===================================="
    echo "Game is now running at:"
    echo ""
    echo "  http://localhost:$PORT"
    echo ""
    echo "===================================="
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    cd builds/web && php -S localhost:$PORT

else
    echo "ERROR: No suitable web server found!"
    echo ""
    echo "Please install one of the following:"
    echo "  - Python 3 (recommended)"
    echo "  - Python 2"
    echo "  - PHP"
    echo ""
    echo "Or manually serve the builds/web directory with your preferred web server"
    exit 1
fi
