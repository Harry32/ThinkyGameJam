#!/usr/bin/env bash

set -e

echo "Dealing with templates"

mkdir /build
mkdir -p /github/home/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}
wget -q https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz
unzip -q Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz
mv templates/*  /github/home/.local/share/godot/export_templates/${GODOT_VERSION}.${RELEASE_NAME}
rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip

echo "Starting Building"
/usr/local/bin/godot --headless --path /game -q --export-release Web /build/index.html

echo "Zipping and Pushing"
cd /build
zip -r build.zip .
/opt/butler/bin/butler push build.zip harry32/tgjgravgame:html5