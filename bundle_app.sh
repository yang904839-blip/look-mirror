#!/bin/bash

# Build the project
swift build -c release

# Create App Bundle structure
mkdir -p LookMirror.app/Contents/MacOS
mkdir -p LookMirror.app/Contents/Resources

# Copy executable
cp .build/release/LookMirror LookMirror.app/Contents/MacOS/

# Copy Info.plist
cp Info.plist LookMirror.app/Contents/

echo "LookMirror.app created successfully."
