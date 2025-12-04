#!/bin/bash

APP_NAME="LookMirror"
APP_PATH="$APP_NAME.app"

echo "Starting development watch mode for $APP_NAME..."

# Function to build and run
build_and_run() {
    echo "Changes detected. Rebuilding..."
    
    # Kill existing instance
    pkill -f "$APP_NAME"
    
    # Build
    swift build -c release
    if [ $? -eq 0 ]; then
        echo "Build successful. Bundling..."
        ./bundle_app.sh
        
        echo "Launching..."
        open "$APP_PATH"
    else
        echo "Build failed."
    fi
}

# Initial run
build_and_run

# Watch for changes in Sources directory
# Using fswatch if available, otherwise simple loop or just manual trigger
if command -v fswatch >/dev/null 2>&1; then
    fswatch -o Sources/ | while read f; do build_and_run; done
else
    echo "fswatch not found. Installing fswatch is recommended for auto-reload."
    echo "Running in manual mode. Press Enter to rebuild."
    while true; do
        read -p "Press Enter to rebuild..."
        build_and_run
    done
fi
