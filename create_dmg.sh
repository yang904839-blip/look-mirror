#!/bin/bash

APP_NAME="LookMirror"
VERSION="1.0"
DMG_NAME="${APP_NAME}-${VERSION}.dmg"
VOLUME_NAME="${APP_NAME}"

echo "Creating DMG installer for ${APP_NAME}..."

# Build the app first
echo "Building app..."
./bundle_app.sh

if [ ! -d "${APP_NAME}.app" ]; then
    echo "Error: ${APP_NAME}.app not found"
    exit 1
fi

# Create temporary directory
TMP_DIR=$(mktemp -d)
echo "Using temporary directory: ${TMP_DIR}"

# Copy app to temp directory
cp -R "${APP_NAME}.app" "${TMP_DIR}/"

# Create Applications symlink
ln -s /Applications "${TMP_DIR}/Applications"

# Create DMG
echo "Creating DMG..."
hdiutil create -volname "${VOLUME_NAME}" \
    -srcfolder "${TMP_DIR}" \
    -ov -format UDZO \
    "${DMG_NAME}"

# Clean up
rm -rf "${TMP_DIR}"

if [ -f "${DMG_NAME}" ]; then
    echo "✅ DMG created successfully: ${DMG_NAME}"
    echo "Size: $(du -h ${DMG_NAME} | cut -f1)"
else
    echo "❌ Failed to create DMG"
    exit 1
fi
